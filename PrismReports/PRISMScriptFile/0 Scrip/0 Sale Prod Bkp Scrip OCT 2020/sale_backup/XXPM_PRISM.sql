--------------------------------------------------------
--  DDL for Package XXPM_PRISM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PRISM" 
IS

 
 procedure revise_milestone (p_mshdr_id          in       number,
                            p_user_id          in       varchar2,
                            p_err_code         out      varchar2,
                            p_err_msg          out      varchar2 )  ;

 PROCEDURE xxpm_approval_upd_response(
    p_func_id    IN NUMBER,
    p_ref_id     IN NUMBER, -- pk of respective function
    p_table_name IN VARCHAR2,
    p_err_code OUT VARCHAR2,
    p_err_msg OUT VARCHAR2)  ;  

function getOtherCharge_amt(p_offer_id in number,p_type in varchar2)
return number;

PROCEDURE XXPM_PROC_OFFER_REVISION(
    I_OFFER_ID   IN NUMBER,
    I_REVISED_BY IN VARCHAR2);

END XXPM_PRISM;
