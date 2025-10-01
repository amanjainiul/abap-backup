FUNCTION z_ewm_idoc_pi_create01.
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

  DATA: ls_head       TYPE /lime/pi_head_create,
        lt_item       TYPE /lime/pi_t_item_create,
        lt_pi_doc     TYPE /lime/pi_t_item_read,
        lt_ret        TYPE bapiret2_t,
        lv_sev        TYPE bapi_mtype,
        lv_ts         TYPE timestampl,

        ls_head_count TYPE /lime/pi_head,
        lt_item_count TYPE /lime/pi_t_item_count,
        lt_cnt_doc    TYPE /lime/pi_t_item_read,
        lt_ret_count  TYPE bapiret2_t,
        lv_sev_count  TYPE bapi_mtype,

        lt_item_post  TYPE /lime/pi_t_item_post,
        lt_post_doc   TYPE /lime/pi_t_item_read,
        lt_ret_post   TYPE bapiret2_t,
        lv_sev_post   TYPE bapi_mtype,

        lv_matid      TYPE /scwm/de_matid,
        lv_batchid    TYPE /scwm/de_batchid,
        ls_mat_charg  TYPE /scwm/s_matid_charg,
        ls_t300_md    TYPE /scwm/s_t300_md,
        ls_lagp       TYPE /scwm/lagp.

  DATA: ls_idoc_data TYPE edidd,
        ls_hdr_seg   TYPE zewm_invadj_h,
        ls_item_seg  TYPE zewm_invadj_i.

  " Work table for returning IDoc status
  DATA: gt_idoc_status TYPE STANDARD TABLE OF bdidocstat WITH DEFAULT KEY,
        gs_idoc_status TYPE bdidocstat.

  CONSTANTS: lc_act     TYPE /lime/pi_active        VALUE 'A',
             lc_doctyp  TYPE /lime/pi_document_type VALUE 'HS',
             lc_proctyp TYPE /lime/pi_process_type  VALUE 'SCWM',
             lc_ent     TYPE /scwm/de_entitled_role VALUE 'BP'.

  FIELD-SYMBOLS: <ls_item> LIKE LINE OF lt_item,
                 <ls_cnt>  LIKE LINE OF lt_item_count,
                 <ls_res1> LIKE LINE OF <ls_cnt>-t_item_result,
                 <ls_res2> LIKE LINE OF <ls_cnt>-t_item_result,
                 <ls_quan> LIKE LINE OF <ls_res2>-t_quan,
                 <ls_post> LIKE LINE OF lt_item_post.

*----------------------------------------------------------------------*
* 1. Read IDoc Header Segment ZEWM_INVADJ_H
*----------------------------------------------------------------------*
  LOOP AT idoc_data INTO ls_idoc_data WHERE segnam = 'ZEWM_INVADJ_H'.
    ls_hdr_seg = ls_idoc_data-sdata.
  ENDLOOP.

*----------------------------------------------------------------------*
* 2. Read Item Segment(s) ZEWM_INVADJ_I
*----------------------------------------------------------------------*
  LOOP AT idoc_data INTO ls_idoc_data WHERE segnam = 'ZEWM_INVADJ_I'.
    ls_item_seg = ls_idoc_data-sdata.

* Prepare PI Head
    ls_head-lgnum        = ls_hdr_seg-lgnum.
    ls_head-doc_type     = lc_doctyp.
    ls_head-process_type = lc_proctyp.
    ls_head-active       = lc_act.

* Resolve MATID
    CLEAR lv_matid.
    IF ls_item_seg-matnr IS NOT INITIAL.
      CALL FUNCTION 'CONVERSION_EXIT_MDLPD_INPUT'
        EXPORTING
          input  = ls_item_seg-matnr
        IMPORTING
          output = lv_matid
        EXCEPTIONS
          OTHERS = 1.
    ENDIF.

* Resolve BatchID
    IF ls_item_seg-charg IS NOT INITIAL AND lv_matid IS NOT INITIAL.
      ls_mat_charg-matid = lv_matid.
      ls_mat_charg-charg = ls_item_seg-charg.
      TRY.
          CALL METHOD /scwm/cl_batch_appl=>get_batchid_by_no
            EXPORTING
              iv_lgnum       = ls_hdr_seg-lgnum
              is_matid_charg = ls_mat_charg
            IMPORTING
              ev_batchid     = lv_batchid.
        CATCH /scwm/cx_batch_precheck.
      ENDTRY.
    ENDIF.

