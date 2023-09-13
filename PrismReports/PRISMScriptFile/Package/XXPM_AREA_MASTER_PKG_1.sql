--------------------------------------------------------
--  DDL for Package XXPM_AREA_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_AREA_MASTER_PKG" 

IS
   PROCEDURE xxpm_area_master_val(i_batch_id IN NUMBER);
   PROCEDURE update_area_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_property_number IN varchar2,
                               v_build_number IN varchar2,v_unit_number IN varchar2,v_batch_id IN number,v_area in varchar2);
   PROCEDURE unit_area_value_validation (p_property_id IN number,p_build_id IN number,p_batch_id IN number,p_status OUT varchar2);                           
   PROCEDURE insert_area_master (i_batch_id IN NUMBER);
   PROCEDURE xxdm_area_validations(p_batch_id IN NUMBER);


END XXPM_AREA_MASTER_PKG;


--------------------------------------------------------
--  DDL for Package Body XXPM_AREA_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_AREA_MASTER_PKG" 
AS
PROCEDURE 
xxpm_area_master_val (i_batch_id IN NUMBER)
AS
cursor c_area_temp  
is
        select 
      property_number,
    build_number,
    unit_number,
    area,
    uom,
    value,
    description,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    batch_id,
    interface_status_flag,
    interface_id,
    err_msg,
    err_description,
    validated_by,
    validated_date,
    processed_by,
    processed_date,
    property_id,
    build_id,
    unit_id,
    area_id,
    diff_val
        from 
        XXDM_PROPERTY_AREA 
        WHERE 
        batch_id=i_batch_id AND
        INTERFACE_STATUS_FLAG !='E';

v_batch_id          NUMBER;
v_ready_flag        varchar2 (1);
v_property_number   varchar2 (60);
v_build_number      varchar2 (60);
v_unit_number       varchar2(60);
v_property_id       number;
vm_property_id      number;
vu_property_id      number;
v_build_id          number;
vu_build_id         number;
v_unit_id           number;
v_area              varchar2(60);
v_err_reason        varchar2 (2000);
v_errm              varchar2 (2000);
v_lookup_area       varchar2(60);
v_area_count        number;
v_total_property_value number;
v_total_build_value  number;
v_total_unit_value   number;
v_status    Varchar2(15);
v_count_pm_units    number;
v_unit_number_dm    VARCHAR2(60);
l_unit_value     NUMBER;
l_diff number;


BEGIN
 	v_batch_id := i_batch_id;

