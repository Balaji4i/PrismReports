--------------------------------------------------------
--  DDL for View XXPM_CANCELLATION_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_CANCELLATION_PCS_V" ("CANCEL_ID", "FUNC_ID ", "LEASE_AGREEMENT_ID", "LEASE_NUMBER", "BOOKING_ID ", "BOOKING_NUMBER", "CANCEL_TYPE  ", "CANCEL_NUMBER ", "CANCEL_DATE", "FINAL_CANCEL_DATE", "CURRENCY ", "REFUND_AMOUNT", "OBJECT_VERSION_NUMBER", "DLD_CANCEL_STATUS", "DLD_CANCEL_DATE", "REASON  ", "REASON_DESC", "STATUS", "DESCRIPTION", "ORG_ID", "ORG_NAME", "USER_GRP_ID", "FLOW_STATUS", "FLOW_LEVEL ", "FLOW_WITH", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE ", "LAST_UPDATE_LOGIN", "FORFIET_AMOUNT", "USAGE ") AS 
  SELECT DISTINCT
        cn.cancel_id,
        cn.func_id,
        cn.lease_agreement_id,
        la.lease_number,
        cn.booking_id,
        bk.booking_number,
        cn.cancel_type,
        cn.cancel_number,
        trunc(cn.cancel_date),
        trunc(cn.final_cancel_date),
        cn.currency,
        cn.refund_amount,
        cn.object_version_number,
        cn.dld_cancel_status,
        cn.dld_cancel_date,
        cn.reason,
        cn.reason_desc,
        cn.status,
        cn.description,
        cn.org_id,
        og.org_name,
        cn.user_grp_id,
        cn.flow_status,
        cn.flow_level,
        cn.flow_with,
        cn.created_by,
        trunc(cn.creation_date),
        cn.last_updated_by,
        trunc(cn.last_update_date),
        cn.last_update_login,
        cn.forfiet_amount,
        cn.usage
    FROM
        xxpm_cancellation      cn,
        xxstg_organizations    og,
        xxpm_lease_agreement   la,
        xxpm_booking_header    bk
    WHERE
        og.org_id = cn.org_id
        AND la.lease_agreement_id = cn.lease_agreement_id
        AND bk.booking_hdr_id = cn.booking_id
