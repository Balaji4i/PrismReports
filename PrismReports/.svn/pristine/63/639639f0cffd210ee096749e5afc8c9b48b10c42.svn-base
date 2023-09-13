--------------------------------------------------------
--  DDL for View XXPM_PRICELIST_LINE_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PRICELIST_LINE_PCS_V" ("PLL_ID", "PL_ID", "PROPERTY_ID", "PPROPERTY_NAME", "BUILD_ID", "BUILD_NAME", "UNIT_ID", "UNIT_TYPE", "VIEW_TYPE", "UNIT_NAME", "UOM", "BASE_PRICE", "MIN_PRICE", "START_DATE", "END_DATE") AS 
  SELECT DISTINCT
        pll_id,
        pll.pl_id,
        pll.property_id,
        pm.property_name,
        pll.build_id,
        bm.build_name,
        pll.unit_id,
        lp1.lookup_value_name_disp,
        lp2.lookup_value_name_disp,
        um.unit_name,
        pll.uom,
        base_price,
        min_price,
        trunc(pll.start_date),
        trunc(pll.end_date)
    FROM
        xxpm_pl_lines             pll,
        xxpm_property_master      pm,
        xxpm_property_buildings   bm,
        xxpm_property_units       um,
        xxfnd_lookup_v            lp1,
        xxfnd_lookup_v            lp2
    WHERE
        pll.property_id = pm.property_id
        AND pll.build_id = bm.build_id
        AND pll.unit_id = um.unit_id
        AND lp1.lookup_type_name = 'UNIT_TYPE'
        AND lp1.lookup_value_name = um.unit_type
        AND lp2.lookup_type_name = 'UNIT_VIEW_TYPE'
        AND lp2.lookup_value_name = um.view_type
    ORDER BY
        pll.pll_id DESC
