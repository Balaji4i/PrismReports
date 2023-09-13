--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_EVENTS
--------------------------------------------------------

  CREATE TABLE "XXPM_BOOKING_EVENTS" 
   (	"BOOKING_EVENT_ID" NUMBER, 
	"BOOKING_HDR_ID" NUMBER, 
	"EVENT_TYPE" VARCHAR2(30), 
	"EVENT_DATE" DATE, 
	"EVENT_UPDATED_ON" DATE, 
	"EVENT_EXE_BY" NUMBER, 
	"EVENT_REF_NUMBER" VARCHAR2(60), 
	"ACTIVE_YN" VARCHAR2(1), 
	"DESCRIPTION" VARCHAR2(240), 
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