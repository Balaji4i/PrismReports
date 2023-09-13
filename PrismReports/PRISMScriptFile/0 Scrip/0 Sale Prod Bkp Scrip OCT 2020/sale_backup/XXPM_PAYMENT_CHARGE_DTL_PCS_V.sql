--------------------------------------------------------
--  DDL for View XXPM_PAYMENT_CHARGE_DTL_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PAYMENT_CHARGE_DTL_PCS_V" ("MS_REV_DTL_ID", "MS_REV_ID", "SOURCE_FUNC_ID", "SOURCE_FUNC_REF_ID", "MILESTONE_TYPE", "MILESTONE_TYPE_DISP", "MS_DTL_ID", "PL_MOD_ID", "SEQ_NUMBER", "INSTALLMENT_TYPE", "INSTALLMENT_TYPE_DISP,", "INSTALLMENT_PCT", "INSTALLMENT_AMOUNT", "UOM", "QUANTITY", "RATE", "WAVE_OFF", "INCLUDED_IN_RATE", "INSTALLMENT_METHOD", "INSTALLMENT_EVENT", "PERIOD_OCCURENCE", "PERIOD_VALUES", "PERIOD_DURATION", "CHARGE_TYPE", "CHARGE_TYPE_DISP,", "PAYMENT_TERM", "REMARKS", "DUE_DAYS", "DUE_DAYS_FROM", "DUE_DATE", "BILLING_ID", "STATUS", "INVOICE_ID", "INSTALLMENT_PCT_R", "INSTALLMENT_AMOUNT_R", "ACTION_FLAG", "ACTION_FLAG_DISP,", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "BOOKING_MS_DTL_ID") AS 
  SELECT DISTINCT
        paydtl.ms_rev_dtl_id,
        paydtl.ms_rev_id,
        paydtl.source_func_id,
        paydtl.source_func_ref_id,
        paydtl.milestone_type,
        lk1.lookup_value_name_disp   AS milestone_type_disp,
        paydtl.ms_dtl_id,
        paydtl.pl_mod_id,
        paydtl.seq_number,
        paydtl.installment_type,
        lk2.lookup_value_name_disp   AS installment_type_disp,
        paydtl.installment_pct,
        paydtl.installment_amount,
        paydtl.uom,
        paydtl.quantity,
        paydtl.rate,
        paydtl.wave_off,
        paydtl.included_in_rate,
        paydtl.installment_method,
        paydtl.installment_event,
        paydtl.period_occurence,
        paydtl.period_values,
        paydtl.period_duration,
        paydtl.charge_type,
        lk3.lookup_value_name_disp   AS charge_type_disp,
        paydtl.payment_term,
        paydtl.remarks,
        paydtl.due_days,
        paydtl.due_days_from,
        paydtl.due_date,
        paydtl.billing_id,
        paydtl.status,
        paydtl.invoice_id,
        paydtl.installment_pct_r,
        paydtl.installment_amount_r,
        paydtl.action_flag,
        lk4.lookup_value_name_disp   AS action_flag_disp,
        paydtl.created_by,
        trunc(paydtl.creation_date),
        paydtl.last_updated_by,
        trunc(paydtl.last_update_date),
        paydtl.last_update_login,
        paydtl.booking_ms_dtl_id
    FROM
        xxpm_book_ms_rev_dtl   paydtl,
        xxfnd_lookup_v         lk1,
        xxfnd_lookup_v         lk2,
        xxfnd_lookup_v         lk3,
        xxfnd_lookup_v         lk4
    WHERE
        lk1.lookup_value_name = paydtl.milestone_type
        AND lk1.lookup_type_name = 'MILESTONE_TYPE'
        AND lk2.lookup_value_name = paydtl.installment_type
        AND lk2.lookup_type_name = 'MILESTONE_INSTALLMENT'
        AND lk3.lookup_value_name = paydtl.charge_type
        AND lk3.lookup_type_name = 'CHARGE_TYPE'
        AND lk4.lookup_value_name = paydtl.action_flag
        AND lk4.lookup_type_name = 'ACTION'
