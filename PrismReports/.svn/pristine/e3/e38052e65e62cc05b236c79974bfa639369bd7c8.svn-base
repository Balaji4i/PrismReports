CREATE OR REPLACE PACKAGE "XXPM_BOOKING_DASHBOARD"
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
/


CREATE OR REPLACE PACKAGE BODY  "XXPM_BOOKING_DASHBOARD"
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
                                )
as
l_offer_id NUMBER:=OFFER_HDR_ID_S.nextval;
l_offer_number varchar2(60):=to_char(sysdate, 'DDMONYY')||'-'||l_offer_id;
l_offer_date date:=sysdate;
l_org_id number;
l_project_id number;
l_property_id number;
l_building_id number;
l_uom varchar2(60);
l_base_price number;
l_min_price number;
l_pl_amount number;

CURSOR MSDTL (l_MS_ID number)
is 
SELECT 
MS_DTL_ID, 
SEQ_NUMBER, 
INSTALLMENT_TYPE, 
INSTALLMENT_PCT, 
CHARGE_TYPE, 
PAYMENT_TERM, 
REMARKS, 
DUE_DAYS, 
DUE_DAYS_FROM, 
DUE_DATE, 
INSTALLMENT_METHOD,
INSTALLMENT_EVENT,
PERIOD_OCCURENCE,
PERIOD_VALUES, 
PERIOD_DURATION
FROM xxpm_milestone_dtl
WHERE MS_HDR_ID=l_MS_ID;

BEGIN
--get master record
SELECT 
pm.ORG_ID, 
pm.PROJECT_ID,
pu.PROPERTY_ID, 
pu.BUILD_ID,
pu.UOM
into 
l_org_id ,
l_project_id ,
l_property_id ,
l_building_id,
l_uom
FROM 
xxpm_property_units pu, xxpm_property_master pm
where 
pm.PROPERTY_ID=pu.PROPERTY_ID
and UNIT_ID=P_UNIT;
DBMS_OUTPUT.put_line('l_org_id==>'||l_org_id);
DBMS_OUTPUT.put_line('l_project_id==>'||l_project_id);
DBMS_OUTPUT.put_line('l_property_id==>'||l_property_id);
DBMS_OUTPUT.put_line('l_building_id==>'||l_building_id);
DBMS_OUTPUT.put_line('l_uom==>'||l_uom);
---end-----
--Get PL Amount-----
begin

SELECT 
BASE_PRICE, 
MIN_PRICE,
PL_AMOUNT
into
l_base_price
,l_min_price
,l_pl_amount
FROM XXPM_PL_LINES 
where 
PL_ID=P_PL_HDR_ID
and PROPERTY_ID=l_property_id
and BUILD_ID=l_building_id
and UNIT_ID=P_UNIT;
EXCEPTION 
when no_data_found then
l_base_price:=null;
l_min_price:=null;
l_pl_amount:=null;
end;
DBMS_OUTPUT.put_line('l_base_price==>'||l_base_price);
DBMS_OUTPUT.put_line('l_min_price==>'||l_min_price);
DBMS_OUTPUT.put_line('l_pl_amount==>'||l_pl_amount);
---end-----
-- inserting offer headers
if l_base_price is not null and l_pl_amount is not null then
insert into xxpm_offer_header(
 OFFER_HDR_ID
,OFFER_NUMBER 
,OFFER_DATE 
,CUSTOMER_ID 
,CUST_SITE_ID
,ORG_ID 
,FUNC_ID 
,MS_HDR_ID 
,PL_ID 
,OFFER_FLAG 
,CURRENCY_CODE 
,STATUS 
,USAGE
,CREATED_BY 
,CREATION_DATE 
,LAST_UPDATED_BY 
,LAST_UPDATE_DATE 
,LAST_UPDATE_LOGIN
,PROPERTY_ID
)
values
(
l_offer_id
,l_offer_number
,l_offer_date
,P_CUST_ID
,P_CUST_SITE_ID
,l_org_id
,6
,P_MS_HDR_ID
,P_PL_HDR_ID
,'N'
,'AED'
,'DRA'
,'S'
,P_LOGIN_USER
,SYSDATE
,P_LOGIN_USER
,SYSDATE
,P_LOGIN_USER
,l_property_id
);
dbms_output.put_line('===HDR-===Inserted');
--INSERTING LINE
insert into xxpm_offer_detail(
OFFER_DTL_ID, 
OFFER_HDR_ID, 
PROPERTY_ID, 
BUILDING_ID, 
UNIT_ID, 
UOM, 
BASE_RATE, 
OFFER_AMOUNT, 
TAX_CODE, 
CREATED_BY, 
CREATION_DATE, 
LAST_UPDATED_BY, 
LAST_UPDATE_DATE, 
LAST_UPDATE_LOGIN
)
values
(
OFFER_DTL_ID_S.nextval
,l_offer_id
,l_property_id
,l_building_id
,P_UNIT
,l_uom
,l_base_price
,l_pl_amount
,p_TAX_CODE
,P_LOGIN_USER
,SYSDATE
,P_LOGIN_USER
,SYSDATE
,P_LOGIN_USER
);
dbms_output.put_line('===linE-===Inserted');
begin
for c1 in MSDTL(P_MS_HDR_ID)
loop 
insert into xxpm_offer_milestone_detail (
OFFER_MS_DTL_ID, 
OFFER_HDR_ID, 
MS_DTL_ID, 
SEQ_NUMBER, 
INSTALLMENT_TYPE, 
INSTALLMENT_PCT, 
CHARGE_TYPE, 
PAYMENT_TERM, 
REMARKS, 
DUE_DAYS, 
DUE_DAYS_FROM, 
DUE_DATE, 
MILESTONE_TYPE,
UOM,
WAVE_OFF,
INSTALLMENT_METHOD,
INSTALLMENT_EVENT,
PERIOD_OCCURENCE,
PERIOD_VALUES, 
PERIOD_DURATION, 
CREATED_BY, 
CREATION_DATE, 
LAST_UPDATED_BY, 
LAST_UPDATE_DATE, 
LAST_UPDATE_LOGIN 
)
values(
OFFER_MS_DTL_ID.nextval
,l_offer_id
,c1.MS_DTL_ID
,c1.SEQ_NUMBER
,c1.INSTALLMENT_TYPE 
,c1.INSTALLMENT_PCT 
,c1.CHARGE_TYPE
,c1.PAYMENT_TERM 
,c1.REMARKS 
,c1.DUE_DAYS 
,c1.DUE_DAYS_FROM 
,c1.DUE_DATE
,'MS'
,l_uom
,'N'
,c1.INSTALLMENT_METHOD
,c1.INSTALLMENT_EVENT
,c1.PERIOD_OCCURENCE
,c1.PERIOD_VALUES
,c1.PERIOD_DURATION
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
);
P_OFFER_ID:=l_offer_id;
end loop;
end;
commit;
else 
P_OFFER_ID:=0;
end if;
END XXPM_DASHBOARD_OFFER;

