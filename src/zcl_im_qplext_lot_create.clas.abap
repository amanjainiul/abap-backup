class ZCL_IM_QPLEXT_LOT_CREATE definition
  public
  final
  create public .

public section.

  interfaces IF_EX_QPLEXT_LOT_CREATE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_QPLEXT_LOT_CREATE IMPLEMENTATION.


METHOD if_ex_qplext_lot_create~map_ext_to_int.
*--------------------------------------------------------------------*
* Purpose : Trigger outbound IDoc (ZQM_MES_QUAL) after lot creation
* Author  : ITWPVTLTD
* BAdI    : QPLEXT_LOT_CREATE (S/4HANA)
*--------------------------------------------------------------------*

  DATA: ls_qals       TYPE qals,
        ls_hdr_seg    TYPE ze1qm_hdr,
        ls_idoc_ctrl  TYPE edidc,
        ls_idoc_data  TYPE edidd,
        lt_idoc_data  TYPE STANDARD TABLE OF edidd,
        lv_timestamp  TYPE timestampl.

*--------------------------------------------------------------------*
* 1️⃣  Ensure valid inspection lot
*--------------------------------------------------------------------*
  ls_qals = es_insp_lot_erp.
  IF ls_qals-prueflos IS INITIAL.
    RETURN.
  ENDIF.

*--------------------------------------------------------------------*
* 2️⃣  Populate custom IDoc segment (ZE1QM_HDR)
*--------------------------------------------------------------------*
  GET TIME STAMP FIELD lv_timestamp.

  CLEAR ls_hdr_seg.
  ls_hdr_seg-prueflos  = ls_qals-prueflos.
  ls_hdr_seg-matnr     = ls_qals-matnr.
  ls_hdr_seg-werks     = ls_qals-werk.
  ls_hdr_seg-charg     = ls_qals-charg.
  ls_hdr_seg-pruefart  = ls_qals-art.
  ls_hdr_seg-aufnr     = ls_qals-aufnr.
  ls_hdr_seg-status    = ls_qals-stat35.
  ls_hdr_seg-timestamp = lv_timestamp.

*--------------------------------------------------------------------*
* 3️⃣  Build IDoc data
*--------------------------------------------------------------------*
  CLEAR ls_idoc_data.
  ls_idoc_data-segnam = 'ZE1QM_HDR'.
  ls_idoc_data-sdata  = ls_hdr_seg.
  APPEND ls_idoc_data TO lt_idoc_data.

*--------------------------------------------------------------------*
* 4️⃣  Control record for IDoc
*--------------------------------------------------------------------*
  CLEAR ls_idoc_ctrl.
  ls_idoc_ctrl-mestyp = 'ZQMMES'.
  ls_idoc_ctrl-idoctp = 'ZQM_MES_QUAL'.
  ls_idoc_ctrl-rcvprn = 'CPI_IS'.
  ls_idoc_ctrl-rcvprt = 'LS'.
  ls_idoc_ctrl-sndprn = sy-sysid.
  ls_idoc_ctrl-sndprt = 'LS'.

*--------------------------------------------------------------------*
* 5️⃣  Distribute IDoc
*--------------------------------------------------------------------*
  CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
    IN UPDATE TASK
    EXPORTING
      master_idoc_control = ls_idoc_ctrl
    TABLES
      master_idoc_data    = lt_idoc_data.

  COMMIT WORK.

  MESSAGE |Outbound QM IDoc sent for lot { ls_qals-prueflos }.| TYPE 'S'.

ENDMETHOD.
ENDCLASS.
