--------------------------------------------------------
--  DDL for Package XXDM_SALE_RECEIPTS_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXDM_SALE_RECEIPTS_PKG" 
AS
procedure sales_receipts_val(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);
     PROCEDURE sales_receipts_insert( P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);

end xxdm_sale_receipts_pkg;
