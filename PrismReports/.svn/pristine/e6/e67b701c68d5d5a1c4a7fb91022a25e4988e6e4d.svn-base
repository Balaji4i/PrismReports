--------------------------------------------------------
--  DDL for Package XXPM_BILL_INVOICE_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_BILL_INVOICE_PKG" 
is
PRAGMA SERIALLY_REUSABLE;
      g_invoice_code      VARCHAR2 (5)    := 'IN';
      G_CURRENCY_CODE     VARCHAR2 (5)    := 'AED';
      g_inv_hdr_status    VARCHAR2 (20)   := 'APR';
--      g_inv_int_status    VARCHAR2 (60)   := 'Pending at user side. Kindly validate and Transfer to AR';
        g_inv_int_status    VARCHAR2 (60)   := 'ERROR';
--      g_inv_int_status    VARCHAR2 (20)   := 'READY_TO_INVOICE';

 FUNCTION GET_LINE_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
    )
RETURN NUMBER;

 FUNCTION GET_TAX_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
    )
RETURN NUMBER; 

   FUNCTION get_function_id (p_func_short_code IN VARCHAR2)
      RETURN NUMBER;      
   PROCEDURE load_invoice (p_billing_id IN NUMBER,
                          p_err_code      OUT varchar2,
                          P_ERR_MSG       OUT varchar2);
   procedure XXPM_CREATE_INVOICE_TXN(P_CHARGE_TYPE in varchar2 ,P_BOOK_REF_ID  in number , P_TRANS_REF_ID in number);

   PROCEDURE GET_INV_NUMBER(P_BOOKING_HDR_ID IN NUMBER,P_INV_NUMBER OUT VARCHAR2);

--   procedure sublease_invoice(p_billing_id IN NUMBER);

PROCEDURE ms_based_invoice (p_billing_id    IN NUMBER,
                            p_err_code      OUT varchar2,
                            P_ERR_MSG       OUT varchar2);



end xxpm_bill_invoice_pkg;
