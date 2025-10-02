class ZCL_Z_EWM_WHO_PROCESS_DPC definition
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

  methods WAREHOUSEORDERSE_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WHO_PROCESS_MPC=>TS_WAREHOUSEORDER
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSEORDERSE_DELETE_ENTITY
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
  methods WAREHOUSEORDERSE_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WHO_PROCESS_MPC=>TS_WAREHOUSEORDER
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSEORDERSE_GET_ENTITYSET
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
      !ET_ENTITYSET type ZCL_Z_EWM_WHO_PROCESS_MPC=>TT_WAREHOUSEORDER
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSEORDERSE_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WHO_PROCESS_MPC=>TS_WAREHOUSEORDER
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSETASKSET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WHO_PROCESS_MPC=>TS_WAREHOUSETASK
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSETASKSET_DELETE_ENTITY
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
  methods WAREHOUSETASKSET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WHO_PROCESS_MPC=>TS_WAREHOUSETASK
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSETASKSET_GET_ENTITYSET
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
      !ET_ENTITYSET type ZCL_Z_EWM_WHO_PROCESS_MPC=>TT_WAREHOUSETASK
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WAREHOUSETASKSET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WHO_PROCESS_MPC=>TS_WAREHOUSETASK
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .

  methods CHECK_SUBSCRIPTION_AUTHORITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_WHO_PROCESS_DPC IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 02.10.2025 19:23:01 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WHO_PROCESS_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA warehouseorderse_create_entity TYPE zcl_z_ewm_who_process_mpc=>ts_warehouseorder.
 DATA warehousetaskset_create_entity TYPE zcl_z_ewm_who_process_mpc=>ts_warehousetask.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseOrderSet
*-------------------------------------------------------------------------*
     WHEN 'WarehouseOrderSet'.
*     Call the entity set generated method
    warehouseorderse_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = warehouseorderse_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = warehouseorderse_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseTaskSet
*-------------------------------------------------------------------------*
     WHEN 'WarehouseTaskSet'.
*     Call the entity set generated method
    warehousetaskset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = warehousetaskset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = warehousetaskset_create_entity
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
*&* This class has been generated on 02.10.2025 19:23:01 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WHO_PROCESS_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseOrderSet
*-------------------------------------------------------------------------*
      when 'WarehouseOrderSet'.
*     Call the entity set generated method
     warehouseorderse_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseTaskSet
*-------------------------------------------------------------------------*
      when 'WarehouseTaskSet'.
*     Call the entity set generated method
     warehousetaskset_delete_entity(
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
*&* This class has been generated  on 02.10.2025 19:23:01 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WHO_PROCESS_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA warehouseorderse_get_entity TYPE zcl_z_ewm_who_process_mpc=>ts_warehouseorder.
 DATA warehousetaskset_get_entity TYPE zcl_z_ewm_who_process_mpc=>ts_warehousetask.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseOrderSet
*-------------------------------------------------------------------------*
      WHEN 'WarehouseOrderSet'.
*     Call the entity set generated method
          warehouseorderse_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = warehouseorderse_get_entity
                         es_response_context = es_response_context
          ).

        IF warehouseorderse_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = warehouseorderse_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseTaskSet
*-------------------------------------------------------------------------*
      WHEN 'WarehouseTaskSet'.
*     Call the entity set generated method
          warehousetaskset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = warehousetaskset_get_entity
                         es_response_context = es_response_context
          ).

        IF warehousetaskset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = warehousetaskset_get_entity
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
*&* This class has been generated on 02.10.2025 19:23:01 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WHO_PROCESS_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
 DATA warehouseorderse_get_entityset TYPE zcl_z_ewm_who_process_mpc=>tt_warehouseorder.
 DATA warehousetaskset_get_entityset TYPE zcl_z_ewm_who_process_mpc=>tt_warehousetask.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseOrderSet
*-------------------------------------------------------------------------*
   WHEN 'WarehouseOrderSet'.
