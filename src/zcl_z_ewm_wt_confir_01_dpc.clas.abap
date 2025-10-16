class ZCL_Z_EWM_WT_CONFIR_01_DPC definition
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

  methods WHOCONFIRMHEADER_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TS_WHOCONFIRMHEADER1
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WHOCONFIRMHEADER_DELETE_ENTITY
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
  methods WHOCONFIRMHEADER_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TS_WHOCONFIRMHEADER1
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WHOCONFIRMHEADER_GET_ENTITYSET
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
      !ET_ENTITYSET type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TT_WHOCONFIRMHEADER1
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WHOCONFIRMHEADER_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TS_WHOCONFIRMHEADER1
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WTCONFIRMHEADER1_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TS_WTCONFIRMHEADER1
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WTCONFIRMHEADER1_DELETE_ENTITY
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
  methods WTCONFIRMHEADER1_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TS_WTCONFIRMHEADER1
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WTCONFIRMHEADER1_GET_ENTITYSET
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
      !ET_ENTITYSET type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TT_WTCONFIRMHEADER1
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods WTCONFIRMHEADER1_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type ZCL_Z_EWM_WT_CONFIR_01_MPC=>TS_WTCONFIRMHEADER1
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .

  methods CHECK_SUBSCRIPTION_AUTHORITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_WT_CONFIR_01_DPC IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 05.09.2025 02:22:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WT_CONFIR_01_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA wtconfirmheader1_create_entity TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_wtconfirmheader1.
 DATA whoconfirmheader_create_entity TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_whoconfirmheader1.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WTConfirmHeader1Set
*-------------------------------------------------------------------------*
     WHEN 'WTConfirmHeader1Set'.
*     Call the entity set generated method
    wtconfirmheader1_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = wtconfirmheader1_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = wtconfirmheader1_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  WHOConfirmHeader1Set
*-------------------------------------------------------------------------*
     WHEN 'WHOConfirmHeader1Set'.
*     Call the entity set generated method
    whoconfirmheader_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = whoconfirmheader_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = whoconfirmheader_create_entity
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
*&* This class has been generated on 05.09.2025 02:22:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WT_CONFIR_01_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WTConfirmHeader1Set
*-------------------------------------------------------------------------*
      when 'WTConfirmHeader1Set'.
*     Call the entity set generated method
     wtconfirmheader1_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  WHOConfirmHeader1Set
*-------------------------------------------------------------------------*
      when 'WHOConfirmHeader1Set'.
*     Call the entity set generated method
     whoconfirmheader_delete_entity(
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
*&* This class has been generated  on 05.09.2025 02:22:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WT_CONFIR_01_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA wtconfirmheader1_get_entity TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_wtconfirmheader1.
 DATA whoconfirmheader_get_entity TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_whoconfirmheader1.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WTConfirmHeader1Set
*-------------------------------------------------------------------------*
      WHEN 'WTConfirmHeader1Set'.
*     Call the entity set generated method
          wtconfirmheader1_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = wtconfirmheader1_get_entity
                         es_response_context = es_response_context
          ).

        IF wtconfirmheader1_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = wtconfirmheader1_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  WHOConfirmHeader1Set
*-------------------------------------------------------------------------*
      WHEN 'WHOConfirmHeader1Set'.
*     Call the entity set generated method
          whoconfirmheader_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = whoconfirmheader_get_entity
                         es_response_context = es_response_context
          ).

        IF whoconfirmheader_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = whoconfirmheader_get_entity
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
*&* This class has been generated on 05.09.2025 02:22:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WT_CONFIR_01_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
 DATA wtconfirmheader1_get_entityset TYPE zcl_z_ewm_wt_confir_01_mpc=>tt_wtconfirmheader1.
 DATA whoconfirmheader_get_entityset TYPE zcl_z_ewm_wt_confir_01_mpc=>tt_whoconfirmheader1.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WTConfirmHeader1Set