* Read T300 + Bin
    CALL FUNCTION '/SCWM/T300_MD_READ_SINGLE'
      EXPORTING
        iv_lgnum   = ls_hdr_seg-lgnum
      IMPORTING
        es_t300_md = ls_t300_md
      EXCEPTIONS
        OTHERS     = 1.

    CALL FUNCTION '/SCWM/LAGP_READ_SINGLE'
      EXPORTING
        iv_lgnum = ls_hdr_seg-lgnum
        iv_lgpla = ls_item_seg-vlpla
      IMPORTING
        es_lagp  = ls_lagp
      EXCEPTIONS
        OTHERS   = 1.

*----------------------------------------------------------------------
* 3. CREATE PI Document
*----------------------------------------------------------------------
    APPEND INITIAL LINE TO lt_item ASSIGNING <ls_item>.
    GET TIME STAMP FIELD lv_ts.

    <ls_item>-data-doc_type   = lc_doctyp.
    <ls_item>-data-count_date = lv_ts.
    <ls_item>-data-hu_item-huident  = ls_item_seg-vlenr.
    <ls_item>-data-hu_item-lgnum_hu = ls_hdr_seg-lgnum.
    <ls_item>-data-loc_parent-lgnum = ls_hdr_seg-lgnum.
    <ls_item>-data-loc_parent-lgpla = ls_item_seg-vlpla.
    <ls_item>-data-loc_parent-lgtyp = ls_lagp-lgtyp.
    <ls_item>-data-stock_item-matid   = lv_matid.
    <ls_item>-data-stock_item-batchid = lv_batchid.
    <ls_item>-data-stock_item-cat     = ls_item_seg-cat.
    <ls_item>-data-stock_item-lgnum_stock = ls_hdr_seg-lgnum.
    <ls_item>-data-stock_item-owner   = ls_t300_md-entitled.
    <ls_item>-data-stock_item-owner_role    = lc_ent.
    <ls_item>-data-stock_item-entitled      = ls_t300_md-entitled.
    <ls_item>-data-stock_item-entitled_role = lc_ent.
    <ls_item>-data-reason = ls_hdr_seg-reason.
    <ls_item>-active      = lc_act.

    CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_CREATE'
      EXPORTING
        is_head       = ls_head
        it_item       = lt_item
        iv_save_pack  = abap_true
      IMPORTING
        et_pi_doc     = lt_pi_doc
        et_bapiret    = lt_ret
        e_rc_severity = lv_sev.

    COMMIT WORK AND WAIT.

    READ TABLE lt_pi_doc INTO DATA(ls_pi_doc) INDEX 1.
    IF sy-subrc <> 0.
      CLEAR gs_idoc_status.
      gs_idoc_status-docnum = IDOC_CONTRL-docnum.
      gs_idoc_status-status = '51'.
      gs_idoc_status-msgty  = 'E'.
      gs_idoc_status-msgid  = 'Z_EWM_PI'.
      gs_idoc_status-msgno  = '001'.
      gs_idoc_status-msgv1  = 'PI not created'.
      APPEND gs_idoc_status TO gt_idoc_status.
      RETURN.
    ENDIF.

*----------------------------------------------------------------------
* 4. COUNT PI Document
*----------------------------------------------------------------------
    CLEAR lt_item_count.
    ls_head_count-process_type = lc_proctyp.
    ls_head_count-lgnum        = ls_hdr_seg-lgnum.

    APPEND INITIAL LINE TO lt_item_count ASSIGNING <ls_cnt>.
    <ls_cnt>-doc_number   = ls_pi_doc-doc_number.
    <ls_cnt>-doc_year     = ls_pi_doc-doc_year.
    <ls_cnt>-item_no      = '1'.
    <ls_cnt>-process_type = lc_proctyp.
    <ls_cnt>-lgnum        = ls_hdr_seg-lgnum.
    <ls_cnt>-doc_type     = lc_doctyp.
    <ls_cnt>-count_date   = lv_ts.
    <ls_cnt>-count_user   = ls_hdr_seg-processor.
    <ls_cnt>-reason       = ls_hdr_seg-reason.
    <ls_cnt>-post_item    = abap_true.

