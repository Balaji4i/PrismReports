--------------------------------------------------------
--  DDL for Table XXFND_SCHEDULE_T
--------------------------------------------------------

  CREATE TABLE "XXFND_SCHEDULE_T" 
   (	"SCHEDULE_ID" NUMBER, 
	"SCHEDULE_NAME" VARCHAR2(240), 
	"FREQUENCY_MIN" NUMBER, 
	"PROGRAM_NAME" VARCHAR2(240), 
	"BI_REPORT_PATH" VARCHAR2(240), 
	"BI_REPORT_NAME" VARCHAR2(240), 
	"DB_REFRESH_PKG" VARCHAR2(240), 
	"APPLICATION_NAME" VARCHAR2(240), 
	"NEXT_SCHEDULE_TIME" TIMESTAMP (6), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(60), 
	"RUN_STATUS" VARCHAR2(30), 
	"STATUS" VARCHAR2(30), 
	"RECORDS_FROM_DATE" TIMESTAMP (6), 
	"LAST_SCHEDULE_TIME" TIMESTAMP (6), 
	"DB_TABLE_NAME" VARCHAR2(250), 
	"DB_COLUMN_NAMES" VARCHAR2(4000)
   )