FOR i IN c_area_temp LOOP

    v_ready_flag := 'V';
	v_err_reason:= '';
	v_errm := '';
  l_unit_value := '';
  l_diff  := '';
  
    Begin      
			select property_id,property_number into v_property_id,v_property_number from xxpm_property_master 
			where property_number=i.property_number;
	EXCEPTION
			WHEN OTHERS
			  THEN
               v_property_id:='';
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
    Begin      
			select build_id,build_number into v_build_id,v_build_number from xxpm_property_buildings 
			where build_number=i.build_number;
	EXCEPTION
			WHEN OTHERS
			  THEN
               v_build_id := ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
    Begin
    select count(1) into v_count_pm_units from xxpm_property_units  where unit_number=i.unit_number;
                ---Master unit check
    if (v_count_pm_units >0)    then        
                Begin      
                DBMS_OUTPUT.PUT_LINE('Count greater than 0');
                select unit_id,unit_number into v_unit_id,v_unit_number from xxpm_property_units 
                        where unit_number=i.unit_number;
                EXCEPTION
                        WHEN OTHERS
                          THEN
                           v_unit_id := ''; 
                           v_ready_flag := 'E';
                           v_errm := SQLCODE || '-' || SQLERRM;
                END;
     else
                Begin      
                            DBMS_OUTPUT.PUT_LINE('Count=0');
                        select unit_number into v_unit_number_dm from xxdm_property_units 
                        where unit_number=i.unit_number and batch_id=v_batch_id;
                         DBMS_OUTPUT.PUT_LINE(v_unit_number_dm);
                EXCEPTION
                        WHEN OTHERS
                          THEN
                           v_unit_number_dm := ''; 
                           v_ready_flag := 'E';
                           v_errm := SQLCODE || '-' || SQLERRM;
                END;
     end if;
     EXCEPTION
        WHEN OTHERS
          THEN
           v_count_pm_units := ''; 
           v_ready_flag := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
     END;
    if v_count_pm_units > 0 then
     BEGIN       
        DBMS_OUTPUT.PUT_LINE('UNIT ID iS NOT NULL');
			select xb.property_id,xu.property_id,xb.build_id,xu.property_number,xb.build_number,
            xpu.unit_number,xpu.unit_id,xpu.property_id,xpu.build_id
			into vm_property_id,v_property_id,v_build_id,v_property_number,v_build_number ,
            v_unit_number,v_unit_id,vu_property_id,vu_build_id
			from xxpm_property_master xu, xxpm_property_buildings xb,xxpm_property_units xpu
			where xu.property_id=xb.PROPERTY_ID
            and xu.property_id=xpu.property_id
            and xb.property_id=xpu.property_id
            and xb.build_id=xpu.build_id
			and xb.build_number=i.build_number
			and xu.property_number=i.property_number
            and xpu.unit_number=i.unit_number;

            update XXDM_PROPERTY_AREA set property_id=vu_property_id,build_id=vu_build_id,unit_id=v_unit_id
            where build_number=i.build_number
			and property_number=i.property_number
            and unit_number=i.unit_number
            and batch_id=v_batch_id;
            commit;
            DBMS_OUTPUT.PUT_LINE('UNIT ID iS NOT NULL ENDS');

	EXCEPTION
			WHEN OTHERS
			  THEN
              DBMS_OUTPUT.PUT_LINE('UNIT ID IS EXIST');
               v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
    else
     BEGIN       
            DBMS_OUTPUT.PUT_LINE('UNIT ID IS NULL');
			select xb.property_id,xu.property_id,xb.build_id,xu.property_number,xb.build_number
            into vm_property_id,v_property_id,v_build_id,v_property_number,v_build_number 
           	from xxpm_property_master xu, xxpm_property_buildings xb
			where xu.property_id=xb.PROPERTY_ID
            and xb.build_number=i.build_number
			and xu.property_number=i.property_number;

            DBMS_OUTPUT.PUT_LINE(vm_property_id || '' || v_property_id|| '' ||v_build_id || '' || v_property_number || '' || v_build_number);

            update XXDM_PROPERTY_AREA set property_id=v_property_id,build_id=v_build_id,unit_id=null
            where build_number=i.build_number
			and property_number=i.property_number
            and unit_number=i.unit_number
            and batch_id=v_batch_id;
            commit;            
             DBMS_OUTPUT.PUT_LINE('UNIT ID IS  NULL ENDS');
	EXCEPTION
			WHEN OTHERS
			  THEN
               DBMS_OUTPUT.PUT_LINE('UNIT ID IS NEW');
               v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
    end if;

    BEGIN
			select count(1) into v_lookup_area from xxfnd_lookup_v where lookup_type_name='AREA_TYPE'  and lookup_value_name=i.AREA;
            DBMS_OUTPUT.PUT_LINE('AREA LOOKUP ' || v_lookup_area);
    EXCEPTION
            WHEN OTHERS
			  THEN
               v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
    END;
    BEGIN
            select count(1) into v_area_count from XXDM_PROPERTY_AREA 
            where build_number=i.build_number
			  and property_number=i.property_number
              and unit_number=i.unit_number
              and area=i.area
              and batch_id=v_batch_id;
    EXCEPTION
            WHEN OTHERS
			  THEN
               v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
    END;
    Begin
          DBMS_OUTPUT.PUT_LINE('Property ' || v_property_id || 'Build id ' || v_build_id || 'Unit_id ' || v_unit_id);

          select value into v_total_property_value from XXPM_PROPERTY_AREA where
          property_id =v_property_id and build_id is  null and unit_id is null and area=i.AREA;

          DBMS_OUTPUT.PUT_LINE( 'Property_id '||v_property_id|| ' Property_value :' || v_total_property_value);

    EXCEPTION
            WHEN OTHERS
			  THEN
               v_total_property_value:='';
               v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
    end;
    Begin
      select value into v_total_build_value from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is null and area=i.AREA; 

      DBMS_OUTPUT.PUT_LINE('Build_value : ' || v_total_build_value);

    EXCEPTION
            WHEN OTHERS
			  THEN
               v_total_build_value:='';
               v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
    end;
    Begin
      select sum(value) into v_total_unit_value from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area=i.AREA;   

      DBMS_OUTPUT.PUT_LINE('Unit_value : ' || v_total_unit_value);

    EXCEPTION
            WHEN OTHERS
			  THEN
               v_total_unit_value :='';
               v_ready_flag := 'E';
			   --v_errm := SQLCODE || '-' || SQLERRM;
    end;
    
    Begin
    
    IF v_unit_id IS NOT NULL THEN
    Dbms_output.put_line('inside if v_unit_id ' || v_unit_id);
    Begin
    SELECT VALUE INTO l_unit_value  FROM XXPM_PROPERTY_AREA WHERE
      property_id =v_property_id AND build_id =v_build_id AND unit_id =v_unit_id and area =i.area;     
      l_diff :=i.VALUE -l_unit_value  ;  
          Dbms_output.put_line('inside if l_diff ' || l_diff);      
      exception WHEN others THEN
                Dbms_output.put_line(' Exception in getting the unit value  ');

      l_unit_value:='';
      l_diff:= i.VALUE;
                

      END;      
      ELSE
      l_diff:=i.VALUE ;
      Dbms_output.put_line('inside else l_diff ' || l_diff);
    end if;
    
    UPDATE XXDM_PROPERTY_AREA SET diff_val =l_diff  WHERE unit_number =i.unit_number AND   batch_id=v_batch_id;
    commit;
    
    end;
    


