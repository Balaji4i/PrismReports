--------------------------------------------------------
--  DDL for View XXPM_BLOCKING_DETAILS_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCKING_DETAILS_PCS_V" (
    "BLOCK_DTL_ID",
    "BLOCK_ID",
    "PROPERTY_ID",
    "PROPERTY_NAME",
    "PROPERTY_NAME_TL",
    "BUILD_ID",
    "BUILD_NAME",
    "BUILD_NUMBER",
    "UNIT_ID",
    "UNIT_NAME",
    "UNIT_NUMBER",
    "UNIT_TYPE",
    "AREASQ",
    "UOM",
    "QUANTITY",
    "BASE_RATE",
    "OFFER_AMOUNT",
    "DISC_PCT",
    "DISC_AMOUNT",
    "TAX_CODE",
    "TAX_RATE",
    "TAX_AMOUNT",
    "MOD_NAME",
    "UNIT_CATEGORY",
    "CATEGORY_NAME",
    "UNIT_TYPE_NAME",
    "UOM_NAME"
) AS
    SELECT
        xbd.block_dtl_id,
        xbd.block_id,
        xbd.property_id,
        xpm.property_name,
        xpm.property_name_tl,
        xbd.build_id,
        xpb.build_name,
        xpb.build_number,
        xbd.unit_id,
        xpu.unit_name,
        xpu.unit_number,
        xpu.unit_type,
        xpa.value                    AS areasq,
        xpu.uom,
        xod.quantity,
        xod.base_rate,
        nvl(xod.offer_amount, 0) offer_amount,
        xod.disc_pct,
        nvl(xod.disc_amount, 0) disc_amount,
        xod.tax_code,
        nvl(xod.tax_rate, 0) tax_rate,
        nvl(xod.tax_amount, 0) AS tax_amount,
        xm.mod_name,
        xpu.unit_category,
        xlv.lookup_value_name_disp   AS category_nam,
        (
            SELECT
                xlv.lookup_value_name_disp
            FROM
                xxfnd_lookup_v xlv
            WHERE
                xlv.lookup_value_name = xpu.unit_type
                AND ROWNUM = 1
        ) AS unit_type_name,
        (
            SELECT
                xlv.lookup_value_name_disp
            FROM
                xxfnd_lookup_v xlv
            WHERE
                xlv.lookup_value_name = xpu.uom
                AND ROWNUM = 1
        ) AS uom_name
    FROM
        xxpm_block_detail         xbd,
        xxpm_property_master      xpm,
        xxpm_property_buildings   xpb,
        xxpm_property_units       xpu,
        xxpm_property_area        xpa,
        xxpm_block_header         xbh,
        xxpm_offer_detail         xod,
        xxpm_pl_modifiers         xpm,
        xxpm_modifiers            xm,
        xxfnd_lookup_v            xlv
    WHERE
        xbd.property_id = xpm.property_id
        AND xbd.build_id = xpb.build_id
        AND xbd.unit_id = xpu.unit_id
        AND xpb.property_id = xpm.property_id
        AND xpb.build_id = xpu.build_id
        AND xpa.unit_id = xpu.unit_id
        AND xpa.build_id = xpb.build_id
        AND xpa.property_id = xpm.property_id
        AND xbd.block_id = xbh.block_id
        AND xod.offer_hdr_id (+) = xbh.offer_hdr_id
        AND xod.pl_mod_id = xpm.pl_mod_id (+)
        AND xpm.mod_id = xm.mod_id (+)
        AND xlv.lookup_value_name = xpu.unit_category
        AND xlv.lookup_type_name = 'UNIT_CATEGORY'