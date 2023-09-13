--------------------------------------------------------
--  DDL for Table XXPM_UNIT_TRANSFER_DETAILS
--------------------------------------------------------

  CREATE TABLE "XXPM_UNIT_TRANSFER_DETAILS" 
   (	"UNIT_TRANSFER_ID" NUMBER, 
	"CANCEL_ID" NUMBER, 
	"BOOKING_HDR_ID" NUMBER, 
	"UNIT_TRANSFER_DATE" DATE, 
	"FROM_CUSTOMER" NUMBER, 
	"FROM_CUSTOMER_BILL_TO" NUMBER, 
	"FROM_CUSTOMER_CONTACTS" NUMBER, 
	"TO_CUSTOMER" NUMBER, 
	"TO_CUSTOMER_BILL_TO" NUMBER, 
	"TO_CUSTOMER_CONTACTS" NUMBER, 
	"UNIT_TRANSFER_STATUS" VARCHAR2(1), 
	"DESCRIPTION" VARCHAR2(240), 
	"USER_GRP_ID" NUMBER, 
	"FLOW_STATUS" VARCHAR2(60), 
	"FLOW_LEVEL" NUMBER, 
	"FLOW_WITH" NUMBER, 
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
	"LAST_UPDATE_LOGIN" VARCHAR2(150)
   )