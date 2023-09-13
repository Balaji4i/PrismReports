
create or replace TYPE "XXPM_OFFER_MILESTONE_DETAIL_TYP" AS OBJECT
(
OFFER_MS_DTL_ID    			NUMBER             ,
OFFER_HDR_ID                NUMBER             ,
MS_DTL_ID                   NUMBER             ,
PL_MOD_ID                   NUMBER             ,
SEQ_NUMBER                  NUMBER             ,
INSTALLMENT_TYPE            VARCHAR2(60 BYTE)  ,
INSTALLMENT_PCT             NUMBER             ,
INSTALLMENT_AMOUNT          NUMBER             ,
CHARGE_TYPE                 VARCHAR2(60 BYTE)  ,
PAYMENT_TERM                VARCHAR2(60 BYTE)  ,
REMARKS                     VARCHAR2(4000 BYTE),
DUE_DAYS                    NUMBER             ,
DUE_DAYS_FROM               VARCHAR2(60 BYTE)  ,
DUE_DATE                    DATE               ,
ATTRIBUTE_CATEGORY          VARCHAR2(240 BYTE) ,
ATTRIBUTE1                  VARCHAR2(240 BYTE) ,
ATTRIBUTE2                  VARCHAR2(240 BYTE) ,
ATTRIBUTE3                  VARCHAR2(240 BYTE) ,
ATTRIBUTE4                  VARCHAR2(240 BYTE) ,
ATTRIBUTE5                  VARCHAR2(240 BYTE) ,
ATTRIBUTE6                  VARCHAR2(240 BYTE) ,
ATTRIBUTE7                  VARCHAR2(240 BYTE) ,
ATTRIBUTE8                  VARCHAR2(240 BYTE) ,
ATTRIBUTE9                  VARCHAR2(240 BYTE) ,
ATTRIBUTE10                 VARCHAR2(240 BYTE) ,
CREATED_BY                  VARCHAR2(60 BYTE)  ,
CREATION_DATE               TIMESTAMP  ,
LAST_UPDATED_BY             VARCHAR2(60 BYTE)  ,
LAST_UPDATE_DATE            TIMESTAMP  ,
LAST_UPDATE_LOGIN           VARCHAR2(150 BYTE) ,
MILESTONE_TYPE              VARCHAR2(60 BYTE)  ,
UOM                         VARCHAR2(30 BYTE)  ,
QUANTITY                    NUMBER             ,
RATE                        NUMBER             ,
WAVE_OFF                    VARCHAR2(30 BYTE)  ,
INSTALLMENT_METHOD          VARCHAR2(30 BYTE)  ,
INSTALLMENT_EVENT           VARCHAR2(240 BYTE)  ,
PERIOD_OCCURENCE            VARCHAR2(30 BYTE)  ,
PERIOD_VALUES               NUMBER             ,
PERIOD_DURATION             VARCHAR2(30 BYTE)  ,
INCLUDED_IN_RATE            VARCHAR2(30 BYTE)  ,
TAX_RATE            NUMBER  ,
TAX_CODE              VARCHAR2(30 BYTE)             ,
TAX_AMOUNT             NUMBER,
CARPARKING               VARCHAR2(200)
);


create or replace TYPE "XXPM_OFFER_MILESTONE_DETAIL_TYPE" AS TABLE OF XXPM_OFFER_MILESTONE_DETAIL_TYP;

\
