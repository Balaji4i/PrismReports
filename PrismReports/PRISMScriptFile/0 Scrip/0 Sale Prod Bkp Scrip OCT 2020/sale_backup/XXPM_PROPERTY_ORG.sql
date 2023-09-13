--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_ORG
--------------------------------------------------------

  CREATE TABLE "XXPM_PROPERTY_ORG" 
   (	"PROP_ORG_ID" NUMBER, 
	"PROPERTY_ID" NUMBER, 
	"UNIT_ID" NUMBER, 
	"ORG_ID" NUMBER, 
	"ACTIVE_YN" VARCHAR2(1), 
	"INACTIVE_ON" DATE, 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