DBMS_OUTPUT.PUT_LINE('Property id:- ' || i.property_number|| 'Build id:- ' || i.build_number || 'Unit_id:- ' || i.unit_number);
if (v_property_id is not null) then
    if (v_build_id is not null) then
        if(v_unit_id is not null)  or (v_unit_number_dm is not null)then
            if (v_property_id=vm_property_id) then--and (v_property_id=vu_property_id) and (v_build_id=vu_build_id) then
                if (v_lookup_area >0) or (i.AREA is null)then  
                    if(v_area_count = 1) then
                       if(v_total_property_value <> 0) or (v_total_property_value <> '') then 
                          if(v_total_build_value <> 0) or (v_total_build_value <> '')then
                      DBMS_OUTPUT.PUT_LINE('status flag:- ' ||v_ready_flag||'v_property_number:'||v_property_number||'v_build_number:'||v_build_number||'v_unit_number:'||v_unit_number_dm||'v_batch_id:'||v_batch_id||'i.area:'||i.area);    
                    update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);

                     /*        if(v_total_property_value >= v_total_build_value) then
                                if (v_total_build_value >= v_total_unit_value) then
                      DBMS_OUTPUT.PUT_LINE('ALL VALIDATION DONE');
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id,i.area);

--                                   if i.area='CHARGE'  then
--                                    unit_area_value_validation(v_property_id,v_build_id,v_batch_id,v_status);
--                                    if(v_status='SUCCESS') then
--                                        DBMS_OUTPUT.PUT_LINE('ALL VALIDATION DONE');
--                                        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE ' || v_errm);
--                                                    v_property_number:=i.property_number;
--                                                    v_build_number:=i.build_number;
--                                                    v_unit_number:=i.unit_number;
--                                                    v_err_reason:= v_err_reason;
--                                                    update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
--                                    else
--                                         DBMS_OUTPUT.PUT_LINE('BUILD VALUE IS LESS THAN UNIT VALUE');
--                                            v_property_number:=i.property_number;
--                                            v_build_number:=i.build_number;
--                                            v_unit_number:=i.unit_number;
--                                            v_ready_flag := 'E';
--                                            v_err_reason:= 'BUILD VALUE IS LESS THAN UNIT VALUE';
--                                            update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
--                                    end if;
--                                    else    
--                                            DBMS_OUTPUT.PUT_LINE('1111111111111111');
--                                                    v_property_number:=i.property_number;
--                                                    v_build_number:=i.build_number;
--                                                    v_unit_number:=i.unit_number;
--                                                    v_err_reason:= v_err_reason;
--                                                    update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
--                                    end if;
                                 else
                                        DBMS_OUTPUT.PUT_LINE('UNIT VALUE IS MORE THAN BUILD VALUE');
                                        v_property_number:=i.property_number;
                                        v_build_number:=i.build_number;
                                        v_unit_number:=i.unit_number;
                                        v_ready_flag := 'E';
                                        v_err_reason:= 'UNIT VALUE IS MORE THAN BUILD VALUE';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id,i.area);
                                 end if;
                              else
                                    DBMS_OUTPUT.PUT_LINE('BUILD VALUE IS MORE THAN PROPERTY VALUE');
                                        v_property_number:=i.property_number;
                                        v_build_number:=i.build_number;
                                        v_unit_number:=i.unit_number;
                                         v_ready_flag := 'E';
                                        v_err_reason:= 'BUILD VALUE IS MORE THAN PROPERTY VALUE';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id,i.area);
                               end if;         
                        */
                          else
                                  DBMS_OUTPUT.PUT_LINE('Build value is not available in the property unit area');
                                    v_property_number:=i.property_number;
                                    v_build_number:=i.build_number;
                                    v_unit_number:=i.unit_number;
                                     v_ready_flag := 'E';
                                    v_err_reason:= i.area||' is not available in the building area '|| v_build_number || 'for the property number ' || v_property_number;
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
                          end if;
                        else 
                                 DBMS_OUTPUT.PUT_LINE('Property value is not available in the property unit area');
                                v_property_number:=i.property_number;
                                v_build_number:=i.build_number;
                                v_unit_number:=i.unit_number;
                                 v_ready_flag := 'E';
                                v_err_reason:= i.area||' is not available in the property '|| v_property_number;
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
                         end if;               
                    else
                           DBMS_OUTPUT.PUT_LINE('AREA TYPE IS ALREADY EXIST');
                        v_property_number:=i.property_number;
                        v_build_number:=i.build_number;
                        v_unit_number:=i.unit_number;
                        v_ready_flag := 'E';
                        v_area:=i.area;
                        v_err_reason:= 'Area type ' || v_area || ' is already available for the property  ' || i.property_number||' building ' || i.build_number ||' units '
                                       || i.unit_number || ' Hence you cannot the create the same area type for the unit';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
                    end if;
                 else
                     DBMS_OUTPUT.PUT_LINE('AREA TYPE IS NOT AVAILABLE IN LOOKUP');
                      v_property_number:=i.property_number;
                      v_build_number:=i.build_number;
                      v_unit_number:=i.unit_number;
                       v_ready_flag := 'E';
                      v_err_reason:= 'Mentioned area type ' || i.area || ' is not available in lookup';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
                 end if;
            else
                  DBMS_OUTPUT.PUT_LINE('UNIT NUMBER IS NOT RELATED WITH THE PROPERTY NUMBER AND BUILDING');
                v_property_number:=i.property_number;
                v_build_number:=i.build_number;
                v_unit_number:=i.unit_number;
                 v_ready_flag := 'E';
                v_err_reason:= i.unit_number ||' :- UNIT NUMBER IS NOT RELATED WITH THE ' ||i.property_number  ||  ':- PROPERTY NUMBER AND '|| i.BUILD_NUMBER  ||':- BUILDING NUMBER';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
            end if;
        else
              DBMS_OUTPUT.PUT_LINE('UNIT NUMBER IS NOT IN THE PROPERTY UNITS TABLE');
            v_property_number:=i.property_number;
            v_build_number:=i.build_number;
            v_unit_number:=i.unit_number;
             v_ready_flag := 'E';
            v_err_reason:= i.unit_number || ' :- UNIT NUMBER IS NOT IN THE PROPERTY UNITS TABLE';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
        end if;
    else
          DBMS_OUTPUT.PUT_LINE('BUILD NUMBER IS NOT IN THE BUILD MASTER TABLE');
        v_property_number:=i.property_number;
        v_build_number:=i.build_number;
        v_unit_number:=i.unit_number;
         v_ready_flag := 'E';
        v_err_reason:= i.build_number || ' :- BUILD NUMBER IS NOT IN THE BUILD MASTER TABLE';
        
