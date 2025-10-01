class ZCL_Z_EWM_STOCK_ADJ_DPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_DATA
  abstract
  create public .

public section.

  interfaces /IWBEP/IF_SB_DPC_COMM_SERVICES .
  interfaces /IWBEP/IF_SB_GEN_DPC_INJECTION .

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~DELETE_ENTITY
    redefinition .
protected section.

  data mo_injection type ref to /IWBEP/IF_SB_GEN_DPC_INJECTION .

  methods STOCKADJUSTMENTI_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_STOCK_ADJ_MPC=>TS_STOCKADJUSTMENTITEM
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods STOCKADJUSTMENTI_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods STOCKADJUSTMENTI_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_STOCK_ADJ_MPC=>TS_STOCKADJUSTMENTITEM
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods STOCKADJUSTMENTI_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type ZCL_Z_EWM_STOCK_ADJ_MPC=>TT_STOCKADJUSTMENTITEM
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods STOCKADJUSTMENTI_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_STOCK_ADJ_MPC=>TS_STOCKADJUSTMENTITEM
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .

  methods CHECK_SUBSCRIPTION_AUTHORITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_STOCK_ADJ_DPC IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 18.09.2025 18:02:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_STOCK_ADJ_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA stockadjustmenti_create_entity TYPE zcl_z_ewm_stock_adj_mpc=>ts_stockadjustmentitem.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  StockAdjustmentItemSet
*-------------------------------------------------------------------------*
     WHEN 'StockAdjustmentItemSet'.
*     Call the entity set generated method
    stockadjustmenti_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = stockadjustmenti_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = stockadjustmenti_create_entity
      CHANGING
        cr_data = er_entity
   ).

  when others.
    super->/iwbep/if_mgw_appl_srv_runtime~create_entity(
       EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         io_data_provider   = io_data_provider
         it_key_tab = it_key_tab
         it_navigation_path = it_navigation_path
      IMPORTING
        er_entity = er_entity
  ).
ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~DELETE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_DEL_ENTITY_BASE
*&* This class has been generated on 18.09.2025 18:02:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_STOCK_ADJ_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  StockAdjustmentItemSet
*-------------------------------------------------------------------------*
      when 'StockAdjustmentItemSet'.
*     Call the entity set generated method
     stockadjustmenti_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

   when others.
     super->/iwbep/if_mgw_appl_srv_runtime~delete_entity(
        EXPORTING
          iv_entity_name = iv_entity_name
          iv_entity_set_name = iv_entity_set_name
          iv_source_name = iv_source_name
          it_key_tab = it_key_tab
          it_navigation_path = it_navigation_path
 ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_GETENTITY_BASE
*&* This class has been generated  on 18.09.2025 18:02:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_STOCK_ADJ_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA stockadjustmenti_get_entity TYPE zcl_z_ewm_stock_adj_mpc=>ts_stockadjustmentitem.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  StockAdjustmentItemSet
*-------------------------------------------------------------------------*
      WHEN 'StockAdjustmentItemSet'.
*     Call the entity set generated method
          stockadjustmenti_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = stockadjustmenti_get_entity
                         es_response_context = es_response_context
          ).

        IF stockadjustmenti_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = stockadjustmenti_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TMP_ENTITYSET_BASE
*&* This class has been generated on 18.09.2025 18:02:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_STOCK_ADJ_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
 DATA stockadjustmenti_get_entityset TYPE zcl_z_ewm_stock_adj_mpc=>tt_stockadjustmentitem.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  StockAdjustmentItemSet
*-------------------------------------------------------------------------*
   WHEN 'StockAdjustmentItemSet'.
*     Call the entity set generated method
      stockadjustmenti_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = stockadjustmenti_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = stockadjustmenti_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

    WHEN OTHERS.
      super->/iwbep/if_mgw_appl_srv_runtime~get_entityset(
        EXPORTING
          iv_entity_name = iv_entity_name
          iv_entity_set_name = iv_entity_set_name
          iv_source_name = iv_source_name
          it_filter_select_options = it_filter_select_options
          it_order = it_order
          is_paging = is_paging
          it_navigation_path = it_navigation_path
          it_key_tab = it_key_tab
          iv_filter_string = iv_filter_string
          iv_search_string = iv_search_string
          io_tech_request_context = io_tech_request_context
       IMPORTING
         er_entityset = er_entityset ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_UPD_ENTITY_BASE
*&* This class has been generated on 18.09.2025 18:02:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_STOCK_ADJ_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA stockadjustmenti_update_entity TYPE zcl_z_ewm_stock_adj_mpc=>ts_stockadjustmentitem.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  StockAdjustmentItemSet
*-------------------------------------------------------------------------*
      WHEN 'StockAdjustmentItemSet'.
*     Call the entity set generated method
          stockadjustmenti_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = stockadjustmenti_update_entity
          ).
       IF stockadjustmenti_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = stockadjustmenti_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~update_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             io_data_provider   = io_data_provider
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~COMMIT_WORK.
* Call RFC commit work functionality
DATA lt_message      TYPE bapiret2. "#EC NEEDED
DATA lv_message_text TYPE BAPI_MSG.
DATA lo_logger       TYPE REF TO /iwbep/cl_cos_logger.
DATA lv_subrc        TYPE syst-subrc.

lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

  IF iv_rfc_dest IS INITIAL OR iv_rfc_dest EQ 'NONE'.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
      wait   = abap_true
    IMPORTING
      return = lt_message.
  ELSE.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      DESTINATION iv_rfc_dest
    EXPORTING
      wait                  = abap_true
    IMPORTING
      return                = lt_message
    EXCEPTIONS
      communication_failure = 1000 MESSAGE lv_message_text
      system_failure        = 1001 MESSAGE lv_message_text
      OTHERS                = 1002.

  IF sy-subrc <> 0.
    lv_subrc = sy-subrc.
    /iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
        EXPORTING
          iv_subrc            = lv_subrc
          iv_exp_message_text = lv_message_text
          io_logger           = lo_logger ).
  ENDIF.
  ENDIF.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~GET_GENERATION_STRATEGY.
* Get generation strategy
  rv_generation_strategy = '1'.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~LOG_MESSAGE.
* Log message in the application log
DATA lo_logger TYPE REF TO /iwbep/cl_cos_logger.
DATA lv_text TYPE /iwbep/sup_msg_longtext.

  MESSAGE ID iv_msg_id TYPE iv_msg_type NUMBER iv_msg_number
    WITH iv_msg_v1 iv_msg_v2 iv_msg_v3 iv_msg_v4 INTO lv_text.

  lo_logger = mo_context->get_logger( ).
  lo_logger->log_message(
    EXPORTING
     iv_msg_type   = iv_msg_type
     iv_msg_id     = iv_msg_id
     iv_msg_number = iv_msg_number
     iv_msg_text   = lv_text
     iv_msg_v1     = iv_msg_v1
     iv_msg_v2     = iv_msg_v2
     iv_msg_v3     = iv_msg_v3
     iv_msg_v4     = iv_msg_v4
     iv_agent      = 'DPC' ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~RFC_EXCEPTION_HANDLING.
* RFC call exception handling
DATA lo_logger  TYPE REF TO /iwbep/cl_cos_logger.

lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

/iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
  EXPORTING
    iv_subrc            = iv_subrc
    iv_exp_message_text = iv_exp_message_text
    io_logger           = lo_logger ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~RFC_SAVE_LOG.
  DATA lo_logger  TYPE REF TO /iwbep/cl_cos_logger.
  DATA lo_message_container TYPE REF TO /iwbep/if_message_container.

  lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).
  lo_message_container = /iwbep/if_mgw_conv_srv_runtime~get_message_container( ).

  " Save the RFC call log in the application log
  /iwbep/cl_sb_gen_dpc_rt_util=>rfc_save_log(
    EXPORTING
      is_return            = is_return
      iv_entity_type       = iv_entity_type
      it_return            = it_return
      it_key_tab           = it_key_tab
      io_logger            = lo_logger
      io_message_container = lo_message_container ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~SET_INJECTION.
* Unit test injection
  IF io_unit IS BOUND.
    mo_injection = io_unit.
  ELSE.
    mo_injection = me.
  ENDIF.
  endmethod.


  method CHECK_SUBSCRIPTION_AUTHORITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'CHECK_SUBSCRIPTION_AUTHORITY'.
  endmethod.


METHOD stockadjustmenti_create_entity.

  DATA: ls_input      TYPE zcl_z_ewm_stock_adj_mpc=>ts_stockadjustmentitem,
        ls_head       TYPE /lime/pi_head_create,
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
        lv_sev_post   TYPE bapi_mtype.

  DATA: lv_matid     TYPE /scwm/de_matid,
        lv_batchid   TYPE /scwm/de_batchid,
        ls_mat_charg TYPE /scwm/s_matid_charg,
        ls_t300_md   TYPE /scwm/s_t300_md,
        ls_lagp      TYPE /scwm/lagp.

  CONSTANTS: lc_act     TYPE /lime/pi_active        VALUE 'A',
             lc_doctyp  TYPE /lime/pi_document_type VALUE 'HS',
             lc_proctyp TYPE /lime/pi_process_type  VALUE 'SCWM',
             lc_ent     TYPE /scwm/de_entitled_role VALUE 'BP'.

*--------------------------------------------------------------------
* 1. Read OData payload
*--------------------------------------------------------------------
  io_data_provider->read_entry_data(
    IMPORTING
      es_data = ls_input ).

*--------------------------------------------------------------------
* 2. Prepare PI Head
*--------------------------------------------------------------------
  ls_head-lgnum        = ls_input-lgnum.
  ls_head-doc_type     = lc_doctyp.
  ls_head-process_type = lc_proctyp.
  ls_head-active       = lc_act.

*--------------------------------------------------------------------
* 3. Resolve MATID and BatchID
*--------------------------------------------------------------------
  IF ls_input-matnr IS NOT INITIAL.
    CALL FUNCTION 'CONVERSION_EXIT_MDLPD_INPUT'
      EXPORTING
        input  = ls_input-matnr
      IMPORTING
        output = lv_matid
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.

  IF ls_input-charg IS NOT INITIAL AND lv_matid IS NOT INITIAL.
    ls_mat_charg-matid = lv_matid.
    ls_mat_charg-charg = ls_input-charg.
    TRY.
        CALL METHOD /scwm/cl_batch_appl=>get_batchid_by_no
          EXPORTING
            iv_lgnum       = ls_input-lgnum
            is_matid_charg = ls_mat_charg
          IMPORTING
            ev_batchid     = lv_batchid.
      CATCH /scwm/cx_batch_precheck.
    ENDTRY.
  ENDIF.

  CALL FUNCTION '/SCWM/T300_MD_READ_SINGLE'
    EXPORTING
      iv_lgnum   = ls_input-lgnum
    IMPORTING
      es_t300_md = ls_t300_md
    EXCEPTIONS
      OTHERS     = 1.

  CALL FUNCTION '/SCWM/LAGP_READ_SINGLE'
    EXPORTING
      iv_lgnum = ls_input-lgnum
      iv_lgpla = ls_input-vlpla
    IMPORTING
      es_lagp  = ls_lagp
    EXCEPTIONS
      OTHERS   = 1.

*--------------------------------------------------------------------
* 4. CREATE PI Document
*--------------------------------------------------------------------
  APPEND INITIAL LINE TO lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).
  GET TIME STAMP FIELD lv_ts.

  <ls_item>-data-doc_type   = lc_doctyp.
  <ls_item>-data-count_date = lv_ts.
  <ls_item>-data-hu_item-huident  = ls_input-vlenr.
  <ls_item>-data-hu_item-lgnum_hu = ls_input-lgnum.
  <ls_item>-data-loc_parent-lgnum = ls_input-lgnum.
  <ls_item>-data-loc_parent-lgpla = ls_input-vlpla.
  <ls_item>-data-loc_parent-lgtyp = ls_lagp-lgtyp.
  <ls_item>-data-stock_item-matid   = lv_matid.
  <ls_item>-data-stock_item-batchid = lv_batchid.
  <ls_item>-data-stock_item-cat     = ls_input-cat.
  <ls_item>-data-stock_item-lgnum_stock = ls_input-lgnum.
  <ls_item>-data-stock_item-owner   = ls_t300_md-entitled.
  <ls_item>-data-stock_item-owner_role    = lc_ent.
  <ls_item>-data-stock_item-entitled      = ls_t300_md-entitled.
  <ls_item>-data-stock_item-entitled_role = lc_ent.
  <ls_item>-data-reason = 'UPLD'.
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
    er_entity-message = 'PI Document not created'.
    RETURN.
  ENDIF.

