--------------------------------------------------------
--  DDL for Table XXFND_FLEXS_CATEGORY
--------------------------------------------------------

  CREATE TABLE "XXFND_FLEXS_CATEGORY" 
   (	"FLEX_CATG_ID" NUMBER, 
	"FLEX_ID" NUMBER, 
	"CATG_CODE" VARCHAR2(30), 
	"CATG_NAME" VARCHAR2(60), 
	"GLOBAL_YN" VARCHAR2(1), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )