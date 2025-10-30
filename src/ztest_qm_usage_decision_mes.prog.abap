REPORT ztest_qm_ud_input.

PARAMETERS: InsLot TYPE qplos OBLIGATORY,      "Inspection Lot
            Plant TYPE werks_d OBLIGATORY,   "Plant
            selSet TYPE qmerknr OBLIGATORY,  "Selected Set / Code Group
            UDCode TYPE qbewert OBLIGATORY.  "UD Code

*---------------------------------------------------------------
* BAPI Structures
*---------------------------------------------------------------
DATA: ls_ud_bapi   TYPE bapi2045ud,
      ls_ud_ret    TYPE bapi2045ud_return,
      ls_bapi_ret  TYPE bapireturn1,
      lt_sysstat   TYPE TABLE OF bapi2045ss,
      lt_usrstat   TYPE TABLE OF bapi2045us.

*---------------------------------------------------------------
* Prepare Usage Decision Data
*---------------------------------------------------------------
CLEAR ls_ud_bapi.

ls_ud_bapi-insplot             = InsLot.
ls_ud_bapi-ud_plant            = Plant.
ls_ud_bapi-ud_selected_set     = selSet.   "Selected Set (Code Group)
ls_ud_bapi-ud_code             = UDCode.   "UD Code
ls_ud_bapi-ud_text_line        = |UD Test via SE38|.
ls_ud_bapi-ud_recorded_by_user = sy-uname.
ls_ud_bapi-ud_recorded_on_date = sy-datum.
ls_ud_bapi-ud_recorded_at_time = sy-uzeit.
ls_ud_bapi-ud_force_completion = 'X'.

WRITE: / 'Posting UD for Lot:', InsLot.
WRITE: / 'Plant:', Plant, ', Selected Set:', selSet, ', UD Code:', UDCode.

*---------------------------------------------------------------
* Call BAPI
*---------------------------------------------------------------
CALL FUNCTION 'BAPI_INSPLOT_SETUSAGEDECISION'
  EXPORTING
    number         = ls_ud_bapi-insplot
    ud_data        = ls_ud_bapi
  IMPORTING
    ud_return_data = ls_ud_ret
    return         = ls_bapi_ret
  TABLES
    system_status  = lt_sysstat
    user_status    = lt_usrstat.

IF sy-subrc = 0 AND ls_bapi_ret-type <> 'E'.
  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' EXPORTING wait = 'X'.
  WRITE: / '✅ Usage Decision posted successfully!'.
ELSE.
  CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  WRITE: / '❌ UD Posting Failed:'.
  WRITE: / ls_bapi_ret-message.
ENDIF.
