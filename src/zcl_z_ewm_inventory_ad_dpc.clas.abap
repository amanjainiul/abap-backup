class ZCL_Z_EWM_INVENTORY_AD_DPC definition
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

  methods INVENTORYADJUS01_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_INVENTORY_AD_MPC=>TS_INVENTORYADJUSTMENTITEM
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUS01_DELETE_ENTITY
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
  methods INVENTORYADJUS01_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_INVENTORY_AD_MPC=>TS_INVENTORYADJUSTMENTITEM
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUS01_GET_ENTITYSET
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
      !ET_ENTITYSET type ZCL_Z_EWM_INVENTORY_AD_MPC=>TT_INVENTORYADJUSTMENTITEM
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUS01_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_INVENTORY_AD_MPC=>TS_INVENTORYADJUSTMENTITEM
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUSTM_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_INVENTORY_AD_MPC=>TS_INVENTORYADJUSTMENT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUSTM_DELETE_ENTITY
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
  methods INVENTORYADJUSTM_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_INVENTORY_AD_MPC=>TS_INVENTORYADJUSTMENT
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUSTM_GET_ENTITYSET
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
      !ET_ENTITYSET type ZCL_Z_EWM_INVENTORY_AD_MPC=>TT_INVENTORYADJUSTMENT
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVENTORYADJUSTM_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_INVENTORY_AD_MPC=>TS_INVENTORYADJUSTMENT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .

  methods CHECK_SUBSCRIPTION_AUTHORITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_INVENTORY_AD_DPC IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 04.09.2025 19:24:10 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_INVENTORY_AD_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA inventoryadjustm_create_entity TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustment.
 DATA inventoryadjus01_create_entity TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustmentitem.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentSet
*-------------------------------------------------------------------------*
     WHEN 'InventoryAdjustmentSet'.
*     Call the entity set generated method
    inventoryadjustm_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = inventoryadjustm_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = inventoryadjustm_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentItemSet
*-------------------------------------------------------------------------*
     WHEN 'InventoryAdjustmentItemSet'.
*     Call the entity set generated method
    inventoryadjus01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = inventoryadjus01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = inventoryadjus01_create_entity
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
*&* This class has been generated on 04.09.2025 19:24:10 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_INVENTORY_AD_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentSet
*-------------------------------------------------------------------------*
      when 'InventoryAdjustmentSet'.
*     Call the entity set generated method
     inventoryadjustm_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentItemSet
*-------------------------------------------------------------------------*
      when 'InventoryAdjustmentItemSet'.
*     Call the entity set generated method
     inventoryadjus01_delete_entity(
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
*&* This class has been generated  on 04.09.2025 19:24:10 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_INVENTORY_AD_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA inventoryadjustm_get_entity TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustment.
 DATA inventoryadjus01_get_entity TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustmentitem.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentSet
*-------------------------------------------------------------------------*
      WHEN 'InventoryAdjustmentSet'.
*     Call the entity set generated method
          inventoryadjustm_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = inventoryadjustm_get_entity
                         es_response_context = es_response_context
          ).

        IF inventoryadjustm_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = inventoryadjustm_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentItemSet
*-------------------------------------------------------------------------*
      WHEN 'InventoryAdjustmentItemSet'.
*     Call the entity set generated method
          inventoryadjus01_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = inventoryadjus01_get_entity
                         es_response_context = es_response_context
          ).

        IF inventoryadjus01_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = inventoryadjus01_get_entity
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
*&* This class has been generated on 04.09.2025 19:24:10 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_INVENTORY_AD_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
 DATA inventoryadjustm_get_entityset TYPE zcl_z_ewm_inventory_ad_mpc=>tt_inventoryadjustment.
 DATA inventoryadjus01_get_entityset TYPE zcl_z_ewm_inventory_ad_mpc=>tt_inventoryadjustmentitem.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentSet
*-------------------------------------------------------------------------*
   WHEN 'InventoryAdjustmentSet'.
