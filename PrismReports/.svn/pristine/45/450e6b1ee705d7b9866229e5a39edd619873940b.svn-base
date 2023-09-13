--------------------------------------------------------
--  DDL for View XXPM_MILESTONE_HEADER_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MILESTONE_HEADER_PCS_V" (
    "MS_HDR_ID",
    "PAYMENT_PLAN_SHORT_CODE",
    "REVISION_NO",
    "REVISED_BY",
    "REVISION_DATE",
    "BUSINESS_UNIT",
    "START_DATE",
    "END_DATE",
    "PAYMENT_PLAN_DATE",
    "DESCRIPTION"
) AS
    SELECT DISTINCT
        hdr.ms_hdr_id,
        hdr.milestone_name,
        hdr.revision_no,
        hdr.revised_by,
        TO_CHAR(hdr.revision_date, 'YYYY-MM-DD') AS revision_date,
        org.org_name,
        TO_CHAR(hdr.start_date, 'YYYY-MM-DD') AS start_date,
--HDR.START_DATE, 
        TO_CHAR(hdr.end_date, 'YYYY-MM-DD') AS end_date,
        TO_CHAR(hdr.milestone_date, 'YYYY-MM-DD') AS payment_plan_date,
        hdr.description
    FROM
        xxpm_milestone_hdr    hdr,
        xxstg_organizations   org
    WHERE
        hdr.org_id = org.org_id