*     Call the entity set generated method
      warehouseorderse_get_entityset(
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
         et_entityset = warehouseorderse_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = warehouseorderse_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseTaskSet
*-------------------------------------------------------------------------*
   WHEN 'WarehouseTaskSet'.
*     Call the entity set generated method
      warehousetaskset_get_entityset(
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
         et_entityset = warehousetaskset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = warehousetaskset_get_entityset
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
*&* This class has been generated on 02.10.2025 19:23:01 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WHO_PROCESS_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA warehouseorderse_update_entity TYPE zcl_z_ewm_who_process_mpc=>ts_warehouseorder.
 DATA warehousetaskset_update_entity TYPE zcl_z_ewm_who_process_mpc=>ts_warehousetask.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseOrderSet
*-------------------------------------------------------------------------*
      WHEN 'WarehouseOrderSet'.
*     Call the entity set generated method
          warehouseorderse_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = warehouseorderse_update_entity
          ).
       IF warehouseorderse_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = warehouseorderse_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  WarehouseTaskSet
*-------------------------------------------------------------------------*
      WHEN 'WarehouseTaskSet'.
*     Call the entity set generated method
          warehousetaskset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = warehousetaskset_update_entity
          ).
       IF warehousetaskset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = warehousetaskset_update_entity
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


  method WAREHOUSEORDERSE_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WAREHOUSEORDERSE_CREATE_ENTITY'.
  endmethod.


  method WAREHOUSEORDERSE_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WAREHOUSEORDERSE_DELETE_ENTITY'.
  endmethod.


METHOD warehouseorderse_get_entity.

  "-----------------------------
  " Data declarations
  "-----------------------------
  DATA: lt_whoid     TYPE /scwm/tt_whoid,
        ls_whoid     TYPE /scwm/de_who,
        lv_lgnum     TYPE /scwm/lgnum,
        lv_whoid_val TYPE /scwm/de_who,
        lo_log       TYPE REF TO /scwm/cl_log,
        ls_who_int   TYPE /scwm/s_who_int,
        ls_who       TYPE zcl_z_ewm_who_process_mpc=>ts_warehouseorder,
        lt_whorange  TYPE rsds_frange_t,
        lv_who_guid  TYPE /scwm/de_who_id.

  CLEAR: lv_who_guid, lt_whorange.

  "-----------------------------
  " 1) Read key values from IT_KEY_TAB
  "-----------------------------
  LOOP AT it_key_tab INTO DATA(ls_key).
    CASE to_upper( ls_key-name ).
      WHEN 'LGNUM'.
        lv_lgnum = ls_key-value.
      WHEN 'WHO'.
        lv_whoid_val = ls_key-value.
    ENDCASE.
  ENDLOOP.

  "-----------------------------
  " 2) Prepare IT_WHOID for FM
  "-----------------------------
  CLEAR lt_whoid.
  IF lv_whoid_val IS NOT INITIAL.
    ls_whoid = lv_whoid_val.
    APPEND ls_whoid TO lt_whoid.
  ENDIF.

  "-----------------------------
  " 3) Call standard FM /SCWM/WHO_GET
  "-----------------------------
  CLEAR ls_who_int.

  CALL FUNCTION '/SCWM/WHO_GET'
    EXPORTING
      iv_lgnum    = lv_lgnum
      io_prot     = lo_log
      iv_to       = space
      iv_lock_who = space
      iv_lock_to  = space
      iv_whoid    = lv_whoid_val
      iv_who_guid = lv_who_guid
      it_whorange = lt_whorange
      it_whoid    = lt_whoid
    IMPORTING
      es_who      = ls_who_int
    EXCEPTIONS
      not_found   = 1
      OTHERS      = 2.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = |WHO { lv_whoid_val } not found|.
  ENDIF.

  "-----------------------------
  " 4) Map ES_WHO -> ER_ENTITY
  "-----------------------------
  CLEAR ls_who.
  MOVE-CORRESPONDING ls_who_int TO ls_who.

  " DEC 15 date/time fields → convert to CHAR
  ls_who-createdat      = ls_who_int-created_at.
  ls_who-startedat      = ls_who_int-started_at.
  ls_who-confirmedat    = ls_who_int-confirmed_at.
  ls_who-lsd             = ls_who_int-lsd.
  ls_who-changedat      = ls_who_int-changed_at.
  ls_who-createdatwh   = ls_who_int-created_at_wh.
  ls_who-startedatwh   = ls_who_int-started_at_wh.
  ls_who-lsdwh          = ls_who_int-lsd_wh.
  ls_who-confirmedatwh = ls_who_int-confirmed_at_wh.
  ls_who-changedatwh   = ls_who_int-changed_at_wh.

  "-----------------------------
  " 5) Return entity
  "-----------------------------
  er_entity = ls_who.

