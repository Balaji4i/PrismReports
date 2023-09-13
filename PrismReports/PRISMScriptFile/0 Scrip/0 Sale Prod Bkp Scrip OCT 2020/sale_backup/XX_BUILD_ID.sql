--------------------------------------------------------
--  DDL for Function XX_BUILD_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "XX_BUILD_ID" (p_build_number VARCHAR2,p_property_id number)
   RETURN NUMBER
IS
   l_build_id     NUMBER;
BEGIN
   SELECT build_id
     INTO l_build_id
     FROM xxpm_property_buildings
    WHERE     property_id = p_property_id
          AND build_number = p_build_number;

   RETURN (l_build_id);
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN 0;
END;
