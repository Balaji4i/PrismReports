--------------------------------------------------------
--  DDL for Package Body XXPM_RECEIPT_ACCOUNT_SYNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_RECEIPT_ACCOUNT_SYNC" 
IS
PROCEDURE INVOICE_HDR_ACCOUNTS (P_XML_DATA CLOB, p_error_message OUT VARCHAR2)
   AS
      ACCT_DOC XMLTYPE := XMLTYPE.CREATEXML (P_XML_DATA);

      TYPE INVOICE_HDR_ACC_REPORT IS TABLE OF XXPM_INVOICE_HDR_SYNC % ROWTYPE
         INDEX BY BINARY_INTEGER;

      INVOICE_SYNC_TABLE INVOICE_HDR_ACC_REPORT;

      CURSOR C_INVOICE_SYNC
      IS
                   SELECT   INVOICE_NUMBER INVOICE_NUMBER, 
                            CUSTOMER_TRX_ID CUSTOMER_TRX_ID, 
                            to_timestamp_tz(GL_DATE,'YYYY-MM-DD"T"HH24:MI:SS.ff3+TZH:TZM') GL_DATE, 
                            null, null
                     FROM XMLTABLE (
                             '/DATA_DS/G_1'
                             PASSING ACCT_DOC
                             COLUMNS
                                    INVOICE_NUMBER VARCHAR2 (240) PATH 'TRX_NUMBER',
                                    CUSTOMER_TRX_ID NUMBER PATH 'CUSTOMER_TRX_ID', 
                                    GL_DATE VARCHAR2 (50) PATH 'GL_DATE');
   BEGIN
      OPEN C_INVOICE_SYNC;
      FETCH C_INVOICE_SYNC
      BULK COLLECT INTO INVOICE_SYNC_TABLE;
      CLOSE C_INVOICE_SYNC;

      FOR I IN INVOICE_SYNC_TABLE.FIRST .. INVOICE_SYNC_TABLE.LAST
      LOOP 
         MERGE INTO XXPM_INVOICE_HDR_SYNC A
              USING (SELECT INVOICE_SYNC_TABLE (I).CUSTOMER_TRX_ID CUSTOMER_TRX_ID
                           ,INVOICE_SYNC_TABLE (I).INVOICE_NUMBER INVOICE_NUMBER 
                           ,INVOICE_SYNC_TABLE (I).GL_DATE GL_DATE
                       FROM DUAL) B
                 ON (A.INVOICE_NUMBER = B.INVOICE_NUMBER)
         WHEN MATCHED
         THEN
                UPDATE SET   
                GL_DATE = B.GL_DATE  , UPDATED_ON = SYSDATE
         WHEN NOT MATCHED
         THEN
            INSERT     (CUSTOMER_TRX_ID
                       ,INVOICE_NUMBER  
                       ,GL_DATE
                       ,UPDATED_ON
                       ,CREATED_ON
                       )

                VALUES (B.CUSTOMER_TRX_ID
                       ,B.INVOICE_NUMBER 
                       ,B.GL_DATE
                       ,SYSDATE
                       ,SYSDATE);
      END LOOP;

      COMMIT;
      p_error_message := 'Success';
    EXCEPTION WHEN OTHERS
    THEN
    p_error_message := 'Error in Invoice reverce sync : '||SQLERRM;
   END INVOICE_HDR_ACCOUNTS;


----------------------------------------


