--------------------------------------------------------
--  DDL for View XXPM_PAYMENT_CHARGE_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PAYMENT_CHARGE_PCS_V" ("MS_REV_ID", "BOOKING_HDR_ID", "BOOKING_NUMBER", "ORG_ID", "ORG_NAME", "FUNC_ID", "MS_REV_NUMBER", "MS_REV_DATE", "USAGE ", "OBJECT_VERSION_NUMBER", "STATUS", "DESCRIPTION", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "USER_GRP_ID", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN") AS 
  SELECT DISTINCT
        paychar.ms_rev_id,
        paychar.booking_hdr_id,
        bk.booking_number,
        paychar.org_id,
        org.org_name,
        paychar.func_id,
        paychar.ms_rev_number,
        paychar.ms_rev_date,
        paychar.usage,
        paychar.object_version_number,
        paychar.status,
        paychar.description,
        paychar.flow_status,
        paychar.flow_level,
        paychar.flow_with,
        paychar.user_grp_id,
        paychar.created_by,
        paychar.creation_date,
        paychar.last_updated_by,
        paychar.last_update_date,
        paychar.last_update_login
    FROM
        xxpm_book_ms_rev_hdr    paychar,
        xxstg_organizations     org,
        xxpm_booking_header_v   bk
    WHERE
        org.org_id (+) = paychar.org_id
        AND bk.booking_hdr_id = paychar.booking_hdr_id
