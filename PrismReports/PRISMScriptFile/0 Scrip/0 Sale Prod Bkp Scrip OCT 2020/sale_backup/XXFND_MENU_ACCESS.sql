--------------------------------------------------------
--  DDL for Table XXFND_MENU_ACCESS
--------------------------------------------------------

  CREATE TABLE "XXFND_MENU_ACCESS" 
   (	"MENU_ACCESS_ID" NUMBER, 
	"USER_ROLE_ID" NUMBER, 
	"SUB_MENU_ID" NUMBER, 
	"MENU_DISPLAY" VARCHAR2(1), 
	"MENU_CONTROL" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )
