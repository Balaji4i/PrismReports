--------------------------------------------------------
--  DDL for View XXPM_MILESTONE_HEADER_H_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MILESTONE_HEADER_H_V" (
    "MS_HDR_ID_H",
    "MS_HDR_ID",
    "MILESTONE_NAME",
    "MILESTONE_NAME_TL",
    "MILESTONE_NUMBER",
    "MILESTONE_SHORTCODE",
    "MILESTONE_DATE",
    "FUNC_ID",
    "ORG_ID",
    "ORG_NAME",
    "PROJECT_ID",
    "PROJECT_NAME",
    "MILESTONE_TYPE",
    "USAGE",
    "REVISION_NO",
    "REVISION_DATE",
    "REVISED_BY",
    "DESCRIPTION",
    "START_DATE",
    "END_DATE",
    "ACTIVE_YN",
    "STATUS",
    "STATUS_DISP",
    "FLOW_STATUS",
    "FLOW_LEVEL",
    "FLOW_WITH",
    "USER_GRP_ID",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN"
) AS
    SELECT
        hdr.ms_hdr_id_h,
        hdr.ms_hdr_id,
        hdr.milestone_name,
        hdr.milestone_name_tl,
        hdr.milestone_number,
        hdr.milestone_shortcode,
        hdr.milestone_date,
        hdr.func_id,
        hdr.org_id,
        org.org_name,
        hdr.project_id,
PRO.PROJECT_NAME,
        hdr.milestone_type,
        hdr.usage,
        hdr.revision_no,
        hdr.revision_date,
        hdr.revised_by,
        hdr.description,
        hdr.start_date,
        hdr.end_date,
        hdr.active_yn,
        hdr.status,
        lk.lookup_value_name_disp AS status_disp,
        hdr.flow_status,
        hdr.flow_level,
        hdr.flow_with,
        hdr.user_grp_id,
        hdr.created_by,
        hdr.creation_date,
        hdr.last_updated_by,
        hdr.last_update_date,
        hdr.last_update_login
    FROM
        xxpm_milestone_hdr_h   hdr,
        xxstg_organizations    org,
        xxstg_projects         pro,
        xxfnd_lookup_v         lk
    WHERE
        org.org_id = hdr.org_id
        AND pro.proj_id = hdr.project_id
        AND lk.lookup_value_name = hdr.status
        AND lk.lookup_type_name = 'TRANSACTION_STATUS'
    ORDER BY
        hdr.revision_no