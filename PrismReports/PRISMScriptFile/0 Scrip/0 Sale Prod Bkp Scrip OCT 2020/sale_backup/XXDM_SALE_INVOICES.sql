--------------------------------------------------------
--  DDL for Package XXDM_SALE_INVOICES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXDM_SALE_INVOICES" 
as
procedure sales_invoice_val(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
;

procedure sales_invoice_Insert(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);

    FUNCTION get_function_id(
    p_func_short_code IN VARCHAR2)
    RETURN NUMBER;



end xxdm_sale_invoices;
