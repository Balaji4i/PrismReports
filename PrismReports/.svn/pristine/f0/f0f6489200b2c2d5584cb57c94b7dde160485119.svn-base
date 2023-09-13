create or replace PACKAGE BODY "XXPM_BOOK_MS_REV_PKG" IS

    PROCEDURE get_milestones (
        p_rev_hdr_id      IN   NUMBER,
        p_booking_hdr_id  IN   NUMBER,
        p_func_id         IN   NUMBER,
        retcode           OUT  NUMBER,
        errbuf            OUT  VARCHAR2
    ) AS

        l_ms_rev_dtl_id         NUMBER;
        l_ms_rev_id             NUMBER := p_rev_hdr_id;
    --    
        l_old_booking_amount    NUMBER;
        l_old_disc_amount       NUMBER;
        l_old_tax_amount        NUMBER;
        l_old_total_spa_amount  NUMBER;
        l_org_id                NUMBER;
        CURSOR book_ms IS
        SELECT
            booking_ms_dtl_id,
            milestone_type,
            ms_dtl_id,
            pl_mod_id,
            seq_number,
            installment_type,
            installment_pct,
            installment_amount,
            uom,
            quantity,
            rate,
            wave_off,
            included_in_rate,
            installment_method,
            installment_event,
            period_occurence,
            period_values,
            period_duration,
            charge_type,
            payment_term,
            remarks,
            due_days,
            due_days_from,
            due_date,
            attribute_category,
            attribute1,
            attribute2,
            attribute3,
            attribute4,
            attribute5,
            attribute6,
            attribute7,
            attribute8,
            attribute9,
            attribute10,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login,
            source_func_id,
            source_func_ref_id,
            billing_id,
            status,
            invoice_id,
            booking_hdr_id,
            carparking
        FROM
            xxpm_booking_milestones
        WHERE
            booking_hdr_id = p_booking_hdr_id;

    BEGIN
        retcode := 0;
        errbuf := 'success';
        BEGIN
            FOR i IN book_ms LOOP
                dbms_output.put_line(' COUNT 1            i.booking_ms_dtl_id  ' || i.booking_ms_dtl_id);
                INSERT INTO xxpm_book_ms_rev_dtl (
                    ms_rev_dtl_id,
                    ms_rev_id,
                    source_func_id,
                    source_func_ref_id,
                    milestone_type,
                    ms_dtl_id,
                    pl_mod_id,
                    seq_number,
                    installment_type,
                    installment_pct,
                    installment_amount,
                    uom,
                    quantity,
                    rate,
                    wave_off,
                    included_in_rate,
                    installment_method,
                    installment_event,
                    period_occurence,
                    period_values,
                    period_duration,
                    charge_type,
                    payment_term,
                    remarks,
                    due_days,
                    due_days_from,
                    due_date,
                    billing_id,
                    status,
                    invoice_id,
                    installment_pct_r,
                    installment_amount_r,
                    action_flag,
                    attribute_category,
                    attribute1,
                    attribute2,
                    attribute3,
                    attribute4,
                    attribute5,
                    attribute6,
                    attribute7,
                    attribute8,
                    attribute9,
                    attribute10,
                    created_by,
                    creation_date,
                    last_updated_by,
                    last_update_date,
                    last_update_login,
                    booking_ms_dtl_id,
                    carparking
                ) VALUES (
                    xxpm_booking_hdr_rev_id_s.NEXTVAL,
                    l_ms_rev_id,
                    i.source_func_id,
                    i.source_func_ref_id,
                    i.milestone_type,
                    i.ms_dtl_id,
                    i.pl_mod_id,
                    i.seq_number,
                    i.installment_type,
                    i.installment_pct,
                    i.installment_amount,
                    i.uom,
                    i.quantity,
                    i.rate,
                    i.wave_off,
                    i.included_in_rate,
                    i.installment_method,
                    i.installment_event,
                    i.period_occurence,
                    i.period_values,
                    i.period_duration,
                    i.charge_type,
                    i.payment_term,
                    i.remarks,
                    i.due_days,
                    i.due_days_from,
                    i.due_date,
                    i.billing_id,
                    i.status,
                    i.invoice_id,
                    i.installment_pct,
                    i.installment_amount,
                    nvl2(i.invoice_id, 'NA', 'UPD'),
                    i.attribute_category,
                    i.attribute1,
                    i.attribute2,
                    i.attribute3,
                    i.attribute4,
                    i.attribute5,
                    i.attribute6,
                    i.attribute7,
                    i.attribute8,
                    i.attribute9,
                    i.attribute10,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    i.booking_ms_dtl_id,
                    i.carparking
                );

            END LOOP;

            BEGIN
                SELECT
                    nvl(bd.booking_amount, 0)                                                                                        AS booking_amount,
                    nvl(bd.disc_amount, 0)                                                                                           AS disc_amount,
                    nvl(bd.tax_amount, 0)                                                                                            AS tax_amount,
                    ( round(nvl(bd.booking_amount, 0) - nvl(bd.disc_amount, 0) + nvl(bd.tax_amount, 0), 2) )                                  AS total_spa_amount,
                    bh.org_id                                                                                                       AS org_id
                INTO
                    l_old_booking_amount,
                    l_old_disc_amount,
                    l_old_tax_amount,
                    l_old_total_spa_amount,
                    l_org_id
                FROM
                    xxpm_booking_detail  bd,
                    xxpm_booking_header  bh
                WHERE
                        bh.booking_hdr_id = bd.booking_hdr_id
                    AND bd.booking_hdr_id = p_booking_hdr_id;

            EXCEPTION
                WHEN OTHERS THEN
                    l_old_booking_amount := NULL;
                    l_old_disc_amount := NULL;
                    l_old_tax_amount := NULL;
                    l_old_total_spa_amount := NULL;
                    l_org_id := NULL;
            END;

            UPDATE xxpm_book_ms_rev_hdr
            SET
                status = 'DRA',
                old_booking_amount = l_old_booking_amount,
                old_disc_amount = l_old_disc_amount,
                old_tax_amount = l_old_tax_amount,
                old_total_spa_amount = l_old_total_spa_amount,
                org_id = l_org_id,
                new_booking_amount = NULL,
                new_disc_amount = NULL,
                new_tax_amount = NULL,
                new_total_spa_amount = NULL,
                new_cust_id = NULL,
                new_ship_to_site_id = NULL,
                new_bill_to_site_id = NULL,
                new_cust_contact_id = NULL
            WHERE
                    ms_rev_id = l_ms_rev_id
                AND booking_hdr_id = p_booking_hdr_id;

            dbms_output.put_line('record inserted for the booking milestone revision booking_hdr_id');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                retcode := 1;
                errbuf := substr(sqlerrm, 1, 1000);
        END;

    END get_milestones;

    PROCEDURE update_milestones (
        p_rev_hdr_id      IN   NUMBER,
        p_booking_hdr_id  IN   NUMBER,
        p_username        IN   VARCHAR2,
        msg               OUT  VARCHAR2,
        msg_code          OUT  VARCHAR2,
        p_delet_count     OUT  VARCHAR2,
        p_new_count       OUT  VARCHAR2,
        p_update_count    OUT  VARCHAR2
    ) AS

        l_booking_ms_dtl_id  NUMBER;
        l_tax_code           VARCHAR2(30);
        l_tax_rate           NUMBER;
        l_delet_count        NUMBER := 0;
        l_new_count          NUMBER := 0;
        l_update_count       NUMBER := 0;

