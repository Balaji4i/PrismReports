--------------------------------------------------------
--  DDL for Procedure UPDATE_BOOKING_DATES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_BOOKING_DATES" 
AS

        CURSOR cur_insert IS
       SELECT
	   OFFER_HDR_ID,
ORG_ID,
FUNC_ID,
OFFER_NUMBER,
OFFER_DATE
FROM XXPM_OFFER_HEADER;
       


       
    BEGIN
        FOR i IN cur_insert
        LOOP
        
           
update XXPM_BOOKING_HEADER SET BOOKING_DATE=i.OFFER_DATE Where BOOKING_NUMBER=i.OFFER_NUMBER;

           
           


       
    
    
        END LOOP;
           commit;

    END UPDATE_BOOKING_DATES;
