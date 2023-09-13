--------------------------------------------------------
--  DDL for View XXPM_AREA_CHANGE_HEADER_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_AREA_CHANGE_HEADER_PCS_V" (
    "AREA_CNG_HDR_ID",
    "AREA_CNG_NUMBER",
    "AREA_CNG_DATE",
    "HEADER_STATUS",
    "DESCRIPTION",
    "FUNC_ID"
) AS
    SELECT
        xh.area_cng_hdr_id,
        xh.area_cng_number,
        xh.area_cng_date,
        lk.lookup_value_name_disp header_status,
        xd.description,
        xh.func_id
    FROM
        xxpm_area_change_hdr   xh,
        xxpm_area_change_dlt   xd,
        xxfnd_lookup_v         lk
    WHERE
        xh.area_cng_hdr_id = xd.area_cng_hdr_id (+)
        AND lk.lookup_type_name = 'BOOKING_STATUS'
        AND xh.status = lk.lookup_value_name