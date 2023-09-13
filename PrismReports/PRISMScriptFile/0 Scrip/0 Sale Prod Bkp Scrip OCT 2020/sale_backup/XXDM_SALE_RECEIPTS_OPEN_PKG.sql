--------------------------------------------------------
--  DDL for Package XXDM_SALE_RECEIPTS_OPEN_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXDM_SALE_RECEIPTS_OPEN_PKG" 
AS
procedure sales_receiptso_val(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);
     PROCEDURE sales_receiptso_insert( P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);

end xxdm_sale_receipts_OPEN_pkg;
