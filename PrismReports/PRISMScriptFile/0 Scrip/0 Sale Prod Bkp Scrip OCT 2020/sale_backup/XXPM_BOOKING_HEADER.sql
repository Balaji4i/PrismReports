--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_HEADER
--------------------------------------------------------

  CREATE TABLE "XXPM_BOOKING_HEADER" 
   (	"BOOKING_HDR_ID" NUMBER, 
	"ORG_ID" NUMBER, 
	"FUNC_ID" NUMBER, 
	"PROPERTY_ID" NUMBER, 
	"OFFER_HDR_ID" NUMBER, 
	"BLOCK_ID" NUMBER, 
	"BOOKING_NUMBER" VARCHAR2(60), 
	"BOOKING_DATE" DATE, 
	"BOOKING_END_DATE" DATE, 
	"BOOKING_FROM_DATE" DATE, 
	"BOOKING_TO_DATE" DATE, 
	"SPA_PCT" NUMBER, 
	"AREA_VARIATION_PCT" NUMBER, 
	"USAGE" VARCHAR2(30), 
	"BOOKING_EXE_BY" NUMBER, 
	"REVISION_NO" NUMBER, 
	"REVISION_DATE" DATE, 
	"REVISED_BY" VARCHAR2(60), 
	"MS_HDR_ID" NUMBER, 
	"PL_ID" NUMBER, 
	"BOOKING_TYPE" VARCHAR2(60), 
	"BOOKING_STAGE" VARCHAR2(60), 
	"LEAD_ID" NUMBER, 
	"SALESMAN_ID" NUMBER, 
	"CURRENCY_CODE" VARCHAR2(3), 
	"CHECKLIST" VARCHAR2(250), 
	"TERMS_DESC" VARCHAR2(2000), 
	"OBJECT_VERSION_NUMBER" NUMBER, 
	"BOOKING_FLAG" VARCHAR2(60), 
	"TAX_CODE" VARCHAR2(60), 
	"PREV_BOOKING_ID" NUMBER, 
	"LEAD_SOURCE_CHANNEL" VARCHAR2(240), 
	"LEAD_SOURCE_NAME" VARCHAR2(240), 
	"VEND_ID" NUMBER, 
	"VEND_SITE_ID" NUMBER, 
	"VEND_CONTRACT_NO" VARCHAR2(240), 
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
	"MIGRATED_DATA" VARCHAR2(5), 
	"ACTIVE_YN" VARCHAR2(1)
   )
