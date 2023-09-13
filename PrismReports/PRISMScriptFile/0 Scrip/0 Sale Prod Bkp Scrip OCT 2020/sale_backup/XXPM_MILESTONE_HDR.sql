--------------------------------------------------------
--  DDL for Table XXPM_MILESTONE_HDR
--------------------------------------------------------

  CREATE TABLE "XXPM_MILESTONE_HDR" 
   (	"MS_HDR_ID" NUMBER, 
	"MILESTONE_NAME" VARCHAR2(240), 
	"MILESTONE_NAME_TL" VARCHAR2(240), 
	"MILESTONE_NUMBER" VARCHAR2(60), 
	"MILESTONE_SHORTCODE" VARCHAR2(60), 
	"MILESTONE_DATE" DATE, 
	"FUNC_ID" NUMBER, 
	"ORG_ID" NUMBER, 
	"PROJECT_ID" NUMBER, 
	"MILESTONE_TYPE" VARCHAR2(30), 
	"USAGE" VARCHAR2(30), 
	"REVISION_NO" NUMBER, 
	"REVISION_DATE" DATE, 
	"REVISED_BY" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"ACTIVE_YN" VARCHAR2(1), 
	"STATUS" VARCHAR2(60), 
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
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )