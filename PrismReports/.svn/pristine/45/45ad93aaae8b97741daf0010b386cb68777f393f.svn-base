create or replace VIEW XXPM_BOOKING_MILESTONE_DASHBOARD_V AS 
WITH
customerdtl as (SELECT 
inv.ORG_ID, 
inv.CUST_ID, 
inv.invoice_id, 
cus.CUSTOMER_NAME, 
inv.BOOKING_ID
FROM 
xxpm_invoice_header inv, xxstg_cust_sites cussite, xxstg_customer cus
where 
cussite.CUST_ID=inv.CUST_ID
and cussite.CUST_SITE_ID=inv.CUST_SITE_ID
and inv.ORG_ID=cussite.ORG_ID
and cus.CUST_ID=inv.CUST_ID
--and  inv.invoice_id=3923
--and  inv.BOOKING_ID=51
),  
bookingMS as (
SELECT 
xbm.booking_hdr_id,
        xbm.booking_ms_dtl_id,
        xbm.milestone_type,
        xbm.seq_number,
        xbm.installment_type,
        xbm.installment_pct,
        xbm.installment_amount,
        xbm.uom,
        xbm.quantity,
        xbm.rate,
        xbm.wave_off,
        xbm.included_in_rate,
        xbm.installment_method,
        xbm.period_duration,
        xbm.charge_type,
        xbm.payment_term,
        xbm.remarks,
        xbm.due_days,
        xbm.due_days_from,
        xbm.due_date,
        xbm.attribute1,
        xbm.attribute2,
        xbm.attribute3,
        xbm.attribute4,
        xbm.attribute5,
        xbm.attribute6,
        xbm.attribute7,
        xbm.attribute8,
        xbm.attribute9,
        xbm.attribute10,
        xbm.created_by,
        xbm.creation_date,
        xbm.last_updated_by,
        xbm.last_update_date,
        xbm.last_update_login,
        xbm.source_func_id,
        xbm.source_func_ref_id,
        xbm.billing_id,
        xbm.status,
        xbm.invoice_id,
        xbm.tax_rate,
        xbm.tax_code,
        xbm.tax_amount,
        xbm.baseamount,
        xbm.carparking,
        xbm.CUST_TYPE,
        xbm.MILESTONES_STATUS,
        lk1.lookup_value_name_disp as MILESTONE_METHOD_DISP,
        lk2.lookup_value_name_disp as CHARGE_TYPE_DISP,
        lk3.lookup_value_name_disp as MILESTONE_INSTALLMENT_DISP,
        xbd.UNIT_NAME,
        inv.INTERFACE_ERROR_MSG, 
        inv.BOOKING_NUMBER, 
        inv.INTERFACE_STATUS, 
        inv.INVOICE_NUMBER, 
        inv.CUST_ID, 
        inv.ORG_ID
FROM 
xxpm_booking_milestones xbm , xxfnd_lookup_v lk1, 
xxfnd_lookup_v lk2, xxfnd_lookup_v lk3, 
xxpm_booking_detail_v xbd, xxpm_invoice_header inv
where 
lk1.lookup_type_name(+)='MILESTONE_METHOD'
and lk1.lookup_value_name(+)=xbm.installment_method
and lk2.lookup_type_name (+) = 'CHARGE_TYPE'
and lk2.lookup_value_name (+) = xbm.charge_type
and lk3.lookup_type_name (+) = 'MILESTONE_INSTALLMENT'
and lk3.lookup_value_name (+) = xbm.installment_type
and xbd.BOOKING_HDR_ID=xbm.BOOKING_HDR_ID
and inv.invoice_id(+)=xbm.invoice_id
--and xbm.BOOKING_HDR_ID=51
)
select 
cus.invoice_id, 
cus.CUSTOMER_NAME, 
cus.BOOKING_ID,
bms.booking_ms_dtl_id,
bms.milestone_type,
bms.seq_number,
bms.installment_type,
bms.installment_pct,
bms.installment_amount,
bms.uom,
bms.quantity,
bms.rate,
bms.wave_off,
bms.included_in_rate,
bms.installment_method,
bms.period_duration,
bms.charge_type,
bms.payment_term,
bms.remarks,
bms.due_days,
bms.due_days_from,
bms.due_date,
bms.attribute1,
bms.attribute2,
bms.attribute3,
bms.attribute4,
bms.attribute5,
bms.attribute6,
bms.attribute7,
bms.attribute8,
bms.attribute9,
bms.attribute10,
bms.created_by,
bms.creation_date,
bms.last_updated_by,
bms.last_update_date,
bms.last_update_login,
bms.source_func_id,
bms.source_func_ref_id,
bms.billing_id,
bms.status,
bms.tax_rate,
bms.tax_code,
bms.tax_amount,
bms.baseamount,
bms.carparking,
bms.CUST_TYPE,
bms.MILESTONES_STATUS,
bms.MILESTONE_METHOD_DISP,
bms.CHARGE_TYPE_DISP,
bms.MILESTONE_INSTALLMENT_DISP,
bms.UNIT_NAME,
bms.INTERFACE_ERROR_MSG, 
bms.BOOKING_NUMBER, 
bms.INTERFACE_STATUS, 
bms.INVOICE_NUMBER, 
bms.CUST_ID, 
bms.ORG_ID
from 
customerdtl cus, bookingMS bms
where bms.BOOKING_HDR_ID=cus.BOOKING_ID(+)
and bms.invoice_id=cus.invoice_id(+);