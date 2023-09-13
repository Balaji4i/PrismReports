--------------------------------------------------------
--  DDL for View XXPM_BLOCKING_HEADER_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCKING_HEADER_PCS_V" ("BLOCK_ID", "BLOCK_NUMBER", "BLOCK_TYPE", "BLOCK_DATE", "EXTN_COUNT", "OFFER_HDR_ID", "OFFER_NUMBER", "ORG_ID", "ORG_NAME", "CUST_ID", "CUSTOMER_NAME", "CUSTOMER_NUMBER", "CUST_SITE_ID", "LEAD_ID", "LEAD_NUMBER", "LEAD_NAME", "MOBILE_NUMBER", "PHONE_NUMBER", "EMAIL_ID", "PROFESSIONAL", "USAGE", "STATUS", "STATUS_DISP", "VALID_UPTO", "RECEIPT_YN", "DESCRIPTION", "PROPERTY_ID", "PROPERTY_NAME", "NO_OF_UNITS", "AMOUNT", "SITE_NUMBER", "SITE_NAME", "FIXAMT", "CHARGE", "MILESTONE_NAME", "PL_NAME") AS 
  SELECT
        block_id,
        block_number,
        block_type,
        block_date,
        extn_count,
        offer_hdr_id,
        offer_number,
        org_id1,
        org_name,
        cust_id,
        customer_name,
        customer_number,
        cus1,
        lead_id,
        lead_number,
        lead_name,
        mobile_number,
        phone_number,
        email_id,
        professional,
        usage,
        status,
        status_disp,
        valid_upto,
        receipt_yn,
        description,
        property_id,
        property_name,
        no_of_units,
        amount,
        (
            SELECT
                xcs.site_number
            FROM
                xxstg_cust_sites xcs
            WHERE
                xcs.cust_site_id = cus1
                AND xcs.org_id = org_id1
        ) AS site_number,
        (
            SELECT
                xcs.site_name
            FROM
                xxstg_cust_sites xcs
            WHERE
                xcs.cust_site_id = cus1
                AND xcs.org_id = org_id1
        ) AS site_name,
        nvl(xxpm_prism.getothercharge_amt(offer_hdr_id, 'Fix'), 0) AS fixamt,
        nvl(xxpm_prism.getothercharge_amt(offer_hdr_id, 'Charge'), 0) AS charge,
        milestone_name,
        pl_name
    FROM
        (
            SELECT
                xbh.block_id,
                xbh.block_number,
                lk1.lookup_value_name_disp   AS block_type,
                trunc(xbh.block_date) AS block_date,
                xbh.extn_count,
                xbh.offer_hdr_id,
                xoh.offer_number,
                xbh.org_id                   AS org_id1,
                xo.org_name,
                xbh.cust_id,
                xc.customer_name,
                xc.customer_number,
                xbh.cust_site_id             cus1,
                xbh.lead_id,
                ld.lead_number,
                ld.lead_name,
                ld.mobile_number,
                ld.phone_number,
                ld.email_id,
                ld.professional,
                xbh.usage,
                xbh.status,
                lk.lookup_value_name_disp    AS status_disp,
                xbh.valid_upto,
                xbh.receipt_yn,
                xbh.description,
                xbh.property_id,
                xpm.property_name,
                xpm.no_of_units,
    --REC.RECEIVED_AMOUNT,
                SUM(rec.received_amount) AS amount,
                xmh.milestone_name,
                xph.pl_name
            FROM
                xxpm_block_header      xbh,
                xxstg_organizations    xo,
                xxpm_offer_header      xoh,
                xxstg_customer         xc,
                xxstg_lead             ld,
                xxpm_receipt           rec,
                xxpm_property_master   xpm,
                xxfnd_lookup_v         lk,
                xxfnd_lookup_v         lk1,
                xxpm_milestone_hdr     xmh,
                xxpm_pl_header         xph
            WHERE
                xbh.org_id = xo.org_id
                AND xbh.offer_hdr_id = xoh.offer_hdr_id (+)
                AND xbh.cust_id = xc.cust_id (+)
                AND xbh.lead_id = ld.lead_id (+)
                AND rec.source_func_ref_id (+) = xbh.block_id
                AND xpm.property_id = xbh.property_id
                AND lk.lookup_value_name = xbh.status
                AND lk.lookup_type_name = 'TRANSACTION_STATUS'
                AND lk1.lookup_value_name = xbh.block_type
                AND lk1.lookup_type_name = 'BLOCK_TYPE'
                AND xoh.ms_hdr_id = xmh.ms_hdr_id (+)
                AND xoh.pl_id = xph.pl_id (+)
            GROUP BY
                xbh.block_id,
                xbh.block_number,
                lk1.lookup_value_name_disp,
                xbh.block_date,
                xbh.extn_count,
                xbh.offer_hdr_id,
                xoh.offer_number,
                xbh.org_id,
                xo.org_name,
                xbh.cust_id,
                xc.customer_name,
                xc.customer_number,
                xbh.cust_site_id,
                xbh.lead_id,
                ld.lead_number,
                ld.lead_name,
                ld.mobile_number,
                ld.phone_number,
                ld.email_id,
                ld.professional,
                xbh.usage,
                xbh.status,
                lk.lookup_value_name_disp,
                xbh.valid_upto,
                xbh.receipt_yn,
                xbh.description,
                xbh.property_id,
                xpm.property_name,
                xpm.no_of_units,
                xmh.milestone_name,
                xph.pl_name
        )
