--------------------------------------------------------
--  DDL for View XXPM_REGISTRATION_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_REGISTRATION_PCS_V" (
    "REGN_ID",
    "FUNC_ID",
    "REGN_NUMBER",
    "REGN_DATE",
    "BOOKING_HDR_ID",
    "BOOKING_AMOUNT",
    "BOOKING_NUMBER",
    "PROPERTY_NAME",
    "CUSTOMER_NAME",
    "INVOICED_AMOUNT",
    "RECEIPT_AMOUNT",
    "APPLIED_RECEIPT_AMOUNT",
    "TOTAL_AMOUNT",
    "JOINT_OWNER",
    "PROPERTY_ID",
    "ORG_ID"
) AS
    SELECT
        xr.regn_id,
        xr.func_id,
        xr.regn_number,
        trunc(xr.regn_date),
        xbh.booking_hdr_id,
        xbd.booking_amount,
        xbh.booking_number,
        xpm.property_name,
        xc.customer_name,
        (
            SELECT
                SUM(inv_lines.amount) AS invoice_amount
            FROM
                xxpm_booking_milestones   bms,
                xxpm_invoice_header       inv_hdr,
                xxpm_milestone_dtl        mdtl,
                xxpm_milestone_hdr        mhdr,
                xxpm_invoice_lines        inv_lines,
                xxstg_pay_terms           pay_terms,
                xxfnd_lookup_v            lv
            WHERE
                bms.invoice_id IS NOT NULL
                AND bms.invoice_id = inv_hdr.invoice_id
                AND bms.ms_dtl_id = mdtl.ms_dtl_id (+)
                AND mdtl.ms_hdr_id = mhdr.ms_hdr_id (+)
                AND pay_terms.term_id (+) = inv_hdr.payment_terms
                AND inv_hdr.invoice_id = inv_lines.invoice_id (+)
                AND lv.lookup_type_name (+) = 'INVOICE_STATUS'
                AND lv.lookup_value_name (+) = inv_hdr.status
                AND inv_hdr.booking_id = xbh.booking_hdr_id
        ) AS invoiced_amount,
        (
            SELECT
                SUM(rd.amount_applied) AS receipt_amount
            FROM
                xxpm_invoice_header    inv_hdr,
                xxpm_receipt_details   rd,
                xxpm_receipt           r
            WHERE
                inv_hdr.invoice_id (+) = rd.invoice_id
                AND r.receipt_id = rd.receipt_id
                AND ( inv_hdr.booking_id = xbh.booking_hdr_id
                      OR ( r.source_func_id = (
                    SELECT
                        func_id
                    FROM
                        xxfnd_functions
                    WHERE
                        func_short_code = 'BL'
                )
                           AND r.source_func_ref_id = xbh.block_id ) )
        ) AS receipt_amount,
        (
            SELECT
                SUM(rd.amount_applied) AS receipt_amount
            FROM
                xxpm_invoice_header    inv_hdr,
                xxpm_receipt_details   rd,
                xxpm_receipt           r
            WHERE
                inv_hdr.invoice_id (+) = rd.invoice_id
                AND r.receipt_id = rd.receipt_id
                AND ( inv_hdr.booking_id = xbh.booking_hdr_id
                      OR ( r.source_func_id = (
                    SELECT
                        func_id
                    FROM
                        xxfnd_functions
                    WHERE
                        func_short_code = 'BL'
                )
                           AND r.source_func_ref_id = xbh.block_id ) )
                AND r.interface_status = 'READY_TO_APPLY'
        ) AS applied_receipt_amount,
        (
            SELECT
                SUM(x.installment_amount)
            FROM
                xxpm_booking_milestones x
            WHERE
                x.booking_hdr_id = xbh.booking_hdr_id
                AND nvl(x.included_in_rate, 'N') = 'N'
                AND ( x.wave_off IS NULL
                      OR x.wave_off NOT IN (
                    'Y',
                    'O'
                ) )
        ) AS total_amount,
        (
            SELECT
                LISTAGG((
                    SELECT
                        xst.customer_name
                    FROM
                        xxstg_customer xst
                    WHERE
                        xst.cust_id = xbc.cust_id
                ), ',') WITHIN GROUP(
                    ORDER BY
                        xbc.booking_hdr_id
                )
            FROM
                xxpm_booking_customer xbc
            WHERE
                xbc.booking_hdr_id = xbh.booking_hdr_id
                AND nvl(xbc.primary_yn, 'N') = 'N'
            GROUP BY
                xbc.booking_hdr_id
        ) AS joint_owner,
        xpm.property_id,
        xbh.org_id
    FROM
        xxpm_registration       xr,
        xxpm_booking_header     xbh,
        xxpm_booking_detail     xbd,
        xxpm_property_master    xpm,
        xxpm_booking_customer   xbc,
        xxstg_customer          xc
    WHERE
        xr.booking_id = xbh.booking_hdr_id
        AND xbh.property_id = xpm.property_id
        AND xbc.booking_hdr_id = xbh.booking_hdr_id
        AND xbd.booking_hdr_id = xbh.booking_hdr_id
        AND xbc.primary_yn = 'Y'
        AND xc.cust_id = xbc.cust_id