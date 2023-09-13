
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXPRISM"."XXPM_BOOKING_CUSTOMER_V" ("ROW_ID", "BOOKING_CUST_ID", "BOOKING_HDR_ID", "CUST_ID", "CUSTOMER_NUMBER", "CUSTOMER_NAME", "SHIP_TO_SITE_ID", "SHIP_TO_SITE_NUMBER", "SHIP_TO_SITE_NAME", "BILL_TO_SITE_ID", "BILL_TO_SITE_NUMBER", "BILL_TO_SITE_NAME", "CUST_CONTACT_ID", "CONTACT_NAME", "PRIMARY_YN", "DESCRIPTION", "ATTRIBUTE_CATEGORY", "MOBILE_NUMBER", "EMAIL_ID", "ATTRIBUTE1", "ATTRIBUTE2", "ATTRIBUTE3", "ATTRIBUTE4", "ATTRIBUTE5", "ATTRIBUTE6", "ATTRIBUTE7", "ATTRIBUTE8", "ATTRIBUTE9", "ATTRIBUTE10", "ATTRIBUTE11", "ATTRIBUTE12", "ATTRIBUTE13", "ATTRIBUTE14", "ATTRIBUTE15", "ATTRIBUTE16", "ATTRIBUTE17", "ATTRIBUTE18", "ATTRIBUTE19", "ATTRIBUTE20", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN") AS 
  SELECT
        bc.rowid,
        bc.booking_cust_id,
        bc.booking_hdr_id,
        bc.cust_id,
        c.customer_number,
        c.customer_name,
        bc.ship_to_site_id,
        cs1.site_number,
        cs1.site_name,
        bc.bill_to_site_id,
        cs2.site_number,
        cs2.site_name,
        bc.cust_contact_id,
        cc.contact_name,
        bc.primary_yn,
        bc.description,
        bc.attribute_category,
        cc.mobile_number,
        cc.email_id,
        bc.attribute1,
        bc.attribute2,
        bc.attribute3,
        bc.attribute4,
        bc.attribute5,
        bc.attribute6,
        bc.attribute7,
        bc.attribute8,
        bc.attribute9,
        bc.attribute10,
        bc.attribute11,
        bc.attribute12,
        bc.attribute13,
        bc.attribute14,
        bc.attribute15,
        bc.attribute16,
        bc.attribute17,
        bc.attribute18,
        bc.attribute19,
        bc.attribute20,
        bc.created_by,
        bc.creation_date,
        bc.last_updated_by,
        bc.last_update_date,
        bc.last_update_login
    FROM
        xxpm_booking_header     xbh,
        xxpm_booking_customer   bc,
        xxstg_customer          c,
        xxstg_cust_sites        cs1,
        xxstg_cust_sites        cs2,
        xxstg_cust_contacts     cc
    WHERE
        c.cust_id (+) = bc.cust_id
        AND cs1.cust_site_id (+) = bc.ship_to_site_id
        AND cs2.cust_site_id (+) = bc.bill_to_site_id
        AND cc.cust_id (+) = bc.cust_id
        AND bc.booking_hdr_id = xbh.booking_hdr_id
        AND cs1.org_id (+) = xbh.org_id
        AND cs2.org_id (+) = xbh.org_id;
