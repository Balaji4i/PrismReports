--------------------------------------------------------
--  DDL for Package XXSTG_INTEGRATION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXSTG_INTEGRATION_PKG" 
IS
   PROCEDURE bank_accounts (p_xml_data CLOB);
   
   PROCEDURE customers (p_xml_data CLOB);  
   
   PROCEDURE customer_site (p_xml_data CLOB);
   
   PROCEDURE locations (p_xml_data CLOB);
   
   PROCEDURE organizations (p_xml_data CLOB);
   
   PROCEDURE payment_terms (p_xml_data CLOB);
   
   PROCEDURE customer_contact (p_xml_data CLOB);
   
PROCEDURE employee (p_xml_data CLOB);  
   
   PROCEDURE vendor (p_xml_data CLOB);
   
   PROCEDURE vendor_contact (p_xml_data CLOB);
   
   PROCEDURE vendor_site (p_xml_data CLOB);
   
   PROCEDURE projects (p_xml_data CLOB);
   
   PROCEDURE project_milestone (p_xml_data CLOB);
   
   PROCEDURE invoice_status (p_xml_data CLOB);
   
   PROCEDURE receipt_status (p_xml_data CLOB);
   
   PROCEDURE receipt_method (p_xml_data CLOB);
   
END xxstg_integration_pkg;


