--------------------------------------------------------
--  DDL for View XXPM_MILESTONES_CREDIT_MEMO_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MILESTONES_CREDIT_MEMO_V" ("BOOKING_MS_DTL_ID", "BOOKING_HDR_ID", "SOURCE_FUNC_ID", "INVOICE_ID", "INSTALLMENT_AMOUNT", "INVOICE_AMOUNT", "AMOUNT_APPLIED") AS 
  SELECT
    bm.booking_ms_dtl_id,
    bm.booking_hdr_id,
    bm.source_func_id,
    bm.invoice_id,
    bm.installment_amount as installment_amount,
    (SELECT sum(nvl(AMOUNT,0)) FROM xxpm_invoice_lines where invoice_id=bm.invoice_id)as invoice_amount,
    SUM(nvl((rd.amount_applied), 0)) amount_applied
FROM
    xxpm_booking_milestones bm, xxpm_invoice_header inv, xxpm_receipt_details rd
WHERE
inv.invoice_id=bm.invoice_id
and rd.invoice_id=inv.invoice_id
and inv.INTERFACE_STATUS='INVOICED'
--and bm.booking_ms_dtl_id = 9001
group by 
    bm.booking_ms_dtl_id,
    bm.booking_hdr_id,
    bm.source_func_id,
    bm.invoice_id,
    bm.installment_amount
