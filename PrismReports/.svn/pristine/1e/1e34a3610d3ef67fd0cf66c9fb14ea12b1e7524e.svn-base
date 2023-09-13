--------------------------------------------------------
--  DDL for View XXPM_UNBLOCKING_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_UNBLOCKING_V" ("UNBLOCK_ID", "BLOCK_ID", "UNBLOCK_NUMBER", "UNBLOCK_DATE", "ORG_ID", "ORG_NAME", "STATUS", "DESCRIPTION", "FUNC_ID", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "USER_GRP_ID", "USAGE", "LEAD_ID", "BLOCK_NUMBER", "BLOCK_DATE", "BLOCK_TYPE", "BLOCKED_BY", "RECEIPT_YN", "OFFER_HDR_ID", "VALID_UPTO", "EXTN_REASON", "EXTN_COUNT", "OFFER_NUMBER", "CUST_ID", "CUSTOMER_NAME", "CUST_SITE_ID", "BLOCK_DTL_ID", "PROPERTY_ID", "PROPERTY_NUMBER", "PROPERTY_NAME", "BUILD_ID", "BUILD_NUMBER", "BUILD_NAME", "UNIT_ID", "UNIT_NUMBER", "UNIT_NAME", "UNBLOCK_FLAG", "OFFER_DTL_ID") AS 
  SELECT
        xuh.unblock_id,
        xuh.block_id,
        xuh.unblock_number,
        xuh.unblock_date,
        xuh.org_id,
        (
            SELECT
                org_name
            FROM
                xxstg_organizations org
            WHERE
                org.org_id = xuh.org_id
        ) org_name,
        xuh.status,
        xuh.description,
        xuh.func_id,
        xuh.flow_status,
        xuh.flow_level,
        xuh.flow_with,
        xuh.user_grp_id,
        xbh.usage,
        xbh.lead_id,
        xbh.block_number,
        xbh.block_date,
        xbh.block_type,
        xbh.blocked_by,
        xbh.receipt_yn,
        xbh.offer_hdr_id,
        xbh.valid_upto,
        xbh.extn_reason,
        xbh.extn_count,
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
        xbd.offer_dtl_id
    FROM
        xxpm_unblock_header   xuh,
        xxpm_block_header     xbh,
        xxpm_block_detail     xbd,
        xxpm_unblock_detail   xud
    WHERE
        xuh.block_id = xbh.block_id
        AND xbh.block_id = xbd.block_id
        and xud.BLOCK_DTL_ID=xbd.BLOCK_DTL_ID
