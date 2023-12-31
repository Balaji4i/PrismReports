--------------------------------------------------------
--  DDL for Table XXPM_UNBLOCK_HEADER
--------------------------------------------------------

  CREATE TABLE "XXPM_UNBLOCK_HEADER" 
   (	"UNBLOCK_ID" NUMBER, 
	"BLOCK_ID" NUMBER, 
	"UNBLOCK_NUMBER" VARCHAR2(30), 
	"UNBLOCK_DATE" DATE, 
	"ORG_ID" NUMBER, 
	"STATUS" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
	"FUNC_ID" NUMBER, 
	"FLOW_STATUS" VARCHAR2(60), 
	"FLOW_LEVEL" NUMBER, 
	"FLOW_WITH" NUMBER, 
	"USER_GRP_ID" NUMBER, 
	"CREATED_BY" VARCHAR2(60), 
	"CREATED_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(60)
   )
