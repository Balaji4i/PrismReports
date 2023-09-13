create or replace TYPE XXPM_OFFER_DETAIL_TYP AS OBJECT
(
OFFER_DTL_ID       			NUMBER       ,
OFFER_HDR_ID                NUMBER       ,
PROPERTY_ID                 NUMBER       ,
BUILDING_ID                 NUMBER       ,
UNIT_ID                     NUMBER       ,
UOM                         VARCHAR2(60 BYTE) ,
QUANTITY                    NUMBER       ,
BASE_RATE                   NUMBER       ,
OFFER_AMOUNT                NUMBER       ,
PL_MOD_ID                   NUMBER       ,
DISC_PCT                    NUMBER       ,
DISC_AMOUNT                 NUMBER       ,
TAX_CODE                    VARCHAR2(60 BYTE) ,
TAX_RATE                    NUMBER       ,
TAX_AMOUNT                  NUMBER       ,
ATTRIBUTE_CATEGORY          VARCHAR2(240 BYTE),
ATTRIBUTE1                  VARCHAR2(240 BYTE),
ATTRIBUTE2                  VARCHAR2(240 BYTE),
ATTRIBUTE3                  VARCHAR2(240 BYTE),
ATTRIBUTE4                  VARCHAR2(240 BYTE),
ATTRIBUTE5                  VARCHAR2(240 BYTE),
ATTRIBUTE6                  VARCHAR2(240 BYTE),
ATTRIBUTE7                  VARCHAR2(240 BYTE),
ATTRIBUTE8                  VARCHAR2(240 BYTE),
ATTRIBUTE9                  VARCHAR2(240 BYTE),
ATTRIBUTE10                 VARCHAR2(240 BYTE),
CREATED_BY                  VARCHAR2(60 BYTE) ,
CREATION_DATE               TIMESTAMP ,
LAST_UPDATED_BY             VARCHAR2(60 BYTE) ,
LAST_UPDATE_DATE            TIMESTAMP ,
LAST_UPDATE_LOGIN           VARCHAR2(150 BYTE),
DISC_TYPE                   VARCHAR2(20),  
MIN_PRICE                   NUMBER
);


create or replace type "XXPM_OFFER_DETAIL_TYPE" AS TABLE OF XXPM_OFFER_DETAIL_TYP;