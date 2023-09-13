--------------------------------------------------------
--  DDL for View XXPM_BLOCKING_HEADER_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCKING_HEADER_V" ("BLOCK_ID", "BLOCK_NUMBER", "BLOCK_TYPE", "BLOCK_DATE", "OFFER_HDR_ID", "OFFER_NUMBER", "ORG_ID", "ORG_NAME", "CUST_ID", "CUSTOMER_NAME", "CUSTOMER_NUMBER", "CUST_SITE_ID", "SITE_NUMBER", "SITE_NAME", "LEAD_ID", "LEAD_NUMBER", "LEAD_NAME", "MOBILE_NUMBER", "PHONE_NUMBER", "EMAIL_ID", "PROFESSIONAL", "USAGE", "STATUS", "STATUS_DISP", "VALID_UPTO", "RECEIPT_YN", "DESCRIPTION", "PROPERTY_ID", "PROPERTY_NAME", "NO_OF_UNITS", "AMOUNT") AS 
  SELECT
        bh.block_id,
        bh.block_number,
        lk1.lookup_value_name_disp   AS block_type,
        bh.block_date,
        bh.offer_hdr_id,
        oh.offer_number,
        bh.org_id,
        ogr.org_name,
        bh.cust_id,
        cus.customer_name,
        cus.customer_number,
        bh.cust_site_id,
        cussite.site_number,
        cussite.site_name,
        bh.lead_id,
        ld.lead_number,
        ld.lead_name,
        ld.mobile_number,
        ld.phone_number,
        ld.email_id,
        ld.professional,
        bh.usage,
        bh.status,
        lk.lookup_value_name_disp    AS status_disp,
        bh.valid_upto,
        bh.receipt_yn,
        bh.description,
        bh.property_id,
        pm.property_name,
        pm.no_of_units,
        SUM(rec.received_amount) AS amount
    FROM
        xxpm_block_header      bh,
        xxstg_organizations    ogr,
        xxpm_offer_header      oh,
        xxstg_customer         cus,
        xxstg_cust_sites       cussite,
        xxstg_lead             ld,
        xxfnd_lookup_v         lk,
        xxfnd_lookup_v         lk1,
        xxpm_receipt           rec,
        xxpm_property_master   pm
    WHERE
        bh.org_id = ogr.org_id
        AND bh.offer_hdr_id = oh.offer_hdr_id
        AND bh.cust_id = cus.cust_id
        AND bh.cust_site_id = cussite.cust_site_id
        AND bh.cust_id = cussite.cust_id
        AND bh.lead_id = ld.lead_id
        AND bh.org_id = cussite.org_id
        AND lk.lookup_value_name = bh.status
        AND lk.lookup_type_name = 'TRANSACTION_STATUS'
        AND lk1.lookup_value_name = bh.block_type
        AND lk1.lookup_type_name = 'BLOCK_TYPE'
        AND rec.source_func_ref_id = bh.block_id
        AND bh.property_id = pm.property_id
    GROUP BY
        bh.block_id,
        bh.block_number,
        lk1.lookup_value_name_disp,
        bh.block_date,
        bh.offer_hdr_id,
        oh.offer_number,
        bh.org_id,
        ogr.org_name,
        bh.cust_id,
        cus.customer_name,
        cus.customer_number,
        bh.cust_site_id,
        cussite.site_number,
        cussite.site_name,
        bh.lead_id,
        ld.lead_number,
        ld.lead_name,
        ld.mobile_number,
        ld.phone_number,
        ld.email_id,
        ld.professional,
        bh.usage,
        bh.status,
        lk.lookup_value_name_disp,
        bh.valid_upto,
        bh.receipt_yn,
        bh.description,
        bh.property_id,
        pm.property_name,
        pm.no_of_units