PROCEDURE RECEIPT_HDR_ACCOUNTS (P_XML_DATA CLOB, p_error_message OUT VARCHAR2)
   AS
      ACCT_DOC XMLTYPE := XMLTYPE.CREATEXML (P_XML_DATA);

      TYPE RECEIPT_HDR_ACC_REPORT IS TABLE OF XXPM_RECEIPT_HDR_ACC_REPORT % ROWTYPE
         INDEX BY BINARY_INTEGER;

      RECEIPT_HDR_ACC_TABLE RECEIPT_HDR_ACC_REPORT;

      CURSOR C_RECEIPT_HDR_ACC
      IS
                   SELECT CASH_RECEIPT_ID CASH_RECEIPT_ID,
							RECEIPT_NUMBER RECEIPT_NUMBER,
							to_timestamp_tz(RECEIPT_DATE,'YYYY-MM-DD"T"HH24:MI:SS.ff3+TZH:TZM') RECEIPT_DATE,
							to_timestamp_tz(GL_DATE,'YYYY-MM-DD"T"HH24:MI:SS.ff3+TZH:TZM') GL_DATE, null, null, null
                     FROM XMLTABLE (
                             '/DATA_DS/G_1'
                             PASSING ACCT_DOC
                             COLUMNS CASH_RECEIPT_ID NUMBER PATH 'CASH_RECEIPT_ID',
                                    RECEIPT_NUMBER VARCHAR2 (240) PATH 'RECEIPT_NUMBER',
                                    RECEIPT_DATE VARCHAR2 (50) PATH 'RECEIPT_DATE',
                                    GL_DATE VARCHAR2 (50) PATH 'GL_DATE');
   BEGIN
      OPEN C_RECEIPT_HDR_ACC;

      FETCH C_RECEIPT_HDR_ACC
      BULK COLLECT INTO RECEIPT_HDR_ACC_TABLE;

      CLOSE C_RECEIPT_HDR_ACC;

      FOR I IN RECEIPT_HDR_ACC_TABLE.FIRST .. RECEIPT_HDR_ACC_TABLE.LAST
      LOOP 
         MERGE INTO XXPM_RECEIPT_HDR_ACC_REPORT A
              USING (SELECT RECEIPT_HDR_ACC_TABLE (I).CASH_RECEIPT_ID CASH_RECEIPT_ID
                           ,RECEIPT_HDR_ACC_TABLE (I).RECEIPT_NUMBER RECEIPT_NUMBER
                           ,RECEIPT_HDR_ACC_TABLE (I).RECEIPT_DATE RECEIPT_DATE
                           ,RECEIPT_HDR_ACC_TABLE (I).GL_DATE GL_DATE
                       FROM DUAL) B
                 ON (A.CASH_RECEIPT_ID = B.CASH_RECEIPT_ID
                    AND
                    A.RECEIPT_NUMBER = B.RECEIPT_NUMBER)
         WHEN MATCHED
         THEN
            UPDATE SET RECEIPT_DATE  	= B.RECEIPT_DATE
                      ,GL_DATE 			= B.GL_DATE
                      ,UPDATED_ON       = SYSDATE
         WHEN NOT MATCHED
         THEN
            INSERT     (CASH_RECEIPT_ID
                       ,RECEIPT_NUMBER
                       ,RECEIPT_DATE  
                       ,GL_DATE
                       ,UPDATED_ON
                       ,CREATED_ON
                       )

                VALUES (B.CASH_RECEIPT_ID
                       ,B.RECEIPT_NUMBER
                       ,B.RECEIPT_DATE
                       ,B.GL_DATE
                       ,SYSDATE
                       ,SYSDATE);
      END LOOP;

      COMMIT;
      p_error_message := 'Success';
    EXCEPTION WHEN OTHERS
    THEN
    p_error_message := 'Error in RECEIPT_HDR_ACCOUNTS : '||SQLERRM;
   END RECEIPT_HDR_ACCOUNTS;

