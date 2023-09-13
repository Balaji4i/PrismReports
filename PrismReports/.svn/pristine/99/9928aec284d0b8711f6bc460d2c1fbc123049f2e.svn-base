--------------------------------------------------------
--  DDL for View XXPM_BLOCKING_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCKING_V" ("BLOCK_ID", "LEAD_ID", "BLOCK_NUMBER", "BLOCK_DATE", "BLOCK_TYPE", "BLOCKED_BY", "ORG_ID", "ORG_NAME", "STATUS", "DESCRIPTION", "FUNC_ID", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "USER_GRP_ID", "RECEIPT_YN", "OFFER_HDR_ID", "OFFER_NUMBER", "CUST_ID", "CUSTOMER_NAME", "CUST_SITE_ID", "CITY_NAME", "COUNTRY_NAME", "VALID_UPTO", "EXTN_REASON", "EXTN_COUNT", "BLOCK_DTL_ID", "PROPERTY_ID", "PROPERTY_NUMBER", "PROPERTY_NAME", "BUILD_ID", "BUILD_NUMBER", "BUILD_NAME", "UNIT_ID", "UNIT_NUMBER", "UNIT_NAME", "UNBLOCK_FLAG", "UNBLOCK_ID", "OFFER_DTL_ID") AS 
  SELECT DISTINCT
        xbh.block_id,
        xbh.lead_id,
        xbh.block_number,
        xbh.block_date,
        xbh.block_type,
        xbh.blocked_by,
        xbh.org_id,
        org.org_name,
        xbh.status,
        xbh.description,
        xbh.func_id,
        xbh.flow_status,
        xbh.flow_level,
        xbh.flow_with,
        xbh.user_grp_id,
        xbh.receipt_yn,
        xbh.offer_hdr_id,
        (
            SELECT
                offer_number
            FROM
                xxpm_offer_header xoh
            WHERE
                xoh.offer_hdr_id = xbh.offer_hdr_id
        ) offer_number,
        xbh.cust_id,
        (
            SELECT
                customer_name
            FROM
                xxstg_customer xsh
            WHERE
                xsh.cust_id = xbh.cust_id
        ) customer_name,
        xbh.cust_site_id,
--null CITY_NAME,
--NULL COUNTRY_NAME,
--(select CITY from XXSTG_CUST_SITES XCS where XCS.CUST_ID=XBH.CUST_ID and xcs.CUST_SITE_ID = xbh.CUST_SITE_ID) 
--(select COUNTRY from XXSTG_CUST_SITES XCS where XCS.CUST_ID=XBH.CUST_ID and xcs.CUST_SITE_ID = xbh.CUST_SITE_ID) 
        city      city_name,
        country   country_name,
        xbh.valid_upto,
        xbh.extn_reason,
        xbh.extn_count,
        xbd.block_dtl_id,
        xbd.property_id,
        (
            SELECT
                xpm.property_number
            FROM
                xxpm_property_master xpm
            WHERE
                xpm.property_id = xbd.property_id
        ) property_number,
        (
            SELECT
                xpm.property_name
            FROM
                xxpm_property_master xpm
            WHERE
                xpm.property_id = xbd.property_id
        ) property_name,
        xbd.build_id,
        (
            SELECT
                xpb.build_number
            FROM
                xxpm_property_buildings xpb
            WHERE
                xpb.build_id = xbd.build_id
        ) build_number,
        (
            SELECT
                xpb.build_name
            FROM
                xxpm_property_buildings xpb
            WHERE
                xpb.build_id = xbd.build_id
        ) build_name,
        xbd.unit_id,
        (
            SELECT
                xpu.unit_number
            FROM
                xxpm_property_units xpu
            WHERE
                xpu.unit_id = xbd.unit_id
        ) unit_number,
        (
            SELECT
                xpu.unit_name
            FROM
                xxpm_property_units xpu
            WHERE
                xpu.unit_id = xbd.unit_id
        ) unit_name,
        xbd.unblock_flag,
        xbd.unblock_id,
        xbd.offer_dtl_id
    FROM
        xxpm_block_header     xbh,
        xxpm_block_detail     xbd,
        xxstg_cust_sites      xcs,
        xxstg_organizations   org
    WHERE
        xbh.block_id = xbd.block_id (+)
        AND xbh.cust_id = xcs.cust_id (+)
        AND xbh.cust_site_id = xcs.cust_site_id (+)
        AND xbh.org_id = org.org_id (+)
    ORDER BY
        xbh.block_id DESC
