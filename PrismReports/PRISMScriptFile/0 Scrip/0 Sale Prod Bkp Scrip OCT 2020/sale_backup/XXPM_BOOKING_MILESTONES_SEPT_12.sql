--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_MILESTONES_SEPT_12
--------------------------------------------------------

  CREATE TABLE "XXPM_BOOKING_MILESTONES_SEPT_12" 
   (	"BOOKING_MS_DTL_ID" NUMBER, 
	"MILESTONE_TYPE" VARCHAR2(60), 
	"MS_DTL_ID" NUMBER, 
	"PL_MOD_ID" NUMBER, 
	"SEQ_NUMBER" NUMBER, 
	"INSTALLMENT_TYPE" VARCHAR2(60), 
	"INSTALLMENT_PCT" NUMBER, 
	"INSTALLMENT_AMOUNT" NUMBER, 
	"UOM" VARCHAR2(30), 
	"QUANTITY" NUMBER, 
	"RATE" NUMBER, 
	"WAVE_OFF" VARCHAR2(30), 
	"INCLUDED_IN_RATE" VARCHAR2(30), 
	"INSTALLMENT_METHOD" VARCHAR2(30), 
	"INSTALLMENT_EVENT" VARCHAR2(240), 
	"PERIOD_OCCURENCE" VARCHAR2(30), 
	"PERIOD_VALUES" NUMBER, 
	"PERIOD_DURATION" VARCHAR2(30), 
	"CHARGE_TYPE" VARCHAR2(60), 
	"PAYMENT_TERM" VARCHAR2(60), 
	"REMARKS" VARCHAR2(4000), 
	"DUE_DAYS" NUMBER, 
	"DUE_DAYS_FROM" VARCHAR2(60), 
	"DUE_DATE" DATE, 
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
	"SOURCE_FUNC_ID" NUMBER, 
	"SOURCE_FUNC_REF_ID" NUMBER, 
	"BILLING_ID" NUMBER, 
	"STATUS" VARCHAR2(60), 
	"INVOICE_ID" NUMBER, 
	"BOOKING_HDR_ID" NUMBER, 
	"BASEAMOUNT" NUMBER, 
	"TAX_RATE" NUMBER, 
	"TAX_CODE" VARCHAR2(60), 
	"TAX_AMOUNT" NUMBER, 
	"CARPARKING" VARCHAR2(200), 
	"INVOICE_NUMBER" VARCHAR2(240)
   )
