FUNCTION z_idoc_input_zqm_mes_qual.
*"----------------------------------------------------------------------
*"*"Global Interface:
*"  IMPORTING
*"     VALUE(INPUT_METHOD) LIKE  BDWFAP_PAR-INPUTMETHD
*"     VALUE(MASS_PROCESSING) LIKE  BDWFAP_PAR-MASS_PROC
*"  EXPORTING
*"     VALUE(WORKFLOW_RESULT) LIKE  BDWFAP_PAR-RESULT
*"     VALUE(APPLICATION_VARIABLE) LIKE  BDWFAP_PAR-APPL_VAR
*"     VALUE(IN_UPDATE_TASK) LIKE  BDWFAP_PAR-UPDATETASK
*"     VALUE(CALL_TRANSACTION_DONE) LIKE  BDWFAP_PAR-CALLTRANS
*"     VALUE(DOCUMENT_NUMBER) LIKE  VBAK-VBELN
*"  TABLES
*"      IDOC_CONTRL STRUCTURE  EDIDC
*"      IDOC_DATA STRUCTURE  EDIDD
*"      IDOC_STATUS STRUCTURE  BDIDOCSTAT
*"      RETURN_VARIABLES STRUCTURE  BDWFRETVAR
*"      SERIALIZATION_INFO STRUCTURE  BDI_SER
*"      EDI_TEXT STRUCTURE  EDIORDTXT1 OPTIONAL
*"      EDI_TEXT_LINES STRUCTURE  EDIORDTXT2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: ls_idoc_data TYPE edidd,
        gs_status    TYPE bdidocstat,
        lv_error     TYPE abap_bool VALUE abap_false.

  DATA: ls_hdr_seg TYPE ze1qm_hdr,
        ls_ud_seg  TYPE ze1qm_ud,
        ls_res_seg TYPE ze1qm_result.

  DATA: ls_ud_bapi    TYPE bapi2045ud,
        ls_ud_return  TYPE bapi2045ud_return,
        ls_stock_data TYPE bapi2045d_il2,
        ls_bapi_ret   TYPE bapireturn1,
        lt_sysstat    TYPE TABLE OF bapi2045ss,
        lt_usrstat    TYPE TABLE OF bapi2045us,
        lt_bapiret    TYPE TABLE OF bapireturn1.

  DATA: ls_char_in TYPE bapi2045d2.

*--------------------------------------------------------------------*
* Process segments
*--------------------------------------------------------------------*
  LOOP AT idoc_data INTO ls_idoc_data.

*--------------------------------------------------------------------*
* Header Segment
*--------------------------------------------------------------------*
    IF ls_idoc_data-segnam = 'ZE1QM_HDR'.
      CLEAR ls_hdr_seg.
      MOVE ls_idoc_data-sdata TO ls_hdr_seg.
      CONTINUE.
    ENDIF.

*--------------------------------------------------------------------*
* Usage Decision Segment
*--------------------------------------------------------------------*
    IF ls_idoc_data-segnam = 'ZE1QM_UD'.

      CLEAR ls_ud_seg.
      MOVE ls_idoc_data-sdata TO ls_ud_seg.

      CLEAR ls_ud_bapi.
      ls_ud_bapi-insplot         = ls_ud_seg-prueflos.
      ls_ud_bapi-ud_plant        = ls_hdr_seg-werks.
      ls_ud_bapi-ud_selected_set = ls_ud_seg-verwmerkm.
      ls_ud_bapi-ud_code         = ls_ud_seg-entscheid.

      CONCATENATE 'UD from MES:' ls_ud_seg-verwmerkm
        INTO ls_ud_bapi-ud_text_line SEPARATED BY space.

      IF ls_ud_seg-bearbuser IS INITIAL.
        ls_ud_bapi-ud_recorded_by_user = sy-uname.
      ELSE.
        ls_ud_bapi-ud_recorded_by_user = ls_ud_seg-bearbuser.
      ENDIF.

      IF ls_ud_seg-datum IS INITIAL.
        ls_ud_bapi-ud_recorded_on_date = sy-datum.
      ELSE.
        ls_ud_bapi-ud_recorded_on_date = ls_ud_seg-datum.
      ENDIF.

      IF ls_ud_seg-zeit IS INITIAL.
        ls_ud_bapi-ud_recorded_at_time = sy-uzeit.
      ELSE.
        ls_ud_bapi-ud_recorded_at_time = ls_ud_seg-zeit.
      ENDIF.

      ls_ud_bapi-ud_force_completion = 'X'.

      CLEAR: ls_ud_return, ls_stock_data, ls_bapi_ret,
             lt_sysstat, lt_usrstat, lt_bapiret.

      CALL FUNCTION 'BAPI_INSPLOT_SETUSAGEDECISION'
        EXPORTING
          number         = ls_ud_bapi-insplot
          ud_data        = ls_ud_bapi
        IMPORTING
          ud_return_data = ls_ud_return
          stock_data     = ls_stock_data
          return         = ls_bapi_ret
        TABLES
          system_status  = lt_sysstat
          user_status    = lt_usrstat.

      IF sy-subrc <> 0 OR ls_bapi_ret-type = 'E'.
        lv_error = abap_true.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      ELSE.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
      ENDIF.

      CONTINUE.
    ENDIF.

*--------------------------------------------------------------------*
* (Future) Results Segment
*--------------------------------------------------------------------*
*    IF ls_idoc_data-segnam = 'ZE1QM_RESULT'.
*      "Your characteristic results logic here
*      CONTINUE.
*    ENDIF.

  ENDLOOP.

*--------------------------------------------------------------------*
* TECO Production Order if requested
*--------------------------------------------------------------------*
  IF ls_hdr_seg-status = 'TECO' AND ls_hdr_seg-aufnr IS NOT INITIAL.

    DATA: lt_orders        TYPE TABLE OF bapi_order_key,
          ls_order         TYPE bapi_order_key,
          lt_detail_return TYPE TABLE OF bapi_order_return,
          lt_app_log       TYPE TABLE OF bapi_order_application_log,
          ls_return        TYPE bapiret2.

    CLEAR: lt_orders, lt_detail_return, lt_app_log, ls_return.

    ls_order-order_number = ls_hdr_seg-aufnr.
    APPEND ls_order TO lt_orders.

    CALL FUNCTION 'BAPI_PS_INITIALIZATION'.

    CALL FUNCTION 'BAPI_PRODORD_COMPLETE_TECH'
      EXPORTING
        scope_compl_tech   = '1'
        work_process_group = 'COWORK_BAPI'
        work_process_max   = 99
      IMPORTING
        return             = ls_return
      TABLES
        orders             = lt_orders
        detail_return      = lt_detail_return
        application_log    = lt_app_log.

    IF sy-subrc <> 0 OR ls_return-type = 'E'.
      lv_error = abap_true.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
    ELSE.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
    ENDIF.

  ENDIF.

*--------------------------------------------------------------------*
* Update IDoc Status
*--------------------------------------------------------------------*
  CLEAR gs_status.
  gs_status-docnum = idoc_contrl-docnum.

  IF lv_error = abap_true.
    gs_status-status = '51'.
    gs_status-msgty  = 'E'.
    gs_status-msgv1  = 'Error during QM MES inbound processing'.
  ELSE.
    gs_status-status = '53'.
    gs_status-msgty  = 'S'.
    gs_status-msgv1  = 'QM UD AND/OR TECO processed successfully from MES'.
  ENDIF.

  APPEND gs_status TO idoc_status.

ENDFUNCTION.
