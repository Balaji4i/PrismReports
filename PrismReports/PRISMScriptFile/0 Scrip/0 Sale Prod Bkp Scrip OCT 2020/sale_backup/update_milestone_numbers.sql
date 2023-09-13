--------------------------------------------------------
--  DDL for Procedure update_milestone_numbers
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "update_milestone_numbers" AS
    CURSOR cur_insert IS
    SELECT
        ms_hdr_id,
        milestone_number
    FROM
        xxpm_milestone_hdr;

BEGIN
    FOR i IN cur_insert LOOP UPDATE xxdm_milestone_dtl
    SET
        ms_hdr_id = i.ms_hdr_id
    WHERE
        milestone_number = i.milestone_number;

    END LOOP;

    COMMIT;
END ;
