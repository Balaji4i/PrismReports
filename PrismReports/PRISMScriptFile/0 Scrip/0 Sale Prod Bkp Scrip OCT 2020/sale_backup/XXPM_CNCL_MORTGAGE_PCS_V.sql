--------------------------------------------------------
--  DDL for View XXPM_CNCL_MORTGAGE_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_CNCL_MORTGAGE_PCS_V" ("MORT_NUMBER", "MORT_AMOUNT", "BOOKING_HDR_ID", "MORT_ID") AS 
  SELECT
        mort_number,
        mort_amount,
        booking_hdr_id,
        mort_id
    FROM
        xxpm_property_mortgage
