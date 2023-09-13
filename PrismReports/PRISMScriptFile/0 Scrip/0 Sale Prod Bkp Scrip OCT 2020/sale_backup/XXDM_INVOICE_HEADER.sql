--------------------------------------------------------
--  DDL for Table XXDM_INVOICE_HEADER
--------------------------------------------------------

  CREATE TABLE "XXDM_INVOICE_HEADER" 
   (	"INVOICE_ID" NUMBER, 
	"INVOICE_NUMBER" VARCHAR2(60), 
	"INVOICE_DATE" DATE, 
	"FUNC_ID" NUMBER, 
	"INVOICE_CLASS" VARCHAR2(60), 
	"ORG_ID" NUMBER, 
	"TRX_SOURCE" VARCHAR2(250), 
	"TRX_TYPE" VARCHAR2(250), 
	"CURRENCY_CODE" VARCHAR2(3), 
	"EXCHANGE_RATE" NUMBER, 
	"CUST_ID" NUMBER, 
	"CUST_SITE_ID" NUMBER, 
	"DUE_DATE" DATE, 
	"STATUS" VARCHAR2(60), 
	"INTERFACE_STATUS" VARCHAR2(60), 
	"OFFER_ID" NUMBER, 
	"OFFER_NUMBER" VARCHAR2(60), 
	"BOOKING_ID" NUMBER, 
	"BOOKING_NUMBER" VARCHAR2(60), 
	"SALE_LEASE_NUMBER" VARCHAR2(60), 
	"CUSTOMER_TRX_ID" NUMBER, 
	"CUSTOMER_TRX_NUMBER" VARCHAR2(60), 
	"INVOICING_RULE" VARCHAR2(60), 
	"ACNT_RULE" VARCHAR2(60), 
	"RULE_START_DATE" DATE, 
	"RULE_END_DATE" DATE, 
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
	"CREATED_BY" VARCHAR2(240), 
	"CREATED_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(240), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(240), 
	"INTERFACE_ERROR_MSG" CLOB, 
	"PAYMENT_TERMS" NUMBER
   )