--------------------------------------------------------
--  DDL for Package Body XXSTG_INTEGRATION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXSTG_INTEGRATION_PKG" 
IS
   PROCEDURE bank_accounts (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE bank_acct_tbl_type IS TABLE OF xxstg_bank_accounts%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_bank_acct_tbl bank_acct_tbl_type;

      CURSOR c_bank_acct
      IS
                   SELECT bank_acnt_id
                         ,bank_name
                         ,NULL bank_name_tl
                         ,bank_number
                         ,branch_name
                         ,NULL branch_name_tl
                         ,branch_number
                         ,address1
                         ,NULL address1_tl
                         ,address2
                         ,NULL address2_tl
                         ,address3
                         ,NULL address3_tl
                         ,address4
                         ,NULL address4_tl
                         ,city
                         ,NULL city_tl
                         ,postal_code
                         ,state
                         ,NULL state_tl
                         ,province
                         ,NULL province_tl
                         ,county
                         ,NULL county_tl
                         ,country
                         ,NULL country_tl
                         ,swift_code
                         ,iban
                         ,bank_account_num
                         ,bank_account_type
                         ,currency_code
                         ,orig_bank_ref
                         ,orig_branch_ref
                         ,orig_account_ref
                         ,'Y' active_yn
                         ,'anonymous' created_by
                         ,SYSDATE creation_date
                         ,'anonymous' last_updated_by
                         ,SYSDATE last_update_date
                         ,'anonymous' last_update_login
                         ,NULL bank_account_name
                     FROM XMLTABLE (
                             '/DATA_DS/G_1'
                             PASSING acct_doc
                             COLUMNS bank_acnt_id    NUMBER PATH 'BANK_ACCOUNT_ID'
                                    ,bank_name       VARCHAR2 (240) PATH 'BANK_NAME'
                                    ,bank_number     VARCHAR2 (30) PATH 'BANK_ID       '
                                    ,branch_name     VARCHAR2 (240)
                                           PATH 'BANK_BRANCH_NAME       '
                                    ,branch_number   VARCHAR2 (30)
                                           PATH 'BANK_BRANCH_ID     '
                                    ,address1        VARCHAR2 (240)
                                           PATH 'ADDRESS_LINE1          '
                                    ,address2        VARCHAR2 (240)
                                           PATH 'ADDRESS_LINE2          '
                                    ,address3        VARCHAR2 (240)
                                           PATH 'ADDRESS_LINE3          '
                                    ,address4        VARCHAR2 (240)
                                           PATH 'ADDRESS_LINE4          '
                                    ,city            VARCHAR2 (60)
                                           PATH 'CITY              '
                                    ,postal_code     VARCHAR2 (60) PATH 'ZIP       '
                                    ,state           VARCHAR2 (60)
                                           PATH 'STATE             '
                                    ,province        VARCHAR2 (60)
                                           PATH 'PROVINCE          '
                                    ,county          VARCHAR2 (60)
                                           PATH 'COUNTY            '
                                    ,country         VARCHAR2 (60)
                                           PATH 'COUNTRY           '
                                    ,swift_code      VARCHAR2 (60)
                                           PATH 'SWIFT_CODE        '
                                    ,iban            VARCHAR2 (60) PATH 'IBAN_NUMBER'
                                    ,bank_account_num VARCHAR2 (60)
                                           PATH 'BANK_ACCOUNT_NUM'
                                    ,bank_account_type VARCHAR2 (60)
                                           PATH 'BANK_ACCOUNT_TYPE'
                                    ,currency_code   VARCHAR2 (30) PATH 'CURRENCY_CODE'
                                    ,orig_bank_ref   NUMBER PATH 'BANK_ID      '
                                    ,orig_branch_ref NUMBER PATH 'BANK_BRANCH_ID    '
                                    ,orig_account_ref NUMBER PATH 'BANK_ACCOUNT_ID   '
                                    ,active_yn       VARCHAR2 (1)
                                           PATH 'ACTIVE_YN          '
                                    ,bank_account_name VARCHAR2 (60)
                                           PATH 'BANK_ACCOUNT_NAME');
   BEGIN
      OPEN c_bank_acct;

      FETCH c_bank_acct
      BULK COLLECT INTO l_bank_acct_tbl;

      CLOSE c_bank_acct;

      FOR i IN l_bank_acct_tbl.FIRST .. l_bank_acct_tbl.LAST
      LOOP
         MERGE INTO xxstg_bank_accounts a
              USING (SELECT l_bank_acct_tbl (i).bank_acnt_id bank_acnt_id
                           ,l_bank_acct_tbl (i).bank_name bank_name
                           ,l_bank_acct_tbl (i).bank_number bank_number
                           ,l_bank_acct_tbl (i).branch_name branch_name
                           ,l_bank_acct_tbl (i).branch_number branch_number
                           ,l_bank_acct_tbl (i).address1 address1
                           ,l_bank_acct_tbl (i).address2 address2
                           ,l_bank_acct_tbl (i).address3 address3
                           ,l_bank_acct_tbl (i).address4 address4
                           ,l_bank_acct_tbl (i).city city
                           ,l_bank_acct_tbl (i).postal_code postal_code
                           ,l_bank_acct_tbl (i).state state
                           ,l_bank_acct_tbl (i).province province
                           ,l_bank_acct_tbl (i).county county
                           ,l_bank_acct_tbl (i).country country
                           ,l_bank_acct_tbl (i).swift_code swift_code
                           ,l_bank_acct_tbl (i).iban iban
                           ,l_bank_acct_tbl (i).bank_account_num
                               bank_account_num
                           ,l_bank_acct_tbl (i).bank_account_type
                               bank_account_type
                           ,l_bank_acct_tbl (i).currency_code currency_code
                           ,l_bank_acct_tbl (i).orig_bank_ref orig_bank_ref
                           ,l_bank_acct_tbl (i).orig_branch_ref
                               orig_branch_ref
                           ,l_bank_acct_tbl (i).orig_account_ref
                               orig_account_ref
                           ,l_bank_acct_tbl (i).active_yn active_yn
                           ,l_bank_acct_tbl (i).created_by created_by
                           ,l_bank_acct_tbl (i).creation_date creation_date
                           ,l_bank_acct_tbl (i).last_update_date
                               last_update_date
                           ,l_bank_acct_tbl (i).last_updated_by
                               last_updated_by
                           ,l_bank_acct_tbl (i).last_update_login
                               last_update_login
                           ,l_bank_acct_tbl (i).bank_account_name
                               bank_account_name
                       FROM DUAL) b
                 ON (a.bank_acnt_id = b.bank_acnt_id)
         WHEN MATCHED
         THEN
            UPDATE SET bank_name    = b.bank_name
                      ,bank_number  = b.bank_number
                      ,branch_name  = b.branch_name
                      ,branch_number = b.branch_number
                      ,address1     = b.address1
                      ,address2     = b.address2
                      ,address3     = b.address3
                      ,address4     = b.address4
                      ,city         = b.city
                      ,postal_code  = b.postal_code
                      ,state        = b.state
                      ,province     = b.province
                      ,county       = b.county
                      ,country      = b.country
                      ,swift_code   = b.swift_code
                      ,iban         = b.iban
                      ,bank_account_num = b.bank_account_num
                      ,bank_account_type = b.bank_account_type
                      ,currency_code = b.currency_code
                      ,orig_bank_ref = b.orig_bank_ref
                      ,orig_branch_ref = b.orig_branch_ref
                      ,orig_account_ref = b.orig_account_ref
                      ,active_yn    = b.active_yn
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_update_date = b.last_update_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_login = b.last_update_login
                      ,bank_account_name = b.bank_account_name
         WHEN NOT MATCHED
         THEN
            INSERT     (bank_acnt_id
                       ,bank_name
                       ,bank_number
                       ,branch_name
                       ,branch_number
                       ,address1
                       ,address2
                       ,address3
                       ,address4
                       ,city
                       ,postal_code
                       ,state
                       ,province
                       ,county
                       ,country
                       ,swift_code
                       ,iban
                       ,bank_account_num
                       ,bank_account_type
                       ,currency_code
                       ,orig_bank_ref
                       ,orig_branch_ref
                       ,orig_account_ref
                       ,active_yn
                       ,created_by
                       ,creation_date
                       ,last_update_date
                       ,last_updated_by
                       ,last_update_login
                       ,bank_account_name)
                VALUES (b.bank_acnt_id
                       ,b.bank_name
                       ,b.bank_number
                       ,b.branch_name
                       ,b.branch_number
                       ,b.address1
                       ,b.address2
                       ,b.address3
                       ,b.address4
                       ,b.city
                       ,b.postal_code
                       ,b.state
                       ,b.province
                       ,b.county
                       ,b.country
                       ,b.swift_code
                       ,b.iban
                       ,b.bank_account_num
                       ,b.bank_account_type
                       ,b.currency_code
                       ,b.orig_bank_ref
                       ,b.orig_branch_ref
                       ,b.orig_account_ref
                       ,b.active_yn
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_update_date
                       ,b.last_updated_by
                       ,b.last_update_login
                       ,b.bank_account_name);
      END LOOP;

      COMMIT;
   END bank_accounts;

   PROCEDURE customers (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE customer_tbl_type IS TABLE OF xxstg_customer%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_customer_tbl customer_tbl_type;

      CURSOR c_customer
      IS
                  SELECT cust_id
                        ,customer_number
                        ,customer_name
                        ,'Test' customer_name_tl
                        ,sales_person_id
                        ,lead_id
                        ,orig_system_ref
                        ,'Y' active_yn
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                        ,title
                        ,sur_name
                        ,middle_name
                        ,first_name
                        ,passport_no
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS cust_id        NUMBER PATH 'CUST_ID'
                                   ,customer_number VARCHAR2 (30)
                                          PATH 'CUSTOMER_NUMBER'
                                   ,customer_name  VARCHAR2 (240) PATH 'CUSTOMER_NAME'
                                   ,orig_system_ref NUMBER PATH 'ORIG_SYSTEM_REF'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_YN'
                                   ,created_by     VARCHAR2 (60) PATH 'CREATED_BY'
                                   ,creation_date  VARCHAR2 (150) PATH 'CREATION_DATE'
                                   ,last_updated_by VARCHAR2 (60)
                                          PATH 'LAST_UPDATED_BY'
                                   ,last_update_date VARCHAR2 (150)
                                          PATH 'LAST_UPDATE_DATE'
                                   ,last_update_login VARCHAR2 (150)
                                          PATH 'LAST_UPDATE_LOGIN'
                                   ,lead_id        NUMBER PATH 'LEAD_ID'
                                   ,sales_person_id NUMBER PATH 'SALES_PERSON_ID'
                                   ,title          VARCHAR2 (60) PATH 'TITLE'
                                   ,sur_name       VARCHAR2 (60) PATH 'SUR_NAME'
                                   ,first_name     VARCHAR2 (60) PATH 'FIRST_NAME'
                                   ,middle_name    VARCHAR2 (60) PATH 'MIDDLE_NAME'
                                   ,passport_no    VARCHAR2 (60) PATH 'PASSPPORT_NO');
   BEGIN
      OPEN c_customer;

      FETCH c_customer
      BULK COLLECT INTO l_customer_tbl;

      CLOSE c_customer;

      FOR i IN l_customer_tbl.FIRST .. l_customer_tbl.LAST
      LOOP
         IF l_customer_tbl (i).cust_id IS NOT NULL
         THEN
            MERGE INTO xxstg_customer a
                 USING (SELECT l_customer_tbl (i).cust_id cust_id
                              ,l_customer_tbl (i).customer_number
                                  customer_number
                              ,l_customer_tbl (i).customer_name customer_name
                              ,l_customer_tbl (i).orig_system_ref
                                  orig_system_ref
                              ,l_customer_tbl (i).active_yn active_yn
                              ,l_customer_tbl (i).created_by created_by
                              ,l_customer_tbl (i).creation_date creation_date
                              ,l_customer_tbl (i).last_updated_by
                                  last_updated_by
                              ,l_customer_tbl (i).last_update_date
                                  last_update_date
                              ,l_customer_tbl (i).last_update_login
                                  last_update_login
                              ,l_customer_tbl (i).lead_id lead_id
                              ,l_customer_tbl (i).sales_person_id
                                  sales_person_id
                              ,l_customer_tbl (i).title title
                              ,l_customer_tbl (i).sur_name sur_name
                              ,l_customer_tbl (i).middle_name middle_name
                              ,l_customer_tbl (i).first_name first_name
                              ,l_customer_tbl (i).passport_no passport_no
                          FROM DUAL) b
                    ON (    a.cust_id = b.cust_id
                        AND b.cust_id IS NOT NULL)
            WHEN MATCHED
            THEN
               UPDATE SET customer_number = b.customer_number
                         ,customer_name = b.customer_name
                         ,orig_system_ref = b.orig_system_ref
                         ,active_yn    = b.active_yn
                         ,created_by   = b.created_by
                         ,creation_date = b.creation_date
                         ,last_updated_by = b.last_updated_by
                         ,last_update_date = b.last_update_date
                         ,last_update_login = b.last_update_login
                         ,lead_id      = b.lead_id
                         ,sales_person_id = b.sales_person_id
                         ,title        = b.title
                         ,sur_name     = b.sur_name
                         ,middle_name  = b.middle_name
                         ,first_name   = b.first_name
                         ,passport_no  = b.passport_no
            WHEN NOT MATCHED
            THEN
               INSERT     (cust_id
                          ,customer_number
                          ,customer_name
                          ,orig_system_ref
                          ,active_yn
                          ,created_by
                          ,creation_date
                          ,last_updated_by
                          ,last_update_date
                          ,last_update_login
                          ,lead_id
                          ,sales_person_id
                          ,title
                          ,sur_name
                          ,middle_name
                          ,first_name
                          ,passport_no)
                   VALUES (b.cust_id
                          ,b.customer_number
                          ,b.customer_name
                          ,b.orig_system_ref
                          ,b.active_yn
                          ,b.created_by
                          ,b.creation_date
                          ,b.last_updated_by
                          ,b.last_update_date
                          ,b.last_update_login
                          ,b.lead_id
                          ,b.sales_person_id
                          ,b.title
                          ,b.sur_name
                          ,b.middle_name
                          ,b.first_name
                          ,b.passport_no --                          ,b.cust_acct_number
                                        --                          ,b.lead_number
                                        --                          ,b.customer_type
                           );
         END IF;
      END LOOP;

      COMMIT;
   END customers;

   PROCEDURE customer_site (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE cust_site_tbl_type IS TABLE OF xxstg_cust_sites%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_cust_site_tbl cust_site_tbl_type;

      CURSOR c_cust_site
      IS
                  SELECT cust_site_id
                        ,cust_id
                        ,site_number
                        ,site_name
                        ,address1
                        ,address2
                        ,address3
                        ,address4
                        ,city
                        ,postal_code
                        ,state
                        ,province
                        ,county
                        ,country
                        ,org_id
                        ,orig_system_ref
                        ,primary_yn
                        ,'Y' active_yn
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS cust_site_id   NUMBER PATH 'CUST_SITE_ID'
                                   ,cust_id        NUMBER PATH 'CUST_ID'
                                   ,site_number    VARCHAR2 (30) PATH 'SITE_NUMBER'
                                   ,site_name      VARCHAR2 (500) PATH 'SITE_NAME'
                                   ,address1       VARCHAR2 (240) PATH 'ADDRESS1'
                                   ,address2       VARCHAR2 (240) PATH 'ADDRESS2'
                                   ,address3       VARCHAR2 (240) PATH 'ADDRESS3'
                                   ,address4       VARCHAR2 (240) PATH 'ADDRESS4'
                                   ,city           VARCHAR2 (60) PATH 'CITY'
                                   ,postal_code    VARCHAR2 (60) PATH 'POSTAL_CODE'
                                   ,state          VARCHAR2 (60) PATH 'STATE'
                                   ,province       VARCHAR2 (60) PATH 'PROVINCE'
                                   ,county         VARCHAR2 (60) PATH 'COUNTY'
                                   ,country        VARCHAR2 (60) PATH 'COUNTRY'
                                   ,org_id         NUMBER PATH 'BU_ID'
                                   ,orig_system_ref NUMBER PATH 'ORIG_SYSTEM_REF'
                                   ,primary_yn     VARCHAR2 (1) PATH 'PRIMARY_YN'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_YN ');
   BEGIN
      OPEN c_cust_site;

      FETCH c_cust_site
      BULK COLLECT INTO l_cust_site_tbl;

      CLOSE c_cust_site;

      FOR i IN l_cust_site_tbl.FIRST .. l_cust_site_tbl.LAST
      LOOP
         MERGE INTO xxstg_cust_sites a
              USING (SELECT l_cust_site_tbl (i).cust_site_id cust_site_id
                           ,l_cust_site_tbl (i).cust_id cust_id
                           ,l_cust_site_tbl (i).site_number site_number
                           ,l_cust_site_tbl (i).address1 address1
                           ,l_cust_site_tbl (i).address2 address2
                           ,l_cust_site_tbl (i).address3 address3
                           ,l_cust_site_tbl (i).address4 address4
                           ,l_cust_site_tbl (i).city city
                           ,l_cust_site_tbl (i).postal_code postal_code
                           ,l_cust_site_tbl (i).state state
                           ,l_cust_site_tbl (i).province province
                           ,l_cust_site_tbl (i).county county
                           ,l_cust_site_tbl (i).country country
                           ,l_cust_site_tbl (i).org_id org_id
                           ,l_cust_site_tbl (i).orig_system_ref
                               orig_system_ref
                           ,l_cust_site_tbl (i).active_yn active_yn
                       --                            ,l_cust_site_tbl (i).primary_yn         primary_yn
                       FROM DUAL) b
                 ON (    a.cust_site_id = b.cust_site_id
                     AND a.org_id = b.org_id
                     AND b.cust_site_id IS NOT NULL)
         WHEN MATCHED
         THEN
            UPDATE SET cust_id      = b.cust_id
                      ,site_number  = b.site_number
                      ,address1     = b.address1
                      ,address2     = b.address2
                      ,address3     = b.address3
                      ,address4     = b.address4
                      ,city         = b.city
                      ,postal_code  = b.postal_code
                      ,state        = b.state
                      ,province     = b.province
                      ,county       = b.county
                      ,country      = b.country
                      --,org_id = b.org_id
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
         --                        ,primary_yn            = b.primary_yn
         WHEN NOT MATCHED
         THEN
            INSERT     (cust_site_id
                       ,cust_id
                       ,site_number
                       ,address1
                       ,address2
                       ,address3
                       ,address4
                       ,city
                       ,postal_code
                       ,state
                       ,province
                       ,county
                       ,country
                       ,org_id
                       ,orig_system_ref
                       ,active_yn      --                          ,primary_yn
                                 )
                VALUES (b.cust_site_id
                       ,b.cust_id
                       ,b.site_number
                       ,b.address1
                       ,b.address2
                       ,b.address3
                       ,b.address4
                       ,b.city
                       ,b.postal_code
                       ,b.state
                       ,b.province
                       ,b.county
                       ,b.country
                       ,b.org_id
                       ,b.orig_system_ref
                       ,b.active_yn  --                          ,b.primary_yn
                                   );
      END LOOP;

      COMMIT;
   END customer_site;

   PROCEDURE locations (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE locations_tbl_type IS TABLE OF xxstg_locations%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_locations_tbl locations_tbl_type;

      CURSOR c_locations
      IS
                  SELECT loc_id
                        ,location_name
                        ,NULL location_name_tl
                        ,country
                        ,NULL country_tl
                        ,address1
                        ,NULL address1_tl
                        ,address2
                        ,NULL address2_tl
                        ,address3
                        ,NULL address3_tl
                        ,address4
                        ,NULL address4_tl
                        ,city
                        ,NULL city_tl
                        ,postal_code
                        ,NULL postal_code_tl
                        ,state
                        ,NULL state_tl
                        ,province
                        ,NULL province_tl
                        ,county
                        ,NULL county_tl
                        ,orig_system_ref
                        ,'Y' active_yn
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                        ,org_id
                        ,NULL license_no
                        ,po_box
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS loc_id         NUMBER PATH 'LOCATION_ID'
                                   ,location_name  VARCHAR2 (240) PATH 'LOCATION_NAME'
                                   ,country        VARCHAR2 (60)
                                          PATH 'COUNTRY          '
                                   ,address1       VARCHAR2 (240)
                                          PATH 'ADDRESS_LINE_1         '
                                   ,address2       VARCHAR2 (240)
                                          PATH 'ADDRESS_LINE_2         '
                                   ,address3       VARCHAR2 (240)
                                          PATH 'ADDRESS_LINE_3         '
                                   ,address4       VARCHAR2 (240)
                                          PATH 'ADDRESS_LINE_4         '
                                   ,city           VARCHAR2 (60)
                                          PATH 'TOWN_OR_CITY             '
                                   ,postal_code    VARCHAR2 (60)
                                          PATH 'POSTAL_CODE      '
                                   ,state          VARCHAR2 (60)
                                          PATH 'STATE            '
                                   ,province       VARCHAR2 (60)
                                          PATH 'PROVINCE         '
                                   ,county         VARCHAR2 (60)
                                          PATH 'COUNTY           '
                                   ,orig_system_ref NUMBER PATH 'LOCATION_ID'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_STATUS'
                                   ,org_id         NUMBER PATH 'ORG_ID'
                                   ,po_box         VARCHAR2 (60) PATH 'PO_BOX');
   BEGIN
      OPEN c_locations;

      FETCH c_locations
      BULK COLLECT INTO l_locations_tbl;

      CLOSE c_locations;

      FOR i IN l_locations_tbl.FIRST .. l_locations_tbl.LAST
      LOOP
         MERGE INTO xxstg_locations a
              USING (SELECT l_locations_tbl (i).loc_id loc_id
                           ,l_locations_tbl (i).location_name location_name
                           ,l_locations_tbl (i).country country
                           ,l_locations_tbl (i).address1 address1
                           ,l_locations_tbl (i).address2 address2
                           ,l_locations_tbl (i).address3 address3
                           ,l_locations_tbl (i).address4 address4
                           ,l_locations_tbl (i).city city
                           ,l_locations_tbl (i).postal_code postal_code
                           ,l_locations_tbl (i).state state
                           ,l_locations_tbl (i).province province
                           ,l_locations_tbl (i).county county
                           ,l_locations_tbl (i).orig_system_ref
                               orig_system_ref
                           ,l_locations_tbl (i).active_yn active_yn
                           ,l_locations_tbl (i).org_id org_id
                           ,l_locations_tbl (i).po_box po_box
                       FROM DUAL) b
                 ON (a.loc_id = b.loc_id)
         WHEN MATCHED
         THEN
            UPDATE SET location_name = b.location_name
                      ,country      = b.country
                      ,address1     = b.address1
                      ,address2     = b.address2
                      ,address3     = b.address3
                      ,address4     = b.address4
                      ,city         = b.city
                      ,postal_code  = b.postal_code
                      ,state        = b.state
                      ,province     = b.province
                      ,county       = b.county
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      ,org_id       = b.org_id
                      ,po_box       = b.po_box
         WHEN NOT MATCHED
         THEN
            INSERT     (loc_id
                       ,location_name
                       ,country
                       ,address1
                       ,address2
                       ,address3
                       ,address4
                       ,city
                       ,postal_code
                       ,state
                       ,province
                       ,county
                       ,orig_system_ref
                       ,active_yn
                       ,org_id
                       ,po_box)
                VALUES (b.loc_id
                       ,b.location_name
                       ,b.country
                       ,b.address1
                       ,b.address2
                       ,b.address3
                       ,b.address4
                       ,b.city
                       ,b.postal_code
                       ,b.state
                       ,b.province
                       ,b.county
                       ,b.orig_system_ref
                       ,b.active_yn
                       ,b.org_id
                       ,b.po_box);
      END LOOP;

      COMMIT;
   END locations;

   PROCEDURE organizations (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE org_tbl_type IS TABLE OF xxstg_organizations%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_org_tbl      org_tbl_type;

      CURSOR c_org
      IS
                 SELECT org_id
                       ,org_name
                       ,NULL org_name_tl
                       ,short_code
                       ,legal_entity_id
                       ,ledger_id
                       ,ledger_name
                       ,ledger_gl_code
                       ,org_gl_code
                       ,orig_system_ref
                       ,DECODE (active_yn, 'A', 'Y') active_yn
                       ,'anonymous' created_by
                       ,SYSDATE creation_date
                       ,'anonymous' last_updated_by
                       ,SYSDATE last_update_date
                       ,'anonymous' last_update_login
                   FROM XMLTABLE (
                           '/DATA_DS/G_1'
                           PASSING acct_doc
                           COLUMNS org_id        VARCHAR2 (240) PATH 'ORGANIZATION_ID'
                                  ,org_name      VARCHAR2 (240) PATH 'NAME'
                                  ,org_name_tl   VARCHAR2 (240) PATH 'org_name_tl'
                                  ,short_code    VARCHAR2 (150) PATH 'SHORT_CODE'
                                  ,legal_entity_id VARCHAR2 (240)
                                         PATH 'LEGAL_ENTITY_ID'
                                  ,ledger_id     VARCHAR2 (240) PATH 'LEDGER_ID'
                                  ,ledger_name   VARCHAR2 (50) PATH 'LEDGER_NAME'
                                  ,ledger_gl_code VARCHAR2 (20) PATH 'LEDGER_GL_CODE'
                                  ,org_gl_code   VARCHAR2 (20) PATH 'ORG_GL_CODE'
                                  ,orig_system_ref VARCHAR2 (240)
                                         PATH 'ORGANIZATION_ID'
                                  ,active_yn     VARCHAR2 (1) PATH 'STATUS');
   BEGIN
      OPEN c_org;

      FETCH c_org
      BULK COLLECT INTO l_org_tbl;

      CLOSE c_org;

      FOR i IN l_org_tbl.FIRST .. l_org_tbl.LAST
      LOOP
         MERGE INTO xxstg_organizations a
              USING (SELECT l_org_tbl (i).org_id org_id
                           ,l_org_tbl (i).org_name org_name
                           ,l_org_tbl (i).short_code short_code
                           ,l_org_tbl (i).orig_system_ref orig_system_ref
                           ,l_org_tbl (i).active_yn active_yn
                           ,l_org_tbl (i).created_by created_by
                           ,l_org_tbl (i).creation_date creation_date
                           ,l_org_tbl (i).last_updated_by last_updated_by
                           ,l_org_tbl (i).last_update_date last_update_date
                           ,l_org_tbl (i).last_update_login last_update_login
                       FROM DUAL) b
                 ON (a.org_id = b.org_id)
         WHEN MATCHED
         THEN
            UPDATE SET org_name     = b.org_name
                      ,short_code   = b.short_code
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
         WHEN NOT MATCHED
         THEN
            INSERT     (org_id
                       ,org_name
                       ,short_code
                       ,orig_system_ref
                       ,active_yn
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login)
                VALUES (b.org_id
                       ,b.org_name
                       ,b.short_code
                       ,b.orig_system_ref
                       ,b.active_yn
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login);
      END LOOP;

      COMMIT;
   END organizations;

   PROCEDURE payment_terms (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE payterm_tbl_type IS TABLE OF xxstg_pay_terms%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_payterm_tbl  payterm_tbl_type;

      CURSOR c_payterm
      IS
                  SELECT term_id
                        ,term_name
                        ,term_days
                        ,orig_system_ref
                        ,'Y' active_yn
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS term_id        NUMBER PATH 'TERM_ID'
                                   ,term_name      VARCHAR2 (30) PATH 'TERM_NAME'
                                   ,term_days      NUMBER PATH 'TERM_DAYS'
                                   ,orig_system_ref NUMBER PATH 'TERM_ID'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_YN');
   BEGIN
      OPEN c_payterm;

      FETCH c_payterm
      BULK COLLECT INTO l_payterm_tbl;

      CLOSE c_payterm;

      FOR i IN l_payterm_tbl.FIRST .. l_payterm_tbl.LAST
      LOOP
         MERGE INTO xxstg_pay_terms a
              USING (SELECT l_payterm_tbl (i).term_id term_id
                           ,l_payterm_tbl (i).term_name term_name
                           ,l_payterm_tbl (i).term_days term_days
                           ,l_payterm_tbl (i).orig_system_ref orig_system_ref
                           ,l_payterm_tbl (i).active_yn active_yn
                           ,l_payterm_tbl (i).created_by created_by
                           ,l_payterm_tbl (i).creation_date creation_date
                           ,l_payterm_tbl (i).last_updated_by last_updated_by
                           ,l_payterm_tbl (i).last_update_date
                               last_update_date
                           ,l_payterm_tbl (i).last_update_login
                               last_update_login
                       FROM DUAL) b
                 ON (a.term_id = b.term_id)
         WHEN MATCHED
         THEN
            UPDATE SET term_name    = b.term_name
                      ,term_days    = b.term_days
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
         WHEN NOT MATCHED
         THEN
            INSERT     (term_id
                       ,term_name
                       ,term_days
                       ,orig_system_ref
                       ,active_yn
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login)
                VALUES (b.term_id
                       ,b.term_name
                       ,b.term_days
                       ,b.orig_system_ref
                       ,b.active_yn
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login);
      END LOOP;

      COMMIT;
   END payment_terms;

   PROCEDURE customer_contact (p_xml_data CLOB)
   AS
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
                                     ,passport_number  VARCHAR2 (60)
                                            PATH 'PASSPORT_NUMBER'
                                     ,passport_exp_date DATE PATH 'PASSPORT_EXP_DATE'
                                     ,national_id_number VARCHAR2 (60)
                                            PATH 'NATIONAL_ID_NUMBER'
                                     ,national_id_exp_date DATE
                                            PATH 'NATIONAL_ID_EXP_DATE'
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
                           ,l_cust_cont_tbl (i).passport_number
                               passport_number
                           ,l_cust_cont_tbl (i).passport_exp_date
                               passport_exp_date
                           ,l_cust_cont_tbl (i).national_id_number
                               national_id_number
                           ,l_cust_cont_tbl (i).national_id_exp_date
                               national_id_exp_date
                           ,l_cust_cont_tbl (i).orig_system_ref
                               orig_system_ref
                           ,l_cust_cont_tbl (i).active_yn active_yn
                           ,l_cust_cont_tbl (i).fax_number fax_number
                           ,l_cust_cont_tbl (i).created_by created_by
                           ,l_cust_cont_tbl (i).creation_date creation_date
                           ,l_cust_cont_tbl (i).last_updated_by
                               last_updated_by
                           ,l_cust_cont_tbl (i).last_update_date
                               last_update_date
                           ,l_cust_cont_tbl (i).last_update_login
                               last_update_login
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

      COMMIT;
   END customer_contact;

   PROCEDURE employee (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE emp_tbl_type IS TABLE OF xxstg_employee%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_emp_tbl      emp_tbl_type;

      CURSOR c_broker
      IS
                  SELECT emp_id
                        ,employee_name
                        ,NULL employee_name_tl
                        ,employee_number
                        ,email_id
                        ,contact_number
                        ,nationality
                        ,orig_system_ref
                        ,'Y' active_yn
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                        ,0 position_id
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS emp_id         NUMBER PATH 'PERSON_ID'
                                   ,employee_name  VARCHAR2 (240) PATH 'EMPLOYEE_NAME'
                                   ,employee_number VARCHAR2 (30)
                                          PATH 'EMPLOYEE_NUMBER'
                                   ,email_id       VARCHAR2 (60) PATH 'EMAIL_ADDRESS'
                                   ,contact_number VARCHAR2 (60) PATH 'CONTACT_NUMBER'
                                   ,nationality    VARCHAR2 (60) PATH 'NATIONALITY'
                                   ,orig_system_ref NUMBER PATH 'PERSON_ID');
   BEGIN
      OPEN c_broker;

      FETCH c_broker
      BULK COLLECT INTO l_emp_tbl;

      CLOSE c_broker;

      FOR i IN l_emp_tbl.FIRST .. l_emp_tbl.LAST
      LOOP
         MERGE INTO xxstg_employee a
              USING (SELECT l_emp_tbl (i).emp_id emp_id
                           ,l_emp_tbl (i).employee_name employee_name
                           ,l_emp_tbl (i).employee_number employee_number
                           ,l_emp_tbl (i).email_id email_id
                           ,l_emp_tbl (i).contact_number contact_number
                           ,l_emp_tbl (i).nationality nationality
                           ,l_emp_tbl (i).orig_system_ref orig_system_ref
                           ,l_emp_tbl (i).active_yn active_yn
                           ,l_emp_tbl (i).created_by created_by
                           ,l_emp_tbl (i).creation_date creation_date
                           ,l_emp_tbl (i).last_updated_by last_updated_by
                           ,l_emp_tbl (i).last_update_date last_update_date
                           ,l_emp_tbl (i).last_update_login last_update_login
                           ,l_emp_tbl (i).position_id position_id
                       FROM DUAL) b
                 ON (a.emp_id = b.emp_id)
         WHEN MATCHED
         THEN
            UPDATE SET employee_name = b.employee_name
                      ,employee_number = b.employee_number
                      ,email_id     = b.email_id
                      ,contact_number = b.contact_number
                      ,nationality  = b.nationality
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
                      ,position_id  = b.position_id
         WHEN NOT MATCHED
         THEN
            INSERT     (emp_id
                       ,employee_name
                       ,employee_number
                       ,email_id
                       ,contact_number
                       ,nationality
                       ,orig_system_ref
                       ,active_yn
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login
                       ,position_id)
                VALUES (b.emp_id
                       ,b.employee_name
                       ,b.employee_number
                       ,b.email_id
                       ,b.contact_number
                       ,b.nationality
                       ,b.orig_system_ref
                       ,b.active_yn
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login
                       ,b.position_id);
      END LOOP;

      COMMIT;
   END employee;

   PROCEDURE vendor (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE vendor_tbl_type IS TABLE OF xxstg_vendor%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_vendor_tbl   vendor_tbl_type;

      CURSOR c_vendor
      IS
                  SELECT vend_id
                        ,vendor_number
                        ,vendor_name
                        ,NULL vendor_name_tl
                        ,orig_system_ref
                        ,profession
                        ,'Y' active_yn
                        ,created_by
                        ,TO_DATE (
                            TO_CHAR (
                               TO_TIMESTAMP_TZ (creation_date
                                               ,'YYYY-MM-DD"T"HH24:MI:SS.ff3TZH:TZM')
                              ,'YYYY-MM-DD')
                           ,'YYYY-MM-DD')
                            creation_date
                        ,last_updated_by
                        ,TO_DATE (
                            TO_CHAR (
                               TO_TIMESTAMP_TZ (last_update_date
                                               ,'YYYY-MM-DD"T"HH24:MI:SS.ff3TZH:TZM')
                              ,'YYYY-MM-DD')
                           ,'YYYY-MM-DD')
                            last_update_date
                        ,last_update_login
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS vend_id        NUMBER PATH 'VENDOR_ID'
                                   ,vendor_number  VARCHAR2 (30) PATH 'VENDOR_NUMBER'
                                   ,vendor_name    VARCHAR2 (240) PATH 'VENDOR_NAME'
                                   ,orig_system_ref NUMBER PATH 'SUPPLIER_ID'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_YN'
                                   ,created_by     VARCHAR2 (60) PATH 'CREATED_BY'
                                   ,creation_date  VARCHAR2 (150) PATH 'CREATION_DATE'
                                   ,last_updated_by VARCHAR2 (60)
                                          PATH 'LAST_UPDATED_BY'
                                   ,last_update_date VARCHAR2 (150)
                                          PATH 'LAST_UPDATE_DATE'
                                   ,last_update_login VARCHAR2 (150)
                                          PATH 'LAST_UPDATE_LOGIN'
                                   ,profession     VARCHAR2 (240) PATH 'PROFESSION');
   BEGIN
      OPEN c_vendor;

      FETCH c_vendor
      BULK COLLECT INTO l_vendor_tbl;

      CLOSE c_vendor;

      FOR i IN l_vendor_tbl.FIRST .. l_vendor_tbl.LAST
      LOOP
         MERGE INTO xxstg_vendor a
              USING (SELECT l_vendor_tbl (i).vend_id vend_id
                           ,l_vendor_tbl (i).vendor_number vendor_number
                           ,l_vendor_tbl (i).vendor_name vendor_name
                           ,l_vendor_tbl (i).orig_system_ref orig_system_ref
                           ,l_vendor_tbl (i).active_yn active_yn
                           ,l_vendor_tbl (i).created_by created_by
                           ,l_vendor_tbl (i).creation_date creation_date
                           ,l_vendor_tbl (i).last_updated_by last_updated_by
                           ,l_vendor_tbl (i).last_update_date
                               last_update_date
                           ,l_vendor_tbl (i).last_update_login
                               last_update_login
                           ,l_vendor_tbl (i).profession profession
                       FROM DUAL) b
                 ON (a.vend_id = b.vend_id)
         WHEN MATCHED
         THEN
            UPDATE SET vendor_number = b.vendor_number
                      ,vendor_name  = b.vendor_name
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
         WHEN NOT MATCHED
         THEN
            INSERT     (vend_id
                       ,vendor_number
                       ,vendor_name
                       ,orig_system_ref
                       ,active_yn
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login)
                VALUES (b.vend_id
                       ,b.vendor_number
                       ,b.vendor_name
                       ,b.orig_system_ref
                       ,b.active_yn
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login);
      END LOOP;

      COMMIT;
   END vendor;

   PROCEDURE vendor_contact (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE vendor_cont_tbl_type IS TABLE OF xxstg_vend_contacts%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_vendor_cont_tbl vendor_cont_tbl_type;

      CURSOR c_vendor_cont
      IS
                  SELECT vend_contact_id
                        ,vend_id
                        ,vend_site_id
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
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                    --                        ,primary_yn
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS vend_contact_id NUMBER PATH 'VEND_CONTACT_ID'
                                   ,vend_id        NUMBER PATH 'VEND_ID'
                                   ,vend_site_id   NUMBER PATH 'VEND_SITE_ID'
                                   ,contact_name   VARCHAR2 (240) PATH 'CONTACT_NAME'
                                   ,designation    VARCHAR2 (60) PATH 'DESIGNATION'
                                   ,mobile_number  VARCHAR2 (60) PATH 'MOBILE_NUMBER'
                                   ,phone_number   VARCHAR2 (60) PATH 'PHONE_NUMBER'
                                   ,email_id       VARCHAR2 (60) PATH 'EMAIL_ADDRESS'
                                   ,passport_number VARCHAR2 (60)
                                          PATH 'PASSPORT_NUMBER'
                                   ,passport_exp_date VARCHAR2 (60)
                                          PATH 'PASSPORT_EXP_DATE'
                                   ,national_id_number VARCHAR2 (60)
                                          PATH 'NATIONAL_ID_NUMBER'
                                   ,national_id_exp_date VARCHAR2 (60)
                                          PATH 'NATIONAL_ID_EXP_DATE'
                                   ,orig_system_ref NUMBER PATH 'VENDOR_CONTACT_ID'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_YN' --                                  ,primary_yn            VARCHAR2(1)    PATH 'PRIMARY_YN'
                                   ,fax_number     VARCHAR2 (240 BYTE)
                                          PATH 'FAX_NUMBER');
   BEGIN
      OPEN c_vendor_cont;

      FETCH c_vendor_cont
      BULK COLLECT INTO l_vendor_cont_tbl;

      CLOSE c_vendor_cont;

      FOR i IN l_vendor_cont_tbl.FIRST .. l_vendor_cont_tbl.LAST
      LOOP
         MERGE INTO xxstg_vend_contacts a
              USING (SELECT l_vendor_cont_tbl (i).vend_contact_id
                               vend_contact_id
                           ,l_vendor_cont_tbl (i).vend_id vend_id
                           ,l_vendor_cont_tbl (i).vend_site_id vend_site_id
                           ,l_vendor_cont_tbl (i).contact_name contact_name
                           ,l_vendor_cont_tbl (i).designation designation
                           ,l_vendor_cont_tbl (i).mobile_number mobile_number
                           ,l_vendor_cont_tbl (i).phone_number phone_number
                           ,l_vendor_cont_tbl (i).email_id email_id
                           ,l_vendor_cont_tbl (i).passport_number
                               passport_number
                           ,l_vendor_cont_tbl (i).passport_exp_date
                               passport_exp_date
                           ,l_vendor_cont_tbl (i).national_id_number
                               national_id_number
                           ,l_vendor_cont_tbl (i).national_id_exp_date
                               national_id_exp_date
                           ,l_vendor_cont_tbl (i).orig_system_ref
                               orig_system_ref
                           ,l_vendor_cont_tbl (i).active_yn active_yn
                           --                            ,l_vendor_cont_tbl (i).primary_yn           primary_yn
                           ,l_vendor_cont_tbl (i).fax_number fax_number
                       FROM DUAL) b
                 ON (    a.vend_contact_id = b.vend_contact_id
                     AND a.vend_id = b.vend_id
                     AND a.vend_site_id = b.vend_site_id)
         WHEN MATCHED
         THEN
            UPDATE SET contact_name = b.contact_name
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
                      --                      ,primary_yn            = b.primary_yn
                      ,fax_number   = b.fax_number
         WHEN NOT MATCHED
         THEN
            INSERT     (vend_contact_id
                       ,vend_id
                       ,vend_site_id
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
                       --                        ,primary_yn
                       ,fax_number)
                VALUES (b.vend_contact_id
                       ,b.vend_id
                       ,b.vend_site_id
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
                       --                        ,b.primary_yn
                       ,b.fax_number);
      END LOOP;

      COMMIT;
   END vendor_contact;

   PROCEDURE vendor_site (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE vendor_site_tbl_type IS TABLE OF xxstg_vend_sites%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_vendor_site_tbl vendor_site_tbl_type;

      CURSOR c_vendor_site
      IS
                  SELECT vend_site_id
                        ,vend_id
                        ,site_number
                        ,address1
                        ,address2
                        ,address3
                        ,address4
                        ,city
                        ,postal_code
                        ,state
                        ,province
                        ,county
                        ,country
                        ,org_id
                        ,orig_system_ref
                        ,'Y' active_yn
                        ,'anonymous' created_by
                        ,SYSDATE creation_date
                        ,'anonymous' last_updated_by
                        ,SYSDATE last_update_date
                        ,'anonymous' last_update_login
                    --                        ,primary_yn
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS vend_site_id   NUMBER PATH 'VEND_SITE_ID'
                                   ,vend_id        NUMBER PATH 'VEND_ID'
                                   ,site_number    VARCHAR2 (30) PATH 'SITE_NUMBER'
                                   ,address1       VARCHAR2 (240) PATH 'ADDRESS1'
                                   ,address2       VARCHAR2 (240) PATH 'ADDRESS2'
                                   ,address3       VARCHAR2 (240) PATH 'ADDRESS3'
                                   ,address4       VARCHAR2 (240) PATH 'ADDRESS4'
                                   ,city           VARCHAR2 (60) PATH 'CITY'
                                   ,postal_code    VARCHAR2 (60) PATH 'POSTAL_CODE'
                                   ,state          VARCHAR2 (60) PATH 'STATE'
                                   ,province       VARCHAR2 (60) PATH 'PROVINCE'
                                   ,county         VARCHAR2 (60) PATH 'COUNTY'
                                   ,country        VARCHAR2 (60) PATH 'COUNTRY'
                                   ,org_id         NUMBER PATH 'ORG_ID'
                                   ,orig_system_ref NUMBER PATH 'SUPPLIER_SITE_ID'
                                   ,active_yn      VARCHAR2 (1) PATH 'ACTIVE_YN' --                                  ,primary_yn         VARCHAR2(1)     PATH 'PRIMARY_YN'
                                                                                );
   BEGIN
      OPEN c_vendor_site;

      FETCH c_vendor_site
      BULK COLLECT INTO l_vendor_site_tbl;

      CLOSE c_vendor_site;

      FOR i IN l_vendor_site_tbl.FIRST .. l_vendor_site_tbl.LAST
      LOOP
         MERGE INTO xxstg_vend_sites a
              USING (SELECT l_vendor_site_tbl (i).vend_site_id vend_site_id
                           ,l_vendor_site_tbl (i).vend_id vend_id
                           ,l_vendor_site_tbl (i).site_number site_number
                           ,l_vendor_site_tbl (i).address1 address1
                           ,l_vendor_site_tbl (i).address2 address2
                           ,l_vendor_site_tbl (i).address3 address3
                           ,l_vendor_site_tbl (i).address4 address4
                           ,l_vendor_site_tbl (i).city city
                           ,l_vendor_site_tbl (i).postal_code postal_code
                           ,l_vendor_site_tbl (i).state state
                           ,l_vendor_site_tbl (i).province province
                           ,l_vendor_site_tbl (i).county county
                           ,l_vendor_site_tbl (i).country country
                           ,l_vendor_site_tbl (i).org_id org_id
                           ,l_vendor_site_tbl (i).orig_system_ref
                               orig_system_ref
                           ,l_vendor_site_tbl (i).active_yn active_yn
                           ,l_vendor_site_tbl (i).created_by created_by
                           ,l_vendor_site_tbl (i).creation_date creation_date
                           ,l_vendor_site_tbl (i).last_updated_by
                               last_updated_by
                           ,l_vendor_site_tbl (i).last_update_date
                               last_update_date
                           ,l_vendor_site_tbl (i).last_update_login
                               last_update_login
                       --                            ,l_vendor_site_tbl (i).primary_yn          primary_yn
                       FROM DUAL) b
                 ON (a.vend_site_id = b.vend_site_id)
         WHEN MATCHED
         THEN
            UPDATE SET vend_id      = b.vend_id
                      ,site_number  = b.site_number
                      ,address1     = b.address1
                      ,address2     = b.address2
                      ,address3     = b.address3
                      ,address4     = b.address4
                      ,city         = b.city
                      ,postal_code  = b.postal_code
                      ,state        = b.state
                      ,province     = b.province
                      ,county       = b.county
                      ,country      = b.country
                      ,org_id       = b.org_id
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
                      --                       ,primary_yn          = b.primary_yn
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
         WHEN NOT MATCHED
         THEN
            INSERT     (vend_site_id
                       ,vend_id
                       ,site_number
                       ,address1
                       ,address2
                       ,address3
                       ,address4
                       ,city
                       ,postal_code
                       ,state
                       ,province
                       ,county
                       ,country
                       ,org_id
                       ,orig_system_ref
                       ,active_yn
                       --                        ,primary_yn
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login)
                VALUES (b.vend_site_id
                       ,b.vend_id
                       ,b.site_number
                       ,b.address1
                       ,b.address2
                       ,b.address3
                       ,b.address4
                       ,b.city
                       ,b.postal_code
                       ,b.state
                       ,b.province
                       ,b.county
                       ,b.country
                       ,b.org_id
                       ,b.orig_system_ref
                       ,b.active_yn
                       --                        ,b.primary_yn
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login);
      END LOOP;

      COMMIT;
   END vendor_site;

   PROCEDURE projects (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE project_tbl_type IS TABLE OF xxstg_projects%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_project_tbl  project_tbl_type;

      CURSOR c_project
      IS
                  SELECT proj_id
                        ,project_name
                        ,project_number
                        ,                                       --description,
                                                            --project_unit_id,
                                                            --legal_entity_id,
                                                            --project_type_id,
                                               --carrying_out_organization_id,
                                                        --project_status_code,
                         org_id
                        ,start_date
                        ,completion_date
                        ,closed_date
                        ,NULL cost_center_code
                        ,orig_system_ref
                        ,'Y' active_yn
                        ,NULL created_by
                        ,NULL creation_date
                        ,NULL last_updated_by
                        ,NULL last_update_date
                        ,NULL last_update_login
                        ,NULL inv_prefix
                        ,NULL seq_no
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS proj_id        NUMBER PATH 'PROJECT_ID'
                                   ,project_name   VARCHAR2 (250) PATH 'PROJECT_NAME'
                                   ,project_number VARCHAR2 (25) PATH 'PROJECT_NUMBER'
                                   ,org_id         NUMBER PATH 'ORG_ID'
                                   ,start_date     DATE PATH 'START_DATE'
                                   ,completion_date DATE PATH 'COMPLETION_DATE'
                                   ,closed_date    DATE PATH 'CLOSED_DATE' --, cost_center_code varchar2 (60) PATH 'COST_CENTER_CODE'
                                   ,orig_system_ref NUMBER PATH 'PROJECT_ID');
   BEGIN
      OPEN c_project;

      FETCH c_project
      BULK COLLECT INTO l_project_tbl;

      CLOSE c_project;

      FOR i IN l_project_tbl.FIRST .. l_project_tbl.LAST
      LOOP
         MERGE INTO xxstg_projects a
              USING (SELECT l_project_tbl (i).proj_id proj_id
                           ,l_project_tbl (i).project_name project_name
                           ,l_project_tbl (i).project_number project_number
                           ,l_project_tbl (i).org_id org_id
                           ,l_project_tbl (i).start_date start_date
                           ,l_project_tbl (i).completion_date completion_date
                           ,l_project_tbl (i).closed_date closed_date
                           ,l_project_tbl (i).cost_center_code
                               cost_center_code
                           ,l_project_tbl (i).orig_system_ref orig_system_ref
                           ,l_project_tbl (i).active_yn active_yn
                       FROM DUAL) b
                 ON (a.proj_id = b.proj_id)
         WHEN MATCHED
         THEN
            UPDATE SET project_name = b.project_name
                      ,project_number = b.project_number
                      ,org_id       = b.org_id
                      ,start_date   = b.start_date
                      ,completion_date = b.completion_date
                      ,closed_date  = b.closed_date
                      ,cost_center_code = b.cost_center_code
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
         WHEN NOT MATCHED
         THEN
            INSERT     (proj_id
                       ,project_name
                       ,project_number
                       ,org_id
                       ,start_date
                       ,completion_date
                       ,closed_date
                       ,cost_center_code
                       ,orig_system_ref
                       ,active_yn)
                VALUES (b.proj_id
                       ,b.project_name
                       ,b.project_number
                       ,b.org_id
                       ,b.start_date
                       ,b.completion_date
                       ,b.closed_date
                       ,b.cost_center_code
                       ,b.orig_system_ref
                       ,b.active_yn);
      END LOOP;

      COMMIT;
   END projects;

   PROCEDURE project_milestone (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE project_milestone_tbl_type
         IS TABLE OF xxstg_project_milestones%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_project_milestone_tbl project_milestone_tbl_type;

      CURSOR c_project_milestone
      IS
                  SELECT proj_ms_id
                        ,proj_id
                        ,ms_name
                        ,start_date
                        ,completion_date
                        ,orig_system_ref
                        ,NULL created_by
                        ,NULL creation_date
                        ,NULL last_updated_by
                        ,NULL last_update_date
                        ,NULL last_update_login
                    FROM XMLTABLE (
                            '/DATA_DS/G_1'
                            PASSING acct_doc
                            COLUMNS proj_ms_id     NUMBER PATH 'TASK_ID'
                                   ,proj_id        NUMBER PATH 'PROJECT_ID'
                                   ,ms_name        VARCHAR2 (240) PATH 'TASK_NAME'
                                   ,start_date     DATE PATH 'START_DATE'
                                   ,completion_date DATE PATH 'COMPLETION_DATE'
                                   ,orig_system_ref NUMBER PATH 'TASK_ID');
   BEGIN
      OPEN c_project_milestone;

      FETCH c_project_milestone
      BULK COLLECT INTO l_project_milestone_tbl;

      CLOSE c_project_milestone;

      FOR i IN l_project_milestone_tbl.FIRST .. l_project_milestone_tbl.LAST
      LOOP
         MERGE INTO xxstg_project_milestones a
              USING (SELECT l_project_milestone_tbl (i).proj_ms_id proj_ms_id
                           ,l_project_milestone_tbl (i).proj_id proj_id
                           ,l_project_milestone_tbl (i).ms_name ms_name
                           ,l_project_milestone_tbl (i).start_date start_date
                           ,l_project_milestone_tbl (i).completion_date
                               completion_date
                           ,l_project_milestone_tbl (i).orig_system_ref
                               orig_system_ref
                       FROM DUAL) b
                 ON (a.proj_ms_id = b.proj_ms_id)
         WHEN MATCHED
         THEN
            UPDATE SET proj_id      = b.proj_id
                      ,ms_name      = b.ms_name
                      ,start_date   = b.start_date
                      ,completion_date = b.completion_date
                      ,orig_system_ref = b.orig_system_ref
         WHEN NOT MATCHED
         THEN
            INSERT     (proj_ms_id
                       ,proj_id
                       ,ms_name
                       ,start_date
                       ,completion_date
                       ,orig_system_ref)
                VALUES (b.proj_ms_id
                       ,b.proj_id
                       ,b.ms_name
                       ,b.start_date
                       ,b.completion_date
                       ,b.orig_system_ref);
      END LOOP;

      COMMIT;
   END project_milestone;

   PROCEDURE invoice_status (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE invoice_tbl_type IS TABLE OF xxpm_invoice_header%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_invoice_tbl  invoice_tbl_type;

      CURSOR c_invoice
      IS
                      SELECT NULL invoice_id
                            ,invoice_number
                            ,NULL invoice_date
                            ,NULL func_id
                            ,NULL invoice_class
                            ,NULL org_id
                            ,NULL trx_source
                            ,NULL trx_type
                            ,NULL currency_code
                            ,NULL exchange_rate
                            ,NULL cust_id
                            ,NULL cust_site_id
                            ,NULL due_date
                            ,NULL status
                            ,interface_status
                            ,NULL offer_id
                            ,NULL offer_number
                            ,NULL booking_id
                            ,NULL booking_number
                            ,NULL sale_lease_number
                            ,customer_trx_id
                            ,NULL customer_trx_number
                            ,NULL invoicing_rule
                            ,NULL acnt_rule
                            ,NULL rule_start_date
                            ,NULL rule_end_date
                            ,NULL attribute_category
                            ,NULL attribute1
                            ,NULL attribute2
                            ,NULL attribute3
                            ,NULL attribute4
                            ,NULL attribute5
                            ,NULL attribute6
                            ,NULL attribute7
                            ,NULL attribute8
                            ,NULL attribute9
                            ,NULL attribute10
                            ,NULL created_by
                            ,NULL created_date
                            ,NULL last_updated_by
                            ,NULL last_update_date
                            ,NULL last_update_login
                            ,interface_error_msg
                            ,NULL payment_terms
                        FROM XMLTABLE (
                                '/DATA_DS/G_1'
                                PASSING acct_doc
                                COLUMNS invoice_number     VARCHAR2 (60) PATH 'TRX_NUMBER'
                                       ,interface_status   VARCHAR2 (240)
                                              PATH 'STATUS_VALUE'
                                       ,customer_trx_id    NUMBER PATH 'CUSTOMER_TRX_ID'
                                       ,interface_error_msg CLOB PATH 'MESSAGE_TEXT');
   BEGIN
      OPEN c_invoice;

      FETCH c_invoice
      BULK COLLECT INTO l_invoice_tbl;

      CLOSE c_invoice;

      FOR i IN l_invoice_tbl.FIRST .. l_invoice_tbl.LAST
      LOOP
         UPDATE xxpm_invoice_header
            SET interface_status = l_invoice_tbl (i).interface_status
               ,customer_trx_id = l_invoice_tbl (i).customer_trx_id
               ,interface_error_msg = l_invoice_tbl (i).interface_error_msg
          WHERE invoice_number = l_invoice_tbl (i).invoice_number;
      END LOOP;

      COMMIT;
   END invoice_status;

   PROCEDURE receipt_status (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE receipt_tbl_type IS TABLE OF xxpm_receipt%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_receipt_tbl  receipt_tbl_type;

      CURSOR c_receipt
      IS
                 SELECT NULL receipt_id
                       ,NULL func_id
                       ,NULL source_func_id
                       ,NULL source_func_ref_id
                       ,receipt_number
                       ,NULL receipt_date
                       ,NULL org_id
                       ,NULL receipt_type
                       ,NULL property_id
                       ,NULL unit_id
                       ,NULL build_id
                       ,NULL lead_id
                       ,NULL cust_id
                       ,NULL cust_site_id
                       ,NULL salesman_id
                       ,NULL customer_name
                       ,NULL currency_code
                       ,NULL receipt_amount
                       ,NULL pay_mode
                       ,NULL pay_ref_number
                       ,NULL pay_ref_date
                       ,NULL bank_name
                       ,NULL bank_branch_name
                       ,NULL drawn_by
                       ,NULL status
                       ,NULL description
                       ,NULL flow_status
                       ,NULL flow_level
                       ,NULL flow_with
                       ,NULL tax_amount
                       ,NULL tax_code
                       ,NULL tax_rate
                       ,NULL attribute_category
                       ,NULL attribute1
                       ,NULL attribute2
                       ,NULL attribute3
                       ,NULL attribute4
                       ,NULL attribute5
                       ,NULL attribute6
                       ,NULL attribute7
                       ,NULL attribute8
                       ,NULL attribute9
                       ,NULL attribute10
                       ,NULL attribute11
                       ,NULL attribute12
                       ,NULL attribute13
                       ,NULL attribute14
                       ,NULL attribute15
                       ,NULL attribute16
                       ,NULL attribute17
                       ,NULL attribute18
                       ,NULL attribute19
                       ,NULL attribute20
                       ,NULL created_by
                       ,NULL creation_date
                       ,NULL last_updated_by
                       ,NULL last_update_date
                       ,NULL last_update_login
                       ,NULL recommended_amount
                       ,NULL received_amount
                       ,NULL diff_in_days
                       ,NULL pay_rec_date
                       ,NULL pay_rev_date
                       ,NULL rct_type
                       ,NULL rct_desc
                       ,interface_status
                       ,NULL gl_date
                       ,NULL rev_date
                       ,NULL rev_gl_date
                       ,NULL rev_category
                       ,NULL rev_reason
                       ,NULL rev_desc
                       ,NULL rev_int_status
                       ,receipt_risk_yn
                       ,NULL interface_error_msg
                       ,NULL bank_account_num
                       ,NULL mode_of_receipt
                       ,NULL remit_bank_acct_use_id
                   FROM XMLTABLE (
                           '/DATA_DS/G_1'
                           PASSING acct_doc
                           COLUMNS receipt_number VARCHAR2 (60) PATH 'RECEIPT_NUMBER'
                                  ,interface_status VARCHAR2 (240)
                                         PATH 'STATUS_VALUE'
                                  ,receipt_risk_yn VARCHAR2 (1)
                                         PATH 'RISK_RECEIPT_YN');
   BEGIN
      OPEN c_receipt;

      FETCH c_receipt
      BULK COLLECT INTO l_receipt_tbl;

      CLOSE c_receipt;

      FOR i IN l_receipt_tbl.FIRST .. l_receipt_tbl.LAST
      LOOP
         UPDATE xxpm_receipt
            SET interface_status = l_receipt_tbl (i).interface_status
               ,receipt_risk_yn = l_receipt_tbl (i).receipt_risk_yn
          WHERE receipt_number = l_receipt_tbl (i).receipt_number;
      END LOOP;

      COMMIT;
   END receipt_status;

   PROCEDURE receipt_method (p_xml_data CLOB)
   AS
      acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE receiptmthd_tbl_type IS TABLE OF xxstg_receipt_method%ROWTYPE
         INDEX BY BINARY_INTEGER;

      l_recptmthd_tbl receiptmthd_tbl_type;

      CURSOR c_recptmthd
      IS
                    SELECT receipt_method_id
                          ,receipt_method_name
                          ,org_id
                          ,NULL TYPE
                          ,'anonymous' created_by
                          ,SYSDATE creation_date
                          ,'anonymous' last_updated_by
                          ,SYSDATE last_update_date
                          ,'anonymous' last_update_login
                          ,remit_bank_acct_use_id
                          ,bank_account_num
                          ,bank_name
                          ,bank_branch_name
                          ,rec_bank_acc_num
                          ,rec_bank_name
                          ,rec_bank_branch_name
                      FROM XMLTABLE (
                              '/DATA_DS/G_1'
                              PASSING acct_doc
                              COLUMNS receipt_method_id NUMBER PATH 'RECEIPT_METHOD_ID'
                                     ,receipt_method_name VARCHAR2 (30)
                                            PATH 'RECEIPT_METHOD_NAME'
                                     ,org_id           NUMBER PATH 'ORG_ID'
                                     ,remit_bank_acct_use_id NUMBER
                                            PATH 'REMIT_BANK_ACCT_USE_ID'
                                     ,bank_account_num VARCHAR2 (60)
                                            PATH 'BANK_ACCOUNT_NUM'
                                     ,bank_name        VARCHAR2 (240) PATH 'BANK_NAME'
                                     ,bank_branch_name VARCHAR2 (240)
                                            PATH 'BANK_BRANCH_NAME'
                                     ,rec_bank_acc_num VARCHAR2 (60)
                                            PATH 'REC_BANK_ACC_NUM'
                                     ,rec_bank_name    VARCHAR2 (240)
                                            PATH 'REC_BANK_NAME'
                                     ,rec_bank_branch_name VARCHAR2 (240)
                                            PATH 'REC_BANK_BRANCH_NAME');
   BEGIN
      OPEN c_recptmthd;

      FETCH c_recptmthd
      BULK COLLECT INTO l_recptmthd_tbl;

      CLOSE c_recptmthd;

      FOR i IN l_recptmthd_tbl.FIRST .. l_recptmthd_tbl.LAST
      LOOP
         MERGE INTO xxstg_receipt_method a
              USING (SELECT l_recptmthd_tbl (i).receipt_method_id
                               receipt_method_id
                           ,l_recptmthd_tbl (i).receipt_method_name
                               receipt_method_name
                           ,l_recptmthd_tbl (i).org_id org_id
                           ,l_recptmthd_tbl (i).TYPE TYPE
                           ,l_recptmthd_tbl (i).created_by created_by
                           ,l_recptmthd_tbl (i).creation_date creation_date
                           ,l_recptmthd_tbl (i).last_updated_by
                               last_updated_by
                           ,l_recptmthd_tbl (i).last_update_date
                               last_update_date
                           ,l_recptmthd_tbl (i).last_update_login
                               last_update_login
                           ,l_recptmthd_tbl (i).remit_bank_acct_use_id
                               remit_bank_acct_use_id
                           ,l_recptmthd_tbl (i).bank_account_num
                               bank_account_num
                           ,l_recptmthd_tbl (i).bank_name bank_name
                           ,l_recptmthd_tbl (i).bank_branch_name
                               bank_branch_name
                           ,l_recptmthd_tbl (i).rec_bank_acc_num
                               rec_bank_acc_num
                           ,l_recptmthd_tbl (i).rec_bank_name rec_bank_name
                           ,l_recptmthd_tbl (i).rec_bank_branch_name
                               rec_bank_branch_name
                       FROM DUAL) b
                 ON (    a.remit_bank_acct_use_id = b.remit_bank_acct_use_id
                     AND a.org_id = b.org_id
                     AND a.receipt_method_id = b.receipt_method_id)
         WHEN MATCHED
         THEN
            UPDATE SET receipt_method_name = b.receipt_method_name
                      ,TYPE         = b.TYPE
                      ,created_by   = b.created_by
                      ,creation_date = b.creation_date
                      ,last_updated_by = b.last_updated_by
                      ,last_update_date = b.last_update_date
                      ,last_update_login = b.last_update_login
                      ,bank_name    = b.bank_name
                      ,bank_branch_name = b.bank_branch_name
                      ,rec_bank_acc_num = b.rec_bank_acc_num
                      ,rec_bank_name = b.rec_bank_name
                      ,rec_bank_branch_name = b.rec_bank_branch_name
         WHEN NOT MATCHED
         THEN
            INSERT     (receipt_method_id
                       ,receipt_method_name
                       ,org_id
                       ,TYPE
                       ,created_by
                       ,creation_date
                       ,last_updated_by
                       ,last_update_date
                       ,last_update_login
                       ,remit_bank_acct_use_id
                       ,bank_account_num
                       ,bank_name
                       ,bank_branch_name
                       ,rec_bank_acc_num
                       ,rec_bank_name
                       ,rec_bank_branch_name)
                VALUES (b.receipt_method_id
                       ,b.receipt_method_name
                       ,b.org_id
                       ,b.TYPE
                       ,b.created_by
                       ,b.creation_date
                       ,b.last_updated_by
                       ,b.last_update_date
                       ,b.last_update_login
                       ,b.remit_bank_acct_use_id
                       ,b.bank_account_num
                       ,b.bank_name
                       ,b.bank_branch_name
                       ,b.rec_bank_acc_num
                       ,b.rec_bank_name
                       ,b.rec_bank_branch_name);
      END LOOP;

      COMMIT;
   END receipt_method;
END xxstg_integration_pkg;
