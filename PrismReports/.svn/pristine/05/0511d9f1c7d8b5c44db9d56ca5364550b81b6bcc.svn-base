--------------------------------------------------------
--  DDL for View XXPM_BOOKING_MILESTONES_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKING_MILESTONES_PCS_V" (
    "ROW_ID",
    "BOOKING_HDR_ID",
    "BOOKING_MS_DTL_ID",
    "MILESTONE_TYPE",
    "MS_DTL_ID",
    "PL_MOD_ID",
    "SEQ_NUMBER",
    "INSTALLMENT_TYPE",
    "INSTALLMENT_TYPE_DESC",
    "INSTALLMENT_PCT",
    "INSTALLMENT_AMOUNT",
    "UOM",
    "QUANTITY",
    "RATE",
    "WAVE_OFF",
    "INCLUDED_IN_RATE",
    "INSTALLMENT_METHOD",
    "INSTALLMENT_METHOD_DESC",
    "INSTALLMENT_EVENT",
    "PERIOD_OCCURENCE",
    "PERIOD_VALUES",
    "PERIOD_DURATION",
    "CHARGE_TYPE",
    "CHARGE_TYPE_DESC",
    "PAYMENT_TERM",
    "REMARKS",
    "DUE_DAYS",
    "DUE_DAYS_FROM",
    "DUE_DATE",
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
    "SOURCE_FUNC_ID",
    "SOURCE_FUNC_REF_ID",
    "BILLING_ID",
    "STATUS",
    "INVOICE_ID"
) AS
    SELECT DISTINCT
        xbm.rowid,
        xbm.booking_hdr_id,
        xbm.booking_ms_dtl_id,
        xbm.milestone_type,
        xbm.ms_dtl_id,
        xbm.pl_mod_id,
        xbm.seq_number,
        xbm.installment_type,
        DECODE(xbm.milestone_type, 'MS',(
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_type_name = 'MILESTONE_INSTALLMENT'
                AND lookup_value_name = xbm.installment_type
        ), xbm.installment_type) AS lookup_value_name_disp,
        xbm.installment_pct,
        xbm.installment_amount,
        xbm.uom,
        xbm.quantity,
        xbm.rate,
        xbm.wave_off,
        xbm.included_in_rate,
        xbm.installment_method,
        lk2.lookup_value_name_disp,
        (
            SELECT
                installment_event
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS installment_event,
        (
            SELECT
                period_occurence
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS period_occurence,
        (
            SELECT
                period_values
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS period_values,
        xbm.period_duration,
        (
            SELECT
                charge_type
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS charge_type,
        lk3.lookup_value_name_disp,
        xbm.payment_term,
        xbm.remarks,
        xbm.due_days,
        xbm.due_days_from,
        xbm.due_date,
        xbm.attribute_category,
        xbm.attribute1,
        xbm.attribute2,
        xbm.attribute3,
        xbm.attribute4,
        xbm.attribute5,
        xbm.attribute6,
        xbm.attribute7,
        xbm.attribute8,
        xbm.attribute9,
        xbm.attribute10,
        xbm.created_by,
        trunc(xbm.creation_date) AS creation_date,
        xbm.last_updated_by,
        trunc(xbm.last_update_date) AS last_update_date,
        xbm.last_update_login,
        xbm.source_func_id,
        xbm.source_func_ref_id,
        xbm.billing_id,
        xbm.status,
        xbm.invoice_id
    FROM
        xxpm_booking_milestones   xbm,
        xxfnd_lookup_v            lk1,
        xxfnd_lookup_v            lk2,
        xxfnd_lookup_v            lk3
    WHERE
        lk2.lookup_type_name (+) = 'MILESTONE_METHOD'
        AND lk2.lookup_value_name (+) = xbm.installment_method
        AND lk3.lookup_type_name (+) = 'CHARGE_TYPE'
        AND lk3.lookup_value_name (+) = xbm.charge_type