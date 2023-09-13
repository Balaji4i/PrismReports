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
l_cur_tot_building number;
l_cur_tot_unit  number;
l_overall_bunit number;
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
into l_cur_tot_building
FROM 
xxpm_property_area 
where AREA='CHARGE' and build_id=p_build_id and unit_id is null and PROPERTY_ID=p_property_id; 
DBMS_OUTPUT.put_line('l_cur_tot_building-->'||l_cur_tot_building);
---
SELECT 
sum(VALUE)
into l_cur_tot_unit
FROM 
xxpm_property_area 
where AREA='CHARGE' and build_id=p_build_id and unit_id is not null and PROPERTY_ID=p_property_id; 
DBMS_OUTPUT.put_line('l_cur_tot_unit-->'||l_cur_tot_unit);
l_overall_bunit:=l_cur_tot_unit+p_valuediff;
l_overall_building:=l_cur_tot_building+p_valuediff;
l_overall_property:=l_tot_property+p_valuediff;

DBMS_OUTPUT.put_line('l_overall_bunit-->'||l_overall_bunit);
if(l_overall_bunit>l_cur_tot_building) then
DBMS_OUTPUT.put_line('--BUID need to update--');
    if (l_overall_building>l_tot_sum_building) then
                DBMS_OUTPUT.put_line('--area out of building--');
        --            update xxpm_property_area
        --            set VALUE=l_overall_property
        --            where 
        --            AREA='CHARGE' 
        --            and build_id is null 
        --            and unit_id is null 
        --            and PROPERTY_ID=p_property_id;
                DBMS_OUTPUT.put_line('--building update--');
        --            update xxpm_property_area
        --            set VALUE=l_overall_building
        --            where 
        --            AREA='CHARGE'
        --            and unit_id is null
        --            and build_id=p_build_id;
                 DBMS_OUTPUT.put_line('--unit  update--'); 
        --          update xxpm_property_area
        --          set VALUE=p_new_area
        --          where 
        --          AREA='CHARGE'
        --          and unit_id=p_unitid;   
                DBMS_OUTPUT.put_line('--properyt update--');
      else
      DBMS_OUTPUT.put_line('--area inside the building--');
      DBMS_OUTPUT.put_line('--building update--');
--            update xxpm_property_area
--            set VALUE=l_overall_building
--            where 
--            AREA='CHARGE'
--            and unit_id is null
--            and build_id=p_build_id;
      DBMS_OUTPUT.put_line('--area update--');
    --        update xxpm_property_area
    --        set VALUE=p_new_area
    --        where 
    --        AREA='CHARGE'
    --        and unit_id=p_unitid;
      commit;
      end if;
else
    DBMS_OUTPUT.put_line('--area update--');
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