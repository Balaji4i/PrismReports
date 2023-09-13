--------------------------------------------------------
--  DDL for Function XX_MS_HDR_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "XX_MS_HDR_ID" (p_milestone_number VARCHAR2)
   RETURN NUMBER
IS
   l_ms_hdr_id    NUMBER;
BEGIN
   SELECT ms_hdr_id
     INTO l_ms_hdr_id
     FROM xxpm_milestone_hdr
    WHERE milestone_number = p_milestone_number;

   RETURN l_ms_hdr_id;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN 0;
END;
