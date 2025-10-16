FUNCTION Z_IDOC_INPUT_ZLOIPRO_CNF.
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

 DATA: ls_idoc_data TYPE edidd,
        gs_conf      TYPE ze1confpp,
        ls_conf_bapi TYPE bapi_pp_timeticket,
        lt_conf_bapi TYPE TABLE OF bapi_pp_timeticket,
        lt_return    TYPE TABLE OF bapiret2,
        ls_return    TYPE bapiret2,
        lv_error     TYPE abap_bool VALUE abap_false,
        gs_status    TYPE bdidocstat.

  FIELD-SYMBOLS: <fs_sdata> TYPE ze1confpp.

*--------------------------------------------------------------------*
* Loop through all custom ZE1CONFPP segments
*--------------------------------------------------------------------*
  LOOP AT idoc_data INTO ls_idoc_data WHERE segnam = 'ZE1CONFPP'.

* Safely cast SDATA (LCHR) to structure
    ASSIGN ls_idoc_data-sdata TO <fs_sdata> CASTING.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.

    MOVE-CORRESPONDING <fs_sdata> TO gs_conf.

*--------------------------------------------------------------------*
* Map IDoc fields → BAPI structure
*--------------------------------------------------------------------*
    CLEAR ls_conf_bapi.

    ls_conf_bapi-orderid         = gs_conf-aufnr.
    ls_conf_bapi-operation       = gs_conf-vornr.
    ls_conf_bapi-yield           = gs_conf-lmnga.
    ls_conf_bapi-scrap           = gs_conf-xmnga.
    ls_conf_bapi-conf_quan_unit  = gs_conf-meins.
    ls_conf_bapi-postg_date      = gs_conf-budat.
    ls_conf_bapi-exec_start_date = gs_conf-isdd.
    ls_conf_bapi-exec_fin_date   = gs_conf-iedd.
    ls_conf_bapi-conf_text       = gs_conf-conf_text.
    ls_conf_bapi-fin_conf        = gs_conf-final_conf.   " 'X' = final conf

    APPEND ls_conf_bapi TO lt_conf_bapi.

*--------------------------------------------------------------------*
* Create confirmation
*--------------------------------------------------------------------*
    CALL FUNCTION 'BAPI_PRODORDCONF_CREATE_TT'
      TABLES
        timetickets = lt_conf_bapi
        return       = lt_return.

    READ TABLE lt_return INTO ls_return WITH KEY type = 'E'.
    IF sy-subrc = 0.
      lv_error = abap_true.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      WRITE: / '❌ Error for order', gs_conf-aufnr, ':', ls_return-message.
    ELSE.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
      WRITE: / '✅ Confirmation posted:', gs_conf-aufnr,
               'Op', gs_conf-vornr, 'Qty', gs_conf-lmnga, gs_conf-meins.
    ENDIF.

*--------------------------------------------------------------------*
* Optionally TECO if requested
*--------------------------------------------------------------------*
    IF gs_conf-teco_flag = 'X' AND lv_error = abap_false.
      CLEAR: lt_return, ls_return.

      CALL FUNCTION 'BAPI_PRODORD_COMPLETE_TECO'
        EXPORTING
          number = gs_conf-aufnr
        TABLES
          return = lt_return.

      READ TABLE lt_return INTO ls_return WITH KEY type = 'E'.
      IF sy-subrc = 0.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        WRITE: / '❌ TECO failed for', gs_conf-aufnr, ':', ls_return-message.
        lv_error = abap_true.
      ELSE.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
        WRITE: / '✅ Order', gs_conf-aufnr, 'set to TECO.'.
      ENDIF.
    ENDIF.

    CLEAR lt_conf_bapi.

  ENDLOOP.

*--------------------------------------------------------------------*
* IDoc status update
*--------------------------------------------------------------------*
  CLEAR gs_status.
  gs_status-docnum = idoc_contrl-docnum.
  IF lv_error = abap_true.
    gs_status-status = '51'.  " Error
    gs_status-msgty  = 'E'.
    gs_status-msgv1  = 'One or more confirmations failed'.
  ELSE.
    gs_status-status = '53'.  " Success
    gs_status-msgty  = 'S'.
    gs_status-msgv1  = 'All confirmations posted successfully'.
  ENDIF.
  APPEND gs_status TO idoc_status.



ENDFUNCTION.
