--------------------------------------------------------
--  DDL for View XXPM_HANDOVER_HEADER_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_HANDOVER_HEADER_PCS_V" ("MOVE_IO_ID", "MOVE_IO_NUMBER", "USAGE", "IO_FLAG", "ORG_ID", "BUSINESS_UNIT", "BOOKING_NUMBER", "PROPERTY_NAME", "PROPERTY_ID", "BUILD_NAME", "BUILD_ID", "UNIT_NAME", "UNIT_ID", "CUSTOMER_NAME", "STATUS", "TOTAL_INVOICE_AMOUNT", "TOTAL_RECEIPT_AMOUNT", "TOTAL_SALE_VALUE") AS 
  SELECT DISTINCT
        xmio.move_io_id,
        xmio.move_io_number,
        xmio.usage,
        xmio.io_flag,
        xmio.org_id,
        xo.org_name                  AS business_unit,
        xbh.booking_number,
        xpm.property_name,
        xpm.property_id,
        xpb.build_name,
        xpb.build_id,
        xpu.unit_name,
        xpu.unit_id,
        xc.customer_name,
        ulk.lookup_value_name_disp   AS status,
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
                AND lv.lookup_type_name (+) = 'invoice_status'
                AND lv.lookup_value_name (+) = inv_hdr.status
                AND inv_hdr.booking_id = xbh.booking_hdr_id
        ) AS total_invoice_amount,
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
                        func_short_code = 'bl'
                )
                           AND r.source_func_ref_id = xbh.block_id ) )
        ) AS total_receipt_amount,
        (
            SELECT
                SUM(x.installment_amount)
            FROM
                xxpm_booking_milestones x
            WHERE
                x.booking_hdr_id = xbh.booking_hdr_id
                AND nvl(x.included_in_rate, 'n') = 'n'
                AND ( x.wave_off IS NULL
                      OR x.wave_off NOT IN (
                    'y',
                    'o'
                ) )
        ) AS total_sale_value
    FROM
        xxpm_move_in_out          xmio,
        xxstg_organizations       xo,
        xxpm_booking_header       xbh,
        xxpm_booking_detail       xbd,
        xxpm_property_master      xpm,
        xxpm_property_buildings   xpb,
        xxpm_property_units       xpu,
        xxpm_booking_customer     xbc,
        xxstg_customer            xc,
        xxfnd_lookup_v            ulk
    WHERE
        xo.org_id = xmio.org_id
        AND xbh.booking_hdr_id = xmio.booking_id
        AND xbd.booking_hdr_id = xbh.booking_hdr_id
        AND xbd.property_id = xpm.property_id
        AND xbd.building_id = xpb.build_id
        AND xbd.unit_id = xpu.unit_id
        AND xbc.booking_hdr_id = xbh.booking_hdr_id
        AND xc.cust_id = xbc.cust_id
        AND 'BOOKING_STATUS' = ulk.lookup_type_name (+)
        AND ulk.lookup_value_name (+) = xmio.status
