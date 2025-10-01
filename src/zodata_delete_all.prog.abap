REPORT zodata_delete_all.

PARAMETERS: p_all AS CHECKBOX DEFAULT abap_false,
            p_hdr TYPE zodata_hdr-hdr_id.

START-OF-SELECTION.

  IF p_all = abap_true.
    DELETE FROM zodata_kv.
    DELETE FROM zodata_hdr.
    WRITE: / 'All entries deleted'.
  ELSEIF p_hdr IS NOT INITIAL.
    DELETE FROM zodata_kv WHERE hdr_id = p_hdr.
    DELETE FROM zodata_hdr WHERE hdr_id = p_hdr.
    WRITE: / 'Deleted entries for HDR_ID:', p_hdr.
  ELSE.
    WRITE: / 'Please select either ALL or enter HDR_ID'.
  ENDIF.

  COMMIT WORK.