--        DBMS_OUTPUT.PUT_line('v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number_dm,v_batch_id,i.area '||v_ready_flag ||'   '||v_err_reason||'   '||v_errm||'   '||v_property_number||'   '||v_build_number||'   '||v_unit_number_dm||'   '||v_batch_id||'   '||i.area);
         DBMS_OUTPUT.PUT_line(' v_unit_number_dm   '||i.unit_number);
             update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
    end if;
else 
    DBMS_OUTPUT.PUT_LINE('PROPERTY NUMBER IS NOT IN THE PROPERTY MASTER TABLE');
    v_property_number:=i.property_number;
    v_build_number:=i.build_number;
    v_unit_number:=i.unit_number;
     v_ready_flag := 'E';
    v_err_reason:= i.property_number || ' :- PROPERTY NUMBER IS NOT IN THE PROPERTY MASTER TABLE';
                                update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
end if;




----------------------------Mandatory Validations ------------------



if i.AREA is null then

    DBMS_OUTPUT.PUT_LINE('.AREA is null');
    v_property_number:=i.property_number;
    v_build_number:=i.build_number;
    v_unit_number:=i.unit_number;
     v_ready_flag := 'E';
    v_err_reason:= ' AREA should not be  null';
      update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
end if;

if i.uom is null then

    DBMS_OUTPUT.PUT_LINE('.uom is null');
    v_property_number:=i.property_number;
    v_build_number:=i.build_number;
    v_unit_number:=i.unit_number;
     v_ready_flag := 'E';
    v_err_reason:= ' uom should not be  null';
      update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
end if;

if i.value is null then

    DBMS_OUTPUT.PUT_LINE('.value is null');
    v_property_number:=i.property_number;
    v_build_number:=i.build_number;
    v_unit_number:=i.unit_number;
     v_ready_flag := 'E';
    v_err_reason:= ' value should not be  null';
      update_area_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,i.unit_number,v_batch_id,i.area);
end if;


















END LOOP;

xxdm_area_validations(v_batch_id );

END xxpm_area_master_val;
-----------------------------
PROCEDURE update_area_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_property_number IN varchar2,
                             v_build_number IN varchar2,v_unit_number IN varchar2,v_batch_id IN number,v_area in varchar2)
as
Begin
--DBMS_OUTPUT.PUT_LINE(' v_status_flag  ' ||v_status_flag ||'v_err_desc '||v_err_desc ||'v_err_msg '||v_err_msg );
DBMS_OUTPUT.PUT_LINE('  v_unit_number     '||v_unit_number );
--||' v_property_number '||v_property_number || ' v_build_number ' ||v_build_number
--DBMS_OUTPUT.PUT_LINE(' v_batch_id  '||v_batch_id  ||'v_area '||v_area);
        UPDATE   XXDM_PROPERTY_AREA
        SET     
		    INTERFACE_STATUS_FLAG=v_status_flag,
            ERR_DESCRIPTION= v_err_desc,
            ERR_MSG=v_err_msg
        where   
		    property_number=v_property_number and build_number=v_build_number 
            and unit_number=v_unit_number and batch_id=v_batch_id and area=v_area ;  
        commit;
End update_area_temp;
--------
procedure unit_area_value_validation (p_property_id IN number,p_build_id IN number,p_batch_id IN number,p_status OUT varchar2)
as
v_batch_id number;
v_build_id number;
v_property_id number;
v_unit_id number;
v_total_build_value number;
v_total_sum_stage number;
v_total_sum_master number;
v_total_stageIn_master  number;
v_total_stagenotin_master number;
v_total_masterIn_stage number;
v_total_masterInnot_stage number;
v_total number;

begin
v_build_id:=p_build_id;
v_property_id:=p_property_id;
v_batch_id:=p_batch_id;

--Total build value
select nvl(value,0) into v_total_build_value from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is null and area='CHARGE'; 


---Sum of stage not in master
select nvl(sum(value),0) into v_total_stagenotin_master from XXDM_PROPERTY_AREA where batch_id=v_batch_id and
      property_id =v_property_id and build_id =v_build_id and area='CHARGE' and unit_id not in ( 
select unit_id from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area='CHARGE');

--Sum of stage in master      