*--------------------------------------------------------------------
* 5. COUNT PI Document
*--------------------------------------------------------------------
  CLEAR lt_item_count.
  ls_head_count-process_type = lc_proctyp.
  ls_head_count-lgnum        = ls_input-lgnum.

  APPEND INITIAL LINE TO lt_item_count ASSIGNING FIELD-SYMBOL(<ls_cnt>).
  <ls_cnt>-doc_number   = ls_pi_doc-doc_number.
  <ls_cnt>-doc_year     = ls_pi_doc-doc_year.
  <ls_cnt>-item_no      = '1'.
  <ls_cnt>-process_type = lc_proctyp.
  <ls_cnt>-lgnum        = ls_input-lgnum.
  <ls_cnt>-doc_type     = lc_doctyp.
  <ls_cnt>-count_date   = lv_ts.
  <ls_cnt>-count_user   = ls_input-processor.   " <-- FIXED: user from payload
  <ls_cnt>-reason       = 'UPLD'.
  <ls_cnt>-post_item    = abap_true.

* Level 1 HU
  APPEND INITIAL LINE TO <ls_cnt>-t_item_result ASSIGNING FIELD-SYMBOL(<ls_res1>).
  <ls_res1>-data-lvl = '1'.
  <ls_res1>-data-type_item   = 'H'.
  <ls_res1>-data-type_parent = 'L'.
  <ls_res1>-data-hu_item-huident  = ls_input-vlenr.  " <-- FIXED: use VLENR
  <ls_res1>-data-hu_item-lgnum_hu = ls_input-lgnum.
  <ls_res1>-data-loc_parent-lgnum = ls_input-lgnum.
  <ls_res1>-data-loc_parent-lgpla = ls_input-vlpla.
  <ls_res1>-data-loc_parent-lgtyp = ls_lagp-lgtyp.

