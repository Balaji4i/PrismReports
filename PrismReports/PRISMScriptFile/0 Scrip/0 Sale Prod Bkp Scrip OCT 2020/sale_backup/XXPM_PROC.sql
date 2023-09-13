--------------------------------------------------------
--  DDL for Procedure XXPM_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_PROC" 
IS
  pcust_id   VARCHAR2(50);
  pcust_name VARCHAR2(50);
  CURSOR cust_detail
  IS
    SELECT customer_account_number FROM xxpm_receipt_update;
BEGIN
  FOR cust IN cust_detail
  LOOP
    BEGIN
      SELECT cust_id,
        customer_name
      INTO pcust_id,
        pcust_name
      FROM XXSTG_CUSTOMER
      WHERE customer_number = cust.customer_account_number;
      UPDATE xxpm_receipt_update
      SET cust_id                   = pcust_id,
        customer_name               = pcust_name
      WHERE customer_account_number = cust.customer_account_number;
    EXCEPTION
    WHEN no_data_found THEN
      UPDATE xxpm_receipt_update
      SET cust_id                   = null,
        customer_name               = null
      WHERE customer_account_number = cust.customer_account_number;
    END;
  END LOOP;
END;
