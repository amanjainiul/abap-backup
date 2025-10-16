REPORT zprod_com_gi.

*---------------------------------------------------------------------*
* Selection screen for user inputs
*---------------------------------------------------------------------*
PARAMETERS: p_matnr TYPE matnr OBLIGATORY,   "Material
            p_werks TYPE werks_d OBLIGATORY, "Plant
            p_lgort TYPE lgort_d OBLIGATORY, "Storage Location
            p_aufnr TYPE aufnr  OBLIGATORY,  "Production Order
            p_menge TYPE menge_d OBLIGATORY, "Quantity
            p_meins TYPE meins  DEFAULT 'PC'. "Unit of Measure

*---------------------------------------------------------------------*
* Data Declaration
*---------------------------------------------------------------------*
DATA: ls_header  TYPE bapi2017_gm_head_01,
      ls_code    TYPE bapi2017_gm_code,
      ls_item    TYPE bapi2017_gm_item_create,
      lt_item    TYPE TABLE OF bapi2017_gm_item_create,
      ls_return  TYPE bapiret2,
      lt_return  TYPE TABLE OF bapiret2,
      lv_matdoc  TYPE bapi2017_gm_head_ret-mat_doc,
      lv_year    TYPE bapi2017_gm_head_ret-doc_year.

*---------------------------------------------------------------------*
* Header data (document info)
*---------------------------------------------------------------------*
ls_header-pstng_date = sy-datum.       "Posting Date
ls_header-doc_date   = sy-datum.       "Document Date
ls_header-header_txt = |Auto GI for Order { p_aufnr } via SE38|.

*---------------------------------------------------------------------*
* Transaction code (Movement Type context)
*---------------------------------------------------------------------*
ls_code-gm_code = '03'.                " 03 = Goods Issue (MIGO_GI uses same)

*---------------------------------------------------------------------*
* Line item details
*---------------------------------------------------------------------*
CLEAR ls_item.
ls_item-material  = p_matnr.
ls_item-plant     = p_werks.
ls_item-stge_loc  = p_lgort.
ls_item-move_type = '261'.             " Goods Issue to order
ls_item-entry_qnt = p_menge.
ls_item-entry_uom = p_meins.
ls_item-orderid   = p_aufnr.           " Production Order reference

APPEND ls_item TO lt_item.

*---------------------------------------------------------------------*
* Call the BAPI for Goods Movement
*---------------------------------------------------------------------*
CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
  EXPORTING
    goodsmvt_header = ls_header
    goodsmvt_code   = ls_code
  IMPORTING
    materialdocument = lv_matdoc
    matdocumentyear  = lv_year
  TABLES
    goodsmvt_item    = lt_item
    return           = lt_return.

*---------------------------------------------------------------------*
* Display messages and commit
*---------------------------------------------------------------------*
DATA(lv_error) = abap_false.

LOOP AT lt_return INTO ls_return.
  WRITE: / ls_return-type, ls_return-message.
  IF ls_return-type = 'E' OR ls_return-type = 'A'.
    lv_error = abap_true.
  ENDIF.
ENDLOOP.

IF lv_error = abap_false.
  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
    EXPORTING
      wait = 'X'.

  WRITE: / '✅ Goods Issue posted successfully:',
         lv_matdoc, lv_year.
ELSE.
  CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  WRITE: / '❌ Error: Goods Issue failed.'.
ENDIF.