* Level 2 Stock
  APPEND INITIAL LINE TO <ls_cnt>-t_item_result ASSIGNING FIELD-SYMBOL(<ls_res2>).
  <ls_res2>-data-lvl = '2'.
  <ls_res2>-data-type_item   = 'S'.
  <ls_res2>-data-type_parent = 'H'.
  <ls_res2>-data-hu_parent-lgnum_hu = ls_input-lgnum.
  <ls_res2>-data-hu_parent-huident  = ls_input-vlenr. " <-- FIXED: use VLENR
  <ls_res2>-data-stock_item-matid   = lv_matid.
  <ls_res2>-data-stock_item-batchid = lv_batchid.
  <ls_res2>-data-stock_item-cat     = ls_input-cat.
  <ls_res2>-data-stock_item-lgnum_stock = ls_input-lgnum.
  <ls_res2>-data-stock_item-owner   = ls_t300_md-entitled.
  <ls_res2>-data-stock_item-owner_role    = lc_ent.
  <ls_res2>-data-stock_item-entitled      = ls_t300_md-entitled.
  <ls_res2>-data-stock_item-entitled_role = lc_ent.

  APPEND INITIAL LINE TO <ls_res2>-t_quan ASSIGNING FIELD-SYMBOL(<ls_quan>).
  <ls_quan>-qan_status       = 'C'.
  <ls_quan>-entered_quantity = ls_input-cntqty.
  <ls_quan>-entered_unit     = ls_input-altme.  " <-- FIXED: ensure not empty

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

*--------------------------------------------------------------------
* 6. POST PI Document
*--------------------------------------------------------------------
  CLEAR lt_item_post.
  LOOP AT lt_item_count ASSIGNING <ls_cnt>.
    APPEND INITIAL LINE TO lt_item_post ASSIGNING FIELD-SYMBOL(<ls_post>).
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

*--------------------------------------------------------------------
* 7. Return response
*--------------------------------------------------------------------
  er_entity-lgnum     = ls_input-lgnum.
  er_entity-processor     = ls_input-processor.
  er_entity-vlenr     = ls_input-vlenr.
  er_entity-matnr     = ls_input-matnr.
  er_entity-cntqty    = ls_input-cntqty.
  er_entity-vlpla     = ls_input-vlpla.
  er_entity-charg     = ls_input-charg.
  er_entity-cat       = ls_input-cat.
  er_entity-pi_doc    = ls_pi_doc-doc_number.
  er_entity-pi_year   = ls_pi_doc-doc_year.
  er_entity-message   = 'PI Document created, counted and posted'.

ENDMETHOD.


  method STOCKADJUSTMENTI_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'STOCKADJUSTMENTI_DELETE_ENTITY'.
  endmethod.


  method STOCKADJUSTMENTI_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'STOCKADJUSTMENTI_GET_ENTITY'.
  endmethod.


  method STOCKADJUSTMENTI_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'STOCKADJUSTMENTI_GET_ENTITYSET'.
  endmethod.


  method STOCKADJUSTMENTI_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'STOCKADJUSTMENTI_UPDATE_ENTITY'.
  endmethod.
ENDCLASS.
