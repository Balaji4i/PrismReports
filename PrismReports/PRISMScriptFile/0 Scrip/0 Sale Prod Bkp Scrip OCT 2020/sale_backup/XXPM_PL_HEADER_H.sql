--------------------------------------------------------
--  DDL for Table XXPM_PL_HEADER_H
--------------------------------------------------------

  CREATE TABLE "XXPM_PL_HEADER_H" 
   (	"PL_ID_H" NUMBER, 
	"PL_ID" NUMBER, 
	"PL_NAME" VARCHAR2(60), 
	"PL_NAME_TL" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(2000), 
	"ORG_ID" NUMBER, 
	"FUNC_ID" NUMBER, 
	"PL_TYPE" VARCHAR2(60), 
	"PRIORITY" NUMBER, 
	"USAGE" VARCHAR2(30), 
	"CURRENCY_CODE" VARCHAR2(3), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"REVISION_NO" NUMBER, 
	"REVISION_DATE" DATE, 
	"REVISED_BY" VARCHAR2(60), 
	"STATUS" VARCHAR2(30), 
	"FLOW_STATUS" VARCHAR2(30), 
	"FLOW_WITH" NUMBER, 
	"FLOW_LEVEL" NUMBER, 
	"USER_GRP_ID" NUMBER, 
	"BASE_PRICE_YN" VARCHAR2(1), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"PL_NUMBER" VARCHAR2(60)
   )