--------------------------------------------------------
--  DDL for Procedure XXPM_UPDATE_MILESTONE_STATUS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_UPDATE_MILESTONE_STATUS" (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
) AS
    l_booking_id    NUMBER;
    l_status        VARCHAR2(60);
    l_staus_count   NUMBER;

BEGIN
--get cancellation booking id
    BEGIN
        SELECT
            booking_id
        INTO l_booking_id
        FROM
            xxpm_cancellation
        WHERE
            cancel_id = p_primary_id
            AND func_id = p_func_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_booking_id := 0;
END;
DBMS_OUTPUT.PUT_LINE('l_booking_id S0 ' || l_booking_id);
-- check booking status

    BEGIN
        SELECT
            status
        INTO l_status
        FROM
            xxpm_booking_header
        WHERE
            booking_hdr_id = l_booking_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_status := 'NULL';
    END;
    DBMS_OUTPUT.PUT_LINE('l_booking_id S011 ' || l_status);
--checking if condition

    BEGIN
        IF l_status = 'CANCEL' THEN 
--updating status flag
            BEGIN
                UPDATE xxpm_booking_milestones
                SET
                    MILESTONES_STATUS = 'N',
                    last_updated_by = p_login_user,
                    last_update_date = SYSDATE,
                    last_update_login = p_login_user
                WHERE
                    INVOICE_ID is null
                    and MILESTONE_TYPE = 'MS'
                    and booking_hdr_id = l_booking_id;
            END;
                COMMIT;
    DBMS_OUTPUT.PUT_LINE('l_booking_id S1 update n in booking ms ');
        END IF;
    END;

    SELECT
        COUNT(MILESTONES_STATUS)
    INTO l_staus_count
    FROM
        xxpm_booking_milestones
    WHERE
        booking_hdr_id = l_booking_id
        and INVOICE_ID is null;
DBMS_OUTPUT.PUT_LINE('S2 get cont '||l_staus_count);

    IF l_staus_count = 0 THEN
        p_out_status := 'Y';
    ELSE
        p_out_status := 'Y';
    END IF;
    xxpm_insert_booking_ms_debit_memo(p_primary_id,p_func_id,p_login_user,p_out_status);  
END;
