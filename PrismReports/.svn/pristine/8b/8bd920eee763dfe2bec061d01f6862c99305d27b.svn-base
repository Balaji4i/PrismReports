--------------------------------------------------------
--  DDL for View XXPM_MILESTONE_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MILESTONE_PCS_V" (
    "S_NO",
    "MS_HDR_ID",
    "PAYMENT_PLAN",
    "PAYMENT_PLAN_SHORT_CODE",
    "REVISION_NO",
    "REVISED_BY",
    "REVISION_DATE",
    "BUSINESS_UNIT",
    "START_DATE",
    "END_DATE",
    "PAYMENT_PLAN_DATE",
    "DESCRIPTION",
    "INSTALLMENT_TYPE",
    "INSTALLMENT_PERCENTAGE",
    "CHARGE_TYPE",
    "PAYMENT_TERM",
    "INSTALLMENT_METHOD",
    "INSTALLMENT_EVENT",
    "PROJ_MS_ID",
    "PROJECT_START_DATE",
    "PROJECT_END_DATE",
    "PERIOD_OCCURANCE",
    "PERIOD_DURATION",
    "PERIOD_VALUES",
    "DUE_DAYS",
    "DUE_DATE",
    "REMARKS"
) AS
    SELECT DISTINCT
        ROWNUM,
        hdr.ms_hdr_id,
        hdr.milestone_name,
        hdr.milestone_shortcode,
        hdr.revision_no,
        hdr.revised_by,
        trunc(hdr.revision_date),
        org.org_name,
        TO_CHAR(hdr.start_date, 'YYYY-MM-DD') AS start_date,
--HDR.START_DATE, 
        trunc(hdr.end_date),
        trunc(hdr.milestone_date),
        hdr.description,
        lkv.lookup_value_name_disp    installment_type,
        dtl.installment_pct,
        lkv1.lookup_value_name_disp   AS charge_type,
        pay.term_name,
        dtl.installment_method,
        nvl((
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_type_name LIKE '%BOOKING_EVENT%'
                AND lookup_value_name = dtl.installment_event
        ), dtl.installment_event) installment_event,
        nvl(dtl.proj_ms_id, 0),
        (
            SELECT
                trunc(start_date)
            FROM
                xxstg_project_milestones
            WHERE
                proj_ms_id = dtl.proj_ms_id
        ) AS project_start_date,
        (
            SELECT
                trunc(completion_date)
            FROM
                xxstg_project_milestones
            WHERE
                proj_ms_id = dtl.proj_ms_id
        ) AS completion_date,
        period_occurence,
        period_duration,
        nvl(period_values, 0) period_values,
        nvl(due_days, 0) due_days,
        TO_CHAR(due_date, 'YYYY-MM-DD') AS due_date,
        remarks
    FROM
        xxpm_milestone_dtl    dtl,
        xxpm_milestone_hdr    hdr,
        xxstg_organizations   org,
        xxfnd_lookup_v        lkv,
        xxfnd_lookup_v        lkv1,
        xxstg_pay_terms       pay
    WHERE
        dtl.ms_hdr_id = hdr.ms_hdr_id
        AND hdr.org_id = org.org_id
        AND dtl.installment_type = lkv.lookup_value_name
        AND dtl.charge_type = lkv1.lookup_value_name
        AND dtl.payment_term = pay.term_id