-------------Receipt
procedure XXPM_DASHBOARD_RECEIPT(
                                P_INVOICE 	        IN NUMBER,
                                P_BOOKING_ID        IN NUMBER,
                                P_TOAL_INV_AMT      IN NUMBER,
                                P_LOGIN_USER        IN varchar2,
                                P_RECEIPT_Id       OUT NUMBER
                                )
as
l_RECEIPT_ID NUMBER;
l_FUNC_ID NUMBER;
l_RECEIPT_NUMBER varchar2(30);
--l_SOURCE_FUNC_ID NUMBER;
--l_SOURCE_FUNC_REF_ID NUMBER;
l_RECEIPT_DATE DATE;
l_RECEIPT_DTL_ID number;

BEGIN
l_RECEIPT_ID:=XXPM_RECEIPT_ID_S.NEXTVAL;
l_FUNC_ID:=9;
l_RECEIPT_NUMBER:='RT-'||l_RECEIPT_ID||to_char(sysdate, 'MONddyy');
l_RECEIPT_DATE:=sysdate;
l_RECEIPT_DTL_ID:=RECEIPT_DTL_ID_S.nextval;

--dbms_output.put_line('l_RECEIPT_ID-->'||l_RECEIPT_ID);
--dbms_output.put_line('l_FUNC_ID-->'||l_FUNC_ID);
--dbms_output.put_line('l_RECEIPT_NUMBER-->'||l_RECEIPT_NUMBER);
--dbms_output.put_line('l_RECEIPT_DATE->'||l_RECEIPT_DATE);
--dbms_output.put_line('l_RECEIPT_DTL_ID->'||l_RECEIPT_DTL_ID);
INSERT INTO xxpm_receipt
(
    RECEIPT_ID,
    FUNC_ID,
    RECEIPT_NUMBER,
    RECEIPT_DATE,
    SOURCE_FUNC_ID,
    SOURCE_FUNC_REF_ID,  
    ORG_ID,
    PROPERTY_ID,
    UNIT_ID,
    BUILD_ID,
    CUST_ID,
    CUST_SITE_ID,
    CUSTOMER_NAME,
    CURRENCY_CODE,
    RECEIPT_TYPE,
    INTERFACE_STATUS,
    CREATED_BY,
    CREATION_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN,
    RECOMMENDED_AMOUNT

)
(
SELECT 
 l_RECEIPT_ID
,l_FUNC_ID
,l_RECEIPT_NUMBER
,l_RECEIPT_DATE
,BH.FUNC_ID
,BH.BOOKING_HDR_ID
,BH.ORG_ID
,BD.PROPERTY_ID
,BD.UNIT_ID
,BD.BUILDING_ID
,inv.CUST_ID
,inv.CUST_SITE_ID
,cus.CUSTOMER_NAME
,BH.CURRENCY_CODE
,BM.CHARGE_TYPE
,'Draft'
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,P_TOAL_INV_AMT
FROM 
xxpm_booking_milestones BM, xxpm_booking_header BH, xxpm_booking_detail BD, xxpm_invoice_header inv, xxstg_customer cus
WHERE 
BH.BOOKING_HDR_ID=BM.BOOKING_HDR_ID
AND BD.BOOKING_HDR_ID=BH.BOOKING_HDR_ID
and inv.INVOICE_ID=BM.INVOICE_ID
and BH.BOOKING_HDR_ID=inv.BOOKING_ID
and cus.CUST_ID=inv.CUST_ID
AND BM.INVOICE_ID=P_INVOICE);
--insert line
insert into xxpm_receipt_details
(
RECEIPT_DTL_ID,
RECEIPT_ID    ,
BOOKING_MS_DTL_ID,
INVOICE_ID       ,
INTERFACE_STATUS ,
CREATED_BY       ,
CREATION_DATE    ,
LAST_UPDATED_BY ,
LAST_UPDATE_DATE ,
LAST_UPDATE_LOGIN
)
(SELECT 
l_RECEIPT_DTL_ID
,l_RECEIPT_ID
,BOOKING_MS_DTL_ID 
,invoice_id
,'Draft'
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
FROM 
xxpm_booking_milestones 
where invoice_id=P_INVOICE);
commit;
P_RECEIPT_Id:=l_RECEIPT_ID;
END XXPM_DASHBOARD_RECEIPT;

-------------Billing
procedure XXPM_DASHBOARD_BILLING(
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
END XXPM_DASHBOARD_BILLING;


END XXPM_BOOKING_DASHBOARD;
/
