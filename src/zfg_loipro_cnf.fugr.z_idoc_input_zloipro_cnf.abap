FUNCTION z_idoc_input_zloipro_cnf.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(INPUT_METHOD) LIKE  BDWFAP_PAR-INPUTMETHD
*"     VALUE(MASS_PROCESSING) LIKE  BDWFAP_PAR-MASS_PROC
*"  EXPORTING
*"     VALUE(WORKFLOW_RESULT) LIKE  BDWF_PARAM-RESULT
*"     VALUE(APPLICATION_VARIABLE) LIKE  BDWF_PARAM-APPL_VAR
*"     VALUE(IN_UPDATE_TASK) LIKE  BDWFAP_PAR-UPDATETASK
*"     VALUE(CALL_TRANSACTION_DONE) LIKE  BDWFAP_PAR-CALLTRANS
*"  TABLES
*"      IDOC_CONTRL STRUCTURE  EDIDC
*"      IDOC_DATA STRUCTURE  EDIDD
*"      IDOC_STATUS STRUCTURE  BDIDOCSTAT
*"      RETURN_VARIABLES STRUCTURE  BDWFRETVAR
*"      SERIALIZATION_INFO STRUCTURE  BDI_SER
*"  EXCEPTIONS
*"      WRONG_FUNCTION_CALLED
*"----------------------------------------------------------------------

  DATA: ls_idoc_data   TYPE edidd,
        gs_conf        TYPE ze1confpp,             "your Z segment structure
        ls_conf_bapi   TYPE bapi_pp_timeticket,
        lt_conf_bapi   TYPE TABLE OF bapi_pp_timeticket,
        ls_return_bapi TYPE bapiret1,             "single return from BAPI
        lt_return_det  TYPE TABLE OF bapi_coru_return,
        ls_return_det  TYPE bapi_coru_return,
        lv_error       TYPE abap_bool VALUE abap_false,
        gs_status      TYPE bdidocstat.

  FIELD-SYMBOLS: <fs_sdata> TYPE any.

*--------------------------------------------------------------------*
* Loop through inbound data records and process ZE1CONFPP segments
*--------------------------------------------------------------------*
  LOOP AT idoc_data INTO ls_idoc_data WHERE segnam = 'ZE1CONFPP'.

* -- SDATA is LCHR (long char). You must convert it into your Z segment
*    structure (ze1confpp). There are different ways, depending on how the
*    IDoc was created:
*    A) If SDATA already contains an ABAP structure in binary form (rare):
*         ASSIGN ls_idoc_data-sdata TO <fs_sdata> CASTING TYPE ze1confpp.
*         IF sy-subrc = 0.
*           MOVE-CORRESPONDING <fs_sdata> TO gs_conf.
*         ENDIF.
*
*    B) If SDATA is a concatenation of fixed-length fields OR delimited text,
*       you need to parse with substring offsets or SPLIT. Replace the
*       "*** TODO: parse SDATA" block below with the correct parsing.
*
*    C) If you have a helper FM that maps sdata to structure, call it here
*       (for example: z_idoc_sdata_to_ze1confpp or a standard EDI FM).
*
* NOTE: The code below shows a placeholder parse approach that assumes
*       SDATA is a delimited string like "AUFNR|VORNR|LMNGA|XMNGA|MEINS|BUDAT|..."
*       — replace it with the real parsing required in your landscape.
*
    CLEAR gs_conf.

*** >>>>>  Replace this block with your parsing logic <<<<< ***
    " Example placeholder: if SDATA is pipe-delimited (AUFNR|VORNR|LMNGA...)
    DATA(lv_sdata) = ls_idoc_data-sdata.
    IF lv_sdata IS NOT INITIAL.
      DATA(lt_parts) = VALUE string_table( ).
      SPLIT lv_sdata AT '|' INTO TABLE lt_parts.
      IF lines( lt_parts ) >= 11.
        READ TABLE lt_parts INDEX 1 INTO gs_conf-aufnr.
        READ TABLE lt_parts INDEX 2 INTO gs_conf-vornr.
        READ TABLE lt_parts INDEX 3 INTO gs_conf-lmnga.
        READ TABLE lt_parts INDEX 4 INTO gs_conf-xmnga.
        READ TABLE lt_parts INDEX 5 INTO gs_conf-meins.
        READ TABLE lt_parts INDEX 6 INTO gs_conf-budat.
        READ TABLE lt_parts INDEX 7 INTO gs_conf-isdd.
        READ TABLE lt_parts INDEX 8 INTO gs_conf-iedd.
        READ TABLE lt_parts INDEX 9 INTO gs_conf-conf_text.
        READ TABLE lt_parts INDEX 10 INTO gs_conf-final_conf.
        READ TABLE lt_parts INDEX 11 INTO gs_conf-teco_flag.
      ENDIF.
    ENDIF.

    " If you have a helper FM that converts SDATA -> ZE1CONFPP, call it instead:
    " CALL FUNCTION 'Z_MAP_SD_TO_ZE1CONFPP'
    "   EXPORTING
    "     i_sdata = ls_idoc_data-sdata
    "   IMPORTING
    "     e_conf  = gs_conf
    "   EXCEPTIONS
    "     others  = 1.

