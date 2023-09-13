--------------------------------------------------------
--  DDL for View XXPM_BILLING_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BILLING_PCS_V" (
    "BILLING_ID",
    "BILLING_NUMBER",
    "BILLING_DATE",
    "ORG_ID",
    "STATUS",
    "DESCRIPTION"
) AS
    SELECT
        xb.billing_id,
        xb.billing_number,
        trunc(xb.billing_date),
        xb.org_id,
        xb.status,
        xb.description
    FROM
        xxpm_billing xb