ENDMETHOD.


METHOD warehouseorderse_get_entityset.

  "-----------------------------
  " Data declarations
  "-----------------------------
  DATA: lt_entityset TYPE TABLE OF /scwm/who,
        ls_who       TYPE /scwm/who,
        lt_db_who    TYPE TABLE OF /scwm/who,
        ls_db_who    TYPE /scwm/who,
        lv_lgnum     TYPE /scwm/lgnum.

  "-----------------------------
  " 1) Read filters from URI / $filter
  "-----------------------------
  LOOP AT it_filter_select_options INTO DATA(ls_filter).
    CASE to_upper( ls_filter-property ).
      WHEN 'LGNUM'.
        LOOP AT ls_filter-select_options INTO DATA(ls_opt_lgnum).
          lv_lgnum = ls_opt_lgnum-low.
          EXIT. " take first value only
        ENDLOOP.
    ENDCASE.
  ENDLOOP.

  "-----------------------------
  " 2) Select all WHOs for the warehouse
  "-----------------------------
  CLEAR lt_db_who.
  IF lv_lgnum IS NOT INITIAL.
    SELECT * FROM /scwm/who
      INTO TABLE lt_db_who
      WHERE lgnum = lv_lgnum.
  ELSE.
    SELECT * FROM /scwm/who
      INTO TABLE lt_db_who.
  ENDIF.

  "-----------------------------
  " 3) Map DB entries to OData entity
  "    DEC fields → CHAR
  "-----------------------------
  LOOP AT lt_db_who INTO ls_db_who.
    CLEAR ls_who.

    " Direct mapping for CHAR, NUMC, RAW, QUAN
    MOVE-CORRESPONDING ls_db_who TO ls_who.

    " Convert DEC date/time fields to CHAR
    ls_who-created_at      = ls_db_who-created_at.
    ls_who-started_at      = ls_db_who-started_at.
    ls_who-confirmed_at    = ls_db_who-confirmed_at.
    ls_who-lsd             = ls_db_who-lsd.
    ls_who-changed_at      = ls_db_who-changed_at.
    ls_who-created_at_wh   = ls_db_who-created_at_wh.
    ls_who-started_at_wh   = ls_db_who-started_at_wh.
    ls_who-lsd_wh          = ls_db_who-lsd_wh.
    ls_who-confirmed_at_wh = ls_db_who-confirmed_at_wh.
    ls_who-changed_at_wh   = ls_db_who-changed_at_wh.

    " Append to output table
    APPEND ls_who TO lt_entityset.
  ENDLOOP.

  "-----------------------------
  " 4) Return entity set
  "-----------------------------
  et_entityset = lt_entityset.

ENDMETHOD.


  method WAREHOUSEORDERSE_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WAREHOUSEORDERSE_UPDATE_ENTITY'.
  endmethod.


  method WAREHOUSETASKSET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WAREHOUSETASKSET_CREATE_ENTITY'.
  endmethod.


  method WAREHOUSETASKSET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WAREHOUSETASKSET_DELETE_ENTITY'.
  endmethod.


