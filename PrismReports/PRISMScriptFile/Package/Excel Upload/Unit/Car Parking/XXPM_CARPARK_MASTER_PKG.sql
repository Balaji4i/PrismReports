CREATE OR REPLACE PACKAGE "XXPM_CARPARK_MASTER_PKG" 
IS
  PROCEDURE xxpm_carpark_master_val(
      i_batch_id IN NUMBER);
  PROCEDURE update_carpark_temp(
      v_status_flag     IN VARCHAR2,
      v_err_desc        IN VARCHAR2,
      v_err_msg         IN VARCHAR2,
      v_unit_number    IN VARCHAR2,
      v_batch_id        IN NUMBER);
  PROCEDURE insert_carpark_master(
      i_batch_id IN NUMBER);
END XXPM_CARPARK_MASTER_PKG;

/


CREATE OR REPLACE PACKAGE BODY "XXPM_CARPARK_MASTER_PKG" 
IS
PROCEDURE xxpm_carpark_master_val(i_batch_id IN NUMBER)
  as
  cursor c_carpark_temp
  is
  select 
    CARPARK_ID,
    UNIT_NUMBER,
    UNIT_ID,
    CP_UNIT_ID,
    CP_UNIT_NUMBER,
    ALLOT_TYPE,
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
    from XXDM_PROPERTY_CARPARKS 
    WHERE BATCH_ID=i_batch_id
     and   INTERFACE_STATUS_FLAG !='E';

v_batch_id          NUMBER;
v_ready_flag        varchar2 (1);
v_err_reason        varchar2(2000);
v_errm              varchar2(2000);
v_unit_id           number;
v_unit_number       varchar2(15);
v_lookup_carpark    varchar2(20);
v_free_carpark_status    varchar2(20);
v_paid_carpark_status    varchar2(20);
v_cp_unit_id            number;
v_cp_unit_number        varchar2(20);
v_count_pm_units           number;
v_count_pm_cp_units         number;
v_unit_number_dm            varchar2(60);
v_cp_unit_number_dm       varchar2(60);

begin
    v_batch_id:=i_batch_id;

FOR i IN c_carpark_temp LOOP
    v_ready_flag := 'V';
	v_err_reason:= '';
	v_errm := '';
Begin
     select count(*) into v_count_pm_units from xxpm_property_units  where unit_number=i.unit_number;
if (v_count_pm_units >0)    then     
                Begin      
                        select unit_id,unit_number into v_unit_id,v_unit_number from xxpm_property_units 
                        where unit_number=i.unit_number;

                        DBMS_OUTPUT.PUT_LINE('UNIT NUMBER VALIDATIOn:-' || v_unit_id || v_unit_number );

                EXCEPTION
                        WHEN OTHERS
                          THEN
                           v_unit_id := ''; 
                           v_ready_flag := 'E';
                           v_errm := SQLCODE || '-' || SQLERRM;
                END;
                Begin
                    update XXDM_PROPERTY_CARPARKS set unit_id= v_unit_id  where unit_number=i.unit_number and batch_id=v_batch_id;
                    commit;
                Exception
                WHEN OTHERS
                THEN
                                   v_ready_flag := 'E';
                                   v_errm := SQLCODE || '-' || SQLERRM;
                End;
           Begin        
                 if(i.allot_type='FREE' )
                then
                select STATUS into v_free_carpark_status from XXPM_PROPERTY_UNITS where unit_number in 
                  (select unit_number from XXDM_PROPERTY_CARPARKS where unit_number=i.unit_number and allot_type='FREE'  and batch_id=v_batch_id);
                    DBMS_OUTPUT.PUT_LINE('FREE CARPARKING  ' || v_free_carpark_status);

                end if;


                if(i.allot_type='PAID' )
                then
                select STATUS into v_paid_carpark_status from XXPM_PROPERTY_UNITS where unit_number in 
                  (select unit_number from XXDM_PROPERTY_CARPARKS where unit_number=i.unit_number and allot_type='PAID'  and batch_id=v_batch_id);
                DBMS_OUTPUT.PUT_LINE('PAID CARPARKING  ' ||v_paid_carpark_status);

                end if;

            Exception
            WHEN OTHERS
            THEN
                           v_lookup_carpark:='';
                           v_ready_flag := 'V';
                           v_errm := SQLCODE || '-' || SQLERRM;
            End;
