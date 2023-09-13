--------------------------------------------------------
--  DDL for Function GET_FUNCTION_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_FUNCTION_ID" (P_CODE IN VARCHAR2) 
   RETURN number 
   IS L_FUNID number;
   BEGIN 

	  SELECT FUNC_ID into L_FUNID 
	  FROM xxfnd_functions where FUNC_SHORT_CODE=P_CODE;

      RETURN L_FUNID; 
    END;
