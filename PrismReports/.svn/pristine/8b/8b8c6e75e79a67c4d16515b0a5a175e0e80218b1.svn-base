--------------------------------------------------------
--  DDL for Function XX_BOOKING_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "XX_BOOKING_ID" (p_booking_number VARCHAR2)
   RETURN NUMBER
IS
   l_booking_hdr_id NUMBER;
BEGIN
   SELECT booking_hdr_id
     INTO l_booking_hdr_id
     FROM xxpm_booking_header
    WHERE booking_number = p_booking_number;

   RETURN (l_booking_hdr_id);
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN 0;
END;
