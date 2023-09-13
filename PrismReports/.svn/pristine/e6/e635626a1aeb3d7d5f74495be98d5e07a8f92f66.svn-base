create or replace procedure XXPM_CREATE_AUTO_BILLING(
                                p_primary_id 	IN NUMBER,
                                p_func_id       IN VARCHAR2,
                                p_login_user 	in VARCHAR2,
                                P_ERR_MSG		OUT VARCHAR2
                                )
as
l_org_id    number;
l_PROJ_ID   number;
l_bill_id   number;
l_bill_fun_id   number;
l_BOOKING_MS_DTL_ID number;
l_P_ERROR_CODE varchar(30);
l_P_ERR_MSG varchar(30);
BEGIN
--
begin
Select 
bh.org_id, 
pro.PROJ_ID,
BOOKING_MS_DTL_ID
into 
l_org_id,
l_PROJ_ID,
l_BOOKING_MS_DTL_ID
from xxpm_booking_header bh, xxstg_projects pro, xxpm_booking_milestones bms
where 
pro.ORG_ID=bh.ORG_ID
and bh.BOOKING_HDR_ID=bms.BOOKING_HDR_ID
and bms.SOURCE_FUNC_ID =p_func_id
and bms.CHARGE_TYPE='CAN_DEB_MO'
and bms.SOURCE_FUNC_REF_ID=p_primary_id;
end;
--
dbms_output.put_line('inserted End==>'||l_org_id||'-'||l_PROJ_ID||'-'||l_BOOKING_MS_DTL_ID);
if(l_org_id is not null and l_PROJ_ID is not null)    then
l_bill_id:=XXPM_BILLING_S.nextval;
l_bill_fun_id:=20;
--create insert for billing
dbms_output.put_line('inserted Start==>');
INSERT INTO xxpm_billing
(
BILLING_ID               
,BILLING_NUMBER           
,BILLING_DATE             
,USAGE                    
,ORG_ID                   
,STATUS                   
,DESCRIPTION              
,FUNC_ID                  
,CREATED_BY               
,CREATION_DATE            
,LAST_UPDATED_BY          
,LAST_UPDATE_DATE         
,LAST_UPDATE_LOGIN        
,PROJECT_ID )
VALUES
(
l_bill_id,
'BL-'||l_bill_id,
sysdate,
'S',
l_org_id,
'APR',
'Billing for Credit memo against the milestone',
l_bill_fun_id,
P_LOGIN_USER,
systimestamp,
P_LOGIN_USER,
systimestamp,
P_LOGIN_USER,
l_proj_id
);
COMMIT;
dbms_output.put_line('inserted End==>');
--updating billing in booking milestone
begin
update xxpm_booking_milestones
set BILLING_ID=l_bill_id
where 
SOURCE_FUNC_ID =p_func_id
and SOURCE_FUNC_REF_ID=p_primary_id
and CHARGE_TYPE='CAN_DEB_MO';
end;
commit;
dbms_output.put_line('Booking Ms Updated==>');
begin
dbms_output.put_line('Billing-->ms_id.booking_ms_dtl_id->'||l_BOOKING_MS_DTL_ID);
xxpm_bill_invoice_pkg.ms_based_invoice (l_BOOKING_MS_DTL_ID, l_P_ERROR_CODE,l_P_ERR_MSG);
dbms_output.put_line('Billing to invoice--P_ERROR_CODE->'||l_P_ERROR_CODE);
dbms_output.put_line('PKG--P_ERR_MSG->'||P_ERR_MSG);
EXCEPTION
  WHEN no_data_found THEN
    l_P_ERROR_CODE := SQLCODE ;
    l_P_ERR_MSG :='Error billing to invoice'|| '-' || SQLERRM;
    DBMS_OUTPUT.PUT_LINE('exception no data found   ');
end;
--P_ERR_MSG:='Y';
end if;
END;