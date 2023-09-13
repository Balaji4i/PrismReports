--------------------------------------------------------
--  DDL for View AA_CP_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "AA_CP_V" ("CP_UNIT", "UNIT_NUM", "UNIT_ID", "CP_UNIT_ID", "FLAG_STATUS", "STATUS") AS 
  SELECT
REPLACE(CP_UNIT, ' ', '') as CP_UNIT, UNIT_NUM, UNIT_ID, CP_UNIT_ID, FLAG_STATUS, STATUS
FROM 
aa_cp
where 
UNIT_ID is null
