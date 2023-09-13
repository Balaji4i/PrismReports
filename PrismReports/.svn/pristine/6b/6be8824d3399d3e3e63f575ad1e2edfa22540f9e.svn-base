--------------------------------------------------------
--  DDL for Package Body XXSF_AGENT_SYNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXSF_AGENT_SYNC" AS

    PROCEDURE merge_agency_sync (
        p_agency_id       IN   VARCHAR2,
        p_agency_name     IN   VARCHAR2,
        p_agency_type     IN   VARCHAR2,
        p_contract_type   IN   VARCHAR2,
        p_creation_date   IN   DATE,
        p_current_owner   IN   VARCHAR2,
        p_email           IN   VARCHAR2,
        p_mobile          IN   VARCHAR2,
        p_record_type     IN   VARCHAR2,
        p_status          IN   VARCHAR2
    ) AS
        l_query VARCHAR2(10000);
    BEGIN
        l_query := 'MERGE INTO XXSF_AGENCY USING DUAL ON (AGENCY_ID = '''
                   || p_agency_id
                   || ''') WHEN MATCHED THEN UPDATE SET '
                   || ' AGENCY_NAME = '''
                   || p_agency_name
                   || ''', AGENCY_TYPE = '''
                   || p_agency_type
                   || ''', CONTRACT_TYPE = '''
                   || p_contract_type
                   || ''', CREATION_DATE = '''
                   || p_creation_date
                   || ''', CURRENT_OWNER = '''
                   || p_current_owner
                   || ''', EMAIL = '''
                   || p_email
                   || ''', MOBILE = '''
                   || p_mobile
                   || ''', RECORD_TYPE = '''
                   || p_record_type
                   || ''', STATUS = '''
                   || p_status
                   || ''''
                   || ' WHEN NOT MATCHED THEN INSERT '
                   || '(AGENCY_ID,AGENCY_NAME,AGENCY_TYPE,CONTRACT_TYPE,CREATION_DATE,CURRENT_OWNER,EMAIL,MOBILE,RECORD_TYPE,STATUS) VALUES '
                   || '('''
                   || p_agency_id
                   || ''','''
                   || p_agency_name
                   || ''','''
                   || p_agency_type
                   || ''','''
                   || p_contract_type
                   || ''','''
                   || p_creation_date
                   || ''','''
                   || p_current_owner
                   || ''','''
                   || p_email
                   || ''','''
                   || p_mobile
                   || ''','''
                   || p_record_type
                   || ''','''
                   || p_status
                   || ''')';

                   DBMS_OUTPUT.PUT_LINE(l_query);

        EXECUTE IMMEDIATE l_query;
        COMMIT;
    END merge_agency_sync;

    PROCEDURE merge_agent_sync (
        p_agency_id        IN   VARCHAR2,
        p_agency_name      IN   VARCHAR2,
        p_agent_name       IN   VARCHAR2,
        p_customer_owner   IN   VARCHAR2,
        p_email2           IN   VARCHAR2
    ) AS
        l_query VARCHAR2(10000);
    BEGIN
        l_query := 'MERGE INTO XXSF_AGENTS USING DUAL ON (AGENCY_ID = '''
                   || p_agency_id || ''' AND AGENT_NAME = '''
                   || p_agent_name
                   || ''') WHEN MATCHED THEN UPDATE SET '
                   || ' AGENCY_NAME = '''
                   || p_agency_name
                   || ''', CUSTOMER_OWNER = '''
                   || p_customer_owner
                   || ''', EMAIL2 = '''
                   || p_email2
                   || ''''
                   || ' WHEN NOT MATCHED THEN INSERT '
                   || '(AGENCY_ID,AGENCY_NAME,AGENT_NAME,CUSTOMER_OWNER,EMAIL2) VALUES '
                   || '('''
                   || p_agency_id
                   || ''','''
                   || p_agency_name
                   || ''','''
                   || p_agent_name
                   || ''','''
                   || p_customer_owner
                   || ''','''
                   || p_email2
                   || ''')';
                   DBMS_OUTPUT.PUT_LINE(l_query);
        EXECUTE IMMEDIATE l_query;
        COMMIT;
    END merge_agent_sync;

END xxsf_agent_sync;
