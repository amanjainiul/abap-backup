class ZCL_IM_INSPECTIONLOT_UPDAT definition
  public
  final
  create public .

public section.

  interfaces IF_EX_INSPECTIONLOT_UPDATE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_INSPECTIONLOT_UPDAT IMPLEMENTATION.


  method IF_EX_INSPECTIONLOT_UPDATE~CHANGE_AT_SAVE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CHANGE_BEFORE_UPDATE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CHANGE_IN_UPDATE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CHANGE_UD_AT_SAVE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CHANGE_UD_BEFORE_UPDATE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CHANGE_UD_IN_UPDATE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CREATE_AT_SAVE.
      " Your custom logic
  ...
  BREAK-POINT.
  " More custom logic
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~CREATE_BEFORE_UPDATE.
  endmethod.


METHOD if_ex_inspectionlot_update~create_in_update.

  DATA: ls_edidc   TYPE edidc,
        lt_edidd   TYPE STANDARD TABLE OF edidd,
        ls_edidd   TYPE edidd,
        lt_comm    TYPE STANDARD TABLE OF edidc,
        ls_hdr     TYPE ze1qm_hdr,
        lv_idocnum TYPE edi_docnum,
        lv_status  TYPE char10.

  "--------------------------------------------------------------
  " Build payload for ZE1QM_HDR segment from INSLOT (QALS)
  "--------------------------------------------------------------
  ls_hdr-prueflos = insplot-prueflos.
  ls_hdr-matnr    = insplot-matnr.
  ls_hdr-werks    = insplot-werk.
  ls_hdr-charg    = insplot-charg.
  ls_hdr-pruefart = insplot-art.
  ls_hdr-aufnr    = insplot-aufnr.

  " Map statuses (simple mapping)
  IF insplot-stat01 = 'X'.
    lv_status = 'CREATED'.
  ELSEIF insplot-stat15 = 'X'.
    lv_status = 'INPROC'.
  ELSEIF insplot-stat20 = 'X'.
    lv_status = 'READY'.
  ELSE.
    lv_status = 'UNKNOWN'.
  ENDIF.

  ls_hdr-status = lv_status.

  CONCATENATE sy-datum sy-uzeit INTO ls_hdr-timestamp.

  "--------------------------------------------------------------
  " Read ALE / IDoc routing from TVARVC
  "--------------------------------------------------------------
  DATA: lv_mestyp  TYPE tvarvc-low,
        lv_idoctp  TYPE tvarvc-low,
        lv_rcvpor  TYPE tvarvc-low,
        lv_rcvprt  TYPE tvarvc-low,
        lv_rcvprn  TYPE tvarvc-low,
        lv_sndpor  TYPE tvarvc-low,
        lv_sndprt  TYPE tvarvc-low,
        lv_sndprn  TYPE tvarvc-low.

  SELECT SINGLE low INTO lv_mestyp  FROM tvarvc WHERE name = 'ZQM_IDOC_MESTYP'.
  SELECT SINGLE low INTO lv_idoctp  FROM tvarvc WHERE name = 'ZQM_IDOC_IDOCTYP'.

  SELECT SINGLE low INTO lv_rcvpor FROM tvarvc WHERE name = 'ZQM_IDOC_RCVPOR'.
  SELECT SINGLE low INTO lv_rcvprt FROM tvarvc WHERE name = 'ZQM_IDOC_RCVPRT'.
  SELECT SINGLE low INTO lv_rcvprn FROM tvarvc WHERE name = 'ZQM_IDOC_RCVPRN'.

  SELECT SINGLE low INTO lv_sndpor FROM tvarvc WHERE name = 'ZQM_IDOC_SNDPOR'.
  SELECT SINGLE low INTO lv_sndprt FROM tvarvc WHERE name = 'ZQM_IDOC_SNDPRT'.
  SELECT SINGLE low INTO lv_sndprn FROM tvarvc WHERE name = 'ZQM_IDOC_SNDPRN'.

  "--------------------------------------------------------------
  " Fill control record EDIDC
  "--------------------------------------------------------------
  CLEAR ls_edidc.
  ls_edidc-mestyp = lv_mestyp.
  ls_edidc-idoctp = lv_idoctp.
  ls_edidc-direct = '1'.     "Outbound direction

  ls_edidc-rcvpor = lv_rcvpor.
  ls_edidc-rcvprt = lv_rcvprt.
  ls_edidc-rcvprn = lv_rcvprn.

  ls_edidc-sndpor = lv_sndpor.
  ls_edidc-sndprt = lv_sndprt.
  ls_edidc-sndprn = lv_sndprn.

  "--------------------------------------------------------------
  " Fill IDoc Segment
  "--------------------------------------------------------------
  CLEAR ls_edidd.
  ls_edidd-segnam = 'ZE1QM_HDR'.
  ls_edidd-sdata  = ls_hdr.
  APPEND ls_edidd TO lt_edidd.

  "--------------------------------------------------------------
  " Distribute IDoc   (correct signature for your system)
  "--------------------------------------------------------------
  CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
    EXPORTING
      master_idoc_control = ls_edidc
    TABLES
      communication_idoc_control = lt_comm
      master_idoc_data           = lt_edidd
    EXCEPTIONS
      error_in_idoc_control      = 1
      error_writing_idoc_status  = 2
      error_in_idoc_data         = 3
      sending_logical_system_unknown = 4
      OTHERS                     = 5.

  "--------------------------------------------------------------
  " Optional: retrieve generated IDoc number
  "--------------------------------------------------------------
  IF sy-subrc = 0.
    READ TABLE lt_comm INTO ls_edidc INDEX 1.
    IF sy-subrc = 0.
      lv_idocnum = ls_edidc-docnum.
      " todo: SLG1 logging if required
    ENDIF.
  ENDIF.

ENDMETHOD.


  method IF_EX_INSPECTIONLOT_UPDATE~SET_UD_AT_SAVE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~SET_UD_BEFORE_UPDATE.
  endmethod.


  method IF_EX_INSPECTIONLOT_UPDATE~SET_UD_IN_UPDATE.
  endmethod.
ENDCLASS.