--  CURSOR book_ms
--  IS
--    SELECT booking_ms_dtl_id,
--      milestone_type,
--      ms_dtl_id,
--      pl_mod_id,
--      seq_number,
--      installment_type,
--      installment_pct,
--      installment_amount,
--      uom,
--      quantity,
--      rate,
--      wave_off,
--      included_in_rate,
--      installment_method,
--      installment_event,
--      period_occurence,
--      period_values,
--      period_duration,
--      charge_type,
--      payment_term,
--      remarks,
--      due_days,
--      due_days_from,
--      due_date,
--      attribute_category,
--      attribute1,
--      attribute2,
--      attribute3,
--      attribute4,
--      attribute5,
--      attribute6,
--      attribute7,
--      attribute8,
--      attribute9,
--      attribute10,
--      created_by,
--      creation_date,
--      last_updated_by,
--      last_update_date,
--      last_update_login,
--      source_func_id,
--      source_func_ref_id,
--      billing_id,
--      status,
--      invoice_id,
--      booking_hdr_id
--    FROM xxpm_booking_milestones
--    WHERE booking_hdr_id = p_booking_hdr_id;
        CURSOR book_ms_rev IS
        SELECT
            ms_rev_dtl_id,
            ms_rev_id,
            source_func_id,
            source_func_ref_id,
            milestone_type,
            ms_dtl_id,
            pl_mod_id,
            seq_number,
            installment_type,
            installment_pct,
            installment_amount,
            uom,
            quantity,
            rate,
            wave_off,
            included_in_rate,
            installment_method,
            installment_event,
            period_occurence,
            period_values,
            period_duration,
            charge_type,
            payment_term,
            remarks,
            due_days,
            due_days_from,
            due_date,
            billing_id,
            status,
            invoice_id,
            installment_pct_r,
            installment_amount_r,
            action_flag,
            attribute_category,
            attribute1,
            attribute2,
            attribute3,
            attribute4,
            attribute5,
            attribute6,
            attribute7,
            attribute8,
            attribute9,
            attribute10,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login,
            booking_ms_dtl_id,
            carparking
        FROM
            xxpm_book_ms_rev_dtl
        WHERE
            ms_rev_id = p_rev_hdr_id;

    BEGIN
