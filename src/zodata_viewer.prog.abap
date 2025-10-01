REPORT zodata_viewer.

PARAMETERS: p_lgnum TYPE /scwm/lgnum OBLIGATORY,
            p_who   TYPE /scwm/de_who OBLIGATORY.

DATA: lo_http     TYPE REF TO if_http_client,
      lv_uri      TYPE string,
      lv_response TYPE string,
      lv_status   TYPE i,
      lv_reason   TYPE string,
      lv_who_norm TYPE /scwm/de_who.

" Normalize WHO
lv_who_norm = |{ p_who ALPHA = IN }|.

" Build URI
lv_uri = |Z_EWM_WHO_PROCESS_SRV/WarehouseOrderSet(Lgnum='{ p_lgnum }',Who='{ lv_who_norm }')|.

TRY.
    cl_http_client=>create_by_destination(
      EXPORTING destination = 'ZGW_LOOPBACK'
      IMPORTING client      = lo_http ).

    lo_http->request->set_method( if_http_request=>co_request_method_get ).
    lo_http->request->set_header_field( name = 'Accept' value = 'application/xml' ).
    lo_http->request->set_header_field( name = '~request_uri' value = lv_uri ).

    lo_http->send( ).
    lo_http->receive( ).

    lo_http->response->get_status(
      IMPORTING code = lv_status reason = lv_reason ).

    lv_response = lo_http->response->get_cdata( ).
    lo_http->close( ).

    WRITE: / 'URI:       ', lv_uri,
           / 'HTTP Code: ', lv_status, lv_reason,
           / '--------------------------------------------------'.

    " Extract with POSIX-safe regex ([^<]* instead of .*?)
    DATA: lv_lgnum     TYPE string,
          lv_who       TYPE string,
          lv_procty    TYPE string,
          lv_createdby TYPE string,
          lv_startedat TYPE string.

    FIND FIRST OCCURRENCE OF REGEX '<d:Lgnum>([^<]*)</d:Lgnum>'
      IN lv_response SUBMATCHES lv_lgnum.
    FIND FIRST OCCURRENCE OF REGEX '<d:Who>([^<]*)</d:Who>'
      IN lv_response SUBMATCHES lv_who.
    FIND FIRST OCCURRENCE OF REGEX '<d:HdrProcty>([^<]*)</d:HdrProcty>'
      IN lv_response SUBMATCHES lv_procty.
    FIND FIRST OCCURRENCE OF REGEX '<d:CreatedBy>([^<]*)</d:CreatedBy>'
      IN lv_response SUBMATCHES lv_createdby.
    FIND FIRST OCCURRENCE OF REGEX '<d:StartedAt>([^<]*)</d:StartedAt>'
      IN lv_response SUBMATCHES lv_startedat.

    ULINE.
    WRITE: / 'Extracted Values:',
           / 'Lgnum     =', lv_lgnum,
           / 'Who       =', lv_who,
           / 'HdrProcty =', lv_procty,
           / 'CreatedBy =', lv_createdby,
           / 'StartedAt =', lv_startedat.

  CATCH cx_root INTO DATA(lx_err).
    WRITE: / 'Error in HTTP Request:', lx_err->get_text( ).
    IF lo_http IS BOUND.
      lo_http->close( ).
    ENDIF.
ENDTRY.
