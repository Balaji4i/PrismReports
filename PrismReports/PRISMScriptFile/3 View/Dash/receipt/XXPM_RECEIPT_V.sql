CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXPM_RECEIPT_V" ("ROW_ID", "RECEIPT_ID", "RECEIPT_NUMBER", "RECEIPT_DATE", "ORG_ID", "BUSINESS_UNIT", "RECEIPT_TYPE", "PROPERTY_ID", "PROPERY_NAME", "PROPERY_NUMBER", "UNIT_ID", "UNIT_NAME", "UNIT_NUMBER", "BUILD_ID", "BUILING_NAME", "BUILING_NUMBER", "LEAD_ID", "CUST_ID", "CUSTOMER_NAME", "CUST_SITE_ID", "SITE_NUMBER", "SALESMAN_ID", "CURRENCY_CODE", "RECEIPT_AMOUNT", "RECEIPT_METHOD_NAME", "PAY_MODE", "PAY_REF_NUMBER", "PAY_REF_DATE", "BANK_NAME", "BANK_BRANCH_NAME", "STATUS", "DESCRIPTION", "RECOMMENDED_AMOUNT", "RECEIVED_AMOUNT", "DIFF_IN_DAYS", "PAY_REC_DATE", "PAY_REV_DATE", "RCT_TYPE", "RCT_DESC", "SOURCE_FUNC_ID", "SOURCE_FUNC_REF_ID") AS 
  SELECT  xr.ROWID
        ,xr.receipt_id
        ,xr.receipt_number
        ,xr.receipt_date
        ,xr.org_id
        ,xo.org_name
        ,lk.lookup_value_name_disp
        ,xr.property_id
        ,xpm.property_name
        ,xpm.property_number
        ,xr.unit_id
        ,xpu.unit_name
        ,xpu.unit_number
        ,xr.build_id
        ,xpb.build_name
        ,xpb.build_number
        ,xr.lead_id
        ,xr.cust_id
        ,xsc.customer_name
        ,xcs.cust_site_id
        ,xcs.site_number
        ,xr.salesman_id
        ,lk1.lookup_value_name_disp
        ,xr.receipt_amount
        ,xrm.receipt_method_name
        ,xr.pay_mode
        ,xr.pay_ref_number
        ,xr.pay_ref_date
        ,xr.bank_name
        ,xr.bank_branch_name
        ,xr.INTERFACE_STATUS
        ,                                        --LK2.LOOKUP_VALUE_NAME_DISP,
         xr.description
        ,xr.recommended_amount
        ,xr.received_amount
        ,xr.diff_in_days
        ,xr.pay_rec_date
        ,xr.pay_rev_date
        ,xr.rct_type
        ,xr.rct_desc
        ,xr.source_func_id
        ,xr.source_func_ref_id
    FROM xxpm_receipt xr
        ,xxstg_organizations xo
        ,xxfnd_lookup_v lk
        ,xxpm_property_master xpm
        ,xxpm_property_units xpu
        ,xxpm_property_buildings xpb
        ,xxstg_customer xsc
        ,xxstg_cust_sites xcs
        ,xxfnd_lookup_v lk1
        ,                                                --XXFND_LOOKUP_V LK2,
         xxstg_receipt_method xrm
   WHERE     xr.org_id = xo.org_id
         -- and xr.receipt_id=xr.receipt_id+0
         AND xr.receipt_type = xr.receipt_type || ''
         AND xr.property_id =   xr.property_id
                              + 0
         AND xr.unit_id =   xr.unit_id
                          + 0
         AND xr.cust_id =   xr.cust_id
                          + 0
         AND xr.receipt_type = lk.lookup_value_name
         AND lk.lookup_type_name in('RECEIPT_TYPE','CHARGE_TYPE')
         AND xr.property_id = xpm.property_id
         AND xpm.property_id =   xpm.property_id
                               + 0
         AND xr.unit_id = xpu.unit_id
         AND xpu.unit_id =   xpu.unit_id
                           + 0
         AND xr.build_id = xpb.build_id
         AND xpb.build_id =   xpb.build_id
                            + 0
         AND xr.cust_id = xsc.cust_id
         and xsc.cust_id=xsc.cust_id+0
         AND xr.cust_site_id = xcs.cust_site_id
         and xr.org_id=xcs.org_id
         and xcs.cust_id=xcs.cust_id+0
         and xcs.cust_site_id=xcs.cust_site_id+0
         and xcs.org_id=xcs.org_id+0
         AND xr.currency_code = lk1.lookup_value_name
         AND lk1.lookup_type_name = 'CURRENCY'
         --and XR.STATUS=LK2.LOOKUP_VALUE_NAME(+)
         AND xr.pay_mode = xrm.receipt_method_id(+)
         AND xr.org_id = xrm.org_id(+)
         AND xr.remit_bank_acct_use_id = xrm.remit_bank_acct_use_id(+)
         --and LK2.LOOKUP_TYPE_NAME (+) = 'TRANSACTION_STATUS'
        -- AND receipt_number = '19540'
ORDER BY xr.receipt_number DESC;