*-------------------------------------------------------------------------*
   WHEN 'WTConfirmHeader1Set'.
*     Call the entity set generated method
      wtconfirmheader1_get_entityset(
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
         et_entityset = wtconfirmheader1_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = wtconfirmheader1_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  WHOConfirmHeader1Set
*-------------------------------------------------------------------------*
   WHEN 'WHOConfirmHeader1Set'.
*     Call the entity set generated method
      whoconfirmheader_get_entityset(
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
         et_entityset = whoconfirmheader_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = whoconfirmheader_get_entityset
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
*&* This class has been generated on 05.09.2025 02:22:53 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_Z_EWM_WT_CONFIR_01_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA wtconfirmheader1_update_entity TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_wtconfirmheader1.
 DATA whoconfirmheader_update_entity TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_whoconfirmheader1.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  WTConfirmHeader1Set
*-------------------------------------------------------------------------*
      WHEN 'WTConfirmHeader1Set'.
*     Call the entity set generated method
          wtconfirmheader1_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = wtconfirmheader1_update_entity
          ).
       IF wtconfirmheader1_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = wtconfirmheader1_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  WHOConfirmHeader1Set
*-------------------------------------------------------------------------*
      WHEN 'WHOConfirmHeader1Set'.
*     Call the entity set generated method
          whoconfirmheader_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = whoconfirmheader_update_entity
          ).
       IF whoconfirmheader_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = whoconfirmheader_update_entity
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


