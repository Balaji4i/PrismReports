--------------------------------------------------------
--  DDL for Table XXDM_MILESTONE_DTL
--------------------------------------------------------

  CREATE TABLE "XXDM_MILESTONE_DTL" 
   (	"MS_DTL_ID" VARCHAR2(20), 
	"MILESTONE_NUMBER" VARCHAR2(240), 
	"SEQ_NUMBER" VARCHAR2(20), 
	"INSTALLMENT_TYPE" VARCHAR2(60), 
	"INSTALLMENT_PCT" VARCHAR2(20), 
	"CHARGE_TYPE" VARCHAR2(60), 
	"PAYMENT_TERM" VARCHAR2(60), 
	"REMARKS" VARCHAR2(4000), 
	"DUE_DAYS" VARCHAR2(20), 
	"DUE_DAYS_FROM" VARCHAR2(60), 
	"PROJ_MS_ID" VARCHAR2(20), 
	"DUE_DATE" VARCHAR2(11), 
	"REVISION" VARCHAR2(20), 
	"REVISION_DATE" VARCHAR2(11), 
	"REVISED_BY" VARCHAR2(60), 
	"CREATED_BY" VARCHAR2(60), 
	"CREATION_DATE" DATE DEFAULT SYSDATE, 
	"LAST_UPDATED_BY" VARCHAR2(60), 
	"LAST_UPDATE_DATE" DATE DEFAULT SYSDATE, 
	"LAST_UPDATE_LOGIN" VARCHAR2(150), 
	"INSTALLMENT_METHOD" VARCHAR2(30), 
	"INSTALLMENT_EVENT" VARCHAR2(240), 
	"PERIOD_OCCURENCE" VARCHAR2(30), 
	"PERIOD_VALUES" VARCHAR2(30), 
	"PERIOD_DURATION" VARCHAR2(30), 
	"BATCH_ID" NUMBER, 
	"INTERFACE_STATUS_FLAG" VARCHAR2(1), 
	"INTERFACE_ID" NUMBER, 
	"ERR_MSG" VARCHAR2(2000), 
	"ERR_DESCRIPTION" VARCHAR2(2000), 
	"VALIDATED_BY" VARCHAR2(60), 
	"VALIDATED_DATE" TIMESTAMP (6), 
	"PROCESSED_BY" VARCHAR2(60), 
	"PROCESSED_DATE" TIMESTAMP (6), 
	"ACTION_FLAG" VARCHAR2(5), 
	"PROCESS_FLAG" VARCHAR2(5), 
	"INSERT_HISTORY_FLAG" VARCHAR2(5), 
	"MS_HDR_ID" NUMBER
   )