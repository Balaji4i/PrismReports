--------------------------------------------------------
--  DDL for Package XX_TEST_REST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XX_TEST_REST" 
IS

      
PROCEDURE GET_FILTER_DATA(P_CONT_ID VARCHAR2);   


 --Apex
-- DECLARE
--P_PROJECT_NAME VARCHAR2(500);
--BEGIN
--XX_TEST_REST.GET_REPORT_VALUES(:P_PROJECT_NAME);
--END;
      

 procedure submit_approval_pcs (p_func_id                 in          number,
                              p_ref_id                   in          number, -- pk of respective function 
                              p_level_no                 in          number,
                              p_table_name               in          varchar2,
                              p_status_column            in          varchar2,
                              p_pk_column                in          varchar2,
                              p_amount                   in          number,
                              p_attribute1               in          varchar2,
                              p_attribute2               in          varchar2,
                              p_attribute3               in          varchar2,
                              p_attribute4               in          varchar2,
                              p_attribute5               in          varchar2) ; 
 


procedure get_DynamicData(p_column_name       in varchar2,
                   p_table_name        in varchar2,
                   p_where_condtion    in varchar2,
                   p_value             in varchar2);
 
 

      
END XX_TEST_REST;



--------------------------------------------------------
--  DDL for Package Body XX_TEST_REST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XX_TEST_REST" 
IS
PROCEDURE GET_FILTER_DATA(P_CONT_ID VARCHAR2)
IS
l_cursor sys_refcursor;

BEGIN

open l_cursor for


SELECT S_NO,
  MS_HDR_ID,
  PAYMENT_PLAN,
  PAYMENT_PLAN_SHORT_CODE,
  REVISION_NO,
  REVISED_BY,
  REVISION_DATE,
  BUSINESS_UNIT,
  START_DATE,
  END_DATE,
  PAYMENT_PLAN_DATE,
  DESCRIPTION,
  INSTALLMENT_TYPE,
  INSTALLMENT_PERCENTAGE,
  CHARGE_TYPE,
  PAYMENT_TERM,
  INSTALLMENT_METHOD,
  INSTALLMENT_EVENT,
  PROJ_MS_ID,
  PROJECT_START_DATE,
  PROJECT_END_DATE,
  PERIOD_OCCURANCE,
  PERIOD_DURATION,
  PERIOD_VALUES,
  DUE_DAYS,
  DUE_DATE,
  REMARKS
FROM XXPM_MILESTONE_PCS_V
WHERE MS_HDR_ID = P_CONT_ID;
--SELECT S_NO , MS_HDR_ID , PAYMENT_PLAN , PAYMENT_PLAN_SHORT_CODE , REVISION_NO , 
--  REVISED_BY , to_char(REVISION_DATE,'YYYY/MM/DD') as REVISION_DATE , BUSINESS_UNIT , 
--  to_char(START_DATE,'YYYY/MM/DD')as START_DATE , to_char(END_DATE,'YYYY/MM/DD') as END_DATE , 
--  to_char(PAYMENT_PLAN_DATE,'YYYY/MM/DD')as PAYMENT_PLAN_DATE , 
--  DESCRIPTION , INSTALLMENT_TYPE , INSTALLMENT_PERCENTAGE , 
--  CHARGE_TYPE , PAYMENT_TERM , INSTALLMENT_METHOD , INSTALLMENT_EVENT , 
--  PROJ_MS_ID , 
--  to_char(PROJECT_START_DATE,'YYYY/MM/DD')as PROJECT_START_DATE , 
--    to_char(PROJECT_END_DATE,'YYYY/MM/DD')as PROJECT_END_DATE , 
--  PERIOD_OCCURANCE , PERIOD_DURATION , PERIOD_VALUES , DUE_DAYS , DUE_DATE , REMARKS 
--   FROM XXPM_MILESTONE_PCS_V WHERE MS_HDR_ID =P_CONT_ID;


--SELECT MS_HDR_ID, MILESTONE_NUMBER, MILESTONE_DATE, to_char(MILESTONE_DATE,'YYYY/MM/DD') as CER_DATE 
--FROM XXPM_MILESTONE_HDR 
--where MS_HDR_ID =P_CONT_ID;

