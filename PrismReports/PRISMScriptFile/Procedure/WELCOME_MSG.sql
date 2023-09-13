--------------------------------------------------------
--  DDL for Procedure WELCOME_MSG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "WELCOME_MSG" 
IS
BEGIN
dbms_output.put_line ('Welcome ');
insert into xxpm_cust_detail_types(cust_id_list,cust_name_list) 
      values('1','1');
END;
