--------------------------------------------------------
--  DDL for Table XXPM_MOVE_IO_METERS
--------------------------------------------------------

  CREATE TABLE "XXPM_MOVE_IO_METERS" 
   (	"METER_ID" NUMBER, 
	"LEASE_AGREEMENT_ID" NUMBER, 
	"BOOKING_ID" NUMBER, 
	"MOVE_IO_ID" NUMBER, 
	"METER_CODE" VARCHAR2(60), 
	"METER_VALUE" NUMBER, 
	"DESCRIPTION" VARCHAR2(240), 
	"STATUS" VARCHAR2(60), 
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
	"ASSISTED_BY" NUMBER
   )