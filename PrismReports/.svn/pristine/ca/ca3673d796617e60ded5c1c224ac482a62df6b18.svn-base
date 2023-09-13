--------------------------------------------------------
--  DDL for Type PROPERTY_FIX_FITTINGS_OBJ_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "PROPERTY_FIX_FITTINGS_OBJ_TYPE" force AS OBJECT (
    fix_id              number,
    property_number     varchar(60),
    property_id         number, 
    build_number        varchar2(60),
    build_id            number,
    unit_number         varchar2(60),
    unit_id             number,
    fix_category        varchar2(60),
    description         varchar2(4000),
    fix_condition       varchar2(60),
    uom                 varchar2(60),
    value               number,
    quantity            number,
    rate                number,
  CONSTRUCTOR FUNCTION Property_fix_fittings_Obj_Type RETURN SELF AS RESULT);
