create or replace procedure XXPM_DASHBOARD_OFFER(
                                P_UNIT 	       IN NUMBER,
                                P_MS_HDR_ID    IN varchar2,
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
END;