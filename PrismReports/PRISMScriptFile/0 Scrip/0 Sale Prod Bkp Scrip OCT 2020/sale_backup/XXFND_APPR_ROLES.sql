--------------------------------------------------------
--  DDL for Table XXFND_APPR_ROLES
--------------------------------------------------------

  CREATE TABLE "XXFND_APPR_ROLES" 
   (	"ROLE_ID" NUMBER, 
	"ROLE_NAME" VARCHAR2(30), 
	"DESCRIPTION" VARCHAR2(240), 
	"ROLE_TYPE" VARCHAR2(30), 
	"ROLE_VALUE" VARCHAR2(4000), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )