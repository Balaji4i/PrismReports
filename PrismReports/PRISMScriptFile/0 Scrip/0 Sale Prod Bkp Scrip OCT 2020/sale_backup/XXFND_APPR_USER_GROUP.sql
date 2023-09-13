--------------------------------------------------------
--  DDL for Table XXFND_APPR_USER_GROUP
--------------------------------------------------------

  CREATE TABLE "XXFND_APPR_USER_GROUP" 
   (	"USER_GRP_ID" NUMBER, 
	"USER_GRP_NAME" VARCHAR2(30), 
	"DESCRIPTION" VARCHAR2(240), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
