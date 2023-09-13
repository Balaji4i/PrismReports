--------------------------------------------------------
--  DDL for View XXPM_PROPERTY_MORTGAGE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PROPERTY_MORTGAGE_V" ("ROW_ID", "MORT_ID", "UNIT_ID", "FUNC_ID", "MORT_NUMBER", "MORT_DATE", "START_DATE", "END_DATE", "MORT_DESCRIPTION", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "MORT_STATUS", "MORT_AMOUNT", "MORT_DOC_NO", "MORT_VERIFIED_YN", "BANK_ID", "BANK_NAME", "BRANCH_ID", "BRANCH_NAME", "BOOKING_HDR_ID", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "USER_GRP_ID", "UNIT_NAME", "BOOKING_NUMBER", "MORT_VERIFIED_YN_DESC", "ATTRIBUTE_CAT", "ATTRIBUTE1", "ATTRIBUTE2", "ATTRIBUTE3", "ATTRIBUTE4", "ATTRIBUTE5", "ATTRIBUTE6", "ATTRIBUTE7", "ATTRIBUTE8", "ATTRIBUTE9", "ATTRIBUTE10") AS 
  SELECT
        xpm.rowid,
        xpm.mort_id,
        xpm.unit_id,
        xpm.func_id,
        xpm.mort_number,
        xpm.mort_date,
        xpm.start_date,
        xpm.end_date,
        xpm.mort_description,
        xpm.created_by,
        xpm.creation_date,
        xpm.last_updated_by,
        xpm.last_update_date,
        xpm.last_update_login,
        xpm.mort_status,
        xpm.mort_amount,
        xpm.mort_doc_no,
        xpm.mort_verified_yn,
        xpm.bank_id,
        xsb.bank_name,
        xpm.branch_id,
        xsb.branch_name,
        xpm.booking_hdr_id,
        xpm.flow_status,
        xpm.flow_level,
        xpm.flow_with,
        xpm.user_grp_id,
        xpu.unit_name,
        xbh.booking_number,
        xlv.lookup_value_name_disp,
        xpm.attribute_category,
        xpm.attribute1,
        xpm.attribute2,
        xpm.attribute3,
        xpm.attribute4,
        xpm.attribute5,
        xpm.attribute6,
        xpm.attribute7,
        xpm.attribute8,
        xpm.attribute9,
        xpm.attribute10
    FROM
        xxpm_property_mortgage   xpm,
        xxstg_banks              xsb,
        xxpm_property_units      xpu,
        xxpm_booking_header      xbh,
        xxfnd_lookup_v           xlv
    WHERE
        xsb.bank_id (+) = xpm.bank_id
        AND xsb.branch_id (+) = xpm.branch_id
        AND xpu.unit_id (+) = xpm.unit_id
        AND xbh.booking_hdr_id (+) = xpm.booking_hdr_id
        AND xlv.lookup_type_name (+) = 'YES_NO'
        AND xlv.lookup_value_name (+) = xpm.mort_verified_yn
