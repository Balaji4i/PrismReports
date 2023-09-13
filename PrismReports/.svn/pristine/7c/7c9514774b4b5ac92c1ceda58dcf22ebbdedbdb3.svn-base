--------------------------------------------------------
--  File created - Monday-August-12-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXPL_OWNER_DTLE
--------------------------------------------------------
CREATE TABLE "XXPL_OWNER_DTLE" (
    "OWNER_ID"             NUMBER,
    "PROPERTY_ID"          NUMBER,
    "BUILD_ID"             NUMBER,
    "UNIT_ID"              NUMBER,
    "VEND_ID"              NUMBER,
    "VEND_SITE_ID"         NUMBER,
    "PRIMARY_YN"           VARCHAR2(1),
    "DESCRIPTION"          VARCHAR2(4000),
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

   CREATE UNIQUE INDEX "XXPL_OWNER_DTLE_U1" ON
        "XXPL_OWNER_DTLE" (
            "OWNER_ID"
        );
--------------------------------------------------------
--  DDL for Table XXTEST_APPLY_RECEIPT_T
--------------------------------------------------------

CREATE TABLE "XXTEST_APPLY_RECEIPT_T" (
    "S_NO"               NUMBER,
    "CASH_RECEIPT_ID"    NUMBER,
    "CUSTOMER_TRX_ID"    NUMBER,
    "AMOUNT_APPLIED"     NUMBER,
    "APPLICATION_DATE"   DATE,
    "ACCOUNTING_DATE"    DATE,
    "STATUS"             VARCHAR2(100),
    "ERROR_MSG"          VARCHAR2(1000)
)
--------------------------------------------------------
--  DDL for Table XXREP_PROJECT
--------------------------------------------------------

CREATE TABLE "XXREP_PROJECT" (
    "PROJECT_ID"       NUMBER,
    "PROJECT_NUMBER"   VARCHAR2(25),
    "PROJECT_NAME"     VARCHAR2(240),
    "PLOT_NUM"         VARCHAR2(150),
    "BASELINE_DATE"    DATE,
    "ORG_ID"           NUMBER
)
--------------------------------------------------------
--  DDL for Table XXREP_PROJECT_BUDGET
--------------------------------------------------------

CREATE TABLE "XXREP_PROJECT_BUDGET" (
    "PROJECT_ID"         NUMBER,
    "TASK_ID"            NUMBER,
    "BUDGET_VALUE_O"     NUMBER,
    "BUDGET_VALUE_C"     NUMBER,
    "BUDGET_VALUE_P"     NUMBER,
    "PVO_APPROVED_LM"    NUMBER,
    "PVO_SUBMITTED_LM"   NUMBER,
    "PVO_APPROVED"       NUMBER,
    "PVO_SUBMITTED"      NUMBER,
    "PC_PAID"            NUMBER,
    "VENDOR_NAME"        VARCHAR2(255),
    "CONTRACT_VALUE_O"   NUMBER,
    "VO_LM"              NUMBER,
    "VO"                 NUMBER
)
--------------------------------------------------------
--  DDL for Table XXREP_PROJECT_SUMMARY
--------------------------------------------------------

CREATE TABLE "XXREP_PROJECT_SUMMARY" (
    "BATCH_ID"         NUMBER,
    "PROJECT_ID"       NUMBER,
    "PROJECT_NUM"      VARCHAR2(25),
    "PROJECT_NAME"     VARCHAR2(240),
    "PROJECT_STATUS"   VARCHAR2(80),
    "BU_ID"            NUMBER,
    "BUDGET_VALUE_O"   NUMBER,
    "BUDGET_VALUE_C"   NUMBER,
    "BUDGET_VALUE_P"   NUMBER,
    "CONTRACT_VALUE"   NUMBER,
    "PVO_APPROVED"     NUMBER,
    "PVO_SUBMITTED"    NUMBER,
    "VO"               NUMBER,
    "LAND_AREA"        NUMBER,
    "FLOOR_AREA"       NUMBER,
    "SALEABLE_AREA"    NUMBER,
    "BUILD_AREA"       NUMBER,
    "PC_AMOUNT"        NUMBER,
    "PC_PAID"          NUMBER,
    "REVENUE_VALUE"    NUMBER
)
--------------------------------------------------------
--  DDL for Table XXREP_TASK
--------------------------------------------------------

CREATE TABLE "XXREP_TASK" (
    "PROJECT_ID"         NUMBER,
    "TASK_ID"            NUMBER,
    "TASK_NUMBER"        VARCHAR2(100),
    "TASK_NAME"          VARCHAR2(255),
    "DISPLAY_SEQUENCE"   NUMBER,
    "TOP_TASK_ID"        NUMBER,
    "WBS_LEVEL"          NUMBER,
    "PARENT_TASK_ID"     NUMBER,
    "SUB_CONTRACTOR"     VARCHAR2(255),
    "CONTRACT_AMOUNT"    NUMBER,
    "PC_AMOUNT"          NUMBER,
    "PC_AMOUNT_PAID"     NUMBER
)
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
)
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
)

 
