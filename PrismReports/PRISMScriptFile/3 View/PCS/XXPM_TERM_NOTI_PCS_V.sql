--------------------------------------------------------
--  DDL for View XXPM_TERM_NOTI_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_TERM_NOTI_PCS_V" (
    "REMARKS",
    "ACKNOWLEDGED_YN",
    "PAY_RECEIVED_YN",
    "LETTER_NOTIFY_YN",
    "NOTIFY_DATE",
    "DUE_DATE",
    "EMAIL_NOTIFY_YN",
    "NOTIFY_BY",
    "NOTIFY_TYPE",
    "NOTIFY_ID",
    "CANCEL_ID"
) AS
    SELECT
        xcn.remarks,
        xcn.acknowledged_yn,
        xcn.pay_received_yn,
        xcn.letter_notify_yn,
        xcn.notify_date,
        xcn.due_date,
        xcn.email_notify_yn,
        xcn.notify_by,
        xcn.notify_type,
        xcn.notify_id,
        xcn.cancel_id
    FROM
        xxpm_cancel_notify xcn