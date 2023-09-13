--------------------------------------------------------
--  DDL for Procedure UPDATE_UNIT_FEATUREES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_UNIT_FEATUREES" 
AS
  CURSOR cur_insert
  IS
    SELECT UNIT_ID,UNIT_NUMBER FROM XXPM_PROPERTY_UNITS;
BEGIN
  FOR i IN cur_insert
  LOOP
    UPDATE XXDM_PROPERTY_FEATURES SET UNIT_ID=i.UNIT_ID WHERE UNIT_NUMBER=i.UNIT_NUMBER ;
  END LOOP;
  COMMIT;
END UPDATE_UNIT_FEATUREES;
