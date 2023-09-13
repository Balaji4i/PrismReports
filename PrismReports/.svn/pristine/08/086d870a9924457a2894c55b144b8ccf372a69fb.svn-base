CREATE OR REPLACE PACKAGE "XXPM_UNIT_MASTER_PKG" 

IS
   PROCEDURE xxpm_unit_master_val(i_batch_id IN NUMBER);
   PROCEDURE update_unit_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_property_number IN varchar2,
                               v_build_number IN varchar2,v_unit_number IN varchar2,v_batch_id IN number);
   PROCEDURE insert_unit_master (i_batch_id IN NUMBER);
   
   
   PROCEDURE CREATE_BLOCKING_FROM_EXCEL (P_PropertyId IN NUMBER, 
                                 P_build_id IN NUMBER,
                                 P_unit_id IN NUMBER);

END XXPM_UNIT_MASTER_PKG;
/


CREATE OR REPLACE PACKAGE BODY "XXPM_UNIT_MASTER_PKG" 
AS
PROCEDURE xxpm_unit_master_val (i_batch_id IN NUMBER)
AS
cursor c_unit_temp
        is
  SELECT
    property_number,
    build_number,
    unit_number,
    unit_name,
    unit_name_tl,
    unit_shortcode,
    func_id,
    doc_ref_number_1,
    doc_ref_number_2,
    doc_ref_number_3,
    floor_number,
    no_of_rooms,
    unit_type,
    status,
    unit_class,
    unit_category,
    description,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    saleable_yn,
    leaseable_yn,
    sale_available_yn,
    lease_available_yn,
    free_hold_yn,
    lease_hold_yn,
    list_for_brokers,
    list_for_internal,
    allot_type,
    batch_id,
    interface_status_flag,
    interface_id,
    err_msg,
    err_description,
    validated_by,
    validated_date,
    processed_by,
    processed_date,
    area_type,
    view_type,
    uom,
    vend_id,
    active_yn,
    property_id,
    build_id,
    unit_id,
    cp_unit_id
FROM
    xxdm_property_units
	where BATCH_ID=i_batch_id;

v_batch_id          NUMBER;
v_ready_flag        varchar2 (1);
v_property_id       number;
vu_property_id      number;
v_build_id          number;
v_property_number   varchar2 (60);
v_build_number      varchar2 (60);
v_err_reason        varchar2 (2000);
v_errm              varchar2 (2000);        
v_property_count    number;
v_unit_count        number;
v_count_units       number;
v_total_unit_count  number;
v_avail_unit_count   number;
v_lookup_floor      varchar2(60);
v_unit_type         varchar2(60);
v_unit_class        varchar2(60);
v_unit_category     varchar2(60);
v_unit_status       varchar2(60);
v_unit_short_code   number;
v_unit_number       varchar2(60);
v_unit_name         varchar2(240);
v_unitshort_code    varchar2(60);
v_unit_number_count        number;   

Begin
		v_batch_id := i_batch_id;