PROCEDURE RECEIPT_APP_ACCOUNTS (P_XML_DATA CLOB, p_error_message OUT VARCHAR2)
   AS
      ACCT_DOC XMLTYPE := XMLTYPE.CREATEXML (P_XML_DATA);

      TYPE RECEIPT_APP_ACC_REPORT IS TABLE OF xxpm_receipt_app_acc_report % ROWTYPE
         INDEX BY BINARY_INTEGER;

      RECEIPT_APP_ACC_TABLE RECEIPT_APP_ACC_REPORT;

      CURSOR C_RECEIPT_APP_ACC
      IS
                   SELECT   CASH_RECEIPT_ID CASH_RECEIPT_ID,
							RECEIPT_NUMBER RECEIPT_NUMBER,
							to_timestamp_tz(RECEIPT_DATE,'YYYY-MM-DD"T"HH24:MI:SS.ff3+TZH:TZM') RECEIPT_DATE,
							to_timestamp_tz(GL_DATE,'YYYY-MM-DD"T"HH24:MI:SS.ff3+TZH:TZM') GL_DATE,
                            to_timestamp_tz(DEPOSIT_DATE,'YYYY-MM-DD"T"HH24:MI:SS.ff3+TZH:TZM') DEPOSIT_DATE,
                            CUSTOMER_TRX_ID CUSTOMER_TRX_ID,
                            TRX_NUMBER TRX_NUMBER, null, null,
                            RECEIVABLE_APPLICATION_ID  RECEIVABLE_APPLICATION_ID
                     FROM XMLTABLE (
                             '/DATA_DS/G_1'
                             PASSING ACCT_DOC
                             COLUMNS  
                                    CASH_RECEIPT_ID NUMBER PATH 'CASH_RECEIPT_ID',
                                    RECEIPT_NUMBER VARCHAR2 (240) PATH 'RECEIPT_NUMBER',
                                    RECEIPT_DATE VARCHAR2 (240) PATH 'RECEIPT_DATE',
                                    GL_DATE VARCHAR2 (240) PATH 'GL_DATE',
                                    DEPOSIT_DATE VARCHAR2 (240) PATH 'DEPOSIT_DATE',
                                    CUSTOMER_TRX_ID NUMBER PATH 'CUSTOMER_TRX_ID',
                                    TRX_NUMBER VARCHAR2 (240) PATH 'TRX_NUMBER',
                                    RECEIVABLE_APPLICATION_ID NUMBER PATH 'RECEIVABLE_APPLICATION_ID'
                                    );
   BEGIN
      OPEN C_RECEIPT_APP_ACC;

      FETCH C_RECEIPT_APP_ACC
      BULK COLLECT INTO RECEIPT_APP_ACC_TABLE;

      CLOSE C_RECEIPT_APP_ACC;

      FOR I IN RECEIPT_APP_ACC_TABLE.FIRST .. RECEIPT_APP_ACC_TABLE.LAST
      LOOP 
         MERGE INTO xxpm_receipt_app_acc_report A
              USING (SELECT RECEIPT_APP_ACC_TABLE (I).RECEIVABLE_APPLICATION_ID RECEIVABLE_APPLICATION_ID
                           ,RECEIPT_APP_ACC_TABLE (I).CASH_RECEIPT_ID CASH_RECEIPT_ID
                           ,RECEIPT_APP_ACC_TABLE (I).RECEIPT_NUMBER RECEIPT_NUMBER
                           ,RECEIPT_APP_ACC_TABLE (I).RECEIPT_DATE RECEIPT_DATE
                           ,RECEIPT_APP_ACC_TABLE (I).GL_DATE GL_DATE
                           ,RECEIPT_APP_ACC_TABLE (I).DEPOSIT_DATE DEPOSIT_DATE
                           ,RECEIPT_APP_ACC_TABLE (I).CUSTOMER_TRX_ID CUSTOMER_TRX_ID
                           ,RECEIPT_APP_ACC_TABLE (I).TRX_NUMBER TRX_NUMBER
                       FROM DUAL) B
                 ON (A.RECEIVABLE_APPLICATION_ID = B.RECEIVABLE_APPLICATION_ID)
         WHEN MATCHED
         THEN
            UPDATE SET RECEIPT_NUMBER   = B.RECEIPT_NUMBER
                      ,RECEIPT_DATE  	= B.RECEIPT_DATE
                      ,GL_DATE 			= B.GL_DATE
                      ,UPDATED_ON       = SYSDATE
                      ,DEPOSIT_DATE     = B.DEPOSIT_DATE
                      ,CUSTOMER_TRX_ID  = B.CUSTOMER_TRX_ID
                      ,TRX_NUMBER       = B.TRX_NUMBER
         WHEN NOT MATCHED
         THEN
            INSERT     (RECEIVABLE_APPLICATION_ID
                       ,CASH_RECEIPT_ID
                       ,RECEIPT_NUMBER
                       ,RECEIPT_DATE  
                       ,GL_DATE 
                       ,DEPOSIT_DATE
                       ,CUSTOMER_TRX_ID
                       ,TRX_NUMBER
                       ,UPDATED_ON
                       ,CREATED_ON
                       )

                VALUES (B.RECEIVABLE_APPLICATION_ID
                       ,B.CASH_RECEIPT_ID
                       ,B.RECEIPT_NUMBER
                       ,B.RECEIPT_DATE
                       ,B.GL_DATE
                       ,B.DEPOSIT_DATE
                       ,B.CUSTOMER_TRX_ID
                       ,B.TRX_NUMBER
                       ,SYSDATE
                       ,SYSDATE); 
      END LOOP;

      COMMIT;
      p_error_message := 'Success';
    EXCEPTION WHEN OTHERS
    THEN
    p_error_message := 'Error in RECEIPT_APP_ACCOUNTS : '||SQLERRM;
   END RECEIPT_APP_ACCOUNTS;