ELSE
                Begin      
                    DBMS_OUTPUT.PUT_LINE('Count=0');
                        select unit_number into v_unit_number_dm from xxdm_property_units 
                        where unit_number=i.unit_number and batch_id=v_batch_id;
                         DBMS_OUTPUT.PUT_LINE(v_unit_number_dm);
                EXCEPTION
                        WHEN OTHERS
                          THEN
                           v_unit_number_dm := ''; 
                           v_ready_flag := 'V';
                           v_errm := SQLCODE || '-' || SQLERRM;
                END;
                Begin
                    update XXDM_PROPERTY_CARPARKS set unit_id= null  where unit_number=i.unit_number and batch_id=v_batch_id;
                    commit;
                Exception
                WHEN OTHERS
                THEN
                                   v_ready_flag := 'V';
                                   v_errm := SQLCODE || '-' || SQLERRM;
                End;
                 Begin
             update XXDM_PROPERTY_CARPARKS set cp_unit_id= null  where cp_unit_number=i.cp_unit_number 
             and batch_id=v_batch_id;
             commit;
                Exception
                WHEN OTHERS
                THEN
                               v_ready_flag := 'V';
                               v_errm := SQLCODE || '-' || SQLERRM;
                End;

                     Begin

                    if(i.allot_type='FREE' )
                    then
                    DBMS_OUTPUT.PUT_LINE('111111111' || v_free_carpark_status);
                    select STATUS into v_free_carpark_status from XXDM_PROPERTY_UNITS where batch_id =v_batch_id and  unit_number in 
                      (select unit_number from XXDM_PROPERTY_CARPARKS where unit_number=i.unit_number and allot_type='FREE'  and batch_id=v_batch_id);
                    DBMS_OUTPUT.PUT_LINE('000000000000'||v_free_carpark_status);
                    end if;


                    if(i.allot_type='PAID' )
                    then
                    DBMS_OUTPUT.PUT_LINE('222222222222222'||v_paid_carpark_status);
                    select STATUS into v_paid_carpark_status from XXDM_PROPERTY_UNITS where batch_id =v_batch_id and unit_number in 
                      (select unit_number from XXDM_PROPERTY_CARPARKS where unit_number=i.unit_number and allot_type='PAID'  and batch_id=v_batch_id);
                    DBMS_OUTPUT.PUT_LINE('33333333333333'||v_paid_carpark_status);
                    end if;

                    Exception
                    WHEN OTHERS
                    THEN
                                   v_lookup_carpark:='';
                                   v_ready_flag := 'V';
                                   v_errm := SQLCODE || '-' || SQLERRM;
                    End;    
end if;
      EXCEPTION
        WHEN OTHERS
          THEN
           v_count_pm_units := ''; 
           v_ready_flag := 'V';
           v_errm := SQLCODE || '-' || SQLERRM;
END;
Begin
     select count(1) into v_count_pm_cp_units from xxpm_property_units  where unit_number=i.cp_unit_number;
     --and unit_type='CAR_PARKING';  

     DBMS_OUTPUT.PUT_LINE('UNIT NUMBER COUNT : ' || v_count_pm_cp_units);

if  (v_count_pm_cp_units>0) then
    Begin      
            DBMS_OUTPUT.PUT_LINE('BEFORE : ' || i.cp_unit_number);
			select unit_id,unit_number into v_cp_unit_id,v_cp_unit_number from xxpm_property_units 
			where unit_number=i.cp_unit_number; --and unit_type='CAR_PARKING';
            DBMS_OUTPUT.PUT_LINE('CP UNIT NUMBER VALIDATIOn:-' || v_cp_unit_id ||'' ||v_cp_unit_number );
    EXCEPTION
			WHEN OTHERS
			  THEN
               v_cp_unit_id := ''; 
			   v_ready_flag := 'V';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
    Begin
             update XXDM_PROPERTY_CARPARKS set cp_unit_id= v_cp_unit_id  where cp_unit_number=i.cp_unit_number 
             and batch_id=v_batch_id;
             commit;
    Exception
	WHEN OTHERS
	THEN
				   v_ready_flag := 'V';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;

