--------------------------------------------------------
--  DDL for Table XXPM_REVISION_LINE
--------------------------------------------------------

  CREATE TABLE "XXPM_REVISION_LINE" 
   (	"PL_REV_LINE_ID" NUMBER, 
	"PL_REVISON_ID" NUMBER, 
	"UNIT_TYPE" VARCHAR2(60), 
	"REV_BASE_CHARGE" NUMBER, 
	"REV_MIN_CHARGE" NUMBER, 
	"REV_SECURITYDEPOSIT_CHARGE" NUMBER, 
	"REV_MUNICIPALITY_CHARGE" NUMBER, 
	"REV_ELECTRICITY_CHARGE" NUMBER, 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"THIRD_PARTY_SERV_CHARGE" NUMBER, 
	"OTHER_GOVNT_CHARGE_NEW" NUMBER, 
	"OTHER_GOVNT_CHARGE_RNEW" NUMBER, 
	"EJARI_PAYMENT_CHARGE" NUMBER
   )