PROCEDURE update_gl_receipt_header(
    receipt_no  VARCHAR2,
    gl_date_new TIMESTAMP, P_CASH_RECEIPT_ID NUMBER)
AS
  l_current_gl_date TIMESTAMP;
  receipt_count NUMBER:=0;
BEGIN
  SELECT COUNT(*) INTO receipt_count FROM xxpm_receipt WHERE receipt_number = receipt_no;
  IF (receipt_count = 1) THEN
    SELECT gl_date INTO l_current_gl_date FROM xxpm_receipt WHERE receipt_number  = receipt_no;

    UPDATE xxpm_receipt
      SET gl_date          = gl_date_new,
          CASH_RECEIPT_ID = P_CASH_RECEIPT_ID,
          LAST_UPDATE_DATE = sysdate
      WHERE receipt_number = receipt_no; 
  END IF;
  commit;
  EXCEPTION WHEN OTHERS
    THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END update_gl_receipt_header;

PROCEDURE update_gl_receipt_line(p_receipt_no VARCHAR2, p_invoice_no VARCHAR2, P_GL_DATE timestamp,
                                      P_CUSTOMER_TRX_ID number, P_RECEIVABLE_APPLICATION_ID number)
AS
v_invoice_id number;
v_receipt_id number;
line_count number;
BEGIN 
SELECT INVOICE_ID into v_invoice_id FROM XXPM_INVOICE_HEADER WHERE INVOICE_NUMBER = p_invoice_no;
select RECEIPT_ID into v_receipt_id from XXPM_RECEIPT where RECEIPT_NUMBER = p_receipt_no;
DBMS_OUTPUT.PUT_LINE('v_invoice_id-'||v_invoice_id);
DBMS_OUTPUT.PUT_LINE('v_receipt_id-'||v_receipt_id);
if(v_invoice_id is not null and v_receipt_id is not null) then

SELECT count(*) into line_count FROM XXPM_RECEIPT_DETAILS WHERE INVOICE_ID = v_invoice_id and RECEIPT_ID = v_receipt_id;

DBMS_OUTPUT.PUT_LINE('line_count-'||line_count);
if(line_count > 0) then

update xxpm_receipt_details 
set 
CUSTOMER_TRX_ID = P_CUSTOMER_TRX_ID , 
RECEIVABLE_APPLICATION_ID = P_RECEIVABLE_APPLICATION_ID , 
GL_DATE = P_GL_DATE,
LAST_UPDATE_DATE = sysdate
WHERE INVOICE_ID = v_invoice_id and RECEIPT_ID = v_receipt_id;
end if;
 commit;
end if;
  EXCEPTION WHEN OTHERS
    THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END update_gl_receipt_line;

PROCEDURE update_gl_invoice_header(
    invoice_no  VARCHAR2,
    gl_date_new TIMESTAMP, P_CUSTOMER_TRX_ID NUMBER)
AS
  l_current_gl_date TIMESTAMP;
  invoice_count NUMBER:=0;
BEGIN
  SELECT COUNT(*) INTO invoice_count FROM XXPM_INVOICE_HEADER WHERE INVOICE_NUMBER = invoice_no;
  IF (invoice_count = 1) THEN
    SELECT gl_date INTO l_current_gl_date FROM XXPM_INVOICE_HEADER WHERE INVOICE_NUMBER = invoice_no;

      UPDATE XXPM_INVOICE_HEADER
      SET gl_date          = gl_date_new,
          CUSTOMER_TRX_ID = P_CUSTOMER_TRX_ID,
          LAST_UPDATE_DATE = sysdate
      WHERE INVOICE_NUMBER = invoice_no; 
  END IF;
  commit;
  EXCEPTION WHEN OTHERS
    THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END update_gl_invoice_header;


END XXPM_RECEIPT_ACCOUNT_SYNC;