select nvl(sum(value),0) into v_total_stageIn_master from XXDM_PROPERTY_AREA where batch_id=v_batch_id and 
      property_id =v_property_id and build_id =v_build_id and area='CHARGE' and unit_id in ( 
select unit_id from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area='CHARGE');

----Sum of master in stage

select nvl(sum(value),0) into v_total_masterIn_stage from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and area='CHARGE' and unit_id  in ( 
select unit_id from XXDM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area='CHARGE' and batch_id=v_batch_id);

----Sum of master not in stage

select nvl(sum(value),0) into v_total_masterInnot_stage from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and area='CHARGE' and unit_id not in ( 
select unit_id from XXDM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area='CHARGE' and  batch_id=v_batch_id);


--Total sum of master

select nvl(sum(value),0) into v_total_sum_master from XXPM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area='CHARGE';   

---Total sum of staging

select nvl(sum(value),0) into v_total_sum_stage from XXDM_PROPERTY_AREA where
      property_id =v_property_id and build_id =v_build_id and unit_id is not null and area='CHARGE' and  batch_id=v_batch_id;   

     v_total:= v_total_stageIn_master + v_total_stagenotin_master+v_total_masterInnot_stage;

DBMS_OUTPUT.PUT_LINE('Total ' || v_total);

if (v_total_sum_master+v_total_sum_stage) <=  v_total_build_value then
p_status :='SUCCESS';
else
     if (v_total_masterIn_stage>=v_total_stageIn_master)
     then
         if (v_total <=  v_total_build_value) then
                p_status :='SUCCESS';
         else
                p_status :='FAILURE';
         end if;
     else
                p_status :='FAILURE';      
     end if;
end if;

DBMS_OUTPUT.PUT_LINE('TOTAL BUILD VALUE ' || v_total_build_value);
DBMS_OUTPUT.PUT_LINE('TOTAL SUM_STAGE_VALUE  ' || v_total_sum_stage) ;
DBMS_OUTPUT.PUT_LINE('TOTAL SUM_MASTER_VALUE  ' || v_total_sum_master) ;
DBMS_OUTPUT.PUT_LINE('TOTAL SUM_STAGE_IN_MASTER_VALUE  ' || v_total_stageIn_master);
DBMS_OUTPUT.PUT_LINE('TOTAL SUM_STAGE_NOT_IN_MASTER_VALUE  ' ||v_total_stagenotin_master);
DBMS_OUTPUT.PUT_LINE('TOTAL SUM_MASTER_IN_STAGE_VALUE  ' || v_total_masterIn_stage);
DBMS_OUTPUT.PUT_LINE('TOTAL SUM_MASTER_NOT_IN_STAGE_VALUE  ' ||v_total_masterInnot_stage);

end unit_area_value_validation;
-----------------------------------
procedure insert_area_master (i_batch_id IN NUMBER)
as
cursor c_area_dm
is
        select 
        AREA_ID,
        PROPERTY_NUMBER, 
        BUILD_NUMBER, 
        UNIT_NUMBER, 
        PROPERTY_ID,
        BUILD_ID,
        UNIT_ID,
        AREA, 
        UOM, 
        VALUE, 
        DESCRIPTION, 
        CREATED_BY, 
        CREATION_DATE, 
        LAST_UPDATED_BY, 
        LAST_UPDATE_DATE, 
        LAST_UPDATE_LOGIN, 
        BATCH_ID, 
        INTERFACE_STATUS_FLAG, 
        INTERFACE_ID, 
        ERR_MSG, 
        ERR_DESCRIPTION, 
        VALIDATED_BY, 
        VALIDATED_DATE, 
        PROCESSED_BY,   
        PROCESSED_DATE
        from 
        XXDM_PROPERTY_AREA 
        where  INTERFACE_STATUS_FLAG='V'
        and batch_id=i_batch_id;


v_row_count number;
v_errm  varchar2(2000);
v_property_id number;
v_build_id number;
v_unit_id number;
v_property_number varchar2(100);
vm_property_id number;
vu_property_id number;
vu_build_id number;
v_build_number varchar2(100);
v_unit_number varchar2(100);
v_batch_id     NUMBER;

BEGIN
v_batch_id:=i_batch_id;

