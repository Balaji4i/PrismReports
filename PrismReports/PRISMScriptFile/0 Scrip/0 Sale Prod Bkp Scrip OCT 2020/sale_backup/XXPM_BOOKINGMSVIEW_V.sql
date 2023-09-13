--------------------------------------------------------
--  DDL for View XXPM_BOOKINGMSVIEW_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKINGMSVIEW_V" ("SOURCE_FUNC_ID", "SOURCE_FUNC_REF_ID", "SOURCE_NUMBER", "BOOKING_HDR_ID") AS 
  SELECT DISTINCT
        source_func_id,
        source_func_ref_id,
        get_source_number(source_func_id, source_func_ref_id) AS source_number,
        booking_hdr_id
    FROM
        xxpm_booking_milestones_v
    WHERE
        booking_hdr_id IS NOT NULL
    ORDER BY
        booking_hdr_id DESC
