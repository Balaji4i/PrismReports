--------------------------------------------------------
--  DDL for View XXPM_AREA_CHANGE_LINE_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_AREA_CHANGE_LINE_PCS_V" (
    "AREA_CNG_DLT_ID",
    "AREA_CNG_HDR_ID",
    "PROPERTY_NAME",
    "BUILD_NAME",
    "UNIT_NAME",
    "UNIT_CATEGORY",
    "BOOKING_NUMBER",
    "STATUS",
    "UOM",
    "OLD_AREA_VALUE",
    "NEW_AREA_VALUE",
    "DESCRIPTION",
    "ADJ_BOOKING_AMOUNT",
    "SPA_PCT",
    "AREA_EXCEED_TOLERANCE",
    "CUST_ACCEPTED_YN"
) AS
    SELECT
        xd.area_cng_dlt_id,
        xd.area_cng_hdr_id,
        xp.property_name,
        xb.build_name,
        xu.unit_name,
        clk.lookup_value_name_disp   AS unit_category,
        xbh.booking_number,
        slk.lookup_value_name_disp   AS status,
        ulk.lookup_value_name_disp   AS uom,
        xd.old_area_value,
        xd.new_area_value,
        xd.description,
        xd.adj_booking_amount,
        xbh.spa_pct,
        xd.area_exceed_tolerance,
        xd.cust_accepted_yn
    FROM
        xxpm_area_change_dlt      xd,
        xxpm_property_master      xp,
        xxpm_property_buildings   xb,
        xxpm_property_units       xu,
        xxpm_booking_header       xbh,
        xxfnd_lookup_v            ulk,
        xxfnd_lookup_v            slk,
        xxfnd_lookup_v            clk
    WHERE
        xd.property_id = xp.property_id (+)
        AND xd.build_id = xb.build_id (+)
        AND xd.unit_id = xu.unit_id (+)
        AND 'AREA_UOM' = ulk.lookup_type_name (+)
        AND ulk.lookup_value_name (+) = xd.uom
        AND 'UNIT_STATUS' = slk.lookup_type_name (+)
        AND slk.lookup_value_name (+) = xd.unit_status
        AND 'UNIT_CATEGORY' = clk.lookup_type_name (+)
        AND clk.lookup_value_name (+) = xu.unit_category
        AND xd.booking_hdr_id = xbh.booking_hdr_id (+)