FOR i IN c_unit_temp LOOP
	v_ready_flag := 'V';
	v_err_reason:= '';
	v_errm := '';

    Begin      
			select property_id,property_number into v_property_id,v_property_number from xxpm_property_master 
			where property_number=i.property_number;
            DBMS_OUTPUT.PUT_LINE('PROPERTY VALIDATION DONE');
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
             DBMS_OUTPUT.PUT_LINE('BUILDING VALIDATION DONE');
	EXCEPTION
			WHEN OTHERS
			  THEN
			   v_build_id := ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
	BEGIN       
			select xb.property_id,xu.property_id,xb.build_id,xu.property_number,xb.build_number 
			into v_property_id,vu_property_id,v_build_id,v_property_number,v_build_number  
			from xxpm_property_master xu, xxpm_property_buildings xb
			where xu.property_id=xb.PROPERTY_ID
			and xb.build_number=i.build_number
			and xu.property_number=i.property_number;

             DBMS_OUTPUT.PUT_LINE('PROPERTY AND BUILDING VALIDATION DONE');

	EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

    Begin

    update XXDM_PROPERTY_UNITS set property_id= v_property_id,build_id=v_build_id
    where
    build_number=i.build_number and property_number=i.property_number and batch_id=v_batch_id;

    commit;
    Exception
	WHEN OTHERS
	THEN
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;
    Begin
        select count(1) into v_property_count from XXDM_PROPERTY_UNITS where property_number=i.property_number and batch_id=v_batch_id;

        select count(1) into v_avail_unit_count from XXDM_PROPERTY_UNITS DM,XXPM_PROPERTY_UNITS PM where
        DM.UNIT_NUMBER=PM.UNIT_NUMBER and batch_id=v_batch_id; 

        select count(1) into v_unit_count from XXPM_PROPERTY_UNITS where property_id=vu_property_id;

        select nvl(no_of_units,0) into v_count_units from xxpm_property_master where property_number=i.property_number;



        v_total_unit_count:=abs(v_property_count-v_avail_unit_count)+v_unit_count;


        DBMS_OUTPUT.PUT_LINE('PROPERTY COUNT VALIDATION DONE');

	Exception
	WHEN OTHERS
	THEN
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;
	Begin
	select count(lookup_value_name) into v_lookup_floor from xxfnd_lookup_v where lookup_type_name='FLOOR_TYPE'  and lookup_value_name=i.FLOOR_NUMBER;

     DBMS_OUTPUT.PUT_LINE('FLOOR VALIDATION DONE');

	Exception
	WHEN OTHERS
	THEN
				   v_lookup_floor:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;
	Begin
	select count(lookup_value_name) into v_unit_type from xxfnd_lookup_v where lookup_type_name='UNIT_TYPE'  and lookup_value_name=i.UNIT_TYPE;
     DBMS_OUTPUT.PUT_LINE('UNIT TYPE VALIDATION DONE');

	Exception
	WHEN OTHERS
	THEN
				   v_unit_type:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;
	Begin
	select count(lookup_value_name) into v_unit_class from xxfnd_lookup_v where lookup_type_name='UNIT_CLASS'  and lookup_value_name=i.UNIT_CLASS;
	 DBMS_OUTPUT.PUT_LINE('UNIT CLASS VALIDATION DONE');

    Exception
	WHEN OTHERS
	THEN
				   v_unit_class:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;
	Begin
	select count(lookup_value_name) into v_unit_category from xxfnd_lookup_v where lookup_type_name='UNIT_CATEGORY'  and lookup_value_name=i.UNIT_CATEGORY;
	 DBMS_OUTPUT.PUT_LINE('UNIT CATEGORY VALIDATION DONE');

    Exception
	WHEN OTHERS
	THEN
				   v_unit_category:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;
	Begin
	select count(lookup_value_name) into v_unit_status from xxfnd_lookup_v where lookup_type_name='UNIT_STATUS'  and lookup_value_name=i.STATUS;
	 DBMS_OUTPUT.PUT_LINE('UNIT STATUS VALIDATION DONE');

    Exception
	WHEN OTHERS
	THEN
				   v_unit_status:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;

    Begin

    select count(1) into v_unit_number_count from XXDM_PROPERTY_UNITS 
    where build_number=i.build_number
			and property_number=i.property_number
            and unit_number=i.unit_number
            and batch_id=v_batch_id;

     DBMS_OUTPUT.PUT_LINE('COUNT OF UNIT VALIDATION DONE');
    Exception
    WHEN OTHERS
	THEN
				   v_unit_status:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;

    Begin

    select count(1) into v_unit_short_code from XXDM_PROPERTY_UNITS 
    where build_number=i.build_number
			and property_number=i.property_number
            and unit_shortcode=i.unit_shortcode
            and batch_id=v_batch_id;

 DBMS_OUTPUT.PUT_LINE('SHORT CODE VALIDATION DONE');
    Exception
    WHEN OTHERS
	THEN
				   v_unit_status:='';
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
	End;

    v_unit_number:=i.unit_number;
    v_unit_name:=i.unit_name;
    v_unitshort_code:=i.unit_shortcode;

