--------------------------------------------------------
--  File created - Sunday-August-11-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXSTG_AR_TXN_SOURCE
--------------------------------------------------------
CREATE TABLE "XXSTG_AR_TXN_SOURCE" (
    "BATCH_SOURCE_ID"       NUMBER,
    "TXN_NAME"              VARCHAR2(240),
    "DESCRIPTION"           VARCHAR2(500),
    "STATUS"                VARCHAR2(240),
    "BATCH_SOURCE_SEQ_ID"   NUMBER
);
    CREATE UNIQUE INDEX "XXSTG_AR_TXN_SOURCE_U1" ON
        "XXSTG_AR_TXN_SOURCE" (
            "BATCH_SOURCE_ID"
        );
--------------------------------------------------------
--  DDL for Table XXSTG_AR_TXN_TYPE
--------------------------------------------------------

CREATE TABLE "XXSTG_AR_TXN_TYPE" (
    "CUST_TRX_TYPE_ID"       NUMBER,
    "TXN_NAME"               VARCHAR2(240),
    "DESCRIPTION"            VARCHAR2(500),
    "STATUS"                 VARCHAR2(240),
    "TXN_TYPE"               VARCHAR2(240),
    "CUST_TRX_TYPE_SEQ_ID"   NUMBER,
    "REV_ACCOUNT_ID"         NUMBER
);

