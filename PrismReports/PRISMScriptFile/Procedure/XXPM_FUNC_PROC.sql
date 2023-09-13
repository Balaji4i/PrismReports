--------------------------------------------------------
--  DDL for Procedure XXPM_FUNC_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_FUNC_PROC" 
is
CURSOR cust_detail IS SELECT customer_account_number FROM xxpm_receipt_update;
begin
 FOR cust IN cust_detail
  LOOP
insert into xxpm_cust_detail_types(cust_id_list,cust_name_list) 
      values(cust.customer_account_number,cust.customer_account_number);
dbms_output.put_line('hi');
end loop;
end;
