alter table xxpm_area_change_dlt add negotiable number;
\
alter table xxpm_cancellation add INTERFACE_ERROR_MSG CLOB

create table XXPM_APPLY_CREDIT_MEMO (
 CREDIT_MEMO_ID				NUMBER NOT NULL
,BOOKING_ID					NUMBER
,ORG_ID						NUMBER
,ORG_NAME					VARCHAR2(240)
,INVOICE_ID					NUMBER
,CREDIT_MEMO_TRX_NUMBER		VARCHAR2(60)
,INVOICE_NUMBER				VARCHAR2(60)
,APPLYDATE					VARCHAR2(30)
,GLDATE						VARCHAR2(30)
,INV_AMT					NUMBER
,APPLIED_RECEIPT_AMOUNT		NUMBER
,BALANCE					NUMBER
);

CREATE UNIQUE INDEX "XXPM_CREDIT_MEMO_U1" ON "XXPM_APPLY_CREDIT_MEMO" ("CREDIT_MEMO_ID");

CREATE INDEX "XXPM_CREDIT_MEMO_N1" ON "XXPM_APPLY_CREDIT_MEMO" ("BOOKING_ID");



CREATE SEQUENCE  "CREDIT_MEMO_ID_S"  
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 9999999999999999999999999999   
   NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   

CREATE TABLE XXPM_PROPERTY_RESERVATION
(
RESER_TEMPLATE_ID NUMBER,
RESER_TEMPLATE_CODE		VARCHAR2(30),
RESER_TEMPLATE_NAME		VARCHAR2(60),
PROPERTY_ID				NUMBER
);


CREATE TABLE XXPM_BOOKING_CUSTOMER_DTL (
 BOOKING_CUST_DTL_ID      NUMBER
,BOOKING_CUST_ID          NUMBER        
,BOOKING_HDR_ID           NUMBER        
,CUST_ID                  NUMBER        
,SHIP_TO_SITE_ID          NUMBER        
,BILL_TO_SITE_ID          NUMBER        
,CUST_CONTACT_ID          NUMBER        
,DESCRIPTION              VARCHAR2(240) 
,ATTRIBUTE_CATEGORY       VARCHAR2(240) 
,ATTRIBUTE1               VARCHAR2(240) 
,ATTRIBUTE2               VARCHAR2(240) 
,ATTRIBUTE3               VARCHAR2(240) 
,ATTRIBUTE4               VARCHAR2(240) 
,ATTRIBUTE5               VARCHAR2(240) 
,ATTRIBUTE6               VARCHAR2(240) 
,ATTRIBUTE7               VARCHAR2(240) 
,ATTRIBUTE8               VARCHAR2(240) 
,ATTRIBUTE9               VARCHAR2(240) 
,ATTRIBUTE10              VARCHAR2(240) 
,ATTRIBUTE11              VARCHAR2(240) 
,ATTRIBUTE12              VARCHAR2(240) 
,ATTRIBUTE13              VARCHAR2(240) 
,ATTRIBUTE14              VARCHAR2(240) 
,ATTRIBUTE15              VARCHAR2(240) 
,ATTRIBUTE16              VARCHAR2(240) 
,ATTRIBUTE17              VARCHAR2(240) 
,ATTRIBUTE18              VARCHAR2(240) 
,ATTRIBUTE19              VARCHAR2(240) 
,ATTRIBUTE20              VARCHAR2(240) 
,CREATED_BY               VARCHAR2(60)  
,CREATION_DATE            TIMESTAMP(6)  
,LAST_UPDATED_BY          VARCHAR2(60)  
,LAST_UPDATE_DATE         TIMESTAMP(6)  
,LAST_UPDATE_LOGIN        VARCHAR2(150) 
);


   CREATE SEQUENCE  "BOOKING_CUST_DTL_ID"  
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 9999999999999999999999999999   
   NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

alter table xxpm_booking_milestones add (CUST_TYPE VARCHAR2(30), MILESTONES_STATUS VARCHAR(1));
---
CREATE TABLE UNIT_TRANSFER_DETAILS ( 
UNIT_TRANSFER_ID            NUMBER
,CANCEL_ID                   NUMBER
,BOOKING_HDR_ID                  NUMBER
,UNIT_TRANSFER_DATE          DATE
,FROM_CUSTOMER               NUMBER
,FROM_CUSTOMER_BILL_TO       NUMBER
,FROM_CUSTOMER_CONTACTS      NUMBER
,TO_CUSTOMER                 NUMBER
,TO_CUSTOMER_BILL_TO         NUMBER    
,TO_CUSTOMER_CONTACTS        NUMBER    
,UNIT_TRANSFER_STATUS        VARCHAR(1)    
,DESCRIPTION                 VARCHAR2(240) 
,USER_GRP_ID                 NUMBER        
,FLOW_STATUS                 VARCHAR2(60)  
,FLOW_LEVEL                  NUMBER        
,FLOW_WITH                   NUMBER        
,ATTRIBUTE_CATEGORY          VARCHAR2(240) 
,ATTRIBUTE1                  VARCHAR2(240) 
,ATTRIBUTE2                  VARCHAR2(240) 
,ATTRIBUTE3                  VARCHAR2(240) 
,ATTRIBUTE4                  VARCHAR2(240) 
,ATTRIBUTE5                  VARCHAR2(240) 
,ATTRIBUTE6                  VARCHAR2(240) 
,ATTRIBUTE7                  VARCHAR2(240) 
,ATTRIBUTE8                  VARCHAR2(240) 
,ATTRIBUTE9                  VARCHAR2(240) 
,ATTRIBUTE10                 VARCHAR2(240) 
,CREATED_BY                  VARCHAR2(60)  
,CREATION_DATE               TIMESTAMP(6)  
,LAST_UPDATED_BY             VARCHAR2(60)  
,LAST_UPDATE_DATE            TIMESTAMP(6)  
,LAST_UPDATE_LOGIN           VARCHAR2(150) 
);

CREATE UNIQUE INDEX "UNIT_TRANSFER_DETAILS_PK" ON
        "UNIT_TRANSFER_DETAILS" (
            "UNIT_TRANSFER_ID"
        );




--------------------------------------------------------
--  File created - Sunday-August-11-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXPM_ACTIVITY_LOG
--------------------------------------------------------
CREATE TABLE "XXPM_ACTIVITY_LOG" (
    "ACTIVITY_ID"           NUMBER,
    "ACTIVITY_NUMBER"       VARCHAR2(30),
    "ACTIVITY_DATE"         DATE,
    "FUNC_ID"               NUMBER,
    "SOURCE_FUNC_ID"        NUMBER,
    "SOURCE_FUNC_REF_ID"    NUMBER,
    "ORG_ID"                NUMBER,
    "PROPERTY_ID"           NUMBER,
    "BUILD_ID"              NUMBER,
    "UNIT_ID"               NUMBER,
    "ACTIVITY_TYPE"         VARCHAR2(60),
    "ACTIVITY_REF_NUMBER"   VARCHAR2(240),
    "ACTIVITY_REF_DATE"     DATE,
    "STATUS"                VARCHAR2(60),
    "DESCRIPTION"           VARCHAR2(4000),
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150)
);
    CREATE UNIQUE INDEX "XXPM_ACTIVITY_LOG_PK" ON
        "XXPM_ACTIVITY_LOG" (
            "ACTIVITY_ID"
        );
--------------------------------------------------------
--  DDL for Table XXPM_AREA_CHANGE_DLT
--------------------------------------------------------

