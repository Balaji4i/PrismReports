--------------------------------------------------------
--  DDL for View SAMPLE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SAMPLE_V" ("UNIT_ID", "UNIT_NUMBER", "UNIT_NUMBER_N") AS 
  SELECT  
--*
UNIT_ID, UNIT_NUMBER, REPLACE(UNIT_NUMBER, 'The Anwa by Omniyat /','')as UNIT_NUMBER_n
FROM xxpm_property_units
where PROPERTY_ID=1000380
and UNIT_TYPE not in ('CAR_PARKING') 
and UNIT_NUMBER like 'The Anwa by Omniyat /%'
