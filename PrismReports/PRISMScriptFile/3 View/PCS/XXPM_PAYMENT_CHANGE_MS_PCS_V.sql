--------------------------------------------------------
--  DDL for View XXPM_PAYMENT_CHANGE_MS_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PAYMENT_CHANGE_MS_PCS_V" (
    "MS_REV_DTL_ID",
    "MILESTONE_TYPE",
    "INSTALLMENT_PCT",
    "INSTALLMENT_METHOD",
    "INSTALLMENT_EVENT",
    "SEQ_NUMBER",
    "INSTALLMENT_AMOUNT",
    "INSTALLMENT_PCT_R",
    "INSTALLMENT_AMOUNT_R",
    "CHARGE_TYPE",
    "CHARGE_TYPE_DISP",
    "INSTALLMENT_TYPE_DISP",
    "INSTALLMENT_TYPE",
    "PAYMENT_TERM",
    "PAYMENT_TERM_DISP",
    "DUE_DAYS",
    "DUE_DATE",
    "INVOICE_ID",
    "INVOICE_NUMBER",
    "MS_REV_ID"
) AS
    SELECT DISTINCT
        xbmrd.ms_rev_dtl_id,
        xbmrd.milestone_type,
        xbmrd.installment_pct,
        xbmrd.installment_method,
        xbmrd.installment_event,
        xbmrd.seq_number,
        xbmrd.installment_amount,
        xbmrd.installment_pct_r,
        xbmrd.installment_amount_r,
        xbmrd.charge_type,
        lkv1.lookup_value_name_disp   AS charge_type_disp,
        lkv.lookup_value_name_disp    installment_type_disp,
        xbmrd.installment_type,
        xbmrd.payment_term,
        pay.term_name                 AS payment_term_disp,
        xbmrd.due_days,
        trunc(xbmrd.due_date),
        xbmrd.invoice_id,
        xih.invoice_number,
        xbmrd.ms_rev_id --added on 23-May
    FROM
        xxpm_book_ms_rev_dtl   xbmrd,
        xxpm_invoice_header    xih,
        xxfnd_lookup_v         lkv,
        xxfnd_lookup_v         lkv1,
        xxstg_pay_terms        pay
    WHERE
        xih.invoice_id (+) = xbmrd.invoice_id
        AND xbmrd.installment_type = lkv.lookup_value_name (+)
    --and LKV.LOOKUP_TYPE_NAME='MILESTONE_INSTALLMENT'
        AND xbmrd.charge_type = lkv1.lookup_value_name (+)
        AND lkv1.lookup_type_name = 'CHARGE_TYPE'
        AND xbmrd.payment_term = pay.term_id (+)