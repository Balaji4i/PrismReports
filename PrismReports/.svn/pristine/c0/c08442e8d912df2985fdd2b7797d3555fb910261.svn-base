--------------------------------------------------------
--  DDL for View XXPM_PAYMENT_CHANGE_LINE_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PAYMENT_CHANGE_LINE_PCS_V" ("MS_REV_ID", "MS_REV_DTL_ID", "BUILDING_ID", "BUILD_NAME", "UNIT_ID", "UNIT_NAME", "UNIT_TYPE", "VALUE", "MOD_NAME", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "TOTAL_AMOUNT") AS 
  SELECT
        xbmrd.ms_rev_id,
        xbmrd.ms_rev_dtl_id,
        xbd.building_id,
        xpd.build_name,
        xbd.unit_id,
        xpu.unit_name,
        xpu.unit_type,
        xpa.value,
        xm.mod_name,
        xbd.disc_amount,
        xbd.tax_code,
        xbd.tax_rate,
        xbd.tax_amount,
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
        ) AS total_amount
    FROM
        xxpm_book_ms_rev_hdr      xbmrh,
        xxpm_book_ms_rev_dtl      xbmrd,
        xxpm_booking_header       xbh,
        xxpm_booking_detail       xbd,
        xxpm_property_units       xpu,
        xxpm_property_area        xpa,
        xxpm_pl_modifiers         xpm,
        xxpm_modifiers            xm,
        xxpm_property_buildings   xpd
    WHERE
        xbmrh.ms_rev_id = xbmrd.ms_rev_id
        AND xbh.booking_hdr_id = xbmrh.booking_hdr_id
        AND xbh.booking_hdr_id = xbd.booking_hdr_id
        AND xpu.unit_id = xbd.unit_id
        AND xpa.unit_id = xbd.unit_id
        AND xpa.property_id = xbd.property_id
        AND xpa.build_id = xbd.building_id
        AND xbd.pl_mod_id = xpm.pl_mod_id (+)
        AND xpm.mod_id = xm.mod_id (+)
        AND xpa.build_id = xpd.build_id
