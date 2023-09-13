--------------------------------------------------------
--  DDL for View XXPM_BOOKING_DETAIL_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKING_DETAIL_V" ("ROW_ID", "BOOKING_DTL_ID", "BOOKING_HDR_ID", "PROPERTY_ID", "PROPERTY_NAME", "BUILDING_ID", "BUILD_NAME", "UNIT_ID", "UNIT_NAME", "UNIT_CATEGORY", "UNIT_TYPE", "UNIT_TYPE_DESC", "AREA_TYPE", "AREA_TYPE_DESC", "BOOKING_RATE", "BOOKING_AMOUNT", "UOM", "QUANTITY", "PL_MOD_ID", "DISC_PCT", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "ATTRIBUTE_CATEGORY", "ATTRIBUTE1", "ATTRIBUTE2", "ATTRIBUTE3", "ATTRIBUTE4", "ATTRIBUTE5", "ATTRIBUTE6", "ATTRIBUTE7", "ATTRIBUTE8", "ATTRIBUTE9", "ATTRIBUTE10", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN") AS 
  SELECT
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
        xpu.unit_type,
        l1.lookup_value_name_disp,
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
        xbd.creation_date,
        xbd.last_updated_by,
        xbd.last_update_date,
        xbd.last_update_login
    FROM
        xxpm_booking_detail       xbd,
        xxpm_property_master      xpm,
        xxpm_property_buildings   xpb,
        xxpm_property_units       xpu,
        xxfnd_lookup_v            l1,
        xxfnd_lookup_v            l2
    WHERE
        xbd.property_id = xpm.property_id (+)
        AND xbd.building_id = xpb.build_id (+)
        AND xbd.unit_id = xpu.unit_id (+)
        AND xpu.unit_type = l1.lookup_value_name (+)
        AND l1.lookup_type_name (+) = 'UNIT_TYPE'
        AND xpu.area_type = l2.lookup_value_name (+)
        AND l2.lookup_type_name (+) = 'UNIT_AREA_TYPE'