DBMS_OUTPUT.PUT_LINE('Unit Number '  || v_unit_number);

if (v_property_id is not null) then
	if (v_build_id is not null) then
        if(v_property_id = vu_property_id)   then
            if (v_total_unit_count <= v_count_units) then
                if (v_lookup_floor >0) or (i.floor_number is null) then
                    if (v_unit_type>0) or (i.unit_type is null) then  
                        if (v_unit_class>0) or (i.unit_class is null)then
                            if (v_unit_category>0) or (i.unit_category is null) then
								if (v_unit_status>0) or (i.status is  null) then
                                   if (v_unit_number_count=1) then
                                      if (v_unit_short_code = 1) then
                                         if (v_unit_name is not null) and (v_unit_number is not null) and (v_unitshort_code is not null) then
                                            DBMS_OUTPUT.PUT_LINE('ALL VALIDATION DONE');
                                            v_property_number:=i.property_number;
                                            v_build_number:=i.build_number;
                                            v_unit_number:=i.unit_number;
                                            v_err_reason:= v_err_reason;
                                            update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                                         else 
                                            DBMS_OUTPUT.PUT_LINE(v_unit_number ||'-' ||v_unit_name||'-' || v_unitshort_code);
                                            v_property_number:=i.property_number;
                                            v_build_number:=i.build_number;
                                            v_ready_flag:='E';
                                            v_err_reason:= 'UNIT NAME OR NUMBER OR SHORTCODE IS NULL';
                                               update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                                         end if;    
                                      else
                                            DBMS_OUTPUT.PUT_LINE('DUPLICATE SHORT CODE');
                                            v_property_number:=i.property_number;
                                            v_build_number:=i.build_number;
                                            v_ready_flag:='E';
                                            v_err_reason:= 'DUPLICATE UNIT SHORT CODE FOR THE SAME PROPERTY AND BUILDING';
                                              update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                                      end if;
                                   else
                                       DBMS_OUTPUT.PUT_LINE('DUPLICATE UNIT NUMBER');
                                        v_property_number:=i.property_number;
                                        v_build_number:=i.build_number;
                                        v_ready_flag:='E';
                                        v_err_reason:= 'DUPLICATE UNIT NUMBER FOR THE SAME PROPERTY AND BUILDING';
                                           update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                                   end if; 
								else
                                        DBMS_OUTPUT.PUT_LINE('UNIT STATUS ISSUE');
                                        v_ready_flag:='E';
                                        v_property_number:=i.property_number;
                                        v_build_number:=i.build_number;
                                        v_err_reason:= i.property_number  ||  ':- Property is not having the mentioned Unit status ' || i.status;
                                          update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
								end if;
                            else
                              DBMS_OUTPUT.PUT_LINE('UNIT CATEGORY ISSUE');
                                v_ready_flag:='E';
                                v_property_number:=i.property_number;
                                v_build_number:=i.build_number;
                                v_err_reason:= i.property_number  ||  ':- Property is not having the mentioned Unit category ' || i.unit_category;
                                 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                            end if;
						else
                          DBMS_OUTPUT.PUT_LINE('UNIT CLASS ISSUE');
                            v_ready_flag:='E';
                            v_property_number:=i.property_number;
                            v_build_number:=i.build_number;
                            v_err_reason:= i.property_number  ||  ':- Property is not having the mentioned Unit class ' || i.unit_class;
                            DBMS_OUTPUT.PUT_LINE(v_ready_flag || ':-Flag' ||i.property_number  ||  ':- Property is not having the mentioned Unit class ' || i.unit_class);
                             update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                        end if;   
                    else
                          DBMS_OUTPUT.PUT_LINE('UNIT TYPE ISSUE');
                           v_ready_flag:='E';
                            v_property_number:=i.property_number;
                            v_build_number:=i.build_number;
                            v_err_reason:= i.property_number||':- Property is not having the mentioned Unit type ' ||i.unit_type;
                              update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                    end if;           
                else
                          DBMS_OUTPUT.PUT_LINE('FLOOR ISSUE');
                           v_ready_flag:='E';
                        v_property_number:=i.property_number;
                        v_build_number:=i.build_number;
                        v_err_reason:= i.property_number  ||  ':- Property is not having the mentioned Floor ' || i.FLOOR_NUMBER;
                        update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                end if;
            else         
                  DBMS_OUTPUT.PUT_LINE('PROPERTY COUNT MORE THAN UNITS ALLOTED');
                v_property_number:=i.property_number;
                v_build_number:=i.build_number;
                v_ready_flag:='E';
                v_err_reason:= i.property_number  ||  ':- Property Count is more than no of units alloted';
                 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);

            end if;
        else
              DBMS_OUTPUT.PUT_LINE('PROPERTY BUILDING NOT RELATED');
                v_property_number:=i.property_number;
                v_build_number:=i.build_number;
                v_err_reason:= i.property_number  ||  ':- PROPERTY NUMBER IS NOT BELONGS TO THE '|| i.BUILD_NUMBER  ||':- BUILDING NUMBER';
                  update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
        end if;
	else
          DBMS_OUTPUT.PUT_LINE('BUILD NUMBER NOT AVAILABLE');
        v_property_number:=i.property_number;
        v_build_number:=i.build_number;
        v_err_reason:= i.build_number || ' :- BUILD NUMBER IS NOT IN THE BUILD MASTER TABLE';
          update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
	end if;
