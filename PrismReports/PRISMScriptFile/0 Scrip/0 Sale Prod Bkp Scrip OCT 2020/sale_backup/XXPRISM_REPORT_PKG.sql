--------------------------------------------------------
--  DDL for Package XXPRISM_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPRISM_REPORT_PKG" 
is 

  function XXPRISM_RESERVATION_CONTRACT( 
    P_UNIT_NUM IN VARCHAR2,
    P_PROPERTY_ID IN VARCHAR2 ) 
  RETURN CLOB; 

  FUNCTION XXPRISM_RECEIPT_REPORT( 
        P_RECP_NUM IN VARCHAR2) 
  RETURN CLOB; 

  function XXPRISM_AR_DETAIL(
    P_PROJ_NAME IN VARCHAR2,
    P_PROP_NAME IN VARCHAR2,
    P_DATE IN DATE
    ) 
  RETURN CLOB; 

    function XXPRISM_AR_SUMMARY( 
    P_PROJ_NAME IN VARCHAR2,
    P_PROP_NAME IN VARCHAR2,
    P_DATE IN DATE
    ) 
  RETURN CLOB; 

  function XXPRISM_UNIT_STATUS( 
    P_PROJ_NAME IN VARCHAR2,
    P_PROP_NAME IN VARCHAR2
    ) 
  RETURN CLOB; 

  FUNCTION XXPRISM_SPA_REPORT(
   P_BLOCK_NUM IN VARCHAR2) 
  RETURN CLOB;

  FUNCTION XXPRISM_ARABIC_SPA_REPORT(
   P_BLOCK_NUM IN VARCHAR2) 
  RETURN CLOB;

   FUNCTION XXPRISM_ALL_INVENTORY_STATUS
   (P_PROP_NAME IN VARCHAR2,
   P_BUILD_NAME IN VARCHAR2) 
  RETURN CLOB;

   FUNCTION XXPRISM_TRADE_RECEIVABLES
   (P_PROJ_NAME IN VARCHAR2,
   P_CUST_NUMB IN VARCHAR2,
   P_UNIT_NUMBER IN VARCHAR2,
   P_DATE IN STRING
   ) 
  RETURN CLOB;
  
  FUNCTION XXPRISM_TAX_INVOICE
   (p_bu_name IN VARCHAR2,
   p_inv_num IN VARCHAR2,
   p_booking_num IN VARCHAR2
   ) 
  RETURN CLOB;
  
  FUNCTION XXPRISM_CUSTOMER_STATEMENT
   (p_cust_id IN VARCHAR2,
   P_DATE IN DATE
   ) 
  RETURN CLOB;
  
    FUNCTION XXPRISM_SOA_SUMMARY
   (p_cust_id IN VARCHAR2,
   P_DATE IN DATE
   ) 
  RETURN CLOB;
  
  function XXPRISM_COLLECTION_REPORT( 
    P_PROP_NAME IN VARCHAR2,
   -- p_date IN DATE
    PFROM IN DATE,
    PTO IN DATE
    ) 
  RETURN CLOB;
  
  function XXPRISM_ERROR_STATUS 
  RETURN CLOB;
  
  function XXPRISM_SALES_REPORT( 
    p_bu_id IN VARCHAR2,
    p_unit_type IN VARCHAR2,
    p_date_from IN DATE,
    p_date_to IN DATE
    )
  RETURN CLOB;
  
  function XXPRISM_CANCELLATION(
    p_prop_name IN VARCHAR2,
    p_date IN DATE
    ) 
  RETURN CLOB; 
  
   function XXPRISM_PDC_REPORT( 
    P_PROP_NAME IN VARCHAR2,
    P_DATE IN DATE
    ) 
  RETURN CLOB ;
  
  FUNCTION XXPRISM_UNIT_STATUS_NEW (
                      P_PROJ_NAME IN VARCHAR2
                      ,P_PROP_NAME IN VARCHAR2
                      ) 
  RETURN CLOB ;

  function XXPRISM_PDC_DUE_REPORT( 
    P_DUE_ALERT IN VARCHAR2
    ) 
  RETURN CLOB ;
  
   FUNCTION XXPRISM_EMAIL_RECEIPT_REPORT(P_RECP_NUM IN VARCHAR2)
  RETURN CLOB ;
  
    FUNCTION XXPRISM_CUST_MASTER(P_CUST IN NUMBER) 
  RETURN CLOB ;
  
  FUNCTION XXPRISM_UNAPPLIED_RECEIPT(
      P_PROP_NAME IN VARCHAR2,
	  P_DATE IN DATE
	  ) 
  RETURN CLOB ;
 
END XXPRISM_report_pkg;