*** End of parsing placeholder ****************************************

* Basic validation
    IF gs_conf-aufnr IS INITIAL OR gs_conf-vornr IS INITIAL.
      " Nothing to do — skip (and mark status if desired)
      CONTINUE.
    ENDIF.

*--------------------------------------------------------------------*
* Map IDoc fields → BAPI structure (BAPI_PP_TIMETICKET)
*--------------------------------------------------------------------*
    CLEAR ls_conf_bapi.
    ls_conf_bapi-orderid        = gs_conf-aufnr.              "AUFNR
    ls_conf_bapi-operation      = gs_conf-vornr.              "VORNR
    ls_conf_bapi-yield          = gs_conf-lmnga.              "LMNGA
    ls_conf_bapi-scrap          = gs_conf-xmnga.              "XMNGA
    ls_conf_bapi-conf_quan_unit = gs_conf-meins.              "MEINS
    ls_conf_bapi-postg_date     = gs_conf-budat.              "BUDAT
   "" ls_conf_bapi-exec_start_date= gs_conf-isdd.               "ISDD
    ls_conf_bapi-exec_fin_date  = gs_conf-iedd.               "IEDD
    ls_conf_bapi-conf_text      = gs_conf-conf_text.          "CONF_TEXT
    ls_conf_bapi-fin_conf       = gs_conf-final_conf.         "FINAL_CONF ('X' final)

    CLEAR lt_conf_bapi.
    APPEND ls_conf_bapi TO lt_conf_bapi.

*--------------------------------------------------------------------*
* Call BAPI to create confirmation (time tickets)
* BAPI signature:
*   IMPORTING return = bapiret1
*   TABLES    timetickets = bapi_pp_timeticket
*             detail_return = bapi_coru_return
*--------------------------------------------------------------------*
    CLEAR ls_return_bapi.
    CLEAR lt_return_det.

    CALL FUNCTION 'BAPI_PRODORDCONF_CREATE_TT'
      IMPORTING
        return        = ls_return_bapi
      TABLES
        timetickets   = lt_conf_bapi
        detail_return = lt_return_det.

    " Check return
    IF ls_return_bapi-type = 'E' OR ls_return_bapi-type = 'A'.
      lv_error = abap_true.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      " Add IDoc status error row for this Doc
      CLEAR gs_status.
      gs_status-docnum = idoc_contrl-docnum.
      gs_status-status = '51'.
      gs_status-msgty  = 'E'.
      gs_status-msgv1  = |Conf failed { gs_conf-aufnr } op { gs_conf-vornr }|.
      APPEND gs_status TO idoc_status.
      " Optionally log detail_return entries to system log / table
      CONTINUE. " process next segment
    ELSE.
      " Success: commit and continue
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = abap_true.
      " Add success status later after loop (aggregate), or log per-segment
    ENDIF.

*--------------------------------------------------------------------*
* Optionally TECO if TECO_FLAG = 'X' and no error for this item
*--------------------------------------------------------------------*
    IF gs_conf-teco_flag = 'X' AND lv_error = abap_false.
      CLEAR lt_return_det.
      CLEAR ls_return_bapi.

      CALL FUNCTION 'BAPI_PRODORD_COMPLETE_TECO'
        EXPORTING
          number = gs_conf-aufnr
        IMPORTING
          return = ls_return_bapi.   "single BAPIRET1 (some systems use table; check your version)

      IF ls_return_bapi-type = 'E' OR ls_return_bapi-type = 'A'.
        lv_error = abap_true.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        CLEAR gs_status.
        gs_status-docnum = idoc_contrl-docnum.
        gs_status-status = '51'.
        gs_status-msgty  = 'E'.
        gs_status-msgv1  = |TECO failed { gs_conf-aufnr }|.
        APPEND gs_status TO idoc_status.
      ELSE.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = abap_true.
        " success for TECO -> continue
      ENDIF.
    ENDIF.

  ENDLOOP. " idoc_data

*--------------------------------------------------------------------*
* Final IDoc status if none added inside loop
*--------------------------------------------------------------------*
  " If no specific status appended per-segment, append a success status
  IF idoc_status IS INITIAL.
    CLEAR gs_status.
    gs_status-docnum = idoc_contrl-docnum.
    gs_status-status = COND #( WHEN lv_error = abap_true THEN '51' ELSE '53' ).
    gs_status-msgty  = COND #( WHEN lv_error = abap_true THEN 'E' ELSE 'S' ).
    gs_status-msgv1  = COND #( WHEN lv_error = abap_true
                                THEN 'One or more confirmations failed'
                                ELSE 'All confirmations processed' ).
    APPEND gs_status TO idoc_status.
  ENDIF.



ENDFUNCTION.
