
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXPM_TEST"."XXPM_BOOKING_INVOICE_V" ("CHARGE_TYPE", "INVOICE_ID", "BOOKING_ID", "INVOICE_NUMBER", "MILESTONE_NAME", "INSTALLMENT_NAME", "PERCENTAGE", "INVOICE_AMOUNT", "INSTALLMENT_AMOUNT", "INVOICE_DATE", "DUE_DATE", "PAYMENT_TERMS", "INVOICE_DESCRIPTION", "INVOICE_STATUS", "INTERFACE_STATUS", "PAYMENT", "AR_INVOICE_NO", "TAX_AMOUNT", "TOTAL_INVOICE_AMOUNT", "AMOUNT_APPLIED", "BALANCE_AMT", "CUSTOMER_NAME") AS 
  SELECT 
BMS.CHARGE_TYPE,INV_HDR.INVOICE_ID AS INVOICE_ID,
INV_HDR.BOOKING_ID,
INV_HDR.INVOICE_NUMBER AS INVOICE_NUMBER,
MHDR.MILESTONE_NAME AS MILESTONE_NAME,               
(SELECT LOOKUP_VALUE_NAME_DISP FROM XXFND_LOOKUP_V WHERE LOOKUP_VALUE_NAME = INV_LINES.INSTALLMENT_TYPE AND LOOKUP_TYPE_NAME = 'MILESTONE_INSTALLMENT') AS INSTALLMENT_NAME,    
BMS.INSTALLMENT_PCT AS PERCENTAGE,                                                    
SUM(nvl(INV_LINES.AMOUNT,0)) AS INVOICE_AMOUNT,                             
BMS.INSTALLMENT_AMOUNT as INSTALLMENT_AMOUNT,                                       
INV_HDR.INVOICE_DATE  AS INVOICE_DATE,                                                    
INV_HDR.DUE_DATE  AS DUE_DATE,                                                    
PAY_TERMS.TERM_NAME AS PAYMENT_TERMS,                                                    
INV_LINES.DESCRIPTION AS INVOICE_DESCRIPTION,                                                    
LV.LOOKUP_VALUE_NAME_DISP AS INVOICE_STATUS,                                            
INV_HDR.INTERFACE_STATUS AS INTERFACE_STATUS,
INV_HDR.PAYMENT_TERMS AS PAYMENT,
INV_LINES.CUSTOMER_TRX_LINE_ID AS AR_INVOICE_NO,
SUM(nvl(INV_LINES.TAX_AMOUNT,0)) AS TAX_AMOUNT,
(SUM(nvl(INV_LINES.AMOUNT,0))+SUM(nvl(INV_LINES.TAX_AMOUNT,0))) as TOTAL_INVOICE_AMOUNT,  
NVL ( (xrd.amount_applied), 0) AMOUNT_APPLIED  ,  
(SUM(nvl(INV_LINES.AMOUNT,0))+SUM(nvl(INV_LINES.TAX_AMOUNT,0))) - NVL ((xrd.amount_applied), 0) as BALANCE_AMT, 
cus.CUSTOMER_NAME 
FROM XXPM_BOOKING_MILESTONES BMS,                                                    
XXPM_INVOICE_HEADER INV_HDR,                                                    
XXPM_MILESTONE_DTL MDTL,                                                    
XXPM_MILESTONE_HDR MHDR,                                                    
XXPM_INVOICE_LINES INV_LINES,                                                    
XXSTG_PAY_TERMS PAY_TERMS,                                                    
XXFND_LOOKUP_V LV,  
xxpm_receipt_details xrd, 
XXSTG_CUSTOMER cus 
WHERE BMS.INVOICE_ID IS NOT NULL                                    
AND BMS.INVOICE_ID=INV_HDR.INVOICE_ID                                                    
AND BMS.MS_DTL_ID = MDTL.MS_DTL_ID(+)                                                    
AND MDTL.MS_HDR_ID = MHDR.MS_HDR_ID(+)                                                    
AND PAY_TERMS.TERM_ID(+) = INV_HDR.PAYMENT_TERMS                                                    
AND INV_HDR.INVOICE_ID = INV_LINES.INVOICE_ID(+)                                                    
AND LV.LOOKUP_TYPE_NAME(+) = 'INVOICE_STATUS'                                                    
AND LV.LOOKUP_VALUE_NAME(+) = INV_HDR.STATUS  
and INV_HDR.invoice_id      = xrd.invoice_id(+)  
and cus.CUST_ID=INV_HDR.CUST_ID                             
GROUP BY                             
BMS.CHARGE_TYPE,INV_HDR.INVOICE_ID,                                                    
INV_HDR.INVOICE_NUMBER,
INV_HDR.BOOKING_ID,
MHDR.MILESTONE_NAME,                                     
INV_LINES.INSTALLMENT_TYPE,                                              
BMS.INSTALLMENT_PCT,                                  
BMS.INSTALLMENT_AMOUNT,                                       
INV_HDR.INVOICE_DATE,                                                    
INV_HDR.DUE_DATE,                                                    
PAY_TERMS.TERM_NAME,                                                    
INV_LINES.DESCRIPTION,                                                    
LV.LOOKUP_VALUE_NAME_DISP,                                            
INV_HDR.INTERFACE_STATUS,                                            
INV_HDR.PAYMENT_TERMS,                                            
INV_LINES.CUSTOMER_TRX_LINE_ID,  
xrd.amount_applied, 
cus.CUSTOMER_NAME;
