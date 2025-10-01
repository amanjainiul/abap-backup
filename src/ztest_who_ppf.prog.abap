REPORT ztest_who_ppf.

PARAMETERS: p_srv   TYPE char40 OBLIGATORY DEFAULT 'Z_EWM_WHO_PROCESS_SRV',
            p_ent   TYPE char40 OBLIGATORY DEFAULT 'WarehouseOrderSet',
            p_lgnum TYPE char10 OBLIGATORY DEFAULT 'SW02',
            p_who   TYPE char20 OBLIGATORY DEFAULT '1380'.

DATA: lo_http     TYPE REF TO if_http_client,
      lv_srv      TYPE string,
      lv_ent      TYPE string,
      lv_pent_up  TYPE string,
      lv_who_ext  TYPE char10,
      lv_uri      TYPE string,
      lv_response TYPE string,
      lv_status   TYPE i,
      lv_reason   TYPE string,
      lv_short    TYPE string.

START-OF-SELECTION.

  " --- normalize & prepare
  lv_srv = to_upper( val = p_srv ).

  lv_pent_up = to_upper( val = p_ent ).
  CASE lv_pent_up.
    WHEN 'WAREHOUSEORDERSET'.
      lv_ent = 'WarehouseOrderSet'.
    WHEN 'WAREHOUSETASKSET'.
      lv_ent = 'WarehouseTaskSet'.
    WHEN OTHERS.
      lv_ent = p_ent.
  ENDCASE.

  " pad WHO to 10 chars (leading zeros)
  lv_who_ext = |{ p_who ALPHA = IN }|.

  " build relative URI (SM59 Path Prefix must contain the service root or the service)
  lv_uri = |{ lv_srv }/{ lv_ent }?$filter=Lgnum eq '{ p_lgnum }' and Who eq '{ lv_who_ext }'|.

  WRITE: / 'WT PPF Test'.
  WRITE: / '------------------------------------------------------------'.
  WRITE: / 'Final URI   :', lv_uri.

  " create HTTP client via destination (Type H)
  TRY.
      cl_http_client=>create_by_destination(
        EXPORTING destination = 'ZGW_LOOPBACK'
        IMPORTING client      = lo_http ).
    CATCH cx_root INTO DATA(lx_create).
      WRITE: / 'HTTP client creation error:', lx_create->get_text( ).
      RETURN.
  ENDTRY.

  " prepare request (GET, ask XML)
  lo_http->request->set_method( if_http_request=>co_request_method_get ).
  lo_http->request->set_header_field( name = 'Accept' value = 'application/xml' ).
  lo_http->request->set_header_field( name = '~request_uri' value = lv_uri ).

  " send / receive
  TRY.
      lo_http->send( ).
      lo_http->receive( ).
    CATCH cx_root INTO DATA(lx_send).
      WRITE: / 'Error during send/receive:', lx_send->get_text( ).
      lo_http->close( ).
      RETURN.
  ENDTRY.

  " get status and response
  lo_http->response->get_status(
    IMPORTING
      code   = lv_status
      reason = lv_reason ).

  lv_response = lo_http->response->get_cdata( ).
  lo_http->close( ).

  " output
  WRITE: / '------------------------------------------------------------'.
  WRITE: / 'HTTP Status:', lv_status.
  WRITE: / 'Reason     :', lv_reason.
  WRITE: / 'Response   :' .

  IF lv_response IS NOT INITIAL.
    lv_short = lv_response.
    WRITE: / lv_short(500).
  ENDIF.

END-OF-SELECTION.