--  retcode := 0 ;
--  errbuf  := 'success' ;

        BEGIN
            SELECT
                tax_code,
                tax_rate
            INTO
                l_tax_code,
                l_tax_rate
            FROM
                xxpm_booking_detail
            WHERE
                booking_hdr_id = p_booking_hdr_id;

        END;
----BASEAMOUNT
----TAX_AMOUNT
----l_LINE_AMT:=p_TOTAL_SPA/(100+l_taxper)*100;
----p_TAX_AMT:=p_TOTAL_SPA/(100+l_taxper)*l_taxper;

        BEGIN
            FOR i IN book_ms_rev LOOP
                IF ( i.booking_ms_dtl_id IS NOT NULL ) THEN
                    dbms_output.put_line('111');
                    IF ( i.action_flag = 'DEL' ) THEN
                        DELETE FROM xxpm_booking_milestones
                        WHERE
                            booking_ms_dtl_id = i.booking_ms_dtl_id;

                        COMMIT;
              --dinesh
                        DELETE FROM xxpm_book_ms_rev_dtl
                        WHERE
                                action_flag = 'DEL'
                            AND booking_ms_dtl_id = i.booking_ms_dtl_id;

                        COMMIT;
                        l_delet_count := l_delet_count + 1;
                        dbms_output.put_line('delete' || i.booking_ms_dtl_id);
                    ELSIF ( i.action_flag = 'UPD' ) THEN
