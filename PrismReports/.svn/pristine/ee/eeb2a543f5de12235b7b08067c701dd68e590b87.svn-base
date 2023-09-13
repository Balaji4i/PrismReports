--------------------------------------------------------
--  DDL for View XXPM_MOVE_IO_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MOVE_IO_PCS_V" ("MOVE_IO_ID", "FUNC_ID", "LEASE_AGREEMENT_ID", "BOOKING_ID", "MOVE_IO_NUMBER", "MOVE_IO_DATE", "USAGE", "RESOURCE_NAME", "IO_FLAG", "LOOKUP_VALUE_NAME_DISP as STATUS", "DESCRIPTION", "ORG_ID", "USER_GRP_ID", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "ORG_NAME", "BOOKING_NUMBER", "PROPERTY_NAME", "PROPERTY_NUMBER", "BUILD_NAME", "BUILD_NUMBER", "UNIT_NAME", "UNIT_NUMBER", "CUST_ID", "CUSTOMER_NAME") AS 
  SELECT distinct
         MI.MOVE_IO_ID,                       
         MI.FUNC_ID,                       
         MI.LEASE_AGREEMENT_ID,                       
         MI.BOOKING_ID,                       
         MI.MOVE_IO_NUMBER,                       
         trunc(MI.MOVE_IO_DATE),                       
         MI.USAGE,                       
         MI.RESOURCE_NAME,                       
         MI.IO_FLAG,                       
         LV.LOOKUP_VALUE_NAME_DISP as STATUS,                       
         MI.DESCRIPTION,                       
         MI.ORG_ID,                       
         MI.USER_GRP_ID,                       
         MI.CREATED_BY,                       
         trunc(MI.CREATION_DATE),                       
         MI.LAST_UPDATED_BY,                       
         trunc(MI.LAST_UPDATE_DATE),                       
         MI.LAST_UPDATE_LOGIN,                       
         ORG.ORG_NAME,                       
         BH.BOOKING_NUMBER,                       
         PM.PROPERTY_NAME,                       
         PM.PROPERTY_NUMBER,                       
         PB.BUILD_NAME,                       
         PB.BUILD_NUMBER,                       
         PU.UNIT_NAME,                       
         PU.UNIT_NUMBER,                       
         BC.CUST_ID,                       
         CUS.CUSTOMER_NAME        
  FROM   XXPM_MOVE_IN_OUT MI,                       
         XXPM_BOOKING_HEADER BH,                       
         XXPM_BOOKING_DETAIL BD,                       
         XXPM_PROPERTY_MASTER PM,                       
         XXPM_PROPERTY_BUILDINGS PB,                       
         XXPM_PROPERTY_UNITS PU,                       
         XXSTG_ORGANIZATIONS ORG,                       
         XXPM_BOOKING_CUSTOMER BC,                       
         XXSTG_CUSTOMER CUS,                   
         XXFND_LOOKUP_V LV                   
  WHERE  MI.BOOKING_ID = BH.BOOKING_HDR_ID                       
         AND BH.BOOKING_HDR_ID = BD.BOOKING_HDR_ID                       
         AND BH.PROPERTY_ID = PM.PROPERTY_ID                       
         AND BD.BUILDING_ID = PB.BUILD_ID                       
         AND BD.UNIT_ID = PU.UNIT_ID                       
         AND MI.ORG_ID = ORG.ORG_ID                       
         AND BH.BOOKING_HDR_ID = BC.BOOKING_HDR_ID                       
         AND BC.CUST_ID = CUS.CUST_ID                       
         AND BC.PRIMARY_YN = 'Y'                  
         AND LV.LOOKUP_TYPE_NAME = 'BOOKING_STATUS'      
         AND MI.STATUS=LV.LOOKUP_VALUE_NAME
