CREATE OR REPLACE PROCEDURE "XXSTG_SYNC_CUSTOMER" (
    p_xml_data   IN           CLOB,
    p_status     OUT          VARCHAR2
) AS

    acct_doc XMLTYPE := xmltype.createxml(p_xml_data);
    TYPE customer_tbl_type IS TABLE OF xxstg_customer%rowtype INDEX BY BINARY_INTEGER;
    -- varialble
    l_customer_tbl   customer_tbl_type;
    
    CURSOR c_customer IS
    SELECT
        cust_id,
        customer_number,
        customer_name,
        'Test' customer_name_tl,
        sales_person_id,
        lead_id,
        orig_system_ref,
        'Y' active_yn,
        'anonymous' created_by,
        SYSDATE   creation_date,
        'anonymous' last_updated_by,
        SYSDATE   last_update_date,
        'anonymous' last_update_login,
        title,
        sur_name,
        middle_name,
        first_name,
        passport_no
    FROM
        XMLTABLE ( '/DATA_DS/G_1' PASSING acct_doc COLUMNS 
        cust_id NUMBER PATH 'CUST_ID', 
        customer_number VARCHAR2(30) PATH 'CUSTOMER_NUMBER'
        ,customer_name VARCHAR2(240) PATH 'CUSTOMER_NAME'
        ,orig_system_ref NUMBER PATH 'ORIG_SYSTEM_REF'
        ,active_yn VARCHAR2(1) PATH 'ACTIVE_YN'
        ,created_by VARCHAR2(60) PATH 'CREATED_BY'
        ,creation_date VARCHAR2(150) PATH 'CREATION_DATE'
        ,last_updated_by VARCHAR2(60) PATH 'LAST_UPDATED_BY'
        ,last_update_date VARCHAR2(150) PATH 'LAST_UPDATE_DATE'
        ,last_update_login VARCHAR2(150) PATH 'LAST_UPDATE_LOGIN'
        ,lead_id NUMBER PATH 'LEAD_ID'
        ,sales_person_id NUMBER PATH 'SALES_PERSON_ID'
        ,title VARCHAR2(60) PATH 'TITLE'
        ,sur_name VARCHAR2(60) PATH 'SUR_NAME'
        ,first_name VARCHAR2(60) PATH 'FIRST_NAME'
        ,middle_name VARCHAR2(60) PATH 'MIDDLE_NAME'
        ,passport_no VARCHAR2(60) PATH 'PASSPPORT_NO' 
        );

BEGIN
    OPEN c_customer;
    FETCH c_customer BULK COLLECT INTO l_customer_tbl;
    CLOSE c_customer;
    FOR i IN l_customer_tbl.first..l_customer_tbl.last 
    LOOP 
    IF l_customer_tbl(i).cust_id IS NOT NULL THEN
     MERGE INTO xxstg_customer a USING (
        SELECT
                                                  l_customer_tbl(i).cust_id cust_id,
                                                  l_customer_tbl(i).customer_number customer_number,
                                                  l_customer_tbl(i).customer_name customer_name,
                                                  l_customer_tbl(i).orig_system_ref orig_system_ref,
                                                  l_customer_tbl(i).active_yn active_yn,
                                                  l_customer_tbl(i).created_by created_by,
                                                  l_customer_tbl(i).creation_date creation_date,
                                                  l_customer_tbl(i).last_updated_by last_updated_by,
                                                  l_customer_tbl(i).last_update_date last_update_date,
                                                  l_customer_tbl(i).last_update_login last_update_login,
                                                  l_customer_tbl(i).lead_id lead_id,
                                                  l_customer_tbl(i).sales_person_id sales_person_id,
                                                  l_customer_tbl(i).title title,
                                                  l_customer_tbl(i).sur_name sur_name,
                                                  l_customer_tbl(i).middle_name middle_name,
                                                  l_customer_tbl(i).first_name first_name,
                                                  l_customer_tbl(i).passport_no passport_no
                                              FROM
                                                  dual
                                          )
        b ON ( a.cust_id = b.cust_id 
                AND b.cust_id IS NOT NULL )
        WHEN MATCHED THEN 
        UPDATE 
        SET 
        customer_number = b.customer_number,
        customer_name = b.customer_name,
        orig_system_ref = b.orig_system_ref,
        active_yn = b.active_yn,
        created_by = b.created_by,
        creation_date = b.creation_date,
        last_updated_by = b.last_updated_by,
        last_update_date = b.last_update_date,
        last_update_login = b.last_update_login,
        lead_id = b.lead_id,
        sales_person_id = b.sales_person_id,
        title = b.title,
        sur_name = b.sur_name,
        middle_name = b.middle_name,
        first_name = b.first_name,
        passport_no = b.passport_no
        WHEN NOT MATCHED THEN 
        INSERT (
            cust_id,
            customer_number,
            customer_name,
            orig_system_ref,
            active_yn,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login,
            lead_id,
            sales_person_id,
            title,
            sur_name,
            middle_name,
            first_name,
            passport_no ) 
            VALUES (
            b.cust_id,
            b.customer_number,
            b.customer_name,
            b.orig_system_ref,
            b.active_yn,
            b.created_by,
            b.creation_date,
            b.last_updated_by,
            b.last_update_date,
            b.last_update_login,
            b.lead_id,
            b.sales_person_id,
            b.title,
            b.sur_name,
            b.middle_name,
            b.first_name,
            b.passport_no
            );

    END IF;
    END LOOP;
    p_status:='Success';
    COMMIT;
END;