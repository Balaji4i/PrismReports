  CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXPM_BOOKING_DASHBOARD_V" ("BOOKING_HDR_ID", "ORG_ID", "FUNC_ID", "BOOKING_NUMBER", "BOOKING_DATE", "USAGE", "MS_HDR_ID", "PL_ID", "CURRENCY_CODE", "BOOKING_STATUS", "STATUS_DISP", "BOOKING_DTL_ID", "PROPERTY_ID", "BUILDING_ID", "UNIT_ID", "UOM", "BOOKING_RATE", "BOOKING_AMOUNT", "DISC_PCT", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "UNIT_NUMBER", "UNIT_SHORTCODE", "STATUS", "UNIT_CATEGORY", "BUILD_NAME", "BUILD_NUMBER", "PROPERTY_NAME", "PROPERTY_NUMBER", "BOOKING_CUST_ID", "CUST_ID", "SHIP_TO_SITE_ID", "BILL_TO_SITE_ID", "CUSTOMER_NUMBER", "CUSTOMER_NAME", "MILESTONE_NAME", "MILESTONE_NUMBER", "PL_NUMBER", "ORG_NAME", "ORG_NAME_TL", "INSTALLMENTAMOUNT", "INVOICED_AMOUNT", "UN_INVOICE", "RECEIPT_AMOUNT", "APPLIED_RECEIPT_AMOUNT", "BALANCE_AMT") AS 
  with booking_hdr as (SELECT 
bh.BOOKING_HDR_ID 
,bh.ORG_ID 
,bh.FUNC_ID 
,bh.BOOKING_NUMBER 
,bh.BOOKING_DATE
,bh.USAGE
,bh.MS_HDR_ID
,bh.PL_ID
,bh.CURRENCY_CODE
,bh.STATUS as booking_status
,lk.LOOKUP_VALUE_NAME_DISP as STATUS_DISP
,bd.BOOKING_DTL_ID 
,bd.PROPERTY_ID
,bd.BUILDING_ID 
,bd.UNIT_ID
,bd.UOM 
,bd.BOOKING_RATE 
,bd.BOOKING_AMOUNT
,bd.DISC_PCT 
,bd.DISC_AMOUNT 
,bd.TAX_CODE
,bd.TAX_RATE
,bd.TAX_AMOUNT
,pu.UNIT_NUMBER 
,pu.UNIT_SHORTCODE
,pu.STATUS
,pu.UNIT_CATEGORY
,pb.BUILD_NAME 
,pb.BUILD_NUMBER
,pm.PROPERTY_NAME 
,pm.PROPERTY_NUMBER
,bc.BOOKING_CUST_ID 
,bc.CUST_ID 
,bc.SHIP_TO_SITE_ID 
,bc.BILL_TO_SITE_ID
,cus.CUSTOMER_NUMBER 
,cus.CUSTOMER_NAME
,mh.MILESTONE_NAME 
,mh.MILESTONE_NUMBER
,plh.PL_NUMBER
,org.ORG_NAME
,org.ORG_NAME_TL
FROM 
xxpm_booking_header bh,xxpm_booking_detail bd, 
xxpm_property_units pu, xxpm_property_buildings pb
,xxpm_property_master pm, xxpm_booking_customer bc
,xxstg_customer cus, xxstg_cust_sites cussite
,xxstg_organizations org, xxpm_milestone_hdr mh
,xxpm_pl_header plh
,xxfnd_lookup_v lk
where bh.BOOKING_HDR_ID=bd.BOOKING_HDR_ID
and pu.UNIT_ID=bd.UNIT_ID
and pu.PROPERTY_ID=bd.PROPERTY_ID
and pu.BUILD_ID=bd.BUILDING_ID
and pb.BUILD_ID=bd.BUILDING_ID
and pb.PROPERTY_ID=bd.PROPERTY_ID
and pm.PROPERTY_ID=bd.PROPERTY_ID
and pm.PROPERTY_ID=pm.PROPERTY_ID+0
and bc.BOOKING_HDR_ID=bh.BOOKING_HDR_ID
and bc.PRIMARY_YN='Y'
and cus.CUST_ID=bc.CUST_ID
and cussite.CUST_ID=bc.CUST_ID
and cussite.ORG_ID=bh.ORG_ID
and org.ORG_ID=bh.ORG_ID
and mh.MS_HDR_ID=bh.MS_HDR_ID
and plh.PL_ID=bh.PL_ID
and lk.LOOKUP_TYPE_NAME='BOOKING_STATUS'
and lk.LOOKUP_VALUE_NAME=bh.STATUS
--and bh.BOOKING_HDR_ID=196
),
booking_line as
(SELECT ih.booking_id , SUM (  NVL (il.amount, 0) + NVL (il.tax_amount, 0)) invoiced_amount
FROM xxpm_invoice_header ih, xxpm_invoice_lines il
WHERE     
il.invoice_id = ih.invoice_id
AND ih.invoice_id =   ih.invoice_id+ 0
AND il.invoice_id =   il.invoice_id+ 0
--and ih.booking_id=196
GROUP BY ih.booking_id),
not_inv_amt as(
SELECT 
booking_hdr_id,
sum(ROUND(INSTALLMENT_AMOUNT,2)) as un_invoice
FROM xxpm_booking_milestones 
where 
invoice_id is null
and booking_hdr_id=booking_hdr_id+0
--and booking_hdr_id=196
group by 
booking_hdr_id
),
booking_colleted_amt as(
SELECT 
inv_hdr.booking_id ,
SUM (rd.amount_applied) AS receipt_amount ,
SUM(rd.AMOUNT_APPLIED) as applied_receipt_amount
FROM xxpm_invoice_header inv_hdr
     ,xxpm_receipt_details rd
     ,xxpm_receipt r
WHERE     
inv_hdr.invoice_id = rd.invoice_id
AND inv_hdr.invoice_id =   inv_hdr.invoice_id+ 0
AND r.receipt_id = rd.receipt_id
AND r.receipt_id =   r.receipt_id+ 0
GROUP BY inv_hdr.booking_id
)

