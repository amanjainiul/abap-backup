REPORT ztest_send_qm_idoc_to_mes.

DATA: ls_edidc   TYPE edidc,
      lt_edidd   TYPE STANDARD TABLE OF edidd,
      ls_edidd   TYPE edidd,
      lt_comm    TYPE STANDARD TABLE OF edidc,
      ls_hdr     TYPE ze1qm_hdr,
      lv_idocnum TYPE edi_docnum.

DATA: lv_mestyp  TYPE tvarvc-low,
      lv_idoctp TYPE tvarvc-low,
      lv_rcvpor TYPE tvarvc-low,
      lv_rcvprt TYPE tvarvc-low,
      lv_rcvprn TYPE tvarvc-low,
      lv_sndpor TYPE tvarvc-low,
      lv_sndprt TYPE tvarvc-low,
      lv_sndprn TYPE tvarvc-low.

*--------------------------------------------------------------------
* Read config directly from TVARVC
*--------------------------------------------------------------------
SELECT SINGLE low INTO lv_mestyp  FROM tvarvc WHERE name = 'ZQM_IDOC_MESTYP'.
SELECT SINGLE low INTO lv_idoctp  FROM tvarvc WHERE name = 'ZQM_IDOC_IDOCTYP'.

SELECT SINGLE low INTO lv_rcvpor FROM tvarvc WHERE name = 'ZQM_IDOC_RCVPOR'.
SELECT SINGLE low INTO lv_rcvprt FROM tvarvc WHERE name = 'ZQM_IDOC_RCVPRT'.
SELECT SINGLE low INTO lv_rcvprn FROM tvarvc WHERE name = 'ZQM_IDOC_RCVPRN'.

SELECT SINGLE low INTO lv_sndpor FROM tvarvc WHERE name = 'ZQM_IDOC_SNDPOR'.
SELECT SINGLE low INTO lv_sndprt FROM tvarvc WHERE name = 'ZQM_IDOC_SNDPRT'.
SELECT SINGLE low INTO lv_sndprn FROM tvarvc WHERE name = 'ZQM_IDOC_SNDPRN'.

*--------------------------------------------------------------------
* Fill control record
*--------------------------------------------------------------------
ls_edidc-mestyp = lv_mestyp.
ls_edidc-idoctp = lv_idoctp.
ls_edidc-direct = '1'. "Outbound

ls_edidc-rcvpor = lv_rcvpor.
ls_edidc-rcvprt = lv_rcvprt.
ls_edidc-rcvprn = lv_rcvprn.

ls_edidc-sndpor = lv_sndpor.
ls_edidc-sndprt = lv_sndprt.
ls_edidc-sndprn = lv_sndprn.

*--------------------------------------------------------------------
* Fill custom IDoc Segment data
*--------------------------------------------------------------------
ls_hdr-prueflos  = '030000000023'.
ls_hdr-matnr     = 'S4H_PROD_20'.
ls_hdr-werks     = 'P002'.
ls_hdr-charg     = ''.
ls_hdr-pruefart  = '03'.
ls_hdr-aufnr     = '000001000088'.
ls_hdr-status    = 'CREATED'.
ls_hdr-timestamp = '20251031002502'.

ls_edidd-segnam = 'ZE1QM_HDR'.
ls_edidd-sdata  = ls_hdr.
APPEND ls_edidd TO lt_edidd.

*--------------------------------------------------------------------
* Distribute IDoc
*--------------------------------------------------------------------
CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
  EXPORTING
    master_idoc_control = ls_edidc
  TABLES
    communication_idoc_control = lt_comm
    master_idoc_data           = lt_edidd
  EXCEPTIONS
    error_in_idoc_control           = 1
    error_writing_idoc_status       = 2
    error_in_idoc_data              = 3
    sending_logical_system_unknown  = 4
    OTHERS                          = 5.

IF sy-subrc = 0.
  READ TABLE lt_comm INTO ls_edidc INDEX 1.
  IF sy-subrc = 0.
    lv_idocnum = ls_edidc-docnum.
    WRITE: / '✅ IDoc generated successfully: ', lv_idocnum.
  ELSE.
    WRITE: / '⚠ IDoc created but not found in comm table'.
  ENDIF.
ELSE.
  WRITE: / '❌ Error sending IDoc, SY-SUBRC = ', sy-subrc.
ENDIF.
