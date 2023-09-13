--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_FEATURES
--------------------------------------------------------

  CREATE TABLE "XXDM_PROPERTY_FEATURES" 
   (	"FEATURE_ID" VARCHAR2(60), 
	"PROPERTY_NUMBER" VARCHAR2(60), 
	"BUILD_NUMBER" VARCHAR2(60), 
	"UNIT_NUMBER" VARCHAR2(60), 
	"FEATURE_TYPE" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
	"FEATURE_CONDITION" VARCHAR2(60), 
	"UOM" VARCHAR2(60), 
	"VALUE" VARCHAR2(20), 
	"QUANTITY" VARCHAR2(20), 
	"RATE" VARCHAR2(20), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"BATCH_ID" NUMBER, 
	"INTERFACE_STATUS_FLAG" VARCHAR2(1), 
	"INTERFACE_ID" NUMBER, 
	"ERR_MSG" VARCHAR2(2000), 
	"ERR_DESCRIPTION" VARCHAR2(2000), 
	"VALIDATED_BY" VARCHAR2(60), 
	"VALIDATED_DATE" TIMESTAMP (6), 
	"PROCESSED_BY" VARCHAR2(60), 
	"PROCESSED_DATE" TIMESTAMP (6), 
	"BUILD_ID" VARCHAR2(40), 
	"PROPERTY_ID" VARCHAR2(40), 
	"UNIT_ID" VARCHAR2(40), 
	"F_ID" NUMBER
   )
