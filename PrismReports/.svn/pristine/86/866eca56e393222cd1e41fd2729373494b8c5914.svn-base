--------------------------------------------------------
--  DDL for Function XXPM_FUNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXPM_FUNC" 
  RETURN xxpm_cust_detail_type
IS
  cust_id   VARCHAR2(50);
  cust_name VARCHAR2(50);
  cust_list xxpm_cust_detail_type := xxpm_cust_detail_type();
  CURSOR cust_detail
  IS
    SELECT customer_account_number FROM xxpm_receipt_update;
BEGIN
  FOR cust IN cust_detail
  LOOP
    BEGIN
      xxpm_receipt_pcust_num(cust.customer_account_number,cust_id,cust_name);
      cust_list.extend;
      cust_list(cust_list.last):= xxpm_cust_detail_obj(cust_id,cust_name);
    EXCEPTION
    WHEN no_data_found THEN
      cust_list.extend;
      cust_list(cust_list.last):= xxpm_cust_detail_obj(NULL,NULL);
    END;
  END LOOP;
RETURN cust_list;
END;
