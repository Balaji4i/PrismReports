--------------------------------------------------------
--  DDL for Table XXPM_INVOICE_LINES_BCK_3108
--------------------------------------------------------

  CREATE TABLE "XXPM_INVOICE_LINES_BCK_3108" 
   (	"INVOICE_ID" NUMBER, 
	"INVOICE_LINE_ID" NUMBER, 
	"LINE_NUMBER" NUMBER, 
	"DESCRIPTION" VARCHAR2(240), 
	"UOM_CODE" VARCHAR2(240), 
	"QUANTITY" NUMBER, 
	"PRICE" NUMBER, 
	"AMOUNT" NUMBER, 
	"TAX_CODE" VARCHAR2(60), 
	"TAX_PERC" NUMBER, 
	"TAX_AMOUNT" NUMBER, 
	"CHARGE_TYPE" VARCHAR2(60), 
	"REV_ACNT_ID" NUMBER, 
	"REV_ACNT_CODE" VARCHAR2(240), 
	"OFFER_DTL_ID" NUMBER, 
	"BOOKING_DTL_ID" NUMBER, 
	"PROPERTY_ID" NUMBER, 
	"PROPERTY_NUMBER" VARCHAR2(60), 
	"BUILD_ID" NUMBER, 
	"BUILD_NUMBER" VARCHAR2(60), 
	"UNIT_ID" NUMBER, 
	"UNIT_NUMBER" VARCHAR2(60), 
	"BILLING_MS_ID" NUMBER, 
	"INSTALLMENT_TYPE" VARCHAR2(60), 
	"CUSTOMER_TRX_LINE_ID" NUMBER, 
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
	"LINE_AMOUNT" NUMBER, 
	"LINE_TYPE" VARCHAR2(30)
   )
