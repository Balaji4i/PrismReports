--------------------------------------------------------
--  DDL for View XXPM_PAYMENT_CHANGE_HDR_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PAYMENT_CHANGE_HDR_PCS_V" (
    "MS_REV_ID",
    "BOOKING_NUMBER",
    "ORG_ID",
    "ORG_NAME",
    "BOOKING_DATE",
    "PROPERTY_ID",
    "PROPERTY_NAME",
    "BOOKING_DTL_ID",
    "BOOKING_HDR_ID",
    "CUST_ID",
    "CUSTOMER_NAME",
    "PL_ID",
    "PL_NAME",
    "MS_HDR_ID",
    "MILESTONE_NAME",
    "BOOKING_AMOUNT"
) AS
    SELECT
        xbmrh.ms_rev_id,
        xbh.booking_number,
        xbh.org_id,
        xo.org_name,
        trunc(xbh.booking_date),
        xbh.property_id,
        xpm.property_name,
        xbd.booking_dtl_id,
        xbh.booking_hdr_id,
        xbc.cust_id,
        xc.customer_name,
        xoh.pl_id,
        xph.pl_name,
        xoh.ms_hdr_id,
        xmh.milestone_name,
        xbd.booking_amount
    FROM
        xxpm_book_ms_rev_hdr    xbmrh,
        xxpm_booking_header     xbh,
        xxpm_booking_customer   xbc,
        xxpm_offer_header       xoh,
        xxpm_booking_detail     xbd,
        xxpm_property_master    xpm,
        xxstg_customer          xc,
        xxpm_milestone_hdr      xmh,
        xxpm_pl_header          xph,
        xxstg_organizations     xo
    WHERE
        xbmrh.booking_hdr_id = xbh.booking_hdr_id
        AND xbh.booking_hdr_id = xbc.booking_hdr_id
        AND xbh.offer_hdr_id = xoh.offer_hdr_id
        AND xbc.primary_yn = 'Y'
        AND xbh.booking_hdr_id = xbd.booking_hdr_id
        AND xpm.property_id = xbh.property_id
        AND xbc.cust_id = xc.cust_id (+)
        AND xmh.ms_hdr_id (+) = xoh.ms_hdr_id
        AND xph.pl_id (+) = xoh.pl_id
        AND xbh.org_id = xo.org_id (+)