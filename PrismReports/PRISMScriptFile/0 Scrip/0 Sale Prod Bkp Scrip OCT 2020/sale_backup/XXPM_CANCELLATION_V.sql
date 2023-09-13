--------------------------------------------------------
--  DDL for View XXPM_CANCELLATION_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_CANCELLATION_V" ("BOOKING_HDR_ID", "BOOKING_NUMBER", "BOOKING_DATE", "PROPERTY_NAME", "CUSTOMER_NUMBER", "CUSTOMER_NAME", "SITE_NUMBER", "SITE_NAME", "CUSTOMER_SITE", "BUILDING_ID", "BUILD_NAME", "UNIT_NAME", "CLEARED_AMOUNT") AS 
  SELECT
        bk.booking_hdr_id,
        bk.booking_number,
        bk.booking_date,
        pro.property_name,
        scus.customer_number,
        scus.customer_name,
        scusit.site_number,
        scusit.site_name,
        scusit.site_number
        || ' '
        || scusit.site_name "CUSTOMER_SITE",
        bd.building_id,
        (
            SELECT
                build_name
            FROM
                xxpm_property_buildings
            WHERE
                build_id = bd.building_id
        ) AS build_name,
        (
            SELECT
                unit_name
            FROM
                xxpm_property_units
            WHERE
                unit_id = bd.unit_id
        ) AS unit_name,
        (
        SELECT
nvl(SUM(r.received_amount), 0)
FROM
xxpm_receipt r
WHERE
r.receipt_risk_yn = 'N'
AND r.SOURCE_FUNC_REF_ID = bk.booking_hdr_id
            
--            SELECT
--                nvl(SUM(r.received_amount), 0)
--            FROM
--                xxpm_invoice_header    inv_hdr,
--                xxpm_receipt_details   rd,
--                xxpm_receipt           r
--            WHERE
--                inv_hdr.invoice_id (+) = rd.invoice_id
--                AND r.receipt_id = rd.receipt_id
--                AND r.receipt_risk_yn = 'N'
--                AND inv_hdr.booking_id = bk.booking_hdr_id
        ) AS cleared_amount
    FROM
        xxpm_booking_header     bk,
        xxpm_booking_customer   bcus,
        xxpm_property_master    pro,
        xxstg_customer          scus,
        xxstg_cust_sites        scusit,
        xxpm_booking_detail     bd
    WHERE
        bk.booking_hdr_id = bcus.booking_hdr_id (+)
        AND bk.booking_hdr_id = bd.booking_hdr_id (+)
        AND bk.property_id = pro.property_id
        AND bcus.cust_id = scus.cust_id
        AND scusit.cust_site_id = bcus.bill_to_site_id
        AND bcus.primary_yn = 'Y'
        AND scusit.org_id = bk.org_id
