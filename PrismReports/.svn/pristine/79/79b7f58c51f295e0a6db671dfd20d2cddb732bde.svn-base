--------------------------------------------------------
--  DDL for Package Body XXPM_AREA_CHANGE_PROCESS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_AREA_CHANGE_PROCESS" 
as

PROCEDURE XXPM_AREA_CHANGE_CALC(
                           p_old_area in number,
                           p_new_area in number,
                           p_bookinghdr in number,
                           p_unit_id  in number,
                           p_tolerance in number,
                           p_login_user in varchar2,
                           p_old_booking in number,
                           p_type out varchar2,
                           p_new_booking out number,
                           p_amount_differ out number
                           )
AS

l_tolerance_per number;
l_agreedVariation number;
l_areaVariation number;
l_count number;
p_PROPERTY_ID number;
p_BUILD_ID number;
l_flag varchar2(2);
l_range_diff number;
l_type varchar2(30):='NO_PROCESS';
l_baseprice number;
l_amountdiffern number;
l_newbookingAmt number;
l_total number;
l_selling number;
l_perSF number;
BEGIN
select 
PROPERTY_ID, BUILD_ID 
into
p_PROPERTY_ID, p_BUILD_ID 
from xxpm_property_area
where AREA='CHARGE'
and UNIT_ID=p_unit_id;
-- get Selling price/perSF
SELECT 
--bd.BOOKING_DTL_ID, bd.BOOKING_HDR_ID, 
--bd.PROPERTY_ID, bd.BUILDING_ID, 
--bd.UNIT_ID, bd.BOOKING_RATE, 
--bd.BOOKING_AMOUNT, bd.DISC_AMOUNT, 
--pa.VALUE,
NVL(bd.BOOKING_AMOUNT,0)-NVL(bd.DISC_AMOUNT,0) as tot,
round(((NVL(bd.BOOKING_AMOUNT,0)-NVL(bd.DISC_AMOUNT,0))/NVL(pa.VALUE,0)),2)as sellingprice
into 
--l_perSF, 
l_total, l_selling
FROM 
xxpm_booking_detail bd, xxpm_property_area pa
where 
pa.PROPERTY_ID=bd.PROPERTY_ID
and pa.BUILD_ID=bd.BUILDING_ID
and pa.UNIT_ID=bd.UNIT_ID
--and acd.area_cng_hdr_id=22
and bd.BOOKING_HDR_ID=p_bookinghdr
and pa.UNIT_ID=p_unit_id;
---
SELECT BOOKING_RATE 
INTO l_baseprice
FROM xxpm_booking_detail WHERE BOOKING_HDR_ID=p_bookinghdr AND UNIT_ID=p_unit_id;
DBMS_OUTPUT.PUT_LINE('l_baseprice'||l_baseprice);
--Area Variation different
l_areaVariation:=p_new_area-p_old_area;
--checking tolerance
l_agreedVariation:=((p_tolerance)*(p_old_area/100));
DBMS_OUTPUT.PUT_LINE('l_agreedVariation==>:'||l_agreedVariation);
DBMS_OUTPUT.PUT_LINE('l_areaVariation==>:'||l_areaVariation);

begin
if l_areaVariation between -l_agreedVariation and +l_agreedVariation then
DBMS_OUTPUT.PUT_LINE('==IN Ranger==>');
--l_flag:=xxpm_update_unit_area(p_PROPERTY_ID, p_BUILD_ID, p_UNIT_ID,p_new_area,l_areaVariation);
else
DBMS_OUTPUT.PUT_LINE('==OUT Ranger==>');
l_range_diff:=l_areaVariation-l_agreedVariation;
DBMS_OUTPUT.PUT_LINE('l_range_diff'||l_range_diff);
--l_flag:=xxpm_update_unit_area(p_PROPERTY_ID, p_BUILD_ID, p_UNIT_ID,p_new_area,l_areaVariation);
    DBMS_OUTPUT.PUT_LINE('p_old_area'||p_old_area);
    DBMS_OUTPUT.PUT_LINE('p_new_area'||p_new_area);
    if p_old_area<p_new_area then
    DBMS_OUTPUT.PUT_LINE('invoice');
    l_type:='CREATE_INVOICE';
    l_amountdiffern:=l_selling*l_range_diff;
    else
    DBMS_OUTPUT.PUT_LINE('debit memo');
    l_type:='CREATE_CREDIT';
    l_amountdiffern:=l_selling*l_range_diff;
    end if;