select 
 bhr.BOOKING_HDR_ID 
,bhr.ORG_ID 
,bhr.FUNC_ID 
,bhr.BOOKING_NUMBER 
,bhr.BOOKING_DATE
,bhr.USAGE
,bhr.MS_HDR_ID
,bhr.PL_ID
,bhr.CURRENCY_CODE
,bhr.booking_status
,bhr.STATUS_DISP
,bhr.BOOKING_DTL_ID 
,bhr.PROPERTY_ID
,bhr.BUILDING_ID 
,bhr.UNIT_ID
,bhr.UOM 
,bhr.BOOKING_RATE 
,bhr.BOOKING_AMOUNT
,bhr.DISC_PCT 
,bhr.DISC_AMOUNT 
,bhr.TAX_CODE
,bhr.TAX_RATE
,bhr.TAX_AMOUNT
,bhr.UNIT_NUMBER 
,bhr.UNIT_SHORTCODE
,bhr.STATUS
,bhr.UNIT_CATEGORY
,bhr.BUILD_NAME 
,bhr.BUILD_NUMBER
,bhr.PROPERTY_NAME 
,bhr.PROPERTY_NUMBER
,bhr.BOOKING_CUST_ID 
,bhr.CUST_ID 
,bhr.SHIP_TO_SITE_ID 
,bhr.BILL_TO_SITE_ID
,bhr.CUSTOMER_NUMBER 
,bhr.CUSTOMER_NAME
,bhr.MILESTONE_NAME 
,bhr.MILESTONE_NUMBER
,bhr.PL_NUMBER
,bhr.ORG_NAME
,bhr.ORG_NAME_TL
,NVL(bhr.BOOKING_AMOUNT,0)-NVL(bhr.DISC_AMOUNT,0)+NVL(bhr.TAX_AMOUNT,0) as InstallmentAmount
,bkl.invoiced_amount
,bmsuniv.un_invoice
,receamt.receipt_amount
,receamt.applied_receipt_amount
,NVL(receamt.receipt_amount,0)-NVL(receamt.applied_receipt_amount,0) balance_amt
--count(*)
from 
booking_hdr bhr
,booking_line bkl 
,not_inv_amt bmsuniv
,booking_colleted_amt receamt
where bhr.BOOKING_HDR_ID= bkl.booking_id
and bhr.BOOKING_HDR_ID=bmsuniv.BOOKING_HDR_ID(+)
and bmsuniv.BOOKING_HDR_ID=bmsuniv.BOOKING_HDR_ID+0
and receamt.booking_id(+)=bhr.BOOKING_HDR_ID
