--------------------------------------------------------
--  DDL for View XXPM_INVOICE_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_INVOICE_V" (
    "INVOICE_ID",
    "INVOICE_NUMBER",
    "ORG_ID",
    "ORGANIZATION_NAME",
    "CUST_ID",
    "CUSTOMER_NAME",
    "BOOKING_NUMBER",
    "OFFER_NUMBER",
    "PROPERTY_ID",
    "PROPERTY_NUMBER",
    "PROPERTY_NAME",
    "BUILD_ID",
    "BUILD_NUMBER",
    "BUILD_NAME",
    "UNIT_ID",
    "UNIT_NUMBER",
    "UNIT_NAME",
    "INVOICE_DATE",
    "INVOICE_STATUS",
    "CHARGE_TYPE",
    "TRX_SOURCE",
    "TRX_TYPE",
    "CURRENCY_CODE",
    "PAYMENT_TERMS",
    "STATUS",
    "CUSTOMER_TRX_NUMBER",
    "RULE_START_DATE",
    "RULE_END_DATE",
    "ACNT_RULE",
    "INVOICING_RULE",
    "CREATED_BY"
) AS
    SELECT
        xh.invoice_id,
        xh.invoice_number,
        xh.org_id,
        (
            SELECT
                xo.org_name
            FROM
                xxstg_organizations xo
            WHERE
                xo.org_id = xh.org_id
        ) organization_name,
        xh.cust_id,
        (
            SELECT
                customer_name
            FROM
                xxstg_customer cus
            WHERE
                cus.cust_id = xh.cust_id
        ) customer_name,
        xh.booking_number,
        xh.offer_number,
        xl.property_id,
        (
            SELECT
                xpm.property_number
            FROM
                xxpm_property_master xpm
            WHERE
                xpm.property_id = xl.property_id
        ) property_number,
        (
            SELECT
                xpm.property_name
            FROM
                xxpm_property_master xpm
            WHERE
                xpm.property_id = xl.property_id
        ) property_name,
        xl.build_id,
        (
            SELECT
                xpb.build_number
            FROM
                xxpm_property_buildings xpb
            WHERE
                xpb.build_id = xl.build_id
        ) build_number,
        (
            SELECT
                xpb.build_name
            FROM
                xxpm_property_buildings xpb
            WHERE
                xpb.build_id = xl.build_id
        ) build_name,
        xl.unit_id,
        (
            SELECT
                xpu.unit_number
            FROM
                xxpm_property_units xpu
            WHERE
                xpu.unit_id = xl.unit_id
        ) unit_number,
        (
            SELECT
                xpu.unit_name
            FROM
                xxpm_property_units xpu
            WHERE
                xpu.unit_id = xl.unit_id
        ) unit_name,
        xh.invoice_date,
        xh.interface_status   invoice_status,
--(SELECT LK.LOOKUP_VALUE_NAME_DISP FROM XXFND_LOOKUP_V LK WHERE XH.INTERFACE_STATUS =  LK.LOOKUP_VALUE_NAME and LOOKUP_TYPE_NAME='INVOICE_STATUS') INVOICE_STATUS,
        (
            SELECT
                lk.lookup_value_name_disp
            FROM
                xxfnd_lookup_v lk
            WHERE
                xl.charge_type = lk.lookup_value_name
                AND lookup_type_name = 'CHARGE_TYPE'
        ) charge_type,
        xh.trx_source,
        xh.trx_type,
        (
            SELECT
                lk.lookup_value_name_disp
            FROM
                xxfnd_lookup_v lk
            WHERE
                xh.currency_code = lk.lookup_value_name
                AND lookup_type_name = 'CURRENCY'
        ) currency_code,
        xh.payment_terms,
--(SELECT LK.LOOKUP_VALUE_NAME_DISP FROM XXFND_LOOKUP_V LK WHERE XH.status =  LK.LOOKUP_VALUE_NAME and LOOKUP_TYPE_NAME='TRANSACTION_STATUS') STATUS,
        xh.status             status,
        xh.customer_trx_number,
        xh.rule_start_date,
        xh.rule_end_date,
        xh.acnt_rule,
        xh.invoicing_rule,
        xh.created_by
    FROM
        xxpm_invoice_header   xh,
        xxpm_invoice_lines    xl
    WHERE
        xh.invoice_id = xl.invoice_id
    ORDER BY
        invoice_number DESC