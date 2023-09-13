--------------------------------------------------------
--  DDL for View XXPM_BOOKING_MOVE_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKING_MOVE_V" (
    "BOOKING_DTL_ID",
    "BOOKING_HDR_ID",
    "BOOKING_NUMBER",
    "ORG_ID",
    "ORG_NAME",
    "USAGE",
    "STATUS",
    "PROPERTY_ID",
    "PROPERTY_NAME",
    "BUILDING_ID",
    "BUILD_NAME",
    "UNIT_ID",
    "UNIT_NAME",
    "UNIT_CATEGORY",
    "UNIT_TYPE",
    "UNIT_TYPE_DESC",
    "CUST_ID",
    "CUSTOMER_NUMBER",
    "CUSTOMER_NAME",
    "SHIP_TO_SITE_ID",
    "SHIP_TO_SITE_NUMBER",
    "SHIP_TO_SITE_NAME",
    "BILL_TO_SITE_ID",
    "BILL_TO_SITE_NUMBER",
    "BILL_TO_SITE_NAME",
    "CUST_CONTACT_ID",
    "CONTACT_NAME",
    "PRIMARY_YN",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN",
    "BOOKING_FROM_DATE",
    "BOOKING_TO_DATE",
    "Line",
    "MS",
    "Fix",
    "Charge",
    "TOTOAL_SALE_VALUE",
    "INV_AMOUNT",
    "REC_AMOUNT"
) AS
    SELECT
        dtl.booking_dtl_id,
        dtl.booking_hdr_id,
        hdr.booking_number,
        hdr.org_id,
        hdr.org_name,
        hdr.usage,
        hdr.status,
        dtl.property_id,
        dtl.property_name,
        dtl.building_id,
        dtl.build_name,
        dtl.unit_id,
        dtl.unit_name,
        dtl.unit_category,
        dtl.unit_type,
        dtl.unit_type_desc,
        cus.cust_id,
        cus.customer_number,
        cus.customer_name,
        cus.ship_to_site_id,
        cus.ship_to_site_number,
        cus.ship_to_site_name,
        cus.bill_to_site_id,
        cus.bill_to_site_number,
        cus.bill_to_site_name,
        cus.cust_contact_id,
        cus.contact_name,
        cus.primary_yn,
        hdr.created_by,
        hdr.creation_date,
        hdr.last_updated_by,
        hdr.last_update_date,
        hdr.last_update_login,
        hdr.booking_from_date,
        hdr.booking_to_date,
        nvl(xxpm_booking.getbookingtotal(hdr.booking_hdr_id), 0) AS line,
        nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'MS'), 0) AS ms,
        nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'Fix'), 0) AS fix,
        nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'Charge'), 0) AS charge,
        ( nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'Fix'), 0) + nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id
        , 'Charge'), 0) + nvl(xxpm_booking.getbookingtotal(hdr.booking_hdr_id), 0) ) AS totoal_sale_value,
        (
            SELECT
                round(SUM(inv_lns.amount), 3)
            FROM
                xxpm_invoice_lines inv_lns
            WHERE
                inv_lns.invoice_id IN (
                    SELECT
                        inv_hrd.invoice_id
                    FROM
                        xxpm_invoice_header inv_hrd
                    WHERE
                        inv_hrd.booking_id = dtl.booking_hdr_id
--      AND rownum               =1
                )
        ) AS inv_amount,
        (
            SELECT
                round(SUM(reci.received_amount), 3)
            FROM
                xxpm_receipt reci
            WHERE
                reci.source_func_ref_id = dtl.booking_hdr_id
                AND ROWNUM = 1
        ) AS rec_amount
    FROM
        xxpm_booking_detail_v     dtl,
        xxpm_booking_header_v     hdr,
        xxpm_booking_customer_v   cus 
