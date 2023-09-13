--------------------------------------------------------
--  DDL for Procedure UPDATE_BUILDINGS2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_BUILDINGS2" 
AS
  CURSOR cur_insert
  IS
    SELECT  
       MS_HDR_ID,
	   MILESTONE_NUMBER
FROM XXPM_MILESTONE_HDR;
BEGIN
  FOR i IN cur_insert
  LOOP
    UPDATE XXDM_MILESTONE_DTL SET MS_HDR_ID=i.MS_HDR_ID WHERE MILESTONE_NUMBER=i.MILESTONE_NUMBER ;
  END LOOP;
  COMMIT;
END UPDATE_BUILDINGS2;