--        dbms_output.put_line('id=='|| i.ms_rev_dtl_id); 
--        dbms_output.put_line('action_flag'|| i.action_flag); 
                        UPDATE xxpm_property_units
                        SET
                            status = 'ALOT'
                        WHERE
                            unit_number = i.carparking;

                        COMMIT;
                        UPDATE xxpm_booking_milestones
                        SET
                            installment_pct = round(i.installment_pct_r, 2),
                            installment_amount = i.installment_amount_r,
                            status = i.status,
                            source_func_id = i.source_func_id,
                            source_func_ref_id = i.source_func_ref_id,
                            milestone_type = i.milestone_type,
                            ms_dtl_id = i.ms_dtl_id,
                            pl_mod_id = i.pl_mod_id,
                            seq_number = i.seq_number,
                            installment_type = i.installment_type,
                            uom = i.uom,
                            quantity = i.quantity,
                            rate = i.rate,
                            wave_off = i.wave_off,
                            included_in_rate = i.included_in_rate,
                            installment_method = i.installment_method,
                            installment_event = i.installment_event,
                            period_occurence = i.period_occurence,
                            period_values = i.period_values,
                            period_duration = i.period_duration,
                            charge_type = i.charge_type,
                            payment_term = i.payment_term,
                            remarks = i.remarks,
                            due_days = i.due_days,
                            due_days_from = i.due_days_from,
                            due_date = i.due_date,
                            billing_id = i.billing_id,
                            last_updated_by = i.last_updated_by,
                            last_update_date = i.last_update_date,
                            last_update_login = i.last_update_login,
                            booking_ms_dtl_id = i.booking_ms_dtl_id,
                            carparking = i.carparking,
                            baseamount = get_line_amt(i.installment_amount_r, l_tax_code, nvl(l_tax_rate, 0)),
                            tax_amount = get_tax_amt(i.installment_amount_r, l_tax_code, nvl(l_tax_rate, 0)),
                            tax_code = l_tax_code,
                            tax_rate = l_tax_rate
                        WHERE
                            booking_ms_dtl_id = i.booking_ms_dtl_id;

                        COMMIT;
                        l_update_count := l_update_count + 1;
                    END IF;

                ELSE
                    IF ( i.action_flag = 'NEW' ) THEN
                        dbms_output.put_line('NEW= ');
                        update_cp_unit(i.carparking, p_booking_hdr_id);
                        COMMIT;
                        UPDATE xxpm_property_units
                        SET
                            status = 'ALOT'
                        WHERE
                            unit_number = i.carparking;

                        COMMIT;
                        SELECT
                            xxpm_booking_milestones_s.NEXTVAL
                        INTO l_booking_ms_dtl_id
                        FROM
                            dual;

                        INSERT INTO xxpm_booking_milestones (
                            booking_ms_dtl_id,
                            milestone_type,
                            ms_dtl_id,
                            pl_mod_id,
                            seq_number,
                            installment_type,
                            installment_pct,
                            installment_amount,
                            uom,
                            quantity,
                            rate,
                            wave_off,
                            included_in_rate,
                            installment_method,
                            installment_event,
                            period_occurence,
                            period_values,
                            period_duration,
                            charge_type,
                            payment_term,
                            remarks,
                            due_days,
                            due_days_from,
                            due_date,
                            attribute_category,
                            attribute1,
                            attribute2,
                            attribute3,
                            attribute4,
                            attribute5,
                            attribute6,
                            attribute7,
                            attribute8,
                            attribute9,
                            attribute10,
                            created_by,
                            creation_date,
                            last_updated_by,
                            last_update_date,
                            last_update_login,
                            source_func_id,
                            source_func_ref_id,
                            billing_id,
                            status,
                            invoice_id,
                            booking_hdr_id,
                            carparking,
                            tax_rate,
                            tax_code,
                            tax_amount,
                            baseamount
                        ) VALUES (
                            l_booking_ms_dtl_id,
                            i.milestone_type,
                            i.ms_dtl_id,
                            i.pl_mod_id,
                            i.seq_number,
                            i.installment_type,
                            round(nvl(i.installment_pct_r, 0), 2),
                            i.installment_amount_r,
                            i.uom,
                            i.quantity,
                            i.rate,
                            i.wave_off,
                            i.included_in_rate,
                            i.installment_method,
                            i.installment_event,
                            i.period_occurence,
                            i.period_values,
                            i.period_duration,
                            i.charge_type,
                            i.payment_term,
                            i.remarks,
                            i.due_days,
                            i.due_days_from,
                            i.due_date,
                            i.attribute_category,
                            i.attribute1,
                            i.attribute2,
                            i.attribute3,
                            i.attribute4,
                            i.attribute5,
                            i.attribute6,
                            i.attribute7,
                            i.attribute8,
                            i.attribute9,
                            i.attribute10,
                            i.created_by,
                            i.creation_date,
                            i.last_updated_by,
                            i.last_update_date,
                            i.last_update_login,
                            i.source_func_id,
                            i.source_func_ref_id,
                            i.billing_id,
                            i.status,
                            i.invoice_id,
                            p_booking_hdr_id,
                            i.carparking,
                            l_tax_rate,
                            l_tax_code,
                            get_tax_amt(i.installment_amount_r, l_tax_code, nvl(l_tax_rate, 0)),
                            get_line_amt(i.installment_amount_r, l_tax_code, nvl(l_tax_rate, 0))
                        );

                        COMMIT;
                        l_new_count := l_new_count + 1;
          -- code to update booking_ms_dtl_id field in rev detail table
                        UPDATE xxpm_book_ms_rev_dtl
                        SET
                            booking_ms_dtl_id = l_booking_ms_dtl_id,
                            source_func_id = 58,
                            source_func_ref_id = ms_rev_id,
                            action_flag = 'UPD'
                        WHERE
                            ms_rev_dtl_id = i.ms_rev_dtl_id;

                        UPDATE xxpm_booking_milestones
                        SET
                            source_func_id = 58,
                            source_func_ref_id = i.ms_rev_id
                        WHERE
                            booking_ms_dtl_id = l_booking_ms_dtl_id;

                        COMMIT;
                    END IF;
                END IF;
            END LOOP;
    -- dbms_output.put_line('record inserted for the booking milestone table booking_hdr_id'|| i_booking_id);
            COMMIT;
            BEGIN