*     Call the entity set generated method
      inventoryadjustm_get_entityset(
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
         et_entityset = inventoryadjustm_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = inventoryadjustm_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentItemSet
*-------------------------------------------------------------------------*
   WHEN 'InventoryAdjustmentItemSet'.
*     Call the entity set generated method
      inventoryadjus01_get_entityset(
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
         et_entityset = inventoryadjus01_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = inventoryadjus01_get_entityset
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
*&* This class has been generated on 04.09.2025 19:24:10 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_INVENTORY_AD_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA inventoryadjustm_update_entity TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustment.
 DATA inventoryadjus01_update_entity TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustmentitem.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentSet
*-------------------------------------------------------------------------*
      WHEN 'InventoryAdjustmentSet'.
*     Call the entity set generated method
          inventoryadjustm_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = inventoryadjustm_update_entity
          ).
       IF inventoryadjustm_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = inventoryadjustm_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  InventoryAdjustmentItemSet
*-------------------------------------------------------------------------*
      WHEN 'InventoryAdjustmentItemSet'.
*     Call the entity set generated method
          inventoryadjus01_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = inventoryadjus01_update_entity
          ).
       IF inventoryadjus01_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = inventoryadjus01_update_entity
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


METHOD inventoryadjus01_create_entity.

  "=== OData item payload ===
  DATA: ls_item TYPE zcl_z_ewm_inventory_ad_mpc=>ts_inventoryadjustmentitem,
        lv_msg  TYPE string,
        lv_ts   TYPE timestampl.

  "=== PI Create ===
  DATA: ls_head_create TYPE /lime/pi_head_create,
        lt_item_create TYPE /lime/pi_t_item_create,
        lt_pi_doc      TYPE /lime/pi_t_item_read,
        ls_pi_doc      TYPE /lime/pi_item_read,
        lt_ret_create  TYPE bapiret2_t,
        ls_ret         TYPE bapiret2,
        lv_sev_create  TYPE bapi_mtype.

  "=== PI Count ===
  DATA: ls_head_count TYPE /lime/pi_head,
        lt_item_count TYPE /lime/pi_t_item_count,
        lt_cnt_doc    TYPE /lime/pi_t_item_read,
        lt_ret_count  TYPE bapiret2_t,
        lv_sev_count  TYPE bapi_mtype.

  "=== PI Post ===
  DATA: lt_post_doc TYPE /lime/pi_t_item_read,
        lt_ret_post TYPE bapiret2_t,
        lv_sev_post TYPE bapi_mtype.

  "=== IDs ===
  DATA: lv_matid     TYPE /scwm/de_matid,
        lv_batchid   TYPE /scwm/de_batchid,
        ls_mat_charg TYPE /scwm/s_matid_charg.

*--------------------------------------------------------------------
* 1) Read payload
*--------------------------------------------------------------------
  io_data_provider->read_entry_data( IMPORTING es_data = ls_item ).
  CLEAR lv_msg.

*--------------------------------------------------------------------
* 2) Resolve MATID and BATCHID
*--------------------------------------------------------------------
  CLEAR lv_matid.
  IF ls_item-matnr IS NOT INITIAL.
    CALL FUNCTION 'CONVERSION_EXIT_MDLPD_INPUT'
      EXPORTING
        input  = ls_item-matnr
      IMPORTING
        output = lv_matid
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.

  CLEAR lv_batchid.
  IF ls_item-charg IS NOT INITIAL AND lv_matid IS NOT INITIAL.
    ls_mat_charg-matid = lv_matid.
    ls_mat_charg-charg = ls_item-charg.
    TRY.
        CALL METHOD /scwm/cl_batch_appl=>get_batchid_by_no
          EXPORTING
            iv_lgnum       = ls_item-lgnum
            is_matid_charg = ls_mat_charg
          IMPORTING
            ev_batchid     = lv_batchid.
      CATCH /scwm/cx_batch_precheck.
        CLEAR lv_batchid.
    ENDTRY.
  ENDIF.

*--------------------------------------------------------------------
* 3) Prepare PI head
*--------------------------------------------------------------------
  CLEAR ls_head_create.
  ls_head_create-lgnum        = ls_item-lgnum.
  ls_head_create-doc_type     = 'HS'.      " adjust if needed
  ls_head_create-process_type = 'SCWM'.
  ls_head_create-active       = 'A'.