METHOD warehousetaskset_get_entity.

  DATA: ls_task_o TYPE /scwm/ordim_o,
        ls_task_c TYPE /scwm/ordim_c,
        ls_entity TYPE zcl_z_ewm_who_process_mpc_ext=>ts_warehousetask,
        lv_lgnum  TYPE /scwm/lgnum,
        lv_tanum  TYPE /scwm/tanum.

  "----------------------------------------------------
  " Read key values from IT_KEY_TAB
  "----------------------------------------------------
  LOOP AT it_key_tab INTO DATA(ls_key).
    CASE ls_key-name.
      WHEN 'Lgnum'.
        lv_lgnum = ls_key-value.
      WHEN 'Tanum'.
        lv_tanum = ls_key-value.
    ENDCASE.
  ENDLOOP.

  "----------------------------------------------------
  " Try to fetch from ORDIM_O first
  "----------------------------------------------------
  SELECT SINGLE * FROM /scwm/ordim_o
    INTO @ls_task_o
    WHERE lgnum = @lv_lgnum
      AND tanum = @lv_tanum.

  IF sy-subrc = 0.
    MOVE-CORRESPONDING ls_task_o TO ls_entity.
  ELSE.
    "----------------------------------------------------
    " If not found, try from ORDIM_C
    "----------------------------------------------------
    SELECT SINGLE * FROM /scwm/ordim_c
      INTO @ls_task_c
      WHERE lgnum = @lv_lgnum
        AND tanum = @lv_tanum.

    IF sy-subrc = 0.
      MOVE-CORRESPONDING ls_task_c TO ls_entity.
    ELSE.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message = |Warehouse Task { lv_tanum } not found in Warehouse { lv_lgnum }|.
    ENDIF.
  ENDIF.

  "----------------------------------------------------
  " Fix invalid date '00000000' → replace with 20991231
  "----------------------------------------------------
  IF ls_entity-mmimbudatmigration IS INITIAL
     OR ls_entity-mmimbudatmigration = '00000000'.
    ls_entity-mmimbudatmigration = '20991231'.
  ENDIF.

  "----------------------------------------------------
  " Return single entity
  "----------------------------------------------------
  er_entity = ls_entity.

ENDMETHOD.


METHOD warehousetaskset_get_entityset.

  DATA: lt_task_o TYPE TABLE OF /scwm/ordim_o,
        lt_task_c TYPE TABLE OF /scwm/ordim_c,
        lt_task   TYPE TABLE OF /scwm/ordim_o, " target: ORDIM_O structure
        ls_task   TYPE /scwm/ordim_o,
        lv_lgnum  TYPE /scwm/lgnum,
        lv_who    TYPE /scwm/de_who.

  "----------------------------------------------------
  " Parse filters from OData request
  "----------------------------------------------------
  LOOP AT it_filter_select_options INTO DATA(ls_filter).
    CASE ls_filter-property.
      WHEN 'Lgnum'.
        lv_lgnum = ls_filter-select_options[ 1 ]-low.
      WHEN 'Who'.
        lv_who   = ls_filter-select_options[ 1 ]-low.
    ENDCASE.
  ENDLOOP.

  "----------------------------------------------------
  " Fetch all tasks from both ORDIM_O and ORDIM_C
  "----------------------------------------------------
  IF lv_lgnum IS NOT INITIAL AND lv_who IS NOT INITIAL.

    " --- Open Tasks
    SELECT * FROM /scwm/ordim_o
      INTO TABLE @lt_task_o
      WHERE lgnum = @lv_lgnum
        AND who   = @lv_who.

    " --- Completed Tasks
    SELECT * FROM /scwm/ordim_c
      INTO TABLE @lt_task_c
      WHERE lgnum = @lv_lgnum
        AND who   = @lv_who.

    " --- Merge into lt_task with MOVE-CORRESPONDING
    LOOP AT lt_task_c INTO DATA(ls_task_c).
      CLEAR ls_task.
      MOVE-CORRESPONDING ls_task_c TO ls_task.
      APPEND ls_task TO lt_task.
    ENDLOOP.

    APPEND LINES OF lt_task_o TO lt_task.

  ENDIF.

  "----------------------------------------------------
  " Map to OData entityset
  "----------------------------------------------------
  LOOP AT lt_task INTO ls_task.
    DATA(ls_entity) = VALUE zcl_z_ewm_who_process_mpc_ext=>ts_warehousetask( ).
    MOVE-CORRESPONDING ls_task TO ls_entity.

    " Fix invalid date '00000000' → replace with 20991231
    IF ls_task-mmim_budat_migration IS INITIAL
       OR ls_task-mmim_budat_migration = '00000000'.
      ls_entity-mmimbudatmigration = '20991231'.
    ELSE.
      ls_entity-mmimbudatmigration = ls_task-mmim_budat_migration.
    ENDIF.

    APPEND ls_entity TO et_entityset.
  ENDLOOP.

ENDMETHOD.


  method WAREHOUSETASKSET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WAREHOUSETASKSET_UPDATE_ENTITY'.
  endmethod.
ENDCLASS.
