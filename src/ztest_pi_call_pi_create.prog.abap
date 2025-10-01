REPORT zdbg_pi_create_match_idoc NO STANDARD PAGE HEADING.

* Minimal test that builds a create payload to match the working iDoc sample you provided.
* This sets MATID/BATCHID (if resolvable), OWNER/OWNER_ROLE='BP', CAT='AV',
* HU HUIDENT and LOC_PARENT-LGPLA=ASRSHB (per your dump) before calling the FM.

PARAMETERS: p_lgnum TYPE /scwm/lgnum DEFAULT 'SW02' OBLIGATORY,
            p_vlpla TYPE /scwm/lgpla DEFAULT 'ASRSHB' OBLIGATORY,
            p_matnr TYPE string     DEFAULT 'S4H_PINV_01',
            p_charg TYPE string     DEFAULT '',
            p_vlenr TYPE /scwm/de_huident DEFAULT '00000000001000000596', " from dump
            p_owner TYPE /scwm/de_owner DEFAULT 'BP_PL_P002',              " from dump
            p_qty   TYPE p DECIMALS 3 DEFAULT '5.000'.

DATA: ls_head   TYPE /lime/pi_head_create,
      lt_item   TYPE /lime/pi_t_item_create,
      ls_ci     TYPE /lime/pi_item_create,
      lt_pi_doc TYPE /lime/pi_t_item_read,
      lt_ret    TYPE bapiret2_t,
      ls_ret    TYPE bapiret2,
      lv_sev    TYPE bapi_mtype,
      lv_ts     TYPE timestampl.

DATA: lv_matid     TYPE /scwm/de_matid,
      lv_batchid   TYPE /scwm/de_batchid,
      ls_mat_charg TYPE /scwm/s_matid_charg,
      ls_t300_md   TYPE /scwm/s_t300_md,
      ls_lagp      TYPE /scwm/lagp.

* Head
START-OF-SELECTION.
  ls_head-lgnum        = p_lgnum.
  ls_head-doc_type     = 'HS'.
  ls_head-process_type = 'SCWM'.
  ls_head-active       = 'A'.

* Convert MATNR -> MATID (internal id)
  CLEAR lv_matid.
  IF p_matnr IS NOT INITIAL.
    CALL FUNCTION 'CONVERSION_EXIT_MDLPD_INPUT'
      EXPORTING
        input  = p_matnr
      IMPORTING
        output = lv_matid
      EXCEPTIONS
        OTHERS = 1.
    IF sy-subrc <> 0.
      CLEAR lv_matid.
    ENDIF.
  ENDIF.

* Try to resolve BATCHID if CHARG provided
  CLEAR lv_batchid.
  IF p_charg IS NOT INITIAL AND lv_matid IS NOT INITIAL.
    ls_mat_charg-matid = lv_matid.
    ls_mat_charg-charg = p_charg.
    TRY.
        CALL METHOD /scwm/cl_batch_appl=>get_batchid_by_no
          EXPORTING
            iv_lgnum       = p_lgnum
            is_matid_charg = ls_mat_charg
          IMPORTING
            ev_batchid     = lv_batchid.
      CATCH /scwm/cx_batch_precheck.
        CLEAR lv_batchid.
    ENDTRY.
  ENDIF.

* Optionally read T300/LAGP to get entitled owner if you don't pass owner
  CLEAR ls_t300_md.
  IF p_lgnum IS NOT INITIAL.
    CALL FUNCTION '/SCWM/T300_MD_READ_SINGLE'
      EXPORTING
        iv_lgnum   = p_lgnum
      IMPORTING
        es_t300_md = ls_t300_md
      EXCEPTIONS
        not_found  = 1
        OTHERS     = 2.
  ENDIF.
  CALL FUNCTION '/SCWM/LAGP_READ_SINGLE'
    EXPORTING
      iv_lgnum      = p_lgnum
      iv_lgpla      = p_vlpla
    IMPORTING
      es_lagp       = ls_lagp
    EXCEPTIONS
      wrong_input   = 1
      not_found     = 2
      enqueue_error = 3
      OTHERS        = 4.

* Build single create line to match iDoc
  CLEAR ls_ci.
  GET TIME STAMP FIELD lv_ts.

  ls_ci-data-doc_type   = ls_head-doc_type.
  ls_ci-data-count_date = lv_ts.

  " HU
  ls_ci-data-hu_item-huident  = p_vlenr.
  ls_ci-data-hu_item-lgnum_hu = p_lgnum.

  " LOC_PARENT - set bin exactly as in your working dump
  ls_ci-data-loc_parent-lgnum = p_lgnum.
  ls_ci-data-loc_parent-lgpla = p_vlpla.
  IF ls_lagp-lgtyp IS NOT INITIAL.
    ls_ci-data-loc_parent-lgtyp = ls_lagp-lgtyp.
  ENDIF.

  " STOCK_ITEM - put internal ids if resolved and use owner/role 'BP'
  IF p_matnr IS NOT INITIAL.
    ls_ci-data-stock_item-matnr = p_matnr.
  ENDIF.
  IF p_charg IS NOT INITIAL.
    ls_ci-data-stock_item-charg = p_charg.
  ENDIF.
  IF lv_matid IS NOT INITIAL.
    ls_ci-data-stock_item-matid = lv_matid.     " important - internal mat id
  ENDIF.
  IF lv_batchid IS NOT INITIAL.
    ls_ci-data-stock_item-batchid = lv_batchid. " important - internal batch id
  ENDIF.

  " fields observed in working iDoc
  ls_ci-data-stock_item-cat = 'F2'.            " matches dump
  ls_ci-data-stock_item-owner = p_owner.
  ls_ci-data-stock_item-owner_role = 'BP'.     " critical
  ls_ci-data-stock_item-entitled = p_owner.
  ls_ci-data-stock_item-entitled_role = 'BP'.  " critical

  ls_ci-data-reason = 'CNTB'.                  " matches dump reason
  ls_ci-active      = 'A'.

  APPEND ls_ci TO lt_item.

* Debug hint: set session breakpoint in /SCWM/PI_CALL_DOCUMENT_CREATE now and run
  WRITE: / 'Prepared payload - call PI create (inspect IT_ITEM in debugger now if needed)'.

* Call the FM
  CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_CREATE'
    EXPORTING
      is_head       = ls_head
      it_item       = lt_item
      iv_save_pack  = abap_true
    IMPORTING
      et_pi_doc     = lt_pi_doc
      et_bapiret    = lt_ret
      e_rc_severity = lv_sev.

* Output results
  WRITE: / 'Create RC severity:', lv_sev.
  LOOP AT lt_ret INTO ls_ret.
    WRITE: / ls_ret-type, ls_ret-id, ls_ret-number, '-', ls_ret-message.
  ENDLOOP.

  IF lv_sev = 'S'.
  COMMIT WORK AND WAIT.  " <-- ensure DB save
ENDIF.

  IF lt_pi_doc IS NOT INITIAL.
    READ TABLE lt_pi_doc INTO DATA(ls_pd) INDEX 1.
    IF sy-subrc = 0.
      WRITE: / 'Created PI Document:', ls_pd-doc_number, ' Year:', ls_pd-doc_year.
    ENDIF.
  ELSE.
    WRITE: / 'No PI document returned.'.
  ENDIF.

  WRITE: / 'End of test.'.
