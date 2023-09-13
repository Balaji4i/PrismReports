--------------------------------------------------------
--  DDL for View XXPM_BLOCK_MILESTONE_DETAIL_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCK_MILESTONE_DETAIL_PCS_V" (
    "OFFER_MS_DTL_ID",
    "OFFER_HDR_ID",
    "MS_DTL_ID",
    "PL_MOD_ID",
    "SEQ_NUMBER",
    "INSTALLMENT_TYPE",
    "INSTALLMENT_TYPE_DISP",
    "INSTALLMENT_PCT",
    "INSTALLMENT_AMOUNT",
    "CHARGE_TYPE",
    "CHARGE_TYPE_DISP",
    "PAYMENT_TERM",
    "PAYMENT_TERM_DISP",
    "REMARKS",
    "DUE_DAYS",
    "DUE_DAYS_FROM",
    "DUE_DATE",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN",
    "MILESTONE_TYPE",
    "UOM",
    "QUANTITY",
    "RATE",
    "WAVE_OFF",
    "INSTALLMENT_METHOD",
    "INSTALLMENT_EVENT",
    "PERIOD_OCCURENCE",
    "PERIOD_VALUES",
    "PERIOD_DURATION",
    "INCLUDED_IN_RATE"
) AS
    SELECT
        bms.offer_ms_dtl_id,
        bms.offer_hdr_id,
        bms.ms_dtl_id,
        bms.pl_mod_id,
        bms.seq_number,
        bms.installment_type,
        lkv.lookup_value_name_disp    installment_type_disp,
        bms.installment_pct,
        bms.installment_amount,
        bms.charge_type,
        lkv1.lookup_value_name_disp   AS charge_type_disp,
        bms.payment_term,
        pay.term_name                 AS payment_term_disp,
        bms.remarks,
        bms.due_days,
        bms.due_days_from,
        bms.due_date,
        bms.created_by,
        bms.creation_date,
        bms.last_updated_by,
        bms.last_update_date,
        bms.last_update_login,
        bms.milestone_type,
        bms.uom,
        bms.quantity,
        bms.rate,
        bms.wave_off,
        bms.installment_method,
        nvl((
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_type_name LIKE '%BOOKING_EVENT%'
                AND lookup_value_name = bms.installment_event
        ), bms.installment_event) installment_event,
        bms.period_occurence,
        bms.period_values,
        bms.period_duration,
        bms.included_in_rate
    FROM
        xxpm_offer_milestone_detail   bms,
        xxfnd_lookup_v                lkv,
        xxfnd_lookup_v                lkv1,
        xxstg_pay_terms               pay
    WHERE
        bms.installment_type = lkv.lookup_value_name
        AND bms.charge_type = lkv1.lookup_value_name
        AND bms.payment_term = pay.term_id
    ORDER BY
        bms.ms_dtl_id