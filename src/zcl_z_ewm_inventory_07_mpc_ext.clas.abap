class ZCL_Z_EWM_INVENTORY_07_MPC_EXT definition
  public
  inheriting from ZCL_Z_EWM_INVENTORY_07_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_INVENTORY_07_MPC_EXT IMPLEMENTATION.


METHOD define.
  super->define( ).

  DATA(lo_entity) = model->get_entity_type( iv_entity_name = 'InventoryAdjustmentItem1' ).
  IF lo_entity IS BOUND.
    DATA(lo_property) = lo_entity->get_property( iv_property_name = 'CNTQTY' ).
    IF lo_property IS BOUND.
      lo_property->set_type_edm_string( ).    " force CNTQTY to Edm.String
      lo_property->set_maxlength( '15' ).     " allow up to 15 chars
      lo_property->set_nullable( abap_true ). " optional
    ENDIF.
  ENDIF.
ENDMETHOD.
ENDCLASS.