--    FOR j IN book_ms
--    LOOP
--      UPDATE xxpm_book_ms_rev_dtl
--      SET installment_amount =j.installment_amount,
--        installment_pct      =j.installment_pct
--      WHERE booking_ms_dtl_id=j.booking_ms_dtl_id;
--    END LOOP;
                UPDATE xxpm_book_ms_rev_hdr
                SET
                    status = 'APR',
                    old_booking_amount = new_booking_amount,
                    old_disc_amount = new_disc_amount,
                    old_tax_amount = new_tax_amount,
                    old_total_spa_amount = new_total_spa_amount,
                    new_booking_amount = NULL,
                    new_disc_amount = NULL,
                    new_tax_amount = NULL,
                    new_total_spa_amount = NULL,
                    new_cust_id = NULL,
                    new_ship_to_site_id = NULL,
                    new_bill_to_site_id = NULL,
                    new_cust_contact_id = NULL
                WHERE
                    ms_rev_id = p_rev_hdr_id;
    -- dbms_output.put_line('record inserted for the booking milestone table booking_hdr_id'|| i_booking_id);
                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
--    retcode := 1 ;
--    errbuf  := SUBSTR(sqlerrm, 1, 1000);
                    msg := sqlerrm;
                    msg_code := 'E';
            END;

            msg := 'Success';
            msg_code := 'S';
            p_delet_count := l_delet_count;
            p_new_count := l_new_count;
            p_update_count := l_update_count;
        EXCEPTION
            WHEN OTHERS THEN
                msg := sqlerrm;
                msg_code := 'E';
