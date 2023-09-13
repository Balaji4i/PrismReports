--------------------------------------------------------
--  DDL for Procedure XXDM_PAYMENT_MILESTONES_VAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXDM_PAYMENT_MILESTONES_VAL" 
AS
    CURSOR cur_sales_miles is
        SELECT
            ms_dtl_id,
            milestone_number,
            seq_number,
            installment_type,
            installment_pct,
            charge_type,
            payment_term,
            remarks,
            due_days,
            due_days_from,
            proj_ms_id,
            due_date,
            revision,
            revision_date,
            revised_by,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login,
            installment_method,
            installment_event,
            period_occurence,
            period_values,
            period_duration batch_id,
            interface_status_flag,
            interface_id,
            err_msg,
            err_description,
            validated_by,
            validated_date,
            processed_by,
            processed_date,
            action_flag,
            process_flag,
            insert_history_flag
        FROM
            xxdm_milestone_dtl
        WHERE
            interface_status_flag = 'V';
BEGIN
    for i in cur_sales_miles LOOP 
    NULL;
--    BEGIN
    --==============================================================================
    ---------------------OFFER_NUMBER Validations----------------------------------
    --==============================================================================
      /*  SELECT
            ms_hdr_id
        INTO l_offer_hdr_id
        FROM
            xxpm__milestone_hdr
        WHERE
            milestone_number = i.milestone_number
            AND ROWNUM = 1;

        UPDATE xxdm_milestone_dtl
        SET
            ms_hdr_id = l_offer_hdr_id,
            status_flag = l_status_flag,
            err_desc = l_err_msg
        WHERE
            milestone_number = i.milestone_number;
   -- AND rowid            =i.rowid;
*/
--    END;
    END LOOP;

    COMMIT;
END xxdm_payment_milestones_val;