end if;
DBMS_OUTPUT.PUT_LINE('l_amountdiffern-->'||l_amountdiffern);

update xxpm_booking_header
set AREA_VARIATION_PCT=p_tolerance
where BOOKING_HDR_ID=p_bookinghdr;

DBMS_OUTPUT.PUT_LINE('l_flag==>:'||l_flag);
--l_newbookingAmt:=l_amountdiffern+p_old_booking;
p_new_booking:=round((NVL(l_amountdiffern,0)+p_old_booking),2);
p_type:=l_type;
p_amount_differ:=round(NVL(l_amountdiffern,0),2);
commit;
end;
END XXPM_AREA_CHANGE_CALC;

--**************************************

FUNCTION xxpm_update_unit_area (
                        p_property_id       IN             NUMBER,
                        p_build_id          IN             NUMBER,
                        p_unitid            IN             number,
                        p_new_area          IN             NUMBER, 
                        p_valuediff         IN             number
                        )
return varchar2
as
p_status VARCHAR2(1):='Y';
l_tot_property number;
l_tot_sum_building number;
l_cur_building_sum number;
l_cur_unit_sum  number;
l_overall_cur_unitSum number;
l_overall_building number;
l_overall_property number;
BEGIN
begin
--Property
SELECT 
VALUE
into l_tot_property
FROM 
xxpm_property_area 
where build_id is null and unit_id is null and PROPERTY_ID=p_property_id;
DBMS_OUTPUT.put_line('l_tot_property-->'||l_tot_property);
----
--Sum of building
SELECT 
sum(VALUE)
into l_tot_sum_building
FROM 
xxpm_property_area 
where AREA='CHARGE' and build_id is not null and unit_id is null and PROPERTY_ID=p_property_id;
DBMS_OUTPUT.put_line('l_tot_sum_building-->'||l_tot_sum_building);
-----current building 
SELECT 
sum(VALUE)
into l_cur_building_sum
FROM 
xxpm_property_area 
where AREA='CHARGE' and build_id=p_build_id and unit_id is null and PROPERTY_ID=p_property_id; 
DBMS_OUTPUT.put_line('l_cur_building_sum-->'||l_cur_building_sum);
---
SELECT 
sum(VALUE)
into l_cur_unit_sum
FROM 
xxpm_property_area 
where AREA='CHARGE' and build_id=p_build_id and unit_id is not null and PROPERTY_ID=p_property_id; 
DBMS_OUTPUT.put_line('l_cur_unit_sum-->'||l_cur_unit_sum);
l_overall_cur_unitSum:=l_cur_unit_sum+p_valuediff;
l_overall_building:=l_cur_building_sum+p_valuediff;
l_overall_property:=l_tot_property+p_valuediff;

DBMS_OUTPUT.put_line('l_overall_cur_unitSum-->'||l_overall_cur_unitSum);
DBMS_OUTPUT.put_line('l_overall_building-->'||l_overall_building);
if(l_overall_cur_unitSum>l_cur_building_sum) then
        DBMS_OUTPUT.put_line('--area outside the building v1--');
        DBMS_OUTPUT.put_line('--Property Update--');
                    update xxpm_property_area
                    set VALUE=l_overall_property
                    where 
                    AREA='CHARGE' 
                    and build_id is null 
                    and unit_id is null 
                    and PROPERTY_ID=p_property_id;    
        DBMS_OUTPUT.put_line('--building update--');
                    update xxpm_property_area
                    set VALUE=l_overall_building
                    where 
                    AREA='CHARGE'
                    and unit_id is null
                    and build_id=p_build_id;
        DBMS_OUTPUT.put_line('--unit  update--');         
                  update xxpm_property_area
                  set VALUE=p_new_area
                  where 
                  AREA='CHARGE'
                  and unit_id=p_unitid;   
else
    DBMS_OUTPUT.put_line('--area inside the building 2--');
    update xxpm_property_area
    set VALUE=p_new_area
    where 
    AREA='CHARGE'
    and unit_id=p_unitid;
