--------------------------------------------------------
--  DDL for Package XXPM_CANCELLATION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_CANCELLATION_PKG" 
is

procedure xxpm_update_milestone_status(
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
);

PROCEDURE xxpm_insert_booking_ms_debit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
);

PROCEDURE xxpm_insert_cancellation_credit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
);

procedure XXPM_CREATE_AUTO_BILLING(
        p_primary_id 	IN NUMBER,
        p_func_id       IN VARCHAR2,
        p_type          in varchar2,
        p_login_user 	in VARCHAR2,
        P_ERR_MSG		OUT VARCHAR2
        );

end XXPM_CANCELLATION_PKG;
