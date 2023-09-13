--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_UNITS
--------------------------------------------------------

  CREATE TABLE "XXDM_PROPERTY_UNITS" 
   (	"PROPERTY_NUMBER" VARCHAR2(60), 
	"BUILD_NUMBER" VARCHAR2(60), 
	"UNIT_NUMBER" VARCHAR2(60), 
	"UNIT_NAME" VARCHAR2(240), 
	"UNIT_NAME_TL" VARCHAR2(240), 
	"UNIT_SHORTCODE" VARCHAR2(60), 
	"FUNC_ID" NUMBER, 
	"DOC_REF_NUMBER_1" VARCHAR2(60), 
	"DOC_REF_NUMBER_2" VARCHAR2(60), 
	"DOC_REF_NUMBER_3" VARCHAR2(60), 
	"FLOOR_NUMBER" VARCHAR2(60), 
	"NO_OF_ROOMS" VARCHAR2(20), 
	"UNIT_TYPE" VARCHAR2(60), 
	"STATUS" VARCHAR2(60), 
	"UNIT_CLASS" VARCHAR2(60), 
	"UNIT_CATEGORY" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"SALEABLE_YN" VARCHAR2(1), 
	"LEASEABLE_YN" VARCHAR2(1), 
	"SALE_AVAILABLE_YN" VARCHAR2(1), 
	"LEASE_AVAILABLE_YN" VARCHAR2(1), 
	"FREE_HOLD_YN" VARCHAR2(1), 
	"LEASE_HOLD_YN" VARCHAR2(1), 
	"LIST_FOR_BROKERS" VARCHAR2(1), 
	"LIST_FOR_INTERNAL" VARCHAR2(1), 
	"ALLOT_TYPE" VARCHAR2(30), 
	"BATCH_ID" NUMBER, 
	"INTERFACE_STATUS_FLAG" VARCHAR2(1), 
	"INTERFACE_ID" NUMBER, 
	"ERR_MSG" VARCHAR2(2000), 
	"ERR_DESCRIPTION" VARCHAR2(2000), 
	"VALIDATED_BY" VARCHAR2(60), 
	"VALIDATED_DATE" TIMESTAMP (6), 
	"PROCESSED_BY" VARCHAR2(60), 
	"PROCESSED_DATE" TIMESTAMP (6), 
	"AREA_TYPE" VARCHAR2(400), 
	"VIEW_TYPE" VARCHAR2(400), 
	"UOM" VARCHAR2(400), 
	"VEND_ID" VARCHAR2(400), 
	"ACTIVE_YN" VARCHAR2(4), 
	"PROPERTY_ID" NUMBER, 
	"BUILD_ID" NUMBER, 
	"UNIT_ID" NUMBER, 
	"CP_UNIT_ID" NUMBER
   )