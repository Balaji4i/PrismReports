--------------------------------------------------------
--  DDL for View XXPM_BILLING_LINES_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BILLING_LINES_PCS_V" ("BILLING_ID", "BOOKING_MS_DTL_ID", "PROPERTY_ID", "PROPERTY_NAME", "CHARGE_TYPE", "CHARGE_TYPE_DISP", "INSTALLMENT_TYPE", "INSTALLMENT_TYPE_DISP", "INSTALLMENT_PCT", "INSTALLMENT_AMOUNT", "INSTALLMENT_METHOD", "PERIOD_DURATION", "INSTALLMENT_EVENT", "DUE_DAYS", "DUE_DATE", "MILESTONE_TYPE") AS 
  SELECT
        xbm.billing_id,
        xbm.booking_ms_dtl_id,
        xpm.property_id,
        xpm.property_name,
        xbm.charge_type,
        xbm.charge_type_desc        AS charge_type_disp,
        xbm.installment_type,
        xbm.installment_type_desc   installment_type_disp,
        nvl(xbm.installment_pct, 0),
        xbm.installment_amount,
        xbm.installment_method,
        xbm.period_duration,
        xbm.installment_event,
        xbm.due_days,
        trunc(xbm.due_date)
        ,xbd.UNIT_NAME        AS milestone_type
--        lk.lookup_value_name_disp   AS milestone_type
    FROM
        xxpm_booking_milestones_v   xbm,
        xxpm_billing                xb,
        xxpm_booking_header         xbh,
        xxpm_property_master        xpm,
        xxfnd_lookup_v              lk,
        xxpm_booking_detail_v       xbd
    WHERE
        xb.billing_id = xbm.billing_id
        AND xbh.booking_hdr_id = xbm.booking_hdr_id
        AND xpm.property_id = xbh.property_id
        AND lk.lookup_type_name = 'MILESTONE_TYPE'
        AND lk.lookup_value_name = xbm.milestone_type
        AND xbd.BOOKING_HDR_ID=xbm.BOOKING_HDR_ID
