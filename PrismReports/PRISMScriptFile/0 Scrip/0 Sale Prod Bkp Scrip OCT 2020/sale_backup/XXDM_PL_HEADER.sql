--------------------------------------------------------
--  DDL for Table XXDM_PL_HEADER
--------------------------------------------------------

  CREATE TABLE "XXDM_PL_HEADER" 
   (	"PL_ID" VARCHAR2(20), 
	"PL_NAME" VARCHAR2(240), 
	"PL_NAME_TL" VARCHAR2(240), 
	"PL_NUMBER" VARCHAR2(240), 
	"ORG_ID" VARCHAR2(20), 
	"DESCRIPTION" VARCHAR2(4000), 
	"PL_TYPE" VARCHAR2(240), 
	"PRIORITY" VARCHAR2(240), 
	"USAGE" VARCHAR2(4000), 
	"CURRENCY_CODE" VARCHAR2(240), 
	"START_DATE" VARCHAR2(100), 
	"END_DATE" VARCHAR2(100), 
	"REVISION_NO" VARCHAR2(100), 
	"REVISION_DATE" VARCHAR2(100), 
	"REVISED_BY" VARCHAR2(100), 
	"STATUS" VARCHAR2(100), 
	"FLOW_STATUS" VARCHAR2(100), 
	"FLOW_WITH" VARCHAR2(100), 
	"FLOW_LEVEL" VARCHAR2(100), 
	"USER_GRP_ID" VARCHAR2(100), 
	"BASE_PRICE_YN" VARCHAR2(100), 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" VARCHAR2(111), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" VARCHAR2(111), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"BATCH_ID" NUMBER, 
	"INTERFACE_STATUS_FLAG" VARCHAR2(1), 
	"INTERFACE_ID" NUMBER, 
	"ERR_MSG" VARCHAR2(2000), 
	"ERR_DESCRIPTION" VARCHAR2(2000), 
	"OLD_STATUS" VARCHAR2(100)
   )
