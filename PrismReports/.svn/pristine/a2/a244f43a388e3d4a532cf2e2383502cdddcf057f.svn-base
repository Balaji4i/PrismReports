--------------------------------------------------------
--  DDL for Procedure XXPM_PROC_UPDATE_ORG_ID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_PROC_UPDATE_ORG_ID" 
IS
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
      SET org_id                   = porg_id
      WHERE business_unit_name = org.business_unit_name;
    EXCEPTION
    WHEN no_data_found THEN
      UPDATE xxpm_receipt_update
      SET org_id                   = null
      WHERE business_unit_name = org.business_unit_name;
    END;
  END LOOP;
END;
