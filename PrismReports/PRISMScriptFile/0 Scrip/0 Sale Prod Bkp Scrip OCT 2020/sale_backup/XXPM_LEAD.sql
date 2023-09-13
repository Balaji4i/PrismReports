--------------------------------------------------------
--  DDL for Table XXPM_LEAD
--------------------------------------------------------

  CREATE TABLE "XXPM_LEAD" 
   (	"LEAD_ID" NUMBER, 
	"ORG_ID" NUMBER, 
	"FUNC_ID" NUMBER, 
	"LEAD_NUMBER" VARCHAR2(60), 
	"VISITTED_DATE" DATE, 
	"TITLE" VARCHAR2(30), 
	"FIRST_NAME" VARCHAR2(240), 
	"LAST_NAME" VARCHAR2(240), 
	"LEAD_NAME" VARCHAR2(150), 
	"STATUS" VARCHAR2(60), 
	"AGENT" VARCHAR2(1), 
	"PRIMARY_SOURCE" VARCHAR2(60), 
	"SEC_SOURCE" VARCHAR2(240), 
	"EMAIL_ID" VARCHAR2(60), 
	"MOBILE_NUMBER" VARCHAR2(60), 
	"PHONE_NUMBER" VARCHAR2(60), 
	"FAX" VARCHAR2(60), 
	"CUR_ADDRESS1" VARCHAR2(240), 
	"CUR_ADDRESS2" VARCHAR2(240), 
	"CUR_ADDRESS3" VARCHAR2(240), 
	"CUR_ADDRESS4" VARCHAR2(240), 
	"CUR_CITY" VARCHAR2(240), 
	"CUR_POSTAL_CODE" VARCHAR2(240), 
	"CUR_PROVINCE" VARCHAR2(240), 
	"CUR_COUNTY" VARCHAR2(240), 
	"CUR_COUNTRY" VARCHAR2(240), 
	"PER_ADDRESS1" VARCHAR2(240), 
	"PER_ADDRESS2" VARCHAR2(240), 
	"PER_ADDRESS3" VARCHAR2(240), 
	"PER_ADDRESS4" VARCHAR2(240), 
	"PER_CITY" VARCHAR2(240), 
	"PER_POSTAL_CODE" VARCHAR2(240), 
	"PER_PROVINCE" VARCHAR2(240), 
	"PER_COUNTY" VARCHAR2(240), 
	"PER_COUNTRY" VARCHAR2(240), 
	"DESCRIPTION" VARCHAR2(240), 
	"NATIONALITY" VARCHAR2(60), 
	"PASSPORT_NUMBER" VARCHAR2(60), 
	"PASSPORT_EXP_DATE" DATE, 
	"COUNTRY_OF_RES" VARCHAR2(60), 
	"RESIDENT_ID" VARCHAR2(60), 
	"RESIDENT_ID_EXP_DATE" DATE, 
	"ATTRIBUTE_CATEGORY" VARCHAR2(240), 
	"ATTRIBUTE1" VARCHAR2(240), 
	"ATTRIBUTE2" VARCHAR2(240), 
	"ATTRIBUTE3" VARCHAR2(240), 
	"ATTRIBUTE4" VARCHAR2(240), 
	"ATTRIBUTE5" VARCHAR2(240), 
	"ATTRIBUTE6" VARCHAR2(240), 
	"ATTRIBUTE7" VARCHAR2(240), 
	"ATTRIBUTE8" VARCHAR2(240), 
	"ATTRIBUTE9" VARCHAR2(240), 
	"ATTRIBUTE10" VARCHAR2(240), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"ACTIVE_RP" VARCHAR2(1), 
	"PROFESSIONAL" VARCHAR2(240), 
	"EMIRATES_ID_REF_1" NUMBER, 
	"EMIRATES_ID_REF_2" NUMBER, 
	"EMIRATES_ID_REF_3" NUMBER, 
	"EMIRATES_ID_REF_4" NUMBER, 
	"TRADE_LINCENSE_NAME" VARCHAR2(240), 
	"TRADE_LINCENSE_NO" NUMBER, 
	"TRADE_LINCENSE_NAME_VALIDITY" DATE, 
	"TRADE_LINCENSE_NO_VALIDITY" DATE, 
	"TRN" NUMBER, 
	"ISSUER_EMIRATES" VARCHAR2(240), 
	"OWNER_DETAILS" VARCHAR2(240), 
	"POA" VARCHAR2(240), 
	"NUMB" NUMBER, 
	"NAME_AND_DETAIL" VARCHAR2(240)
   )