else
    Begin      
            DBMS_OUTPUT.PUT_LINE('No Unit id : ' || i.cp_unit_number);
			select unit_number into v_cp_unit_number_dm from xxdm_property_units 
			where unit_number=i.cp_unit_number and batch_id=v_batch_id; --and unit_type='CAR_PARKING' 
            DBMS_OUTPUT.PUT_LINE('CP UNIT NUMBER VALIDATIOn:-' || v_cp_unit_number_dm );
    EXCEPTION
			WHEN OTHERS
			  THEN
               v_cp_unit_number_dm := ''; 
			   v_ready_flag := 'V';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

end if;
end;

    Begin
	select count(lookup_value_name) into v_lookup_carpark from xxfnd_lookup_v where lookup_type_name='CARPARK_TYPE' 
           and lookup_value_name=i.ALLOT_TYPE;
	Exception
	WHEN OTHERS
	THEN
				   v_lookup_carpark:='';
				   v_ready_flag := 'V';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;



if(v_unit_id is not null)  or (v_unit_number_dm is not null)then
    if(v_cp_unit_id is not null) or (v_cp_unit_number_dm is not null) then
        if (v_lookup_carpark >0) or (i.ALLOT_TYPE is null) then
           -- if (v_free_carpark_status = 'AVAL' and i.allot_type='FREE') or (v_paid_carpark_status = 'BOOK' and i.allot_type='PAID') then
           IF( i.allot_type='FREE') THEN
                    DBMS_OUTPUT.PUT_LINE ('ALL VALIDATION DONE');
                    v_unit_number:=i.unit_number;
                    v_err_reason:= v_err_reason;
                    update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
            else    
                 DBMS_OUTPUT.PUT_LINE ('UNIT NUMBER IS NOT AVAILABLE OR BOOKED');
                v_unit_number:=i.unit_number;
                v_ready_flag:='V';
                v_err_reason:= i.unit_number || ' :- UNIT NUMBER IS NOT AVAILBLE OR BOOKED TO PROVIDE THE FREE/PAID CAR PARKING';
              update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
            end if;    
       else     
             DBMS_OUTPUT.PUT_LINE ('UNIT NUMBER IS NOT HAVING MENTIONED ALLOT TYPE');
            v_unit_number:=i.unit_number;
            v_err_reason:= i.unit_number || ' :- UNIT NUMBER IS NOT HAVING THE MENTIONED ALLOT TYPE:-'|| i.allot_type;
            update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
       end if;
    else
          DBMS_OUTPUT.PUT_LINE ('UNIT NUMBER IS NOT PROPERTY UNIT TABLE FOR CARPARKING TYPE');
        v_unit_number:=i.unit_number;
        v_err_reason:= i.cp_unit_number || ' :- UNIT NUMBER IS NOT IN THE PROPERTY UNITS TABLE INTO CARPARKING UNIT TYPE';
        update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
    end if;                
else
    DBMS_OUTPUT.PUT_LINE ('UNIT NUMBER IS NOT PROPERTY UNIT TABLE');
    v_unit_number:=i.unit_number;
    v_err_reason:= i.unit_number || ' :- UNIT NUMBER IS NOT IN THE PROPERTY UNITS TABLE';
    update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
end if;        


if  i.unit_number is null   then
    DBMS_OUTPUT.PUT_LINE ('unit_number');
    v_unit_number:=i.unit_number;
    v_err_reason:=  '  unit_number should not be null ';
    update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
end if;

if  i.cp_unit_number is null   then
    DBMS_OUTPUT.PUT_LINE ('CARPARK_UNIT_NUMBER');
    v_unit_number:=i.unit_number;
    v_err_reason:=  '  CARPARK_UNIT_NUMBER should not be null ';
    update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
