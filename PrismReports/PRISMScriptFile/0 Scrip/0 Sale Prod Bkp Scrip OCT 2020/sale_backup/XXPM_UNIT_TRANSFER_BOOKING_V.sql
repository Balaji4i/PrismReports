--------------------------------------------------------
--  DDL for View XXPM_UNIT_TRANSFER_BOOKING_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_UNIT_TRANSFER_BOOKING_V" ("UNIT_TRANSFER_ID", "CANCEL_ID", "BOOKING_HDR_ID", "UNIT_TRANSFER_DATE", "FROM_CUSTOMER", "TO_CUSTOMER", "FROM_CUSTOME_SITE", "TO_CUSTOME_SITE") AS 
  SELECT 
ut.UNIT_TRANSFER_ID, ut.CANCEL_ID, ut.BOOKING_HDR_ID, ut.UNIT_TRANSFER_DATE, 
from_cus.CUSTOMER_NAME as From_Customer , to_cus.CUSTOMER_NAME as To_Customer,
from_cus_site.SITE_NUMBER from_Custome_Site, to_cus_site.SITE_NUMBER as To_Custome_Site
FROM XXPM_UNIT_TRANSFER_DETAILS ut, 
xxstg_customer from_cus, xxstg_customer to_cus, 
xxstg_cust_sites from_cus_site
,xxstg_cust_sites to_cus_site
,xxpm_booking_header bk
WHERE 
from_cus.CUST_ID=ut.FROM_CUSTOMER
and to_cus.CUST_ID=ut.TO_CUSTOMER
and from_cus_site.CUST_SITE_ID=ut.FROM_CUSTOMER_BILL_TO
and to_cus_site.CUST_SITE_ID=ut.TO_CUSTOMER_BILL_TO
and bk.BOOKING_HDR_ID=ut.booking_hdr_id
and bk.ORG_ID=from_cus_site.ORG_ID
and bk.ORG_ID=to_cus_site.ORG_ID
