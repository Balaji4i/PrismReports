CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXPM_BOOKING_INVOICE_V" ("CHARGE_TYPE", "INVOICE_ID", "BOOKING_ID", "INVOICE_NUMBER", "MILESTONE_NAME", "INSTALLMENT_NAME", "PERCENTAGE", "INVOICE_AMOUNT", "INSTALLMENT_AMOUNT", "INVOICE_DATE", "DUE_DATE", "PAYMENT_TERMS", "INVOICE_DESCRIPTION", "INVOICE_STATUS", "INTERFACE_STATUS", "PAYMENT", "AR_INVOICE_NO", "TAX_AMOUNT", "TOTAL_INVOICE_AMOUNT", "AMOUNT_APPLIED", "BALANCE_AMT", "CUSTOMER_NAME", "CUST_ID") AS 
  with 
invoice_hdr
        as (SELECT 
        INV_HDR.INVOICE_ID AS INVOICE_ID,
        INV_HDR.BOOKING_ID,
        INV_HDR.INVOICE_NUMBER AS INVOICE_NUMBER,
        INV_HDR.INVOICE_DATE  AS INVOICE_DATE,                                                    
        INV_HDR.DUE_DATE  AS DUE_DATE,
        INV_HDR.INTERFACE_STATUS AS INTERFACE_STATUS,
        INV_HDR.PAYMENT_TERMS AS PAYMENT,
        PAY_TERMS.TERM_NAME,
        INV_HDR.CUST_ID,
        cus.CUSTOMER_NAME,
        BMS.INSTALLMENT_AMOUNT as INSTALLMENT_AMOUNT
        ,BMS.INSTALLMENT_PCT AS PERCENTAGE
        ,BMS.CHARGE_TYPE
        FROM XXPM_INVOICE_HEADER INV_HDR , XXSTG_PAY_TERMS PAY_TERMS, XXSTG_CUSTOMER cus, XXPM_BOOKING_MILESTONES BMS, 
        xxfnd_lookup_v lk
        where 
        PAY_TERMS.TERM_ID= INV_HDR.PAYMENT_TERMS
        and cus.CUST_ID=INV_HDR.CUST_ID
        AND BMS.INVOICE_ID=INV_HDR.INVOICE_ID
        and INV_HDR.INVOICE_ID=INV_HDR.INVOICE_ID+0
        and lk.LOOKUP_TYPE_NAME='CHARGE_TYPE'
        and lk.lookup_value_name = BMS.CHARGE_TYPE
--        and INV_HDR.booking_id=532
        ),
invoice_lns 
        as (SELECT 
        invh.booking_id,
        invh.INVOICE_ID, 
        SUM(nvl(invl.AMOUNT,0)) AS INVOICE_AMOUNT,
        SUM(nvl(invl.TAX_AMOUNT,0)) AS TAX_AMOUNT,
        invl.DESCRIPTION AS INVOICE_DESCRIPTION,
        lk.lookup_value_name_disp as INSTALLMENT_NAME,
        (SUM(nvl(invl.AMOUNT,0))+SUM(nvl(invl.TAX_AMOUNT,0))) as TOTAL_INVOICE_AMOUNT
         
        FROM XXPM_INVOICE_LINES invl, XXPM_INVOICE_HEADER invh,  xxfnd_lookup_v lk
        where 
        invl.INVOICE_ID=invh.INVOICE_ID
        and invl.INVOICE_ID=invl.INVOICE_ID+0
        and lk.lookup_type_name = 'MILESTONE_INSTALLMENT'
        and lk.lookup_value_name = invl.installment_type
--        and invh.booking_id=2670
        group by 
        invh.INVOICE_ID
        ,invl.DESCRIPTION
        ,lk.lookup_value_name_disp
        ,invh.booking_id
        ),
receipt_dtl 
        as (
        SELECT 
        inv.booking_id as rtl_booking_id,
        inv.INVOICE_ID as rtl_inv_id,
        sum(NVL((rd.amount_applied), 0)) as amount_applied 
        FROM 
        XXPM_INVOICE_HEADER inv,xxpm_receipt_details rd
        where inv.INVOICE_ID=rd.INVOICE_ID
        and inv.INVOICE_ID=inv.INVOICE_ID+0
--        and inv.booking_id=2670
        group by 
        inv.booking_id,
        inv.INVOICE_ID
)
       
select 
inv.CHARGE_TYPE
,inv.INVOICE_ID
,inv.BOOKING_ID
,inv.INVOICE_NUMBER
,NULL as MILESTONE_NAME 
,invl.INSTALLMENT_NAME
,inv.PERCENTAGE
,invl.INVOICE_AMOUNT
,inv.INSTALLMENT_AMOUNT
,inv.INVOICE_DATE
,inv.DUE_DATE
,inv.TERM_NAME as PAYMENT_TERMS
,invl.INVOICE_DESCRIPTION
,NULL as INVOICE_STATUS
,inv.INTERFACE_STATUS
,inv.PAYMENT
,NULL as AR_INVOICE_NO
,invl.TAX_AMOUNT
,invl.TOTAL_INVOICE_AMOUNT
,rdl.amount_applied
,NVL(invl.TOTAL_INVOICE_AMOUNT,0)-NVL(rdl.amount_applied,0) as BALANCE_AMT
,inv.CUSTOMER_NAME
,inv.CUST_ID
from 
invoice_hdr inv,  invoice_lns invl, receipt_dtl rdl
where 
inv.INVOICE_ID=invl.INVOICE_ID
and inv.booking_id=invl.booking_id
and rdl.rtl_inv_id(+)=invl.INVOICE_ID;
