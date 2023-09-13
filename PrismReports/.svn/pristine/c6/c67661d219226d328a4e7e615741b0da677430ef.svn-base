create or replace procedure XXPM_DASHBOARD_BILLING(
                                P_BOOKING_MS_DTL_ID 	IN NUMBER,
                                P_LOGIN_USER        in varchar2,
                                P_Billing_Id       out NUMBER
                                )
as
l_org_id    number;
l_PROJ_ID   number;
l_BOOKING_MS_DTL_ID number;
l_BOOKING_HDR_ID    number;
l_bill_id   number;
l_bill_fun_id   number;
BEGIN

begin
Select 
bh.org_id, 
pro.PROJ_ID,
bms.BOOKING_MS_DTL_ID,
bh.BOOKING_HDR_ID
into 
l_org_id,
l_PROJ_ID,
l_BOOKING_MS_DTL_ID,
l_BOOKING_HDR_ID
from xxpm_booking_header bh, xxstg_projects pro, xxpm_booking_milestones bms
where 
pro.ORG_ID=bh.ORG_ID
and bh.BOOKING_HDR_ID=bms.BOOKING_HDR_ID
and bms.BOOKING_MS_DTL_ID=P_BOOKING_MS_DTL_ID;
EXCEPTION
  WHEN no_data_found THEN
    l_org_id := null;
    l_PROJ_ID:=null;
end;
dbms_output.put_line('l_org_id==>'||l_org_id);
dbms_output.put_line('l_PROJ_ID==>'||l_PROJ_ID);
dbms_output.put_line('l_BOOKING_MS_DTL_ID==>'||l_BOOKING_MS_DTL_ID);
dbms_output.put_line('l_BOOKING_HDR_ID==>'||l_BOOKING_HDR_ID);

if(l_org_id is not null and  l_PROJ_ID is not  null) then
dbms_output.put_line('insert Start==>');
l_bill_id:=XXPM_BILLING_S.nextval;
l_bill_fun_id:=20;
INSERT INTO xxpm_billing
(BILLING_ID               
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
'DRA',
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
begin
update xxpm_booking_milestones
set 
SOURCE_FUNC_ID=7,
SOURCE_FUNC_REF_ID=l_BOOKING_HDR_ID,
BILLING_ID=l_bill_id,
LAST_UPDATED_BY=P_LOGIN_USER,
LAST_UPDATE_LOGIN=P_LOGIN_USER,
LAST_UPDATE_DATE=sysdate
where 
BOOKING_HDR_ID=l_BOOKING_HDR_ID
and BOOKING_MS_DTL_ID=P_BOOKING_MS_DTL_ID;
end;
P_Billing_Id:=l_bill_id;
--P_Billing_Id:=0;
COMMIT;
end if;


END;