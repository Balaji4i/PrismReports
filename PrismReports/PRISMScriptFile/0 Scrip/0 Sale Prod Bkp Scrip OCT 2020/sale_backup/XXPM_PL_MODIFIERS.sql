--------------------------------------------------------
--  DDL for Table XXPM_PL_MODIFIERS
--------------------------------------------------------

  CREATE TABLE "XXPM_PL_MODIFIERS" 
   (	"PL_MOD_ID" NUMBER, 
	"PL_ID" NUMBER, 
	"MOD_ID" NUMBER, 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"REVISION_NO" NUMBER, 
	"REVISION_DATE" DATE, 
	"REVISED_BY" VARCHAR2(60), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
