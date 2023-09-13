CREATE OR REPLACE PACKAGE "XXPM_AREA_CHANGE_PROCESS"
AS

PROCEDURE XXPM_AREA_CHANGE( 
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
  );


FUNCTION xxpm_update_unit_area (
                        p_property_id       IN             NUMBER,
                        p_build_id          IN             NUMBER,
                        p_unitid            IN             number,
                        p_new_area          IN             NUMBER, 
                        p_valuediff         IN             number
                        )
return varchar2;

END;
/


CREATE OR REPLACE PACKAGE BODY "XXPM_AREA_CHANGE_PROCESS" 
as

PROCEDURE XXPM_AREA_CHANGE(
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
BEGIN
select 
PROPERTY_ID, BUILD_ID 
into
p_PROPERTY_ID, p_BUILD_ID 
from xxpm_property_area
where AREA='CHARGE'
and UNIT_ID=p_unit_id;

SELECT BOOKING_RATE 
INTO l_baseprice
FROM xxpm_booking_detail WHERE BOOKING_HDR_ID=p_bookinghdr AND UNIT_ID=p_unit_id;

--Area Variation different
l_areaVariation:=p_new_area-p_old_area;
--checking tolerance
l_agreedVariation:=((p_tolerance)*(p_old_area/100));
DBMS_OUTPUT.PUT_LINE('l_agreedVariation==>:'||l_agreedVariation);
DBMS_OUTPUT.PUT_LINE('l_areaVariation==>:'||l_areaVariation);

begin
if l_areaVariation between -l_agreedVariation and +l_agreedVariation then
DBMS_OUTPUT.PUT_LINE('==IN Ranger==>');
l_flag:=xxpm_update_unit_area(p_PROPERTY_ID, p_BUILD_ID, p_UNIT_ID,p_new_area,l_areaVariation);
else
DBMS_OUTPUT.PUT_LINE('==OUT Ranger==>');
l_range_diff:=l_areaVariation-l_agreedVariation;
DBMS_OUTPUT.PUT_LINE('l_range_diff'||l_range_diff);
l_flag:=xxpm_update_unit_area(p_PROPERTY_ID, p_BUILD_ID, p_UNIT_ID,p_new_area,l_areaVariation);
    DBMS_OUTPUT.PUT_LINE('p_old_area'||p_old_area);
    DBMS_OUTPUT.PUT_LINE('p_new_area'||p_new_area);
    if p_old_area<p_new_area then
    DBMS_OUTPUT.PUT_LINE('invoice');
    l_type:='CREATE_INVOICE';
    l_amountdiffern:=l_baseprice*l_range_diff;
    else
    DBMS_OUTPUT.PUT_LINE('debit memo');
    l_type:='CREATE_CREDIT';
    l_amountdiffern:=l_baseprice*l_range_diff;
    end if;
end if;

update xxpm_booking_header
set AREA_VARIATION_PCT=p_tolerance
where BOOKING_HDR_ID=p_bookinghdr;

DBMS_OUTPUT.PUT_LINE('l_flag==>:'||l_flag);
--l_newbookingAmt:=l_amountdiffern+p_old_booking;
p_new_booking:=round((l_amountdiffern+p_old_booking),2);
p_type:=l_type;
p_amount_differ:=round(l_amountdiffern,2);
commit;
end;
END XXPM_AREA_CHANGE;

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



END XXPM_AREA_CHANGE_PROCESS;
/
