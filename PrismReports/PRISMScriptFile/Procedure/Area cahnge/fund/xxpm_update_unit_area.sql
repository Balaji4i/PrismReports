create or replace FUNCTION xxpm_update_unit_area (
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
--                    update xxpm_property_area
--                    set VALUE=l_overall_property
--                    where 
--                    AREA='CHARGE' 
--                    and build_id is null 
--                    and unit_id is null 
--                    and PROPERTY_ID=p_property_id;    
        DBMS_OUTPUT.put_line('--building update--');
--                    update xxpm_property_area
--                    set VALUE=l_overall_building
--                    where 
--                    AREA='CHARGE'
--                    and unit_id is null
--                    and build_id=p_build_id;
        DBMS_OUTPUT.put_line('--unit  update--');         
--                  update xxpm_property_area
--                  set VALUE=p_new_area
--                  where 
--                  AREA='CHARGE'
--                  and unit_id=p_unitid;   
else
    DBMS_OUTPUT.put_line('--area inside the building 2--');
--    update xxpm_property_area
--    set VALUE=p_new_area
--    where 
--    AREA='CHARGE'
--    and unit_id=p_unitid;
commit;
end if;
end;
return p_status;
END xxpm_update_unit_area;