--------------------------------------------------------
--  DDL for View XXPM_BOOKING_DETAIL_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKING_DETAIL_PCS_V" ("ROW_ID", "BOOKING_DTL_ID", "BOOKING_HDR_ID", "PROPERTY_ID", "PROPERTY_NAME", "BUILDING_ID", "BUILD_NAME", "UNIT_ID", "UNIT_NAME", "UNIT_CATEGORY", "UNIT_TYPE", "UNIT_TYPE_DESC", "AREA_TYPE", "AREA_TYPE_DESC", "BOOKING_RATE", "BOOKING_AMOUNT", "UOM", "QUANTITY", "PL_MOD_ID", "DISC_PCT", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "ATTRIBUTE_CATEGORY", "ATTRIBUTE1", "ATTRIBUTE2", "ATTRIBUTE3", "ATTRIBUTE4", "ATTRIBUTE5", "ATTRIBUTE6", "ATTRIBUTE7", "ATTRIBUTE8", "ATTRIBUTE9", "ATTRIBUTE10", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "AREASQ", "DISC_NAME", "TOTAL_AMOUNT") AS 
  SELECT DISTINCT
        xbd.rowid,
        xbd.booking_dtl_id,
        xbd.booking_hdr_id,
        xbd.property_id,
        xpm.property_name,
        xbd.building_id,
        xpb.build_name,
        xbd.unit_id,
        xpu.unit_name,
        xpu.unit_category,
        l1.lookup_value_name_disp,
        xpu.unit_type,
        xpu.area_type,
        l2.lookup_value_name_disp,
        xbd.booking_rate,
        xbd.booking_amount,
        xbd.uom,
        xbd.quantity,
        xbd.pl_mod_id,
        xbd.disc_pct,
        xbd.disc_amount,
        xbd.tax_code,
        xbd.tax_rate,
        xbd.tax_amount,
        xbd.attribute_category,
        xbd.attribute1,
        xbd.attribute2,
        xbd.attribute3,
        xbd.attribute4,
        xbd.attribute5,
        xbd.attribute6,
        xbd.attribute7,
        xbd.attribute8,
        xbd.attribute9,
        xbd.attribute10,
        xbd.created_by,
        trunc(xbd.creation_date) AS creation_date,
        xbd.last_updated_by,
        trunc(xbd.last_update_date) AS last_update_date,
        xbd.last_update_login,
        xpa.value            AS areasq,
        xm.mod_name          AS disc_name,
        xbd.booking_amount   AS total_amount
    FROM
        xxpm_booking_detail       xbd,
        xxpm_booking_header       xbh,
        xxpm_property_master      xpm,
        xxpm_property_buildings   xpb,
        xxpm_property_units       xpu,
        xxfnd_lookup_v            l1,
        xxfnd_lookup_v            l2,
        xxpm_property_area        xpa,
        xxpm_pl_modifiers         xpm,
        xxpm_modifiers            xm
    WHERE
        xbh.booking_hdr_id = xbd.booking_hdr_id
        AND xbd.property_id = xpm.property_id (+)
        AND xbd.building_id = xpb.build_id (+)
        AND xbd.unit_id = xpu.unit_id (+)
        AND xpu.unit_type = l1.lookup_value_name (+)
        AND l1.lookup_type_name (+) = 'UNIT_TYPE'
        AND xpu.area_type = l2.lookup_value_name (+)
        AND l2.lookup_type_name (+) = 'UNIT_AREA_TYPE'
        AND xpa.unit_id = xpu.unit_id
        AND xpa.build_id = xpb.build_id
        AND xpa.property_id = xpm.property_id
        AND xbd.pl_mod_id = xpm.pl_mod_id (+)
        AND xpm.mod_id = xm.mod_id (+)