*--------------------------------------------------------------------
* 4) Prepare items for CREATE  (/LIME/PI_ITEM_CREATE has DATA-*)
*--------------------------------------------------------------------
  CLEAR lt_item_create.
  APPEND INITIAL LINE TO lt_item_create ASSIGNING FIELD-SYMBOL(<ls_pi_item>).

  GET TIME STAMP FIELD lv_ts.

  <ls_pi_item>-data-doc_type             = 'HS'.
  <ls_pi_item>-data-count_date           = lv_ts.

  " Business keys
  <ls_pi_item>-data-hu_item-huident      = ls_item-vlenr.
  <ls_pi_item>-data-loc_parent-lgpla     = ls_item-vlpla.
  <ls_pi_item>-data-stock_item-cat       = ls_item-cat.

  IF lv_matid IS NOT INITIAL.
    <ls_pi_item>-data-stock_item-matid   = lv_matid.
  ENDIF.
  IF lv_batchid IS NOT INITIAL.
    <ls_pi_item>-data-stock_item-batchid = lv_batchid.
  ENDIF.

  " Optional: reason / block / freeze
  " <ls_pi_item>-data-reason             = 'CNTB'.
  " <ls_pi_item>-data-block_ind          = ' '.
  " <ls_pi_item>-data-freeze_ind         = ' '.

*--------------------------------------------------------------------
* 5) CREATE
*--------------------------------------------------------------------
  CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_CREATE'
    EXPORTING
      is_head       = ls_head_create
      it_item       = lt_item_create
      iv_save_pack  = abap_true
    IMPORTING
      et_pi_doc     = lt_pi_doc
      et_bapiret    = lt_ret_create
      e_rc_severity = lv_sev_create.

  LOOP AT lt_ret_create INTO ls_ret.
    CONCATENATE lv_msg ls_ret-message INTO lv_msg SEPARATED BY '; '.
  ENDLOOP.

  IF lv_sev_create <> 'S'.
    " Echo item on error
    er_entity-vlenr  = ls_item-vlenr.
    er_entity-lgnum  = ls_item-lgnum.
    er_entity-matnr  = ls_item-matnr.
    er_entity-cntqty = ls_item-cntqty.
    er_entity-vlpla  = ls_item-vlpla.
    er_entity-charg  = ls_item-charg.
    er_entity-cat    = ls_item-cat.
    " Optionally also fill dynamic PI fields (if present) as initial
    RETURN.
  ENDIF.

  READ TABLE lt_pi_doc INTO ls_pi_doc INDEX 1.

*--------------------------------------------------------------------
* 6) COUNT  (/LIME/PI_ITEM_COUNT result line has DATA + T_QUAN)
*--------------------------------------------------------------------
  CLEAR ls_head_count.
  ls_head_count-process_type = 'SCWM'.
  ls_head_count-lgnum        = ls_item-lgnum.

  CLEAR lt_item_count.
  APPEND INITIAL LINE TO lt_item_count ASSIGNING FIELD-SYMBOL(<ls_cnt>).

  <ls_cnt>-doc_number = ls_pi_doc-doc_number.
  <ls_cnt>-doc_year   = ls_pi_doc-doc_year.
  <ls_cnt>-item_no    = '1'.
  <ls_cnt>-lgnum      = ls_item-lgnum.
  <ls_cnt>-doc_type   = 'HS'.
  <ls_cnt>-count_user = sy-uname.
  <ls_cnt>-post_item  = abap_true.

  " --- Result line 1: HU (level 1) ---
  APPEND INITIAL LINE TO <ls_cnt>-t_item_result ASSIGNING FIELD-SYMBOL(<ls_res_hu>).
  <ls_res_hu>-data-lvl                      = 1.
  <ls_res_hu>-data-type_item                = 'H'.           " HU
  <ls_res_hu>-data-type_parent              = 'L'.           " Location
  <ls_res_hu>-data-hu_item-huident          = ls_item-vlenr.
  <ls_res_hu>-data-loc_parent-lgpla         = ls_item-vlpla.

  " --- Result line 2: Stock (level 2) ---
  APPEND INITIAL LINE TO <ls_cnt>-t_item_result ASSIGNING FIELD-SYMBOL(<ls_res_stk>).
  <ls_res_stk>-data-lvl                     = 2.
  <ls_res_stk>-data-type_item               = 'S'.           " Stock
  <ls_res_stk>-data-type_parent             = 'H'.           " HU
  <ls_res_stk>-data-hu_parent-huident       = ls_item-vlenr.

  IF lv_matid IS NOT INITIAL.
    <ls_res_stk>-data-stock_item-matid      = lv_matid.
  ENDIF.
  IF lv_batchid IS NOT INITIAL.
    <ls_res_stk>-data-stock_item-batchid    = lv_batchid.
  ENDIF.
  <ls_res_stk>-data-stock_item-cat          = ls_item-cat.

  " Quantity on the stock result line
  APPEND INITIAL LINE TO <ls_res_stk>-t_quan ASSIGNING FIELD-SYMBOL(<ls_quan>).
  <ls_quan>-qan_status                      = 'C'.           " Counted
  <ls_quan>-entered_quantity                = ls_item-cntqty.
  <ls_quan>-entered_unit                    = 'EA'.          " TODO: derive UoM if required

  CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_COUNT'
    EXPORTING
      is_head       = ls_head_count
      it_item       = lt_item_count
      iv_save_pack  = abap_true
    IMPORTING
      et_pi_doc     = lt_cnt_doc
      et_bapiret    = lt_ret_count
      e_rc_severity = lv_sev_count.

  LOOP AT lt_ret_count INTO ls_ret.
    CONCATENATE lv_msg ls_ret-message INTO lv_msg SEPARATED BY '; '.
  ENDLOOP.

