--------------------------------------------------------
--  DDL for View XXPM_MODIFIERS_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MODIFIERS_PCS_V" ("PL_MOD_ID", "PL_ID", "MOD_ID", "MOD_NAME", "START_DATE", "END_DATE", "MOD_LEVEL_CODE", "MOD_LEVEL_NAME", "MOD_CATEGORY_CODE", "MOD_CATEGORY_NAME", "MOD_TYPE_CODE", "MOD_TYPE_VALUE", "MOD_VALUE") AS 
  SELECT DISTINCT
        plm.pl_mod_id,
        plm.pl_id,
        plm.mod_id,
        pmod.mod_name,
        trunc(plm.start_date),
        trunc(plm.end_date),
        pmod.mod_level,
        NULL,
        pmod.mod_category,
        lp2.lookup_value_name_disp,
        pmod.mod_type,
        lp3.lookup_value_name_disp,
        pmod.mod_value
    FROM
        xxpm_pl_modifiers   plm,
        xxpm_modifiers      pmod,
--    XXFND_LOOKUP_V LP1,
        xxfnd_lookup_v      lp2,
        xxfnd_lookup_v      lp3
    WHERE
        plm.mod_id = pmod.mod_id
--  AND LP1.LOOKUP_TYPE_NAME ='DISCOUNT_LEVEL'
--  AND LP1.LOOKUP_VALUE_NAME= PMOD.MOD_LEVEL
        AND lp2.lookup_type_name = 'CATEGORY'
        AND lp2.lookup_value_name = pmod.mod_category
        AND lp3.lookup_type_name = 'DISCOUNT_TYPE'
        AND lp3.lookup_value_name = pmod.mod_type
    ORDER BY
        plm.pl_mod_id DESC
