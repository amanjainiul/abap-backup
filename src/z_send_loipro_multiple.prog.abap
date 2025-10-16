REPORT z_send_loipro_multi.

" Define a hidden parameter with correct DDIC type AUFNR
PARAMETERS: pauf TYPE aufnr NO-DISPLAY.

" Multiple order numbers / ranges
SELECT-OPTIONS: so_aufnr FOR pauf OBLIGATORY.

" Logical system (MES target)
PARAMETERS: p_logsys TYPE logsys OBLIGATORY.

START-OF-SELECTION.

  IF so_aufnr[] IS INITIAL.
    MESSAGE 'Please enter at least one Production Order' TYPE 'E'.
  ENDIF.

  " Call RCCLTRAN with multiple orders
  SUBMIT rccltran
    WITH paufnr IN so_aufnr
    WITH p_logsys = p_logsys
    AND RETURN.

  MESSAGE |LOIPRO IDocs triggered for orders { so_aufnr-low } ... { so_aufnr-high } to { p_logsys }| TYPE 'S'.
