--------------------------------------------------------
--  DDL for View XXPM_OFFER_DETAIL_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_OFFER_DETAIL_V" ("OFFER_DTL_ID", "OFFER_HDR_ID", "PROPERTY_ID", "PROPERTY_NAME", "PROPERTY_NUMBER", "BUILDING_ID", "BUILD_NAME", "BUILD_NUMBER", "UNIT_ID", "UNIT_NAME", "UNIT_NUMBER", "UOM", "QUANTITY", "BASE_RATE", "OFFER_AMOUNT", "PL_MOD_ID", "DISC_PCT", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN") AS 
  SELECT
        od.offer_dtl_id,
        od.offer_hdr_id,
        od.property_id,
        pm.property_name,
        pm.property_number,
        od.building_id,
        pb.build_name,
        pb.build_number,
        od.unit_id,
        pu.unit_name,
        pu.unit_number,
        lookup_value_name_disp AS uom,
        od.quantity,
        od.base_rate,
        od.offer_amount,
        od.pl_mod_id,
        od.disc_pct,
        od.disc_amount,
        od.tax_code,
        od.tax_rate,
        od.tax_amount,
        od.created_by,
        od.creation_date,
        od.last_updated_by,
        od.last_update_date,
        od.last_update_login
    FROM
        xxpm_offer_detail         od,
        xxpm_property_master      pm,
        xxpm_property_buildings   pb,
        xxpm_property_units       pu,
        xxfnd_lookup_v            lk
    WHERE
        od.property_id = pm.property_id
        AND od.building_id = pb.build_id
        AND od.unit_id = pu.unit_id
        AND od.uom = lk.lookup_value_name
        AND lk.lookup_type_name = 'AREA_UOM'
