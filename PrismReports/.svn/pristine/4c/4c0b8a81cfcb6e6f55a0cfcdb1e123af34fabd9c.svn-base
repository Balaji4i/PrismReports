--------------------------------------------------------
--  DDL for View XXPM_MILESTONE_DETAIL_H_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MILESTONE_DETAIL_H_V" (
    "MS_DTL_ID_H",
    "MS_DTL_ID",
    "MS_HDR_ID",
    "SEQ_NUMBER",
    "INSTALLMENT_TYPE_CODE",
    "INSTALLMENT_TYPE",
    "INSTALLMENT_PCT",
    "CHARGE_TYPE",
    "TERM_NAME",
    "INSTALLMENT_METHOD",
    "INSTALLMENT_EVENT",
    "PROJ_MS_ID",
    "PROJECT_START_DATE",
    "COMPLETION_DATE",
    "PERIOD_OCCURENCE",
    "PERIOD_DURATION",
    "PERIOD_VALUES",
    "DUE_DAYS",
    "DUE_DATE",
    "REMARKS",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN",
    "REVISION",
    "REVISION_DATE",
    "REVISED_BY"
) AS
    SELECT
        dtl.ms_dtl_id_h,
        dtl.ms_dtl_id,
        dtl.ms_hdr_id,
        dtl.seq_number,
        dtl.installment_type,
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
        nvl(dtl.proj_ms_id, 0) AS proj_ms_id,
        (
            SELECT
                start_date
            FROM
                xxstg_project_milestones
            WHERE
                proj_ms_id = dtl.proj_ms_id
        ) AS project_start_date,
        (
            SELECT
                completion_date
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
        dtl.remarks,
        dtl.created_by,
        dtl.creation_date,
        dtl.last_updated_by,
        dtl.last_update_date,
        dtl.last_update_login,
        dtl.revision,
        dtl.revision_date,
        dtl.revised_by
    FROM
        xxpm_milestone_dtl_h   dtl,
        xxpm_milestone_hdr_h   hdr,
        xxstg_organizations    org,
        xxfnd_lookup_v         lkv,
        xxfnd_lookup_v         lkv1,
        xxstg_pay_terms        pay
    WHERE
        dtl.ms_hdr_id = hdr.ms_hdr_id
        AND dtl.revision = hdr.revision_no
        AND hdr.org_id = org.org_id
        AND dtl.installment_type = lkv.lookup_value_name
        AND dtl.charge_type = lkv1.lookup_value_name
        AND lkv1.lookup_type_name = 'CHARGE_TYPE'
        AND dtl.payment_term = pay.term_id
--AND HDR. MS_HDR_ID =1000293
--AND HDR.REVISION_NO =1
    ORDER BY
        ms_dtl_id_h ASC