--    ,
--    XXPM_LEASE_AGREEMENT la
    WHERE
        dtl.booking_hdr_id = hdr.booking_hdr_id
        AND dtl.booking_hdr_id = cus.booking_hdr_id
        AND cus.primary_yn = 'Y'
        AND hdr.usage = 'S'
        AND dtl.property_id IS NOT NULL
        AND dtl.building_id IS NOT NULL
        AND dtl.unit_id IS NOT NULL
 -- AND HDR.BOOKING_HDR_ID=1000487
    UNION
    SELECT
        dtl.booking_dtl_id,
        dtl.booking_hdr_id,
        hdr.booking_number,
        hdr.org_id,
        hdr.org_name,
        hdr.usage,
        hdr.status,
        dtl.property_id,
        dtl.property_name,
        dtl.building_id,
        dtl.build_name,
        dtl.unit_id,
        dtl.unit_name,
        dtl.unit_category,
        dtl.unit_type,
        dtl.unit_type_desc,
        cus.cust_id,
        cus.customer_number,
        cus.customer_name,
        cus.ship_to_site_id,
        cus.ship_to_site_number,
        cus.ship_to_site_name,
        cus.bill_to_site_id,
        cus.bill_to_site_number,
        cus.bill_to_site_name,
        cus.cust_contact_id,
        cus.contact_name,
        cus.primary_yn,
        hdr.created_by,
        hdr.creation_date,
        hdr.last_updated_by,
        hdr.last_update_date,
        hdr.last_update_login,
        hdr.booking_from_date,
        hdr.booking_to_date,
        nvl(xxpm_booking.getbookingtotal(hdr.booking_hdr_id), 0) AS line,
        nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'MS'), 0) AS ms,
        nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'Fix'), 0) AS fix,
        nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'Charge'), 0) AS charge,
        ( nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id, 'Fix'), 0) + nvl(xxpm_booking.getmilestone_amt(hdr.booking_hdr_id
        , 'Charge'), 0) + nvl(xxpm_booking.getbookingtotal(hdr.booking_hdr_id), 0) ) AS totoal_sale_value,
    --(SELECT ROUND(SUM(BKM.INSTALLMENT_AMOUNT),3)
    --FROM XXPM_BOOKING_MILESTONES BKM
    --WHERE BKM.SOURCE_FUNC_REF_ID=dtl.BOOKING_HDR_ID
    --AND BKM.SOURCE_FUNC_ID      =hdr.FUNC_ID
    --AND rownum                  =1
    --) AS TOTOAL_SALE_VALUE,
        (
            SELECT
                round(SUM(inv_lns.amount), 3)
            FROM
                xxpm_invoice_lines inv_lns
            WHERE
                inv_lns.invoice_id IN (
                    SELECT
                        inv_hrd.invoice_id
                    FROM
                        xxpm_invoice_header inv_hrd
                    WHERE
                        inv_hrd.booking_id = dtl.booking_hdr_id
--      AND rownum               =1
                )
        ) AS inv_amount,
        (
            SELECT
                round(SUM(reci.received_amount), 3)
            FROM
                xxpm_receipt reci
            WHERE
                reci.source_func_ref_id = dtl.booking_hdr_id
                AND ROWNUM = 1
        ) AS rec_amount
    FROM
        xxpm_booking_detail_v     dtl,
        xxpm_booking_header_v     hdr,
        xxpm_booking_customer_v   cus,
        xxpm_lease_agreement      la
    WHERE
        dtl.booking_hdr_id = hdr.booking_hdr_id
        AND dtl.booking_hdr_id = cus.booking_hdr_id
        AND hdr.usage = 'L'
        AND cus.primary_yn = 'Y'
        AND la.booking_id = dtl.booking_hdr_id
        AND la.lease_number IS NOT NULL
        AND dtl.property_id IS NOT NULL
        AND dtl.building_id IS NOT NULL
        AND dtl.unit_id IS NOT NULL
    --AND HDR.BOOKING_HDR_ID=1000334;