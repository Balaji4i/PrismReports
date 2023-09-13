--------------------------------------------------------
--  DDL for View APPLY_CREDIT_MEMO_REFUND_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "APPLY_CREDIT_MEMO_REFUND_V" ("BOOKING_ID", "CREDITMEMOTRXNUMBER", "AMOUNTAPPLIED", "APPLYDATE", "GLDATE", "ORG_ID", "CREDITMEMOBUSINESSUNIT", "REFUNDPAYMENTMETHODNAME") AS 
  with
inv_number as (
SELECT
inv.INVOICE_NUMBER,
inv.booking_id
FROM xxpm_invoice_header inv, xxpm_invoice_lines invl
where
inv.INVOICE_ID=invl.INVOICE_ID
and invl.LINE_TYPE='LINE'
and invl.CHARGE_TYPE='CMC'
and inv.TRX_TYPE='Customer Adjustment'
),
canceldtl
as (SELECT
can.BOOKING_ID
,can.REFUND_AMOUNT
,can.CANCEL_DATE as ApplyDate
,can.CANCEL_DATE as GlDate
,can.ORG_ID
,org.ORG_NAME
FROM
xxpm_cancellation can, xxstg_organizations org
where
can.ORG_ID=org.ORG_ID)
select
candtl.BOOKING_ID
,inv.INVOICE_NUMBER as CreditMemoTrxNumber
,candtl.REFUND_AMOUNT as AmountApplied
,candtl.ApplyDate
,candtl.GlDate
,candtl.ORG_ID
,candtl.ORG_NAME as CreditMemoBusinessUnit
,'Electronic' as RefundPaymentMethodName
from canceldtl candtl, inv_number inv
where
candtl.BOOKING_ID=inv.booking_id
--and candtl.booking_id=626;
