--------------------------------------------------------
--  DDL for Function XXPM_UPDATE_STATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXPM_UPDATE_STATUS" (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2
) RETURN VARCHAR2 AS
    p_status VARCHAR2(1);
BEGIN
    xxpm_update_milestone_status(p_primary_id, p_func_id, p_login_user, p_status);
    RETURN p_status;
EXCEPTION
    WHEN no_data_found THEN
        p_status := 'N';
--        end;
        RETURN p_status;
END xxpm_update_status;
