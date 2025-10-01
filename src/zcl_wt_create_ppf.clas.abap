class ZCL_WT_CREATE_PPF definition
  public
  final
  create public .

public section.

  interfaces IF_EX_EXEC_METHODCALL_PPF .
protected section.
private section.
ENDCLASS.



CLASS ZCL_WT_CREATE_PPF IMPLEMENTATION.


METHOD if_ex_exec_methodcall_ppf~execute.

  DATA: lo_who_ppf    TYPE REF TO /scwm/cl_wo_ppf,
        lv_who        TYPE /scwm/de_who,
        lv_lgnum      TYPE /scwm/lgnum,
        lr_who        TYPE rseloption,
        ls_who_sel    LIKE LINE OF lr_who,
        lt_wt         TYPE /scwm/tt_ordim_o,
        ls_wt         TYPE /scwm/ordim_o,
        ls_t327a      TYPE /scwm/t327a,
        lo_http       TYPE REF TO if_http_client,
        lv_uri        TYPE string,
        lv_response   TYPE string,
        lv_status     TYPE i,
        lv_reason     TYPE string,
        ls_log        TYPE bal_s_log,
        lv_log_handle TYPE balloghndl,
        ls_msg        TYPE bal_s_msg,
        lv_hdr_id     TYPE numc10,
        ls_hdr        TYPE zodata_hdr,
        ls_kv         TYPE zodata_kv,
        lv_seqno      TYPE numc7,
        lt_cfg        TYPE TABLE OF zodata_keys_cfg,
        " helper vars for regex extraction
        lv_val        TYPE string,
        lv_regex      TYPE string.

  "---------------------------------------------------------
  " Skip preview
  "---------------------------------------------------------
  CHECK ip_preview IS INITIAL.

  "---------------------------------------------------------
  " Cast application object
  "---------------------------------------------------------
  TRY.
      lo_who_ppf ?= io_appl_object.
    CATCH cx_sy_move_cast_error.
      rp_status = sppf_status_error.
      RETURN.
  ENDTRY.

  "---------------------------------------------------------
  " Get LGNUM and WHO
  "---------------------------------------------------------
  lv_lgnum = lo_who_ppf->get_lgnum( ).
  lv_who   = lo_who_ppf->get_who( ).

  IF lv_lgnum IS INITIAL OR lv_who IS INITIAL.
    RETURN.
  ENDIF.

  "---------------------------------------------------------
  " Create application log (SLG1)
  "---------------------------------------------------------
  CLEAR ls_log.
  ls_log-object    = 'ZPPF_LOG'.   " Must exist in SLG0
  ls_log-subobject = 'WHO_PPF'.
  ls_log-extnumber = lv_who.

  CALL FUNCTION 'BAL_LOG_CREATE'
    EXPORTING
      i_s_log      = ls_log
    IMPORTING
      e_log_handle = lv_log_handle
    EXCEPTIONS
      OTHERS       = 1.

  "---------------------------------------------------------
  " Build select-option for WHO
  "---------------------------------------------------------
  CLEAR ls_who_sel.
  ls_who_sel-sign   = 'I'.
  ls_who_sel-option = 'EQ'.
  ls_who_sel-low    = lv_who.
  APPEND ls_who_sel TO lr_who.

  "---------------------------------------------------------
  " Read open WTs for WO
  "---------------------------------------------------------
  CALL FUNCTION '/SCWM/TO_READ_MULT'
    EXPORTING
      iv_lgnum   = lv_lgnum
      ir_who     = lr_who
    IMPORTING
      et_ordim_o = lt_wt
    EXCEPTIONS
      OTHERS     = 1.

  IF sy-subrc <> 0 OR lt_wt IS INITIAL.
    RETURN.
  ENDIF.

  READ TABLE lt_wt INDEX 1 INTO ls_wt.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  "---------------------------------------------------------
  " Check customizing table /SCWM/T327A
  "---------------------------------------------------------
  SELECT SINGLE * FROM /scwm/t327a
    INTO ls_t327a
    WHERE lgnum  = lv_lgnum
      AND vltyp  = ls_wt-vltyp
      AND nltyp  = ls_wt-nltyp
      AND procty = ls_wt-procty.

  IF sy-subrc <> 0.
    RETURN. " No customizing match
  ENDIF.

  "---------------------------------------------------------
  " Build OData URI (case sensitive!)
  "---------------------------------------------------------
  lv_uri = |Z_EWM_WHO_PROCESS_SRV/WarehouseOrderSet(Lgnum='{ lv_lgnum }',Who='{ lv_who }')|.

  "---------------------------------------------------------
  " HTTP Call via SM59 (ZGW_LOOPBACK)
  "---------------------------------------------------------
  TRY.
      cl_http_client=>create_by_destination(
        EXPORTING destination = 'ZGW_LOOPBACK'
        IMPORTING client      = lo_http ).

      lo_http->request->set_method( if_http_request=>co_request_method_get ).
      lo_http->request->set_header_field( name = 'Accept' value = 'application/xml' ).
      lo_http->request->set_header_field( name = '~request_uri' value = lv_uri ).

      lo_http->send( ).
      lo_http->receive( ).

      lo_http->response->get_status(
        IMPORTING
          code   = lv_status
          reason = lv_reason ).

      lv_response = lo_http->response->get_cdata( ).
      lo_http->close( ).

      IF lv_status = 200.
        rp_status = sppf_status_processed.
      ELSE.
        rp_status = sppf_status_error.
      ENDIF.

    CATCH cx_root INTO DATA(lx_err).
      rp_status = sppf_status_error.
      IF lo_http IS BOUND.
        lo_http->close( ).
      ENDIF.
  ENDTRY.

  "---------------------------------------------------------
  " Persist OData payload into ZODATA_HDR + ZODATA_KV
  "---------------------------------------------------------
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01'
      object      = 'ZODATAHDR'
    IMPORTING
      number      = lv_hdr_id
    EXCEPTIONS
      OTHERS      = 1.

  ls_hdr-mandt     = sy-mandt.
  ls_hdr-hdr_id    = lv_hdr_id.
  ls_hdr-timestamp = sy-datum * 1000000 + sy-uzeit.
  ls_hdr-lgnum     = lv_lgnum.
  ls_hdr-who       = lv_who.
  ls_hdr-userid    = sy-uname.
  ls_hdr-action    = ip_action.
  ls_hdr-odata_srv = 'Z_EWM_WHO_PROCESS_SRV'.
  INSERT zodata_hdr FROM ls_hdr.

  DEFINE add_kv.
    ADD 1 TO lv_seqno.
    CLEAR ls_kv.
    ls_kv-mandt     = sy-mandt.
    ls_kv-hdr_id    = lv_hdr_id.
    ls_kv-seqno     = lv_seqno.
    ls_kv-key_name  = &1.
    ls_kv-key_value = &2.
    INSERT zodata_kv FROM ls_kv.
  END-OF-DEFINITION.

  "---------------------------------------------------------
  " Load config of active keys
  "---------------------------------------------------------
  SELECT *
    FROM zodata_keys_cfg
    INTO TABLE lt_cfg
    WHERE odata_srv = 'Z_EWM_WHO_PROCESS_SRV'
      AND action    = ip_action
      AND active    = 'X'.

  SORT lt_cfg BY log_key.

  "---------------------------------------------------------
  " Regex parse XML for active keys (safe approach)
  "---------------------------------------------------------
LOOP AT lt_cfg INTO DATA(ls_cfg).
  CLEAR: lv_val, lv_regex.

  " Build regex exactly in case-sensitive form
  CONCATENATE '<d:' ls_cfg-log_key '>([^<]*)</d:' ls_cfg-log_key '>'
         INTO lv_regex.

  FIND FIRST OCCURRENCE OF REGEX lv_regex
    IN lv_response
    SUBMATCHES lv_val.

  IF sy-subrc = 0 AND lv_val IS NOT INITIAL.
    add_kv ls_cfg-log_key lv_val.
  ENDIF.
ENDLOOP.


  TRY.
      " no explicit commit needed, PPF will handle it
      " if you want to be safe, call DB_COMMIT instead
      CALL FUNCTION 'DB_COMMIT'.
    CATCH cx_root INTO DATA(lx_final).
      " swallow any persistence errors silently
  ENDTRY.


ENDMETHOD.
ENDCLASS.