commit;
end if;
end;
return p_status;
END xxpm_update_unit_area;
--***************************************

PROCEDURE XXPM_AREA_CHANGE_SUBMIT(
                                  p_area_change_Id in number,
                                  p_flag out varchar2
                                  ) 
as
CURSOR getAreaDtl(l_area_id number)
is
SELECT
    area_cng_dlt_id,
    area_cng_hdr_id,
    property_id,
    build_id,
    unit_id,
    unit_status,
    area_id,
    area_type,
    uom,
    old_area_value,
    new_area_value,
    booking_hdr_id,
    area_variation_pct,
    old_booking_amount,
    new_booking_amount,
    adj_booking_amount,
    status,
    attribute1,
    payment_term,
    CREATED_BY,
    CUST_ACCEPTED_YN,
    nvl(negotiable, adj_booking_amount)as negotiable
FROM
    xxpm_area_change_dlt
WHERE
    area_cng_hdr_id = l_area_id;

l_area_id       number;
l_seq_number    number := 0;
l_msdtl_id      number;
l_UOM             varchar2(60); 
l_TAX_CODE        varchar2(60); 
l_TAX_RATE        number; 
l_TAX_AMOUNT      number;
l_base_amount     number;
l_org_id           number;
l_PROJ_ID           number;
l_bill_id       number;
l_bill_fun_id   number;
l_P_ERROR_CODE  varchar2(60);
l_P_ERR_MSG varchar2(60);
l_areaVariation number;
l_agreedVariation number;
l_flag varchar2(60);
l_range_diff number;
begin 
for c1 in getAreaDtl(p_area_change_Id)
loop
-- check count
begin
SELECT
    COUNT(*) into l_seq_number
