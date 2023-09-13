--------------------------------------------------------
--  DDL for Procedure XXPM_RECEIPT_UPDATE_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_RECEIPT_UPDATE_PROC" 
IS
BEGIN
  <<update_cust_id>>
  DECLARE
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
        SET cust_id                   = NULL,
          customer_name               = NULL
        WHERE customer_account_number = cust.customer_account_number;
      END;
    END LOOP;
  END update_cust_id;
  <<update_org_id>>
  DECLARE
    porg_id VARCHAR2(50);
    CURSOR org_detail
    IS
      SELECT business_unit_name FROM xxpm_receipt_update;
  BEGIN
    FOR org IN org_detail
    LOOP
      BEGIN
        SELECT org_id
        INTO porg_id
        FROM XXSTG_ORGANIZATIONS
        WHERE org_name = org.business_unit_name;
        UPDATE xxpm_receipt_update
        SET org_id               = porg_id
        WHERE business_unit_name = org.business_unit_name;
      EXCEPTION
      WHEN no_data_found THEN
        UPDATE xxpm_receipt_update
        SET org_id               = NULL
        WHERE business_unit_name = org.business_unit_name;
      END;
    END LOOP;
  END update_org_id;
  <<update_method_id>>
  DECLARE
    pmethod_id VARCHAR2(50);
    CURSOR method_detail
    IS
      SELECT receipt_method_name,org_id FROM xxpm_receipt_update;
  BEGIN
    FOR method_id IN method_detail
    LOOP
      BEGIN
        SELECT receipt_method_id
        INTO pmethod_id
        FROM XXSTG_RECEIPT_METHOD
        WHERE receipt_method_name = method_id.receipt_method_name and org_id = method_id.org_id;
        UPDATE xxpm_receipt_update
        SET receipt_method_id     = pmethod_id
        WHERE receipt_method_name = method_id.receipt_method_name and org_id = method_id.org_id;
      EXCEPTION
      WHEN no_data_found THEN
        UPDATE xxpm_receipt_update
        SET receipt_method_id     = NULL
        WHERE receipt_method_name = method_id.receipt_method_name and org_id = method_id.org_id;
      END;
    END LOOP;
  END update_method_id;
END xxpm_receipt_update_proc;
