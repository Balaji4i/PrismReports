--------------------------------------------------------
--  DDL for View XXPM_CANCEL_HDR_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_CANCEL_HDR_PCS_V" (
    "CANCEL_ID",
    "BOOKING_HDR_ID",
    "CANCEL_NUMBER",
    "BOOKING_NUMBER",
    "CANCEL_DATE",
    "PROPERTY_NAME",
    "PROPERTY_ID",
    "CUSTOMER_NAME",
    "TOTAL_AMOUNT",
    "CLEARED_AMOUNT",
    "INVOICED_AMOUNT",
    "COLLECTED_AMOUNT",
    "FORFEIT_AMOUNT",
    "REFUND_AMOUNT"
) AS
    SELECT
        cancel_id,
        booking_hdr_id,
        cancel_number,
        booking_number,
        cancel_date,
        property_name,
        property_id,
        customer_name,
        total_amount,
        cleared_amount,
        invoiced_amount,
        collected_amount,
        get_forfeit_amount(collected_amount, total_amount) AS forfeit_amount,
        get_refund_amount(collected_amount, total_amount) AS refund_amount
    FROM
        (
            SELECT
                xcn.cancel_id,
                xbh.booking_hdr_id,
                xcn.cancel_number,
                xbh.booking_number,
                xcn.cancel_date,
                xpm.property_name,
                xpm.property_id,
                xc.customer_name,
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
                        nvl(SUM(r.received_amount), 0)
                    FROM
                        xxpm_invoice_header    inv_hdr,
                        xxpm_receipt_details   rd,
                        xxpm_receipt           r
                    WHERE
                        inv_hdr.invoice_id (+) = rd.invoice_id
                        AND r.receipt_id = rd.receipt_id
                        AND r.receipt_risk_yn = 'N'
                        AND inv_hdr.booking_id = xbh.booking_hdr_id
                ) AS cleared_amount,
                (
                    SELECT
                        nvl(SUM(inv_lines.amount), 0) + nvl(SUM(inv_lines.tax_amount), 0) AS invoice_amount
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
                        nvl(SUM(inv_lines.amount), 0) + nvl(SUM(inv_lines.tax_amount), 0) AS invoice_amount
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
                ) AS collected_amount
            FROM
                xxpm_cancellation       xcn,
                xxpm_booking_header     xbh,
                xxpm_property_master    xpm,
                xxpm_booking_customer   xbc,
                xxstg_customer          xc
            WHERE
                xbh.booking_hdr_id (+) = xcn.booking_id
                AND xpm.property_id (+) = xbh.property_id
                AND xbh.booking_hdr_id = xbc.booking_hdr_id (+)
                AND xbc.primary_yn = 'Y'
                AND xbc.cust_id = xc.cust_id (+)
        )