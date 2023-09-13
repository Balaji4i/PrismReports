--------------------------------------------------------
--  DDL for Package XXPM_AUTO_BILLING_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_AUTO_BILLING_PKG" 
is

procedure createBilling(P_TRANS_ID 		IN NUMBER,
						P_FUN_ID			IN NUMBER,
                        P_LOGIN_USER        IN VARCHAR2,
						P_ERROR_CODE 	OUT VARCHAR2,
						P_ERR_MSG		OUT VARCHAR2
						);


procedure create_milestone_credit_memo(
                        P_TRANS_ID 		IN NUMBER,
						P_LOGIN_USER    IN VARCHAR2,
						P_ERROR_CODE 	OUT VARCHAR2,
						P_ERR_MSG		OUT VARCHAR2
						);

end xxpm_Auto_Billing_pkg;