*--------------------------------------------------------------------
* 7) POST
*--------------------------------------------------------------------
  CALL FUNCTION '/SCWM/PI_CALL_DOCUMENT_POST'
    EXPORTING
      is_head       = ls_head_count
      iv_save_pack  = abap_true
    IMPORTING
      et_pi_doc     = lt_post_doc
      et_bapiret    = lt_ret_post
      e_rc_severity = lv_sev_post.

  LOOP AT lt_ret_post INTO ls_ret.
    CONCATENATE lv_msg ls_ret-message INTO lv_msg SEPARATED BY '; '.
  ENDLOOP.

*--------------------------------------------------------------------
* 8) Return Item (and PI numbers if fields exist in entity)
*--------------------------------------------------------------------
  er_entity-vlenr  = ls_item-vlenr.
  er_entity-lgnum  = ls_item-lgnum.
  er_entity-matnr  = ls_item-matnr.
  er_entity-cntqty = ls_item-cntqty.
  er_entity-vlpla  = ls_item-vlpla.
  er_entity-charg  = ls_item-charg.
  er_entity-cat    = ls_item-cat.

  " Safely fill PI_DOC / PI_YEAR only if they exist in the entity type
  FIELD-SYMBOLS: <fld> TYPE any.
  ASSIGN COMPONENT 'PI_DOC'  OF STRUCTURE er_entity TO <fld>.
  IF <fld> IS ASSIGNED. <fld> = ls_pi_doc-doc_number. ENDIF.
  ASSIGN COMPONENT 'PI_YEAR' OF STRUCTURE er_entity TO <fld>.
  IF <fld> IS ASSIGNED. <fld> = ls_pi_doc-doc_year.  ENDIF.

ENDMETHOD.


  method INVENTORYADJUS01_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUS01_DELETE_ENTITY'.
  endmethod.


  method INVENTORYADJUS01_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUS01_GET_ENTITY'.
  endmethod.


  method INVENTORYADJUS01_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUS01_GET_ENTITYSET'.
  endmethod.


  method INVENTORYADJUS01_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUS01_UPDATE_ENTITY'.
  endmethod.


  method INVENTORYADJUSTM_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUSTM_CREATE_ENTITY'.
  endmethod.


  method INVENTORYADJUSTM_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUSTM_DELETE_ENTITY'.
  endmethod.


  method INVENTORYADJUSTM_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUSTM_GET_ENTITY'.
  endmethod.


  method INVENTORYADJUSTM_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUSTM_GET_ENTITYSET'.
  endmethod.


  method INVENTORYADJUSTM_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVENTORYADJUSTM_UPDATE_ENTITY'.
  endmethod.
ENDCLASS.
