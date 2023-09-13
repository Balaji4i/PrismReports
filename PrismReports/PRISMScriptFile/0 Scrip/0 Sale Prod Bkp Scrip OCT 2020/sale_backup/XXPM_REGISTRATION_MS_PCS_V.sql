--------------------------------------------------------
--  DDL for View XXPM_REGISTRATION_MS_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_REGISTRATION_MS_PCS_V" ("OOKING_MS_DTL_ID  ", "ILESTONE_TYPE     ", "S_DTL_ID          ", "L_MOD_ID          ", "EQ_NUMBER         ", "NSTALLMENT_TYPE   ", "NSTALLMENT_PCT    ", "NSTALLMENT_AMOUNT ", "OM                ", "UANTITY           ", "ATE               ", "AVE_OFF           ", "LOOKUP_VALUE_NAME_DISP AS WAVE_OFF", "NCLUDED_IN_RATE   ", "NSTALLMENT_METHOD ", "NSTALLMENT_EVENT  ", "ERIOD_OCCURENCE   ", "ERIOD_VALUES      ", "ERIOD_DURATION    ", "HARGE_TYPE        ", "OOKUP_VALUE_NAME_DISP AS CHARGE_TYPE", "AYMENT_TERM  ", "EMARKS       ", "UE_DAYS      ", "UE_DAYS_FROM ", "UE_DATE      ", "REATED_BY    ", "REATION_DATE ", "AST_UPDATED_BY   ", "AST_UPDATE_DATE  ", "AST_UPDATE_LOGIN ", "OURCE_FUNC_ID    ", "OURCE_FUNC_REF_ID", "ILLING_ID  ", "TATUS      ", "NVOICE_ID ", "OOKING_HDR_ID", "INVOICE_NUMBER", "INVOICE_DATE ", "INTERFACE_STATUS", "LOOKUP_VALUE_NAME_DISP") AS 
  SELECT DISTINCT
        bm.booking_ms_dtl_id,
        bm.milestone_type,
        bm.ms_dtl_id,
        bm.pl_mod_id,
        bm.seq_number,
        bm.installment_type,
        bm.installment_pct,
        bm.installment_amount,
        bm.uom,
        bm.quantity,
        bm.rate,
        bm.wave_off,
        lk1.lookup_value_name_disp   AS wave_off,
        bm.included_in_rate,
        bm.installment_method,
        bm.installment_event,
        bm.period_occurence,
        bm.period_values,
        bm.period_duration,
        bm.charge_type,
        lk.lookup_value_name_disp    AS charge_type,
        bm.payment_term,
        bm.remarks,
        bm.due_days,
        bm.due_days_from,
        trunc(bm.due_date),
        bm.created_by,
        trunc(bm.creation_date),
        bm.last_updated_by,
        trunc(bm.last_update_date),
        bm.last_update_login,
        bm.source_func_id,
        bm.source_func_ref_id,
        bm.billing_id,
        bm.status,
        bm.invoice_id,
        bm.booking_hdr_id,
        inv.invoice_number,
        trunc(inv.invoice_date),
        inv.interface_status,
        lk2.lookup_value_name_disp
    FROM
        xxpm_booking_milestones   bm,
        xxfnd_lookup_v            lk,
        xxfnd_lookup_v            lk1,
        xxpm_invoice_header       inv,
        xxfnd_lookup_v            lk2
    WHERE
        lk.lookup_value_name = bm.charge_type
        AND lk1.lookup_value_name = bm.wave_off
        AND lk1.lookup_type_name = 'TERMINATION_BY'
        AND inv.invoice_id (+) = bm.invoice_id
        AND lk2.lookup_value_name = bm.milestone_type
