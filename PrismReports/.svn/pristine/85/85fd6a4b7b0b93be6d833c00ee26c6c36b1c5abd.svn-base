  CREATE OR REPLACE  VIEW "XXPM_BOOKING_MILESTONES_V" ("ROW_ID", "BOOKING_HDR_ID", "BOOKING_MS_DTL_ID", "MILESTONE_TYPE", "MS_DTL_ID", "PL_MOD_ID", "SEQ_NUMBER", "INSTALLMENT_TYPE", "INSTALLMENT_TYPE_DESC", "INSTALLMENT_PCT", "INSTALLMENT_AMOUNT", "UOM", "QUANTITY", "RATE", "WAVE_OFF", "INCLUDED_IN_RATE", "INSTALLMENT_METHOD", "INSTALLMENT_METHOD_DESC", "INSTALLMENT_EVENT", "PERIOD_OCCURENCE", "PERIOD_VALUES", "PERIOD_DURATION", "CHARGE_TYPE", "CHARGE_TYPE_DESC", "PAYMENT_TERM", "REMARKS", "DUE_DAYS", "DUE_DAYS_FROM", "DUE_DATE", "ATTRIBUTE_CATEGORY", "ATTRIBUTE1", "ATTRIBUTE2", "ATTRIBUTE3", "ATTRIBUTE4", "ATTRIBUTE5", "ATTRIBUTE6", "ATTRIBUTE7", "ATTRIBUTE8", "ATTRIBUTE9", "ATTRIBUTE10", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "SOURCE_FUNC_ID", "SOURCE_FUNC_REF_ID", "BILLING_ID", "STATUS", "INVOICE_ID", "INVOICE_NUMBER", "TAX_RATE", "TAX_CODE", "TAX_AMOUNT", "BASEAMOUNT", "CARPARKING", "SOURCE_NUMBER") AS 
  SELECT DISTINCT
        xbm.rowid,
        xbm.booking_hdr_id,
        xbm.booking_ms_dtl_id,
        xbm.milestone_type,
        xbm.ms_dtl_id,
        xbm.pl_mod_id,
        xbm.seq_number,
        xbm.installment_type,
        DECODE(xbm.milestone_type, 'MS',(
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_type_name = 'MILESTONE_INSTALLMENT'
                AND lookup_value_name = xbm.installment_type
        ), xbm.installment_type) AS lookup_value_name_disp,
        xbm.installment_pct,
        xbm.installment_amount,
        xbm.uom,
        xbm.quantity,
        xbm.rate,
        xbm.wave_off,
        xbm.included_in_rate,
        xbm.installment_method,
        lk2.lookup_value_name_disp,
        (
            SELECT
                installment_event
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS installment_event,
        (
            SELECT
                period_occurence
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS period_occurence,
        (
            SELECT
                period_values
            FROM
                xxpm_milestone_dtl
            WHERE
                ms_dtl_id = xbm.ms_dtl_id
        ) AS period_values,
        xbm.period_duration,
        xbm.charge_type,
        lk3.lookup_value_name_disp,
        xbm.payment_term,
        xbm.remarks,
        xbm.due_days,
        xbm.due_days_from,
        xbm.due_date,
        xbm.attribute_category,
        xbd.UNIT_NAME AS attribute1,
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
        xih.invoice_number,
        xbm.tax_rate,
        xbm.tax_code,
        xbm.tax_amount,
        xbm.baseamount,
        xbm.carparking,
        get_source_number(xbm.source_func_id, xbm.source_func_ref_id) AS source_number
    --,DECODE(  xbm.source_func_id,
    --(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='SB'),(select booking_number  from xxpm_booking_header where booking_hdr_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='CN'),(select cancel_number from xxpm_cancellation where cancel_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='TN'),(select cancel_number from xxpm_cancellation where cancel_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='SP'),(select cancel_number from xxpm_cancellation where cancel_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='RS'),(select cancel_number from xxpm_cancellation where cancel_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='RG'),(select regn_number from xxpm_registration where regn_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='PC'),(select ms_rev_number from xxpm_book_ms_rev_hdr where ms_rev_id =xbm.source_func_ref_id)
    --,(select FUNC_ID from xxfnd_functions where FUNC_SHORT_CODE ='AC'),(select AREA_CNG_NUMBER from xxpm_area_change_hdr where AREA_CNG_HDR_ID =xbm.source_func_ref_id)
    --) SOURCE_NUMBER
    FROM
        xxpm_booking_milestones   xbm,
        xxfnd_lookup_v            lk2,
        xxfnd_lookup_v            lk3,
        xxpm_invoice_header       xih,
		xxpm_booking_detail_v	  xbd	
    WHERE
        lk2.lookup_type_name (+) = 'MILESTONE_METHOD'
        AND lk2.lookup_value_name (+) = xbm.installment_method
        AND lk3.lookup_type_name (+) = 'CHARGE_TYPE'
        AND lk3.lookup_value_name (+) = xbm.charge_type
        AND xbm.invoice_id = xih.invoice_id (+)
		AND xbd.BOOKING_HDR_ID=xbm.BOOKING_HDR_ID;
