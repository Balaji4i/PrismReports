--------------------------------------------------------
--  DDL for Trigger RECEIPT_HDR_ACCOUNT_SYNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "RECEIPT_HDR_ACCOUNT_SYNC" 
AFTER INSERT or UPDATE ON xxpm_receipt_hdr_acc_report 
FOR EACH ROW  
DECLARE
BEGIN

XXPM_RECEIPT_ACCOUNT_SYNC.update_gl_receipt_header(:NEW.RECEIPT_NUMBER, :NEW.GL_DATE, :NEW.CASH_RECEIPT_ID);
NULL;
END RECEIPT_HDR_ACCOUNT_SYNC;

ALTER TRIGGER "RECEIPT_HDR_ACCOUNT_SYNC" ENABLE