CREATE TABLE "XXPM_AREA_CHANGE_DLT" (
    "AREA_CNG_DLT_ID"         NUMBER,
    "AREA_CNG_HDR_ID"         NUMBER,
    "PROPERTY_ID"             NUMBER,
    "BUILD_ID"                NUMBER,
    "UNIT_ID"                 NUMBER,
    "UNIT_STATUS"             VARCHAR2(60),
    "AREA_ID"                 NUMBER,
    "AREA_TYPE"               VARCHAR2(60),
    "UOM"                     VARCHAR2(60),
    "OLD_AREA_VALUE"          NUMBER,
    "NEW_AREA_VALUE"          NUMBER,
    "BOOKING_HDR_ID"          NUMBER,
    "SPA_PCT"                 NUMBER,
    "AREA_VARIATION_PCT"      NUMBER,
    "AREA_EXCEED_TOLERANCE"   NUMBER,
    "OLD_BOOKING_AMOUNT"      NUMBER,
    "NEW_BOOKING_AMOUNT"      NUMBER,
    "ADJ_BOOKING_AMOUNT"      NUMBER,
    "CUST_ACCEPTED_YN"        VARCHAR2(1),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "PAYMENT_TERM"            NUMBER,
    "USER_GRP_ID"             NUMBER,
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER
);
  CREATE UNIQUE INDEX "XXPM_AREA_CHANGE_DLT_PK" ON "XXPM_AREA_CHANGE_DLT" ("AREA_CNG_DLT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_AREA_CHANGE_HDR
--------------------------------------------------------

CREATE TABLE "XXPM_AREA_CHANGE_HDR" (
    "AREA_CNG_HDR_ID"         NUMBER,
    "FUNC_ID"                 NUMBER,
    "AREA_CNG_NUMBER"         VARCHAR2(60),
    "AREA_CNG_DATE"           DATE,
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "SURVEYED_BY"             VARCHAR2(60),
    "SURVEYOR_ID"             NUMBER,
    "SURVEY_DATE"             DATE,
    "PROPERTY_ID"             NUMBER,
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "ORG_ID"                  NUMBER,
    "USER_GRP_ID"             NUMBER,
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_AREA_CHANGE_HDR_PK" ON "XXPM_AREA_CHANGE_HDR" ("AREA_CNG_HDR_ID");

--------------------------------------------------------
--  DDL for Table XXPM_AR_SETUP
--------------------------------------------------------

CREATE TABLE "XXPM_AR_SETUP" (
    "AR_SETUP_ID"            NUMBER,
    "BUSINESS_UNIT_ID"       NUMBER,
    "LEGAL_ENTITY_ID"        NUMBER,
    "CHARGE_TYPE"            VARCHAR2(50),
    "TXN_TYPE"               VARCHAR2(240),
    "TXN_SOURCE"             VARCHAR2(240),
    "CM_TXN_TYPE"            VARCHAR2(240),
    "CM_TXN_SOURCE"          VARCHAR2(240),
    "TYPE_ID"                VARCHAR2(240),
    "TXN_TYPE_ID"            NUMBER,
    "TXN_SOURCE_ID"          NUMBER,
    "CM_TXN_TYPE_ID"         NUMBER,
    "CM_TXN_SOURCE_ID"       NUMBER,
    "REV_ACCOUNT_ID"         NUMBER,
    "CONCATENATED_SEGMENT"   VARCHAR2(240),
    "ACCOUNTING_RULE_NAME"   VARCHAR2(150),
    "INVOICING_RULE"         VARCHAR2(100),
    "INTERCOMPANY_GL_CODE"   VARCHAR2(30),
    "COST_CENTER_GL_CODE"    VARCHAR2(30),
    "USAGE"                  VARCHAR2(30),
    "UNIT_CATEGORY"          VARCHAR2(60),
    "TAX_CODE"               VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_AR_SETUP_PK" ON "XXPM_AR_SETUP" ("AR_SETUP_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BILLING
--------------------------------------------------------

CREATE TABLE "XXPM_BILLING" (
    "BILLING_ID"          NUMBER,
    "BILLING_NUMBER"      VARCHAR2(30),
    "BILLING_DATE"        DATE,
    "USAGE"               VARCHAR2(30),
    "ORG_ID"              NUMBER,
    "STATUS"              VARCHAR2(60),
    "DESCRIPTION"         VARCHAR2(4000),
    "FUNC_ID"             NUMBER,
    "FLOW_STATUS"         VARCHAR2(60),
    "FLOW_LEVEL"          NUMBER,
    "FLOW_WITH"           NUMBER,
    "USER_GRP_ID"         NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_BILLING_PK" ON "XXPM_BILLING" ("BILLING_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BLOCK_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_BLOCK_DETAIL" (
    "BLOCK_DTL_ID"        NUMBER,
    "BLOCK_ID"            NUMBER,
    "PROPERTY_ID"         NUMBER,
    "BUILD_ID"            NUMBER,
    "UNIT_ID"             NUMBER,
    "UNBLOCK_FLAG"        VARCHAR2(1),
    "UNBLOCK_ID"          NUMBER,
    "OFFER_DTL_ID"        NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATED_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_BLOCK_DETAIL_PK" ON "XXPM_BLOCK_DETAIL" ("BLOCK_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BLOCK_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_BLOCK_HEADER" (
    "BLOCK_ID"            NUMBER,
    "BLOCK_NUMBER"        VARCHAR2(30),
    "BLOCK_DATE"          DATE,
    "BLOCK_TYPE"          VARCHAR2(30),
    "BLOCKED_BY"          VARCHAR2(60),
    "ORG_ID"              NUMBER,
    "STATUS"              VARCHAR2(60),
    "DESCRIPTION"         VARCHAR2(4000),
    "FUNC_ID"             NUMBER DEFAULT 18,
    "FLOW_STATUS"         VARCHAR2(60),
    "FLOW_LEVEL"          NUMBER,
    "FLOW_WITH"           NUMBER,
    "USER_GRP_ID"         NUMBER,
    "RECEIPT_YN"          VARCHAR2(1),
    "OFFER_HDR_ID"        NUMBER,
    "CUST_ID"             NUMBER,
    "CUST_SITE_ID"        NUMBER,
    "VALID_UPTO"          DATE,
    "EXTN_REASON"         VARCHAR2(60),
    "EXTN_COUNT"          NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATED_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(60),
    "LEAD_ID"             NUMBER,
    "USAGE"               VARCHAR2(30),
    "PROPERTY_ID"         NUMBER
);
  CREATE UNIQUE INDEX "XXPM_BLOCK_HEADER_U1" ON "XXPM_BLOCK_HEADER" ("BLOCK_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_CUSTOMER
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_CUSTOMER" (
    "BOOKING_CUST_ID"      NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "CUST_ID"              NUMBER,
    "SHIP_TO_SITE_ID"      NUMBER,
    "BILL_TO_SITE_ID"      NUMBER,
    "CUST_CONTACT_ID"      NUMBER,
    "PRIMARY_YN"           VARCHAR2(1),
    "DESCRIPTION"          VARCHAR2(240),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "ATTRIBUTE11"          VARCHAR2(240),
    "ATTRIBUTE12"          VARCHAR2(240),
    "ATTRIBUTE13"          VARCHAR2(240),
    "ATTRIBUTE14"          VARCHAR2(240),
    "ATTRIBUTE15"          VARCHAR2(240),
    "ATTRIBUTE16"          VARCHAR2(240),
    "ATTRIBUTE17"          VARCHAR2(240),
    "ATTRIBUTE18"          VARCHAR2(240),
    "ATTRIBUTE19"          VARCHAR2(240),
    "ATTRIBUTE20"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE INDEX "XXPM_BOOKING_CUSTOMER_N1" ON "XXPM_BOOKING_CUSTOMER" ("BOOKING_HDR_ID", "CUST_ID", "BILL_TO_SITE_ID", "PRIMARY_YN");
  CREATE UNIQUE INDEX "XXPM_BOOKING_CUSTOMER_U1" ON "XXPM_BOOKING_CUSTOMER" ("BOOKING_CUST_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_CUSTOMER_H
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_CUSTOMER_H" (
    "BOOKING_CUST_ID_H"    NUMBER,
    "BOOKING_CUST_ID"      NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "CUST_ID"              NUMBER,
    "SHIP_TO_SITE_ID"      VARCHAR2(150),
    "BILL_TO_SITE_ID"      VARCHAR2(150),
    "CUST_CONTACT_ID"      NUMBER,
    "PRIMARY_YN"           VARCHAR2(1),
    "DESCRIPTION"          VARCHAR2(240),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "ATTRIBUTE11"          VARCHAR2(240),
    "ATTRIBUTE12"          VARCHAR2(240),
    "ATTRIBUTE13"          VARCHAR2(240),
    "ATTRIBUTE14"          VARCHAR2(240),
    "ATTRIBUTE15"          VARCHAR2(240),
    "ATTRIBUTE16"          VARCHAR2(240),
    "ATTRIBUTE17"          VARCHAR2(240),
    "ATTRIBUTE18"          VARCHAR2(240),
    "ATTRIBUTE19"          VARCHAR2(240),
    "ATTRIBUTE20"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOKING_CUSTOMER_H_PK" ON "XXPM_BOOKING_CUSTOMER_H" ("BOOKING_CUST_ID_H");


--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_DETAIL" (
    "BOOKING_DTL_ID"       NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILDING_ID"          NUMBER,
    "UNIT_ID"              NUMBER,
    "UOM"                  VARCHAR2(60),
    "QUANTITY"             NUMBER,
    "BOOKING_RATE"         NUMBER,
    "BOOKING_AMOUNT"       NUMBER,
    "PL_MOD_ID"            NUMBER,
    "DISC_PCT"             NUMBER,
    "DISC_AMOUNT"          NUMBER,
    "TAX_CODE"             VARCHAR2(60),
    "TAX_RATE"             NUMBER,
    "TAX_AMOUNT"           NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE INDEX "XXPM_BOOKING_DETAIL_N1" ON "XXPM_BOOKING_DETAIL" ("BOOKING_HDR_ID", "PROPERTY_ID", "BUILDING_ID", "UNIT_ID");

  CREATE UNIQUE INDEX "XXPM_BOOKING_DETAIL_PK" ON "XXPM_BOOKING_DETAIL" ("BOOKING_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_DETAIL_H
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_DETAIL_H" (
    "BOOKING_DTL_ID_H"     NUMBER,
    "BOOKING_DTL_ID"       NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILDING_ID"          NUMBER,
    "UNIT_ID"              NUMBER,
    "UOM"                  VARCHAR2(60),
    "QUANTITY"             NUMBER,
    "BOOKING_RATE"         NUMBER,
    "BOOKING_AMOUNT"       NUMBER,
    "PL_MOD_ID"            NUMBER,
    "DISC_PCT"             NUMBER,
    "DISC_AMOUNT"          NUMBER,
    "TAX_CODE"             VARCHAR2(60),
    "TAX_RATE"             NUMBER,
    "TAX_AMOUNT"           NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOKING_DETAIL_H_PK" ON "XXPM_BOOKING_DETAIL_H" ("BOOKING_DTL_ID_H");
  
--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_EVENTS
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_EVENTS" (
    "BOOKING_EVENT_ID"     NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "EVENT_TYPE"           VARCHAR2(30),
    "EVENT_DATE"           DATE,
    "EVENT_UPDATED_ON"     DATE,
    "EVENT_EXE_BY"         NUMBER,
    "EVENT_REF_NUMBER"     VARCHAR2(60),
    "ACTIVE_YN"            VARCHAR2(1),
    "DESCRIPTION"          VARCHAR2(240),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOKING_EVENTS_PK" ON "XXPM_BOOKING_EVENTS" ("BOOKING_EVENT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_EVENTS_H
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_EVENTS_H" (
    "BOOKING_EVENT_ID_H"   NUMBER,
    "BOOKING_EVENT_ID"     NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "EVENT_TYPE"           VARCHAR2(30),
    "EVENT_DATE"           DATE,
    "EVENT_UPDATED_ON"     DATE,
    "EVENT_EXE_BY"         NUMBER,
    "EVENT_REF_NUMBER"     VARCHAR2(60),
    "ACTIVE_YN"            VARCHAR2(1),
    "DESCRIPTION"          VARCHAR2(240),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
CREATE UNIQUE INDEX "XXPM_BOOKING_EVENTS_H_PK" ON "XXPM_BOOKING_EVENTS_H" ("BOOKING_EVENT_ID_H");


--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_HEADER" (
    "BOOKING_HDR_ID"          NUMBER,
    "ORG_ID"                  NUMBER,
    "FUNC_ID"                 NUMBER,
    "PROPERTY_ID"             NUMBER,
    "OFFER_HDR_ID"            NUMBER,
    "BLOCK_ID"                NUMBER,
    "BOOKING_NUMBER"          VARCHAR2(60),
    "BOOKING_DATE"            DATE,
    "BOOKING_END_DATE"        DATE,
    "BOOKING_FROM_DATE"       DATE,
    "BOOKING_TO_DATE"         DATE,
    "SPA_PCT"                 NUMBER,
    "AREA_VARIATION_PCT"      NUMBER,
    "USAGE"                   VARCHAR2(30),
    "BOOKING_EXE_BY"          NUMBER,
    "REVISION_NO"             NUMBER,
    "REVISION_DATE"           DATE,
    "REVISED_BY"              VARCHAR2(60),
    "MS_HDR_ID"               NUMBER,
    "PL_ID"                   NUMBER,
    "BOOKING_TYPE"            VARCHAR2(60),
    "BOOKING_STAGE"           VARCHAR2(60),
    "LEAD_ID"                 NUMBER,
    "SALESMAN_ID"             NUMBER,
    "CURRENCY_CODE"           VARCHAR2(3),
    "CHECKLIST"               VARCHAR2(250),
    "TERMS_DESC"              VARCHAR2(2000),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "BOOKING_FLAG"            VARCHAR2(60),
    "TAX_CODE"                VARCHAR2(60),
    "PREV_BOOKING_ID"         NUMBER,
    "LEAD_SOURCE_CHANNEL"     VARCHAR2(240),
    "LEAD_SOURCE_NAME"        VARCHAR2(240),
    "VEND_ID"                 NUMBER,
    "VEND_SITE_ID"            NUMBER,
    "VEND_CONTRACT_NO"        VARCHAR2(240),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "USER_GRP_ID"             NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "MIGRATED_DATA"           VARCHAR2(5),
    "ACTIVE_YN"               VARCHAR2(1)
);
  CREATE INDEX "XXPM_BOOKING_HEADER_N1" ON "XXPM_BOOKING_HEADER" ("BOOKING_HDR_ID", "ORG_ID", "PROPERTY_ID", "STATUS");
  CREATE UNIQUE INDEX "XXPM_BOOKING_HEADER_U1" ON "XXPM_BOOKING_HEADER" ("BOOKING_HDR_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_HEADER_H
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_HEADER_H" (
    "BOOKING_HDR_ID_H"        NUMBER,
    "BOOKING_HDR_ID"          NUMBER,
    "ORG_ID"                  NUMBER,
    "FUNC_ID"                 NUMBER,
    "PROPERTY_ID"             NUMBER,
    "OFFER_HDR_ID"            NUMBER,
    "BLOCK_ID"                NUMBER,
    "BOOKING_NUMBER"          VARCHAR2(60),
    "BOOKING_DATE"            DATE,
    "BOOKING_END_DATE"        DATE,
    "BOOKING_FROM_DATE"       DATE,
    "BOOKING_TO_DATE"         DATE,
    "SPA_PCT"                 NUMBER,
    "AREA_VARIATION_PCT"      NUMBER,
    "USAGE"                   VARCHAR2(30),
    "BOOKING_EXE_BY"          NUMBER,
    "REVISION_NO"             NUMBER,
    "REVISION_DATE"           DATE,
    "REVISED_BY"              VARCHAR2(60),
    "MS_HDR_ID"               NUMBER,
    "PL_ID"                   NUMBER,
    "BOOKING_TYPE"            VARCHAR2(60),
    "BOOKING_STAGE"           VARCHAR2(60),
    "LEAD_ID"                 NUMBER,
    "SALESMAN_ID"             NUMBER,
    "CURRENCY_CODE"           VARCHAR2(3),
    "CHECKLIST"               VARCHAR2(250),
    "TERMS_DESC"              VARCHAR2(2000),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "BOOKING_FLAG"            VARCHAR2(60),
    "TAX_CODE"                VARCHAR2(60),
    "PREV_BOOKING_ID"         NUMBER,
    "LEAD_SOURCE_CHANNEL"     VARCHAR2(240),
    "LEAD_SOURCE_NAME"        VARCHAR2(240),
    "VEND_ID"                 NUMBER,
    "VEND_SITE_ID"            NUMBER,
    "VEND_CONTRACT_NO"        VARCHAR2(240),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "USER_GRP_ID"             NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOKING_HEADER_H_PK" ON "XXPM_BOOKING_HEADER_H" ("BOOKING_HDR_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_HEADER_REV
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_HEADER_REV" (
    "BOOKING_HDR_REV_ID"      NUMBER,
    "BOOKING_HDR_ID"          NUMBER,
    "ORG_ID"                  NUMBER,
    "FUNC_ID"                 NUMBER,
    "BOOKING_REV_NUMBER"      VARCHAR2(60),
    "BOOKING_REV_DATE"        DATE,
    "USAGE"                   VARCHAR2(30),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "USER_GRP_ID"             NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOKING_HEADER_REV_U1" ON "XXPM_BOOKING_HEADER_REV" ("BOOKING_HDR_REV_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_MILESTONES
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_MILESTONES" (
    "BOOKING_MS_DTL_ID"    NUMBER,
    "MILESTONE_TYPE"       VARCHAR2(60),
    "MS_DTL_ID"            NUMBER,
    "PL_MOD_ID"            NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "INSTALLMENT_TYPE"     VARCHAR2(60),
    "INSTALLMENT_PCT"      NUMBER,
    "INSTALLMENT_AMOUNT"   NUMBER,
    "UOM"                  VARCHAR2(30),
    "QUANTITY"             NUMBER,
    "RATE"                 NUMBER,
    "WAVE_OFF"             VARCHAR2(30),
    "INCLUDED_IN_RATE"     VARCHAR2(30),
    "INSTALLMENT_METHOD"   VARCHAR2(30),
    "INSTALLMENT_EVENT"    VARCHAR2(240),
    "PERIOD_OCCURENCE"     VARCHAR2(30),
    "PERIOD_VALUES"        NUMBER,
    "PERIOD_DURATION"      VARCHAR2(30),
    "CHARGE_TYPE"          VARCHAR2(60),
    "PAYMENT_TERM"         VARCHAR2(60),
    "REMARKS"              VARCHAR2(4000),
    "DUE_DAYS"             NUMBER,
    "DUE_DAYS_FROM"        VARCHAR2(60),
    "DUE_DATE"             DATE,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "SOURCE_FUNC_ID"       NUMBER,
    "SOURCE_FUNC_REF_ID"   NUMBER,
    "BILLING_ID"           NUMBER,
    "STATUS"               VARCHAR2(60),
    "INVOICE_ID"           NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "BASEAMOUNT"           NUMBER,
    "TAX_RATE"             NUMBER,
    "TAX_CODE"             VARCHAR2(60),
    "TAX_AMOUNT"           NUMBER,
    "CARPARKING"           VARCHAR2(200)
);

  CREATE INDEX "XXPM_BOOKING_MILESTONES_N1" ON "XXPM_BOOKING_MILESTONES" ("BOOKING_MS_DTL_ID", "MILESTONE_TYPE", "MS_DTL_ID", "INSTALLMENT_TYPE", "INSTALLMENT_METHOD", "CHARGE_TYPE", "SOURCE_FUNC_REF_ID", "INVOICE_ID", "BOOKING_HDR_ID");

  CREATE UNIQUE INDEX "XXPM_BOOKING_MILESTONES_U1" ON "XXPM_BOOKING_MILESTONES" ("BOOKING_MS_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_MILESTONES_H
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_MILESTONES_H" (
    "BOOKING_MS_DTL_ID_H"   NUMBER,
    "BOOKING_MS_DTL_ID"     NUMBER,
    "BOOKING_HDR_ID"        NUMBER,
    "MILESTONE_TYPE"        VARCHAR2(60),
    "MS_DTL_ID"             NUMBER,
    "PL_MOD_ID"             NUMBER,
    "SEQ_NUMBER"            NUMBER,
    "INSTALLMENT_TYPE"      VARCHAR2(60),
    "INSTALLMENT_PCT"       NUMBER,
    "INSTALLMENT_AMOUNT"    NUMBER,
    "UOM"                   VARCHAR2(30),
    "QUANTITY"              NUMBER,
    "RATE"                  NUMBER,
    "WAVE_OFF"              VARCHAR2(30),
    "INCLUDED_IN_RATE"      VARCHAR2(30),
    "INSTALLMENT_METHOD"    VARCHAR2(30),
    "INSTALLMENT_EVENT"     VARCHAR2(240),
    "PERIOD_OCCURENCE"      VARCHAR2(30),
    "PERIOD_VALUES"         NUMBER,
    "PERIOD_DURATION"       VARCHAR2(30),
    "CHARGE_TYPE"           VARCHAR2(60),
    "PAYMENT_TERM"          VARCHAR2(60),
    "REMARKS"               VARCHAR2(4000),
    "DUE_DAYS"              NUMBER,
    "DUE_DAYS_FROM"         VARCHAR2(60),
    "DUE_DATE"              DATE,
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXXPM_BOOKING_MILESTONES_H_PK" ON "XXPM_BOOKING_MILESTONES_H" ("BOOKING_MS_DTL_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_BOOKING_MILESTONES_REV
--------------------------------------------------------

CREATE TABLE "XXPM_BOOKING_MILESTONES_REV" (
    "BOOKING_REV_ID"         NUMBER,
    "BOOKING_MS_DTL_ID"      NUMBER,
    "SOURCE_FUNC_ID"         NUMBER,
    "SOURCE_FUNC_REF_ID"     NUMBER,
    "MILESTONE_TYPE"         VARCHAR2(60),
    "MS_DTL_ID"              NUMBER,
    "PL_MOD_ID"              NUMBER,
    "SEQ_NUMBER"             NUMBER,
    "INSTALLMENT_TYPE"       VARCHAR2(60),
    "INSTALLMENT_PCT"        NUMBER,
    "INSTALLMENT_AMOUNT"     NUMBER,
    "UOM"                    VARCHAR2(30),
    "QUANTITY"               NUMBER,
    "RATE"                   NUMBER,
    "WAVE_OFF"               VARCHAR2(30),
    "INCLUDED_IN_RATE"       VARCHAR2(30),
    "INSTALLMENT_METHOD"     VARCHAR2(30),
    "INSTALLMENT_EVENT"      VARCHAR2(30),
    "PERIOD_OCCURENCE"       VARCHAR2(30),
    "PERIOD_VALUES"          NUMBER,
    "PERIOD_DURATION"        VARCHAR2(30),
    "CHARGE_TYPE"            VARCHAR2(60),
    "PAYMENT_TERM"           VARCHAR2(60),
    "REMARKS"                VARCHAR2(4000),
    "DUE_DAYS"               NUMBER,
    "DUE_DAYS_FROM"          VARCHAR2(60),
    "DUE_DATE"               DATE,
    "BILLING_ID"             NUMBER,
    "STATUS"                 VARCHAR2(60),
    "INVOICE_ID"             NUMBER,
    "INSTALLMENT_PCT_R"      NUMBER,
    "INSTALLMENT_AMOUNT_R"   NUMBER,
    "ACTION_FLAG"            VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"     VARCHAR2(240),
    "ATTRIBUTE1"             VARCHAR2(240),
    "ATTRIBUTE2"             VARCHAR2(240),
    "ATTRIBUTE3"             VARCHAR2(240),
    "ATTRIBUTE4"             VARCHAR2(240),
    "ATTRIBUTE5"             VARCHAR2(240),
    "ATTRIBUTE6"             VARCHAR2(240),
    "ATTRIBUTE7"             VARCHAR2(240),
    "ATTRIBUTE8"             VARCHAR2(240),
    "ATTRIBUTE9"             VARCHAR2(240),
    "ATTRIBUTE10"            VARCHAR2(240),
    "CREATED_BY"             VARCHAR2(60),
    "CREATION_DATE"          TIMESTAMP(6),
    "LAST_UPDATED_BY"        VARCHAR2(60),
    "LAST_UPDATE_DATE"       TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"      VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOKING_MILESTONES_REV_U1" ON "XXPM_BOOKING_MILESTONES_REV" ("BOOKING_MS_DTL_ID");


--------------------------------------------------------
--  DDL for Table XXPM_BOOK_MS_REV_DTL
--------------------------------------------------------

CREATE TABLE "XXPM_BOOK_MS_REV_DTL" (
    "MS_REV_DTL_ID"          NUMBER,
    "MS_REV_ID"              NUMBER,
    "SOURCE_FUNC_ID"         NUMBER,
    "SOURCE_FUNC_REF_ID"     NUMBER,
    "MILESTONE_TYPE"         VARCHAR2(60),
    "MS_DTL_ID"              NUMBER,
    "PL_MOD_ID"              NUMBER,
    "SEQ_NUMBER"             NUMBER,
    "INSTALLMENT_TYPE"       VARCHAR2(60),
    "INSTALLMENT_PCT"        NUMBER,
    "INSTALLMENT_AMOUNT"     NUMBER,
    "UOM"                    VARCHAR2(30),
    "QUANTITY"               NUMBER,
    "RATE"                   NUMBER,
    "WAVE_OFF"               VARCHAR2(30),
    "INCLUDED_IN_RATE"       VARCHAR2(30),
    "INSTALLMENT_METHOD"     VARCHAR2(30),
    "INSTALLMENT_EVENT"      VARCHAR2(240),
    "PERIOD_OCCURENCE"       VARCHAR2(30),
    "PERIOD_VALUES"          NUMBER,
    "PERIOD_DURATION"        VARCHAR2(30),
    "CHARGE_TYPE"            VARCHAR2(60),
    "PAYMENT_TERM"           VARCHAR2(60),
    "REMARKS"                VARCHAR2(4000),
    "DUE_DAYS"               NUMBER,
    "DUE_DAYS_FROM"          VARCHAR2(60),
    "DUE_DATE"               DATE,
    "BILLING_ID"             NUMBER,
    "STATUS"                 VARCHAR2(60),
    "INVOICE_ID"             NUMBER,
    "INSTALLMENT_PCT_R"      NUMBER,
    "INSTALLMENT_AMOUNT_R"   NUMBER,
    "ACTION_FLAG"            VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"     VARCHAR2(240),
    "ATTRIBUTE1"             VARCHAR2(240),
    "ATTRIBUTE2"             VARCHAR2(240),
    "ATTRIBUTE3"             VARCHAR2(240),
    "ATTRIBUTE4"             VARCHAR2(240),
    "ATTRIBUTE5"             VARCHAR2(240),
    "ATTRIBUTE6"             VARCHAR2(240),
    "ATTRIBUTE7"             VARCHAR2(240),
    "ATTRIBUTE8"             VARCHAR2(240),
    "ATTRIBUTE9"             VARCHAR2(240),
    "ATTRIBUTE10"            VARCHAR2(240),
    "CREATED_BY"             VARCHAR2(60),
    "CREATION_DATE"          TIMESTAMP(6),
    "LAST_UPDATED_BY"        VARCHAR2(60),
    "LAST_UPDATE_DATE"       TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"      VARCHAR2(150),
    "BOOKING_MS_DTL_ID"      NUMBER,
    "CARPARKING"             VARCHAR2(200)
);
  CREATE UNIQUE INDEX "XXPM_BOOK_MS_REV_DTL_PK" ON "XXPM_BOOK_MS_REV_DTL" ("MS_REV_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_BOOK_MS_REV_HDR
--------------------------------------------------------

CREATE TABLE "XXPM_BOOK_MS_REV_HDR" (
    "MS_REV_ID"               NUMBER,
    "BOOKING_HDR_ID"          NUMBER,
    "ORG_ID"                  NUMBER,
    "FUNC_ID"                 NUMBER,
    "MS_REV_NUMBER"           VARCHAR2(60),
    "MS_REV_DATE"             DATE,
    "USAGE"                   VARCHAR2(30),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "USER_GRP_ID"             NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_BOOK_MS_REV_HDR_PK" ON "XXPM_BOOK_MS_REV_HDR" ("MS_REV_ID");

--------------------------------------------------------
--  DDL for Table XXPM_CANCELLATION
--------------------------------------------------------

CREATE TABLE "XXPM_CANCELLATION" (
    "CANCEL_ID"               NUMBER,
    "FUNC_ID"                 NUMBER,
    "LEASE_AGREEMENT_ID"      NUMBER,
    "BOOKING_ID"              NUMBER,
    "CANCEL_TYPE"             VARCHAR2(5),
    "CANCEL_NUMBER"           VARCHAR2(60),
    "CANCEL_DATE"             DATE,
    "FINAL_CANCEL_DATE"       DATE,
    "CURRENCY"                VARCHAR2(60),
    "REFUND_AMOUNT"           NUMBER,
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "DLD_CANCEL_STATUS"       VARCHAR2(60),
    "DLD_CANCEL_DATE"         DATE,
    "REASON"                  VARCHAR2(60),
    "REASON_DESC"             VARCHAR2(500),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "ORG_ID"                  NUMBER,
    "USER_GRP_ID"             NUMBER,
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "FORFIET_AMOUNT"          NUMBER,
    "USAGE"                   VARCHAR2(30)
);
ALTER TABLE XXPM_CANCELLATION ADD (ADJUSTMENT_AMT NUMBER);
  CREATE UNIQUE INDEX "XXPM_CANCELLATION_PK" ON "XXPM_CANCELLATION" ("CANCEL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_CANCEL_NOTIFY
--------------------------------------------------------

CREATE TABLE "XXPM_CANCEL_NOTIFY" (
    "NOTIFY_ID"             NUMBER,
    "CANCEL_ID"             NUMBER,
    "NOTIFY_TYPE"           VARCHAR2(60),
    "NOTIFY_DATE"           DATE,
    "NOTIFY_BY"             VARCHAR2(60),
    "DUE_DATE"              DATE,
    "EMAIL_NOTIFY_YN"       VARCHAR2(1),
    "SMS_NOTIFY_YN"         VARCHAR2(1),
    "LETTER_NOTIFY_YN"      VARCHAR2(1),
    "NEWSPAPER_NOTIFY_YN"   VARCHAR2(1),
    "REMARKS"               VARCHAR2(2000),
    "ACKNOWLEDGED_YN"       VARCHAR2(1),
    "PAY_RECEIVED_YN"       VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_CANCEL_NOTIFY_PK" ON "XXPM_CANCEL_NOTIFY" ("NOTIFY_ID");
--------------------------------------------------------
--  DDL for Table XXPM_CUST_DETAIL_TYPES
--------------------------------------------------------

CREATE TABLE "XXPM_CUST_DETAIL_TYPES" (
    "CUST_ID_LIST"     VARCHAR2(50),
    "CUST_NAME_LIST"   VARCHAR2(50)
);
  CREATE UNIQUE INDEX "XXPM_CUST_DETAIL_TYPES_U1" ON "XXPM_CUST_DETAIL_TYPES" ("CUST_ID_LIST");

--------------------------------------------------------
--  DDL for Table XXPM_EXTEN_CANCEL
--------------------------------------------------------

CREATE TABLE "XXPM_EXTEN_CANCEL" (
    "EXTN_CANCL_ID"                   NUMBER,
    "FUNC_ID"                         NUMBER,
    "LEASE_AGREEMENT_ID"              NUMBER,
    "BOOKING_ID"                      NUMBER,
    "TRANS_TYPE"                      VARCHAR2(5),
    "TRANS_NUMBER"                    VARCHAR2(60),
    "TRANS_DATE"                      DATE,
    "DUE_DATE"                        DATE,
    "AMOUNT"                          NUMBER,
    "CURRENCY"                        VARCHAR2(60),
    "STATUS"                          VARCHAR2(60),
    "DESCRIPTION"                     VARCHAR2(240),
    "ORG_ID"                          NUMBER,
    "USER_GRP_ID"                     NUMBER,
    "FLOW_STATUS"                     VARCHAR2(60),
    "FLOW_LEVEL"                      NUMBER,
    "FLOW_WITH"                       NUMBER,
    "ATTRIBUTE_CATEGORY"              VARCHAR2(240),
    "ATTRIBUTE1"                      VARCHAR2(240),
    "ATTRIBUTE2"                      VARCHAR2(240),
    "ATTRIBUTE3"                      VARCHAR2(240),
    "ATTRIBUTE4"                      VARCHAR2(240),
    "ATTRIBUTE5"                      VARCHAR2(240),
    "ATTRIBUTE6"                      VARCHAR2(240),
    "ATTRIBUTE7"                      VARCHAR2(240),
    "ATTRIBUTE8"                      VARCHAR2(240),
    "ATTRIBUTE9"                      VARCHAR2(240),
    "ATTRIBUTE10"                     VARCHAR2(240),
    "CREATED_BY"                      VARCHAR2(60),
    "CREATION_DATE"                   TIMESTAMP(6),
    "LAST_UPDATED_BY"                 VARCHAR2(60),
    "LAST_UPDATE_DATE"                TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"               VARCHAR2(150),
    "PROPERTY_ID"                     NUMBER,
    "BUILD_ID"                        NUMBER,
    "NUM_OF_REMAINING_DAYS"           NUMBER,
    "REFUND_AMT_FOR_REMAINING_DAYS"   NUMBER,
    "NET_REFUND_AMOUNT"               NUMBER,
    "CANCELLATION_AMOUNT"             NUMBER,
    "EXTENSION_DAYS"                  NUMBER,
    "OBJECT_VERSION_NUMBER"           NUMBER
);
  CREATE UNIQUE INDEX "XXPM_EXTEN_CANCEL_PK" ON "XXPM_EXTEN_CANCEL" ("EXTN_CANCL_ID");


--------------------------------------------------------
--  DDL for Table XXPM_INVOICE_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_INVOICE_HEADER" (
    "INVOICE_ID"            NUMBER,
    "INVOICE_NUMBER"        VARCHAR2(60),
    "INVOICE_DATE"          DATE,
    "FUNC_ID"               NUMBER,
    "INVOICE_CLASS"         VARCHAR2(60),
    "ORG_ID"                NUMBER,
    "TRX_SOURCE"            VARCHAR2(250),
    "TRX_TYPE"              VARCHAR2(250),
    "CURRENCY_CODE"         VARCHAR2(3),
    "EXCHANGE_RATE"         NUMBER,
    "CUST_ID"               NUMBER,
    "CUST_SITE_ID"          NUMBER,
    "DUE_DATE"              DATE,
    "STATUS"                VARCHAR2(60),
    "INTERFACE_STATUS"      VARCHAR2(60),
    "OFFER_ID"              NUMBER,
    "OFFER_NUMBER"          VARCHAR2(60),
    "BOOKING_ID"            NUMBER,
    "BOOKING_NUMBER"        VARCHAR2(60),
    "SALE_LEASE_NUMBER"     VARCHAR2(60),
    "CUSTOMER_TRX_ID"       NUMBER,
    "CUSTOMER_TRX_NUMBER"   VARCHAR2(60),
    "INVOICING_RULE"        VARCHAR2(60),
    "ACNT_RULE"             VARCHAR2(60),
    "RULE_START_DATE"       DATE,
    "RULE_END_DATE"         DATE,
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(240),
    "CREATED_DATE"          TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(240),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(240),
    "INTERFACE_ERROR_MSG"   CLOB,
    "PAYMENT_TERMS"         NUMBER
);
 CREATE INDEX "XXPM_INVOICE_HEADER_N1" ON "XXPM_INVOICE_HEADER" ("BOOKING_ID");

  CREATE UNIQUE INDEX "XXPM_INVOICE_HEADER_U1" ON "XXPM_INVOICE_HEADER" ("INVOICE_ID");


--------------------------------------------------------
--  DDL for Table XXPM_INVOICE_LINES
--------------------------------------------------------

CREATE TABLE "XXPM_INVOICE_LINES" (
    "INVOICE_ID"             NUMBER,
    "INVOICE_LINE_ID"        NUMBER,
    "LINE_NUMBER"            NUMBER,
    "DESCRIPTION"            VARCHAR2(240) DEFAULT 'FROM PRISM',
    "UOM_CODE"               VARCHAR2(240),
    "QUANTITY"               NUMBER,
    "PRICE"                  NUMBER,
    "AMOUNT"                 NUMBER,
    "TAX_CODE"               VARCHAR2(60),
    "TAX_PERC"               NUMBER,
    "TAX_AMOUNT"             NUMBER,
    "CHARGE_TYPE"            VARCHAR2(60),
    "REV_ACNT_ID"            NUMBER,
    "REV_ACNT_CODE"          VARCHAR2(240),
    "OFFER_DTL_ID"           NUMBER,
    "BOOKING_DTL_ID"         NUMBER,
    "PROPERTY_ID"            NUMBER,
    "PROPERTY_NUMBER"        VARCHAR2(60),
    "BUILD_ID"               NUMBER,
    "BUILD_NUMBER"           VARCHAR2(60),
    "UNIT_ID"                NUMBER,
    "UNIT_NUMBER"            VARCHAR2(60),
    "BILLING_MS_ID"          NUMBER,
    "INSTALLMENT_TYPE"       VARCHAR2(60),
    "CUSTOMER_TRX_LINE_ID"   NUMBER,
    "ATTRIBUTE_CATEGORY"     VARCHAR2(240),
    "ATTRIBUTE1"             VARCHAR2(240),
    "ATTRIBUTE2"             VARCHAR2(240),
    "ATTRIBUTE3"             VARCHAR2(240),
    "ATTRIBUTE4"             VARCHAR2(240),
    "ATTRIBUTE5"             VARCHAR2(240),
    "ATTRIBUTE6"             VARCHAR2(240),
    "ATTRIBUTE7"             VARCHAR2(240),
    "ATTRIBUTE8"             VARCHAR2(240),
    "ATTRIBUTE9"             VARCHAR2(240),
    "ATTRIBUTE10"            VARCHAR2(240),
    "CREATED_BY"             VARCHAR2(240),
    "CREATED_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"        VARCHAR2(240),
    "LAST_UPDATE_DATE"       TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"      VARCHAR2(240),
    "LINE_AMOUNT"            NUMBER,
    "LINE_TYPE"              VARCHAR2(30)
);
  CREATE INDEX "XXPM_INVOICE_LINES_N1" ON "XXPM_INVOICE_LINES" ("INVOICE_ID");

  CREATE UNIQUE INDEX "XXPM_INVOICE_LINES_U1" ON "XXPM_INVOICE_LINES" ("INVOICE_LINE_ID");




--------------------------------------------------------
--  DDL for Table XXPM_KEY_DETAILS
--------------------------------------------------------

CREATE TABLE "XXPM_KEY_DETAILS" (
    "KEY_ID"               NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "MOVE_IN_OUT_ID"       NUMBER,
    "KEY_CODE"             VARCHAR2(60),
    "KEY_QTY"              NUMBER,
    "DESCRIPTION"          VARCHAR2(240),
    "STATUS"               VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_KEY_DETAILS_U1" ON "XXPM_KEY_DETAILS" ("KEY_ID");

--------------------------------------------------------
--  DDL for Table XXPM_LEAD
--------------------------------------------------------

CREATE TABLE "XXPM_LEAD" (
    "LEAD_ID"                        NUMBER,
    "ORG_ID"                         NUMBER,
    "FUNC_ID"                        NUMBER,
    "LEAD_NUMBER"                    VARCHAR2(60),
    "VISITTED_DATE"                  DATE,
    "TITLE"                          VARCHAR2(30),
    "FIRST_NAME"                     VARCHAR2(240),
    "LAST_NAME"                      VARCHAR2(240),
    "LEAD_NAME"                      VARCHAR2(150),
    "STATUS"                         VARCHAR2(60),
    "AGENT"                          VARCHAR2(1),
    "PRIMARY_SOURCE"                 VARCHAR2(60),
    "SEC_SOURCE"                     VARCHAR2(240),
    "EMAIL_ID"                       VARCHAR2(60),
    "MOBILE_NUMBER"                  VARCHAR2(60),
    "PHONE_NUMBER"                   VARCHAR2(60),
    "FAX"                            VARCHAR2(60),
    "CUR_ADDRESS1"                   VARCHAR2(240),
    "CUR_ADDRESS2"                   VARCHAR2(240),
    "CUR_ADDRESS3"                   VARCHAR2(240),
    "CUR_ADDRESS4"                   VARCHAR2(240),
    "CUR_CITY"                       VARCHAR2(240),
    "CUR_POSTAL_CODE"                VARCHAR2(240),
    "CUR_PROVINCE"                   VARCHAR2(240),
    "CUR_COUNTY"                     VARCHAR2(240),
    "CUR_COUNTRY"                    VARCHAR2(240),
    "PER_ADDRESS1"                   VARCHAR2(240),
    "PER_ADDRESS2"                   VARCHAR2(240),
    "PER_ADDRESS3"                   VARCHAR2(240),
    "PER_ADDRESS4"                   VARCHAR2(240),
    "PER_CITY"                       VARCHAR2(240),
    "PER_POSTAL_CODE"                VARCHAR2(240),
    "PER_PROVINCE"                   VARCHAR2(240),
    "PER_COUNTY"                     VARCHAR2(240),
    "PER_COUNTRY"                    VARCHAR2(240),
    "DESCRIPTION"                    VARCHAR2(240),
    "NATIONALITY"                    VARCHAR2(60),
    "PASSPORT_NUMBER"                VARCHAR2(60),
    "PASSPORT_EXP_DATE"              DATE,
    "COUNTRY_OF_RES"                 VARCHAR2(60),
    "RESIDENT_ID"                    VARCHAR2(60),
    "RESIDENT_ID_EXP_DATE"           DATE,
    "ATTRIBUTE_CATEGORY"             VARCHAR2(240),
    "ATTRIBUTE1"                     VARCHAR2(240),
    "ATTRIBUTE2"                     VARCHAR2(240),
    "ATTRIBUTE3"                     VARCHAR2(240),
    "ATTRIBUTE4"                     VARCHAR2(240),
    "ATTRIBUTE5"                     VARCHAR2(240),
    "ATTRIBUTE6"                     VARCHAR2(240),
    "ATTRIBUTE7"                     VARCHAR2(240),
    "ATTRIBUTE8"                     VARCHAR2(240),
    "ATTRIBUTE9"                     VARCHAR2(240),
    "ATTRIBUTE10"                    VARCHAR2(240),
    "CREATED_BY"                     VARCHAR2(60),
    "CREATION_DATE"                  TIMESTAMP(6),
    "LAST_UPDATED_BY"                VARCHAR2(60),
    "LAST_UPDATE_DATE"               TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"              VARCHAR2(150),
    "ACTIVE_RP"                      VARCHAR2(1),
    "PROFESSIONAL"                   VARCHAR2(240),
    "EMIRATES_ID_REF_1"              NUMBER,
    "EMIRATES_ID_REF_2"              NUMBER,
    "EMIRATES_ID_REF_3"              NUMBER,
    "EMIRATES_ID_REF_4"              NUMBER,
    "TRADE_LINCENSE_NAME"            VARCHAR2(240),
    "TRADE_LINCENSE_NO"              NUMBER,
    "TRADE_LINCENSE_NAME_VALIDITY"   DATE,
    "TRADE_LINCENSE_NO_VALIDITY"     DATE,
    "TRN"                            NUMBER,
    "ISSUER_EMIRATES"                VARCHAR2(240),
    "OWNER_DETAILS"                  VARCHAR2(240),
    "POA"                            VARCHAR2(240),
    "NUMB"                           NUMBER,
    "NAME_AND_DETAIL"                VARCHAR2(240)
);
  CREATE UNIQUE INDEX "XXPM_LEAD_U1" ON "XXPM_LEAD" ("LEAD_ID");

--------------------------------------------------------
--  DDL for Table XXPM_LEASE_AGREEMENT
--------------------------------------------------------

CREATE TABLE "XXPM_LEASE_AGREEMENT" (
    "LEASE_AGREEMENT_ID"   NUMBER,
    "FUNC_ID"              NUMBER,
    "BOOKING_ID"           NUMBER,
    "LEASE_NUMBER"         VARCHAR2(60),
    "LEASE_DATE"           DATE,
    "ORG_ID"               NUMBER,
    "TENANCY_CON_DOC_NO"   VARCHAR2(240),
    "STATUS"               VARCHAR2(60),
    "USAGE"                VARCHAR2(30),
    "DESCRIPTION"          VARCHAR2(240),
    "FLOW_STATUS"          VARCHAR2(60),
    "FLOW_LEVEL"           NUMBER,
    "FLOW_WITH"            NUMBER,
    "USER_GRP_ID"          NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_LEASE_AGREEMENT_PK" ON "XXPM_LEASE_AGREEMENT" ("LEASE_AGREEMENT_ID")

--------------------------------------------------------
--  DDL for Table XXPM_MILESTONE_DTL
--------------------------------------------------------

CREATE TABLE "XXPM_MILESTONE_DTL" (
    "MS_DTL_ID"            NUMBER,
    "MS_HDR_ID"            NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "INSTALLMENT_TYPE"     VARCHAR2(60),
    "INSTALLMENT_PCT"      NUMBER,
    "CHARGE_TYPE"          VARCHAR2(60),
    "PAYMENT_TERM"         NUMBER,
    "REMARKS"              VARCHAR2(4000),
    "DUE_DAYS"             NUMBER,
    "DUE_DAYS_FROM"        VARCHAR2(60),
    "PROJ_MS_ID"           NUMBER,
    "DUE_DATE"             DATE,
    "REVISION"             NUMBER,
    "REVISION_DATE"        DATE,
    "REVISED_BY"           VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "INSTALLMENT_METHOD"   VARCHAR2(30),
    "INSTALLMENT_EVENT"    VARCHAR2(240),
    "PERIOD_OCCURENCE"     VARCHAR2(30),
    "PERIOD_VALUES"        NUMBER,
    "PERIOD_DURATION"      VARCHAR2(30)
);
  CREATE UNIQUE INDEX "XXPM_MILESTONE_DTL_U1" ON "XXPM_MILESTONE_DTL" ("MS_DTL_ID");


--------------------------------------------------------
--  DDL for Table XXPM_MILESTONE_DTL_H
--------------------------------------------------------

CREATE TABLE "XXPM_MILESTONE_DTL_H" (
    "MS_DTL_ID_H"          NUMBER,
    "MS_DTL_ID"            NUMBER,
    "MS_HDR_ID"            NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "INSTALLMENT_TYPE"     VARCHAR2(60),
    "INSTALLMENT_PCT"      NUMBER,
    "CHARGE_TYPE"          VARCHAR2(60),
    "PAYMENT_TERM"         NUMBER,
    "REMARKS"              VARCHAR2(4000),
    "DUE_DAYS"             NUMBER,
    "DUE_DAYS_FROM"        VARCHAR2(60),
    "PROJ_MS_ID"           NUMBER,
    "DUE_DATE"             DATE,
    "REVISION"             NUMBER,
    "REVISION_DATE"        DATE,
    "REVISED_BY"           VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "INSTALLMENT_METHOD"   VARCHAR2(30),
    "INSTALLMENT_EVENT"    VARCHAR2(240),
    "PERIOD_OCCURENCE"     VARCHAR2(30),
    "PERIOD_VALUES"        NUMBER,
    "PERIOD_DURATION"      VARCHAR2(30)
);
  CREATE UNIQUE INDEX "XXPM_MILESTONE_DTL_H_PK" ON "XXPM_MILESTONE_DTL_H" ("MS_DTL_ID_H");
  
--------------------------------------------------------
--  DDL for Table XXPM_MILESTONE_HDR
--------------------------------------------------------

CREATE TABLE "XXPM_MILESTONE_HDR" (
    "MS_HDR_ID"             NUMBER,
    "MILESTONE_NAME"        VARCHAR2(240),
    "MILESTONE_NAME_TL"     VARCHAR2(240),
    "MILESTONE_NUMBER"      VARCHAR2(60),
    "MILESTONE_SHORTCODE"   VARCHAR2(60),
    "MILESTONE_DATE"        DATE,
    "FUNC_ID"               NUMBER,
    "ORG_ID"                NUMBER,
    "PROJECT_ID"            NUMBER,
    "MILESTONE_TYPE"        VARCHAR2(30),
    "USAGE"                 VARCHAR2(30),
    "REVISION_NO"           NUMBER,
    "REVISION_DATE"         DATE,
    "REVISED_BY"            VARCHAR2(60),
    "DESCRIPTION"           VARCHAR2(4000),
    "START_DATE"            DATE,
    "END_DATE"              DATE,
    "ACTIVE_YN"             VARCHAR2(1),
    "STATUS"                VARCHAR2(60),
    "FLOW_STATUS"           VARCHAR2(60),
    "FLOW_LEVEL"            NUMBER,
    "FLOW_WITH"             NUMBER,
    "USER_GRP_ID"           NUMBER,
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_MILESTONE_HDR_U1" ON "XXPM_MILESTONE_HDR" ("MS_HDR_ID");


--------------------------------------------------------
--  DDL for Table XXPM_MILESTONE_HDR_H
--------------------------------------------------------

CREATE TABLE "XXPM_MILESTONE_HDR_H" (
    "MS_HDR_ID_H"           NUMBER,
    "MS_HDR_ID"             NUMBER,
    "MILESTONE_NAME"        VARCHAR2(240),
    "MILESTONE_NAME_TL"     VARCHAR2(240),
    "MILESTONE_NUMBER"      VARCHAR2(60),
    "MILESTONE_SHORTCODE"   VARCHAR2(60),
    "MILESTONE_DATE"        DATE,
    "FUNC_ID"               NUMBER,
    "ORG_ID"                NUMBER,
    "PROJECT_ID"            NUMBER,
    "MILESTONE_TYPE"        VARCHAR2(30),
    "USAGE"                 VARCHAR2(30),
    "REVISION_NO"           NUMBER,
    "REVISION_DATE"         DATE,
    "REVISED_BY"            VARCHAR2(60),
    "DESCRIPTION"           VARCHAR2(4000),
    "START_DATE"            DATE,
    "END_DATE"              DATE,
    "ACTIVE_YN"             VARCHAR2(1),
    "STATUS"                VARCHAR2(60),
    "FLOW_STATUS"           VARCHAR2(60),
    "FLOW_LEVEL"            NUMBER,
    "FLOW_WITH"             NUMBER,
    "USER_GRP_ID"           NUMBER,
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_MILESTONE_HDR_H_PK" ON "XXPM_MILESTONE_HDR_H" ("MS_HDR_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_MODIFIERS
--------------------------------------------------------

CREATE TABLE "XXPM_MODIFIERS" (
    "MOD_ID"              NUMBER,
    "MOD_NAME"            VARCHAR2(60),
    "MOD_NAME_TL"         VARCHAR2(60),
    "MOD_LEVEL"           VARCHAR2(60),
    "MOD_CATEGORY"        VARCHAR2(60),
    "CHARGE_TYPE"         VARCHAR2(60),
    "MOD_TYPE"            VARCHAR2(60),
    "MOD_VALUE"           NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "DESCRIPTION"         VARCHAR2(4000),
    "ACTIVE_YN"           VARCHAR2(1),
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_MODIFIERS_PK" ON "XXPM_MODIFIERS" ("MOD_ID");

--------------------------------------------------------
--  DDL for Table XXPM_MOVE_IN_OUT
--------------------------------------------------------

CREATE TABLE "XXPM_MOVE_IN_OUT" (
    "MOVE_IO_ID"           NUMBER,
    "FUNC_ID"              NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "MOVE_IO_NUMBER"       VARCHAR2(60),
    "MOVE_IO_DATE"         DATE,
    "USAGE"                VARCHAR2(30),
    "RESOURCE_NAME"        VARCHAR2(60),
    "IO_FLAG"              VARCHAR2(1),
    "STATUS"               VARCHAR2(60),
    "DESCRIPTION"          VARCHAR2(240),
    "ORG_ID"               NUMBER,
    "USER_GRP_ID"          NUMBER,
    "FLOW_STATUS"          VARCHAR2(60),
    "FLOW_LEVEL"           NUMBER,
    "FLOW_WITH"            NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "BLDG_COMPL_YN"        VARCHAR2(1),
    "BLDG_COMPL_DATE"      DATE,
    "CERT_RECEIVED"        VARCHAR2(1),
    "CERT_NUMBER"          VARCHAR2(30),
    "CERT_DATE"            DATE,
    "HANDOVER_TYPE"        VARCHAR2(30)
);
CREATE UNIQUE INDEX "XXPM_MOVE_IN_OUT_PK" ON "XXPM_MOVE_IN_OUT" ("MOVE_IO_ID");

--------------------------------------------------------
--  DDL for Table XXPM_MOVE_IO_CUST_VISIT
--------------------------------------------------------

CREATE TABLE "XXPM_MOVE_IO_CUST_VISIT" (
    "VISIT_ID"             NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "MOVE_IO_ID"           NUMBER,
    "ACCEPT_FLAG"          VARCHAR2(1),
    "VISIT_DATE"           DATE,
    "ASSISTED_BY"          NUMBER,
    "DESCRIPTION"          VARCHAR2(240),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_MOVE_IO_CUST_VISIT_PK" ON "XXPM_MOVE_IO_CUST_VISIT" ("VISIT_ID");
--------------------------------------------------------
--  DDL for Table XXPM_MOVE_IO_FIXTURES
--------------------------------------------------------

CREATE TABLE "XXPM_MOVE_IO_FIXTURES" (
    "FIXTURES_ID"          NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "MOVE_IO_ID"           NUMBER,
    "FIX_CATEGORY"         VARCHAR2(60),
    "FIX_CONDITION"        VARCHAR2(60),
    "UOM"                  VARCHAR2(60),
    "QTY"                  NUMBER,
    "RATE"                 NUMBER,
    "VALUE"                NUMBER,
    "DESCRIPTION"          VARCHAR2(240),
    "STATUS"               VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_MOVE_IO_FIXTURES_PK" ON "XXPM_MOVE_IO_FIXTURES" ("FIXTURES_ID");

--------------------------------------------------------
--  DDL for Table XXPM_MOVE_IO_KEYS
--------------------------------------------------------

CREATE TABLE "XXPM_MOVE_IO_KEYS" (
    "KEY_ID"               NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "MOVE_IO_ID"           NUMBER,
    "KEY_CODE"             VARCHAR2(60),
    "KEY_QTY"              NUMBER,
    "DESCRIPTION"          VARCHAR2(240),
    "STATUS"               VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "ASSISTED_BY"          NUMBER
);
  CREATE UNIQUE INDEX "XXPM_MOVE_IO_KEYS_PK" ON "XXPM_MOVE_IO_KEYS" ("KEY_ID");

--------------------------------------------------------
--  DDL for Table XXPM_MOVE_IO_METERS
--------------------------------------------------------

CREATE TABLE "XXPM_MOVE_IO_METERS" (
    "METER_ID"             NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "MOVE_IO_ID"           NUMBER,
    "METER_CODE"           VARCHAR2(60),
    "METER_VALUE"          NUMBER,
    "DESCRIPTION"          VARCHAR2(240),
    "STATUS"               VARCHAR2(60),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "ASSISTED_BY"          NUMBER
);
  CREATE UNIQUE INDEX "XXPM_MOVE_IO_METERS_PK" ON "XXPM_MOVE_IO_METERS" ("METER_ID");

--------------------------------------------------------
--  DDL for Table XXPM_OFFER_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_OFFER_DETAIL" (
    "OFFER_DTL_ID"         NUMBER,
    "OFFER_HDR_ID"         NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILDING_ID"          NUMBER,
    "UNIT_ID"              NUMBER,
    "UOM"                  VARCHAR2(60),
    "QUANTITY"             NUMBER,
    "BASE_RATE"            NUMBER,
    "OFFER_AMOUNT"         NUMBER,
    "PL_MOD_ID"            NUMBER,
    "DISC_PCT"             NUMBER,
    "DISC_AMOUNT"          NUMBER,
    "TAX_CODE"             VARCHAR2(60),
    "TAX_RATE"             NUMBER,
    "TAX_AMOUNT"           NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE INDEX "XXPM_OFFER_DETAIL_N1" ON "XXPM_OFFER_DETAIL" ("OFFER_HDR_ID");

  CREATE UNIQUE INDEX "XXPM_OFFER_DETAIL_U1" ON "XXPM_OFFER_DETAIL" ("OFFER_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_OFFER_DETAIL_H
--------------------------------------------------------

CREATE TABLE "XXPM_OFFER_DETAIL_H" (
    "OFFER_DTL_ID_H"       NUMBER,
    "OFFER_DTL_ID"         NUMBER,
    "OFFER_HDR_ID"         NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILDING_ID"          NUMBER,
    "UNIT_ID"              NUMBER,
    "UOM"                  VARCHAR2(60),
    "QUANTITY"             NUMBER,
    "BASE_RATE"            NUMBER,
    "OFFER_AMOUNT"         NUMBER,
    "PL_MOD_ID"            NUMBER,
    "DISC_PCT"             NUMBER,
    "DISC_AMOUNT"          NUMBER,
    "TAX_CODE"             VARCHAR2(60),
    "TAX_RATE"             NUMBER,
    "TAX_AMOUNT"           NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_OFFER_DETAIL_H_PK" ON "XXPM_OFFER_DETAIL_H" ("OFFER_DTL_ID_H");


--------------------------------------------------------
--  DDL for Table XXPM_OFFER_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_OFFER_HEADER" (
    "OFFER_HDR_ID"             NUMBER,
    "ORG_ID"                   NUMBER,
    "FUNC_ID"                  NUMBER,
    "OFFER_NUMBER"             VARCHAR2(60),
    "OFFER_DATE"               DATE,
    "OFFER_FROM_DATE"          DATE,
    "OFFER_TO_DATE"            DATE,
    "PERFORMED_BY"             NUMBER,
    "REVISION_NO"              NUMBER,
    "REVISION_DATE"            DATE,
    "REVISED_BY"               VARCHAR2(60),
    "MS_HDR_ID"                NUMBER,
    "PL_ID"                    NUMBER,
    "OFFER_TYPE"               VARCHAR2(60),
    "LEAD_ID"                  NUMBER,
    "CUSTOMER_ID"              NUMBER,
    "CUST_SITE_ID"             NUMBER,
    "CUSTOMER_NAME"            VARCHAR2(250),
    "CUSTOMER_PHONE_NO"        VARCHAR2(250),
    "CUSTOMER_COUNTRY"         VARCHAR2(250),
    "SALESMAN_ID"              NUMBER,
    "CURRENCY_CODE"            VARCHAR2(3),
    "CHECKLIST"                VARCHAR2(250),
    "TERMS_DESC"               VARCHAR2(2000),
    "OBJECT_VERSION_NUMBER"    NUMBER,
    "OFFER_FLAG"               VARCHAR2(60),
    "TAX_CODE"                 VARCHAR2(60),
    "PREV_BOOKING_ID"          NUMBER,
    "STATUS"                   VARCHAR2(60),
    "DESCRIPTION"              VARCHAR2(240),
    "FLOW_STATUS"              VARCHAR2(60),
    "FLOW_LEVEL"               NUMBER,
    "FLOW_WITH"                NUMBER,
    "USER_GRP_ID"              NUMBER,
    "ATTRIBUTE_CATEGORY"       VARCHAR2(240),
    "ATTRIBUTE1"               VARCHAR2(240),
    "ATTRIBUTE2"               VARCHAR2(240),
    "ATTRIBUTE3"               VARCHAR2(240),
    "ATTRIBUTE4"               VARCHAR2(240),
    "ATTRIBUTE5"               VARCHAR2(240),
    "ATTRIBUTE6"               VARCHAR2(240),
    "ATTRIBUTE7"               VARCHAR2(240),
    "ATTRIBUTE8"               VARCHAR2(240),
    "ATTRIBUTE9"               VARCHAR2(240),
    "ATTRIBUTE10"              VARCHAR2(240),
    "CREATED_BY"               VARCHAR2(60),
    "CREATION_DATE"            TIMESTAMP(6),
    "LAST_UPDATED_BY"          VARCHAR2(60),
    "LAST_UPDATE_DATE"         TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"        VARCHAR2(150),
    "OFFER_END_DATE"           DATE,
    "USAGE"                    VARCHAR2(30),
    "LEAD_SOURCE_CHANNEL"      VARCHAR2(240),
    "LEAD_SOURCE_NAME"         VARCHAR2(240),
    "VEND_ID"                  NUMBER,
    "VEND_SITE_ID"             NUMBER,
    "VEND_CONTRACT_NO"         VARCHAR2(240),
    "PROPERTY_ID"              NUMBER,
    "EMAIL_ID"                 VARCHAR2(60),
    "LEASE_AGREEMENT_ID"       NUMBER,
    "CAR_PARK_LEASE_AGRE_ID"   NUMBER,
    "CUST_ACCEPT"              VARCHAR2(1),
    "MIGRATED_DATA"            VARCHAR2(5),
    "AGENCY_NAME"              VARCHAR2(300),
    "SALES_MANAGER_NAME"       VARCHAR2(300),
    "AGENT_COMMISSION"         NUMBER,
    "AGENT_NAME"               VARCHAR2(300),
    "AGENT_COMMISSION_PERC"    NUMBER
);
  CREATE UNIQUE INDEX "XXPM_OFFER_HEADER_U1" ON "XXPM_OFFER_HEADER" ("OFFER_HDR_ID");


--------------------------------------------------------
--  DDL for Table XXPM_OFFER_HEADER_H
--------------------------------------------------------

CREATE TABLE "XXPM_OFFER_HEADER_H" (
    "OFFER_HDR_ID_H"          NUMBER,
    "OFFER_HDR_ID"            NUMBER,
    "ORG_ID"                  NUMBER,
    "FUNC_ID"                 NUMBER,
    "OFFER_NUMBER"            VARCHAR2(60),
    "OFFER_DATE"              DATE,
    "OFFER_END_DATE"          DATE,
    "OFFER_FROM_DATE"         DATE,
    "OFFER_TO_DATE"           DATE,
    "USAGE"                   VARCHAR2(30),
    "PERFORMED_BY"            NUMBER,
    "REVISION_NO"             NUMBER,
    "REVISION_DATE"           DATE,
    "REVISED_BY"              VARCHAR2(60),
    "MS_HDR_ID"               NUMBER,
    "PL_ID"                   NUMBER,
    "OFFER_TYPE"              VARCHAR2(60),
    "LEAD_ID"                 NUMBER,
    "CUSTOMER_ID"             NUMBER,
    "CUST_SITE_ID"            NUMBER,
    "CUSTOMER_NAME"           VARCHAR2(250),
    "CUSTOMER_PHONE_NO"       VARCHAR2(250),
    "CUSTOMER_COUNTRY"        VARCHAR2(250),
    "SALESMAN_ID"             NUMBER,
    "CURRENCY_CODE"           VARCHAR2(3),
    "CHECKLIST"               VARCHAR2(250),
    "TERMS_DESC"              VARCHAR2(2000),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "OFFER_FLAG"              VARCHAR2(60),
    "TAX_CODE"                VARCHAR2(60),
    "PREV_BOOKING_ID"         NUMBER,
    "LEAD_SOURCE_CHANNEL"     VARCHAR2(240),
    "LEAD_SOURCE_NAME"        VARCHAR2(240),
    "VEND_ID"                 NUMBER,
    "VEND_SITE_ID"            NUMBER,
    "VEND_CONTRACT_NO"        VARCHAR2(240),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "USER_GRP_ID"             NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_OFFER_HEADER_H_PK" ON "XXPM_OFFER_HEADER_H" ("OFFER_HDR_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_OFFER_MILESTONE_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_OFFER_MILESTONE_DETAIL" (
    "OFFER_MS_DTL_ID"      NUMBER,
    "OFFER_HDR_ID"         NUMBER,
    "MS_DTL_ID"            NUMBER,
    "PL_MOD_ID"            NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "INSTALLMENT_TYPE"     VARCHAR2(60),
    "INSTALLMENT_PCT"      NUMBER,
    "INSTALLMENT_AMOUNT"   NUMBER,
    "CHARGE_TYPE"          VARCHAR2(60),
    "PAYMENT_TERM"         VARCHAR2(60),
    "REMARKS"              VARCHAR2(4000),
    "DUE_DAYS"             NUMBER,
    "DUE_DAYS_FROM"        VARCHAR2(60),
    "DUE_DATE"             DATE,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "MILESTONE_TYPE"       VARCHAR2(60),
    "UOM"                  VARCHAR2(30),
    "QUANTITY"             NUMBER,
    "RATE"                 NUMBER,
    "WAVE_OFF"             VARCHAR2(30),
    "INSTALLMENT_METHOD"   VARCHAR2(30),
    "INSTALLMENT_EVENT"    VARCHAR2(240),
    "PERIOD_OCCURENCE"     VARCHAR2(30),
    "PERIOD_VALUES"        NUMBER,
    "PERIOD_DURATION"      VARCHAR2(30),
    "INCLUDED_IN_RATE"     VARCHAR2(30),
    "TAX_RATE"             NUMBER,
    "TAX_CODE"             VARCHAR2(60),
    "TAX_AMOUNT"           NUMBER,
    "CARPARKING"           VARCHAR2(200)
);


  CREATE INDEX "XXPM_OFFER_MILESTONE_DETAIL_N1" ON "XXPM_OFFER_MILESTONE_DETAIL" ("OFFER_HDR_ID");

  CREATE UNIQUE INDEX "XXPM_OFFER_MILESTONE_DETAIL_U1" ON "XXPM_OFFER_MILESTONE_DETAIL" ("OFFER_MS_DTL_ID");
--------------------------------------------------------
--  DDL for Table XXPM_OFFER_MILESTONE_DETAIL_H
--------------------------------------------------------

CREATE TABLE "XXPM_OFFER_MILESTONE_DETAIL_H" (
    "OFFER_MS_DTL_ID_H"    NUMBER,
    "OFFER_MS_DTL_ID"      NUMBER,
    "OFFER_HDR_ID"         NUMBER,
    "MS_DTL_ID"            NUMBER,
    "PL_MOD_ID"            NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "INSTALLMENT_TYPE"     VARCHAR2(60),
    "INSTALLMENT_PCT"      NUMBER,
    "INSTALLMENT_AMOUNT"   NUMBER,
    "MILESTONE_TYPE"       VARCHAR2(60),
    "UOM"                  VARCHAR2(30),
    "QUANTITY"             NUMBER,
    "RATE"                 NUMBER,
    "WAVE_OFF"             VARCHAR2(30),
    "INSTALLMENT_METHOD"   VARCHAR2(30),
    "INSTALLMENT_EVENT"    VARCHAR2(30),
    "PERIOD_OCCURENCE"     VARCHAR2(30),
    "PERIOD_VALUES"        NUMBER,
    "PERIOD_DURATION"      VARCHAR2(30),
    "CHARGE_TYPE"          VARCHAR2(60),
    "PAYMENT_TERM"         VARCHAR2(60),
    "REMARKS"              VARCHAR2(4000),
    "DUE_DAYS"             NUMBER,
    "DUE_DAYS_FROM"        VARCHAR2(60),
    "DUE_DATE"             DATE,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
CREATE UNIQUE INDEX "XXPM_OFFER_MILESTONE_DTL_H_PK" ON "XXPM_OFFER_MILESTONE_DETAIL_H" ("OFFER_MS_DTL_ID_H");


--------------------------------------------------------
--  DDL for Table XXPM_ORG_ASSIGNMENT
--------------------------------------------------------

CREATE TABLE "XXPM_ORG_ASSIGNMENT" (
    "ORG_ASSIGN_ID"          NUMBER,
    "PROPERTY_ID"            NUMBER,
    "BUILD_ID"               NUMBER,
    "UNIT_ID"                NUMBER,
    "ORG_ID"                 NUMBER,
    "SALABLE"                VARCHAR2(1),
    "LEASEABLE"              VARCHAR2(1),
    "SUB_LEASEABLE"          VARCHAR2(1),
    "COMMISION_ONLY_LEASE"   VARCHAR2(1),
    "START_DATE"             DATE,
    "END_DATE"               DATE,
    "ACTIVE_YN"              VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"     VARCHAR2(240),
    "ATTRIBUTE1"             VARCHAR2(240),
    "ATTRIBUTE2"             VARCHAR2(240),
    "ATTRIBUTE3"             VARCHAR2(240),
    "ATTRIBUTE4"             VARCHAR2(240),
    "ATTRIBUTE5"             VARCHAR2(240),
    "ATTRIBUTE6"             VARCHAR2(240),
    "ATTRIBUTE7"             VARCHAR2(240),
    "ATTRIBUTE8"             VARCHAR2(240),
    "ATTRIBUTE9"             VARCHAR2(240),
    "ATTRIBUTE10"            VARCHAR2(240),
    "CREATED_BY"             VARCHAR2(60),
    "CREATION_DATE"          TIMESTAMP(6),
    "LAST_UPDATED_BY"        VARCHAR2(60),
    "LAST_UPDATE_DATE"       TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"      VARCHAR2(150)
);
  CREATE unique index "SYS_C0063917" ON "XXPM_ORG_ASSIGNMENT" ( "ORG_ASSIGN_ID" );

--------------------------------------------------------
--  DDL for Table XXPM_PL_DISCOUNTS
--------------------------------------------------------

CREATE TABLE "XXPM_PL_DISCOUNTS" (
    "DISCOUNT_ID"         NUMBER,
    "DISCOUNT_NAME"       VARCHAR2(30),
    "DISCOUNT_LEVEL"      VARCHAR2(30),
    "DISCOUNT_TYPE"       VARCHAR2(30),
    "DISCOUNT_VALUE"      NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_DISCOUNTS_PK" ON "XXPM_PL_DISCOUNTS" ("DISCOUNT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PL_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_PL_HEADER" (
    "PL_ID"               NUMBER,
    "PL_NAME"             VARCHAR2(60),
    "PL_NAME_TL"          VARCHAR2(60),
    "DESCRIPTION"         VARCHAR2(2000),
    "ORG_ID"              NUMBER,
    "FUNC_ID"             NUMBER,
    "PL_TYPE"             VARCHAR2(60),
    "PRIORITY"            NUMBER,
    "USAGE"               VARCHAR2(30),
    "CURRENCY_CODE"       VARCHAR2(3),
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "STATUS"              VARCHAR2(30),
    "FLOW_STATUS"         VARCHAR2(30),
    "FLOW_WITH"           NUMBER,
    "FLOW_LEVEL"          NUMBER,
    "USER_GRP_ID"         NUMBER,
    "BASE_PRICE_YN"       VARCHAR2(1),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "PL_NUMBER"           VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_PL_HEADER_U1" ON "XXPM_PL_HEADER" ("PL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PL_HEADER_H
--------------------------------------------------------

CREATE TABLE "XXPM_PL_HEADER_H" (
    "PL_ID_H"             NUMBER,
    "PL_ID"               NUMBER,
    "PL_NAME"             VARCHAR2(60),
    "PL_NAME_TL"          VARCHAR2(60),
    "DESCRIPTION"         VARCHAR2(2000),
    "ORG_ID"              NUMBER,
    "FUNC_ID"             NUMBER,
    "PL_TYPE"             VARCHAR2(60),
    "PRIORITY"            NUMBER,
    "USAGE"               VARCHAR2(30),
    "CURRENCY_CODE"       VARCHAR2(3),
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "STATUS"              VARCHAR2(30),
    "FLOW_STATUS"         VARCHAR2(30),
    "FLOW_WITH"           NUMBER,
    "FLOW_LEVEL"          NUMBER,
    "USER_GRP_ID"         NUMBER,
    "BASE_PRICE_YN"       VARCHAR2(1),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "PL_NUMBER"           VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_PL_HEADER_H_PK" ON "XXPM_PL_HEADER_H" ("PL_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_PL_LINES
--------------------------------------------------------

CREATE TABLE "XXPM_PL_LINES" (
    "PLL_ID"              NUMBER,
    "PL_ID"               NUMBER,
    "PROPERTY_ID"         NUMBER,
    "BUILD_ID"            NUMBER,
    "UNIT_ID"             NUMBER,
    "UOM"                 VARCHAR2(5),
    "BASE_PRICE"          NUMBER,
    "MIN_PRICE"           NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_LINES_PK" ON "XXPM_PL_LINES" ("PLL_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PL_LINES_H
--------------------------------------------------------

CREATE TABLE "XXPM_PL_LINES_H" (
    "PLL_ID_H"            NUMBER,
    "PLL_ID"              NUMBER,
    "PL_ID"               NUMBER,
    "PROPERTY_ID"         NUMBER,
    "BUILD_ID"            NUMBER,
    "UNIT_ID"             NUMBER,
    "UOM"                 VARCHAR2(5),
    "BASE_PRICE"          NUMBER,
    "MIN_PRICE"           NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_LINES_H_PK" ON "XXPM_PL_LINES_H" ("PLL_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_PL_MODIFIERS
--------------------------------------------------------

CREATE TABLE "XXPM_PL_MODIFIERS" (
    "PL_MOD_ID"           NUMBER,
    "PL_ID"               NUMBER,
    "MOD_ID"              NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_MODIFIERS_PK" ON "XXPM_PL_MODIFIERS" ("PL_MOD_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PL_MODIFIERS_H
--------------------------------------------------------

CREATE TABLE "XXPM_PL_MODIFIERS_H" (
    "PL_MOD_ID_H"         NUMBER,
    "PL_MOD_ID"           NUMBER,
    "PL_ID"               NUMBER,
    "MOD_ID"              NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_MODIFIERS_H_PK" ON "XXPM_PL_MODIFIERS_H" ("PL_MOD_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_PL_QUALIFIERS
--------------------------------------------------------

CREATE TABLE "XXPM_PL_QUALIFIERS" (
    "PL_QLFY_ID"          NUMBER,
    "PL_MOD_ID"           NUMBER,
    "QLFY_ID"             NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_QUALIFIERS_PK" ON "XXPM_PL_QUALIFIERS" ("PL_QLFY_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PL_QUALIFIERS_H
--------------------------------------------------------

CREATE TABLE "XXPM_PL_QUALIFIERS_H" (
    "PL_QLFY_ID_H"        NUMBER,
    "PL_QLFY_ID"          NUMBER,
    "PL_MOD_ID"           NUMBER,
    "QLFY_ID"             NUMBER,
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PL_QUALIFIERS_H_PK" ON "XXPM_PL_QUALIFIERS_H" ("PL_QLFY_ID_H");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_AREA
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_AREA" (
    "AREA_ID"              NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILD_ID"             NUMBER,
    "UNIT_ID"              NUMBER,
    "AREA"                 VARCHAR2(60),
    "UOM"                  VARCHAR2(60),
    "VALUE"                NUMBER,
    "DESCRIPTION"          VARCHAR2(4000),
    "ACTIVE_YN"            VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE INDEX "XXPM_PROPERTY_AREA_N1" ON "XXPM_PROPERTY_AREA" ("PROPERTY_ID", "BUILD_ID", "UNIT_ID", "AREA");

  CREATE UNIQUE INDEX "XXPM_PROPERTY_AREA_U1" ON "XXPM_PROPERTY_AREA" ("AREA_ID");


--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_BUILDINGS
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_BUILDINGS" (
    "BUILD_ID"             NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILD_NAME"           VARCHAR2(240),
    "BUILD_NAME_TL"        VARCHAR2(240),
    "BUILD_NUMBER"         VARCHAR2(60),
    "BUILD_SHORTCODE"      VARCHAR2(60),
    "PARENT_UNIT_ID"       NUMBER,
    "BUILD_TYPE"           VARCHAR2(60),
    "BUILD_CLASS"          VARCHAR2(60),
    "BUILD_CATEGORY"       VARCHAR2(60),
    "VEND_ID"              NUMBER,
    "DESCRIPTION"          VARCHAR2(4000),
    "ACTIVE_YN"            VARCHAR2(1),
    "FUNC_ID"              NUMBER,
    "VAT_TYPE"             VARCHAR2(250),
    "VAT_PERC"             NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "LOCATION_ID"          NUMBER,
    "SALEABLE_YN"          VARCHAR2(1),
    "LEASEABLE_YN"         VARCHAR2(1),
    "SALE_AVAILABLE_YN"    VARCHAR2(1),
    "LEASE_AVAILABLE_YN"   VARCHAR2(1),
    "FREE_HOLD_YN"         VARCHAR2(1),
    "LEASE_HOLD_YN"        VARCHAR2(1),
    "LIST_FOR_BROKERS"     VARCHAR2(1),
    "LIST_FOR_INTERNAL"    VARCHAR2(1),
    "NO_OF_FLOORS"         NUMBER
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_BUILDINGS_PK" ON "XXPM_PROPERTY_BUILDINGS" ("BUILD_ID");
--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_CARPARKS
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_CARPARKS" (
    "CARPARK_ID"           NUMBER,
    "UNIT_ID"              NUMBER,
    "CP_UNIT_ID"           NUMBER,
    "ALLOT_TYPE"           VARCHAR2(30),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_CARPARKS_PK" ON "XXPM_PROPERTY_CARPARKS" ("CARPARK_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_CONTACTS
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_CONTACTS" (
    "CONTACT_ID"           NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILD_ID"             NUMBER,
    "UNIT_ID"              NUMBER,
    "CONTACT_TYPE"         VARCHAR2(60),
    "VEND_ID"              NUMBER,
    "VEND_SITE_ID"         NUMBER,
    "CONTACT_NUMBER"       VARCHAR2(60),
    "ACTIVE_YN"            VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "EMP_ID"               NUMBER
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_CONTACTS_PK" ON "XXPM_PROPERTY_CONTACTS" ("CONTACT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_ESCROW
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_ESCROW" (
    "ESCROW_ID"            NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BANK_ACNT_ID"         NUMBER,
    "ACTIVE_YN"            VARCHAR2(1),
    "INACTIVE_ON"          DATE,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "BUILD_ID"             NUMBER,
    "FAVOURING"            VARCHAR2(240),
    "REMARKS"              VARCHAR2(2000)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_ESCROW_PK" ON "XXPM_PROPERTY_ESCROW" ("ESCROW_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_FEATURES
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_FEATURES" (
    "FEATURE_ID"           NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILD_ID"             NUMBER,
    "UNIT_ID"              NUMBER,
    "FEATURE_TYPE"         VARCHAR2(60),
    "DESCRIPTION"          VARCHAR2(4000),
    "FEATURE_CONDITION"    VARCHAR2(60),
    "UOM"                  VARCHAR2(60),
    "VALUE"                NUMBER,
    "ACTIVE_YN"            VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "QUANTITY"             NUMBER,
    "RATE"                 NUMBER
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_FEATURES_PK" ON "XXPM_PROPERTY_FEATURES" ("FEATURE_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_FIX_FITTINGS
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_FIX_FITTINGS" (
    "FIX_ID"               NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILD_ID"             NUMBER,
    "UNIT_ID"              NUMBER,
    "FIX_CATEGORY"         VARCHAR2(60),
    "DESCRIPTION"          VARCHAR2(4000),
    "FIX_CONDITION"        VARCHAR2(60),
    "UOM"                  VARCHAR2(60),
    "VALUE"                NUMBER,
    "ACTIVE_YN"            VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "QUANTITY"             NUMBER,
    "RATE"                 NUMBER,
    "CARPARKING"           VARCHAR2(200)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_FIX_FITTINGS_PK" ON "XXPM_PROPERTY_FIX_FITTINGS" ("FIX_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_MASTER
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_MASTER" (
    "PROPERTY_ID"          NUMBER,
    "PROPERTY_NAME"        VARCHAR2(240),
    "PROPERTY_NAME_TL"     VARCHAR2(240),
    "PROPERTY_NUMBER"      VARCHAR2(60),
    "PROPERTY_SHORTCODE"   VARCHAR2(60),
    "FUNC_ID"              NUMBER,
    "ORG_ID"               NUMBER,
    "PROJECT_ID"           NUMBER,
    "COST_CENTER_CODE"     VARCHAR2(60),
    "LOCATION_ID"          NUMBER,
    "PARCEL_TYPE"          VARCHAR2(240),
    "PROPERTY_TYPE"        VARCHAR2(60),
    "NO_OF_UNITS"          NUMBER,
    "PARENT_PROPERTY_ID"   NUMBER,
    "PROPERTY_CLASS"       VARCHAR2(60),
    "PROPERTY_CATEGORY"    VARCHAR2(60),
    "VEND_ID"              NUMBER,
    "DESCRIPTION"          VARCHAR2(4000),
    "ACTIVE_YN"            VARCHAR2(1),
    "SALEABLE_YN"          VARCHAR2(1),
    "LEASEABLE_YN"         VARCHAR2(1),
    "SALE_AVAILABLE_YN"    VARCHAR2(1),
    "LEASE_AVAILABLE_YN"   VARCHAR2(1),
    "FREE_HOLD_YN"         VARCHAR2(1),
    "LEASE_HOLD_YN"        VARCHAR2(1),
    "LIST_FOR_BROKERS"     VARCHAR2(1),
    "LIST_FOR_INTERNAL"    VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_MASTER_U1" ON "XXPM_PROPERTY_MASTER" ("PROPERTY_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_MILESTONE
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_MILESTONE" (
    "MILESTONE_ID"         NUMBER,
    "MS_HDR_ID"            NUMBER,
    "PROPERTY_ID"          NUMBER,
    "REMARKS"              VARCHAR2(4000),
    "ACTIVE_YN"            VARCHAR2(1),
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "PL_ID"                NUMBER,
    "PRIMARY_YN"           VARCHAR2(1)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_MILESTONE_PK" ON "XXPM_PROPERTY_MILESTONE" ("MILESTONE_ID")

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_MORTGAGE
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_MORTGAGE" (
    "MORT_ID"              NUMBER,
    "UNIT_ID"              NUMBER,
    "FUNC_ID"              NUMBER,
    "MORT_NUMBER"          VARCHAR2(30),
    "MORT_DATE"            DATE,
    "START_DATE"           DATE,
    "END_DATE"             DATE,
    "MORT_DESCRIPTION"     VARCHAR2(500),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "MORT_STATUS"          VARCHAR2(60),
    "MORT_AMOUNT"          NUMBER,
    "MORT_DOC_NO"          NUMBER,
    "MORT_VERIFIED_YN"     VARCHAR2(3),
    "BANK_ID"              NUMBER,
    "BRANCH_ID"            NUMBER,
    "BOOKING_HDR_ID"       NUMBER,
    "FLOW_STATUS"          VARCHAR2(60),
    "FLOW_LEVEL"           NUMBER,
    "FLOW_WITH"            NUMBER,
    "USER_GRP_ID"          NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_MORTGAGE_PK" ON "XXPM_PROPERTY_MORTGAGE" ("MORT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_ORG
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_ORG" (
    "PROP_ORG_ID"         NUMBER,
    "PROPERTY_ID"         NUMBER,
    "UNIT_ID"             NUMBER,
    "ORG_ID"              NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "INACTIVE_ON"         DATE,
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_ORG_PK" ON "XXPM_PROPERTY_ORG" ("PROP_ORG_ID");

--------------------------------------------------------
--  DDL for Table XXPM_PROPERTY_UNITS
--------------------------------------------------------

CREATE TABLE "XXPM_PROPERTY_UNITS" (
    "UNIT_ID"               NUMBER,
    "PROPERTY_ID"           NUMBER,
    "BUILD_ID"              NUMBER,
    "UNIT_NAME"             VARCHAR2(240),
    "UNIT_NAME_TL"          VARCHAR2(240),
    "UNIT_NUMBER"           VARCHAR2(60),
    "UNIT_SHORTCODE"        VARCHAR2(60),
    "FUNC_ID"               NUMBER,
    "ORG_ID"                NUMBER,
    "PARENT_UNIT_ID"        NUMBER,
    "DOC_REF_NUMBER_1"      VARCHAR2(60),
    "DOC_REF_NUMBER_2"      VARCHAR2(60),
    "DOC_REF_NUMBER_3"      VARCHAR2(60),
    "FLOOR_NUMBER"          VARCHAR2(60),
    "NO_OF_ROOMS"           NUMBER,
    "UNIT_TYPE"             VARCHAR2(60),
    "AREA_TYPE"             VARCHAR2(60),
    "VIEW_TYPE"             VARCHAR2(60),
    "CHARGEABLE_AREA"       NUMBER,
    "UOM"                   VARCHAR2(60),
    "CURRENCY_CODE"         VARCHAR2(3),
    "BASE_RATE"             NUMBER,
    "PREMIUM_RATE_1"        NUMBER,
    "PREMIUM_RATE_TYPE_1"   VARCHAR2(60),
    "PREMIUM_RATE_2"        NUMBER,
    "PREMIUM_RATE_TYPE_2"   VARCHAR2(60),
    "PREMIUM_RATE_3"        NUMBER,
    "PREMIUM_RATE_TYPE_3"   VARCHAR2(60),
    "PREMIUM_RATE_4"        NUMBER,
    "PREMIUM_RATE_TYPE_4"   VARCHAR2(60),
    "PREMIUM_RATE_5"        NUMBER,
    "PREMIUM_RATE_TYPE_5"   VARCHAR2(60),
    "TOTAL_RATE"            NUMBER,
    "PURCHASE_AMOUNT"       NUMBER,
    "STATUS"                VARCHAR2(60),
    "UNIT_CLASS"            VARCHAR2(60),
    "UNIT_CATEGORY"         VARCHAR2(60),
    "VEND_ID"               NUMBER(22, 0),
    "DESCRIPTION"           VARCHAR2(4000),
    "ACTIVE_YN"             VARCHAR2(1),
    "VAT_TYPE"              VARCHAR2(250),
    "VAT_PERC"              NUMBER,
    "VAT_AMOUNT"            NUMBER,
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150),
    "SALEABLE_YN"           VARCHAR2(1),
    "LEASEABLE_YN"          VARCHAR2(1),
    "SALE_AVAILABLE_YN"     VARCHAR2(1),
    "LEASE_AVAILABLE_YN"    VARCHAR2(1),
    "FREE_HOLD_YN"          VARCHAR2(1),
    "LEASE_HOLD_YN"         VARCHAR2(1),
    "LIST_FOR_BROKERS"      VARCHAR2(1),
    "LIST_FOR_INTERNAL"     VARCHAR2(1),
    "ALLOT_TYPE"            VARCHAR2(30)
);
  CREATE UNIQUE INDEX "XXPM_PROPERTY_UNITS_U1" ON "XXPM_PROPERTY_UNITS" ("UNIT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_QUALIFIERS
--------------------------------------------------------

CREATE TABLE "XXPM_QUALIFIERS" (
    "QLFY_ID"             NUMBER,
    "QUALIFIERS"          VARCHAR2(60),
    "OPERATOR"            VARCHAR2(60),
    "QUALIFIER_FROM"      VARCHAR2(240),
    "QUALIFIER_TO"        VARCHAR2(240),
    "START_DATE"          DATE,
    "END_DATE"            DATE,
    "DESCRIPTION"         VARCHAR2(4000),
    "ACTIVE_YN"           VARCHAR2(1),
    "REVISION_NO"         NUMBER,
    "REVISION_DATE"       DATE,
    "REVISED_BY"          VARCHAR2(60),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_QUALIFIERS_PK" ON "XXPM_QUALIFIERS" ("QLFY_ID");

--------------------------------------------------------
--  DDL for Table XXPM_RECEIPT
--------------------------------------------------------

CREATE TABLE "XXPM_RECEIPT" (
    "RECEIPT_ID"               NUMBER,
    "FUNC_ID"                  NUMBER,
    "SOURCE_FUNC_ID"           NUMBER,
    "SOURCE_FUNC_REF_ID"       NUMBER,
    "RECEIPT_NUMBER"           VARCHAR2(30),
    "RECEIPT_DATE"             DATE,
    "ORG_ID"                   NUMBER,
    "RECEIPT_TYPE"             VARCHAR2(30),
    "PROPERTY_ID"              NUMBER,
    "UNIT_ID"                  NUMBER,
    "BUILD_ID"                 NUMBER,
    "LEAD_ID"                  NUMBER,
    "CUST_ID"                  NUMBER,
    "CUST_SITE_ID"             NUMBER,
    "SALESMAN_ID"              NUMBER,
    "CUSTOMER_NAME"            VARCHAR2(240),
    "CURRENCY_CODE"            VARCHAR2(3),
    "RECEIPT_AMOUNT"           NUMBER,
    "PAY_MODE"                 NUMBER,
    "PAY_REF_NUMBER"           VARCHAR2(30),
    "PAY_REF_DATE"             DATE,
    "BANK_NAME"                VARCHAR2(60),
    "BANK_BRANCH_NAME"         VARCHAR2(60),
    "DRAWN_BY"                 VARCHAR2(60),
    "STATUS"                   VARCHAR2(60),
    "DESCRIPTION"              VARCHAR2(4000),
    "FLOW_STATUS"              VARCHAR2(60),
    "FLOW_LEVEL"               NUMBER,
    "FLOW_WITH"                NUMBER,
    "TAX_AMOUNT"               NUMBER,
    "TAX_CODE"                 VARCHAR2(60),
    "TAX_RATE"                 NUMBER,
    "ATTRIBUTE_CATEGORY"       VARCHAR2(240),
    "ATTRIBUTE1"               VARCHAR2(240),
    "ATTRIBUTE2"               VARCHAR2(240),
    "ATTRIBUTE3"               VARCHAR2(240),
    "ATTRIBUTE4"               VARCHAR2(240),
    "ATTRIBUTE5"               VARCHAR2(240),
    "ATTRIBUTE6"               VARCHAR2(240),
    "ATTRIBUTE7"               VARCHAR2(240),
    "ATTRIBUTE8"               VARCHAR2(240),
    "ATTRIBUTE9"               VARCHAR2(240),
    "ATTRIBUTE10"              VARCHAR2(240),
    "ATTRIBUTE11"              VARCHAR2(240),
    "ATTRIBUTE12"              VARCHAR2(240),
    "ATTRIBUTE13"              VARCHAR2(240),
    "ATTRIBUTE14"              VARCHAR2(240),
    "ATTRIBUTE15"              VARCHAR2(240),
    "ATTRIBUTE16"              VARCHAR2(240),
    "ATTRIBUTE17"              VARCHAR2(240),
    "ATTRIBUTE18"              VARCHAR2(240),
    "ATTRIBUTE19"              VARCHAR2(240),
    "ATTRIBUTE20"              VARCHAR2(240),
    "CREATED_BY"               VARCHAR2(60),
    "CREATION_DATE"            TIMESTAMP(6),
    "LAST_UPDATED_BY"          VARCHAR2(60),
    "LAST_UPDATE_DATE"         TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"        VARCHAR2(150),
    "RECOMMENDED_AMOUNT"       NUMBER,
    "RECEIVED_AMOUNT"          NUMBER,
    "DIFF_IN_DAYS"             NUMBER,
    "PAY_REC_DATE"             DATE,
    "PAY_REV_DATE"             DATE,
    "RCT_TYPE"                 VARCHAR2(30),
    "RCT_DESC"                 VARCHAR2(150),
    "INTERFACE_STATUS"         VARCHAR2(60),
    "GL_DATE"                  DATE,
    "REV_DATE"                 DATE,
    "REV_GL_DATE"              DATE,
    "REV_CATEGORY"             VARCHAR2(60),
    "REV_REASON"               VARCHAR2(60),
    "REV_DESC"                 VARCHAR2(4000),
    "REV_INT_STATUS"           VARCHAR2(60),
    "RECEIPT_RISK_YN"          VARCHAR2(1),
    "INTERFACE_ERROR_MSG"      CLOB,
    "BANK_ACCOUNT_NUM"         VARCHAR2(60),
    "MODE_OF_RECEIPT"          VARCHAR2(80),
    "REMIT_BANK_ACCT_USE_ID"   NUMBER
);
  CREATE INDEX "XXPM_RECEIPT_N1" ON "XXPM_RECEIPT" ("ORG_ID", "RECEIPT_TYPE", "PROPERTY_ID", "UNIT_ID", "BUILD_ID", "CUST_ID", "CUST_SITE_ID", "CURRENCY_CODE", "PAY_MODE");

  CREATE INDEX "XXPM_RECEIPT_N2" ON "XXPM_RECEIPT" ("RECEIPT_ID", "FUNC_ID", "SOURCE_FUNC_ID", "SOURCE_FUNC_REF_ID", "INTERFACE_STATUS");

  CREATE UNIQUE INDEX "XXPM_RECEIPT_U1" ON "XXPM_RECEIPT" ("RECEIPT_ID");

--------------------------------------------------------
--  DDL for Table XXPM_RECEIPT_DETAILS
--------------------------------------------------------

CREATE TABLE "XXPM_RECEIPT_DETAILS" (
    "RECEIPT_DTL_ID"              NUMBER,
    "RECEIPT_ID"                  NUMBER,
    "BOOKING_MS_DTL_ID"           NUMBER,
    "AMOUNT_APPLIED"              NUMBER,
    "APPLIED_DATE"                TIMESTAMP(6),
    "RECEIVABLE_APPLICATION_ID"   NUMBER,
    "CUSTOMER_TRX_ID"             NUMBER,
    "ATTRIBUTE_CATEGORY"          VARCHAR2(240),
    "ATTRIBUTE1"                  VARCHAR2(240),
    "ATTRIBUTE2"                  VARCHAR2(240),
    "ATTRIBUTE3"                  VARCHAR2(240),
    "ATTRIBUTE4"                  VARCHAR2(240),
    "ATTRIBUTE5"                  VARCHAR2(240),
    "ATTRIBUTE6"                  VARCHAR2(240),
    "ATTRIBUTE7"                  VARCHAR2(240),
    "ATTRIBUTE8"                  VARCHAR2(240),
    "ATTRIBUTE9"                  VARCHAR2(240),
    "ATTRIBUTE10"                 VARCHAR2(240),
    "ATTRIBUTE11"                 VARCHAR2(240),
    "ATTRIBUTE12"                 VARCHAR2(240),
    "ATTRIBUTE13"                 VARCHAR2(240),
    "ATTRIBUTE14"                 VARCHAR2(240),
    "ATTRIBUTE15"                 VARCHAR2(240),
    "ATTRIBUTE16"                 VARCHAR2(240),
    "ATTRIBUTE17"                 VARCHAR2(240),
    "ATTRIBUTE18"                 VARCHAR2(240),
    "ATTRIBUTE19"                 VARCHAR2(240),
    "ATTRIBUTE20"                 VARCHAR2(240),
    "CREATED_BY"                  VARCHAR2(60),
    "CREATION_DATE"               TIMESTAMP(6),
    "LAST_UPDATED_BY"             VARCHAR2(60),
    "LAST_UPDATE_DATE"            TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"           VARCHAR2(150),
    "INVOICE_ID"                  NUMBER,
    "INTERFACE_STATUS"            VARCHAR2(60),
    "INTERFACE_ERROR_MSG"         CLOB
);
  CREATE INDEX "XXPM_RECEIPT_DETAILS_N1" ON "XXPM_RECEIPT_DETAILS" ("RECEIPT_ID", "INVOICE_ID");

  CREATE UNIQUE INDEX "XXPM_RECEIPT_DETAILS_U1" ON "XXPM_RECEIPT_DETAILS" ("RECEIPT_DTL_ID");


--------------------------------------------------------
--  DDL for Table XXPM_REGISTRATION
--------------------------------------------------------

CREATE TABLE "XXPM_REGISTRATION" (
    "REGN_ID"                 NUMBER,
    "FUNC_ID"                 NUMBER,
    "LEASE_AGREEMENT_ID"      NUMBER,
    "BOOKING_ID"              NUMBER,
    "REGN_NUMBER"             VARCHAR2(60),
    "REGN_DATE"               DATE,
    "TITLE_DEED_NUMBER"       VARCHAR2(60),
    "TITLE_DEED_DATE"         DATE,
    "OBJECT_VERSION_NUMBER"   VARCHAR2(60),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "ORG_ID"                  NUMBER,
    "USER_GRP_ID"             NUMBER,
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXPM_REGISTRATION_PK" ON "XXPM_REGISTRATION" ("REGN_ID");

--------------------------------------------------------
--  DDL for Table XXPM_SETUP_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_SETUP_DETAIL" (
    "SETUP_ID"                  NUMBER,
    "USER_NAME"                 VARCHAR2(60),
    "PASS_WORD"                 VARCHAR2(60),
    "HOLD_DAY"                  NUMBER,
    "ATTRIBUTE1"                VARCHAR2(240),
    "ATTRIBUTE2"                VARCHAR2(240),
    "ATTRIBUTE3"                VARCHAR2(240),
    "ATTRIBUTE4"                VARCHAR2(240),
    "ATTRIBUTE5"                VARCHAR2(240),
    "ATTRIBUTE6"                NUMBER,
    "ATTRIBUTE7"                NUMBER,
    "ATTRIBUTE8"                NUMBER,
    "ATTRIBUTE9"                DATE,
    "ATTRIBUTE10"               DATE,
    "CREATED_BY"                NUMBER,
    "CREATION_DATE"             DATE,
    "LAST_UPDATED_BY"           NUMBER,
    "LAST_UPDATE_DATE"          DATE,
    "LAST_UPDATE_LOGIN"         NUMBER,
    "INVOICE_TXN_SOURCE_NAME"   VARCHAR2(200),
    "INVOICE_TXN_SOURCE_TYPE"   VARCHAR2(200),
    "CREDIT_TXN_SOURCE_NAME"    VARCHAR2(200),
    "CREDIT_TXN_SOURCE_TYPE"    VARCHAR2(200),
    "DEBIT_TXN_SOURCE_NAME"     VARCHAR2(200),
    "DEBIT_TXN_SOURCE_TYPE"     VARCHAR2(200),
    "FUSION_DOMAIN"             VARCHAR2(240),
    "FUSION_USERNAME"           VARCHAR2(240),
    "FUSION_PASSWORD"           VARCHAR2(240)
);
  CREATE UNIQUE INDEX "XXPM_SETUP_DETAIL_U1" ON "XXPM_SETUP_DETAIL" ("SETUP_ID")

--------------------------------------------------------
--  DDL for Table XXPM_UNBLOCK_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_UNBLOCK_DETAIL" (
    "UNBLOCK_DTL_ID"      NUMBER,
    "UNBLOCK_ID"          NUMBER,
    "BLOCK_DTL_ID"        NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATED_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_UNBLOCK_DETAIL_PK" ON "XXPM_UNBLOCK_DETAIL" ("UNBLOCK_DTL_ID")

--------------------------------------------------------
--  DDL for Table XXPM_UNBLOCK_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_UNBLOCK_HEADER" (
    "UNBLOCK_ID"          NUMBER,
    "BLOCK_ID"            NUMBER,
    "UNBLOCK_NUMBER"      VARCHAR2(30),
    "UNBLOCK_DATE"        DATE,
    "ORG_ID"              NUMBER,
    "STATUS"              VARCHAR2(60),
    "DESCRIPTION"         VARCHAR2(4000),
    "FUNC_ID"             NUMBER,
    "FLOW_STATUS"         VARCHAR2(60),
    "FLOW_LEVEL"          NUMBER,
    "FLOW_WITH"           NUMBER,
    "USER_GRP_ID"         NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATED_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXPM_UNBLOCK_HEADER_PK" ON "XXPM_UNBLOCK_HEADER" ("UNBLOCK_ID");
--------------------------------------------------------
--  DDL for Table XXPM_RECEIPT_UPDATE
--------------------------------------------------------

CREATE TABLE "XXPM_RECEIPT_UPDATE" (
    "RECEIPT_NUMBER"            VARCHAR2(50),
    "RECEIPT_DATE"              VARCHAR2(50),
    "RECEIPT_METHOD_NAME"       VARCHAR2(50),
    "CURRENCY_CODE"             VARCHAR2(50),
    "RECEIPT_AMOUNT"            VARCHAR2(50),
    "AMOUNT_APPLIED"            VARCHAR2(50),
    "COMMENTS"                  VARCHAR2(50),
    "CUSTOMER_NAME"             VARCHAR2(50),
    "CUSTOMER_ACCOUNT_NUMBER"   VARCHAR2(50),
    "BUSINESS_UNIT_NAME"        VARCHAR2(50),
    "GL_DATE"                   VARCHAR2(50),
    "MATURITY_DATE"             VARCHAR2(50),
    "TRANSACTION_DATE"          VARCHAR2(50),
    "APPLICATION_DATE"          VARCHAR2(50),
    "ACCOUNTING_DATE"           VARCHAR2(50),
    "TRANSACTION_NUMBER"        VARCHAR2(50),
    "ORG_ID"                    VARCHAR2(50),
    "CUST_ID"                   VARCHAR2(50),
    "CUSTOMER_TRX_ID"           VARCHAR2(20),
    "RECEIPT_METHOD_ID"         VARCHAR2(50)
);
--------------------------------------------------------
--  DDL for Table XXPM_RECOMMEND_DETAIL
--------------------------------------------------------

CREATE TABLE "XXPM_RECOMMEND_DETAIL" (
    "RECOMMEND_DTL_ID"     NUMBER,
    "RECOMMEND_ID"         NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "INSTALLMENT_TYPE"     VARCHAR2(60),
    "INSTALLMENT_PCT"      NUMBER,
    "INSTALLMENT_AMOUNT"   NUMBER,
    "CRITERIA"             VARCHAR2(60),
    "CHARGE_TYPE"          VARCHAR2(60),
    "PAYMENT_TERM"         VARCHAR2(60),
    "REMARKS"              VARCHAR2(4000),
    "DUE_DATE"             DATE,
    "CHEQUE_NO"            VARCHAR2(60),
    "CHEQUE_DATE"          DATE,
    "AMOUNT_RECEIVED"      NUMBER,
    "RECEIVED_DATE"        DATE,
    "BANK_NAME"            VARCHAR2(240),
    "PAYEE_NAME"           VARCHAR2(240),
    "STATUS"               VARCHAR2(60),
    "RECEIPT_ID"           NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE1"           VARCHAR2(240),
    "ATTRIBUTE2"           VARCHAR2(240),
    "ATTRIBUTE3"           VARCHAR2(240),
    "ATTRIBUTE4"           VARCHAR2(240),
    "ATTRIBUTE5"           VARCHAR2(240),
    "ATTRIBUTE6"           VARCHAR2(240),
    "ATTRIBUTE7"           VARCHAR2(240),
    "ATTRIBUTE8"           VARCHAR2(240),
    "ATTRIBUTE9"           VARCHAR2(240),
    "ATTRIBUTE10"          VARCHAR2(240),
    "ATTRIBUTE11"          VARCHAR2(240),
    "ATTRIBUTE12"          VARCHAR2(240),
    "ATTRIBUTE13"          VARCHAR2(240),
    "ATTRIBUTE14"          VARCHAR2(240),
    "ATTRIBUTE15"          VARCHAR2(240),
    "ATTRIBUTE16"          VARCHAR2(240),
    "ATTRIBUTE17"          VARCHAR2(240),
    "ATTRIBUTE18"          VARCHAR2(240),
    "ATTRIBUTE19"          VARCHAR2(240),
    "ATTRIBUTE20"          VARCHAR2(240),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
--------------------------------------------------------
--  DDL for Table XXPM_RECOMMEND_HEADER
--------------------------------------------------------

CREATE TABLE "XXPM_RECOMMEND_HEADER" (
    "RECOMMEND_ID"            NUMBER,
    "FUNC_ID"                 NUMBER,
    "BOOKING_ID"              NUMBER,
    "RECOMMEND_NUMBER"        VARCHAR2(20),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "ATTRIBUTE11"             VARCHAR2(240),
    "ATTRIBUTE12"             VARCHAR2(240),
    "ATTRIBUTE13"             VARCHAR2(240),
    "ATTRIBUTE14"             VARCHAR2(240),
    "ATTRIBUTE15"             VARCHAR2(240),
    "ATTRIBUTE16"             VARCHAR2(240),
    "ATTRIBUTE17"             VARCHAR2(240),
    "ATTRIBUTE18"             VARCHAR2(240),
    "ATTRIBUTE19"             VARCHAR2(240),
    "ATTRIBUTE20"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "ORG_ID"                  NUMBER,
    "PROPERTY_ID"             NUMBER,
    "BUILDING_ID"             NUMBER,
    "USER_GRP_ID"             NUMBER,
    "RECOMMEND_DATE"          DATE,
    "REVISION_NO"             NUMBER,
    "RECEIPT_AMOUNT"          NUMBER
);
--------------------------------------------------------
--  DDL for Table XXPM_RECOMMEND_HEADER_H
--------------------------------------------------------

CREATE TABLE "XXPM_RECOMMEND_HEADER_H" (
    "RECOMMEND_HST_ID"        NUMBER,
    "RECOMMEND_ID"            NUMBER,
    "FUNC_ID"                 NUMBER,
    "BOOKING_ID"              NUMBER,
    "RECOMMEND_NUMBER"        VARCHAR2(20),
    "STATUS"                  VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(240),
    "FLOW_STATUS"             VARCHAR2(60),
    "FLOW_LEVEL"              NUMBER,
    "FLOW_WITH"               NUMBER,
    "ATTRIBUTE_CATEGORY"      VARCHAR2(240),
    "ATTRIBUTE1"              VARCHAR2(240),
    "ATTRIBUTE2"              VARCHAR2(240),
    "ATTRIBUTE3"              VARCHAR2(240),
    "ATTRIBUTE4"              VARCHAR2(240),
    "ATTRIBUTE5"              VARCHAR2(240),
    "ATTRIBUTE6"              VARCHAR2(240),
    "ATTRIBUTE7"              VARCHAR2(240),
    "ATTRIBUTE8"              VARCHAR2(240),
    "ATTRIBUTE9"              VARCHAR2(240),
    "ATTRIBUTE10"             VARCHAR2(240),
    "ATTRIBUTE11"             VARCHAR2(240),
    "ATTRIBUTE12"             VARCHAR2(240),
    "ATTRIBUTE13"             VARCHAR2(240),
    "ATTRIBUTE14"             VARCHAR2(240),
    "ATTRIBUTE15"             VARCHAR2(240),
    "ATTRIBUTE16"             VARCHAR2(240),
    "ATTRIBUTE17"             VARCHAR2(240),
    "ATTRIBUTE18"             VARCHAR2(240),
    "ATTRIBUTE19"             VARCHAR2(240),
    "ATTRIBUTE20"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "OBJECT_VERSION_NUMBER"   NUMBER,
    "ORG_ID"                  NUMBER,
    "PROPERTY_ID"             NUMBER,
    "BUILDING_ID"             NUMBER,
    "USER_GRP_ID"             NUMBER,
    "RECOMMEND_DATE"          DATE,
    "REVISION_NO"             NUMBER
);
--------------------------------------------------------
--  DDL for Table XXPM_RECOMMEND_OTHER_CHARGES
--------------------------------------------------------

CREATE TABLE "XXPM_RECOMMEND_OTHER_CHARGES" (
    "RECOMMEND_CHARGE_ID"   NUMBER,
    "RECOMMEND_ID"          NUMBER,
    "SEQ_NUMBER"            NUMBER,
    "INSTALLMENT_TYPE"      VARCHAR2(60),
    "INSTALLMENT_PCT"       NUMBER,
    "INSTALLMENT_AMOUNT"    NUMBER,
    "CRITERIA"              VARCHAR2(60),
    "CHARGE_TYPE"           VARCHAR2(60),
    "PAYMENT_TERM"          VARCHAR2(60),
    "REMARKS"               VARCHAR2(4000),
    "DUE_DATE"              DATE,
    "CHEQUE_NO"             VARCHAR2(60),
    "CHEQUE_DATE"           DATE,
    "AMOUNT_RECEIVED"       NUMBER,
    "RECEIVED_DATE"         DATE,
    "BANK_NAME"             VARCHAR2(240),
    "PAYEE_NAME"            VARCHAR2(240),
    "STATUS"                VARCHAR2(60),
    "RECEIPT_ID"            NUMBER,
    "ATTRIBUTE_CATEGORY"    VARCHAR2(240),
    "ATTRIBUTE1"            VARCHAR2(240),
    "ATTRIBUTE2"            VARCHAR2(240),
    "ATTRIBUTE3"            VARCHAR2(240),
    "ATTRIBUTE4"            VARCHAR2(240),
    "ATTRIBUTE5"            VARCHAR2(240),
    "ATTRIBUTE6"            VARCHAR2(240),
    "ATTRIBUTE7"            VARCHAR2(240),
    "ATTRIBUTE8"            VARCHAR2(240),
    "ATTRIBUTE9"            VARCHAR2(240),
    "ATTRIBUTE10"           VARCHAR2(240),
    "ATTRIBUTE11"           VARCHAR2(240),
    "ATTRIBUTE12"           VARCHAR2(240),
    "ATTRIBUTE13"           VARCHAR2(240),
    "ATTRIBUTE14"           VARCHAR2(240),
    "ATTRIBUTE15"           VARCHAR2(240),
    "ATTRIBUTE16"           VARCHAR2(240),
    "ATTRIBUTE17"           VARCHAR2(240),
    "ATTRIBUTE18"           VARCHAR2(240),
    "ATTRIBUTE19"           VARCHAR2(240),
    "ATTRIBUTE20"           VARCHAR2(240),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150)
);


--------------------------------------------------------
--  DDL for Table XXPM_REVISION
--------------------------------------------------------

CREATE TABLE "XXPM_REVISION" (
    "PL_REVISON_ID"       NUMBER,
    "PL_ID"               NUMBER,
    "REVISON_NO"          VARCHAR2(60),
    "REVISION_TYPE"       VARCHAR2(3),
    "REVISION_VALUE"      NUMBER,
    "DESCRIPTION"         VARCHAR2(2000),
    "REVISED_DATE"        DATE,
    "REVISED_BY"          VARCHAR2(150),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "START_DATE"          DATE,
    "END_DATE"            DATE
);
--------------------------------------------------------
--  DDL for Table XXPM_REVISION_LINE
--------------------------------------------------------

CREATE TABLE "XXPM_REVISION_LINE" (
    "PL_REV_LINE_ID"               NUMBER,
    "PL_REVISON_ID"                NUMBER,
    "UNIT_TYPE"                    VARCHAR2(60),
    "REV_BASE_CHARGE"              NUMBER,
    "REV_MIN_CHARGE"               NUMBER,
    "REV_SECURITYDEPOSIT_CHARGE"   NUMBER,
    "REV_MUNICIPALITY_CHARGE"      NUMBER,
    "REV_ELECTRICITY_CHARGE"       NUMBER,
    "CREATED_BY"                   VARCHAR2(60),
    "CREATION_DATE"                TIMESTAMP(6),
    "LAST_UPDATED_BY"              VARCHAR2(60),
    "LAST_UPDATE_DATE"             TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"            VARCHAR2(150),
    "THIRD_PARTY_SERV_CHARGE"      NUMBER,
    "OTHER_GOVNT_CHARGE_NEW"       NUMBER,
    "OTHER_GOVNT_CHARGE_RNEW"      NUMBER,
    "EJARI_PAYMENT_CHARGE"         NUMBER
);

--XXPM_RECEIPT_UPDATE
--XXPM_RECOMMEND_DETAIL
--XXPM_RECOMMEND_HEADER
--XXPM_RECOMMEND_HEADER_H
--XXPM_RECOMMEND_OTHER_CHARGES
--XXPM_REVISION
--XXPM_REVISION_LINE
ALTER INDEX XXPM_ACTIVITY_LOG_PK 			RENAME TO XXPM_ACTIVITY_LOG_U1;
ALTER INDEX XXPM_AREA_CHANGE_DLT_PK 		RENAME TO XXPM_AREA_CHANGE_DLT_U1;
ALTER INDEX XXPM_AREA_CHANGE_HDR_PK 		RENAME TO XXPM_AREA_CHANGE_HDR_U1;
ALTER INDEX XXPM_AR_SETUP_PK 				RENAME TO XXPM_AR_SETUP_U1;
ALTER INDEX XXPM_BILLING_PK 				RENAME TO XXPM_BILLING_U1;
ALTER INDEX XXPM_BLOCK_DETAIL_PK 			RENAME TO XXPM_BLOCK_DETAIL_U1;
ALTER INDEX XXPM_BOOKING_CUSTOMER_H_PK 		RENAME TO XXPM_BOOKING_CUSTOMER_H_U1;
ALTER INDEX XXPM_BOOKING_DETAIL_PK 			RENAME TO XXPM_BOOKING_DETAIL_U1;
ALTER INDEX XXPM_BOOKING_DETAIL_H_PK 		RENAME TO XXPM_BOOKING_DETAIL_H_U1;
ALTER INDEX XXPM_BOOKING_EVENTS_PK 			RENAME TO XXPM_BOOKING_EVENTS_U1;
ALTER INDEX XXPM_BOOKING_EVENTS_H_PK 		RENAME TO XXPM_BOOKING_EVENTS_H_U1;
ALTER INDEX XXPM_BOOKING_HEADER_H_PK 		RENAME TO XXPM_BOOKING_HEADER_H_U1;
ALTER INDEX XXXPM_BOOKING_MILESTONES_H_PK 	RENAME TO XXXPM_BOOKING_MILESTONES_H_U1;
ALTER INDEX XXPM_BOOK_MS_REV_DTL_PK 		RENAME TO XXPM_BOOK_MS_REV_DTL_U1;
ALTER INDEX XXPM_BOOK_MS_REV_HDR_PK 		RENAME TO XXPM_BOOK_MS_REV_HDR_U1;
ALTER INDEX XXPM_CANCELLATION_PK 			RENAME TO XXPM_CANCELLATION_U1;
ALTER INDEX XXPM_CANCEL_NOTIFY_PK 			RENAME TO XXPM_CANCEL_NOTIFY_U1;
ALTER INDEX XXPM_EXTEN_CANCEL_PK 			RENAME TO XXPM_EXTEN_CANCEL_U1;
ALTER INDEX XXPM_LEASE_AGREEMENT_PK 		RENAME TO XXPM_LEASE_AGREEMENT_U1;
ALTER INDEX XXPM_MILESTONE_DTL_H_PK 		RENAME TO XXPM_MILESTONE_DTL_H_U1;
ALTER INDEX XXPM_MILESTONE_HDR_H_PK 		RENAME TO XXPM_MILESTONE_HDR_H_U1;
ALTER INDEX XXPM_MODIFIERS_PK 				RENAME TO XXPM_MODIFIERS_U1;
ALTER INDEX XXPM_MOVE_IN_OUT_PK 			RENAME TO XXPM_MOVE_IN_OUT_U1;
ALTER INDEX XXPM_MOVE_IO_CUST_VISIT_PK 		RENAME TO XXPM_MOVE_IO_CUST_VISIT_U1;
ALTER INDEX XXPM_MOVE_IO_FIXTURES_PK 		RENAME TO XXPM_MOVE_IO_FIXTURES_U1;
ALTER INDEX XXPM_MOVE_IO_KEYS_PK 			RENAME TO XXPM_MOVE_IO_KEYS_U1;
ALTER INDEX XXPM_MOVE_IO_METERS_PK 			RENAME TO XXPM_MOVE_IO_METERS_U1;
ALTER INDEX XXPM_OFFER_DETAIL_H_PK 			RENAME TO XXPM_OFFER_DETAIL_H_U1;
ALTER INDEX XXPM_OFFER_HEADER_H_PK 			RENAME TO XXPM_OFFER_HEADER_H_U1;
ALTER INDEX XXPM_OFFER_MILESTONE_DTL_H_PK 	RENAME TO XXPM_OFFER_MILESTONE_DTL_H_U1;
ALTER INDEX XXPM_PL_DISCOUNTS_PK 			RENAME TO XXPM_PL_DISCOUNTS_U1;
ALTER INDEX XXPM_PL_HEADER_H_PK 			RENAME TO XXPM_PL_HEADER_H_U1;
ALTER INDEX XXPM_PL_LINES_PK 				RENAME TO XXPM_PL_LINES_U1;
ALTER INDEX XXPM_PL_LINES_H_PK 				RENAME TO XXPM_PL_LINES_H_U1;
ALTER INDEX XXPM_PL_MODIFIERS_PK 			RENAME TO XXPM_PL_MODIFIERS_U1;
ALTER INDEX XXPM_PL_MODIFIERS_H_PK 			RENAME TO XXPM_PL_MODIFIERS_H_U1;
ALTER INDEX XXPM_PL_QUALIFIERS_PK 			RENAME TO XXPM_PL_QUALIFIERS_U1;
ALTER INDEX XXPM_PL_QUALIFIERS_H_PK 		RENAME TO XXPM_PL_QUALIFIERS_H_U1;
ALTER INDEX XXPM_PROPERTY_BUILDINGS_PK 		RENAME TO XXPM_PROPERTY_BUILDINGS_U1;
ALTER INDEX XXPM_PROPERTY_CARPARKS_PK 		RENAME TO XXPM_PROPERTY_CARPARKS_U1;
ALTER INDEX XXPM_PROPERTY_CONTACTS_PK 		RENAME TO XXPM_PROPERTY_CONTACTS_U1;
ALTER INDEX XXPM_PROPERTY_ESCROW_PK 		RENAME TO XXPM_PROPERTY_ESCROW_U1;
ALTER INDEX XXPM_PROPERTY_FEATURES_PK 		RENAME TO XXPM_PROPERTY_FEATURES_U1;
ALTER INDEX XXPM_PROPERTY_FIX_FITTINGS_PK 	RENAME TO XXPM_PROPERTY_FIX_FITTINGS_U1;
ALTER INDEX XXPM_PROPERTY_MILESTONE_PK 		RENAME TO XXPM_PROPERTY_MILESTONE_U1;
ALTER INDEX XXPM_PROPERTY_MORTGAGE_PK 		RENAME TO XXPM_PROPERTY_MORTGAGE_U1;
ALTER INDEX XXPM_PROPERTY_ORG_PK 			RENAME TO XXPM_PROPERTY_ORG_U1;
ALTER INDEX XXPM_QUALIFIERS_PK 				RENAME TO XXPM_QUALIFIERS_U1;
ALTER INDEX XXPM_REGISTRATION_PK 			RENAME TO XXPM_REGISTRATION_U1;
ALTER INDEX XXPM_UNBLOCK_DETAIL_PK 			RENAME TO XXPM_UNBLOCK_DETAIL_U1;
ALTER INDEX XXPM_UNBLOCK_HEADER_PK 			RENAME TO XXPM_UNBLOCK_HEADER_U1;
ALTER INDEX SYS_C0063917 					RENAME TO XXPM_ORG_ASSIGNMENT_U1;

SELECT INDEX_NAME, TABLE_NAME FROM ALL_INDEXES 
WHERE TABLE_OWNER like 'XXSUBCONTRACT'
and UNIQUENESS='UNIQUE'
and INDEX_NAME like 'SYS_C%';




ALTER TABLE XXPM_OFFER_DETAIL ADD (DISC_TYPE VARCHAR2(20));
ALTER TABLE XXPM_OFFER_DETAIL ADD (MIN_PRICE NUMBER);

ALTER TABLE XXPM_OFFER_HEADER ADD (NATIONALITY  VARCHAR2(150));
ALTER TABLE XXPM_OFFER_HEADER ADD (EMIRATES_ID  VARCHAR2(150));

 

ALTER TABLE XXPM_PROPERTY_MASTER ADD (PROPERTY_COMPLETED_PERC NUMBER);

ALTER TABLE XXPM_BILLING ADD (PROJECT_ID NUMBER);