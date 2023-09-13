--------------------------------------------------------
--  DDL for Package XXPM_RECEIPT_ACCOUNT_SYNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_RECEIPT_ACCOUNT_SYNC" 
IS
   PROCEDURE INVOICE_HDR_ACCOUNTS (p_xml_data CLOB, p_error_message OUT VARCHAR2);
   PROCEDURE receipt_hdr_accounts (p_xml_data CLOB, p_error_message OUT VARCHAR2);
   PROCEDURE receipt_app_accounts (p_xml_data CLOB, p_error_message OUT VARCHAR2);
   PROCEDURE update_gl_receipt_header (receipt_no VARCHAR2, gl_date_new timestamp, P_CASH_RECEIPT_ID NUMBER);
   PROCEDURE update_gl_receipt_line (p_receipt_no VARCHAR2, p_invoice_no VARCHAR2, P_GL_DATE timestamp,
                                      P_CUSTOMER_TRX_ID number, P_RECEIVABLE_APPLICATION_ID number);
     
   PROCEDURE update_gl_invoice_header(invoice_no  VARCHAR2,gl_date_new TIMESTAMP, P_CUSTOMER_TRX_ID NUMBER);
   
END XXPM_RECEIPT_ACCOUNT_SYNC;
