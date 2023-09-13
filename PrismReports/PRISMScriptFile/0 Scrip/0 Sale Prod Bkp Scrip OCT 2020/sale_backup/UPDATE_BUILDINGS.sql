--------------------------------------------------------
--  DDL for Procedure UPDATE_BUILDINGS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_BUILDINGS" 
AS
  CURSOR cur_insert
  IS
    SELECT BUILDING,UNIT_SHORT_CODE FROM XXDM_SALES_INVOICES;
BEGIN
  FOR i IN cur_insert
  LOOP
    UPDATE XXDM_SALES_RECEIPTS SET BUILDING=i.BUILDING WHERE UNIT=i.UNIT_SHORT_CODE ;
  END LOOP;
  COMMIT;
END UPDATE_BUILDINGS;
