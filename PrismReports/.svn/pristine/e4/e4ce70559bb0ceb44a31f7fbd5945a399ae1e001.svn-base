--------------------------------------------------------
--  DDL for View XXPM_BOOKING_CUSTOMER_DTL_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BOOKING_CUSTOMER_DTL_V" ("BOOKING_CUST_ID", "BOOKING_HDR_ID", "ORG_ID", "CUST_ID", "PRIMARY_YN", "CUSTOMER_NUMBER", "CUSTOMER_NAME", "SITE_NUMBER", "ADDRESS1", "ADDRESS2", "ADDRESS3", "ADDRESS4", "CITY", "POSTAL_CODE", "STATE", "PROVINCE", "COUNTY", "COUNTRY", "DESCRIPTION") AS 
  SELECT 
bc.BOOKING_CUST_ID, bc.BOOKING_HDR_ID, cussite.ORG_ID, bc.CUST_ID, bc.PRIMARY_YN, 
cus.CUSTOMER_NUMBER, cus.CUSTOMER_NAME, cussite.SITE_NUMBER,
cussite.ADDRESS1, cussite.ADDRESS2, cussite.ADDRESS3, cussite.ADDRESS4, cussite.CITY, cussite.POSTAL_CODE, cussite.STATE, cussite.PROVINCE, cussite.COUNTY, cussite.COUNTRY,
bc.DESCRIPTION
FROM xxpm_booking_customer bc, xxstg_customer cus, xxstg_cust_sites cussite
where 
bc.CUST_ID=cus.CUST_ID
and cussite.CUST_ID=cus.CUST_ID
