--------------------------------------------------------
--  File created - Sunday-August-11-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXDMPL_OWNER_DTLE
--------------------------------------------------------
CREATE TABLE "XXDMPL_OWNER_DTLE" (
    "OWNER_ID"                VARCHAR2(60),
    "PROPERTY_NUMBER"         VARCHAR2(60),
    "BUILD_NUMBER"            VARCHAR2(60),
    "UNIT_NUMBER"             VARCHAR2(60),
    "VEND_ID"                 VARCHAR2(60),
    "VEND_SITE_ID"            VARCHAR2(60),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "PRIMARY_YN"              VARCHAR2(1),
    "DESCRIPTION"             VARCHAR2(4000)
);

CREATE unique index "XXDMPL_OWNER_DTLE_U1" ON "XXDMPL_OWNER_DTLE" ("OWNER_ID");

--------------------------------------------------------
--  DDL for Table XXDM_BOOKING_CUSTOMER
--------------------------------------------------------

CREATE TABLE "XXDM_BOOKING_CUSTOMER" (
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
    "LAST_UPDATE_LOGIN"    VARCHAR2(150),
    "STATUS_FLAG"          VARCHAR2(5),
    "ERR_MESSAGE"          VARCHAR2(500)
);

CREATE unique index "XXDM_BOOKING_CUSTOMER_U1" ON "XXDM_BOOKING_CUSTOMER" ("BOOKING_CUST_ID");

--------------------------------------------------------
--  DDL for Table XXDM_BOOKING_DETAIL
--------------------------------------------------------

