--------------------------------------------------------
--  DDL for Procedure XXPM_RECEIPT_PCUST_NUM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_RECEIPT_PCUST_NUM" (pcust_num in varchar2,pcust_id out varchar2, pcust_name out varchar2)
is
begin
select cust_id, customer_name into pcust_id, pcust_name 
from XXSTG_CUSTOMER where customer_number = pcust_num;
end;