METHOD whoconfirmheader_create_entity.

  "=== Adjust this MPC type to YOUR project ===
  DATA: ls_hdr TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_whoconfirmheader1.

  "=== FM tables (match /SCWM/TO_CONFIRM signature) ===
  DATA: lt_conf       TYPE /scwm/to_conf_tt,
        lt_conf_exc   TYPE /scwm/tt_conf_exc,
        lt_conf_serid TYPE /scwm/tt_conf_serid,
        lt_bapiret    TYPE bapirettab,
        lt_ltap_vb    TYPE /scwm/tt_ltap_vb.

  TYPES: ty_conf_line TYPE LINE OF /scwm/to_conf_tt.
  DATA:  ls_conf      TYPE ty_conf_line.

  DATA: lv_subst       TYPE xfeld,
        lv_update_task TYPE xfeld,
        lv_commit_work TYPE xfeld,
        lv_qname       TYPE uname,
        lv_text        TYPE string.

  DATA: lv_who_db TYPE /scwm/ordim_o-who,
        lv_who_c  TYPE /scwm/ordim_o-who.

  TYPES: BEGIN OF ty_tanum,
           tanum TYPE /scwm/tanum,
         END OF ty_tanum.
  DATA: lt_tanum TYPE STANDARD TABLE OF ty_tanum,
        ls_tanum TYPE ty_tanum.

  " --- NEW for payload logging ---
  DATA: lv_hdr_id  TYPE numc10,
        ls_hdr_rec TYPE zodata_hdr,
        ls_kv      TYPE zodata_kv,
        lv_seqno   TYPE numc7,
        lt_cfg     TYPE TABLE OF zodata_keys_cf1,
        ls_cfg     TYPE zodata_keys_cf1,
        lt_props   TYPE string_table,   " provided property names
        lv_prop    TYPE string.

  "---------------------------------------------------------
  " 1) Read payload into entity structure
  "---------------------------------------------------------
  io_data_provider->read_entry_data( IMPORTING es_data = ls_hdr ).

  " Provided properties (what actually came in the request)
  CALL METHOD io_tech_request_context->get_provided_properties
    IMPORTING
      et_provided_property = lt_props.

  "---------------------------------------------------------
  " 2) Basic validation
  "---------------------------------------------------------
  IF ls_hdr-lgnum IS INITIAL OR ls_hdr-who IS INITIAL.
    ls_hdr-message = 'LGNUM and WHO are required.'.
    er_entity      = ls_hdr.
    RETURN.
  ENDIF.

  "---------------------------------------------------------
  " 3) WHO ALPHA IN
  "---------------------------------------------------------
  CLEAR lv_who_c.
  lv_who_c = ls_hdr-who.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = lv_who_c
    IMPORTING
      output = lv_who_c.
  lv_who_db = lv_who_c.

  "---------------------------------------------------------
  " 4) Header booleans
  "---------------------------------------------------------
  IF ls_hdr-subst = abap_true OR ls_hdr-subst = 'X'.
    lv_subst = 'X'.
  ELSE.
    lv_subst = ' '.
  ENDIF.

  IF ls_hdr-updatetask = abap_true OR ls_hdr-updatetask = 'X'.
    lv_update_task = 'X'.
  ELSE.
    lv_update_task = ' '.
  ENDIF.

  IF ls_hdr-commitwork = abap_true OR ls_hdr-commitwork = 'X'.
    lv_commit_work = 'X'.
  ELSE.
    lv_commit_work = ' '.
  ENDIF.

  lv_qname = sy-uname.

  "---------------------------------------------------------
  " 5) Collect all WTs for this WHO
  "---------------------------------------------------------
  CLEAR lt_tanum.
  SELECT tanum
    FROM /scwm/ordim_o
    INTO TABLE lt_tanum
    WHERE lgnum = ls_hdr-lgnum
      AND who   = lv_who_db.
  IF sy-subrc <> 0 OR lt_tanum IS INITIAL.
    ls_hdr-message = 'No WTs found for WHO.'.
    er_entity      = ls_hdr.
    RETURN.
  ENDIF.

  SORT lt_tanum BY tanum.
  DELETE ADJACENT DUPLICATES FROM lt_tanum COMPARING tanum.

  "---------------------------------------------------------
  " 6) Build IT_CONF
  "---------------------------------------------------------
  CLEAR lt_conf.
  LOOP AT lt_tanum INTO ls_tanum.
    CLEAR ls_conf.
    ls_conf-tanum = ls_tanum-tanum.
    ls_conf-squit = 'X'.
    APPEND ls_conf TO lt_conf.
  ENDLOOP.

  "---------------------------------------------------------
  " 7) Call /SCWM/TO_CONFIRM
  "---------------------------------------------------------
  CALL FUNCTION '/SCWM/TO_CONFIRM'
    EXPORTING
      iv_lgnum         = ls_hdr-lgnum
      iv_subst         = lv_subst
      iv_qname         = lv_qname
      iv_creto         = space
      iv_wtcode        = space
      iv_update_task   = lv_update_task
      iv_commit_work   = lv_commit_work
      iv_processor_det = space
      it_conf          = lt_conf
      it_conf_exc      = lt_conf_exc
      it_conf_serid    = lt_conf_serid
    IMPORTING
      et_ltap_vb       = lt_ltap_vb
      et_bapiret       = lt_bapiret
    EXCEPTIONS
      OTHERS           = 1.

  IF sy-subrc <> 0.
    CLEAR lv_text.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
            INTO lv_text.
    IF lv_text IS INITIAL.
      lv_text = 'TO_CONFIRM failed (parameter mismatch or runtime error).' .
    ENDIF.
    ls_hdr-message = lv_text.
    er_entity      = ls_hdr.
    RETURN.
  ENDIF.

  "---------------------------------------------------------
  " 8) Return first BAPIRET message (if any)
  "---------------------------------------------------------
  DATA ls_ret TYPE bapiret2.
  READ TABLE lt_bapiret INTO ls_ret INDEX 1.
  IF sy-subrc = 0.
    ls_hdr-message = ls_ret-message.
  ENDIF.

  "---------------------------------------------------------
  " 9) Persist header record
  "---------------------------------------------------------
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01'
      object      = 'ZODATAHDR'
    IMPORTING
      number      = lv_hdr_id
    EXCEPTIONS
      OTHERS      = 1.

  CLEAR ls_hdr_rec.
  ls_hdr_rec-mandt     = sy-mandt.
  ls_hdr_rec-hdr_id    = lv_hdr_id.
  ls_hdr_rec-timestamp = sy-datum * 1000000 + sy-uzeit.
  ls_hdr_rec-lgnum     = ls_hdr-lgnum.
  ls_hdr_rec-who       = ls_hdr-who.
  ls_hdr_rec-userid    = sy-uname.
  ls_hdr_rec-odata_srv = 'Z_EWM_WT_CONFIRMATION1_SRV'.
  INSERT zodata_hdr FROM ls_hdr_rec.

  "---------------------------------------------------------
  " 10) Persist key/value pairs dynamically
  "---------------------------------------------------------
  lv_seqno = 0.
  DEFINE add_kv_local.
    ADD 1 TO lv_seqno.
    CLEAR ls_kv.
    ls_kv-mandt     = sy-mandt.
    ls_kv-hdr_id    = lv_hdr_id.
    ls_kv-seqno     = lv_seqno.
    ls_kv-key_name  = &1.
    ls_kv-key_value = &2.
    INSERT zodata_kv FROM ls_kv.
  END-OF-DEFINITION.

  " Load config of active keys
  SELECT *
    FROM zodata_keys_cf1
    INTO TABLE lt_cfg
    WHERE odata_srv = 'Z_EWM_WT_CONFIRMATION1_SRV'
      AND active    = 'X'.

  SORT lt_cfg BY log_key.

  LOOP AT lt_cfg INTO ls_cfg.
    " Check if property was provided in payload
    READ TABLE lt_props INTO lv_prop WITH KEY table_line = ls_cfg-log_key.
    IF sy-subrc = 0.
      " Get value dynamically from ls_hdr
      ASSIGN COMPONENT ls_cfg-log_key OF STRUCTURE ls_hdr TO FIELD-SYMBOL(<lv_val>).
      IF sy-subrc = 0 AND <lv_val> IS ASSIGNED AND <lv_val> IS NOT INITIAL.
        add_kv_local ls_cfg-log_key <lv_val>.
      ENDIF.
    ENDIF.
  ENDLOOP.

  CALL FUNCTION 'DB_COMMIT'.

  er_entity = ls_hdr.

