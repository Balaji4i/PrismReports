--------------------------------------------------------
--  DDL for View XXPM_AREA_CHANGE_DLT_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_AREA_CHANGE_DLT_PCS_V" ("AREA_CNG_DLT_ID", "AREA_CNG_HDR_ID", "AREA_CNG_NUMBER", "FUNC_ID", "USER_GRP_ID", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "AREA_CNG_DATE", "PROPERTY_ID", "PROPERTY_NAME", "BUILD_ID", "BUILD_NAME", "UNIT_ID", "UNIT_NAME", "UNIT_CATEGORY", "UNIT_STATUS_DISP", "UOM_DISP", "UNIT_STATUS", "AREA_ID", "AREA_TYPE", "UOM", "OLD_AREA_VALUE", "NEW_AREA_VALUE", "BOOKING_HDR_ID", "BOOKING_NUMBER", "SPA_PCT", "AREA_VARIATION_PCT", "AREA_EXCEED_TOLERANCE", "OLD_BOOKING_AMOUNT", "NEW_BOOKING_AMOUNT", "ADJ_BOOKING_AMOUNT", "CUST_ACCEPTED_YN", "CUST_ACCEPTED", "STATUS", "DESCRIPTION", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "UNIT_CATEGORY_CODE") AS 
  SELECT
        acd.area_cng_dlt_id,
        acd.area_cng_hdr_id,
        ach.area_cng_number,
        ach.func_id,
        acd.user_grp_id,
        acd.flow_status,
        acd.flow_level,
        acd.flow_with,
        ach.area_cng_date,
        acd.property_id,
        xpm.property_name,
        acd.build_id,
        xpb.build_name,
        acd.unit_id,
        xpu.unit_name,
        (
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_value_name = xpu.unit_category
                AND ROWNUM = 1
        ) AS unit_category,
        (
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_value_name = acd.unit_status
                AND ROWNUM = 1
        ) AS unit_status_disp,
        (
            SELECT
                lookup_value_name_disp
            FROM
                xxfnd_lookup_v
            WHERE
                lookup_value_name = acd.uom
                AND ROWNUM = 1
        ) AS uom_disp,
        acd.unit_status,
        acd.area_id,
        acd.area_type,
        acd.uom,
        acd.old_area_value,
        acd.new_area_value,
        acd.booking_hdr_id,
        (
            SELECT
                booking_number
            FROM
                xxpm_booking_header
            WHERE
                booking_hdr_id = acd.booking_hdr_id
                AND ROWNUM = 1
        ) AS booking_number,
        acd.spa_pct,
        acd.area_variation_pct,
        acd.area_exceed_tolerance,
        acd.old_booking_amount,
        acd.new_booking_amount,
        acd.adj_booking_amount,
        acd.cust_accepted_yn,
        CASE
            WHEN acd.cust_accepted_yn = 'Y' THEN
                'Yes'
            WHEN acd.cust_accepted_yn = 'N' THEN
                'No'
            ELSE
                NULL
        END AS cust_accepted,
        acd.status,
        acd.description,
        acd.created_by,
        trunc(acd.creation_date) AS creation_date,
        acd.last_updated_by,
        trunc(acd.last_update_date) AS last_update_date,
        acd.last_update_login,
        xpu.unit_category AS unit_category_code
    FROM
        xxpm_property_master      xpm,
        xxpm_property_buildings   xpb,
        xxpm_property_units       xpu,
        xxpm_area_change_dlt      acd,
        xxpm_area_change_hdr      ach
    WHERE
        ach.area_cng_hdr_id = acd.area_cng_hdr_id
        AND xpm.property_id = xpb.property_id
        AND xpb.build_id = xpu.build_id
        AND acd.property_id = xpm.property_id
        AND acd.build_id = xpb.build_id
        AND acd.unit_id = xpu.unit_id