--    retcode := 1 ;
--    errbuf  := SUBSTR(sqlerrm, 1, 1000);
        END;

    END update_milestones;

    FUNCTION get_customername (
        p_booking_id xxpm_booking_customer.booking_hdr_id%TYPE
    ) RETURN VARCHAR2 IS
        l_cust_name  xxstg_customer.customer_name%TYPE;
        l_cust_id    xxstg_customer.cust_id%TYPE;
    BEGIN
        SELECT
            cust_id
        INTO l_cust_id
        FROM
            xxpm_booking_customer
        WHERE
                booking_hdr_id = p_booking_id
            AND primary_yn = 'Y'
            AND ROWNUM = 1;

        SELECT
            customer_name
        INTO l_cust_name
        FROM
            xxstg_customer
        WHERE
            cust_id = l_cust_id;

        RETURN l_cust_name;
    END get_customername;

    FUNCTION get_customersite (
        p_booking_id xxpm_booking_customer.booking_hdr_id%TYPE
    ) RETURN NUMBER IS
        l_cust_site_id xxpm_booking_customer.bill_to_site_id%TYPE;
    BEGIN
        SELECT
            bill_to_site_id
        INTO l_cust_site_id
        FROM
            xxpm_booking_customer
        WHERE
                booking_hdr_id = p_booking_id
            AND primary_yn = 'Y'
            AND ROWNUM = 1;

        RETURN l_cust_site_id;
    END get_customersite;

    FUNCTION get_customersitename (
        p_booking_id xxpm_booking_customer.booking_hdr_id%TYPE
    ) RETURN VARCHAR2 IS
        l_cust_site_id    xxpm_booking_customer.bill_to_site_id%TYPE;
        l_cust_site_name  VARCHAR2(130);
        l_org_id          NUMBER;
    BEGIN
        SELECT
            bill_to_site_id
        INTO l_cust_site_id
        FROM
            xxpm_booking_customer
        WHERE
                booking_hdr_id = p_booking_id
            AND primary_yn = 'Y'
            AND ROWNUM = 1;

        SELECT
            org_id
        INTO l_org_id
        FROM
            xxpm_booking_header
        WHERE
            booking_hdr_id = p_booking_id;

        SELECT
            country
            || ' '
            || city
        INTO l_cust_site_name
        FROM
            xxstg_cust_sites
        WHERE
                cust_site_id = l_cust_site_id
            AND org_id = l_org_id;

        RETURN l_cust_site_name;
    END get_customersitename;

    PROCEDURE get_updated_milestones (
        p_rev_hdr_id      IN  NUMBER,
        p_booking_hdr_id  IN  NUMBER
    ) AS
        l_old_ms_rev_id NUMBER;
    BEGIN
        BEGIN
            IF ( p_rev_hdr_id IS NULL ) THEN
                SELECT
                    ms_rev_id
                INTO l_old_ms_rev_id
                FROM
                    xxpm_book_ms_rev_hdr
                WHERE
                    booking_hdr_id = p_booking_hdr_id;

            ELSE
                l_old_ms_rev_id := p_rev_hdr_id;
            END IF;
        EXCEPTION
            WHEN no_data_found THEN
                dbms_output.put_line('P_ERROR_CODE');
        END;

        MERGE INTO xxpm_book_ms_rev_dtl a
        USING (
                  SELECT
                      booking_ms_dtl_id,
                      milestone_type,
                      ms_dtl_id,
                      pl_mod_id,
                      seq_number,
                      installment_type,
                      installment_pct,
                      installment_amount,
                      uom,
                      quantity,
                      rate,
                      wave_off,
                      included_in_rate,
                      installment_method,
                      installment_event,
                      period_occurence,
                      period_values,
                      period_duration,
                      charge_type,
                      payment_term,
                      remarks,
                      due_days,
                      due_days_from,
                      due_date,
                      attribute_category,
                      attribute1,
                      attribute2,
                      attribute3,
                      attribute4,
                      attribute5,
                      attribute6,
                      attribute7,
                      attribute8,
                      attribute9,
                      attribute10,
                      created_by,
                      creation_date,
                      last_updated_by,
                      last_update_date,
                      last_update_login,
                      source_func_id,
                      source_func_ref_id,
                      billing_id,
                      status,
                      invoice_id,
                      booking_hdr_id,
                      baseamount,
                      tax_rate,
                      tax_code,
                      tax_amount,
                      carparking
                  FROM
                      xxpm_booking_milestones
                  WHERE
                      booking_hdr_id = p_booking_hdr_id
              )
        i ON ( a.booking_ms_dtl_id = i.booking_ms_dtl_id )
        WHEN MATCHED THEN UPDATE
        SET installment_pct = i.installment_pct,
            installment_amount = i.installment_amount,
            status = i.status
        WHEN NOT MATCHED THEN
        INSERT (
            ms_rev_dtl_id,
            ms_rev_id,
            source_func_id,
            source_func_ref_id,
            milestone_type,
            ms_dtl_id,
            pl_mod_id,
            seq_number,
            installment_type,
            installment_pct,
            installment_amount,
            uom,
            quantity,
            rate,
            wave_off,
            included_in_rate,
            installment_method,
            installment_event,
            period_occurence,
            period_values,
            period_duration,
            charge_type,
            payment_term,
            remarks,
            due_days,
            due_days_from,
            due_date,
            billing_id,
            status,
            invoice_id,
            installment_pct_r,
            installment_amount_r,
            action_flag,
            attribute_category,
            attribute1,
            attribute2,
            attribute3,
            attribute4,
            attribute5,
            attribute6,
            attribute7,
            attribute8,
            attribute9,
            attribute10,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login,
            booking_ms_dtl_id,
            carparking )
        VALUES
            ( xxpm_booking_rev_id_s.NEXTVAL,
--          p_rev_hdr_id,
            l_old_ms_rev_id,
            i.source_func_id,
            i.source_func_ref_id,
            i.milestone_type,
            i.ms_dtl_id,
            i.pl_mod_id,
            i.seq_number,
            i.installment_type,
            i.installment_pct,
            i.installment_amount,
            i.uom,
            i.quantity,
            i.rate,
            i.wave_off,
            i.included_in_rate,
            i.installment_method,
            i.installment_event,
            i.period_occurence,
            i.period_values,
            i.period_duration,
            i.charge_type,
            i.payment_term,
            i.remarks,
            i.due_days,
            i.due_days_from,
            i.due_date,
            i.billing_id,
            i.status,
            i.invoice_id,
            i.installment_pct,
            i.installment_amount,
            nvl2(i.invoice_id, 'NA', 'UPD'),
            i.attribute_category,
            i.attribute1,
            i.attribute2,
            i.attribute3,
            i.attribute4,
            i.attribute5,
            i.attribute6,
            i.attribute7,
            i.attribute8,
            i.attribute9,
            i.attribute10,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            i.booking_ms_dtl_id,
            i.carparking );

        COMMIT;
    END get_updated_milestones;

    FUNCTION get_line_amt (
        p_total_spa  IN  NUMBER,
        p_tax_code   IN  VARCHAR2,
        p_tax_perc   IN  NUMBER
    ) RETURN NUMBER AS
        l_line_amt  NUMBER;
        l_taxper    NUMBER;
    BEGIN
        IF p_tax_perc IS NOT NULL THEN
            l_line_amt := p_total_spa / ( 100 + p_tax_perc ) * 100;
