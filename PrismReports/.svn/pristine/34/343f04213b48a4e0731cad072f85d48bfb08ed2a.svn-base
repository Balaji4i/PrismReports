create or replace PROCEDURE "XXSTG_SYNC_CUSTOMER_CONTACT" (
    p_xml_data   IN           CLOB,
    p_status     OUT          VARCHAR2
) AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE cust_cont_tbl_type IS TABLE OF xxstg_cust_contacts%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_cust_cont_tbl cust_cont_tbl_type;

      CURSOR c_cust_cont
      IS
                    SELECT cust_contact_id
                          ,cust_id
                          ,cust_site_id
                          ,contact_name
                          ,NULL contact_name_tl
                          ,designation
                          ,mobile_number
                          ,phone_number
                          ,fax_number
                          ,email_id
                          ,passport_number
                          ,passport_exp_date
                          ,national_id_number
                          ,national_id_exp_date
                          ,orig_system_ref
                          ,'Y' active_yn
                          ,primary_yn
                          ,'anonymous' created_by
                          ,SYSDATE creation_date
                          ,'anonymous' last_updated_by
                          ,SYSDATE last_update_date
                          ,'anonymous' last_update_login
                      FROM XMLTABLE (
                              '/DATA_DS/G_1'
                              PASSING acct_doc
                              COLUMNS cust_contact_id  NUMBER PATH 'CUST_CONTACT_ID'
                                     ,cust_id          NUMBER PATH 'CUST_ID'
                                     ,cust_site_id     NUMBER PATH 'CUST_SITE_ID'
                                     ,contact_name     VARCHAR2 (240) PATH 'CONTACT_NAME'
                                     ,designation      VARCHAR2 (60) PATH 'DESIGNATION'
                                     ,mobile_number    VARCHAR2 (60) PATH 'PHONE_NUMBER'
                                     ,phone_number     VARCHAR2 (60) PATH 'PHONE_NUMBER'
                                     ,email_id         VARCHAR2 (60) PATH 'EMAIL_ADDRESS'
                                     ,passport_number  VARCHAR2 (60) PATH 'PASSPORT_NUMBER'
                                     ,passport_exp_date DATE PATH 'PASSPORT_EXP_DATE'
                                     ,national_id_number VARCHAR2 (60) PATH 'NATIONAL_ID_NUMBER'
                                     ,national_id_exp_date DATE PATH 'NATIONAL_ID_EXP_DATE'
                                     ,orig_system_ref  NUMBER PATH 'CONTACT_ID'
                                     ,active_yn        VARCHAR2 (1) PATH 'ACTIVE_YN'
                                     ,primary_yn       VARCHAR2 (1) PATH 'PRIMARY_YN'
                                     ,cust_contact_num NUMBER PATH 'CONTACT_NUMBER'
                                     ,fax_number       VARCHAR2 (240) PATH 'FAX_NUMBER');
   BEGIN
      OPEN c_cust_cont;

      FETCH c_cust_cont
      BULK COLLECT INTO l_cust_cont_tbl;

      CLOSE c_cust_cont;

      FOR i IN l_cust_cont_tbl.FIRST .. l_cust_cont_tbl.LAST
      LOOP
         MERGE INTO xxstg_cust_contacts a
              USING (SELECT l_cust_cont_tbl (i).cust_contact_id
                               cust_contact_id
                           ,l_cust_cont_tbl (i).cust_id cust_id
                           ,l_cust_cont_tbl (i).cust_site_id cust_site_id
                           ,l_cust_cont_tbl (i).contact_name contact_name
                           ,l_cust_cont_tbl (i).designation designation
                           ,l_cust_cont_tbl (i).mobile_number mobile_number
                           ,l_cust_cont_tbl (i).phone_number phone_number
                           ,l_cust_cont_tbl (i).email_id email_id
                           ,l_cust_cont_tbl (i).passport_number passport_number
                           ,l_cust_cont_tbl (i).passport_exp_date passport_exp_date
                           ,l_cust_cont_tbl (i).national_id_number national_id_number
                           ,l_cust_cont_tbl (i).national_id_exp_date national_id_exp_date
                           ,l_cust_cont_tbl (i).orig_system_ref orig_system_ref
                           ,l_cust_cont_tbl (i).active_yn active_yn
                           ,l_cust_cont_tbl (i).fax_number fax_number
                           ,l_cust_cont_tbl (i).created_by created_by
                           ,l_cust_cont_tbl (i).creation_date creation_date
                           ,l_cust_cont_tbl (i).last_updated_by last_updated_by
                           ,l_cust_cont_tbl (i).last_update_date last_update_date
                           ,l_cust_cont_tbl (i).last_update_login last_update_login
                       FROM DUAL) b
                 ON (    a.cust_contact_id = b.cust_contact_id
                     AND a.cust_id = b.cust_id)
         WHEN MATCHED
         THEN
            UPDATE SET cust_site_id = b.cust_site_id
                      ,contact_name = b.contact_name
                      ,designation  = b.designation
                      ,mobile_number = b.mobile_number
                      ,phone_number = b.phone_number
                      ,email_id     = b.email_id
                      ,passport_number = b.passport_number
                      ,passport_exp_date = b.passport_exp_date
                      ,national_id_number = b.national_id_number
                      ,national_id_exp_date = b.national_id_exp_date
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      ,fax_number   = b.fax_number
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
         WHEN NOT MATCHED
         THEN
            INSERT     (cust_contact_id
                       ,cust_id
                       ,cust_site_id
                       ,contact_name
                       ,designation
                       ,mobile_number
                       ,phone_number
                       ,email_id
                       ,passport_number
                       ,passport_exp_date
                       ,national_id_number
                       ,national_id_exp_date
                       ,orig_system_ref
                       ,active_yn
                       ,fax_number
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login)
                VALUES (b.cust_contact_id
                       ,b.cust_id
                       ,b.cust_site_id
                       ,b.contact_name
                       ,b.designation
                       ,b.mobile_number
                       ,b.phone_number
                       ,b.email_id
                       ,b.passport_number
                       ,b.passport_exp_date
                       ,b.national_id_number
                       ,b.national_id_exp_date
                       ,b.orig_system_ref
                       ,b.active_yn
                       ,b.fax_number
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login);
      END LOOP;

    p_status:='Success';
    COMMIT;
END;