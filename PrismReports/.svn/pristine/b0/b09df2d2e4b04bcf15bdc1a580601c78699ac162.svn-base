--------------------------------------------------------
--  DDL for View XXFND_SALEFORCES_LOOKUP_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXFND_SALEFORCES_LOOKUP_V" ("LOOKUP_TYPE_ID", "LOOKUP_TYPE_NAME", "LOOKUP_TYPE_NAME_DISP", "LOOKUP_TYPE_NAME_DISP_TL", "LT_ACCESS_LEVEL", "LT_ACTIVE_YN", "LOOKUP_VALUE_ID", "LOOKUP_VALUE_NAME", "LOOKUP_VALUE_NAME_DISP", "LOOKUP_VALUE_NAME_DISP_TL", "LOOKUP_ADDL_VALUE", "LV_ACCESS_LEVEL", "LV_ACTIVE_YN", "DISPLAY_ORDER") AS 
  SELECT
        lt.lookup_type_id,
        lt.lookup_type_name,
        lt.lookup_type_name_disp,
        lt.lookup_type_name_disp_tl,
        lt.access_level,
        lt.active_yn,
        lv.lookup_value_id,
        lv.lookup_value_name,
        lv.lookup_value_name_disp,
        lv.lookup_value_name_disp_tl,
        lv.lookup_addl_value,
        lv.access_level,
        lv.active_yn,
        lv.display_order
    FROM
        xxfnd_lookup_types    lt,
        xxfnd_lookup_values   lv
    WHERE
        lt.lookup_type_id = lv.lookup_type_id
        AND lt.lookup_type_id = lt.lookup_type_id + 0
        AND lv.lookup_type_id = lv.lookup_type_id + 0
        and lv.LOOKUP_TYPE_ID not in (13,100121,100214)
