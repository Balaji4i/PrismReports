--------------------------------------------------------
--  DDL for Procedure UPDATE_INOVICE_BOOKING_NUMBER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_INOVICE_BOOKING_NUMBER" AS
        CURSOR cur_insert IS
       SELECT
       rowid,
        PROPERTY,
        BUILDING,
        UNIT_SHORT_CODE
FROM
    xxdm_sales_invoices;

    BEGIN
        FOR i IN cur_insert
        LOOP
        BEGIN
            UPDATE xxdm_sales_invoices SET BOOKING_NUMBER=(SELECT DISTINCT XBH.BOOKING_NUMBER FROM xxdm_sales_invoices XSI,XXPM_PROPERTY_MASTER XPM,XXPM_PROPERTY_BUILDINGS XPB,XXPM_PROPERTY_UNITS XPU,xxpm_booking_detail XBD,XXPM_BOOKING_HEADER XBH
WHERE XSI.PROPERTY=XPM.PROPERTY_NUMBER
AND XSI.BUILDING=XPB.BUILD_NUMBER
AND XSI.UNIT_SHORT_CODE=XPU.UNIT_SHORTCODE
AND XBD.UNIT_ID = XPU.UNIT_ID
AND XBD.BUILDING_ID = XPB.BUILD_ID
AND XBD.PROPERTY_ID=XPM.PROPERTY_ID
AND XBH.BOOKING_HDR_ID = XBD.BOOKING_HDR_ID
AND XSI.PROPERTY=I.PROPERTY
AND  XSI.BUILDING=I.BUILDING
AND XSI.UNIT_SHORT_CODE=I.UNIT_SHORT_CODE)
WHERE rowid  = i.rowid ;
         EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('FAILED '||SQLCODE||'-'||SQLERRM);
         END;
        END LOOP;
           commit;

    END UPDATE_INOVICE_BOOKING_NUMBER;