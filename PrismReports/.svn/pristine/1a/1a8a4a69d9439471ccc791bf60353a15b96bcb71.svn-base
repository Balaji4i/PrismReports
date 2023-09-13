--------------------------------------------------------
--  File created - Sunday-August-11-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXFND_APPR_ATTRIBUTES
--------------------------------------------------------
CREATE TABLE "XXFND_APPR_ATTRIBUTES" (
    "ATTR_ID"             NUMBER,
    "ATTR_GRP_ID"         NUMBER,
    "SEQ_NUMBER"          NUMBER,
    "ATTRIBUTE_COLUMN"    VARCHAR2(10),
    "COLUMN_NAME"         VARCHAR2(30),
    "SRC_TABLE"           VARCHAR2(60),
    "SRC_COLUMN"          VARCHAR2(60),
    "SRC_DISP_COLUMN"     VARCHAR2(60),
    "SRC_LOOKUP_TYPE"     VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

CREATE UNIQUE INDEX "XXFND_APPR_ATTRIBUTES_U1" ON
        "XXFND_APPR_ATTRIBUTES" (
            "ATTR_ID"
        );

--------------------------------------------------------
--  DDL for Table XXFND_APPR_ATTR_COMB
--------------------------------------------------------

CREATE TABLE "XXFND_APPR_ATTR_COMB" (
    "ATTR_COMB_ID"        NUMBER,
    "ATTR_GRP_ID"         NUMBER,
    "ATTRIBUTE1"          VARCHAR2(60),
    "ATTRIBUTE2"          VARCHAR2(60),
    "ATTRIBUTE3"          VARCHAR2(60),
    "ATTRIBUTE4"          VARCHAR2(60),
    "ATTRIBUTE5"          VARCHAR2(60),
    "USER_GRP_ID"         NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "AMOUNT_FROM"         NUMBER,
    "AMOUNT_TO"           NUMBER
);

  CREATE UNIQUE INDEX "XXFND_APPR_ATTR_COMB_U1" ON "XXFND_APPR_ATTR_COMB" ("ATTR_COMB_ID");

--------------------------------------------------------
--  DDL for Table XXFND_APPR_ATTR_GROUP
--------------------------------------------------------

CREATE TABLE "XXFND_APPR_ATTR_GROUP" (
    "ATTR_GRP_ID"         NUMBER,
    "ATTR_GRP_NAME"       VARCHAR2(30),
    "DESCRIPTION"         VARCHAR2(240),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE UNIQUE INDEX "XXFND_APPR_ATTR_GROUP_U1" ON "XXFND_APPR_ATTR_GROUP" ("ATTR_GRP_ID");
--------------------------------------------------------
--  DDL for Table XXFND_APPR_ROLES
--------------------------------------------------------

CREATE TABLE "XXFND_APPR_ROLES" (
    "ROLE_ID"             NUMBER,
    "ROLE_NAME"           VARCHAR2(30),
    "DESCRIPTION"         VARCHAR2(240),
    "ROLE_TYPE"           VARCHAR2(30),
    "ROLE_VALUE"          VARCHAR2(4000),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE UNIQUE INDEX "XXFND_APPR_ROLES_U1" ON "XXFND_APPR_ROLES" ("ROLE_ID");

--------------------------------------------------------
--  DDL for Table XXFND_APPR_USERS
--------------------------------------------------------

CREATE TABLE "XXFND_APPR_USERS" (
    "APPR_USER_ID"        NUMBER,
    "USER_LEVEL_ID"       NUMBER,
    "SEQ_NUMBER"          NUMBER,
    "USER_ID"             NUMBER,
    "APPR_ROLE"           VARCHAR2(30),
    "APPR_ROLE_DESC"      VARCHAR2(240),
    "EMP_ID"              NUMBER,
    "APPR_LIMIT"          NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "APPR_TYPE"           VARCHAR2(30),
    "APPR_BY"             NUMBER
);
  CREATE UNIQUE INDEX "XXFND_APPR_USERS_U1" ON "XXFND_APPR_USERS" ("APPR_USER_ID");

--------------------------------------------------------
--  DDL for Table XXFND_APPR_USER_GROUP
--------------------------------------------------------

CREATE TABLE "XXFND_APPR_USER_GROUP" (
    "USER_GRP_ID"         NUMBER,
    "USER_GRP_NAME"       VARCHAR2(30),
    "DESCRIPTION"         VARCHAR2(240),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXFND_APPR_USER_GROUP_PK" ON "XXFND_APPR_USER_GROUP" ("USER_GRP_ID");

--------------------------------------------------------
--  DDL for Table XXFND_APPR_USER_LEVELS
--------------------------------------------------------

CREATE TABLE "XXFND_APPR_USER_LEVELS" (
    "USER_LEVEL_ID"       NUMBER,
    "USER_GRP_ID"         NUMBER,
    "LEVEL_NO"            NUMBER,
    "LEVEL_NAME"          VARCHAR2(60),
    "LEVEL_TYPE"          VARCHAR2(1),
    "APPR_BY_ALL"         VARCHAR2(1),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXFND_APPR_USER_LEVELS_U1" ON "XXFND_APPR_USER_LEVELS" ("USER_LEVEL_ID");

--------------------------------------------------------
--  DDL for Table XXFND_CHECKLIST_RESPONSE
--------------------------------------------------------

CREATE TABLE "XXFND_CHECKLIST_RESPONSE" (
    "CL_RES_ID"            NUMBER,
    "FUNC_ID"              NUMBER,
    "FUNC_REF_ID"          NUMBER,
    "FUNC_CL_ID"           NUMBER,
    "ITEM_RESPONSE1"       VARCHAR2(4000),
    "ITEM_RESPONSE2"       BLOB,
    "RESPONDED_YN"         VARCHAR2(1),
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

CREATE UNIQUE INDEX "XXFND_CHECKLIST_RESPONSE_U1" ON "XXFND_CHECKLIST_RESPONSE" ("CL_RES_ID");


--------------------------------------------------------
--  DDL for Table XXFND_CURRENCIES
--------------------------------------------------------

CREATE TABLE "XXFND_CURRENCIES" (
    "CURRENCY_CODE"       VARCHAR2(15),
    "CURRENCY_NAME"       VARCHAR2(100),
    "DESCRIPTION"         VARCHAR2(240),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

CREATE UNIQUE INDEX "XXFND_CURRENCIES_U1" ON "XXFND_CURRENCIES" ("CURRENCY_CODE");
--------------------------------------------------------
--  DDL for Table XXFND_DATA_COMBINATION
--------------------------------------------------------

CREATE TABLE "XXFND_DATA_COMBINATION" (
    "DCOMB_ID"            NUMBER,
    "SEGMENT1"            VARCHAR2(60),
    "SEGMENT2"            VARCHAR2(60),
    "SEGMENT3"            VARCHAR2(60),
    "SEGMENT4"            VARCHAR2(60),
    "SEGMENT5"            VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE UNIQUE INDEX "XXFND_DATA_COMBINATION_PK" ON "XXFND_DATA_COMBINATION" ("DCOMB_ID");
--------------------------------------------------------
--  DDL for Table XXFND_DATA_GROUP
--------------------------------------------------------

CREATE TABLE "XXFND_DATA_GROUP" (
    "DATA_GROUP_ID"       NUMBER,
    "DATA_GROUP_NAME"     VARCHAR2(100),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

CREATE UNIQUE INDEX "XXFND_DATA_GROUP_PK" ON "XXFND_DATA_GROUP" ("DATA_GROUP_ID");


--------------------------------------------------------
--  DDL for Table XXFND_DATA_GROUP_DETAIL
--------------------------------------------------------

CREATE TABLE "XXFND_DATA_GROUP_DETAIL" (
    "DATA_DETAIL_ID"      NUMBER,
    "DATA_GROUP_ID"       NUMBER,
    "DCOMB_ID"            NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);
CREATE UNIQUE INDEX "XXFND_DATA_GROUP_DETAIL_PK" ON "XXFND_DATA_GROUP_DETAIL" ("DATA_DETAIL_ID");

--------------------------------------------------------
--  DDL for Table XXFND_DATA_SECURITY
--------------------------------------------------------

CREATE TABLE "XXFND_DATA_SECURITY" (
    "DSEQ_ID"             NUMBER,
    "SEQ_NUMBER"          NUMBER,
    "SEGMENT_COLUMN"      VARCHAR2(10),
    "COLUMN_NAME"         VARCHAR2(30),
    "SRC_TABLE"           VARCHAR2(60),
    "SRC_COLUMN"          VARCHAR2(60),
    "SRC_DISP_COLUMN"     VARCHAR2(60),
    "SRC_LOOKUP_TYPE"     VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

CREATE UNIQUE INDEX "XXFND_DATA_SECURITY_PK" ON "XXFND_DATA_SECURITY" ("DSEQ_ID");

--------------------------------------------------------
--  DDL for Table XXFND_FLEXS
--------------------------------------------------------

CREATE TABLE "XXFND_FLEXS" (
    "FLEX_ID"             NUMBER,
    "FLEX_NAME"           VARCHAR2(60),
    "TABLE_NAME"          VARCHAR2(60),
    "DESCRIPTION"         VARCHAR2(2000),
    "FREEZE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "ACTIVE_YN"           VARCHAR2(1)
);

  CREATE UNIQUE INDEX "XXFND_FLEXS_PK" ON "XXFND_FLEXS" ("FLEX_ID");


--------------------------------------------------------
--  DDL for Table XXFND_FLEXS_CATEGORY
--------------------------------------------------------

CREATE TABLE "XXFND_FLEXS_CATEGORY" (
    "FLEX_CATG_ID"        NUMBER,
    "FLEX_ID"             NUMBER,
    "CATG_CODE"           VARCHAR2(30),
    "CATG_NAME"           VARCHAR2(60),
    "GLOBAL_YN"           VARCHAR2(1),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE UNIQUE INDEX "XXFND_FLEXS_CATEGORY_PK" ON "XXFND_FLEXS_CATEGORY" ("FLEX_CATG_ID");
--------------------------------------------------------
--  DDL for Table XXFND_FLEXS_DATA
--------------------------------------------------------

CREATE TABLE "XXFND_FLEXS_DATA" (
    "FLEX_DATA_ID"         NUMBER,
    "FLEX_CATG_ID"         NUMBER,
    "FLEX_ID"              NUMBER,
    "TABLE_NAME"           VARCHAR2(60),
    "REF_KEY_ID"           NUMBER,
    "ATTRIBUTE_CATEGORY"   VARCHAR2(240),
    "ATTRIBUTE_C01"        VARCHAR2(240),
    "ATTRIBUTE_C02"        VARCHAR2(240),
    "ATTRIBUTE_C03"        VARCHAR2(240),
    "ATTRIBUTE_C04"        VARCHAR2(240),
    "ATTRIBUTE_C05"        VARCHAR2(240),
    "ATTRIBUTE_C06"        VARCHAR2(240),
    "ATTRIBUTE_C07"        VARCHAR2(240),
    "ATTRIBUTE_C08"        VARCHAR2(240),
    "ATTRIBUTE_C09"        VARCHAR2(240),
    "ATTRIBUTE_C10"        VARCHAR2(240),
    "ATTRIBUTE_C11"        VARCHAR2(240),
    "ATTRIBUTE_C12"        VARCHAR2(240),
    "ATTRIBUTE_C13"        VARCHAR2(240),
    "ATTRIBUTE_C14"        VARCHAR2(240),
    "ATTRIBUTE_C15"        VARCHAR2(240),
    "ATTRIBUTE_C16"        VARCHAR2(240),
    "ATTRIBUTE_C17"        VARCHAR2(240),
    "ATTRIBUTE_C18"        VARCHAR2(240),
    "ATTRIBUTE_C19"        VARCHAR2(240),
    "ATTRIBUTE_C20"        VARCHAR2(240),
    "ATTRIBUTE_N01"        NUMBER,
    "ATTRIBUTE_N02"        NUMBER,
    "ATTRIBUTE_N03"        NUMBER,
    "ATTRIBUTE_N04"        NUMBER,
    "ATTRIBUTE_N05"        NUMBER,
    "ATTRIBUTE_N06"        NUMBER,
    "ATTRIBUTE_N07"        NUMBER,
    "ATTRIBUTE_N08"        NUMBER,
    "ATTRIBUTE_N09"        NUMBER,
    "ATTRIBUTE_N10"        NUMBER,
    "ATTRIBUTE_N11"        NUMBER,
    "ATTRIBUTE_N12"        NUMBER,
    "ATTRIBUTE_N13"        NUMBER,
    "ATTRIBUTE_N14"        NUMBER,
    "ATTRIBUTE_N15"        NUMBER,
    "ATTRIBUTE_N16"        NUMBER,
    "ATTRIBUTE_N17"        NUMBER,
    "ATTRIBUTE_N18"        NUMBER,
    "ATTRIBUTE_N19"        NUMBER,
    "ATTRIBUTE_N20"        NUMBER,
    "ATTRIBUTE_D01"        DATE,
    "ATTRIBUTE_D02"        DATE,
    "ATTRIBUTE_D03"        DATE,
    "ATTRIBUTE_D04"        DATE,
    "ATTRIBUTE_D05"        DATE,
    "ATTRIBUTE_D06"        DATE,
    "ATTRIBUTE_D07"        DATE,
    "ATTRIBUTE_D08"        DATE,
    "ATTRIBUTE_D09"        DATE,
    "ATTRIBUTE_D10"        DATE,
    "ATTRIBUTE_D11"        DATE,
    "ATTRIBUTE_D12"        DATE,
    "ATTRIBUTE_D13"        DATE,
    "ATTRIBUTE_D14"        DATE,
    "ATTRIBUTE_D15"        DATE,
    "ATTRIBUTE_D16"        DATE,
    "ATTRIBUTE_D17"        DATE,
    "ATTRIBUTE_D18"        DATE,
    "ATTRIBUTE_D19"        DATE,
    "ATTRIBUTE_D20"        DATE,
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(150)
);
  CREATE UNIQUE INDEX "XXFND_FLEXS_DATA_PK" ON "XXFND_FLEXS_DATA" ("FLEX_DATA_ID");
  
--------------------------------------------------------
--  DDL for Table XXFND_FLEXS_FIELDS
--------------------------------------------------------

CREATE TABLE "XXFND_FLEXS_FIELDS" (
    "FLEX_FIELD_ID"       NUMBER,
    "FLEX_CATG_ID"        NUMBER,
    "FLEX_ID"             NUMBER,
    "SEQ_NUMBER"          NUMBER,
    "FLEX_COLUMN"         VARCHAR2(30),
    "DISPLAY_NAME"        VARCHAR2(30),
    "FLEX_LENGTH"         NUMBER,
    "DISPLAY_SIZE"        NUMBER,
    "DATA_TYPE"           VARCHAR2(1),
    "VALUE_SET_ID"        NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE UNIQUE INDEX "XXFND_FLEXS_FIELDS_PK" ON "XXFND_FLEXS_FIELDS" ("FLEX_FIELD_ID");

--------------------------------------------------------
--  DDL for Table XXFND_FUNCTIONS
--------------------------------------------------------

CREATE TABLE "XXFND_FUNCTIONS" (
    "FUNC_ID"              NUMBER,
    "FUNC_NAME"            VARCHAR2(60),
    "FUNC_SHORT_CODE"      VARCHAR2(30),
    "AUTO_NUMBER_YN"       VARCHAR2(1),
    "PREFIX"               VARCHAR2(10),
    "NEXT_NUMBER"          NUMBER,
    "PAGE_PATH"            VARCHAR2(500),
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
    "FUNC_TYPE"            VARCHAR2(30)
);

  CREATE INDEX "XXFND_FUNCTIONS_N1" ON "XXFND_FUNCTIONS" ("FUNC_SHORT_CODE");

  CREATE UNIQUE INDEX "XXFND_FUNCTIONS_U1" ON "XXFND_FUNCTIONS" ("FUNC_ID");


--------------------------------------------------------
--  DDL for Table XXFND_FUNC_APPROVALS
--------------------------------------------------------

CREATE TABLE "XXFND_FUNC_APPROVALS" (
    "FUNC_ID"             NUMBER,
    "ATTR_GRP_ID"         NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

CREATE UNIQUE INDEX "XXFND_FUNC_APPROVALS_PK" ON "XXFND_FUNC_APPROVALS" ("FUNC_ID");

--------------------------------------------------------
--  DDL for Table XXFND_FUNC_APPROVAL_HIST
--------------------------------------------------------

CREATE TABLE "XXFND_FUNC_APPROVAL_HIST" (
    "APPR_HIST_ID"         NUMBER,
    "FUNC_ID"              NUMBER,
    "FUNC_REF_ID"          NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "APPR_ROLE"            VARCHAR2(30),
    "APPROVER_ID"          NUMBER,
    "SUBMISSION_DATE"      DATE,
    "ACTION_DATE"          DATE,
    "DESCRIPTION"          VARCHAR2(4000),
    "STATUS"               VARCHAR2(30),
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
    "FLOW_LEVEL"           NUMBER,
    "USER_GRP_ID"          NUMBER,
    "CYCLE_NO"             NUMBER,
    "CYCLE_FLAG"           VARCHAR2(1)
);

CREATE UNIQUE INDEX "XXFND_FUNC_APPROVAL_HIST_U1" ON "XXFND_FUNC_APPROVAL_HIST" ("APPR_HIST_ID");

--------------------------------------------------------
--  DDL for Table XXFND_FUNC_APPR_LEVELS
--------------------------------------------------------

CREATE TABLE "XXFND_FUNC_APPR_LEVELS" (
    "APPR_LEVEL_ID"        NUMBER,
    "FUNC_ID"              NUMBER,
    "LEVEL_NO"             NUMBER,
    "LEVEL_NAME"           VARCHAR2(60),
    "LEVEL_TYPE"           VARCHAR2(1),
    "APPR_BY_ALL"          VARCHAR2(1),
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
  CREATE UNIQUE INDEX "XXFND_FUNC_APPR_LEVELS_PK" ON "XXFND_FUNC_APPR_LEVELS" ("APPR_LEVEL_ID");

--------------------------------------------------------
--  DDL for Table XXFND_FUNC_ATTACHMENT
--------------------------------------------------------

CREATE TABLE "XXFND_FUNC_ATTACHMENT" (
    "ATTACH_ID"            NUMBER,
    "FUNC_ID"              VARCHAR2(30),
    "FUNC_REF_ID"          NUMBER,
    "DESCRIPTION"          VARCHAR2(4000),
    "FILE_NAME"            VARCHAR2(240),
    "FILE_TYPE"            VARCHAR2(100),
    "ATTACHMENT"           BLOB,
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
    "FUNC_TABLE_NAME"      VARCHAR2(60)
);

CREATE UNIQUE INDEX "XXFND_FUNC_ATTACHMENT_PK" ON "XXFND_FUNC_ATTACHMENT" ("ATTACH_ID");
--------------------------------------------------------
--  DDL for Table XXFND_FUNC_CHECKLIST
--------------------------------------------------------

CREATE TABLE "XXFND_FUNC_CHECKLIST" (
    "FUNC_CL_ID"           NUMBER,
    "FUNC_ID"              NUMBER,
    "SEQ_NUMBER"           NUMBER,
    "CL_TYPE"              VARCHAR2(30),
    "CL_ITEM"              VARCHAR2(2000),
    "LOOKUP_TYPE"          VARCHAR2(30),
    "MANDATORY_YN"         VARCHAR2(1),
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
    "CL_NAME"              VARCHAR2(30)
);
CREATE UNIQUE INDEX "XXFND_FUNC_CHECKLIST_U1" ON "XXFND_FUNC_CHECKLIST" ("FUNC_CL_ID");

--------------------------------------------------------
--  DDL for Table XXFND_LOOKUP_TYPES
--------------------------------------------------------

CREATE TABLE "XXFND_LOOKUP_TYPES" (
    "LOOKUP_TYPE_ID"             NUMBER,
    "LOOKUP_TYPE_NAME"           VARCHAR2(30),
    "LOOKUP_TYPE_NAME_DISP"      VARCHAR2(240),
    "LOOKUP_TYPE_NAME_DISP_TL"   VARCHAR2(240),
    "ACCESS_LEVEL"               VARCHAR2(240),
    "ACTIVE_YN"                  VARCHAR2(1),
    "CREATED_BY"                 VARCHAR2(60),
    "CREATION_DATE"              TIMESTAMP(6),
    "LAST_UPDATED_BY"            VARCHAR2(60),
    "LAST_UPDATE_DATE"           TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"          VARCHAR2(150),
    "PARENT_TYPE_ID"             NUMBER
);

  CREATE UNIQUE INDEX "XXFND_LOOKUP_TYPES_U1" ON "XXFND_LOOKUP_TYPES" ("LOOKUP_TYPE_ID");

  CREATE UNIQUE INDEX "XXFND_LOOKUP_TYPES_U2" ON "XXFND_LOOKUP_TYPES" ("LOOKUP_TYPE_NAME");

--------------------------------------------------------
--  DDL for Table XXFND_LOOKUP_VALUES
--------------------------------------------------------

CREATE TABLE "XXFND_LOOKUP_VALUES" (
    "LOOKUP_VALUE_ID"             NUMBER,
    "LOOKUP_TYPE_ID"              NUMBER,
    "LOOKUP_VALUE_NAME"           VARCHAR2(30),
    "LOOKUP_VALUE_NAME_DISP"      VARCHAR2(240),
    "LOOKUP_VALUE_NAME_DISP_TL"   VARCHAR2(240),
    "ACCESS_LEVEL"                VARCHAR2(240),
    "LOOKUP_ADDL_VALUE"           VARCHAR2(4000),
    "ACTIVE_YN"                   VARCHAR2(1),
    "CREATED_BY"                  VARCHAR2(60),
    "CREATION_DATE"               TIMESTAMP(6),
    "LAST_UPDATED_BY"             VARCHAR2(60),
    "LAST_UPDATE_DATE"            TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"           VARCHAR2(150),
    "PARENT_VALUE_ID"             NUMBER,
    "DISPLAY_ORDER"               NUMBER
);

  CREATE INDEX "XXFND_LOOKUP_VALUES_N1" ON "XXFND_LOOKUP_VALUES" ("LOOKUP_TYPE_ID");
  CREATE UNIQUE INDEX "XXFND_LOOKUP_VALUES_U1" ON "XXFND_LOOKUP_VALUES" ("LOOKUP_VALUE_ID");
  CREATE UNIQUE INDEX "XXFND_LOOKUP_VALUES_U2" ON "XXFND_LOOKUP_VALUES" ("LOOKUP_VALUE_NAME", "LOOKUP_TYPE_ID");


--------------------------------------------------------
--  DDL for Table XXFND_MAIN_MENU
--------------------------------------------------------

CREATE TABLE "XXFND_MAIN_MENU" (
    "MAIN_MENU_ID"        NUMBER,
    "MENU_NAME"           VARCHAR2(100),
    "MENU_NAME_DISP"      VARCHAR2(240),
    "MENU_NAME_DISP_TL"   VARCHAR2(240),
    "MENU_ORDER"          NUMBER,
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "MENU_ICON"           VARCHAR2(240)
);

  CREATE UNIQUE INDEX "XXFND_MAIN_MENU_U1" ON "XXFND_MAIN_MENU" ("MAIN_MENU_ID");
--------------------------------------------------------
--  DDL for Table XXFND_MENU_ACCESS
--------------------------------------------------------

CREATE TABLE "XXFND_MENU_ACCESS" (
    "MENU_ACCESS_ID"      NUMBER,
    "USER_ROLE_ID"        NUMBER,
    "SUB_MENU_ID"         NUMBER,
    "MENU_DISPLAY"        VARCHAR2(1),
    "MENU_CONTROL"        VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150)
);

  CREATE INDEX "XXFND_MENU_ACCESS_IDX1" ON "XXFND_MENU_ACCESS" ("SUB_MENU_ID");
  CREATE INDEX "XXFND_MENU_ACCESS_IDX2" ON "XXFND_MENU_ACCESS" ("USER_ROLE_ID");
  CREATE UNIQUE INDEX "XXFND_MENU_ACCESS_IDX3" ON "XXFND_MENU_ACCESS" ("MENU_ACCESS_ID");

--------------------------------------------------------
--  DDL for Table XXFND_REPORT_PARAMS
--------------------------------------------------------

CREATE TABLE "XXFND_REPORT_PARAMS" (
    "PARAM_ID"            NUMBER,
    "FUNC_ID"             NUMBER,
    "SEQ_NUMBER"          NUMBER,
    "PARAM_NAME"          VARCHAR2(30),
    "PARAM_TABLE"         VARCHAR2(60),
    "PARAM_COLUMN"        VARCHAR2(60),
    "PARAM_DISP_COLUMN"   VARCHAR2(60),
    "PARAM_LOOKUP_TYPE"   VARCHAR2(60),
    "ACTIVE_YN"           VARCHAR2(1),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "DATA_TYPE"           VARCHAR2(30),
    "TOKEN"               VARCHAR2(30),
    "MANDATORY"           VARCHAR2(1) DEFAULT 'N'
);

CREATE UNIQUE INDEX "XXFND_REPORT_PARAMS_PK" ON "XXFND_REPORT_PARAMS" ("PARAM_ID");

--------------------------------------------------------
--  DDL for Table XXFND_SCHEDULE_LIST_T
--------------------------------------------------------

CREATE TABLE "XXFND_SCHEDULE_LIST_T" (
    "SCHEDULE_LIST_ID"    NUMBER,
    "SCHEDULE_ID"         NUMBER,
    "SCHEDULE_NAME"       VARCHAR2(240),
    "PROGRAM_NAME"        VARCHAR2(240),
    "BI_REPORT_PATH"      VARCHAR2(240),
    "BI_REPORT_NAME"      VARCHAR2(240),
    "DB_REFRESH_PKG"      VARCHAR2(240),
    "LAST_REFRESH_TIME"   TIMESTAMP(6),
    "SCHEDULE_STATUS"     VARCHAR2(30),
    "ERROR_MESSAGE"       VARCHAR2(2000),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(60)
);

CREATE UNIQUE INDEX "XXFND_SCHEDULE_LIST_T_U1" ON "XXFND_SCHEDULE_LIST_T" ("SCHEDULE_LIST_ID");
--------------------------------------------------------
--  DDL for Table XXFND_SCHEDULE_T
--------------------------------------------------------

CREATE TABLE "XXFND_SCHEDULE_T" (
    "SCHEDULE_ID"          NUMBER,
    "SCHEDULE_NAME"        VARCHAR2(240),
    "FREQUENCY_MIN"        NUMBER,
    "PROGRAM_NAME"         VARCHAR2(240),
    "BI_REPORT_PATH"       VARCHAR2(240),
    "BI_REPORT_NAME"       VARCHAR2(240),
    "DB_REFRESH_PKG"       VARCHAR2(240),
    "APPLICATION_NAME"     VARCHAR2(240),
    "NEXT_SCHEDULE_TIME"   TIMESTAMP(6),
    "CREATED_BY"           VARCHAR2(60),
    "CREATION_DATE"        TIMESTAMP(6),
    "LAST_UPDATED_BY"      VARCHAR2(60),
    "LAST_UPDATE_DATE"     TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"    VARCHAR2(60),
    "RUN_STATUS"           VARCHAR2(30),
    "STATUS"               VARCHAR2(30)
);
CREATE UNIQUE INDEX "XXFND_SCHEDULE_T_U1" ON "XXFND_SCHEDULE_T" ("SCHEDULE_ID");
--------------------------------------------------------
--  DDL for Table XXFND_SUB_MENU
--------------------------------------------------------

CREATE TABLE "XXFND_SUB_MENU" (
    "SUB_MENU_ID"             NUMBER,
    "SUB_MENU_NAME"           VARCHAR2(100),
    "SUB_MENU_NAME_DISP"      VARCHAR2(240),
    "SUB_MENU_NAME_DISP_TL"   VARCHAR2(240),
    "SUB_MENU_ORDER"          NUMBER,
    "MAIN_MENU_ID"            NUMBER,
    "FUNC_ID"                 NUMBER,
    "MENU_PARAMS"             VARCHAR2(240),
    "CREATED_BY"              VARCHAR2(60),
    "CREATION_DATE"           TIMESTAMP(6),
    "LAST_UPDATED_BY"         VARCHAR2(60),
    "LAST_UPDATE_DATE"        TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"       VARCHAR2(150),
    "MENU_ICON"               VARCHAR2(240)
);

  CREATE INDEX "XXFND_SUB_MENU_N1" ON "XXFND_SUB_MENU" ("MAIN_MENU_ID");

  CREATE UNIQUE INDEX "XXFND_SUB_MENU_U1" ON "XXFND_SUB_MENU" ("SUB_MENU_ID");

--------------------------------------------------------
--  DDL for Table XXFND_USER
--------------------------------------------------------

CREATE TABLE "XXFND_USER" (
    "USER_ID"             NUMBER,
    "USER_NAME"           VARCHAR2(50),
    "USER_PAWD"           VARCHAR2(150),
    "PWD_CHANGED_FLAG"    VARCHAR2(1),
    "USER_ROLE_ID"        NUMBER,
    "USER_NAME_DISP"      VARCHAR2(150),
    "USER_NAME_DISP_TL"   VARCHAR2(150),
    "DATA_GROUP_ID"       NUMBER,
    "DEF_DCOMB_ID"        NUMBER,
    "LOV_ACCESS_GRP_ID"   NUMBER,
    "EMP_ID"              NUMBER,
    "ACTIVE_YN"           VARCHAR2(1),
    "ORIG_SYSTEM_REF"     VARCHAR2(240),
    "CREATED_BY"          VARCHAR2(60),
    "CREATION_DATE"       TIMESTAMP(6),
    "LAST_UPDATED_BY"     VARCHAR2(60),
    "LAST_UPDATE_DATE"    TIMESTAMP(6),
    "LAST_UPDATE_LOGIN"   VARCHAR2(150),
    "USER_EMAIL_ID"       VARCHAR2(300)
);

  CREATE INDEX "XXFND_USER_N1" ON "XXFND_USER" ("DATA_GROUP_ID");
  CREATE index "XXFND_USER_N2" ON "XXFND_USER" ( "USER_NAME" );


ALTER INDEX XXFND_APPR_USER_GROUP_PK	 RENAME TO XXFND_APPR_USER_GROUP_U1;
ALTER INDEX XXFND_DATA_COMBINATION_PK	 RENAME TO XXFND_DATA_COMBINATION_U1;
ALTER INDEX XXFND_DATA_GROUP_PK			 RENAME TO XXFND_DATA_GROUP_U1;
ALTER INDEX XXFND_DATA_GROUP_DETAIL_PK	 RENAME TO XXFND_DATA_GROUP_DETAIL_U1;
ALTER INDEX XXFND_DATA_SECURITY_PK		 RENAME TO XXFND_DATA_SECURITY_U1;
ALTER INDEX XXFND_FLEXS_PK				 RENAME TO XXFND_FLEXS_U1;
ALTER INDEX XXFND_FLEXS_CATEGORY_PK		 RENAME TO XXFND_FLEXS_CATEGORY_U1;
ALTER INDEX XXFND_FLEXS_DATA_PK			 RENAME TO XXFND_FLEXS_DATA_U1;
ALTER INDEX XXFND_FLEXS_FIELDS_PK		 RENAME TO XXFND_FLEXS_FIELDS_U1;
ALTER INDEX XXFND_FUNC_APPROVALS_PK		 RENAME TO XXFND_FUNC_APPROVALS_U1;
ALTER INDEX XXFND_FUNC_APPR_LEVELS_PK	 RENAME TO XXFND_FUNC_APPR_LEVELS_U1;
ALTER INDEX XXFND_FUNC_ATTACHMENT_PK	 RENAME TO XXFND_FUNC_ATTACHMENT_U1;
ALTER INDEX XXFND_REPORT_PARAMS_PK		 RENAME TO XXFND_REPORT_PARAMS_U1;
ALTER INDEX XXFND_MENU_ACCESS_IDX3		 RENAME TO XXFND_MENU_ACCESS_U1;
ALTER INDEX XXFND_MENU_ACCESS_IDX1		 RENAME TO XXFND_MENU_ACCESS_N1;
ALTER INDEX XXFND_MENU_ACCESS_IDX2		 RENAME TO XXFND_MENU_ACCESS_N2;

