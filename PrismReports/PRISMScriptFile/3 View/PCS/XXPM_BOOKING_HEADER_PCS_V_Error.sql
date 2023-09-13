--------------------------------------------------------
--  DDL for View XXPM_BOOKING_HEADER_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKING_HEADER_PCS_V" (
    "ROW_ID",
    "BOOKING_HDR_ID",
    "ORG_ID",
    "FUNC_ID",
    "PROPERTY_ID",
    "PROPERTY_NAME",
    "OFFER_HDR_ID",
    "OFFER_NUMBER",
    "BLOCK_ID",
    "BLOCK_NUMBER",
    "CUST_ID",
    "CUSTOMER_NAME",
    "BOOKING_NUMBER",
    "BOOKING_DATE",
    "BOOKING_END_DATE",
    "BOOKING_FROM_DATE",
    "BOOKING_TO_DATE",
    "SPA_PCT",
    "AREA_VARIATION_PCT",
    "USAGE",
    "USAGEDESC",
    "BOOKING_EXE_BY",
    "EMPLOYEE_NAME",
    "REVISION_NO",
    "REVISION_DATE",
    "REVISED_BY",
    "MS_HDR_ID",
    "MILESTONE_NAME",
    "PL_ID",
    "PL_NAME",
    "BOOKING_TYPE",
    "BOOKING_TYPE_DESC",
    "BOOKING_STAGE",
    "BOOKING_STAGE_DESC",
    "LEAD_ID",
    "SALESMAN_ID",
    "CURRENCY_CODE",
    "CURRENCY_DESC",
    "CHECKLIST",
    "CHECKLIST_DESC",
    "TERMS_DESC",
    "OBJECT_VERSION_NUMBER",
    "BOOKING_FLAG",
    "TAX_CODE",
    "PREV_BOOKING_ID",
    "LEAD_SOURCE_CHANNEL",
    "LEAD_SOURCE_NAME",
    "VEND_ID",
    "VEND_SITE_ID",
    "VEND_CONTRACT_NO",
    "STATUS",
    "STATUS_DESC",
    "DESCRIPTION",
    "FLOW_STATUS",
    "FLOW_LEVEL",
    "FLOW_WITH",
    "USER_GRP_ID",
    "ATTRIBUTE_CATEGORY",
    "ATTRIBUTE1",
    "ATTRIBUTE2",
    "ATTRIBUTE3",
    "ATTRIBUTE4",
    "ATTRIBUTE5",
    "ATTRIBUTE6",
    "ATTRIBUTE7",
    "ATTRIBUTE8",
    "ATTRIBUTE9",
    "ATTRIBUTE10",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN",
    "ORG_NAME",
    "LINE",
    "MS",
    "FIX",
    "CHARGE",
    "BOOKINGTOTAL"
) AS
    SELECT DISTINCT
        bh.rowid,
        bh.booking_hdr_id,
        bh.org_id,
        bh.func_id,
        bh.property_id,
        (
            SELECT
                property_name
            FROM
                xxpm_property_master
            WHERE
                property_id = bh.property_id
        ) property_name,
        bh.offer_hdr_id,
        xoh.offer_number,
        bh.block_id,
        xbl.block_number,
        (
            SELECT
                xsc.cust_id
            FROM
                xxstg_customer xsc
            WHERE
                xoh.customer_id = xsc.cust_id
        ) cust_id,
        (
            SELECT
                xsc.customer_name
            FROM
                xxstg_customer xsc
            WHERE
                xoh.customer_id = xsc.cust_id
        ) customer_name,
        bh.booking_number,
        trunc(bh.booking_date) AS booking_date,
        trunc(bh.booking_end_date) AS booking_end_date,
        trunc(bh.booking_from_date) AS booking_from_date,
        trunc(bh.booking_to_date) AS booking_to_date,
        bh.spa_pct,
        bh.area_variation_pct,
        bh.usage,
        lk.lookup_value_name_disp,
        bh.booking_exe_by,
        xe.employee_name,
        bh.revision_no,
        trunc(bh.revision_date) AS revision_date,
        bh.revised_by,
        bh.ms_hdr_id,
        xmh.milestone_name,
        bh.pl_id,
        xpl.pl_name,
        bh.booking_type,
        lk5.lookup_value_name_disp,
        bh.booking_stage,
        lk4.lookup_value_name_disp,
        bh.lead_id,
        bh.salesman_id,
        bh.currency_code,
        lk1.lookup_value_name_disp,
        bh.checklist,
        lk2.lookup_value_name_disp,
        bh.terms_desc,
        bh.object_version_number,
        bh.booking_flag,
        bh.tax_code,
        bh.prev_booking_id,
        bh.lead_source_channel,
        bh.lead_source_name,
        bh.vend_id,
        bh.vend_site_id,
        bh.vend_contract_no,
        bh.status,
        lk3.lookup_value_name_disp,
        bh.description,
        bh.flow_status,
        bh.flow_level,
        bh.flow_with,
        bh.user_grp_id,
        bh.attribute_category,
        bh.attribute1,
        bh.attribute2,
        bh.attribute3,
        bh.attribute4,
        bh.attribute5,
        bh.attribute6,
        bh.attribute7,
        bh.attribute8,
        bh.attribute9,
        bh.attribute10,
        bh.created_by,
        trunc(bh.creation_date) AS creation_date,
        bh.last_updated_by,
        trunc(bh.last_update_date) AS last_update_date,
        bh.last_update_login,
        xo.org_name,
        nvl(xxpm_booking.getbookingtotal(bh.booking_hdr_id), 0) AS line,
        nvl(xxpm_booking.getmilestone_amt(bh.booking_hdr_id, 'MS'), 0) AS ms,
        nvl(xxpm_booking.getmilestone_amt(bh.booking_hdr_id, 'FIX'), 0) AS fix,
        nvl(xxpm_booking.getmilestone_amt(bh.booking_hdr_id, 'CHARGE'), 0) AS charge, 
