--------------------------------------------------------
--  DDL for Procedure UPDATE_INVOICES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_INVOICES" 
AS  
    

        CURSOR cur_insert IS
      select INVH.INVOICE_ID,INVH.INVOICE_NUMBER,INVH.BOOKING_ID ,LI.INSTALLMENT_TYPE from XXPM_INVOICE_HEADER INVH,XXPM_INVOICE_LINES LI where INVH.INVOICE_ID=LI.INVOICE_ID;
       


       
    BEGIN
        FOR i IN cur_insert
        LOOP
        
           
update XXPM_BOOKING_MILESTONES SET INVOICE_ID=i.INVOICE_ID Where BOOKING_HDR_ID=i.BOOKING_ID and INSTALLMENT_TYPE=i.INSTALLMENT_TYPE;


        END LOOP;
           commit;

    END UPDATE_INVOICES;
