--------------------------------------------------------
--  DDL for Table XXPM_RECEIPT_BKP21_OCT
--------------------------------------------------------

  CREATE TABLE "XXPM_RECEIPT_BKP21_OCT" 
   (	"RECEIPT_ID" NUMBER, 
	"FUNC_ID" NUMBER, 
	"SOURCE_FUNC_ID" NUMBER, 
	"SOURCE_FUNC_REF_ID" NUMBER, 
	"RECEIPT_NUMBER" VARCHAR2(30), 
	"RECEIPT_DATE" DATE, 
	"ORG_ID" NUMBER, 
	"RECEIPT_TYPE" VARCHAR2(30), 
	"PROPERTY_ID" NUMBER, 
	"UNIT_ID" NUMBER, 
	"BUILD_ID" NUMBER, 
	"LEAD_ID" NUMBER, 
	"CUST_ID" NUMBER, 
	"CUST_SITE_ID" NUMBER, 
	"SALESMAN_ID" NUMBER, 
	"CUSTOMER_NAME" VARCHAR2(240), 
	"CURRENCY_CODE" VARCHAR2(3), 
	"RECEIPT_AMOUNT" NUMBER, 
	"PAY_MODE" NUMBER, 
	"PAY_REF_NUMBER" VARCHAR2(30), 
	"PAY_REF_DATE" DATE, 
	"BANK_NAME" VARCHAR2(60), 
	"BANK_BRANCH_NAME" VARCHAR2(60), 
	"DRAWN_BY" VARCHAR2(60), 
	"STATUS" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(4000), 
	"FLOW_STATUS" VARCHAR2(60), 
	"FLOW_LEVEL" NUMBER, 
	"FLOW_WITH" NUMBER, 
	"TAX_AMOUNT" NUMBER, 
	"TAX_CODE" VARCHAR2(60), 
	"TAX_RATE" NUMBER, 
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
	"ATTRIBUTE11" VARCHAR2(240), 
	"ATTRIBUTE12" VARCHAR2(240), 
	"ATTRIBUTE13" VARCHAR2(240), 
	"ATTRIBUTE14" VARCHAR2(240), 
	"ATTRIBUTE15" VARCHAR2(240), 
	"ATTRIBUTE16" VARCHAR2(240), 
	"ATTRIBUTE17" VARCHAR2(240), 
	"ATTRIBUTE18" VARCHAR2(240), 
	"ATTRIBUTE19" VARCHAR2(240), 
	"ATTRIBUTE20" VARCHAR2(240), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"RECOMMENDED_AMOUNT" NUMBER, 
	"RECEIVED_AMOUNT" NUMBER, 
	"DIFF_IN_DAYS" NUMBER, 
	"PAY_REC_DATE" DATE, 
	"PAY_REV_DATE" DATE, 
	"RCT_TYPE" VARCHAR2(30), 
	"RCT_DESC" VARCHAR2(150), 
	"INTERFACE_STATUS" VARCHAR2(60), 
	"GL_DATE" DATE, 
	"REV_DATE" DATE, 
	"REV_GL_DATE" DATE, 
	"REV_CATEGORY" VARCHAR2(60), 
	"REV_REASON" VARCHAR2(60), 
	"REV_DESC" VARCHAR2(4000), 
	"REV_INT_STATUS" VARCHAR2(60), 
	"RECEIPT_RISK_YN" VARCHAR2(1), 
	"INTERFACE_ERROR_MSG" CLOB, 
	"BANK_ACCOUNT_NUM" VARCHAR2(60), 
	"MODE_OF_RECEIPT" VARCHAR2(80), 
	"REMIT_BANK_ACCT_USE_ID" NUMBER
   )
