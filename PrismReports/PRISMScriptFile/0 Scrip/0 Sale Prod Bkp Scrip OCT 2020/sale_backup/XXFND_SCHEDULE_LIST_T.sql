--------------------------------------------------------
--  DDL for Table XXFND_SCHEDULE_LIST_T
--------------------------------------------------------

  CREATE TABLE "XXFND_SCHEDULE_LIST_T" 
   (	"SCHEDULE_LIST_ID" NUMBER, 
	"SCHEDULE_ID" NUMBER, 
	"SCHEDULE_NAME" VARCHAR2(240), 
	"PROGRAM_NAME" VARCHAR2(240), 
	"BI_REPORT_PATH" VARCHAR2(240), 
	"BI_REPORT_NAME" VARCHAR2(240), 
	"DB_REFRESH_PKG" VARCHAR2(240), 
	"LAST_REFRESH_TIME" TIMESTAMP (6), 
	"SCHEDULE_STATUS" VARCHAR2(30), 
	"ERROR_MESSAGE" VARCHAR2(2000), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(60)
   )