for i in c_area_dm loop

     Begin
      select unit_id into v_unit_id from XXPM_PROPERTY_UNITS where
      property_id =i.property_id and build_id =i.build_id and unit_number=i.unit_number; 
        DBMS_OUTPUT.PUT_LINE(i.property_id || '  ' ||i.build_id);
     EXCEPTION
            WHEN OTHERS
			  THEN
               v_unit_id:='';
               v_errm := SQLCODE || '-' || SQLERRM;
     end;

if i.area_id is not null then

update xxpm_property_area
set
AREA=i.area,
UOM=i.UOM,	
VALUE=i.VALUE,
DESCRIPTION=i.DESCRIPTION,
CREATED_BY=i.CREATED_BY,
CREATION_DATE=i.CREATION_DATE,
LAST_UPDATED_BY=i.LAST_UPDATED_BY,
LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
where area_id=i.area_id and
property_id =i.property_id and build_id =i.build_id
and unit_id=v_unit_id;

else


insert into xxpm_property_area (AREA_ID,PROPERTY_ID,
        BUILD_ID,UNIT_ID,AREA,UOM,VALUE,DESCRIPTION,CREATED_BY, 
        CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE, 
        LAST_UPDATE_LOGIN)
values (XXPM_AREA_ID_S.nextval,i.PROPERTY_ID,
        i.BUILD_ID,v_unit_id,i.AREA,i.UOM,i.VALUE,i.DESCRIPTION,
        i.created_by,i.creation_date,i.last_updated_by,i.last_update_date,i.last_update_login );
       --values (XXPM_AREA_ID_S.nextval,v_property_id,
        --v_build_id,v_unit_id,i.AREA,i.UOM,i.VALUE,i.DESCRIPTION,
      -- i.created_by,i.creation_date,i.last_updated_by,i.last_update_date,i.last_update_login );
       

end if;

UPDATE   XXDM_PROPERTY_AREA
        SET     
		    INTERFACE_STATUS_FLAG='P',
            ERR_DESCRIPTION= null,
            ERR_MSG=null
        where   
		    property_number=i.property_number and build_number=i.build_number 
            and unit_number=i.unit_number and batch_id=v_batch_id ;  
commit;

end loop;
commit;
END insert_area_master;



 PROCEDURE xxdm_area_validations(p_batch_id in number)
AS
CURSOR cur_dm_property_area
IS
 
 
 
SELECT 
  BUILD_ID,area,
  sum(DIFF_VAL) as diff_val
FROM XXDM_PROPERTY_AREA WHERE batch_id =p_batch_id AND INTERFACE_STATUS_FLAG ='V'
GROUP BY build_id,area;

l_unit_value NUMBER;
l_actual_unit_value  NUMBER;
l_total_unit_value NUMBER;
l_status_flag  varchar2(10);
l_err_desc  varchar2(500);

BEGIN

FOR i IN cur_dm_property_area
loop

begin
SELECT sum(VALUE) INTO l_unit_value FROM xxpm_property_area WHERE build_id =i.build_id AND area =i.area AND unit_id IS NOT NULL;
SELECT VALUE INTO l_actual_unit_value FROM xxpm_property_area WHERE build_id =i.build_id AND area =i.area AND unit_id IS  NULL;



l_total_unit_value := l_unit_value+ i.diff_val ;
dbms_output.put_line(' l_unit_value  ' || l_unit_value || '     '||' i.diff_val  '||i.diff_val || '  l_total_unit_value   '  ||l_total_unit_value  ||'  l_actual_unit_value  '||l_actual_unit_value ) ;

IF l_total_unit_value  <= l_actual_unit_value THEN

l_status_flag := 'V' ;
ELSE

l_status_flag := 'V' ;
l_err_desc  :='Area exceeds the building allocated area  for  '||i.area;
END IF;
dbms_output.put_line(' l_status_flag  '||l_status_flag );

exception when others then
l_status_flag := 'E' ;
dbms_output.put_line(' exception  occurs' );
end;

UPDATE XXDM_PROPERTY_AREA SET INTERFACE_STATUS_FLAG= l_status_flag ,ERR_DESCRIPTION=l_err_desc  WHERE batch_id =p_batch_id AND  build_id =i.build_id AND area =i.area ;
COMMIT;
end loop;

end;

END XXPM_AREA_MASTER_PKG;