CREATE TABLE "XXDM_BOOKING_DETAIL" (
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
CREATE unique index "XXDM_BOOKING_DETAIL_U1" ON "XXDM_BOOKING_DETAIL" ("BOOKING_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXDM_BOOKING_HEADER
--------------------------------------------------------

CREATE TABLE "XXDM_BOOKING_HEADER" (
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
    "STATUS_FLAG"             VARCHAR2(5),
    "ERR_MESSAGE"             VARCHAR2(500)
);
CREATE unique index "XXDM_BOOKING_HEADER_U1" ON "XXDM_BOOKING_HEADER" ("BOOKING_HDR_ID");

--------------------------------------------------------
--  DDL for Table XXDM_EXCEL_STG_MAPPING
--------------------------------------------------------

CREATE TABLE "XXDM_EXCEL_STG_MAPPING" (
    "ESM_ID"              NUMBER,
    "IFACE_ID"            NUMBER,
    "STG_COLUMN_NAME"     VARCHAR2(60),
    "EXCEL_COLUMN_NUM"    NUMBER,
    "PROMPT_NAME"         VARCHAR2(60),
    "DISPLAY_IN_PAGE"     VARCHAR2(1),
    "MANDATORY"           VARCHAR2(1) DEFAULT 'N',
    "DEFAULT_VALUE"       VARCHAR2(500),
    "DATA_TYPE"           VARCHAR2(60),
    "CREATED_BY"          VARCHAR2(100),
    "CREATION_DATE"       DATE,
    "LAST_UPDATED_BY"     VARCHAR2(100),
    "LAST_UPDATE_DATE"    DATE,
    "LAST_UPDATE_LOGIN"   VARCHAR2(100)
);
CREATE unique index "XXDM_EXCEL_STG_MAPPING_U1" ON "XXDM_EXCEL_STG_MAPPING" ("ESM_ID");

--------------------------------------------------------
--  DDL for Table XXDM_INTERFACE
--------------------------------------------------------

CREATE TABLE "XXDM_INTERFACE" (
    "BATCH_ID"            NUMBER,
    "IFACE_ID"            NUMBER,
    "FILE_NAME"           VARCHAR2(240),
    "UPLOADED_FILE"       BLOB,
    "UPLOAD_FROM"         NUMBER,
    "STATUS"              VARCHAR2(30),
    "UPLOADED_BY"         VARCHAR2(100),
    "UPLOAD_DATE"         DATE,
    "VALIDATED_BY"        VARCHAR2(100),
    "VALIDATE_DATE"       DATE,
    "PROCESSED_BY"        VARCHAR2(100),
    "PROCESS_DATE"        DATE,
    "CREATED_BY"          VARCHAR2(100),
    "CREATION_DATE"       DATE,
    "LAST_UPDATED_BY"     VARCHAR2(100),
    "LAST_UPDATE_DATE"    DATE,
    "LAST_UPDATE_LOGIN"   VARCHAR2(100)
);

CREATE unique index "XXDM_INTERFACE_U1" ON "XXDM_INTERFACE" ("BATCH_ID");

--------------------------------------------------------
--  DDL for Table XXDM_INTERFACE_MASTER
--------------------------------------------------------

CREATE TABLE "XXDM_INTERFACE_MASTER" (
    "IFACE_ID"                     NUMBER,
    "IFACE_NAME"                   VARCHAR2(100),
    "IFACE_SHORT_NAME"             VARCHAR2(30),
    "STAGING_TABLE"                VARCHAR2(60),
    "VALIDATION_PROC"              VARCHAR2(60),
    "PROCESS_PROC"                 VARCHAR2(60),
    "DATA_EXTRACTION_PROC"         VARCHAR2(60),
    "DATA_EXTRACTION_OBJ_TYPE"     VARCHAR2(60),
    "DATA_EXTRACTION_TABLE_TYPE"   VARCHAR2(60),
    "PARENT_IFACE_ID"              NUMBER,
    "LOOKUP_TYPE"                  VARCHAR2(1000),
    "DEFAULT_TAB"                  VARCHAR2(1000),
    "DISPLAY_ORDER"                NUMBER,
    "CREATED_BY"                   VARCHAR2(100),
    "CREATION_DATE"                DATE,
    "LAST_UPDATED_BY"              VARCHAR2(100),
    "LAST_UPDATE_DATE"             DATE,
    "LAST_UPDATE_LOGIN"            VARCHAR2(100)
);

CREATE unique index "XXDM_INTERFACE_MASTER_U1" ON "XXDM_INTERFACE_MASTER" ("IFACE_ID");

--------------------------------------------------------
--  DDL for Table XXDM_INVOICE_HEADER
--------------------------------------------------------

CREATE TABLE "XXDM_INVOICE_HEADER" (
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
CREATE unique index "XXDM_INVOICE_HEADER_U1" ON "XXDM_INVOICE_HEADER" ("INVOICE_ID");
--------------------------------------------------------
--  DDL for Table XXDM_INVOICE_LINES
--------------------------------------------------------

CREATE TABLE "XXDM_INVOICE_LINES" (
    "INVOICE_ID"             NUMBER,
    "INVOICE_LINE_ID"        NUMBER,
    "LINE_NUMBER"            NUMBER,
    "DESCRIPTION"            VARCHAR2(240),
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
    "LAST_UPDATE_LOGIN"      VARCHAR2(240)
);
CREATE unique index "XXDM_INVOICE_LINES_U1" ON "XXDM_INVOICE_LINES" ("INVOICE_LINE_ID");
--------------------------------------------------------
--  DDL for Table XXDM_MILESTONE_DTL
--------------------------------------------------------

CREATE TABLE "XXDM_MILESTONE_DTL" (
    "MS_DTL_ID"               VARCHAR2(20),
    "MILESTONE_NUMBER"        VARCHAR2(20),
    "SEQ_NUMBER"              VARCHAR2(20),
    "INSTALLMENT_TYPE"        VARCHAR2(60),
    "INSTALLMENT_PCT"         VARCHAR2(20),
    "CHARGE_TYPE"             VARCHAR2(60),
    "PAYMENT_TERM"            VARCHAR2(60),
    "REMARKS"                 VARCHAR2(4000),
    "DUE_DAYS"                VARCHAR2(20),
    "DUE_DAYS_FROM"           VARCHAR2(60),
    "PROJ_MS_ID"              VARCHAR2(20),
    "DUE_DATE"                VARCHAR2(11),
    "REVISION"                VARCHAR2(20),
    "REVISION_DATE"           VARCHAR2(11),
    "REVISED_BY"              VARCHAR2(60),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           DATE DEFAULT SYSDATE,
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        DATE DEFAULT SYSDATE,
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "INSTALLMENT_METHOD"      VARCHAR2(30),
    "INSTALLMENT_EVENT"       VARCHAR2(240),
    "PERIOD_OCCURENCE"        VARCHAR2(30),
    "PERIOD_VALUES"           VARCHAR2(30),
    "PERIOD_DURATION"         VARCHAR2(30),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "ACTION_FLAG"             VARCHAR2(5),
    "PROCESS_FLAG"            VARCHAR2(5),
    "INSERT_HISTORY_FLAG"     VARCHAR2(5)
);

CREATE unique index "XXDM_MILESTONE_DTL_U1" ON "XXDM_MILESTONE_DTL" ("MS_DTL_ID");
--------------------------------------------------------
--  DDL for Table XXDM_MILESTONE_HDR
--------------------------------------------------------

CREATE TABLE "XXDM_MILESTONE_HDR" (
    "MS_HDR_ID"               VARCHAR2(20),
    "MILESTONE_NAME"          VARCHAR2(240),
    "MILESTONE_NAME_TL"       VARCHAR2(240),
    "MILESTONE_NUMBER"        VARCHAR2(240),
    "MILESTONE_SHORTCODE"     VARCHAR2(60),
    "MILESTONE_DATE"          VARCHAR2(11),
    "ORG_ID"                  VARCHAR2(20),
    "PROJECT_ID"              VARCHAR2(20),
    "USAGE"                   VARCHAR2(30),
    "REVISION_NO"             VARCHAR2(20),
    "REVISION_DATE"           VARCHAR2(11),
    "REVISED_BY"              VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(4000),
    "START_DATE"              VARCHAR2(11),
    "END_DATE"                VARCHAR2(11),
    "ACTIVE_YN"               VARCHAR2(1),
    "STATUS"                  VARCHAR2(60),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           DATE DEFAULT SYSDATE,
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        DATE DEFAULT SYSDATE,
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "ACTION_FLAG"             VARCHAR2(5),
    "PROCESS_FLAG"            VARCHAR2(5),
    "INSERT_HISTORY_FLAG"     VARCHAR2(5)
);
CREATE unique index "XXDM_MILESTONE_HDR_U1" ON "XXDM_MILESTONE_HDR" ("MS_HDR_ID");

--------------------------------------------------------
--  DDL for Table XXDM_OFFER_DETAIL
--------------------------------------------------------

CREATE TABLE "XXDM_OFFER_DETAIL" (
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
CREATE unique index "XXDM_OFFER_DETAIL_U1" ON "XXDM_OFFER_DETAIL" ("OFFER_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXDM_OFFER_HEADER
--------------------------------------------------------

CREATE TABLE "XXDM_OFFER_HEADER" (
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
    "STATUS_FLAG"              VARCHAR2(10),
    "ERR_MESSAGE"              VARCHAR2(1000)
);
CREATE unique index "XXDM_OFFER_HEADER_U1" ON "XXDM_OFFER_HEADER" ("OFFER_HDR_ID");

--------------------------------------------------------
--  DDL for Table XXDM_OFFER_MILESTONE_DETAIL
--------------------------------------------------------

CREATE TABLE "XXDM_OFFER_MILESTONE_DETAIL" (
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
    "INSTALLMENT_EVENT"    VARCHAR2(30),
    "PERIOD_OCCURENCE"     VARCHAR2(30),
    "PERIOD_VALUES"        NUMBER,
    "PERIOD_DURATION"      VARCHAR2(30),
    "INCLUDED_IN_RATE"     VARCHAR2(30)
);

CREATE unique index "XXDM_OFFER_MILESTONE_DETAIL_U1" ON "XXDM_OFFER_MILESTONE_DETAIL" ("OFFER_MS_DTL_ID");
--------------------------------------------------------
--  DDL for Table XXDM_PL_HEADER
--------------------------------------------------------

CREATE TABLE "XXDM_PL_HEADER" (
    "PL_ID"                   VARCHAR2(20),
    "PL_NAME"                 VARCHAR2(240),
    "PL_NAME_TL"              VARCHAR2(240),
    "PL_NUMBER"               VARCHAR2(240),
    "ORG_ID"                  VARCHAR2(20),
    "DESCRIPTION"             VARCHAR2(4000),
    "PL_TYPE"                 VARCHAR2(240),
    "PRIORITY"                VARCHAR2(240),
    "USAGE"                   VARCHAR2(4000),
    "CURRENCY_CODE"           VARCHAR2(240),
    "START_DATE"              VARCHAR2(100),
    "END_DATE"                VARCHAR2(100),
    "REVISION_NO"             VARCHAR2(100),
    "REVISION_DATE"           VARCHAR2(100),
    "REVISED_BY"              VARCHAR2(100),
    "STATUS"                  VARCHAR2(100),
    "FLOW_STATUS"             VARCHAR2(100),
    "FLOW_WITH"               VARCHAR2(100),
    "FLOW_LEVEL"              VARCHAR2(100),
    "USER_GRP_ID"             VARCHAR2(100),
    "BASE_PRICE_YN"           VARCHAR2(100),
    "ACTIVE_YN"               VARCHAR2(1),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           VARCHAR2(111),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        VARCHAR2(111),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "OLD_STATUS"              VARCHAR2(100)
);
CREATE unique index "XXDM_PL_HEADER_U1" ON "XXDM_PL_HEADER" ("PL_ID");
--------------------------------------------------------
--  DDL for Table XXDM_PL_LINES
--------------------------------------------------------

CREATE TABLE "XXDM_PL_LINES" (
    "PLL_ID"                  VARCHAR2(20),
    "PL_NUMBER"               VARCHAR2(200),
    "PROPERTY_NUMBER"         VARCHAR2(200),
    "BUILD_NUMBER"            VARCHAR2(200),
    "UNIT_NUMBER"             VARCHAR2(200),
    "UOM"                     VARCHAR2(20),
    "BASE_PRICE"              VARCHAR2(200),
    "MIN_PRICE"               VARCHAR2(200),
    "START_DATE"              VARCHAR2(200),
    "END_DATE"                VARCHAR2(200),
    "REVISION_NO"             VARCHAR2(200),
    "REVISION_DATE"           VARCHAR2(200),
    "REVISED_BY"              VARCHAR2(200),
    "ACTIVE_YN"               VARCHAR2(2),
    "CREATED_BY"              VARCHAR2(200),
    "CREATION_DATE"           VARCHAR2(200),
    "LAST_UPDATED_BY"         VARCHAR2(200),
    "LAST_UPDATE_DATE"        VARCHAR2(200),
    "LAST_UPDATE_LOGIN"       VARCHAR2(200),
    "BUILD_ID"                VARCHAR2(200),
    "INTERFACE_STATUS_FLAG"   VARCHAR2(200),
    "INTERFACE_ID"            VARCHAR2(200),
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(4000),
    "BATCH_ID"                VARCHAR2(200),
    "PROPERTY_ID"             VARCHAR2(200),
    "UNIT_ID"                 VARCHAR2(200),
    "HISTORY_INSERT"          VARCHAR2(20)
);

CREATE unique index "XXDM_PL_LINES_U1" ON "XXDM_PL_LINES" ("PLL_ID");

--------------------------------------------------------
--  DDL for Table XXDM_PL_MODIFIERS
--------------------------------------------------------

CREATE TABLE "XXDM_PL_MODIFIERS" (
    "PL_MOD_ID"               VARCHAR2(200),
    "PL_NUMBER"               VARCHAR2(200),
    "MOD_ID"                  VARCHAR2(200),
    "START_DATE"              VARCHAR2(200),
    "END_DATE"                VARCHAR2(200),
    "REVISION_NO"             VARCHAR2(200),
    "REVISION_DATE"           VARCHAR2(200),
    "REVISED_BY"              VARCHAR2(200),
    "ACTIVE_YN"               VARCHAR2(2),
    "CREATED_BY"              VARCHAR2(200),
    "CREATION_DATE"           VARCHAR2(200),
    "LAST_UPDATED_BY"         VARCHAR2(200),
    "LAST_UPDATE_DATE"        VARCHAR2(200),
    "LAST_UPDATE_LOGIN"       VARCHAR2(200),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "PL_ID"                   NUMBER,
    "PL_MOD_NUMBER"           VARCHAR2(50),
    "HISTORY_INSERT"          VARCHAR2(20)
);
CREATE unique index "XXDM_PL_MODIFIERS_U1" ON "XXDM_PL_MODIFIERS" ("PL_MOD_ID");
--------------------------------------------------------
--  DDL for Table XXDM_PL_QUALIFIERS
--------------------------------------------------------

CREATE TABLE "XXDM_PL_QUALIFIERS" (
    "PL_QLFY_ID"              VARCHAR2(200),
    "PL_MOD_ID"               VARCHAR2(200),
    "QLFY_ID"                 VARCHAR2(200),
    "START_DATE"              VARCHAR2(200),
    "END_DATE"                VARCHAR2(200),
    "REVISION_NO"             VARCHAR2(200),
    "REVISION_DATE"           VARCHAR2(200),
    "REVISED_BY"              VARCHAR2(200),
    "ACTIVE_YN"               VARCHAR2(2),
    "CREATED_BY"              VARCHAR2(200),
    "CREATION_DATE"           VARCHAR2(200),
    "LAST_UPDATED_BY"         VARCHAR2(200),
    "LAST_UPDATE_DATE"        VARCHAR2(200),
    "LAST_UPDATE_LOGIN"       VARCHAR2(200),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "PL_MOD_NUMBER"           VARCHAR2(50),
    "HISTORY_INSERT"          VARCHAR2(20)
);
CREATE unique index "XXDM_PL_QUALIFIERS_U1" ON "XXDM_PL_QUALIFIERS" ("PL_QLFY_ID");
--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_AREA
--------------------------------------------------------

CREATE TABLE "XXDM_PROPERTY_AREA" (
    "PROPERTY_NUMBER"         VARCHAR2(60),
    "BUILD_NUMBER"            VARCHAR2(60),
    "UNIT_NUMBER"             VARCHAR2(60),
    "AREA"                    VARCHAR2(60),
    "UOM"                     VARCHAR2(60),
    "VALUE"                   VARCHAR2(20),
    "DESCRIPTION"             VARCHAR2(4000),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "PROPERTY_ID"             NUMBER,
    "BUILD_ID"                NUMBER,
    "UNIT_ID"                 NUMBER,
    "AREA_ID"                 VARCHAR2(60),
    "DIFF_VAL"                NUMBER
);
CREATE unique index "XXDM_PROPERTY_AREA_U1" ON "XXDM_PROPERTY_AREA" ("AREA_ID");
--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_CARPARKS
--------------------------------------------------------

CREATE TABLE "XXDM_PROPERTY_CARPARKS" (
    "CARPARK_ID"              VARCHAR2(60),
    "UNIT_NUMBER"             VARCHAR2(60),
    "CP_UNIT_NUMBER"          VARCHAR2(60),
    "ALLOT_TYPE"              VARCHAR2(4000),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "UNIT_ID"                 NUMBER,
    "CP_UNIT_ID"              NUMBER
);
CREATE unique index "XXDM_PROPERTY_CARPARKS_U1" ON "XXDM_PROPERTY_CARPARKS" ("CARPARK_ID");

--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_FEATURES
--------------------------------------------------------

CREATE TABLE "XXDM_PROPERTY_FEATURES" (
    "FEATURE_ID"              VARCHAR2(60),
    "PROPERTY_NUMBER"         VARCHAR2(60),
    "BUILD_NUMBER"            VARCHAR2(60),
    "UNIT_NUMBER"             VARCHAR2(60),
    "FEATURE_TYPE"            VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(4000),
    "FEATURE_CONDITION"       VARCHAR2(60),
    "UOM"                     VARCHAR2(60),
    "VALUE"                   VARCHAR2(20),
    "QUANTITY"                VARCHAR2(20),
    "RATE"                    VARCHAR2(20),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "BUILD_ID"                VARCHAR2(40),
    "PROPERTY_ID"             VARCHAR2(40),
    "UNIT_ID"                 VARCHAR2(40)
);
CREATE unique index "XXDM_PROPERTY_FEATURES_U1" ON "XXDM_PROPERTY_FEATURES" ("FEATURE_ID");

--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_FIX_FITTINGS
--------------------------------------------------------

CREATE TABLE "XXDM_PROPERTY_FIX_FITTINGS" (
    "FIX_ID"                  VARCHAR2(60),
    "PROPERTY_NUMBER"         VARCHAR2(60),
    "BUILD_NUMBER"            VARCHAR2(60),
    "UNIT_NUMBER"             VARCHAR2(60),
    "FIX_CATEGORY"            VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(4000),
    "FIX_CONDITION"           VARCHAR2(60),
    "UOM"                     VARCHAR2(60),
    "VALUE"                   VARCHAR2(20),
    "QUANTITY"                VARCHAR2(20),
    "RATE"                    VARCHAR2(20),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "UNIT_ID"                 VARCHAR2(40),
    "BUILD_ID"                VARCHAR2(40),
    "PROPERTY_ID"             VARCHAR2(40)
);
CREATE unique index "XXDM_PROPERTY_FIX_FITTINGS_U1" ON "XXDM_PROPERTY_FIX_FITTINGS" ("FIX_ID");

--------------------------------------------------------
--  DDL for Table XXDM_PROPERTY_UNITS
--------------------------------------------------------

CREATE TABLE "XXDM_PROPERTY_UNITS" (
    "PROPERTY_NUMBER"         VARCHAR2(60),
    "BUILD_NUMBER"            VARCHAR2(60),
    "UNIT_NUMBER"             VARCHAR2(60),
    "UNIT_NAME"               VARCHAR2(240),
    "UNIT_NAME_TL"            VARCHAR2(240),
    "UNIT_SHORTCODE"          VARCHAR2(60),
    "FUNC_ID"                 NUMBER,
    "DOC_REF_NUMBER_1"        VARCHAR2(60),
    "DOC_REF_NUMBER_2"        VARCHAR2(60),
    "DOC_REF_NUMBER_3"        VARCHAR2(60),
    "FLOOR_NUMBER"            VARCHAR2(60),
    "NO_OF_ROOMS"             VARCHAR2(20),
    "UNIT_TYPE"               VARCHAR2(60),
    "STATUS"                  VARCHAR2(60),
    "UNIT_CLASS"              VARCHAR2(60),
    "UNIT_CATEGORY"           VARCHAR2(60),
    "DESCRIPTION"             VARCHAR2(4000),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "SALEABLE_YN"             VARCHAR2(1),
    "LEASEABLE_YN"            VARCHAR2(1),
    "SALE_AVAILABLE_YN"       VARCHAR2(1),
    "LEASE_AVAILABLE_YN"      VARCHAR2(1),
    "FREE_HOLD_YN"            VARCHAR2(1),
    "LEASE_HOLD_YN"           VARCHAR2(1),
    "LIST_FOR_BROKERS"        VARCHAR2(1),
    "LIST_FOR_INTERNAL"       VARCHAR2(1),
    "ALLOT_TYPE"              VARCHAR2(30),
    "BATCH_ID"                NUMBER,
    "INTERFACE_STATUS_FLAG"   VARCHAR2(1),
    "INTERFACE_ID"            NUMBER,
    "ERR_MSG"                 VARCHAR2(2000),
    "ERR_DESCRIPTION"         VARCHAR2(2000),
    "VALIDATED_BY"            VARCHAR2(60),
    "VALIDATED_DATE"          TIMESTAMP(6),
    "PROCESSED_BY"            VARCHAR2(60),
    "PROCESSED_DATE"          TIMESTAMP(6),
    "AREA_TYPE"               VARCHAR2(400),
    "VIEW_TYPE"               VARCHAR2(400),
    "UOM"                     VARCHAR2(400),
    "VEND_ID"                 VARCHAR2(400),
    "ACTIVE_YN"               VARCHAR2(4),
    "PROPERTY_ID"             NUMBER,
    "BUILD_ID"                NUMBER,
    "UNIT_ID"                 NUMBER,
    "CP_UNIT_ID"              NUMBER
);
CREATE unique index "XXDM_PROPERTY_UNITS_U1" ON "XXDM_PROPERTY_UNITS" ("UNIT_ID");

--------------------------------------------------------
--  DDL for Table XXDM_RECEIPT
--------------------------------------------------------

CREATE TABLE "XXDM_RECEIPT" (
    "RECEIPT_ID"            NUMBER,
    "FUNC_ID"               NUMBER,
    "SOURCE_FUNC_ID"        NUMBER,
    "SOURCE_FUNC_REF_ID"    NUMBER,
    "RECEIPT_NUMBER"        VARCHAR2(30),
    "RECEIPT_DATE"          DATE,
    "ORG_ID"                NUMBER,
    "RECEIPT_TYPE"          VARCHAR2(30),
    "PROPERTY_ID"           NUMBER,
    "UNIT_ID"               NUMBER,
    "BUILD_ID"              NUMBER,
    "LEAD_ID"               NUMBER,
    "CUST_ID"               NUMBER,
    "CUST_SITE_ID"          NUMBER,
    "SALESMAN_ID"           NUMBER,
    "CUSTOMER_NAME"         VARCHAR2(240),
    "CURRENCY_CODE"         VARCHAR2(3),
    "RECEIPT_AMOUNT"        NUMBER,
    "PAY_MODE"              NUMBER,
    "PAY_REF_NUMBER"        VARCHAR2(30),
    "PAY_REF_DATE"          DATE,
    "BANK_NAME"             VARCHAR2(60),
    "BANK_BRANCH_NAME"      VARCHAR2(60),
    "DRAWN_BY"              VARCHAR2(60),
    "STATUS"                VARCHAR2(60),
    "DESCRIPTION"           VARCHAR2(4000),
    "FLOW_STATUS"           VARCHAR2(60),
    "FLOW_LEVEL"            NUMBER,
    "FLOW_WITH"             NUMBER,
    "TAX_AMOUNT"            NUMBER,
    "TAX_CODE"              VARCHAR2(60),
    "TAX_RATE"              NUMBER,
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
    "LAST_UPDATE_LOGIN"     VARCHAR2(150),
    "RECOMMENDED_AMOUNT"    NUMBER,
    "RECEIVED_AMOUNT"       NUMBER,
    "DIFF_IN_DAYS"          NUMBER,
    "PAY_REC_DATE"          DATE,
    "PAY_REV_DATE"          DATE,
    "RCT_TYPE"              VARCHAR2(30),
    "RCT_DESC"              VARCHAR2(150),
    "INTERFACE_STATUS"      VARCHAR2(60),
    "GL_DATE"               DATE,
    "REV_DATE"              DATE,
    "REV_GL_DATE"           DATE,
    "REV_CATEGORY"          VARCHAR2(60),
    "REV_REASON"            VARCHAR2(60),
    "REV_DESC"              VARCHAR2(4000),
    "REV_INT_STATUS"        VARCHAR2(60),
    "RECEIPT_RISK_YN"       VARCHAR2(1),
    "INTERFACE_ERROR_MSG"   CLOB
);
CREATE unique index "XXDM_RECEIPT_U1" ON "XXDM_RECEIPT" ("RECEIPT_ID");

--------------------------------------------------------
--  DDL for Table XXDM_RECEIPT_DETAILS
--------------------------------------------------------

CREATE TABLE "XXDM_RECEIPT_DETAILS" (
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
CREATE unique index "XXDM_RECEIPT_DETAILS_U1" ON "XXDM_RECEIPT_DETAILS" ("RECEIPT_DTL_ID");

--------------------------------------------------------
--  DDL for Table XXDM_SALES_BOOKINGS
--------------------------------------------------------

CREATE TABLE "XXDM_SALES_BOOKINGS" (
    "BUSINESS_UNIT"         VARCHAR2(250),
    "BOOKING_NUMBER"        VARCHAR2(250),
    "BOOKING_DATE"          DATE,
    "PAYMENT_PLAN"          VARCHAR2(250),
    "PRICELIST"             VARCHAR2(250),
    "BOOKING_TYPE"          VARCHAR2(250),
    "CURRENCY"              VARCHAR2(250),
    "BOOKING_FLAG"          VARCHAR2(250),
    "STATUS"                VARCHAR2(250),
    "DESCRIPTION"           VARCHAR2(250),
    "CUSTOMER"              VARCHAR2(250),
    "CUSTOMER_BILL_TO"      VARCHAR2(250),
    "PROPERTY"              VARCHAR2(250),
    "BUILDING"              VARCHAR2(250),
    "UNIT"                  VARCHAR2(250),
    "UOM"                   VARCHAR2(250),
    "BOOKING_AMOUNT"        VARCHAR2(250),
    "DISCOUNT_PERCENTAGE"   VARCHAR2(250),
    "DISCOUNT_AMOUNT"       VARCHAR2(250),
    "TAX_CODE"              VARCHAR2(250),
    "TAX_RATE"              VARCHAR2(250),
    "TAX_AMOUNT"            VARCHAR2(250),
    "STATUS_FLAG"           VARCHAR2(5),
    "ERR_DESC"              VARCHAR2(250),
    "ORG_ID"                NUMBER,
    "CUST_ID"               NUMBER,
    "BILL_TO_SITE_ID"       NUMBER,
    "PROPERTY_ID"           NUMBER,
    "BUILDING_ID"           NUMBER,
    "UNIT_ID"               NUMBER,
    "BOOKING_RATE"          VARCHAR2(250),
    "MS_HDR_ID"             NUMBER,
    "PL_ID"                 NUMBER
);


--------------------------------------------------------
--  DDL for Table XXDM_SALES_INVOICES
--------------------------------------------------------

CREATE TABLE "XXDM_SALES_INVOICES" (
    "INVOICE_NUMBER"                 VARCHAR2(200),
    "INVOICE_DATE"                   DATE,
    "INVOICE_CLASS"                  VARCHAR2(200),
    "BUSINESS_UNIT"                  VARCHAR2(200),
    "CURRENCY_CODE"                  VARCHAR2(20),
    "CUSTOMER_NAME"                  VARCHAR2(200),
    "CUSTOMER_ACCOUNT_NUMBER"        VARCHAR2(200),
    "CUSTOMER_BILL_TO_SITE_NUMBER"   VARCHAR2(200),
    "PAYMENT_TERM"                   VARCHAR2(200),
    "DUE_DATE"                       DATE,
    "STATUS"                         VARCHAR2(20),
    "BOOKING_NUMBER"                 VARCHAR2(200),
    "CUSTOMER_TRANSACTION_NUMBER"    VARCHAR2(200),
    "STATUS_FLAG"                    VARCHAR2(20),
    "ORG_ID"                         NUMBER,
    "CUST_ID"                        NUMBER,
    "BILL_TO_SITE_ID"                NUMBER,
    "PAYMENT_TERM_NAME"              VARCHAR2(200),
    "ERR_DESC"                       VARCHAR2(2000),
    "OFFER_ID"                       NUMBER,
    "BOOKING_ID"                     NUMBER,
    "DESCRIPTION"                    VARCHAR2(250),
    "UOM_CODE"                       VARCHAR2(10),
    "QUANTITY"                       NUMBER,
    "PRICE"                          NUMBER,
    "LINE_AMOUNT"                    NUMBER,
    "TAX_CODE"                       VARCHAR2(250),
    "TAX_PERCENATGE"                 VARCHAR2(100),
    "TAX_AMOUNT"                     NUMBER,
    "CHARGE_TYPE"                    VARCHAR2(100),
    "PROPERTY"                       VARCHAR2(100),
    "BUILDING"                       VARCHAR2(100),
    "UNIT_SHORT_CODE"                VARCHAR2(100),
    "PAYMENT_MILESTONE"              VARCHAR2(2000),
    "SPA_NUMBER"                     VARCHAR2(100),
    "COLLECTED_AMOUNT"               VARCHAR2(100),
    "RECEIPT_STATUS"                 VARCHAR2(100),
    "OUTSTANDING_AMOUNT"             VARCHAR2(100),
    "CHARGE_TYPE_NAME"               VARCHAR2(50),
    "PROPERTY_ID"                    NUMBER,
    "BUILD_ID"                       NUMBER,
    "UNIT_ID"                        NUMBER,
    "INSTALLMENT_TYPE_NAME"          VARCHAR2(100)
);

--------------------------------------------------------
--  DDL for Table XXDM_SALES_MILESTONES
--------------------------------------------------------

CREATE TABLE "XXDM_SALES_MILESTONES" (
    "BOOKING_NUMBER"           VARCHAR2(250),
    "MILESTONE_TYPE"           VARCHAR2(250),
    "INSTALLMENT_TYPE"         VARCHAR2(250),
    "INSTALLMENT_PERCENATGE"   VARCHAR2(250),
    "INSTALLMENT_AMOUNT"       VARCHAR2(250),
    "UOM"                      VARCHAR2(250),
    "QUANTITY"                 VARCHAR2(250),
    "RATE"                     VARCHAR2(250),
    "CHARGE_TYPE"              VARCHAR2(250),
    "PAYMENT_TERM"             VARCHAR2(250),
    "REMARKS"                  VARCHAR2(250),
    "DUE_DAYS"                 VARCHAR2(250),
    "DUE_DAYS_FROM"            DATE,
    "DUE_DATE"                 DATE,
    "INVOICE_NUMBER"           VARCHAR2(250),
    "STATUS_FLAG"              VARCHAR2(5),
    "ERR_DESC"                 VARCHAR2(250),
    "MILESTONE_TYPE_NAME"      VARCHAR2(250),
    "INSTALLMENT_TYPE_NAME"    VARCHAR2(250),
    "CHARGE_TYPE_NAME"         VARCHAR2(250),
    "PAYMENT_TERM_NAME"        VARCHAR2(250),
    "OFFER_HDR_ID"             NUMBER
);

--------------------------------------------------------
--  DDL for Table XXDM_SALES_RECEIPTS
--------------------------------------------------------

CREATE TABLE "XXDM_SALES_RECEIPTS" (
    "RECEIPT_NUMBER"            VARCHAR2(250),
    "INVOICE_NUMBER"            VARCHAR2(250),
    "RECEIPT_DATE"              DATE,
    "BUSINESS_UNIT"             VARCHAR2(250),
    "RECEIPT_TYPE"              VARCHAR2(250),
    "PROPERTY"                  VARCHAR2(250),
    "UNIT"                      VARCHAR2(250),
    "BUILDING"                  VARCHAR2(250),
    "CUSTOMER"                  VARCHAR2(250),
    "CUSTOMER_BILL_TO_SITE"     VARCHAR2(250),
    "CURRENCY"                  VARCHAR2(250),
    "RECEIPT_AMOUNT"            VARCHAR2(250),
    "PAYMENT_MODE"              VARCHAR2(250),
    "PAYMENT_REFERNCE_NUMBER"   VARCHAR2(250),
    "PYAMENT_REFERNCE_DATE"     DATE,
    "BANK_NAME"                 VARCHAR2(250),
    "BANK_BRANCH_NAME"          VARCHAR2(250),
    "STATUS"                    VARCHAR2(250),
    "DESCRIPTION"               VARCHAR2(250),
    "TAX_AMOUNT"                VARCHAR2(250),
    "TAX"                       VARCHAR2(250),
    "TAX_RATE"                  VARCHAR2(250),
    "GL_DATE"                   DATE,
    "PAYMENT_MILESTONE"         VARCHAR2(250),
    "AMOUNT_APPLIED"            VARCHAR2(250),
    "APPLIED_DATE"              DATE,
    "BOOKING_NUMBER"            VARCHAR2(250),
    "SPA_NUMBER"                VARCHAR2(250),
    "STATUS_FLAG"               VARCHAR2(10),
    "ORG_ID"                    NUMBER,
    "PROPERTY_ID"               NUMBER,
    "BUILD_ID"                  NUMBER,
    "UNIT_ID"                   NUMBER,
    "CUST_ID"                   NUMBER,
    "CUST_SITE_ID"              NUMBER,
    "ERR_DESC"                  VARCHAR2(500),
    "INVOICE_ID"                NUMBER,
    "RECEIPT_TYPE_NAME"         VARCHAR2(250),
    "PAY_MODE_ID"               NUMBER,
    "BANK_ACCOUNT_NUM"          VARCHAR2(60)
);