end if;

if  i.allot_type is null   then
    DBMS_OUTPUT.PUT_LINE (' allot_type is null ');
    v_unit_number:=i.unit_number;
    v_err_reason:=  '  allot_type should not be null ';
    update_carpark_temp(v_ready_flag,v_err_reason,v_errm,v_unit_number,v_batch_id);
end if;

END LOOP;
END xxpm_carpark_master_val;
---------------------------------------------
PROCEDURE update_carpark_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_unit_number IN varchar2,v_batch_id IN number)
as
Begin
            UPDATE   XXDM_PROPERTY_CARPARKS
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
                           ERR_DESCRIPTION= v_err_desc,
                           ERR_MSG=v_err_msg
            where   unit_number=v_unit_number and batch_id=v_batch_id ;  
            commit;
End update_carpark_temp;
--------------------------------------------
PROCEDURE insert_carpark_master (i_batch_id IN NUMBER)
as
cursor c_car_pa_dm
is
select 
    CARPARK_ID,
    UNIT_NUMBER,
    UNIT_ID,
    CP_UNIT_ID,
    CP_UNIT_NUMBER,
    ALLOT_TYPE,
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
from XXDM_PROPERTY_CARPARKS 
    where INTERFACE_STATUS_FLAG='V' and BATCH_ID=i_batch_id;
v_row_count number;
v_errm  varchar2(2000);
v_batch_id     NUMBER;
v_unit_id     varchar2(60);
v_cp_unit_id  varchar2(60);

begin
v_batch_id:=i_batch_id;
for i in c_car_pa_dm loop

      Begin
      select unit_id into v_unit_id from XXPM_PROPERTY_UNITS where
      unit_number=i.unit_number; 

     EXCEPTION
            WHEN OTHERS
			  THEN
               v_unit_id:='';
               v_errm := SQLCODE || '-' || SQLERRM;
      end;

      Begin
      select unit_id into v_cp_unit_id from XXPM_PROPERTY_UNITS where
      unit_number=i.cp_unit_number ;--and unit_type='CAR_PARKING';

      EXCEPTION
            WHEN OTHERS
			  THEN
               v_unit_id:='';
               v_errm := SQLCODE || '-' || SQLERRM;
      end;

update XXPM_PROPERTY_CARPARKS 
set 
allot_type=i.allot_type,
CREATED_BY=i.CREATED_BY,
CREATION_DATE=i.CREATION_DATE,
LAST_UPDATED_BY=i.LAST_UPDATED_BY,
LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
where CARPARK_ID=i.CARPARK_ID;
v_row_count:=SQL%ROWCOUNT;


if (v_row_count =0) then

DBMS_OUTPUT.PUT_LINE('UNIT_ID ' || v_unit_id ||'CP UNIT ID ' || v_cp_unit_id);
insert into XXPM_PROPERTY_CARPARKS 
   (CARPARK_ID,
    UNIT_ID,
    CP_UNIT_ID,
    ALLOT_TYPE,
    CREATED_BY,
    CREATION_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN) 
    values
    (   XXPM_CARPARK_ID_S.nextval,
        v_unit_id,
        v_cp_unit_id,
        i.ALLOT_TYPE,
        i.CREATED_BY,
        i.CREATION_DATE,
        i.LAST_UPDATED_BY,
        i.LAST_UPDATE_DATE,
        i.LAST_UPDATE_LOGIN);
end if;

   UPDATE   XXDM_PROPERTY_CARPARKS
             SET     
		    INTERFACE_STATUS_FLAG='P',
            ERR_DESCRIPTION= null,
            ERR_MSG=null
            where   
            unit_number=i.unit_number and batch_id=v_batch_id; 

   update  XXPM_PROPERTY_UNITS
   set
   status ='ALOT'
   where unit_id=v_cp_unit_id;


END LOOP;
commit;
END insert_carpark_master;
----------------------------------------------
END XXPM_CARPARK_MASTER_PKG;

/
