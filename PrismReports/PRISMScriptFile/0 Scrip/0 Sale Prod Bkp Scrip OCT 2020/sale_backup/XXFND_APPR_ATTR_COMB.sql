--------------------------------------------------------
--  DDL for Table XXFND_APPR_ATTR_COMB
--------------------------------------------------------

  CREATE TABLE "XXFND_APPR_ATTR_COMB" 
   (	"ATTR_COMB_ID" NUMBER, 
	"ATTR_GRP_ID" NUMBER, 
	"ATTRIBUTE1" VARCHAR2(60), 
	"ATTRIBUTE2" VARCHAR2(60), 
	"ATTRIBUTE3" VARCHAR2(60), 
	"ATTRIBUTE4" VARCHAR2(60), 
	"ATTRIBUTE5" VARCHAR2(60), 
	"USER_GRP_ID" NUMBER, 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"AMOUNT_FROM" NUMBER, 
	"AMOUNT_TO" NUMBER
   )