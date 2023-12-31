--------------------------------------------------------
--  DDL for Table XXPM_ACTIVITY_LOG
--------------------------------------------------------

  CREATE TABLE "XXPM_ACTIVITY_LOG" 
   (	"ACTIVITY_ID" NUMBER, 
	"ACTIVITY_NUMBER" VARCHAR2(30), 
	"ACTIVITY_DATE" DATE, 
	"FUNC_ID" NUMBER, 
	"SOURCE_FUNC_ID" NUMBER, 
	"SOURCE_FUNC_REF_ID" NUMBER, 
	"ORG_ID" NUMBER, 
	"PROPERTY_ID" NUMBER, 
	"BUILD_ID" NUMBER, 
	"UNIT_ID" NUMBER, 
	"ACTIVITY_TYPE" VARCHAR2(60), 
	"ACTIVITY_REF_NUMBER" VARCHAR2(240), 
	"ACTIVITY_REF_DATE" DATE, 
	"STATUS" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
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
