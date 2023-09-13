--------------------------------------------------------
--  DDL for View XXPM_BLOCK_RECEIPT_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCK_RECEIPT_PCS_V" ("ROW_ID", "RECEIPT_ID", "RECEIPT_NUMBER", "RECEIPT_DATE", "ORG_ID", "BUSINESS_UNIT", "RECEIPT_TYPE", "PROPERTY_ID", "PROPERY_NAME", "PROPERY_NUMBER", "UNIT_ID", "UNIT_NAME", "UNIT_NUMBER", "BUILD_ID", "BUILING_NAME", "BUILING_NUMBER", "LEAD_ID", "CUST_ID", "CUSTOMER_NAME", "CUST_SITE_ID", "SITE_NUMBER", "SALESMAN_ID", "CURRENCY_CODE", "RECEIPT_AMOUNT", "RECEIPT_METHOD_NAME", "PAY_MODE", "PAY_REF_NUMBER", "PAY_REF_DATE", "BANK_NAME", "BANK_BRANCH_NAME", "STATUS", "DESCRIPTION", "RECOMMENDED_AMOUNT", "RECEIVED_AMOUNT", "DIFF_IN_DAYS", "PAY_REC_DATE", "PAY_REV_DATE", "RCT_TYPE", "RCT_DESC", "SOURCE_FUNC_ID", "SOURCE_FUNC_REF_ID") AS 
  SELECT DISTINCT
        xr.rowid,
        xr.receipt_id,
        xr.receipt_number,
        xr.receipt_date,
        xr.org_id,
        xo.org_name,
        lk.lookup_value_name_disp,
        xr.property_id,
        xpm.property_name,
        xpm.property_number,
        xr.unit_id,
        xpu.unit_name,
        xpu.unit_number,
        xr.build_id,
        xpb.build_name,
        xpb.build_number,
        xr.lead_id,
        xr.cust_id,
        xsc.customer_name,
        xcs.cust_site_id,
        xcs.site_number,
        xr.salesman_id,
        lk1.lookup_value_name_disp,
        xr.receipt_amount,
        xrm.receipt_method_name,
        xr.pay_mode,
        xr.pay_ref_number,
        xr.pay_ref_date,
        xr.bank_name,
        xr.bank_branch_name,
        xr.interface_status,
        xr.description,
        xr.recommended_amount,
        xr.received_amount,
        xr.diff_in_days,
        xr.pay_rec_date,
        xr.pay_rev_date,
        xr.rct_type,
        xr.rct_desc,
        xr.source_func_id,
        xr.source_func_ref_id
    FROM
        xxpm_receipt              xr,
        xxstg_organizations       xo,
        xxfnd_lookup_v            lk,
        xxpm_property_master      xpm,
        xxpm_property_units       xpu,
        xxpm_property_buildings   xpb,
        xxstg_customer            xsc,
        xxstg_cust_sites          xcs,
        xxfnd_lookup_v            lk1,
        xxstg_receipt_method      xrm
    WHERE
        xr.org_id = xo.org_id (+)
        AND xr.receipt_type = lk.lookup_value_name (+)
        AND lk.lookup_type_name (+) = 'RECEIPT_TYPE'
        AND xr.property_id = xpm.property_id (+)
        AND xr.unit_id = xpu.unit_id (+)
        AND xr.build_id = xpb.build_id (+)
        AND xr.cust_id = xsc.cust_id (+)
        AND xr.cust_site_id = xcs.cust_site_id (+)
        AND xr.currency_code = lk1.lookup_value_name (+)
        AND lk1.lookup_type_name (+) = 'CURRENCY'
        AND xr.pay_mode = xrm.receipt_method_id (+)
    ORDER BY
        xr.receipt_number DESC
