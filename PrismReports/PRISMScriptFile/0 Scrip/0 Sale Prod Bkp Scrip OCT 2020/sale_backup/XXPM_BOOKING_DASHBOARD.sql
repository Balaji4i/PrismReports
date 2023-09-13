--------------------------------------------------------
--  DDL for Package XXPM_BOOKING_DASHBOARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_BOOKING_DASHBOARD" 
AS


procedure XXPM_DASHBOARD_OFFER(
                                P_UNIT 	       IN NUMBER,
                                P_MS_HDR_ID    IN NUMBER,
                                P_PL_HDR_ID    IN NUMBER,
                                p_TAX_CODE     IN VARCHAR2,
                                P_CUST_ID      IN NUMBER,
                                P_CUST_SITE_ID IN NUMBER,
                                P_LOGIN_USER   IN VARCHAR2,
                                P_OFFER_ID     OUT NUMBER
                                );

procedure XXPM_DASHBOARD_RECEIPT(
                                P_INVOICE 	        IN NUMBER,
                                P_BOOKING_ID        IN NUMBER,
                                P_TOAL_INV_AMT      IN NUMBER,
                                P_LOGIN_USER        IN varchar2,
                                P_RECEIPT_Id       OUT NUMBER
                                );

procedure XXPM_DASHBOARD_BILLING(
                                P_BOOKING_MS_DTL_ID 	IN NUMBER,
                                P_LOGIN_USER        in varchar2,
                                P_Billing_Id       out NUMBER
                                );


END;
