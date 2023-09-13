--------------------------------------------------------
--  DDL for Table XXSTG_RECEIPT_OLD
--------------------------------------------------------

  CREATE TABLE "XXSTG_RECEIPT_OLD" 
   (	"S_NO" NUMBER, 
	"RECEIPT_REF_TYPE" VARCHAR2(60), 
	"RECEIPT_REF_NUM" VARCHAR2(60), 
	"SOURCE_FUNC_REF_ID" NUMBER, 
	"INVOICE_NUM" VARCHAR2(60), 
	"RECEIPT_ID" NUMBER, 
	"RECEIPT_NUMBER" VARCHAR2(60), 
	"RECEIPT_DATE" DATE, 
	"CUSTOMER_NAME" VARCHAR2(240), 
	"CURRENCY_CODE" VARCHAR2(3), 
	"RECEIPT_AMOUNT" NUMBER, 
	"PAY_REC_DATE" DATE, 
	"DIFF_IN_DAYS" NUMBER, 
	"BANK_NAME" VARCHAR2(60), 
	"BANK_BRANCH_NAME" VARCHAR2(60), 
	"DRAWN_BY" VARCHAR2(60), 
	"PAY_MODE" VARCHAR2(30), 
	"PAY_MODE_CODE" VARCHAR2(30), 
	"RCT_TYPE" VARCHAR2(30), 
	"RCT_TYPE_CODE" VARCHAR2(30), 
	"PAY_REF_NUMBER" VARCHAR2(30), 
	"PAY_REF_DATE" DATE, 
	"DESCRIPTION" VARCHAR2(4000), 
	"TAX_AMOUNT" NUMBER, 
	"TAX_CODE" VARCHAR2(60), 
	"TAX_RATE" NUMBER, 
	"RECOMMENDED_AMOUNT" NUMBER, 
	"RECEIVED_AMOUNT" NUMBER, 
	"RECEIPT_DTL_ID" NUMBER, 
	"BOOKING_TYPE" VARCHAR2(100), 
	"BOOKING_MS_DTL_ID" NUMBER, 
	"AMOUNT_APPLIED" NUMBER, 
	"APPLIED_DATE" DATE, 
	"CUSTOMER_TRX" VARCHAR2(240), 
	"CUSTOMER_TRX_ID" NUMBER, 
	"RECEIVABLE_APPLICATION" VARCHAR2(100), 
	"RECEIVABLE_APPLICATION_ID" NUMBER, 
	"STATUS" VARCHAR2(30), 
	"ERROR_MSG" VARCHAR2(4000)
   )