--------------------------------------------------------
--  DDL for Procedure INV_CNCL_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INV_CNCL_AMT" (
   p_invoice_id   IN     NUMBER
  ,p_inv_amount      OUT NUMBER
  ,p_amount_applied   OUT NUMBER
  ,p_bal_amount      OUT NUMBER
  ,p_can_amount      OUT NUMBER)
AS
   CURSOR cur_ins_amt
   IS
      SELECT NVL (xbm.installment_amount, 0) installment_amount
            ,NVL (xc.refund_amount, 0) refund_amount
        FROM xxpm_invoice_header xih
            ,xxpm_invoice_lines xil
            ,xxpm_booking_milestones xbm
            ,xxpm_cancellation xc
       WHERE     xih.invoice_id = xil.invoice_id
             AND xih.invoice_id = xbm.invoice_id
             AND xbm.source_func_ref_id = xc.cancel_id
             AND xil.charge_type = 'CN_CHG'
             AND xih.invoice_id = p_invoice_id;

   CURSOR cur_inv_amt
   IS
        SELECT   SUM (NVL (xil.amount, 0))
               + SUM (NVL (xil.tax_amount, 0))
                  inv_amount
              ,xil.invoice_id
          FROM xxpm_invoice_lines xil
         WHERE xil.invoice_id = p_invoice_id
      GROUP BY xil.invoice_id;

   l_can_amount   NUMBER := NULL;
   l_inv_amount   NUMBER := NULL;
   l_amount_applied NUMBER := NULL;
   l_receipt_amount number:=Null;
   l_cmc_balance number :=null;
   l_bal_amount   NUMBER := NULL;
   l_flag         VARCHAR2 (2) := 'N';
BEGIN
   FOR i IN cur_ins_amt
   LOOP
      l_flag      := 'C';

      IF     i.refund_amount IS NOT NULL
         AND i.installment_amount IS NOT NULL
      THEN
         IF i.installment_amount < i.refund_amount
         THEN
            l_can_amount := 0;
         ELSE
            l_can_amount := i.installment_amount- i.refund_amount;
         END IF;
      END IF;
   END LOOP;

   --
   FOR j IN cur_inv_amt
   LOOP
      l_inv_amount := j.inv_amount;
-- receipt amount 
      BEGIN
         SELECT NVL (SUM (amount_applied), 0)
           INTO l_receipt_amount
           FROM xxpm_receipt_details
          WHERE invoice_id = j.invoice_id;

      EXCEPTION
         WHEN OTHERS
         THEN
            l_receipt_amount := 0;
      END;
--- refund amount table
        BEGIN
         SELECT  
            NVL(SUM(BALANCE),0)
            into l_cmc_balance
            FROM 
            XXPM_APPLY_CREDIT_MEMO where 
            invoice_id= j.invoice_id;

      EXCEPTION
         WHEN OTHERS
         THEN
            l_cmc_balance := 0;
      END;

      l_amount_applied:=l_receipt_amount+l_cmc_balance;

      DBMS_OUTPUT.put_line ('test--l_amount_applied==>'||l_amount_applied);

      l_amount_applied := NVL (l_amount_applied, 0);

      l_bal_amount := l_inv_amount- l_amount_applied;


      DBMS_OUTPUT.put_line (
            ' l_inv_amount ==>'
         || l_inv_amount
         || ' l_amount_applied ==>'
         || l_amount_applied
         || ' l_bal_amount==> '
         || l_bal_amount);
   END LOOP;

   IF     l_flag = 'C' AND l_can_amount = 0
   THEN
      l_amount_applied := l_inv_amount;
   END IF;

   p_inv_amount := l_inv_amount;
   p_amount_applied := l_amount_applied;
   p_bal_amount := l_bal_amount;
   p_can_amount := l_can_amount;
END;
