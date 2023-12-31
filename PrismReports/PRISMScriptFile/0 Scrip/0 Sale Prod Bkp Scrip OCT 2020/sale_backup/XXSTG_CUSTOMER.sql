--------------------------------------------------------
--  DDL for Table XXSTG_CUSTOMER
--------------------------------------------------------

  CREATE TABLE "XXSTG_CUSTOMER" 
   (	"CUST_ID" NUMBER, 
	"CUSTOMER_NUMBER" VARCHAR2(30), 
	"CUSTOMER_NAME" VARCHAR2(240), 
	"CUSTOMER_NAME_TL" VARCHAR2(240), 
	"SALES_PERSON_ID" NUMBER, 
	"LEAD_ID" NUMBER, 
	"ORIG_SYSTEM_REF" NUMBER, 
	"ACTIVE_YN" VARCHAR2(1), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" TIMESTAMP (6), 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" TIMESTAMP (6), 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"TITLE" VARCHAR2(60), 
	"SUR_NAME" VARCHAR2(60), 
	"MIDDLE_NAME" VARCHAR2(60), 
	"FIRST_NAME" VARCHAR2(60), 
	"PASSPORT_NO" VARCHAR2(60)
   )
