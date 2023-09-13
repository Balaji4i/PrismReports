--------------------------------------------------------
--  DDL for View XXPM_EXTEN_CANCEL_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_EXTEN_CANCEL_PCS_V" ("EXTN_CANCL_ID", "FUNC_ID", "LEASE_AGREEMENT_ID", "LEASE_NUMBER", "BOOKING_ID", "BOOKING_NUMBER", "TRANS_TYPE", "TRANS_NUMBER", "TRANS_DATE", "DUE_DATE", "AMOUNT", "CURRENCY", "STATUS", "DESCRIPTION", "ORG_ID", "ORG_NAME", "USER_GRP_ID", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "PROPERTY_ID", "BUILD_ID", "NUM_OF_REMAINING_DAYS", "REFUND_AMT_FOR_REMAINING_DAYS", "NET_REFUND_AMOUNT", "CANCELLATION_AMOUNT", "EXTENSION_DAYS", "OBJECT_VERSION_NUMBER") AS 
  SELECT DISTINCT
        ex.extn_cancl_id,
        ex.func_id,
        ex.lease_agreement_id,
        la.lease_number,
        ex.booking_id,
        bk.booking_number,
        ex.trans_type,
        ex.trans_number,
        trunc(ex.trans_date),
        trunc(ex.due_date),
        ex.amount,
        ex.currency,
        ex.status,
        ex.description,
        ex.org_id,
        og.org_name,
        ex.user_grp_id,
        ex.flow_status,
        ex.flow_level,
        ex.flow_with,
        ex.created_by,
        trunc(ex.creation_date),
        ex.last_updated_by,
        trunc(ex.last_update_date),
        ex.last_update_login,
        ex.property_id,
        ex.build_id,
        ex.num_of_remaining_days,
        ex.refund_amt_for_remaining_days,
        ex.net_refund_amount,
        ex.cancellation_amount,
        ex.extension_days,
        ex.object_version_number
    FROM
        xxpm_exten_cancel      ex,
        xxpm_lease_agreement   la,
        xxpm_booking_header    bk,
        xxstg_organizations    og
    WHERE
        la.lease_agreement_id = ex.lease_agreement_id
        AND bk.booking_hdr_id = ex.booking_id
        AND og.org_id = ex.org_id