CREATE UNIQUE INDEX "XXSTG_AR_TXN_TYPE_U1" ON "XXSTG_AR_TXN_TYPE" ("CUST_TRX_TYPE_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_BANKS
--------------------------------------------------------

CREATE TABLE "XXSTG_BANKS" (
    "BANK_ID"             NUMBER(22, 0),
    "BANK_NAME"           VARCHAR2(240),
    "BANK_NAME_TL"        VARCHAR2(240),
    "BANK_NUMBER"         VARCHAR2(30),
    "BRANCH_ID"           NUMBER(22, 0),
    "BRANCH_NAME"         VARCHAR2(240),
    "BRANCH_NAME_TL"      VARCHAR2(240),
    "BRANCH_NUMBER"       VARCHAR2(30),
    "ADDRESS1"            VARCHAR2(240),
    "ADDRESS1_TL"         VARCHAR2(240),
    "ADDRESS2"            VARCHAR2(240),
    "ADDRESS2_TL"         VARCHAR2(240),
    "ADDRESS3"            VARCHAR2(240),
    "ADDRESS3_TL"         VARCHAR2(240),
    "ADDRESS4"            VARCHAR2(240),
    "ADDRESS4_TL"         VARCHAR2(240),
    "CITY"                VARCHAR2(60),
    "CITY_TL"             VARCHAR2(60),
    "POSTAL_CODE"         VARCHAR2(60),
    "STATE"               VARCHAR2(60),
    "STATE_TL"            VARCHAR2(60),
    "PROVINCE"            VARCHAR2(60),
    "PROVINCE_TL"         VARCHAR2(60),
    "COUNTY"              VARCHAR2(60),
    "COUNTY_TL"           VARCHAR2(60),
    "COUNTRY"             VARCHAR2(60),
    "COUNTRY_TL"          VARCHAR2(60),
    "ORIG_BANK_REF"       NUMBER(22, 0),
    "ORIG_BRANCH_REF"     NUMBER(22, 0),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_BANKS_PK" ON "XXSTG_BANKS" ("BANK_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_BANK_ACCOUNTS
--------------------------------------------------------

CREATE TABLE "XXSTG_BANK_ACCOUNTS" (
    "BANK_ACNT_ID"        NUMBER,
    "BANK_NAME"           VARCHAR2(240),
    "BANK_NAME_TL"        VARCHAR2(240),
    "BANK_NUMBER"         VARCHAR2(30),
    "BRANCH_NAME"         VARCHAR2(240),
    "BRANCH_NAME_TL"      VARCHAR2(240),
    "BRANCH_NUMBER"       VARCHAR2(30),
    "ADDRESS1"            VARCHAR2(240),
    "ADDRESS1_TL"         VARCHAR2(240),
    "ADDRESS2"            VARCHAR2(240),
    "ADDRESS2_TL"         VARCHAR2(240),
    "ADDRESS3"            VARCHAR2(240),
    "ADDRESS3_TL"         VARCHAR2(240),
    "ADDRESS4"            VARCHAR2(240),
    "ADDRESS4_TL"         VARCHAR2(240),
    "CITY"                VARCHAR2(60),
    "CITY_TL"             VARCHAR2(60),
    "POSTAL_CODE"         VARCHAR2(60),
    "STATE"               VARCHAR2(60),
    "STATE_TL"            VARCHAR2(60),
    "PROVINCE"            VARCHAR2(60),
    "PROVINCE_TL"         VARCHAR2(60),
    "COUNTY"              VARCHAR2(60),
    "COUNTY_TL"           VARCHAR2(60),
    "COUNTRY"             VARCHAR2(60),
    "COUNTRY_TL"          VARCHAR2(60),
    "SWIFT_CODE"          VARCHAR2(60),
    "IBAN"                VARCHAR2(60),
    "BANK_ACCOUNT_NUM"    VARCHAR2(60),
    "BANK_ACCOUNT_TYPE"   VARCHAR2(60),
    "CURRENCY_CODE"       VARCHAR2(30),
    "ORIG_BANK_REF"       NUMBER,
    "ORIG_BRANCH_REF"     NUMBER,
    "ORIG_ACCOUNT_REF"    NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "BANK_ACCOUNT_NAME"   VARCHAR2(60)
);

CREATE UNIQUE INDEX "XXSTG_BANK_ACCOUNTS_PK" ON "XXSTG_BANK_ACCOUNTS" ("BANK_ACNT_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_CUSTOMER
--------------------------------------------------------

CREATE TABLE "XXSTG_CUSTOMER" (
    "CUST_ID"             NUMBER,
    "CUSTOMER_NUMBER"     VARCHAR2(30),
    "CUSTOMER_NAME"       VARCHAR2(240),
    "CUSTOMER_NAME_TL"    VARCHAR2(240),
    "SALES_PERSON_ID"     NUMBER,
    "LEAD_ID"             NUMBER,
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "TITLE"               VARCHAR2(60),
    "SUR_NAME"            VARCHAR2(60),
    "MIDDLE_NAME"         VARCHAR2(60),
    "FIRST_NAME"          VARCHAR2(60),
    "PASSPORT_NO"         VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXSTG_CUSTOMER_U1" ON "XXSTG_CUSTOMER" ("CUST_ID");
  

--------------------------------------------------------
--  DDL for Table XXSTG_CUST_CONTACTS
--------------------------------------------------------

CREATE TABLE "XXSTG_CUST_CONTACTS" (
    "CUST_CONTACT_ID"        NUMBER,
    "CUST_ID"                NUMBER,
    "CUST_SITE_ID"           NUMBER,
    "CONTACT_NAME"           VARCHAR2(240),
    "CONTACT_NAME_TL"        VARCHAR2(240),
    "DESIGNATION"            VARCHAR2(60),
    "MOBILE_NUMBER"          VARCHAR2(60),
    "PHONE_NUMBER"           VARCHAR2(60),
    "FAX_NUMBER"             VARCHAR2(240),
    "EMAIL_ID"               VARCHAR2(60),
    "PASSPORT_NUMBER"        VARCHAR2(60),
    "PASSPORT_EXP_DATE"      DATE,
    "NATIONAL_ID_NUMBER"     VARCHAR2(60),
    "NATIONAL_ID_EXP_DATE"   DATE,
    "ORIG_SYSTEM_REF"        NUMBER,
    "ACTIVE_YN"              VARCHAR2(1),
    "PRIMARY_YN"             VARCHAR2(1),
    "CREATED_BY"             VARCHAR2(60),
    "CREATION_DATE"          TIMESTAMP(6),
    "LAST_UPDATED_BY"        VARCHAR2(60),
    "LAST_UPDATE_DATE"       TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"      VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_CUST_CONTACTS_PK" ON "XXSTG_CUST_CONTACTS" ("CUST_CONTACT_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_CUST_SITES
--------------------------------------------------------

CREATE TABLE "XXSTG_CUST_SITES" (
    "CUST_SITE_ID"        NUMBER,
    "CUST_ID"             NUMBER,
    "SITE_NUMBER"         VARCHAR2(30),
    "SITE_NAME"           VARCHAR2(500),
    "ADDRESS1"            VARCHAR2(240),
    "ADDRESS2"            VARCHAR2(240),
    "ADDRESS3"            VARCHAR2(240),
    "ADDRESS4"            VARCHAR2(240),
    "CITY"                VARCHAR2(60),
    "POSTAL_CODE"         VARCHAR2(60),
    "STATE"               VARCHAR2(60),
    "PROVINCE"            VARCHAR2(60),
    "COUNTY"              VARCHAR2(60),
    "COUNTRY"             VARCHAR2(60),
    "ORG_ID"              NUMBER,
    "ORIG_SYSTEM_REF"     NUMBER,
    "PRIMARY_YN"          VARCHAR2(1),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE INDEX "XXSTG_CUST_SITES_N1" ON "XXSTG_CUST_SITES" ("CUST_ID", "CUST_SITE_ID", "ORG_ID");

  CREATE UNIQUE INDEX "XXSTG_CUST_SITES_PK" ON "XXSTG_CUST_SITES" ("CUST_SITE_ID", "ORG_ID");
--------------------------------------------------------
--  DDL for Table XXSTG_EMPLOYEE
--------------------------------------------------------

CREATE TABLE "XXSTG_EMPLOYEE" (
    "EMP_ID"              NUMBER,
    "EMPLOYEE_NAME"       VARCHAR2(240),
    "EMPLOYEE_NAME_TL"    VARCHAR2(240),
    "EMPLOYEE_NUMBER"     VARCHAR2(30),
    "EMAIL_ID"            VARCHAR2(60),
    "CONTACT_NUMBER"      VARCHAR2(60),
    "NATIONALITY"         VARCHAR2(60),
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "POSITION_ID"         NUMBER
);
  CREATE UNIQUE INDEX "XXSTG_EMPLOYEE_U1" ON "XXSTG_EMPLOYEE" ("EMP_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_GL_CODE_COMBINATION
--------------------------------------------------------

CREATE TABLE "XXSTG_GL_CODE_COMBINATION" (
    "CODE_COMBINATION_ID"     NUMBER,
    "SEGMENT1"                VARCHAR2(25),
    "SEGMENT2"                VARCHAR2(25),
    "SEGMENT3"                VARCHAR2(25),
    "SEGMENT4"                VARCHAR2(25),
    "SEGMENT5"                VARCHAR2(25),
    "SEGMENT6"                VARCHAR2(25),
    "SEGMENT7"                VARCHAR2(25),
    "SEGMENT8"                VARCHAR2(25),
    "SEGMENT9"                VARCHAR2(25),
    "SEGMENT10"               VARCHAR2(25),
    "SEGMENT11"               VARCHAR2(25),
    "SEGMENT12"               VARCHAR2(25),
    "SEGMENT13"               VARCHAR2(25),
    "SEGMENT14"               VARCHAR2(25),
    "SEGMENT15"               VARCHAR2(25),
    "CONCATENATED_SEGMENTS"   VARCHAR2(1000)
);
  CREATE UNIQUE INDEX "XXSTG_GL_CODE_COMBINATION_PK" ON "XXSTG_GL_CODE_COMBINATION" ("CODE_COMBINATION_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_LEAD
--------------------------------------------------------

CREATE TABLE "XXSTG_LEAD" (
    "LEAD_ID"               NUMBER,
    "LEAD_NUMBER"           VARCHAR2(30),
    "LEAD_NAME"             VARCHAR2(240),
    "LEAD_NAME_TL"          VARCHAR2(240),
    "MOBILE_NUMBER"         VARCHAR2(60),
    "PHONE_NUMBER"          VARCHAR2(60),
    "EMAIL_ID"              VARCHAR2(60),
    "ORIG_SYSTEM_REF"       VARCHAR2(30),
    "PROFESSIONAL"          VARCHAR2(240),
    "ACTIVE_YN"             VARCHAR2(1),
    "CREATED_BY"            VARCHAR2(60),
    "CREATION_DATE"         TIMESTAMP(6),
    "LAST_UPDATED_BY"       VARCHAR2(60),
    "LAST_UPDATE_DATE"      TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"     VARCHAR2(150),
    "LEAD_SOURCE_CHANNEL"   VARCHAR2(240),
    "LEAD_SOURCE_NAME"      VARCHAR2(240)
);
  CREATE UNIQUE INDEX "XXSTG_LEAD_PK" ON "XXSTG_LEAD" ("LEAD_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_LEASE_AGREEMENT_HDR
--------------------------------------------------------

CREATE TABLE "XXSTG_LEASE_AGREEMENT_HDR" (
    "S_NO"                      NUMBER,
    "BUSINESS_UNIT"             VARCHAR2(150),
    "ORG_ID"                    NUMBER,
    "BOOKING_ID"                NUMBER,
    "BOOKING_NUMBER"            VARCHAR2(60),
    "BOOKING_DATE"              DATE,
    "BOOKING_DUE_DATE"          DATE,
    "BOOKING_PAY_METHOD"        VARCHAR2(50),
    "BOOKING_PAY_METHOD_CODE"   VARCHAR2(20),
    "PAYMENT_PLAN"              VARCHAR2(100),
    "MS_HDR_ID"                 NUMBER,
    "CUST_REQ_MOVEIN_DATE"      DATE,
    "APPOINTMENT_DATE"          DATE,
    "BOOKING_AMOUNT"            NUMBER,
    "CURRENCY"                  VARCHAR2(25),
    "BOOK_CUST_ID"              NUMBER,
    "TRN_NUMBER"                NUMBER,
    "CUST_CATEGORY"             VARCHAR2(60),
    "CUST_CATEGORY_CODE"        VARCHAR2(60),
    "CUST_NAME"                 VARCHAR2(150),
    "CUST_ACC_NAME"             VARCHAR2(150),
    "VISA_TYPE"                 VARCHAR2(60),
    "VISA_TYPE_CODE"            VARCHAR2(60),
    "NATIONALITY"               VARCHAR2(60),
    "NATIONALITY_CODE"          VARCHAR2(60),
    "CUST_BANK_NAME"            VARCHAR2(150),
    "CUST_BRANCH_NAME"          VARCHAR2(150),
    "CUST_BANK_ACC_NUMBER"      VARCHAR2(60),
    "CUSTOMER_NAME_AR"          VARCHAR2(240),
    "CUSTOMER_NUMBER_AR"        VARCHAR2(240),
    "CUST_ID_AR"                NUMBER,
    "SHIP_TO_ADDRESS"           VARCHAR2(240),
    "BILL_TO_ADDRESS"           VARCHAR2(240),
    "RECOMMEND_ID"              NUMBER,
    "RECOMMEND_NUMBER"          VARCHAR2(20),
    "RECOMMENDATION_DATE"       DATE,
    "LEASE_NUMBER"              VARCHAR2(60),
    "TENANCY_CON_DOC_NO"        VARCHAR2(240),
    "PROPERTY_NAME"             VARCHAR2(240),
    "PROPERTY_ID"               NUMBER,
    "BUILDING_NAME"             VARCHAR2(240),
    "BUILDING_ID"               NUMBER,
    "UNIT_NAME"                 VARCHAR2(240),
    "UNIT_ID"                   NUMBER,
    "BASE_RATE"                 NUMBER,
    "ELECTRICITY_CHARGES"       NUMBER,
    "MUNICIPALITY_CHARGES"      NUMBER,
    "SECURITY_DEPOSITE"         NUMBER,
    "DISCOUNT_RATE"             NUMBER,
    "TAX_AMOUNT"                NUMBER,
    "TOTAL_RATE"                NUMBER,
    "LEASE_START_DATE"          DATE,
    "LEASE_END_DATE"            DATE,
    "STATUS"                    VARCHAR2(30) DEFAULT 'NEW',
    "ERROR_MSG"                 VARCHAR2(4000),
    "LEASE_AGREEMENT_ID"        NUMBER,
    "BOOKING_DTL_ID"            NUMBER,
    "PURPOSE_RENT"              VARCHAR2(240),
    "NO_PROP_UNIT"              VARCHAR2(240),
    "CHECKLIST_NAME"            VARCHAR2(30),
    "NO_OF_YEARS"               NUMBER,
    "LEASE_DATE"                DATE,
    "NO_PROP_UNIT_CODE"         VARCHAR2(30),
    "PURPOSE_RENT_CODE"         VARCHAR2(30),
    "DISCOUNT_NAME"             VARCHAR2(30),
    "DISCOUNT_ID"               NUMBER,
    "OFFER_ID"                  NUMBER
);
  CREATE UNIQUE INDEX "XXSTG_LEASE_AGREEMENT_HDR_U1" ON "XXSTG_LEASE_AGREEMENT_HDR" ("LEASE_AGREEMENT_ID");


--------------------------------------------------------
--  DDL for Table XXSTG_LEASE_MS_DTL
--------------------------------------------------------

CREATE TABLE "XXSTG_LEASE_MS_DTL" (
    "S_NO"                    NUMBER NOT NULL,
    "BOOKING_MS_DTL_ID"       NUMBER,
    "BOOKING_ID"              NUMBER,
    "BOOKING_NUMBER"          VARCHAR2(60),
    "LEASE_NUMBER"            VARCHAR2(60),
    "MILESTONE_TYPE"          VARCHAR2(60),
    "MILESTONE_TYPE_CODE"     VARCHAR2(60),
    "INSTALLMENT_TYPE"        VARCHAR2(60),
    "INSTALLMENT_TYPE_CODE"   VARCHAR2(60),
    "INSTALLMENT_PCT"         NUMBER,
    "INSTALLMENT_AMOUNT"      NUMBER,
    "CHARGE_TYPE"             VARCHAR2(60),
    "CHARGE_TYPE_CODE"        VARCHAR2(60),
    "PAYMENT_TERM"            VARCHAR2(60),
    "PAYMENT_TERM_ID"         VARCHAR2(60),
    "REMARKS"                 VARCHAR2(4000),
    "DUE_DATE"                DATE,
    "STATUS"                  VARCHAR2(30),
    "ERROR_MSG"               VARCHAR2(4000),
    "SEQ_NUMBER"              NUMBER,
    "MS_DTL_ID"               NUMBER
);
--------------------------------------------------------
--  DDL for Table XXSTG_LOCATIONS
--------------------------------------------------------

CREATE TABLE "XXSTG_LOCATIONS" (
    "LOC_ID"              NUMBER,
    "LOCATION_NAME"       VARCHAR2(240),
    "LOCATION_NAME_TL"    VARCHAR2(240),
    "COUNTRY"             VARCHAR2(60),
    "COUNTRY_TL"          VARCHAR2(60),
    "ADDRESS1"            VARCHAR2(240),
    "ADDRESS1_TL"         VARCHAR2(240),
    "ADDRESS2"            VARCHAR2(240),
    "ADDRESS2_TL"         VARCHAR2(240),
    "ADDRESS3"            VARCHAR2(240),
    "ADDRESS3_TL"         VARCHAR2(240),
    "ADDRESS4"            VARCHAR2(240),
    "ADDRESS4_TL"         VARCHAR2(240),
    "CITY"                VARCHAR2(60),
    "CITY_TL"             VARCHAR2(60),
    "POSTAL_CODE"         VARCHAR2(60),
    "POSTAL_CODE_TL"      VARCHAR2(60),
    "STATE"               VARCHAR2(60),
    "STATE_TL"            VARCHAR2(60),
    "PROVINCE"            VARCHAR2(60),
    "PROVINCE_TL"         VARCHAR2(60),
    "COUNTY"              VARCHAR2(60),
    "COUNTY_TL"           VARCHAR2(60),
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "ORG_ID"              NUMBER,
    "LICENSE_NO"          VARCHAR2(60),
    "PO_BOX"              VARCHAR2(60)
);
  CREATE UNIQUE INDEX "XXSTG_LOCATIONS_PK" ON "XXSTG_LOCATIONS" ("LOC_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_MOVE_IN_OUT
--------------------------------------------------------

CREATE TABLE "XXSTG_MOVE_IN_OUT" (
    "S_NO"                 NUMBER NOT NULL,
    "MOVE_IN_OUT_ID"       NUMBER,
    "FUNC_ID"              NUMBER,
    "LEASE_AGREEMENT_ID"   NUMBER,
    "BOOKING_ID"           NUMBER,
    "BOOKING_NUMBER"       VARCHAR2(60),
    "LEASE_NUMBER"         VARCHAR2(60),
    "MOVE_IN_OUT_NUMBER"   VARCHAR2(60),
    "MOVE_IN_OUT_DATE"     DATE,
    "CUSTOMER"             VARCHAR2(250),
    "RESOURCE_NAME"        VARCHAR2(60),
    "IN_OUT_FLAG"          VARCHAR2(1),
    "MOVE_STATUS"          VARCHAR2(60),
    "MOVE_STATUS_CODE"     VARCHAR2(60),
    "DESCRIPTION"          VARCHAR2(240),
    "ORG_ID"               NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILDING_ID"          NUMBER,
    "STATUS"               VARCHAR2(30),
    "ERROR_MSG"            VARCHAR2(2000)
);
--------------------------------------------------------
--  DDL for Table XXSTG_ORGANIZATIONS
--------------------------------------------------------

CREATE TABLE "XXSTG_ORGANIZATIONS" (
    "ORG_ID"              NUMBER,
    "ORG_NAME"            VARCHAR2(240),
    "ORG_NAME_TL"         VARCHAR2(240),
    "SHORT_CODE"          VARCHAR2(150),
    "LEGAL_ENTITY_ID"     NUMBER,
    "LEDGER_ID"           NUMBER,
    "LEDGER_NAME"         VARCHAR2(100),
    "LEDGER_GL_CODE"      VARCHAR2(20),
    "ORG_GL_CODE"         VARCHAR2(20),
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_ORGANIZATIONS_U1" ON "XXSTG_ORGANIZATIONS" ("ORG_ID");


--------------------------------------------------------
--  DDL for Table XXSTG_PAY_TERMS
--------------------------------------------------------

CREATE TABLE "XXSTG_PAY_TERMS" (
    "TERM_ID"             NUMBER,
    "TERM_NAME"           VARCHAR2(60),
    "TERM_DAYS"           NUMBER,
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_PAY_TERMS_PK" ON "XXSTG_PAY_TERMS" ("TERM_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_POSITIONS
--------------------------------------------------------

CREATE TABLE "XXSTG_POSITIONS" (
    "POSITION_ID"         NUMBER,
    "POSITION_NAME"       VARCHAR2(240),
    "POSITION_CODE"       VARCHAR2(60),
    "JOB_ID"              NUMBER,
    "JOB_NAME"            VARCHAR2(240),
    "JOB_CODE"            VARCHAR2(60),
    "PERSON_ID"           NUMBER,
    "PERSON_NUMBER"       VARCHAR2(30),
    "FULL_NAME"           VARCHAR2(240),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_POSITIONS_PK" ON "XXSTG_POSITIONS" ("POSITION_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_PROJECTS
--------------------------------------------------------

CREATE TABLE "XXSTG_PROJECTS" (
    "PROJ_ID"             NUMBER,
    "PROJECT_NAME"        VARCHAR2(240),
    "PROJECT_NUMBER"      VARCHAR2(25),
    "ORG_ID"              NUMBER,
    "START_DATE"          DATE,
    "COMPLETION_DATE"     DATE,
    "CLOSED_DATE"         DATE,
    "COST_CENTER_CODE"    VARCHAR2(60),
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "INV_PREFIX"          VARCHAR2(10) DEFAULT 'INV',
    "SEQ_NO"              NUMBER DEFAULT 100
);
  CREATE UNIQUE INDEX "XXSTG_PROJECTS_PK" ON "XXSTG_PROJECTS" ("PROJ_ID");


--------------------------------------------------------
--  DDL for Table XXSTG_PROJECT_MILESTONES
--------------------------------------------------------

CREATE TABLE "XXSTG_PROJECT_MILESTONES" (
    "PROJ_MS_ID"          NUMBER,
    "PROJ_ID"             NUMBER,
    "MS_NAME"             VARCHAR2(240),
    "START_DATE"          DATE,
    "COMPLETION_DATE"     DATE,
    "ORIG_SYSTEM_REF"     NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_PROJECT_MILESTONES_PK" ON "XXSTG_PROJECT_MILESTONES" ("PROJ_MS_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_RECEIPT
--------------------------------------------------------

CREATE TABLE "XXSTG_RECEIPT" (
    "S_NO" NUMBER NOT NULL,
    "RECEIPT_REF_TYPE"            VARCHAR2(60),
    "RECEIPT_REF_NUM"             VARCHAR2(60),
    "SOURCE_FUNC_REF_ID"          NUMBER,
    "INVOICE_NUM"                 VARCHAR2(60),
    "RECEIPT_ID"                  NUMBER,
    "RECEIPT_NUMBER"              VARCHAR2(60),
    "RECEIPT_DATE"                DATE,
    "CUSTOMER_NAME"               VARCHAR2(240),
    "CURRENCY_CODE"               VARCHAR2(3),
    "RECEIPT_AMOUNT"              NUMBER,
    "PAY_REC_DATE"                DATE,
    "DIFF_IN_DAYS"                NUMBER,
    "BANK_NAME"                   VARCHAR2(60),
    "BANK_BRANCH_NAME"            VARCHAR2(60),
    "DRAWN_BY"                    VARCHAR2(60),
    "PAY_MODE"                    VARCHAR2(30),
    "PAY_MODE_CODE"               VARCHAR2(30),
    "RCT_TYPE"                    VARCHAR2(30),
    "RCT_TYPE_CODE"               VARCHAR2(30),
    "PAY_REF_NUMBER"              VARCHAR2(30),
    "PAY_REF_DATE"                DATE,
    "DESCRIPTION"                 VARCHAR2(4000),
    "TAX_AMOUNT"                  NUMBER,
    "TAX_CODE"                    VARCHAR2(60),
    "TAX_RATE"                    NUMBER,
    "RECOMMENDED_AMOUNT"          NUMBER,
    "RECEIVED_AMOUNT"             NUMBER,
    "RECEIPT_DTL_ID"              NUMBER,
    "BOOKING_TYPE"                VARCHAR2(100),
    "BOOKING_MS_DTL_ID"           NUMBER,
    "AMOUNT_APPLIED"              NUMBER,
    "APPLIED_DATE"                DATE,
    "CUSTOMER_TRX"                VARCHAR2(240),
    "CUSTOMER_TRX_ID"             NUMBER,
    "RECEIVABLE_APPLICATION"      VARCHAR2(100),
    "RECEIVABLE_APPLICATION_ID"   NUMBER,
    "STATUS"                      VARCHAR2(30) DEFAULT 'NEW',
    "ERROR_MSG"                   VARCHAR2(4000),
    "FLAT"                        VARCHAR2(30)
);

--------------------------------------------------------
--  DDL for Table XXSTG_RECEIPT_METHOD
--------------------------------------------------------

CREATE TABLE "XXSTG_RECEIPT_METHOD" (
    "RECEIPT_METHOD_ID"        NUMBER,
    "RECEIPT_METHOD_NAME"      VARCHAR2(30),
    "ORG_ID"                   NUMBER,
    "TYPE"                     VARCHAR2(30),
    "CREATED_BY"               VARCHAR2(60),
    "CREATION_DATE"            TIMESTAMP(6),
    "LAST_UPDATED_BY"          VARCHAR2(60),
    "LAST_UPDATE_DATE"         TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"        VARCHAR2(150),
    "REMIT_BANK_ACCT_USE_ID"   NUMBER,
    "BANK_ACCOUNT_NUM"         VARCHAR2(60),
    "BANK_NAME"                VARCHAR2(240),
    "BANK_BRANCH_NAME"         VARCHAR2(240),
    "REC_BANK_ACC_NUM"         VARCHAR2(60),
    "REC_BANK_NAME"            VARCHAR2(240),
    "REC_BANK_BRANCH_NAME"     VARCHAR2(240)
);
  CREATE UNIQUE INDEX "XXSTG_RECEIPT_METHOD_U1" ON "XXSTG_RECEIPT_METHOD" ("RECEIPT_METHOD_ID", "ORG_ID", "REMIT_BANK_ACCT_USE_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_RECEIPT_OLD
--------------------------------------------------------

CREATE TABLE "XXSTG_RECEIPT_OLD" (
    "S_NO"                        NUMBER,
    "RECEIPT_REF_TYPE"            VARCHAR2(60),
    "RECEIPT_REF_NUM"             VARCHAR2(60),
    "SOURCE_FUNC_REF_ID"          NUMBER,
    "INVOICE_NUM"                 VARCHAR2(60),
    "RECEIPT_ID"                  NUMBER,
    "RECEIPT_NUMBER"              VARCHAR2(60),
    "RECEIPT_DATE"                DATE,
    "CUSTOMER_NAME"               VARCHAR2(240),
    "CURRENCY_CODE"               VARCHAR2(3),
    "RECEIPT_AMOUNT"              NUMBER,
    "PAY_REC_DATE"                DATE,
    "DIFF_IN_DAYS"                NUMBER,
    "BANK_NAME"                   VARCHAR2(60),
    "BANK_BRANCH_NAME"            VARCHAR2(60),
    "DRAWN_BY"                    VARCHAR2(60),
    "PAY_MODE"                    VARCHAR2(30),
    "PAY_MODE_CODE"               VARCHAR2(30),
    "RCT_TYPE"                    VARCHAR2(30),
    "RCT_TYPE_CODE"               VARCHAR2(30),
    "PAY_REF_NUMBER"              VARCHAR2(30),
    "PAY_REF_DATE"                DATE,
    "DESCRIPTION"                 VARCHAR2(4000),
    "TAX_AMOUNT"                  NUMBER,
    "TAX_CODE"                    VARCHAR2(60),
    "TAX_RATE"                    NUMBER,
    "RECOMMENDED_AMOUNT"          NUMBER,
    "RECEIVED_AMOUNT"             NUMBER,
    "RECEIPT_DTL_ID"              NUMBER,
    "BOOKING_TYPE"                VARCHAR2(100),
    "BOOKING_MS_DTL_ID"           NUMBER,
    "AMOUNT_APPLIED"              NUMBER,
    "APPLIED_DATE"                DATE,
    "CUSTOMER_TRX"                VARCHAR2(240),
    "CUSTOMER_TRX_ID"             NUMBER,
    "RECEIVABLE_APPLICATION"      VARCHAR2(100),
    "RECEIVABLE_APPLICATION_ID"   NUMBER,
    "STATUS"                      VARCHAR2(30),
    "ERROR_MSG"                   VARCHAR2(4000)
);
--------------------------------------------------------
--  DDL for Table XXSTG_SALESPERSON
--------------------------------------------------------

CREATE TABLE "XXSTG_SALESPERSON" (
    "SP_ID"               NUMBER,
    "SP_NAME"             VARCHAR2(240),
    "SP_NAME_TL"          VARCHAR2(240),
    "SP_NUMBER"           VARCHAR2(30),
    "EMAIL_ID"            VARCHAR2(60),
    "CONTACT_NUMBER"      VARCHAR2(60),
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_SALESPERSON_PK" ON "XXSTG_SALESPERSON" ("SP_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_VENDOR
--------------------------------------------------------

CREATE TABLE "XXSTG_VENDOR" (
    "VEND_ID"             NUMBER,
    "VENDOR_NUMBER"       VARCHAR2(30),
    "VENDOR_NAME"         VARCHAR2(240),
    "VENDOR_NAME_TL"      VARCHAR2(240),
    "ORIG_SYSTEM_REF"     NUMBER,
    "PROFESSION"          VARCHAR2(240),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXSTG_VENDOR_U1" ON "XXSTG_VENDOR" ("VEND_ID");

--------------------------------------------------------
--  DDL for Table XXSTG_VEND_CONTACTS
--------------------------------------------------------

CREATE TABLE "XXSTG_VEND_CONTACTS" (
    "VEND_CONTACT_ID"        NUMBER,
    "VEND_ID"                NUMBER,
    "VEND_SITE_ID"           NUMBER,
    "CONTACT_NAME"           VARCHAR2(240),
    "CONTACT_NAME_TL"        VARCHAR2(240),
    "DESIGNATION"            VARCHAR2(60),
    "MOBILE_NUMBER"          VARCHAR2(60),
    "PHONE_NUMBER"           VARCHAR2(60),
    "FAX_NUMBER"             NUMBER,
    "EMAIL_ID"               VARCHAR2(60),
    "PASSPORT_NUMBER"        VARCHAR2(60),
    "PASSPORT_EXP_DATE"      DATE,
    "NATIONAL_ID_NUMBER"     VARCHAR2(60),
    "NATIONAL_ID_EXP_DATE"   DATE,
    "ORIG_SYSTEM_REF"        NUMBER,
    "ACTIVE_YN"              VARCHAR2(1),
    "CREATED_BY"             VARCHAR2(60),
    "CREATION_DATE"          TIMESTAMP(6),
    "LAST_UPDATED_BY"        VARCHAR2(60),
    "LAST_UPDATE_DATE"       TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"      VARCHAR2(150)
);

--------------------------------------------------------
--  DDL for Table XXSTG_VEND_SITES
--------------------------------------------------------

CREATE TABLE "XXSTG_VEND_SITES" (
    "VEND_SITE_ID"        NUMBER,
    "VEND_ID"             NUMBER,
    "SITE_NUMBER"         VARCHAR2(30),
    "ADDRESS1"            VARCHAR2(240),
    "ADDRESS2"            VARCHAR2(240),
    "ADDRESS3"            VARCHAR2(240),
    "ADDRESS4"            VARCHAR2(240),
    "CITY"                VARCHAR2(60),
    "POSTAL_CODE"         VARCHAR2(60),
    "STATE"               VARCHAR2(60),
    "PROVINCE"            VARCHAR2(60),
    "COUNTY"              VARCHAR2(60),
    "COUNTRY"             VARCHAR2(60),
    "ORG_ID"              NUMBER,
    "ORIG_SYSTEM_REF"     NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE unique index "XXSTG_VEND_SITES_PK" ON "XXSTG_VEND_SITES" ( "VEND_SITE_ID" );

ALTER INDEX XXSTG_BANKS_PK				 RENAME TO XXSTG_BANKS_U1;
ALTER INDEX XXSTG_GL_CODE_COMBINATION_PK RENAME TO XXSTG_GL_CODE_COMBINATION_U1;
ALTER INDEX XXSTG_LEAD_PK				 RENAME TO XXSTG_LEAD_U1;
ALTER INDEX XXSTG_LOCATIONS_PK			 RENAME TO XXSTG_LOCATIONS_U1;
ALTER INDEX XXSTG_PAY_TERMS_PK			 RENAME TO XXSTG_PAY_TERMS_U1;
ALTER INDEX XXSTG_POSITIONS_PK			 RENAME TO XXSTG_POSITIONS_U1;
ALTER INDEX XXSTG_PROJECTS_PK			 RENAME TO XXSTG_PROJECTS_U1;
ALTER INDEX XXSTG_PROJECT_MILESTONES_PK	 RENAME TO XXSTG_PROJECT_MILESTONES_U1;
ALTER INDEX XXSTG_SALESPERSON_PK		 RENAME TO XXSTG_SALESPERSON_U1;
ALTER INDEX XXSTG_VEND_SITES_PK			 RENAME TO XXSTG_VEND_SITES_U1;
ALTER INDEX XXSTG_BANK_ACCOUNTS_PK	RENAME TO XXSTG_BANK_ACCOUNTS_U1;
ALTER INDEX XXSTG_CUST_CONTACTS_PK			RENAME TO XXSTG_CUST_CONTACTS_U1;
ALTER INDEX XXSTG_CUST_SITES_PK			RENAME TO XXSTG_CUST_SITES_U1;


CREATE TABLE XXPM_INVOICE_NUMBER
   (
"PROJ_ID" NUMBER NOT NULL,
"PROJECT_NAME" VARCHAR2(240),
"PROJECT_NUMBER" VARCHAR2(25),
"ORG_ID" NUMBER,
"START_DATE" DATE,
"COMPLETION_DATE" DATE,
"CLOSED_DATE" DATE,
"COST_CENTER_CODE" VARCHAR2(60),
"ORIG_SYSTEM_REF" NUMBER,
"ACTIVE_YN" VARCHAR2(1),
"CREATED_BY" VARCHAR2(60),
"CREATION_DATE" TIMESTAMP (6),
"LAST_UPDATED_BY" VARCHAR2(60),
"LAST_UPDATE_DATE" TIMESTAMP (6),
"LAST_UPDATE_LOGIN" VARCHAR2(150),
"INV_PREFIX" VARCHAR2(10),
"SEQ_NO" NUMBER
);