--------------------------------------------------------
--  DDL for Table XXREP_TASK
--------------------------------------------------------

  CREATE TABLE "XXREP_TASK" 
   (	"PROJECT_ID" NUMBER, 
	"TASK_ID" NUMBER, 
	"TASK_NUMBER" VARCHAR2(100), 
	"TASK_NAME" VARCHAR2(255), 
	"DISPLAY_SEQUENCE" NUMBER, 
	"TOP_TASK_ID" NUMBER, 
	"WBS_LEVEL" NUMBER, 
	"PARENT_TASK_ID" NUMBER, 
	"SUB_CONTRACTOR" VARCHAR2(255), 
	"CONTRACT_AMOUNT" NUMBER, 
	"PC_AMOUNT" NUMBER, 
	"PC_AMOUNT_PAID" NUMBER
   )