--DBMS_OUTPUT.PUT_LINE('HAVING PERCENTAGE');
        ELSE
            IF ( p_tax_code = 'COMMERCIAL' ) THEN
                l_taxper := 5;
            ELSIF ( p_tax_code = 'COMMERCIAL EXEMPT' ) THEN
                l_taxper := 0;
            ELSIF ( p_tax_code = 'RESIDENTIAL' ) THEN
                l_taxper := 0;
            ELSIF ( p_tax_code = 'RESIDENTIAL EXEMPT' ) THEN
                l_taxper := 0;
            ELSIF ( p_tax_code = 'STANDARD RATE' ) THEN
                l_taxper := 5;
            ELSE
                l_taxper := 0;
            END IF;

            l_line_amt := p_total_spa / ( 100 + l_taxper ) * 100;
            dbms_output.put_line('NO PERCENTAGE');
        END IF;

        RETURN l_line_amt;
    EXCEPTION
        WHEN no_data_found THEN
            l_line_amt := 0;
            RETURN l_line_amt;
    END get_line_amt;

    FUNCTION get_tax_amt (
        p_total_spa  IN  NUMBER,
        p_tax_code   IN  VARCHAR2,
        p_tax_perc   IN  NUMBER
    ) RETURN NUMBER AS
        p_tax_amt  NUMBER;
        l_taxper   NUMBER;
    BEGIN
        IF p_tax_perc IS NOT NULL THEN
            p_tax_amt := p_total_spa / ( 100 + p_tax_perc ) * p_tax_perc;
--DBMS_OUTPUT.PUT_LINE('HAVING PERCENTAGE');
        ELSE
            IF ( p_tax_code = 'COMMERCIAL' ) THEN
                l_taxper := 5;
            ELSIF ( p_tax_code = 'COMMERCIAL EXEMPT' ) THEN
                l_taxper := 0;
            ELSIF ( p_tax_code = 'RESIDENTIAL' ) THEN
                l_taxper := 0;
            ELSIF ( p_tax_code = 'RESIDENTIAL EXEMPT' ) THEN
                l_taxper := 0;
            ELSIF ( p_tax_code = 'STANDARD RATE' ) THEN
                l_taxper := 5;
            ELSE
                l_taxper := 0;
            END IF;

            p_tax_amt := p_total_spa / ( 100 + l_taxper ) * l_taxper;
            dbms_output.put_line('NO PERCENTAGE');
        END IF;

        RETURN p_tax_amt;
    EXCEPTION
        WHEN no_data_found THEN
            p_tax_amt := 0;
            RETURN p_tax_amt;
    END get_tax_amt;

    PROCEDURE update_cp_unit (
        cp_number         IN  VARCHAR2,
        p_booking_hdr_id  IN  NUMBER
    ) AS
        cp_unit_id     NUMBER;
        p_unit_id      NUMBER;
        p_property_id  NUMBER;
    BEGIN
        SELECT
            unit_id,
            property_id
        INTO
            p_unit_id,
            p_property_id
        FROM
            xxpm_booking_detail
        WHERE
            booking_hdr_id = p_booking_hdr_id;

        SELECT
            unit_id
        INTO cp_unit_id
        FROM
            xxpm_property_units
        WHERE
                ROWNUM = 1
            AND property_id = p_property_id
            AND unit_number = cp_number;

        UPDATE xxpm_property_units
        SET
            status = 'ALOT'
        WHERE
            unit_number = cp_number;

        INSERT INTO xxpm_property_carparks (
            carpark_id,
            unit_id,
            cp_unit_id,
            allot_type,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login
        ) VALUES (
            xxpm_area_id_s.NEXTVAL,
            p_unit_id,
            cp_unit_id,
            'PAID',
            'anonymous',
            to_timestamp(sysdate),
            'anonymous',
            to_timestamp(sysdate),
            'anonymous'
        );

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

END xxpm_book_ms_rev_pkg;
