--------------------------------------------------------
--  DDL for Procedure UPDATE_BUILDINGS3
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_BUILDINGS3" 
AS
  CURSOR cur_insert
  IS
    SELECT  
       MS_HDR_ID
FROM XXPM_MILESTONE_DTL where MS_DTL_ID is null;
BEGIN
  FOR i IN cur_insert
  LOOP
    UPDATE XXPM_MILESTONE_DTL SET MS_DTL_ID=XXPM_MS_DTL_ID_S.NEXTVAL WHERE MS_HDR_ID=i.MS_HDR_ID ;
  END LOOP;
  COMMIT;
END UPDATE_BUILDINGS3;