-- 2018-11-27T00:00:00Z
--  OPEN l_cursor for SELECT REPORT_PARAM_NAME,Report_Path, BI_User, BI_Password, 
--  to_char(last_update_time,'YYYY/MM/DD HH24:MI:SS') last_update_time
--  from xxfnd_soa_sync_schedule 
--  where PROJECT_NAME = P_PROJECT_NAME
--  and environment = 'TEST';
  
  APEX_JSON.open_object;
  APEX_JSON.write('GetVal', l_cursor);
  APEX_JSON.close_object;

END GET_FILTER_DATA;



PROCEDURE submit_approval_pcs(
    p_func_id       IN NUMBER,
    p_ref_id        IN NUMBER,
    p_level_no      IN NUMBER,
    p_table_name    IN VARCHAR2,
    p_status_column IN VARCHAR2,
    p_pk_column     IN VARCHAR2,
    p_amount        IN NUMBER,
    p_attribute1    IN VARCHAR2,
    p_attribute2    IN VARCHAR2,
    p_attribute3    IN VARCHAR2,
    p_attribute4    IN VARCHAR2,
    p_attribute5    IN VARCHAR2)
IS
  l_flow_status    VARCHAR2(100) := NULL;
  l_appr_id        NUMBER;
  l_status         VARCHAR2(100);
  l_flow_with      NUMBER := NULL;
  l_flow_level     NUMBER := NULL;
  l_stmt           VARCHAR2(5000);
  l_user_grp_id    NUMBER ;
--  l_user_name      VARCHAR2(100);
--  l_user_emailid   VARCHAR2(100);
  v_flow_status    VARCHAR2(240);
  v_flow_with      NUMBER;
  v_approver_name  VARCHAR2(240);
  v_approver_email VARCHAR2(240);
  v_user_grp_id    VARCHAR2(240);
  v_err_code       VARCHAR2(240);
  v_err_msg        VARCHAR2(240);
  v_level_no       NUMBER;
BEGIN
  v_level_no := p_level_no;
  xxfnd_util_pkg.submit_for_approval(p_func_id , p_ref_id , v_level_no , p_table_name , p_status_column , p_pk_column , p_amount , p_attribute1 , p_attribute2 , p_attribute3 , p_attribute4 , p_attribute5 , v_flow_status , v_flow_with , v_approver_name , v_approver_email , v_user_grp_id , v_err_code , v_err_msg );
--  v_flow_status    := l_status;
--  v_level_no       := v_level_no;
--  v_flow_with      := l_appr_id;
--  v_approver_name  := l_user_name;
--  v_approver_email := l_user_emailid;
--  v_user_grp_id    := l_user_grp_id;
  -- REST conversion
--  dbms_output.put_line('Response in pcs==>  ' || v_flow_status ||',' || v_level_no ||','||v_flow_with||','||v_approver_name||','||v_approver_email||','||v_user_grp_id) ;

  APEX_JSON.open_object;
  APEX_JSON.write('FlowStatus', v_flow_status);
  APEX_JSON.write('LevelNo', v_level_no);
  APEX_JSON.write('FlowWith', v_flow_with);
  APEX_JSON.write('ApproverName', v_approver_name);
  APEX_JSON.write('ApproverEmail', v_approver_email);
  APEX_JSON.write('UserGroupId', v_user_grp_id);
  APEX_JSON.close_object;

EXCEPTION
WHEN OTHERS THEN
  v_err_code := '1';
  v_err_msg  := SUBSTR (sqlerrm, 1, 2000);
  dbms_output.put_line('error in pcs ==>  ' || v_err_code ||' ' || v_err_msg ) ;
  
END submit_approval_pcs; 



PROCEDURE get_DynamicData(p_column_name       in varchar2,
                          p_table_name        in varchar2,
                          p_where_condtion    in varchar2,
                          p_value             in varchar2)

IS
l_cursor sys_refcursor;
l_sql    varchar2(1000);
l_value  varchar2(500);

begin

OPEN l_cursor for 'select ' || p_column_name || 
                ' from ' || p_table_name || ' where 1 = 1 ' || 
                ' and ' || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;
   
--   close  l_cursor;            
--       l_sql := 'select ' || p_column_name || 
--                ' from ' || p_table_name || ' where 1 = 1 ' || 
--                ' and ' || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;
          
--execute immediate l_sql into l_cursor;
--dbms_output.put_line('SQL-->'||p_column_name);

--
--dbms_output.put_line('l_cursor-->'||l_cursor);


 
  APEX_JSON.open_object;
  APEX_JSON.write('GetVal', l_cursor);
  APEX_JSON.close_object;

END get_DynamicData;

END XX_TEST_REST;
