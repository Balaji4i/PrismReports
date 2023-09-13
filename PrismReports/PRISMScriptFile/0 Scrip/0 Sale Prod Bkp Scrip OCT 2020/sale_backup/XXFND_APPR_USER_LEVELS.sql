--------------------------------------------------------
--  DDL for Table XXFND_APPR_USER_LEVELS
--------------------------------------------------------

  CREATE TABLE "XXFND_APPR_USER_LEVELS" 
   (	"USER_LEVEL_ID" NUMBER, 
	"USER_GRP_ID" NUMBER, 
	"LEVEL_NO" NUMBER, 
	"LEVEL_NAME" VARCHAR2(60), 
	"LEVEL_TYPE" VARCHAR2(1), 
	"APPR_BY_ALL" VARCHAR2(1), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
