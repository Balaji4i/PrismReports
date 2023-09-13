--------------------------------------------------------
--  DDL for Table XXDM_OFFER_HEADER
--------------------------------------------------------

  CREATE TABLE "XXDM_OFFER_HEADER" 
   (	"OFFER_HDR_ID" NUMBER, 
	"ORG_ID" NUMBER, 
	"FUNC_ID" NUMBER, 
	"OFFER_NUMBER" VARCHAR2(60), 
	"OFFER_DATE" DATE, 
	"OFFER_FROM_DATE" DATE, 
	"OFFER_TO_DATE" DATE, 
	"PERFORMED_BY" NUMBER, 
	"REVISION_NO" NUMBER, 
	"REVISION_DATE" DATE, 
	"REVISED_BY" VARCHAR2(60), 
	"MS_HDR_ID" NUMBER, 
	"PL_ID" NUMBER, 
	"OFFER_TYPE" VARCHAR2(60), 
	"LEAD_ID" NUMBER, 
	"CUSTOMER_ID" NUMBER, 
	"CUST_SITE_ID" NUMBER, 
	"CUSTOMER_NAME" VARCHAR2(250), 
	"CUSTOMER_PHONE_NO" VARCHAR2(250), 
	"CUSTOMER_COUNTRY" VARCHAR2(250), 
	"SALESMAN_ID" NUMBER, 
	"CURRENCY_CODE" VARCHAR2(3), 
	"CHECKLIST" VARCHAR2(250), 
	"TERMS_DESC" VARCHAR2(2000), 
	"OBJECT_VERSION_NUMBER" NUMBER, 
	"OFFER_FLAG" VARCHAR2(60), 
	"TAX_CODE" VARCHAR2(60), 
	"PREV_BOOKING_ID" NUMBER, 
	"STATUS" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(240), 
	"FLOW_STATUS" VARCHAR2(60), 
	"FLOW_LEVEL" NUMBER, 
	"FLOW_WITH" NUMBER, 
	"USER_GRP_ID" NUMBER, 
	"ATTRIBUTE_CATEGORY" VARCHAR2(240), 
	"ATTRIBUTE1" VARCHAR2(240), 
	"ATTRIBUTE2" VARCHAR2(240), 
	"ATTRIBUTE3" VARCHAR2(240), 
	"ATTRIBUTE4" VARCHAR2(240), 
	"ATTRIBUTE5" VARCHAR2(240), 
	"ATTRIBUTE6" VARCHAR2(240), 
	"ATTRIBUTE7" VARCHAR2(240), 
	"ATTRIBUTE8" VARCHAR2(240), 
	"ATTRIBUTE9" VARCHAR2(240), 
	"ATTRIBUTE10" VARCHAR2(240), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"OFFER_END_DATE" DATE, 
	"USAGE" VARCHAR2(30), 
	"LEAD_SOURCE_CHANNEL" VARCHAR2(240), 
	"LEAD_SOURCE_NAME" VARCHAR2(240), 
	"VEND_ID" NUMBER, 
	"VEND_SITE_ID" NUMBER, 
	"VEND_CONTRACT_NO" VARCHAR2(240), 
	"PROPERTY_ID" NUMBER, 
	"EMAIL_ID" VARCHAR2(60), 
	"LEASE_AGREEMENT_ID" NUMBER, 
	"CAR_PARK_LEASE_AGRE_ID" NUMBER, 
	"CUST_ACCEPT" VARCHAR2(1), 
	"STATUS_FLAG" VARCHAR2(10), 
	"ERR_MESSAGE" VARCHAR2(1000)
   )
