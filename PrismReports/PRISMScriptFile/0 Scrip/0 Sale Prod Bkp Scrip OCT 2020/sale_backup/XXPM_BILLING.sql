--------------------------------------------------------
--  DDL for Table XXPM_BILLING
--------------------------------------------------------

  CREATE TABLE "XXPM_BILLING" 
   (	"BILLING_ID" NUMBER, 
	"BILLING_NUMBER" VARCHAR2(30), 
	"BILLING_DATE" DATE, 
	"USAGE" VARCHAR2(30), 
	"ORG_ID" NUMBER, 
	"STATUS" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
	"FUNC_ID" NUMBER, 
	"FLOW_STATUS" VARCHAR2(60), 
	"FLOW_LEVEL" NUMBER, 
	"FLOW_WITH" NUMBER, 
	"USER_GRP_ID" NUMBER, 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(60), 
	"PROJECT_ID" NUMBER
   )
