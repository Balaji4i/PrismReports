--------------------------------------------------------
--  DDL for Table XXSTG_BANK_ACCOUNTS
--------------------------------------------------------

  CREATE TABLE "XXSTG_BANK_ACCOUNTS" 
   (	"BANK_ACNT_ID" NUMBER, 
	"BANK_NAME" VARCHAR2(240), 
	"BANK_NAME_TL" VARCHAR2(240), 
	"BANK_NUMBER" VARCHAR2(30), 
	"BRANCH_NAME" VARCHAR2(240), 
	"BRANCH_NAME_TL" VARCHAR2(240), 
	"BRANCH_NUMBER" VARCHAR2(30), 
	"ADDRESS1" VARCHAR2(240), 
	"ADDRESS1_TL" VARCHAR2(240), 
	"ADDRESS2" VARCHAR2(240), 
	"ADDRESS2_TL" VARCHAR2(240), 
	"ADDRESS3" VARCHAR2(240), 
	"ADDRESS3_TL" VARCHAR2(240), 
	"ADDRESS4" VARCHAR2(240), 
	"ADDRESS4_TL" VARCHAR2(240), 
	"CITY" VARCHAR2(60), 
	"CITY_TL" VARCHAR2(60), 
	"POSTAL_CODE" VARCHAR2(60), 
	"STATE" VARCHAR2(60), 
	"STATE_TL" VARCHAR2(60), 
	"PROVINCE" VARCHAR2(60), 
	"PROVINCE_TL" VARCHAR2(60), 
	"COUNTY" VARCHAR2(60), 
	"COUNTY_TL" VARCHAR2(60), 
	"COUNTRY" VARCHAR2(60), 
	"COUNTRY_TL" VARCHAR2(60), 
	"SWIFT_CODE" VARCHAR2(60), 
	"IBAN" VARCHAR2(60), 
	"BANK_ACCOUNT_NUM" VARCHAR2(60), 
	"BANK_ACCOUNT_TYPE" VARCHAR2(60), 
	"CURRENCY_CODE" VARCHAR2(30), 
	"ORIG_BANK_REF" NUMBER, 
	"ORIG_BRANCH_REF" NUMBER, 
	"ORIG_ACCOUNT_REF" NUMBER, 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"BANK_ACCOUNT_NAME" VARCHAR2(60)
   )