* HU level
    APPEND INITIAL LINE TO <ls_cnt>-t_item_result ASSIGNING <ls_res1>.
    <ls_res1>-data-lvl = '1'.
    <ls_res1>-data-type_item   = 'H'.
    <ls_res1>-data-type_parent = 'L'.
    <ls_res1>-data-hu_item-huident  = ls_item_seg-vlenr.
    <ls_res1>-data-hu_item-lgnum_hu = ls_hdr_seg-lgnum.
    <ls_res1>-data-loc_parent-lgnum = ls_hdr_seg-lgnum.
    <ls_res1>-data-loc_parent-lgpla = ls_item_seg-vlpla.
    <ls_res1>-data-loc_parent-lgtyp = ls_lagp-lgtyp.

* Stock level
    APPEND INITIAL LINE TO <ls_cnt>-t_item_result ASSIGNING <ls_res2>.
    <ls_res2>-data-lvl = '2'.
    <ls_res2>-data-type_item   = 'S'.
    <ls_res2>-data-type_parent = 'H'.
    <ls_res2>-data-hu_parent-lgnum_hu = ls_hdr_seg-lgnum.
    <ls_res2>-data-hu_parent-huident  = ls_item_seg-vlenr.
    <ls_res2>-data-stock_item-matid   = lv_matid.
    <ls_res2>-data-stock_item-batchid = lv_batchid.
    <ls_res2>-data-stock_item-cat     = ls_item_seg-cat.
    <ls_res2>-data-stock_item-lgnum_stock = ls_hdr_seg-lgnum.
    <ls_res2>-data-stock_item-owner   = ls_t300_md-entitled.
    <ls_res2>-data-stock_item-owner_role    = lc_ent.
    <ls_res2>-data-stock_item-entitled      = ls_t300_md-entitled.
    <ls_res2>-data-stock_item-entitled_role = lc_ent.

    APPEND INITIAL LINE TO <ls_res2>-t_quan ASSIGNING <ls_quan>.
    <ls_quan>-qan_status       = 'C'.
    <ls_quan>-entered_quantity = ls_item_seg-cntqty.
    <ls_quan>-entered_unit     = ls_item_seg-altme.

    CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_COUNT'
      EXPORTING
        is_head       = ls_head_count
        it_item       = lt_item_count
        iv_save_pack  = abap_true
      IMPORTING
        et_pi_doc     = lt_cnt_doc
        et_bapiret    = lt_ret_count
        e_rc_severity = lv_sev_count.

    COMMIT WORK AND WAIT.

*----------------------------------------------------------------------
* 5. POST PI Document
*----------------------------------------------------------------------
    CLEAR lt_item_post.
    LOOP AT lt_item_count ASSIGNING <ls_cnt>.
      APPEND INITIAL LINE TO lt_item_post ASSIGNING <ls_post>.
      <ls_post>-doc_number = <ls_cnt>-doc_number.
      <ls_post>-doc_year   = <ls_cnt>-doc_year.
      <ls_post>-item_no    = <ls_cnt>-item_no.
      GET TIME STAMP FIELD <ls_post>-post_date.
    ENDLOOP.

    CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_POST'
      EXPORTING
        is_head       = ls_head_count
        it_item       = lt_item_post
        iv_save_pack  = abap_true
      IMPORTING
        et_pi_doc     = lt_post_doc
        et_bapiret    = lt_ret_post
        e_rc_severity = lv_sev_post.

    COMMIT WORK AND WAIT.

  ENDLOOP. " ZEWM_INVADJ_I

*----------------------------------------------------------------------
* 6. Success Status
*----------------------------------------------------------------------
  CLEAR gs_idoc_status.
  gs_idoc_status-docnum = IDOC_CONTRL-docnum.
  gs_idoc_status-status = '53'.  " posted
  gs_idoc_status-msgty  = 'S'.
  gs_idoc_status-msgid  = 'Z_EWM_PI'.
  gs_idoc_status-msgno  = '000'.
  gs_idoc_status-msgv1  = 'PI document created, counted, posted'.
  APPEND gs_idoc_status TO gt_idoc_status.

* Move collected statuses back to IDoc framework
  LOOP AT gt_idoc_status INTO gs_idoc_status.
    APPEND gs_idoc_status TO idoc_status.
  ENDLOOP.

ENDFUNCTION.