--  (nvl(xxpm_booking.getmileStone_amt(bh.booking_hdr_id,'MS'),0) + 
        ( nvl(xxpm_booking.getmilestone_amt(bh.booking_hdr_id, 'FIX'), 0) + nvl(xxpm_booking.getmilestone_amt(bh.booking_hdr_id, 'CHARGE'
        ), 0) + nvl(xxpm_booking.getbookingtotal(bh.booking_hdr_id), 0) ) AS total
    FROM
        xxpm_booking_header   bh,
        xxpm_offer_header     xoh,
        xxpm_block_header     xbl,
        xxfnd_lookup_v        lk,
        xxfnd_lookup_v        lk1,
        xxfnd_lookup_v        lk2,
        xxfnd_lookup_v        lk3,
        xxfnd_lookup_v        lk4,
        xxfnd_lookup_v        lk5,
        xxpm_milestone_hdr    xmh,
        xxpm_pl_header        xpl,
        xxstg_employee        xe,
        xxstg_organizations   xo
  --,XXPM_BOOKING_MILESTONES bm
    WHERE
        xoh.offer_hdr_id (+) = bh.offer_hdr_id
        AND xbl.block_id (+) = bh.block_id
--and bm.BOOKING_HDR_ID = bh.BOOKING_HDR_ID
        AND lk.lookup_type_name (+) = 'USAGE'
        AND lk.lookup_value_name (+) = bh.usage
        AND xmh.ms_hdr_id (+) = bh.ms_hdr_id
        AND xpl.pl_id (+) = bh.pl_id
        AND lk1.lookup_type_name (+) = 'CURRENCY'
        AND lk1.lookup_value_name (+) = bh.currency_code
        AND lk2.lookup_type_name (+) = 'BOOKING_CHECKLIST'
        AND lk2.lookup_value_name (+) = bh.checklist
        AND lk3.lookup_type_name (+) = 'BOOKING_STATUS'
        AND lk3.lookup_value_name (+) = bh.status
        AND lk4.lookup_type_name (+) = 'BOOKING_STAGE'
        AND lk4.lookup_value_name (+) = bh.booking_stage
        AND lk5.lookup_type_name (+) = 'BOOKING_TYPE'
        AND lk5.lookup_value_name (+) = bh.booking_type
--AND bh.usage ='Sales'
        AND xe.emp_id (+) = bh.booking_exe_by
        AND xo.org_id = bh.org_id
    ORDER BY
        bh.booking_hdr_id DESC