else 
      DBMS_OUTPUT.PUT_LINE('PROPERTY NUMBER NOT AVAILABLE');
	v_property_number:=i.property_number;
    v_build_number:=i.build_number;
    v_err_reason:= i.property_number || ' :- PROPERTY NUMBER IS NOT IN THE PROPERTY MASTER TABLE';
      update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
end if;   




--------------------Mandatory Validations --------------

 if i.UNIT_NAME is null then
DBMS_OUTPUT.PUT_LINE('UNIT_NAME is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- UNIT_NAME should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;


 if i.UNIT_SHORTCODE is null then
DBMS_OUTPUT.PUT_LINE('UNIT_SHORTCODE is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- UNIT_SHORTCODE should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;

if i.FLOOR_NUMBER is null then
    DBMS_OUTPUT.PUT_LINE('FLOOR_NUMBER is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- FLOOR_NUMBER should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;

 if i.UNIT_TYPE is null then
DBMS_OUTPUT.PUT_LINE('UNIT_TYPE is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- UNIT_TYPE should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;

-- if i.area_type is null then
--DBMS_OUTPUT.PUT_LINE('area_type is null ');
--v_ready_flag:='E';
--v_build_number:=i.build_number;
--v_property_number:=i.property_number;
--v_err_reason:=  ':- area_type should not be null ' ;
-- update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
--  end if;

 if i.view_type is null then
DBMS_OUTPUT.PUT_LINE('view_type is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- view_type should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;

 if i.status is null then
DBMS_OUTPUT.PUT_LINE('status is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- status should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;



 if i.unit_category is null then
DBMS_OUTPUT.PUT_LINE('unit_category is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- unit_category should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;

 if i.saleable_yn is null then
DBMS_OUTPUT.PUT_LINE('saleable_yn is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- saleable_yn should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;

 if i.leaseable_yn is null then
DBMS_OUTPUT.PUT_LINE('leaseable_yn is null ');
v_ready_flag:='E';
v_build_number:=i.build_number;
v_property_number:=i.property_number;
v_err_reason:=  ':- leaseable_yn should not be null ' ;
 update_unit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
  end if;









END LOOP;
commit;
End xxpm_unit_master_val;
---------------------------
PROCEDURE update_unit_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_property_number IN varchar2,
                             v_build_number IN varchar2,v_unit_number IN varchar2,v_batch_id IN number)
as
Begin
            UPDATE   XXDM_PROPERTY_UNITS
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
                           ERR_DESCRIPTION= v_err_desc,
                           ERR_MSG=v_err_msg
            where   property_number=v_property_number and build_number=v_build_number and
            unit_number=v_unit_number and  batch_id=v_batch_id  ;  


            IF v_status_flag ='E' THEN


              UPDATE   XXDM_PROPERTY_AREA
        SET     
		    INTERFACE_STATUS_FLAG=v_status_flag,
            ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
            ERR_MSG=v_err_msg
        where   
		    property_number=v_property_number AND build_number=v_build_number 
            and unit_number=v_unit_number and batch_id=v_batch_id  ;  


              UPDATE   XXDM_PROPERTY_CARPARKS
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
                           ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
                           ERR_MSG=v_err_msg
            where   unit_number=v_unit_number and batch_id=v_batch_id ;  


              UPDATE XXDM_PROPERTY_FEATURES
    SET INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
      ERR_MSG                =v_err_msg
    WHERE property_number    =v_property_number
    AND build_number         =v_build_number
    AND batch_id         =v_batch_id
     AND unit_number    =v_unit_number;


      UPDATE XXDM_PROPERTY_FIX_FITTINGS
    SET INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
      ERR_MSG                =v_err_msg
    WHERE property_number    =v_property_number
    AND build_number        =v_build_number
    AND unit_number           =v_unit_number
    AND batch_id             =v_batch_id;



            end if;




            commit;
End update_unit_temp;
---------------------------------------------
procedure insert_unit_master (i_batch_id IN NUMBER)
as
cursor c_unit_dm
is
        select 
        PROPERTY_NUMBER,
        BUILD_NUMBER,
        UNIT_NUMBER,
        PROPERTY_ID,
        BUILD_ID,
        UNIT_ID,
        UNIT_NAME,
        UNIT_NAME_TL,
        UNIT_SHORTCODE,
        FUNC_ID,
        DOC_REF_NUMBER_1,
        DOC_REF_NUMBER_2,
        DOC_REF_NUMBER_3,
        FLOOR_NUMBER,
        NO_OF_ROOMS,
        UNIT_TYPE,
        VIEW_TYPE,
        AREA_TYPE,
        UOM,
        STATUS,
        UNIT_CLASS,
        UNIT_CATEGORY,
        DESCRIPTION,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        ACTIVE_YN,
        VEND_ID,
        SALEABLE_YN,
        LEASEABLE_YN,
        SALE_AVAILABLE_YN,
        LEASE_AVAILABLE_YN,
        FREE_HOLD_YN,
        LEASE_HOLD_YN,
        LIST_FOR_BROKERS,
        LIST_FOR_INTERNAL,
        ALLOT_TYPE,
        BATCH_ID,
        INTERFACE_STATUS_FLAG,
        INTERFACE_ID,
        ERR_MSG,
        ERR_DESCRIPTION,
        VALIDATED_BY,
        VALIDATED_DATE,
        PROCESSED_BY,
        PROCESSED_DATE
        from XXDM_PROPERTY_UNITS where INTERFACE_STATUS_FLAG='V' and batch_id=i_batch_id;

        cursor cur_feature_property(p_property_id in number)
        is
        SELECT
    property_id,
    build_id,
    unit_id,
    feature_type,
    description,
    feature_condition,
    uom,
    value,
    active_yn,
    attribute_category,
    attribute1,
    attribute2,
    attribute3,
    attribute4,
    attribute5,
    attribute6,
    attribute7,
    attribute8,
    attribute9,
    attribute10,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    quantity,
    rate
FROM
    xxpm_property_features
WHERE
    property_id =p_property_id
    AND build_id IS NULL
    AND unit_id IS NULL;

        cursor cur_feature_building(p_property_id in number,p_build_id in number)
        is
        SELECT
    property_id,
    build_id,
    unit_id,
    feature_type,
    description,
    feature_condition,
    uom,
    value,
    active_yn,
    attribute_category,
    attribute1,
    attribute2,
    attribute3,
    attribute4,
    attribute5,
    attribute6,
    attribute7,
    attribute8,
    attribute9,
    attribute10,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    quantity,
    rate
FROM
    xxpm_property_features
WHERE
    property_id =p_property_id
    AND build_id =p_build_id
    AND unit_id IS NULL;

v_row_count number;
v_errm  varchar2(2000);
v_property_id number;
v_build_id number;
v_property_number varchar2(100);
v_build_number varchar2(100);
v_batch_id     NUMBER;
l_unit_id     number;
v_interface_id number;

begin
v_batch_id:=i_batch_id;
select iface_id into v_interface_id from xxdm_interface_master where iface_name='PROPERTY FEATURES';
for i in c_unit_dm loop

            update XXPM_PROPERTY_UNITS set 
            UNIT_NAME=i.UNIT_NAME,
            UNIT_NAME_TL=i.UNIT_NAME_TL,
            UNIT_SHORTCODE=i.UNIT_SHORTCODE,
            DOC_REF_NUMBER_1=i.DOC_REF_NUMBER_1,
            DOC_REF_NUMBER_2=i.DOC_REF_NUMBER_2,
            DOC_REF_NUMBER_3=i.DOC_REF_NUMBER_3,
            FLOOR_NUMBER=i.FLOOR_NUMBER,
            NO_OF_ROOMS=i.NO_OF_ROOMS,
            UNIT_TYPE=i.UNIT_TYPE,
            AREA_TYPE=i.AREA_TYPE,
            VIEW_TYPE=i.VIEW_TYPE,
            UOM=i.UOM,
            STATUS=i.STATUS,	
            UNIT_CLASS=i.UNIT_CLASS,	
            UNIT_CATEGORY=i.UNIT_CATEGORY,	
            VEND_ID=i.VEND_ID,	
            DESCRIPTION=i.DESCRIPTION,	
            ACTIVE_YN=i.ACTIVE_YN,
            SALEABLE_YN=i.SALEABLE_YN,
            LEASEABLE_YN=i.LEASEABLE_YN,	
            SALE_AVAILABLE_YN=i.SALE_AVAILABLE_YN,	
            LEASE_AVAILABLE_YN=i.LEASE_AVAILABLE_YN,	
            FREE_HOLD_YN=i.FREE_HOLD_YN,
            LEASE_HOLD_YN=i.LEASE_HOLD_YN,	
            LIST_FOR_BROKERS=i.LIST_FOR_BROKERS,	
            LIST_FOR_INTERNAL=i.LIST_FOR_INTERNAL,	
            ALLOT_TYPE=i.ALLOT_TYPE,
            CREATED_BY=i.CREATED_BY,
            CREATION_DATE=i.CREATION_DATE,
            LAST_UPDATED_BY=i.LAST_UPDATED_BY,
            LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
            LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
            where UNIT_NUMBER=i.unit_number;

v_row_count:=SQL%ROWCOUNT;

DBMS_OUTPUT.PUT_LINE('Unit number:- '  ||i.unit_number || 'Row Count:- ' ||v_row_count);

if (v_row_count =0) then
l_unit_id :=XXPM_UNIT_ID_S.nextval;
            insert into XXPM_PROPERTY_UNITS (unit_id,property_id,build_id,unit_number,unit_name,unit_shortcode,floor_number,func_id,
            CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,
            UNIT_NAME_TL,		
            DOC_REF_NUMBER_1,	
            DOC_REF_NUMBER_2,	
            DOC_REF_NUMBER_3,	
            NO_OF_ROOMS,		
            UNIT_TYPE,			
            AREA_TYPE,			
            VIEW_TYPE,			
            UOM,			
            STATUS,				
            UNIT_CLASS,			
            UNIT_CATEGORY,		
            VEND_ID,				
            DESCRIPTION,			
            ACTIVE_YN,			
            SALEABLE_YN,			
            LEASEABLE_YN,		
            SALE_AVAILABLE_YN,	
            LEASE_AVAILABLE_YN,	
            FREE_HOLD_YN,		
            LEASE_HOLD_YN,		
            LIST_FOR_BROKERS,	
            LIST_FOR_INTERNAL,	
            ALLOT_TYPE			
            )
            values 
            (l_unit_id,
            i.property_id,
            i.build_id,
            i.UNIT_NUMBER,
            i.unit_name,
            i.unit_shortcode,
            i.FLOOR_NUMBER,
            i.FUNC_ID,
            i.created_by,
            i.CREATION_DATE,
            i.last_updated_by,
            i.LAST_UPDATE_DATE,
            i.LAST_UPDATE_LOGIN,
            i.UNIT_NAME_TL,
            i.DOC_REF_NUMBER_1,
            i.DOC_REF_NUMBER_2,
            i.DOC_REF_NUMBER_3,
            i.NO_OF_ROOMS,
            i.UNIT_TYPE,
            i.AREA_TYPE,
            i.VIEW_TYPE,
            i.UOM,
            i.STATUS,	
            i.UNIT_CLASS,	
            i.UNIT_CATEGORY,	
            i.VEND_ID,	
            i.DESCRIPTION,	
            i.ACTIVE_YN,
            i.SALEABLE_YN,
            i.LEASEABLE_YN,	
            i.SALE_AVAILABLE_YN,	
            i.LEASE_AVAILABLE_YN,	
            i.FREE_HOLD_YN,
            i.LEASE_HOLD_YN,	
            i.LIST_FOR_BROKERS,	
            i.LIST_FOR_INTERNAL,	
            i.ALLOT_TYPE
            );
        if(i.STATUS ='MNG_BLOCK') then
         XXPM_UNIT_MASTER_PKG.CREATE_BLOCKING_FROM_EXCEL(i.property_id,i.build_id,l_unit_id);
        end if;
        
            for p in cur_feature_property (i.property_id)
            loop

            insert
    INTO xxdm_property_features (
        property_number,
        build_number,
        unit_number,
        feature_type,
        description,
        feature_condition,
        uom,
        value,
        quantity,
        rate,
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
        build_id,
        property_id,
        unit_id
    )
    values(
   i.property_number,                 --PROPERTY_NUMBER
i.build_number,                      --BUILD_NUMBER
i.unit_number,                    --UNIT_NUMBER
p.feature_type,               --        feature_type,
p.description,               --        description,
p.feature_condition,               --        feature_condition,
p.uom,                         --        uom,
p.value,                           --        value,
p.quantity,                    --        quantity,
p.rate,                         --        rate,
'anonymous',                                    --        created_by,
SYSDATE,                        --        creation_date,
'anonymous',                           --        last_updated_by,
SYSDATE,                        --        last_update_date,
'anonymous',                               --        last_update_login,
i.batch_id,                         --        batch_id,
'V',                           --        interface_status_flag,
v_interface_id,                                   --        interface_id,
' inserted using unit ',--        err_msg,
NULL,                               --        err_description,
NULL,                                    --        validated_by,
sysdate,                                    --        validated_date,
NULL,                       --        processed_by,
NULL     ,            --        processed_date,
i.build_id,          --build_id
i.property_id,                    --        property_id,
l_unit_id                                --        unit_id
 ) ;



            end loop;

          for b in cur_feature_building  (i.property_id ,i.build_id)
            loop


          insert
    INTO xxdm_property_features (
        property_number,
        build_number,
        unit_number,
        feature_type,
        description,
        feature_condition,
        uom,
        value,
        quantity,
        rate,
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
        build_id,
        property_id,
        unit_id
    )
    values(
   i.property_number,                 --PROPERTY_NUMBER
i.build_number,                      --BUILD_NUMBER
i.unit_number,                    --UNIT_NUMBER
b.feature_type,               --        feature_type,
b.description,               --        description,
b.feature_condition,               --        feature_condition,
b.uom,                         --        uom,
b.value,                           --        value,
b.quantity,                    --        quantity,
b.rate,                         --        rate,
'anonymous',                                    --        created_by,
SYSDATE,                        --        creation_date,
'anonymous',                           --        last_updated_by,
SYSDATE,                        --        last_update_date,
'anonymous',                               --        last_update_login,
i.batch_id,                         --        batch_id,
'V',                           --        interface_status_flag,
v_interface_id,                                   --        interface_id,
' inserted using unit ',--        err_msg,
NULL,                               --        err_description,
'anonymous',                                    --        validated_by,
SYSDATE,                                    --        validated_date,
NULL,                       --        processed_by,
NULL      ,          --        processed_date,
i.build_id  ,                      --        build_id,
i.property_id,                    --        property_id,
l_unit_id                                --        unit_id
 ) ;
 
            end loop;

end if;
            UPDATE   XXDM_PROPERTY_UNITS
            SET            INTERFACE_STATUS_FLAG='P',
                           ERR_DESCRIPTION= null,
                           ERR_MSG=null
            where   property_number=i.property_number
                     and build_number=i.build_number and
            unit_number=i.unit_number and  batch_id=v_batch_id  ;   

END LOOP;
commit;
END insert_unit_master;
------------------------------------------
procedure CREATE_BLOCKING_FROM_EXCEL (P_PropertyId IN NUMBER, 
                                 P_build_id IN NUMBER,
                                 P_unit_id IN NUMBER)
as
l_count number;
l_block_id number:=XXPM_BLOCK_HEADER_S.nextval;
l_ORG_ID number;
BEGIN
begin
SELECT ORG_ID into l_ORG_ID
FROM 
xxpm_property_master where PROPERTY_ID=P_PropertyId;
end;
begin
SELECT COUNT(*) into l_count
FROM xxpm_block_detail 
WHERE 
UNBLOCK_ID is null
and PROPERTY_ID=P_PropertyId 
and BUILD_ID=P_build_id 
and UNIT_ID=P_unit_id;
end;
if(l_count=0) then
INSERT INTO xxpm_block_header (
    block_id,
    block_number,
    valid_upto,
    block_date,
    block_type,
    org_id,
    status,
    description,
    func_id,
    property_id,
    receipt_yn,
    usage,
    created_by,
    created_date,
    last_updated_by,
    last_update_date,
    last_update_login
) VALUES (
     l_block_id,
    'BL-'||l_block_id,
    sysdate,
    sysdate+180,
    'MB',
    l_ORG_ID,
    'APR',
    'From Excel upload',
    18,
    P_PropertyId,
    'N',
    'S',
    'Projects',
    sysdate,
    'Projects',
    sysdate,
    'Projects'
);
INSERT INTO xxpm_block_detail (
    block_dtl_id,
    block_id,
    property_id,
    build_id,
    unit_id,
    created_by,
    created_date,
    last_updated_by,
    last_update_date,
    last_update_login
) VALUES (
    XXPM_BLOCK_DETAIL_S.nextval,
    l_block_id,
    P_PropertyId,
    P_build_id,
    P_unit_id,
    'Projects',
    sysdate,
    'Projects',
     sysdate,
    'Projects'
);
end if;  
END CREATE_BLOCKING_FROM_EXCEL;
END XXPM_UNIT_MASTER_PKG;
/
