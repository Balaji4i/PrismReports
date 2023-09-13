DELETE FROM xxpm_pl_lines
      WHERE ROWID NOT IN (  SELECT MAX (ROWID) row_id
                              FROM xxpm_pl_lines
                          GROUP BY pl_id, unit_id, base_price)
/

  SELECT pl_id, unit_id, MAX (ROWID) row_id
    FROM xxpm_pl_lines
  HAVING COUNT (*) > 1
GROUP BY pl_id, unit_id


/

select x.rowid row_id,x.* from  xxpm_pl_lines x where PL_ID=17 and UNIT_ID=9533

delete xxpm_pl_lines where rowid in ('AAApCjAAUAAAMqjAAX')

CREATE UNIQUE INDEX XXPM_PL_LINES_U2 ON XXPM_PL_LINES
(PL_ID, UNIT_ID)
NOLOGGING
STORAGE    (
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL