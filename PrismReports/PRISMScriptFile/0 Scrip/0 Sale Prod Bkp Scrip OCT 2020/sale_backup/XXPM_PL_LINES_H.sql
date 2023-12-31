--------------------------------------------------------
--  DDL for Table XXPM_PL_LINES_H
--------------------------------------------------------

  CREATE TABLE "XXPM_PL_LINES_H" 
   (	"PLL_ID_H" NUMBER, 
	"PLL_ID" NUMBER, 
	"PL_ID" NUMBER, 
	"PROPERTY_ID" NUMBER, 
	"BUILD_ID" NUMBER, 
	"UNIT_ID" NUMBER, 
	"UOM" VARCHAR2(5), 
	"BASE_PRICE" NUMBER, 
	"MIN_PRICE" NUMBER, 
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
