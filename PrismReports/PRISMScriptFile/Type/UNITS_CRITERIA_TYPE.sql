--------------------------------------------------------
--  DDL for Type UNITS_CRITERIA_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "UNITS_CRITERIA_TYPE" force AS OBJECT (
    unit_id             	number, 
    property_id         	number, 
    build_id            	number,      
    property_name      		varchar2(240),  
    build_name         		varchar2(240),   
    unit_name          		varchar2(240),      
    unit_number        		varchar2(60),
    unit_shortcode     		varchar2(60),
    UNIT_TYPE             varchar2(20),
  	status					      varchar2(20),
    CONSTRUCTOR FUNCTION UNITS_CRITERIA_TYPE RETURN SELF AS RESULT);
CREATE OR REPLACE EDITIONABLE TYPE BODY "UNITS_CRITERIA_TYPE" 
AS
   CONSTRUCTOR FUNCTION UNITS_CRITERIA_TYPE RETURN SELF AS RESULT
   AS
   BEGIN
      RETURN;
   END;
END;
