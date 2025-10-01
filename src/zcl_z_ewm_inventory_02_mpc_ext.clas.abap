class ZCL_Z_EWM_INVENTORY_02_MPC_EXT definition
  public
  inheriting from ZCL_Z_EWM_INVENTORY_02_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_INVENTORY_02_MPC_EXT IMPLEMENTATION.


METHOD define.
  super->define( ).

  DATA(lo_entity_type) = model->get_entity_type( iv_entity_name = 'InventoryAdjustmentItem' ).

  " Ensure entity can be created
  lo_entity_type->set_creatable( abap_true ).

  " Add Processor if not already there
  DATA(lo_proc) = lo_entity_type->get_property( 'Processor' ).
  IF lo_proc IS INITIAL.
    lo_entity_type->create_property(
      iv_property_name  = 'Processor'
      iv_abap_fieldname = 'PROCESSOR' ).
    lo_entity_type->get_property( 'Processor' )->set_type_edm_string( ).
    lo_entity_type->get_property( 'Processor' )->set_maxlength( 12 ). "UNAME length
    lo_entity_type->get_property( 'Processor' )->set_nullable( abap_true ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
