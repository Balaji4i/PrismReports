--------------------------------------------------------
--  DDL for Table XXPM_SALES_RECEIPTS_TSQ2
--------------------------------------------------------

  CREATE TABLE "XXPM_SALES_RECEIPTS_TSQ2" 
   (	"RECEIPT_NUMBER" VARCHAR2(250), 
	"INVOICE_NUMBER" VARCHAR2(250), 
	"RECEIPT_DATE" DATE, 
	"BUSINESS_UNIT" VARCHAR2(250), 
	"RECEIPT_TYPE" VARCHAR2(250), 
	"PROPERTY" VARCHAR2(250), 
	"UNIT" VARCHAR2(250), 
	"BUILDING" VARCHAR2(250), 
	"CUSTOMER" VARCHAR2(250), 
	"CUSTOMER_BILL_TO_SITE" VARCHAR2(250), 
	"CURRENCY" VARCHAR2(250), 
	"RECEIPT_AMOUNT" VARCHAR2(250), 
	"PAYMENT_MODE" VARCHAR2(250), 
	"PAYMENT_REFERNCE_NUMBER" VARCHAR2(250), 
	"PYAMENT_REFERNCE_DATE" DATE, 
	"BANK_NAME" VARCHAR2(250), 
	"BANK_BRANCH_NAME" VARCHAR2(250), 
	"STATUS" VARCHAR2(250), 
	"DESCRIPTION" VARCHAR2(250), 
	"TAX_AMOUNT" VARCHAR2(250), 
	"TAX" VARCHAR2(250), 
	"TAX_RATE" VARCHAR2(250), 
	"GL_DATE" DATE, 
	"PAYMENT_MILESTONE" VARCHAR2(250), 
	"AMOUNT_APPLIED" VARCHAR2(250), 
	"APPLIED_DATE" DATE, 
	"BOOKING_NUMBER" VARCHAR2(250), 
	"SPA_NUMBER" VARCHAR2(250), 
	"STATUS_FLAG" VARCHAR2(10), 
	"ORG_ID" NUMBER, 
	"PROPERTY_ID" NUMBER, 
	"BUILD_ID" NUMBER, 
	"UNIT_ID" NUMBER, 
	"CUST_ID" NUMBER, 
	"CUST_SITE_ID" NUMBER, 
	"ERR_DESC" VARCHAR2(500), 
	"INVOICE_ID" NUMBER, 
	"RECEIPT_TYPE_NAME" VARCHAR2(250), 
	"PAY_MODE_ID" NUMBER, 
	"BANK_ACCOUNT_NUM" VARCHAR2(60)
   )