ENDMETHOD.


  method WHOCONFIRMHEADER_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WHOCONFIRMHEADER_DELETE_ENTITY'.
  endmethod.


  method WHOCONFIRMHEADER_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WHOCONFIRMHEADER_GET_ENTITY'.
  endmethod.


  method WHOCONFIRMHEADER_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WHOCONFIRMHEADER_GET_ENTITYSET'.
  endmethod.


  method WHOCONFIRMHEADER_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WHOCONFIRMHEADER_UPDATE_ENTITY'.
  endmethod.


METHOD wtconfirmheader1_create_entity.

  "=== MPC header type (adjust to your MPC class/type if different)
  DATA: ls_hdr TYPE zcl_z_ewm_wt_confir_01_mpc=>ts_wtconfirmheader1.

  "=== Use FM table types (no hard-coded line structures)
  DATA: lt_conf       TYPE /scwm/to_conf_tt,
        lt_conf_exc   TYPE /scwm/tt_conf_exc,
        lt_conf_serid TYPE /scwm/tt_conf_serid,
        lt_bapiret    TYPE bapirettab,
        lt_ltap_vb    TYPE /scwm/tt_ltap_vb.

  TYPES: ty_conf_line     TYPE LINE OF /scwm/to_conf_tt,
         ty_conf_exc_line TYPE LINE OF /scwm/tt_conf_exc.

  DATA: ls_conf     TYPE ty_conf_line,
        ls_conf_exc TYPE ty_conf_exc_line,
        ls_ret      TYPE bapiret2.

  DATA: lv_subst       TYPE xfeld,
        lv_update_task TYPE xfeld,
        lv_commit_work TYPE xfeld,
        lv_qname       TYPE uname,
        lv_text        TYPE string.

  " --- KEY/VALUE LOGGING variables (added) ---
  DATA: lv_hdr_id  TYPE numc10,
        ls_hdr_rec TYPE zodata_hdr,
        ls_kv      TYPE zodata_kv,
        lv_seqno   TYPE numc7,
        lt_cfg     TYPE TABLE OF zodata_keys_cf1,
        ls_cfg     TYPE zodata_keys_cf1,
        lt_props   TYPE string_table,   " provided property names
        lv_prop    TYPE string.
  FIELD-SYMBOLS: <lv_val> TYPE any.

  " 1) Read header
  io_data_provider->read_entry_data( IMPORTING es_data = ls_hdr ).

  " Provided properties (names actually in request) - added
  CALL METHOD io_tech_request_context->get_provided_properties
    IMPORTING
      et_provided_property = lt_props.

  " 2) Convert booleans to XFELD
  IF ls_hdr-subst = abap_true OR ls_hdr-subst = 'X'.
    lv_subst = 'X'.
  ELSE.
    lv_subst = ' '.
  ENDIF.
  IF ls_hdr-updatetask = abap_true OR ls_hdr-updatetask = 'X'.
    lv_update_task = 'X'.
  ELSE.
    lv_update_task = ' '.
  ENDIF.
  IF ls_hdr-commitwork = abap_true OR ls_hdr-commitwork = 'X'.
    lv_commit_work = 'X'.
  ELSE.
    lv_commit_work = ' '.
  ENDIF.
  lv_qname = sy-uname.

  " 3) Get inline Items XML from header string property
  DATA: lv_xml TYPE string.
  FIELD-SYMBOLS: <fs_itemsxml> TYPE any.
  CLEAR lv_xml.
  ASSIGN COMPONENT 'ITEMSXML' OF STRUCTURE ls_hdr TO <fs_itemsxml>.
  IF sy-subrc <> 0. ASSIGN COMPONENT 'ItemsXml' OF STRUCTURE ls_hdr TO <fs_itemsxml>. ENDIF.
  IF sy-subrc <> 0. ASSIGN COMPONENT 'ItemsXML' OF STRUCTURE ls_hdr TO <fs_itemsxml>. ENDIF.
  IF sy-subrc <> 0. ASSIGN COMPONENT 'ITEMS'    OF STRUCTURE ls_hdr TO <fs_itemsxml>. ENDIF.
  IF <fs_itemsxml> IS ASSIGNED.
    lv_xml = <fs_itemsxml>.
  ENDIF.

  " 4) Parse <items><item>…</item></items> with iXML (older-stack safe)
  TYPES: BEGIN OF ty_item,
           tanum TYPE string,
           papos TYPE string,
           nista TYPE string,
           altme TYPE string,
           ndifa TYPE string,
           squit TYPE string,
           nlpla TYPE string,
           charg TYPE string,
           excc  TYPE string,
           vlenr TYPE string,
           nlenr TYPE string,
         END OF ty_item.
  TYPES: tt_item TYPE STANDARD TABLE OF ty_item WITH DEFAULT KEY.

  DATA: lt_items TYPE tt_item,
        ls_item  TYPE ty_item.

  IF lv_xml IS NOT INITIAL.
    DATA: lo_ixml          TYPE REF TO if_ixml,
          lo_streamfactory TYPE REF TO if_ixml_stream_factory,
          lo_istream       TYPE REF TO if_ixml_istream,
          lo_doc           TYPE REF TO if_ixml_document,
          lo_parser        TYPE REF TO if_ixml_parser,
          lo_root          TYPE REF TO if_ixml_node,
          lo_node_item     TYPE REF TO if_ixml_node,
          lo_node_field    TYPE REF TO if_ixml_node,
          lo_textnode      TYPE REF TO if_ixml_node,
          lv_name          TYPE string,
          lv_value         TYPE string,
          lv_rootname      TYPE string.

    lo_ixml          = cl_ixml=>create( ).
    lo_streamfactory = lo_ixml->create_stream_factory( ).
    lo_istream       = lo_streamfactory->create_istream_string( lv_xml ).
    lo_doc           = lo_ixml->create_document( ).
    lo_parser        = lo_ixml->create_parser(
                         stream_factory = lo_streamfactory
                         istream        = lo_istream
                         document       = lo_doc ).

    IF lo_parser->parse( ) = 0.
      lo_root = lo_doc->get_root_element( ).
      IF lo_root IS BOUND.
        lv_rootname = lo_root->get_name( ).
        TRANSLATE lv_rootname TO LOWER CASE.
        IF lv_rootname = 'items'.

          lo_node_item = lo_root->get_first_child( ).
          WHILE lo_node_item IS BOUND.
            IF lo_node_item->get_type( ) = if_ixml_node=>co_node_element.
              lv_name = lo_node_item->get_name( ).
              TRANSLATE lv_name TO LOWER CASE.
              IF lv_name = 'item'.
                CLEAR ls_item.

                lo_node_field = lo_node_item->get_first_child( ).
                WHILE lo_node_field IS BOUND.
                  IF lo_node_field->get_type( ) = if_ixml_node=>co_node_element.
                    lv_name = lo_node_field->get_name( ).
                    TRANSLATE lv_name TO LOWER CASE.
                    CLEAR lv_value.
                    lo_textnode = lo_node_field->get_first_child( ).
                    IF lo_textnode IS BOUND AND lo_textnode->get_type( ) = if_ixml_node=>co_node_text.
                      lv_value = lo_textnode->get_value( ).
                    ENDIF.

                    IF lv_name = 'tanum'. ls_item-tanum = lv_value. ENDIF.
                    IF lv_name = 'papos'. ls_item-papos = lv_value. ENDIF.
                    IF lv_name = 'nista'. ls_item-nista = lv_value. ENDIF.
                    IF lv_name = 'altme'. ls_item-altme = lv_value. ENDIF.
                    IF lv_name = 'ndifa'. ls_item-ndifa = lv_value. ENDIF.
                    IF lv_name = 'squit'. ls_item-squit = lv_value. ENDIF.
                    IF lv_name = 'nlpla'. ls_item-nlpla = lv_value. ENDIF.
                    IF lv_name = 'charg'. ls_item-charg = lv_value. ENDIF.
                    IF lv_name = 'excc'.  ls_item-excc  = lv_value. ENDIF.
                    IF lv_name = 'vlenr'. ls_item-vlenr  = lv_value. ENDIF.
                    IF lv_name = 'nlenr'. ls_item-nlenr  = lv_value. ENDIF.
                  ENDIF.
                  lo_node_field = lo_node_field->get_next( ).
                ENDWHILE.

                APPEND ls_item TO lt_items.
              ENDIF.
            ENDIF.
            lo_node_item = lo_node_item->get_next( ).
          ENDWHILE.

        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  " 5) Map parsed items -> IT_CONF / IT_CONF_EXC
  DATA: lv_bool        TYPE string,
        lv_cnt         TYPE i,
        lv_batchid_x16 TYPE /scwm/de_batchid.

  " --- new constants / locals for HU padding
  CONSTANTS: c_hu_len TYPE i VALUE 20.      " EWM HU length (20 chars)
  DATA: lv_tmp_hu  TYPE string,
        lv_pad_len TYPE i,
        lv_zeros   TYPE string.

  LOOP AT lt_items INTO ls_item.
    CLEAR: ls_conf, ls_conf_exc, lv_batchid_x16.

    IF ls_item-tanum IS NOT INITIAL. ls_conf-tanum = ls_item-tanum. ENDIF.
    IF ls_item-papos IS NOT INITIAL. ls_conf-papos = ls_item-papos. ENDIF.

    lv_bool = ls_item-squit.
    TRANSLATE lv_bool TO LOWER CASE.
    IF lv_bool = 'true' OR lv_bool = 'x'.
      ls_conf-squit = 'X'.
      ls_conf-nista = 0.
      ls_conf-ndifa = 0.
      IF ls_item-altme IS NOT INITIAL. ls_conf-altme = ls_item-altme. ENDIF.
    ELSE.
      IF ls_item-nista IS NOT INITIAL. ls_conf-nista = ls_item-nista. ENDIF.
      IF ls_item-ndifa IS NOT INITIAL. ls_conf-ndifa = ls_item-ndifa. ENDIF.
      IF ls_item-altme IS NOT INITIAL. ls_conf-altme = ls_item-altme. ENDIF.

      " --- sanitize and pad VLENR ---
      IF ls_item-vlenr IS NOT INITIAL.
        lv_tmp_hu = ls_item-vlenr.
        CONDENSE lv_tmp_hu NO-GAPS.
        TRANSLATE lv_tmp_hu TO UPPER CASE.
        " compute padding required
        lv_pad_len = c_hu_len - strlen( lv_tmp_hu ).
        IF lv_pad_len > 0.
          lv_zeros = ''.
          DO lv_pad_len TIMES.
            CONCATENATE lv_zeros '0' INTO lv_zeros.
          ENDDO.
          CONCATENATE lv_zeros lv_tmp_hu INTO lv_tmp_hu.
        ENDIF.
        ls_conf-vlenr = lv_tmp_hu.
      ENDIF.

      " --- sanitize and pad NLENR ---
      IF ls_item-nlenr IS NOT INITIAL.
        lv_tmp_hu = ls_item-nlenr.
        CONDENSE lv_tmp_hu NO-GAPS.
        TRANSLATE lv_tmp_hu TO UPPER CASE.
        lv_pad_len = c_hu_len - strlen( lv_tmp_hu ).
        IF lv_pad_len > 0.
          lv_zeros = ''.
          DO lv_pad_len TIMES.
            CONCATENATE lv_zeros '0' INTO lv_zeros.
          ENDDO.
          CONCATENATE lv_zeros lv_tmp_hu INTO lv_tmp_hu.
        ENDIF.
        ls_conf-nlenr = lv_tmp_hu.
      ENDIF.

    ENDIF.

    IF ls_item-nlpla IS NOT INITIAL. ls_conf-nlpla = ls_item-nlpla. ENDIF.

    IF ls_item-charg IS NOT INITIAL.
      CLEAR lv_batchid_x16.
      SELECT SINGLE batchid
        FROM /scwm/ordim_o
        INTO lv_batchid_x16
        WHERE lgnum = ls_hdr-lgnum
          AND tanum = ls_conf-tanum.
      IF sy-subrc = 0 AND lv_batchid_x16 IS NOT INITIAL.
        ls_conf-batchid = lv_batchid_x16.
      ENDIF.
    ENDIF.

    APPEND ls_conf TO lt_conf.

    IF ls_item-excc IS NOT INITIAL.
      CLEAR ls_conf_exc.
      ls_conf_exc-tanum   = ls_conf-tanum.
      ls_conf_exc-papos   = ls_conf-papos.
      ls_conf_exc-exccode = ls_item-excc.
      APPEND ls_conf_exc TO lt_conf_exc.
    ENDIF.
  ENDLOOP.

  DESCRIBE TABLE lt_conf LINES lv_cnt.
  IF lv_cnt = 0.
    ls_hdr-itemsxml = 'No items parsed from ItemsXml.'.
    er_entity = ls_hdr.
    RETURN.
  ENDIF.

  " 6) Call FM with EXPORTING/IMPORTING (no TABLES!)
  CALL FUNCTION '/SCWM/TO_CONFIRM'
    EXPORTING
      iv_lgnum         = ls_hdr-lgnum
      iv_subst         = lv_subst
      iv_qname         = lv_qname
      iv_creto         = space
      iv_wtcode        = space
      iv_update_task   = lv_update_task
      iv_commit_work   = lv_commit_work
      iv_processor_det = space
      it_conf          = lt_conf
      it_conf_exc      = lt_conf_exc
      it_conf_serid    = lt_conf_serid
    IMPORTING
      et_ltap_vb       = lt_ltap_vb
      et_bapiret       = lt_bapiret
    EXCEPTIONS
      OTHERS           = 1.

  IF sy-subrc <> 0.
    CLEAR lv_text.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
            INTO lv_text.
    IF lv_text IS INITIAL.
      lv_text = 'TO_CONFIRM failed (parameter mismatch or runtime error).' .
    ENDIF.
    ls_hdr-itemsxml = lv_text.
    er_entity = ls_hdr.
    RETURN.
  ENDIF.

  READ TABLE lt_bapiret INTO ls_ret INDEX 1.
  IF sy-subrc = 0.
    ls_hdr-itemsxml = ls_ret-message.
  ENDIF.

  " ------------------ ADD KEY-VALUE PERSISTENCE BLOCK BELOW (minimal insertion) ------------------

  " 7) Persist header record for key/value logging
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01'
      object      = 'ZODATAHDR'
    IMPORTING
      number      = lv_hdr_id
    EXCEPTIONS
      OTHERS      = 1.

  CLEAR ls_hdr_rec.
  ls_hdr_rec-mandt     = sy-mandt.
  ls_hdr_rec-hdr_id    = lv_hdr_id.
  ls_hdr_rec-timestamp = sy-datum * 1000000 + sy-uzeit.
  ls_hdr_rec-lgnum     = ls_hdr-lgnum.
  ls_hdr_rec-who       = ls_hdr-who.
  ls_hdr_rec-userid    = sy-uname.
  ls_hdr_rec-odata_srv = 'Z_EWM_WT_CONFIRMATION1_SRV'.
  INSERT zodata_hdr FROM ls_hdr_rec.

  " helper macro to insert KV rows
  lv_seqno = 0.
  DEFINE add_kv_local.
    ADD 1 TO lv_seqno.
    CLEAR ls_kv.
    ls_kv-mandt     = sy-mandt.
    ls_kv-hdr_id    = lv_hdr_id.
    ls_kv-seqno     = lv_seqno.
    ls_kv-key_name  = &1.
    ls_kv-key_value = &2.
    INSERT zodata_kv FROM ls_kv.
  END-OF-DEFINITION.

  " Load config of active keys
  SELECT *
    FROM zodata_keys_cf1
    INTO TABLE lt_cfg
    WHERE odata_srv = 'Z_EWM_WT_CONFIRMATION1_SRV'
      AND active    = 'X'.

  SORT lt_cfg BY log_key.

  LOOP AT lt_cfg INTO ls_cfg.
    " Check if property was provided in payload
    READ TABLE lt_props INTO lv_prop WITH KEY table_line = ls_cfg-log_key.
    IF sy-subrc = 0.
      " Get value dynamically from ls_hdr
      ASSIGN COMPONENT ls_cfg-log_key OF STRUCTURE ls_hdr TO <lv_val>.
      IF sy-subrc = 0 AND <lv_val> IS ASSIGNED AND <lv_val> IS NOT INITIAL.
        add_kv_local ls_cfg-log_key <lv_val>.
      ENDIF.
    ENDIF.
  ENDLOOP.

  CALL FUNCTION 'DB_COMMIT'.

  " -----------------------------------------------------------------------------------------------

  er_entity = ls_hdr.

ENDMETHOD.


  method WTCONFIRMHEADER1_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WTCONFIRMHEADER1_DELETE_ENTITY'.
  endmethod.


  method WTCONFIRMHEADER1_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WTCONFIRMHEADER1_GET_ENTITY'.
  endmethod.


  method WTCONFIRMHEADER1_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WTCONFIRMHEADER1_GET_ENTITYSET'.
  endmethod.


  method WTCONFIRMHEADER1_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'WTCONFIRMHEADER1_UPDATE_ENTITY'.
  endmethod.
ENDCLASS.
