--------------------------------------------------------
--  DDL for View XXPM_OFFER_HEADERS_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_OFFER_HEADERS_PCS_V" ("OFFER_HDR_ID", "ORG_ID", "ORG_NAME", "FUNC_ID", "OFFER_NUMBER", "OFFER_DATE", "OFFER_FROM_DATE", "OFFER_TO_DATE", "PERFORMED_BY", "REVISION_NO", "REVISION_DATE", "REVISED_BY", "MS_HDR_ID", "MILESTONE_NAME", "PL_ID", "PL_NAME", "OFFER_TYPE", "LEAD_ID", "LEAD_NAME", "CUSTOMER_ID", "CUST_SITE_ID", "SITE_NUMBER", "CUSTOMER_NAME", "CUSTOMER_PHONE_NO", "CUSTOMER_COUNTRY", "SALESMAN_ID", "CURRENCY_CODE", "CHECKLIST", "TERMS_DESC", "OBJECT_VERSION_NUMBER", "OFFER_FLAG", "TAX_CODE", "PREV_BOOKING_ID", "STATUS", "DESCRIPTION", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "USER_GRP_ID", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "OFFER_END_DATE", "USAGE", "LEAD_SOURCE_CHANNEL", "LEAD_SOURCE_NAME", "VEND_ID", "VEND_SITE_ID", "VEND_CONTRACT_NO", "PROPERTY_ID", "EMAIL_ID", "LEASE_AGREEMENT_ID", "CAR_PARK_LEASE_AGRE_ID", "CUST_ACCEPT") AS 
  SELECT DISTINCT
        oh.offer_hdr_id,
        oh.org_id,
        org.org_name,
        oh.func_id,
        oh.offer_number,
        trunc(oh.offer_date),
        trunc(oh.offer_from_date),
        trunc(oh.offer_to_date),
        oh.performed_by,
        oh.revision_no,
        trunc(oh.revision_date),
        oh.revised_by,
        oh.ms_hdr_id,
        msh.milestone_name,
        oh.pl_id,
        pl.pl_name,
        lk.lookup_value_name_disp    AS offer_type,
        oh.lead_id,
        ld.lead_name,
        oh.customer_id,
        oh.cust_site_id,
        cusite.site_number,
        oh.customer_name,
        oh.customer_phone_no,
        oh.customer_country,
        oh.salesman_id,
        lk1.lookup_value_name_disp   AS currency_code,
        oh.checklist,
        oh.terms_desc,
        oh.object_version_number,
        oh.offer_flag,
        oh.tax_code,
        oh.prev_booking_id,
        lk2.lookup_value_name_disp   AS status,
        oh.description,
        oh.flow_status,
        oh.flow_level,
        oh.flow_with,
        oh.user_grp_id,
        oh.created_by,
        trunc(oh.creation_date),
        oh.last_updated_by,
        trunc(oh.last_update_date),
        oh.last_update_login,
        ( oh.offer_end_date ),
        oh.usage,
        oh.lead_source_channel,
        oh.lead_source_name,
        oh.vend_id,
        oh.vend_site_id,
        oh.vend_contract_no,
        oh.property_id,
        oh.email_id,
        oh.lease_agreement_id,
        oh.car_park_lease_agre_id,
        oh.cust_accept
    FROM
        xxpm_offer_header     oh,
        xxstg_organizations   org,
        xxpm_milestone_hdr    msh,
        xxpm_pl_header        pl,
        xxfnd_lookup_v        lk,
        xxpm_lead             ld,
        xxstg_cust_sites      cusite,
        xxfnd_lookup_v        lk1,
        xxfnd_lookup_v        lk2
    WHERE
        org.org_id = oh.org_id
        AND msh.ms_hdr_id = oh.ms_hdr_id
        AND oh.pl_id = pl.pl_id
        AND lk.lookup_type_name = 'OFFER_TYPE'
        AND lk.lookup_value_name = oh.offer_type
        AND ld.lead_id = oh.lead_id
        AND cusite.cust_site_id = oh.cust_site_id
        AND cusite.cust_id = oh.customer_id
        AND cusite.org_id = oh.org_id
        AND lk1.lookup_type_name = 'CURRENCY'
        AND lk1.lookup_value_name = oh.currency_code
        AND lk2.lookup_type_name = 'BOOKING_STATUS'
        AND lk2.lookup_value_name = oh.status
