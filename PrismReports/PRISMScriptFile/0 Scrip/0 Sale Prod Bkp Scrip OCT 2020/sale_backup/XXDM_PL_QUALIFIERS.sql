--------------------------------------------------------
--  DDL for Table XXDM_PL_QUALIFIERS
--------------------------------------------------------

  CREATE TABLE "XXDM_PL_QUALIFIERS" 
   (	"PL_QLFY_ID" VARCHAR2(200), 
	"PL_MOD_ID" VARCHAR2(200), 
	"QLFY_ID" VARCHAR2(200), 
	"START_DATE" VARCHAR2(200), 
	"END_DATE" VARCHAR2(200), 
	"REVISION_NO" VARCHAR2(200), 
	"REVISION_DATE" VARCHAR2(200), 
	"REVISED_BY" VARCHAR2(200), 
	"ACTIVE_YN" VARCHAR2(2), 
	"CREATED_BY" VARCHAR2(200), 
	"CREATION_DATE" VARCHAR2(200), 
	"LAST_UPDATED_BY" VARCHAR2(200), 
	"LAST_UPDATE_DATE" VARCHAR2(200), 
	"LAST_UPDATE_LOGIN" VARCHAR2(200), 
	"BATCH_ID" NUMBER, 
	"INTERFACE_STATUS_FLAG" VARCHAR2(1), 
	"INTERFACE_ID" NUMBER, 
	"ERR_MSG" VARCHAR2(2000), 
	"ERR_DESCRIPTION" VARCHAR2(2000), 
	"VALIDATED_BY" VARCHAR2(60), 
	"VALIDATED_DATE" TIMESTAMP (6), 
	"PROCESSED_BY" VARCHAR2(60), 
	"PROCESSED_DATE" TIMESTAMP (6), 
	"PL_MOD_NUMBER" VARCHAR2(50), 
	"HISTORY_INSERT" VARCHAR2(20)
   )
