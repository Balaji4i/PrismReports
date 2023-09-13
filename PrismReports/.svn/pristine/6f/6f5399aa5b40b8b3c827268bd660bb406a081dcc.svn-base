--------------------------------------------------------
--  DDL for View SAMPLE_V1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SAMPLE_V1" ("UNIT_ID", "UNIT_NO", "UNIT_NOS") AS 
  select  "UNIT_ID","UNIT_NO","UNIT_NOS" from 
(
SELECT 
UNIT_ID,
UNIT_NO,
replace(UNIT_NO,'The ANWA by Omniyat /','')as UNIT_NOS
FROM AGENT_DL 
where UNIT_ID is  null) a
