--------------------------------------------------------
--  DDL for Function GET_EMPTY_PDC_DUE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_EMPTY_PDC_DUE" 
   RETURN VARCHAR2
   IS
   l_output varchar2(4000);
   Begin
  
   l_output := '<?xml version="1.0"?>
<PC>
<PC_HEAD>
<PROJECT_NAME>-</PROJECT_NAME>
<SUB_PROJECT></SUB_PROJECT>
<UNIT_NO></UNIT_NO>
<PDC_AMOUNT></PDC_AMOUNT>
<PDC_NUMBER></PDC_NUMBER>
<PDC_DATE></PDC_DATE>
<DUE_DATE></DUE_DATE>
<PDC_REMARKS></PDC_REMARKS>
<PDC_DUE></PDC_DUE>
<RECEIPT_NUMBER></RECEIPT_NUMBER>
<LAYOUT_CHECK/>
</PC_HEAD>
</PC>';
      RETURN l_output;
END GET_EMPTY_PDC_DUE;
