--------------------------------------------------------
--  DDL for Package XXFND_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXFND_PKG" is

--==============================================================================
--                             User Management Package 
--==============================================================================
--
-- file name    : xxfnd_pkh.sql
-- author       : navu k  - 4i apps
-- date         : 01-may-2018 
--
-- description : Package for User Management FND 
--
-- change record:
-- =============
-- version    date             author(s)           remarks
-- ========   ============     ===============     ============
-- ver1.0     01-may-2018      navu k              created
--
--==============================================================================

type apr_rec is record (level_no            number,
                        flow_status         varchar2(60),
                        appr_id             number,
                        appr_role           varchar2(30) ) ;

type apr_tab is table of apr_rec
     index by binary_integer ; 


function needs_approval(p_func_id        in          number,
                        p_ref_id         in          number, -- PK of respective function 
                        p_appr_id        in          number ) 
         return boolean ;

procedure get_next_number(p_func_code      in       varchar2,
                          p_next_num       out      varchar2,
                          p_func_id        out      number,
                          p_err_code       out      varchar2,
                          p_err_msg        out      varchar2 ) ;


function get_profile_value(p_profile_name   in       varchar2) return varchar2 ;


function get_lookup_value(p_lookup_type   in       varchar2,
                          p_lookup_value  in       varchar2) return varchar2 ;



procedure insert_appr_hist(p_func_id        in          number,
                           p_ref_id         in          number, -- PK of respective function 
                           p_level_no       in          number,
                           p_appr_id        in          number,
                           p_appr_role      in          varchar2,
                           p_err_code       out         varchar2,
                           p_err_msg        out         varchar2 ) ;

procedure update_appr_hist(p_func_id        in          number,
                          p_ref_id         in          number, -- PK of respective function 
                          p_level_no       in          number,
                          p_appr_id        in          number,
                          p_response       in          varchar2,
                          p_status         in          varchar2,
                          p_err_code       out         varchar2,
                          p_err_msg        out         varchar2 ) ;

procedure submit_for_approval(p_func_id        in          number,
                              p_ref_id         in          number, -- PK of respective function 
                              p_level_no       in out      number,
                              p_flow_status    out         varchar2,
                              p_appr_id        out         number,
                              p_err_code       out         varchar2,
                              p_err_msg        out         varchar2 )  ;

procedure update_response(p_func_id        in          number,
                          p_ref_id         in          number, -- PK of respective function 
                          p_level_no       in out      number,
                          p_appr_id        in out      number,
                          p_response       in          varchar2,
                          p_status         in          varchar2,
                          p_fwd_to         in          number,
                          p_flow_status    out         varchar2,
                          p_err_code       out         varchar2,
                          p_err_msg        out         varchar2 ) ;                                                                                                


end xxfnd_pkg;
