--------------------------------------------------------
--  DDL for Table XXPM_REGISTRATION
--------------------------------------------------------

  CREATE TABLE "XXPM_REGISTRATION" 
   (	"REGN_ID" NUMBER, 
	"FUNC_ID" NUMBER, 
	"LEASE_AGREEMENT_ID" NUMBER, 
	"BOOKING_ID" NUMBER, 
	"REGN_NUMBER" VARCHAR2(60), 
	"REGN_DATE" DATE, 
	"TITLE_DEED_NUMBER" VARCHAR2(60), 
	"TITLE_DEED_DATE" DATE, 
	"OBJECT_VERSION_NUMBER" VARCHAR2(60), 
	"STATUS" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(240), 
	"ORG_ID" NUMBER, 
	"USER_GRP_ID" NUMBER, 
	"FLOW_STATUS" VARCHAR2(60), 
	"FLOW_LEVEL" NUMBER, 
	"FLOW_WITH" NUMBER, 
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
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
