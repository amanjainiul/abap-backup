FUNCTION z_idoc_input_zqm_mes_qual.
*"----------------------------------------------------------------------
*"*"Global Interface:
*"  TABLES
*"      IDOC_CONTRL STRUCTURE  EDIDC
*"      IDOC_DATA   STRUCTURE  EDIDD
*"      IDOC_STATUS STRUCTURE  BDIDOCSTAT
*"----------------------------------------------------------------------

  DATA: ls_idoc_data TYPE edidd,
        gs_status    TYPE bdidocstat,
        lv_error     TYPE abap_bool VALUE abap_false.

  " Segment structures
  DATA: ls_hdr_seg TYPE ze1qm_hdr,
        ls_ud_seg  TYPE ze1qm_ud,
        ls_res_seg TYPE ze1qm_result.

  " BAPI structures
  DATA: ls_ud_bapi    TYPE bapi2045ud,
        ls_ud_return  TYPE bapi2045ud_return,
        ls_stock_data TYPE bapi2045d_il2,
        ls_bapi_ret   TYPE bapireturn1,
        lt_sysstat    TYPE TABLE OF bapi2045ss,
        lt_usrstat    TYPE TABLE OF bapi2045us,
        lt_bapiret    TYPE TABLE OF bapireturn1.

  DATA: ls_char_in     TYPE bapi2045d2.

*--------------------------------------------------------------------*
* Process each segment in IDoc
*--------------------------------------------------------------------*
  LOOP AT idoc_data INTO ls_idoc_data.

*--------------------------------------------------------------------*
* HEADER Segment
*--------------------------------------------------------------------*
    IF ls_idoc_data-segnam = 'ZE1QM_HDR'.
      CLEAR ls_hdr_seg.
      MOVE ls_idoc_data-sdata TO ls_hdr_seg.
      CONTINUE.
    ENDIF.

*--------------------------------------------------------------------*
* USAGE DECISION Segment
*--------------------------------------------------------------------*
    IF ls_idoc_data-segnam = 'ZE1QM_UD'.
      CLEAR ls_ud_seg.
      MOVE ls_idoc_data-sdata TO ls_ud_seg.

      CLEAR ls_ud_bapi.
      ls_ud_bapi-insplot              = ls_ud_seg-prueflos.
      ls_ud_bapi-ud_plant             = ls_hdr_seg-werks.
      ls_ud_bapi-ud_selected_set      = ls_ud_seg-verwmerkm.
      ls_ud_bapi-ud_code              = ls_ud_seg-entscheid.
      ls_ud_bapi-ud_text_line         = |UD from MES: { ls_ud_seg-verwmerkm }|.
      ls_ud_bapi-ud_recorded_by_user  = ls_ud_seg-bearbuser.
      ls_ud_bapi-ud_recorded_on_date  = ls_ud_seg-datum.
      ls_ud_bapi-ud_recorded_at_time  = ls_ud_seg-zeit.
      ls_ud_bapi-ud_force_completion  = 'X'.

      CLEAR: ls_ud_return, ls_stock_data, ls_bapi_ret, lt_sysstat, lt_usrstat, lt_bapiret.

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
          user_status    = lt_usrstat
        EXCEPTIONS
          OTHERS         = 1.

      IF sy-subrc <> 0 OR ls_bapi_ret-type = 'E'.
        lv_error = abap_true.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      ELSE.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
      ENDIF.
      CONTINUE.
    ENDIF.

*--------------------------------------------------------------------*
* RESULT Segment (Characteristic Results)
*--------------------------------------------------------------------*
    IF ls_idoc_data-segnam = 'ZE1QM_RESULT'.
      CLEAR ls_res_seg.
      MOVE ls_idoc_data-sdata TO ls_res_seg.

      CLEAR ls_char_in.
      ls_char_in-insplot     = ls_res_seg-prueflos.
      ls_char_in-inspoper    = ls_res_seg-vorglfnr.
      ls_char_in-inspchar    = ls_res_seg-merknr.
      ls_char_in-mean_value  = ls_res_seg-istwert.
      ls_char_in-evaluation  = ls_res_seg-bewertung.
      ls_char_in-inspector   = ls_res_seg-pruefer.
      ls_char_in-remark      = ls_res_seg-kurztext.
      ls_char_in-end_date    = sy-datum.
      ls_char_in-end_time    = sy-uzeit.

      CLEAR: ls_bapi_ret, lt_bapiret.

      CALL FUNCTION 'BAPI_INSPCHAR_SETRESULT'
        EXPORTING
          insplot     = ls_char_in-insplot
          inspoper    = ls_char_in-inspoper
          inspchar    = ls_char_in-inspchar
          inspsample  = '1'
          char_result = ls_char_in
        IMPORTING
          return      = ls_bapi_ret
        EXCEPTIONS
          OTHERS      = 1.

      IF sy-subrc <> 0 OR ls_bapi_ret-type = 'E'.
        lv_error = abap_true.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      ELSE.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
      ENDIF.

      CONTINUE.
    ENDIF.

  ENDLOOP.

*--------------------------------------------------------------------*
* IDoc Status Update
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
    gs_status-msgv1  = 'QM inbound iDoc processed successfully'.
  ENDIF.

  APPEND gs_status TO idoc_status.

ENDFUNCTION.
