class ZCL_Z_EWM_INVENTORY_08_MPC_EXT definition
  public
  inheriting from ZCL_Z_EWM_INVENTORY_08_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_Z_EWM_INVENTORY_08_MPC_EXT IMPLEMENTATION.


METHOD define.
  super->define( ).

  DATA(lo_entity) = model->get_entity_type( iv_entity_name = 'InventoryAdjustmentItem' ).

  IF lo_entity IS BOUND.

    " Recreate CNTQTY properly as Edm.Decimal
    DATA(lo_property) = lo_entity->create_property(
                          iv_property_name   = 'CNTQTY'
                          iv_abap_fieldname  = 'CNTQTY' ).

    lo_property->set_type_edm_decimal( ).
    lo_property->set_precison( 15 ). " total digits (including decimals)
    " scale (decimals) is handled inside this precision setting

    lo_property->set_nullable( abap_true ).

  ENDIF.
ENDMETHOD.
ENDCLASS.
