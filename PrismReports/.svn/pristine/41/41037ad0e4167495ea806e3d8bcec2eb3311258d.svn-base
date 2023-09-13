--------------------------------------------------------
--  DDL for View APPLY_CREDIT_MEMO_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "APPLY_CREDIT_MEMO_V" ("s_no", "BOOKING_ID", "ORG_ID", "ORG_NAME", "INVOICE_ID", "CREDIT_MEMO_TRX_NUMBER", "INVOICE_NUMBER", "APPLYDATE", "GLDATE", "INV_AMT", "APPLIED_RECEIPT_AMOUNT", "BALANCE") AS 
  WITH cmc_inv
     AS (SELECT invh.invoice_number, invh.booking_id
           FROM xxpm_invoice_header invh, xxpm_invoice_lines invl
          WHERE     invh.invoice_id = invl.invoice_id
           AND invh.invoice_id = invh.invoice_id + 0
                  AND invl.invoice_id = invl.invoice_id + 0
                AND NVL (invl.charge_type, 'XXX') IN ('CMC')
                AND invl.line_type = 'LINE' --            and invh.booking_id=626
                                           ),
     amountapplied
     AS (  SELECT inv_hdr.booking_id,
                  rd.invoice_id,
                  SUM (rd.amount_applied) AS applied_receipt_amount
             FROM xxpm_invoice_header inv_hdr,
                  xxpm_receipt_details rd,
                  xxpm_receipt r
            WHERE     inv_hdr.invoice_id = rd.invoice_id
                  AND inv_hdr.invoice_id = inv_hdr.invoice_id + 0
                  AND r.receipt_id = rd.receipt_id
                  AND r.receipt_id = r.receipt_id + 0
         GROUP BY inv_hdr.booking_id, rd.invoice_id),
     inv_amt
     AS (  SELECT inv.booking_id,
                  inv.org_id,
                  inv.invoice_id,
                  inv.invoice_number,
                  SUM (NVL (invl.amount, 0) + NVL (invl.tax_amount, 0)) inv_amt
             FROM xxpm_invoice_header inv, xxpm_invoice_lines invl
            WHERE     inv.invoice_id = invl.invoice_id
                  AND inv.invoice_id = inv.invoice_id + 0
                  AND invl.invoice_id = invl.invoice_id + 0
                  AND NVL (inv.trx_type, 'XXX') NOT IN ('Customer Adjustment')
         GROUP BY inv.booking_id,
                  inv.org_id,
                  inv.invoice_id,
                  inv.invoice_number)
SELECT ROWNUM,
       inv.booking_id,
       inv.org_id,
       org.org_name,
       inv.invoice_id,
       cinv.invoice_number AS credit_memo_trx_number,
       inv.invoice_number,
       can.cancel_date AS applydate,
       can.cancel_date AS gldate,
       inv.inv_amt,
       NVL (rd.applied_receipt_amount, 0),
       NVL ( (inv.inv_amt - NVL (rd.applied_receipt_amount, 0)), 0)
          AS balance
  FROM inv_amt inv,
       amountapplied rd,
       cmc_inv cinv,
       xxstg_organizations org,
       xxpm_cancellation can
 WHERE     inv.invoice_id = rd.invoice_id(+)
       AND cinv.booking_id = inv.booking_id
       AND org.org_id = inv.org_id
       AND NVL ( (inv.inv_amt - NVL (rd.applied_receipt_amount, 0)), 0) <> 0
       AND can.booking_id = inv.booking_id
       AND can.booking_id = can.booking_id + 0
