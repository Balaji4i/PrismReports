--------------------------------------------------------
--  DDL for Table XXSTG_VENDOR
--------------------------------------------------------

  CREATE TABLE "XXSTG_VENDOR" 
   (	"VEND_ID" NUMBER, 
	"VENDOR_NUMBER" VARCHAR2(30), 
	"VENDOR_NAME" VARCHAR2(240), 
	"VENDOR_NAME_TL" VARCHAR2(240), 
	"ORIG_SYSTEM_REF" NUMBER, 
	"PROFESSION" VARCHAR2(240), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