FROM
xxpm_booking_milestones where booking_hdr_id =c1.booking_hdr_id;
exception
WHEN NO_DATA_FOUND THEN
l_seq_number:=0;
end;
-- check tax
begin
select 
UOM, TAX_CODE, TAX_RATE, TAX_AMOUNT
into
l_UOM, l_TAX_CODE,l_TAX_RATE,l_TAX_AMOUNT
from xxpm_booking_detail
where booking_hdr_id=c1.booking_hdr_id;
exception
WHEN NO_DATA_FOUND THEN
l_UOM   :=null; 
l_TAX_CODE :=null;
l_TAX_RATE :=null;
l_TAX_AMOUNT :=null;
end;
-- check next sequences
l_msdtl_id:=XXPM_BOOKING_MILESTONES_S.nextval;
-- check if condition
if(c1.CUST_ACCEPTED_YN='Y') then
if(c1.ATTRIBUTE1='CREATE_INVOICE') then
l_base_amount:=GET_LINE_AMT(c1.adj_booking_amount, l_TAX_CODE,l_TAX_RATE);
l_TAX_AMOUNT:=GET_TAX_AMT(c1.adj_booking_amount,l_TAX_CODE,l_TAX_RATE);
INSERT INTO xxpm_booking_milestones (
    booking_ms_dtl_id,
    milestone_type,
    seq_number,
    installment_amount,
    uom,
    quantity,
    rate,
    charge_type,
    payment_term,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    source_func_id,
    source_func_ref_id,
    booking_hdr_id,
    baseamount,
    tax_rate,
    tax_code,
    tax_amount
) VALUES (
    l_msdtl_id,
    'AC_CHG',
    l_seq_number,
    c1.adj_booking_amount,
    l_UOM,
    1,
    c1.negotiable,    
--    c1.adj_booking_amount,
    'AC_CHG',
    5,
    c1.CREATED_BY,
    sysdate,
    c1.CREATED_BY,
    sysdate,
    c1.CREATED_BY,
    54,
    p_area_change_Id,
    c1.booking_hdr_id,
    l_base_amount,
    l_TAX_RATE,
    l_TAX_CODE,
    l_TAX_AMOUNT
);
DBMS_OUTPUT.put_line('---Invoice');
elsif(c1.ATTRIBUTE1='CREATE_CREDIT') then
l_base_amount:=GET_LINE_AMT(c1.adj_booking_amount, l_TAX_CODE,l_TAX_RATE);
l_TAX_AMOUNT:=GET_TAX_AMT(c1.adj_booking_amount,l_TAX_CODE,l_TAX_RATE);
INSERT INTO xxpm_booking_milestones (
    booking_ms_dtl_id,
    milestone_type,
    seq_number,
    installment_amount,
    charge_type,
    payment_term,
    remarks,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    source_func_id,
    source_func_ref_id,
    booking_hdr_id,
    baseamount,
    tax_rate,
    tax_code,
    tax_amount
) VALUES (
    l_msdtl_id,
    'AC_CHG',
    l_seq_number,
    (-1*c1.negotiable) ,   
--    (-1*c1.adj_booking_amount),-- credit memo amount
    'CMC',
    '5',
    'For Credit memo amount:'||c1.adj_booking_amount,
    c1.CREATED_BY,
    sysdate,
    c1.CREATED_BY,
    sysdate,
    c1.CREATED_BY,    
    54,
    p_area_change_Id,
    c1.booking_hdr_id,
    l_base_amount,
    l_TAX_RATE,
    l_TAX_CODE,
    l_TAX_AMOUNT
);
commit;
DBMS_OUTPUT.put_line('---CMC');
begin
Select 
bh.org_id, 
pro.PROJ_ID
into 
l_org_id,
l_PROJ_ID
from xxpm_booking_header bh, xxstg_projects pro, xxpm_booking_milestones bms
where 
pro.ORG_ID=bh.ORG_ID and 
bh.BOOKING_HDR_ID=bms.BOOKING_HDR_ID
and bms.CHARGE_TYPE='CMC'
and bms.milestone_type='AC_CHG'
and bms.BOOKING_HDR_ID=c1.booking_hdr_id;
exception when others then
p_flag:='E';
end;
DBMS_OUTPUT.put_line('---IN--');
    dbms_output.put_line('inserted End==>'||l_org_id||'-'||l_PROJ_ID||'-'||l_msdtl_id);
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
    'Billing for Credit memo against the area change',
    l_bill_fun_id,
    c1.CREATED_BY,
    systimestamp,
    c1.CREATED_BY,
    systimestamp,
    c1.CREATED_BY,
    l_proj_id
    );
    COMMIT;
    dbms_output.put_line('inserted End==>');
    --updating billing in booking milestone
    begin
    update xxpm_booking_milestones
    set BILLING_ID=l_bill_id
    where 
    booking_ms_dtl_id =l_msdtl_id;
    end;
    commit;
    dbms_output.put_line('Booking Ms Updated==>');
    begin
    dbms_output.put_line('Billing-->ms_id.booking_ms_dtl_id->'||l_msdtl_id);
    xxpm_bill_invoice_pkg.ms_based_invoice (l_msdtl_id, l_P_ERROR_CODE,l_P_ERR_MSG);
    dbms_output.put_line('Billing to invoice--P_ERROR_CODE->'||l_P_ERROR_CODE);
    EXCEPTION
      WHEN no_data_found THEN
        l_P_ERROR_CODE := SQLCODE ;
        l_P_ERR_MSG :='Error billing to invoice'|| '-' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE('exception no data found   ');
    end;
    --P_ERR_MSG:='Y';
    end if;
end if;
--Area Variation different
l_areaVariation:=c1.new_area_value-c1.old_area_value;
--checking tolerance
l_agreedVariation:=((c1.area_variation_pct)*(c1.old_area_value/100));
DBMS_OUTPUT.PUT_LINE('l_agreedVariation==>:'||l_agreedVariation);
DBMS_OUTPUT.PUT_LINE('l_areaVariation==>:'||l_areaVariation);

if l_areaVariation between -l_agreedVariation and +l_agreedVariation then
DBMS_OUTPUT.PUT_LINE('==IN Ranger==>');
l_flag:=XXPM_AREA_CHANGE_PROCESS.xxpm_update_unit_area(c1.property_id, c1.build_id, c1.unit_id,c1.new_area_value,l_areaVariation);
XXPM_ACTIVITY_PKG.XXPM_PROC_ACTIVITY(54,c1.area_cng_hdr_id,l_org_id,c1.property_id,c1.build_id,c1.unit_id,'ACSB','Area Change new value:'||c1.new_area_value,c1.CREATED_BY);
else
DBMS_OUTPUT.PUT_LINE('==OUT Ranger==>');
l_range_diff:=l_areaVariation-l_agreedVariation;
DBMS_OUTPUT.PUT_LINE('l_range_diff'||l_range_diff);
l_flag:=XXPM_AREA_CHANGE_PROCESS.xxpm_update_unit_area(c1.property_id, c1.build_id, c1.unit_id,c1.new_area_value,l_areaVariation);
XXPM_ACTIVITY_PKG.XXPM_PROC_ACTIVITY(54,c1.area_cng_hdr_id,l_org_id,c1.property_id,c1.build_id,c1.unit_id,'ACSB','Area Change new value:'||c1.new_area_value,c1.CREATED_BY);
--    DBMS_OUTPUT.PUT_LINE('p_old_area'||c1.old_area_value);
--    DBMS_OUTPUT.PUT_LINE('p_new_area'||c1.new_area_value);
--    if p_old_area<p_new_area then
--    DBMS_OUTPUT.PUT_LINE('invoice');
--    l_type:='CREATE_INVOICE';
--    l_amountdiffern:=l_baseprice*l_range_diff;
--    else
--    DBMS_OUTPUT.PUT_LINE('debit memo');
--    l_type:='CREATE_CREDIT';
--    l_amountdiffern:=l_baseprice*l_range_diff;
--    end if;
end if;
commit;
end if;
-- update line status
update xxpm_area_change_dlt
set STATUS='APR'
where
area_cng_dlt_id=c1.area_cng_dlt_id
AND area_cng_hdr_id=c1.area_cng_hdr_id;
commit;
end loop;
p_flag:='S';
-- update Hdr status
update xxpm_area_change_hdr
set STATUS='APR'
where AREA_CNG_HDR_ID=p_area_change_Id;
commit;
--when exception 
--others then 
--p_flag:='N';
end XXPM_AREA_CHANGE_SUBMIT;

FUNCTION GET_LINE_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
) RETURN NUMBER AS

p_LINE_AMT  NUMBER;
l_taxper NUMBER;

BEGIN
IF p_TAX_PERC IS NOT NULL THEN
p_LINE_AMT:=p_TOTAL_SPA/(100+p_TAX_PERC)*100;
--DBMS_OUTPUT.PUT_LINE('HAVING PERCENTAGE');
ELSE

IF(p_TAX_CODE='COMMERCIAL') THEN
l_taxper:=5;
ELSIF(p_TAX_CODE='COMMERCIAL EXEMPT') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL EXEMPT')THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='STANDARD RATE') THEN
l_taxper:=5;
else 
l_taxper:=0;
END IF;

p_LINE_AMT:=p_TOTAL_SPA/(100+l_taxper)*100;
DBMS_OUTPUT.PUT_LINE('NO PERCENTAGE');
END IF;
RETURN p_LINE_AMT;

EXCEPTION 
WHEN no_data_found THEN
        p_LINE_AMT := 0;
        RETURN p_LINE_AMT;
END GET_LINE_AMT;

-----
FUNCTION GET_TAX_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
) RETURN NUMBER AS

p_TAX_AMT  NUMBER;
l_taxper NUMBER;

BEGIN
IF p_TAX_PERC IS NOT NULL THEN

p_TAX_AMT:=p_TOTAL_SPA/(100+p_TAX_PERC)*p_TAX_PERC;
--DBMS_OUTPUT.PUT_LINE('HAVING PERCENTAGE');
ELSE

IF(p_TAX_CODE='COMMERCIAL') THEN
l_taxper:=5;
ELSIF(p_TAX_CODE='COMMERCIAL EXEMPT') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL EXEMPT')THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='STANDARD RATE') THEN
l_taxper:=5;
else 
l_taxper:=0;
END IF;

p_TAX_AMT:=p_TOTAL_SPA/(100+l_taxper)*l_taxper;
DBMS_OUTPUT.PUT_LINE('NO PERCENTAGE');
END IF;
RETURN p_TAX_AMT;

EXCEPTION 
WHEN no_data_found THEN
        p_TAX_AMT := 0;
        RETURN p_TAX_AMT;
END GET_TAX_AMT;


END XXPM_AREA_CHANGE_PROCESS;
