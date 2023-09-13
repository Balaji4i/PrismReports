--------------------------------------------------------
--  DDL for Procedure XXSTG_SYNC_CUSTOMER_SITE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXSTG_SYNC_CUSTOMER_SITE" (
    p_xml_data   IN           CLOB,
    p_status     OUT          VARCHAR2
) AS
acct_doc       XMLTYPE := xmltype.createxml (p_xml_data);

      TYPE cust_site_tbl_type IS TABLE OF xxstg_cust_sites%ROWTYPE INDEX BY BINARY_INTEGER;

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
                           ,l_cust_site_tbl (i).orig_system_ref orig_system_ref
                           ,l_cust_site_tbl (i).active_yn active_yn
                       FROM DUAL) b
                 ON (
                   a.cust_site_id = b.cust_site_id
                     AND a.org_id = b.org_id
                     )
         WHEN MATCHED
         THEN
            UPDATE SET 
                       cust_id      = b.cust_id
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
                      ,orig_system_ref = b.orig_system_ref
                      ,active_yn    = b.active_yn
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
                       ,active_yn
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
                       ,b.active_yn
                                   );
      END LOOP;
    p_status:='Success';
    COMMIT;
END;
