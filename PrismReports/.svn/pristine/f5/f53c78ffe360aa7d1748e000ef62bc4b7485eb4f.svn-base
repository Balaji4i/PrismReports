create or replace PROCEDURE xxpm_insert_booking_ms_debit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
) AS
    l_booking_id       NUMBER;
    l_forfiet_amount   NUMBER;
    lms_dtlid          NUMBER;
    l_ms_count         NUMBER;
    l_P_ERR_MSG          number; 
BEGIN
--get cancellation booking id and forfeit amount
    BEGIN
        SELECT
            booking_id,
            forfiet_amount
        INTO
            l_booking_id,
            l_forfiet_amount
        FROM
            xxpm_cancellation
        WHERE
            status = 'APR'
            AND cancel_id = p_primary_id
            AND func_id = p_func_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_booking_id := 0;
    END;
--Getting Booking Ms Count

    BEGIN
        SELECT
            COUNT(*)
        INTO l_ms_count
        FROM
            xxpm_booking_milestones
        WHERE
            booking_hdr_id = l_booking_id;

    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('MS Count not found ' || l_ms_count);
    END;
 -- Inserting Debit memo for cancellation

    BEGIN
        -- Seque no
        lms_dtlid := xxpm_booking_milestones_s.nextval;
        dbms_output.put_line('next installemnt Id lms_dtlId==>' || lms_dtlid);
        IF ( l_forfiet_amount != 0) THEN
            INSERT INTO xxpm_booking_milestones (
                booking_ms_dtl_id,
                milestone_type,
                seq_number,
                installment_amount,
                charge_type,
                payment_term,
                remarks,
                due_date,
                source_func_id,
                source_func_ref_id,
                booking_hdr_id,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            ) VALUES (
                lms_dtlid,
                'CNL',
                l_ms_count + 1,
                l_forfiet_amount,
                'CAN_DEB_MO',
                5,
                'Debit memo created. Cancellation-Forfeit Amount :' || l_forfiet_amount,
                SYSDATE,
                p_func_id,
                p_primary_id,
                l_booking_id,
                p_login_user,
                SYSDATE,
                p_login_user,
                SYSDATE,
                p_login_user
            );
        
            COMMIT;
            XXPM_CREATE_AUTO_BILLING(P_PRIMARY_ID,P_FUNC_ID,p_login_user,l_P_ERR_MSG);
            dbms_output.put_line('Stage 7 booking ms inserted==>');
            p_out_status:='Y';
        END IF;

    END;

END;