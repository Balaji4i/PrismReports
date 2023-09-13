--------------------------------------------------------
--  DDL for Package XXPM_PL_QUALIFIER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PL_QUALIFIER_PKG" 
IS
  PROCEDURE xxpm_pl_qualifier_val(
      i_batch_id IN NUMBER);
 PROCEDURE update_pl_qualifier_temp (v_status_flag IN VARCHAR2,v_err_desc IN VARCHAR2,v_err_msg IN VARCHAR2,v_rowid IN VARCHAR2,
                                    v_qlfy_id IN number,v_batch_id IN number);
  PROCEDURE insert_pl_qualifier (i_batch_id IN NUMBER);
  
  procedure insert_history(v_batch_id IN NUMBER ,v_PL_QLFY_ID in number);
  
END XXPM_PL_QUALIFIER_PKG;


--------------------------------------------------------
--  DDL for Package Body XXPM_PL_QUALIFIER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_PL_QUALIFIER_PKG" 
IS
PROCEDURE xxpm_pl_qualifier_val(i_batch_id IN NUMBER)
  as
  cursor c_plqualifer_temp
  is
  SELECT 
  rowid,
        PL_QLFY_ID,
        PL_MOD_ID,
        QLFY_ID,
        START_DATE,
        END_DATE,
        REVISION_NO,
        REVISION_DATE,
        REVISED_BY,
        ACTIVE_YN,
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
    from xxdm_pl_qualifiers
    WHERE BATCH_ID=i_batch_id
    and INTERFACE_STATUS_FLAG != 'E';

v_ready_flag varchar2(10);
v_errm       varchar2(2000);
v_err_reason  varchar2(2000);
v_batch_id   number;
v_pl_mod_id       number;  
v_qlfy_id       number;
v_plqlfy_id     number;
v_qua_id_pl   number;
v_pl_id_qua   number;
v_pl_qlfy_count number;
v_start_date   DATE;
v_end_date     DATE;
v_pl_number   varchar2(50);
L_CNT NUMBER;

begin
    v_batch_id:=i_batch_id;

FOR i IN c_plqualifer_temp LOOP
    v_ready_flag := 'V';
	v_err_reason:= '';
	v_errm := '';
    Begin      
            SELECT pl_mod_id INTO v_pl_mod_id FROM XXPM_PL_MODIFIERS WHERE pl_mod_id=i.pl_mod_id;
            DBMS_OUTPUT.PUT_LINE(v_pl_mod_id||'   ' ||i.pl_mod_id);        
    EXCEPTION
			WHEN OTHERS
			  THEN
               v_pl_mod_id := null; 
      DBMS_OUTPUT.PUT_LINE(v_pl_mod_id||' ex  ' ||i.pl_mod_id);        
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '- 2' || SQLERRM;
	END;
  
  
  ------
  IF  v_pl_mod_id IS NULL THEN
   BEGIN 
         dbms_output.put_line( ' v_pl_number '  ||v_pl_number );

  SELECT xpm.PL_MOD_NUMBER into v_pl_number FROM   xxdm_pl_modifiers xpm ,xxdm_pl_qualifiers xpq  WHERE xpm.PL_MOD_NUMBER = xpq.PL_MOD_NUMBER
     AND  xpm.BATCH_ID = xpq.BATCH_ID
      AND xpm.BATCH_ID =i.BATCH_ID
      and xpq.rowid  = i.rowid;
      dbms_output.put_line( 'v_pl_number '  ||v_pl_number );
      
      v_errm :='';
      			   v_ready_flag := 'V';

        EXCEPTION
			WHEN OTHERS
			  THEN
               v_pl_number := ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '- 1' || SQLERRM;
         
	END;
  
  
  
  
  end if;
  
  
  
  
  
  
  
  
    Begin      
			select qlfy_id into v_qlfy_id from xxpm_qualifiers where qlfy_id=i.qlfy_id;
            DBMS_OUTPUT.PUT_LINE(v_qlfy_id);

   	EXCEPTION
			WHEN OTHERS
			  THEN
               v_qlfy_id:= ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '- 3' || SQLERRM;
	END;

    BEGIN
        SELECT start_date,
          end_date
        INTO v_start_date,
          v_end_date
        FROM xxdm_pl_qualifiers
        WHERE rowid=i.rowid
        AND batch_id    = i.batch_id;
          DBMS_OUTPUT.PUT_LINE('Start Date '||v_start_date||','||'End Date '||v_end_date);
      EXCEPTION
      WHEN OTHERS THEN
        v_ready_flag := 'E';
        v_errm       := SQLCODE || '- 4' || SQLERRM;
      END;


    Begin      
			select count(1) into v_pl_qlfy_count from xxpm_pl_qualifiers where pl_qlfy_id=i.pl_qlfy_id;

            if ( v_pl_qlfy_count = 1 ) then            
              select distinct qua.qlfy_id,mo.pl_mod_id into v_qua_id_pl,v_pl_id_qua from xxpm_pl_qualifiers qua,xxpm_pl_modifiers mo,xxpm_qualifiers qu
              where mo.pl_mod_id=qua.pl_mod_id
              and qu.qlfy_id=qua.qlfy_id
              and qu.qlfy_id=i.qlfy_id
              and mo.pl_mod_id=i.pl_mod_id;
            end if; 

	EXCEPTION
			WHEN OTHERS
			  THEN
               v_qua_id_pl:='';
               v_pl_id_qua:='';
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '- 5' || SQLERRM;
	END;
    
    
    
    IF I.PL_QLFY_ID IS NULL  THEN
    
L_CNT := 0;    
    ELSE
    L_CNT := 1;    

    END IF ;


if(v_pl_mod_id is not null)   then
   IF (v_qlfy_id IS NOT NULL) THEN
  
       if(v_qua_id_pl is not null) and (v_pl_id_qua is not null) then
          if(v_start_date < v_end_date) then
          
          IF L_CNT > 0 THEN
          
                DBMS_OUTPUT.PUT_LINE('All condition passed');    
                v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
        
        ELSE
         v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
        
                IF   TRUNC(SYSDATE) <= TRUNC(v_start_date) THEN
                 v_ready_flag      := 'V';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);

                 ELSE
              v_ready_flag := 'E';
      v_err_reason       := 'start_date  CANNOT BE LESS THAN SYSDATE';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
                 
             
                END IF;
      
        
        
        END IF;
        
          else
                v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
              v_ready_flag:='E';
              v_err_reason := 'Start date should be less than end date';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
          end if;
       ELSE 
       if (i.pl_qlfy_id is not null and i.pl_mod_id is not null and v_pl_qlfy_count  > 0) then
       			   v_ready_flag := 'E';
        v_plqlfy_id:=i.pl_qlfy_id;
           v_pl_mod_id:=i.pl_mod_id;
           v_qlfy_id:=i.qlfy_id;
           v_err_reason := 'QUALIFIER ID IS NOT LINKED WITH THE PL MOD ID';
           else
                 v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
             update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
       end if;
          
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.ROWID,v_qlfy_id,v_batch_id);
     
       end if;   
   else
         v_plqlfy_id:=i.pl_qlfy_id;
         v_pl_mod_id:=i.pl_mod_id;
         v_qlfy_id:=i.qlfy_id;
                			   v_ready_flag := 'E';
         v_err_reason := 'QUALIFIER ID IS NOT EXIST IN THE QUALIFIER MASTER TABLE';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
   END IF;     
elsif  (v_pl_number is not null) then
   if (v_qlfy_id is not null) then
       if(v_qua_id_pl is not null) and (v_pl_id_qua is not null) then
          if(v_start_date < v_end_date) then
                DBMS_OUTPUT.PUT_LINE('All condition passed');    
                v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
          else
                v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
              v_ready_flag:='E';
              v_err_reason := 'Start date should be less than end date';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
          end if;
       else 
       if(i.pl_qlfy_id is not null and i.pl_mod_id is not null) then
           v_plqlfy_id:=i.pl_qlfy_id;
           v_pl_mod_id:=i.pl_mod_id;
           v_qlfy_id:=i.qlfy_id;
           v_ready_flag:='E';
           v_err_reason := 'QUALIFIER ID IS NOT LINKED WITH THE PL MOD ID';
            update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
            else
                 v_plqlfy_id:=i.pl_qlfy_id;
                v_pl_mod_id:=i.pl_mod_id;
                v_qlfy_id:=i.qlfy_id;
             update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
            end if;
       end if;   
   else
         v_plqlfy_id:=i.pl_qlfy_id;
         v_pl_mod_id:=i.pl_mod_id;
         v_qlfy_id:=i.qlfy_id;
         v_ready_flag:='E';
         v_err_reason := 'QUALIFIER ID IS NOT EXIST IN THE QUALIFIER MASTER TABLE';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.ROWID,v_qlfy_id,v_batch_id);
   END IF;   
else
    v_plqlfy_id:=i.pl_qlfy_id;
    v_pl_mod_id:=i.pl_mod_id;
    v_qlfy_id:=i.qlfy_id;
     v_ready_flag:='E';
    v_err_reason := 'PL MOD ID  and pl number IS NOT EXIST IN THE PL MODIFIER TABLE';
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
END IF;  


----------------Mandatory validations ----------------
------------------------------------------------------




IF i.QLFY_ID is null then
    v_plqlfy_id:=i.pl_qlfy_id;
    v_pl_mod_id:=i.pl_mod_id;
    v_qlfy_id:=i.qlfy_id;
     v_ready_flag:='E';
    v_err_reason := 'QLFY_ID SHOULD NOT BE NULL';
    DBMS_OUTPUT.PUT_LINE(' QLFY_ID SHOULD NOT BE NULL ') ;
    
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
END IF; 

IF i.START_DATE is null then
    v_plqlfy_id:=i.pl_qlfy_id;
    v_pl_mod_id:=i.pl_mod_id;
    v_qlfy_id:=i.qlfy_id;
     v_ready_flag:='E';
    v_err_reason := 'START_DATE SHOULD NOT BE NULL';
    DBMS_OUTPUT.PUT_LINE(' START_DATE SHOULD NOT BE NULL ') ;
    
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
END IF; 

IF i.END_DATE is null then
    v_plqlfy_id:=i.pl_qlfy_id;
    v_pl_mod_id:=i.pl_mod_id;
    v_qlfy_id:=i.qlfy_id;
     v_ready_flag:='E';
    v_err_reason := 'END_DATE SHOULD NOT BE NULL';
    DBMS_OUTPUT.PUT_LINE(' END_DATE SHOULD NOT BE NULL ') ;
    
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
END IF; 


IF i.ACTIVE_YN is null then
    v_plqlfy_id:=i.pl_qlfy_id;
    v_pl_mod_id:=i.pl_mod_id;
    v_qlfy_id:=i.qlfy_id;
     v_ready_flag:='E';
    v_err_reason := 'ACTIVE_YN SHOULD NOT BE NULL';
    DBMS_OUTPUT.PUT_LINE(' ACTIVE_YN SHOULD NOT BE NULL ') ;
    
     update_pl_qualifier_temp(v_ready_flag,v_err_reason,v_errm,i.rowid,v_qlfy_id,v_batch_id);
END IF; 











END LOOP;
END xxpm_pl_qualifier_val;
---------------------------------
PROCEDURE update_pl_qualifier_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_rowid IN varchar2,
                                    v_qlfy_id IN number,v_batch_id IN number)
as
Begin
            UPDATE   xxdm_pl_qualifiers
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
                           ERR_DESCRIPTION= v_err_desc,
                           ERR_MSG=v_err_msg
            where  
--            pl_mod_id=v_pl_mod_id 
rowid =v_rowid 
--             qlfy_id=v_qlfy_id
--            and pl_qlfy_id=v_plqlfy_id
            and batch_id=v_batch_id ;  
            commit;
End update_pl_qualifier_temp;
-------------------------------------------------------
PROCEDURE insert_pl_qualifier (i_batch_id IN NUMBER)
as
cursor c_pl_qua_dm
is
            SELECT 
            rowid,
            PL_QLFY_ID,
            PL_MOD_ID,
            QLFY_ID,
            START_DATE,
            END_DATE,
            REVISION_NO,
            REVISION_DATE,
            REVISED_BY,
            ACTIVE_YN,
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
            PROCESSED_DATE,
            pl_mod_number
            from xxdm_pl_qualifiers
            where BATCH_ID=i_batch_id and INTERFACE_STATUS_FLAG='V';
v_row_count number;
v_errm  varchar2(2000);
v_batch_id     NUMBER;
l_PL_QLFY_ID NUMBER;
l_pl_mod_id  number;

begin
v_batch_id:=i_batch_id;
for i in c_pl_qua_dm loop




if(i.PL_QLFY_ID is not null) then
update xxpm_pl_qualifiers set
                             START_DATE=i.start_date,
                             END_DATE=i.end_date,
                             ACTIVE_YN=i.ACTIVE_YN,
--                             revision_no=nvl(revision_no+1,1),
                             revision_date=sysdate, 
                             CREATED_BY=i.CREATED_BY,
                             CREATION_DATE=i.CREATION_DATE,
                             LAST_UPDATED_BY=i.LAST_UPDATED_BY,
                             LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
                             LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
WHERE PL_QLFY_ID=i.PL_QLFY_ID;




insert_history(i.batch_id ,i.PL_QLFY_ID);
DBMS_OUTPUT.PUT_LINE(v_row_count);
end if;

l_pl_mod_id:=i.pl_mod_id;
IF l_pl_mod_id IS NULL THEN
select pl_mod_id into l_pl_mod_id  from xxdm_pl_modifiers where pl_mod_number = i.pl_mod_number and batch_id =i.batch_id;
end if;


IF(i.PL_QLFY_ID IS  NULL) THEN
l_PL_QLFY_ID:=XXPM_PL_QUALIFIERS_S.nextval;
            insert into xxpm_pl_qualifiers (PL_QLFY_ID,PL_MOD_ID,QLFY_ID,START_DATE,END_DATE,REVISION_NO,REVISION_DATE,REVISED_BY,
            ACTIVE_YN,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN)
            VALUES 
            (l_PL_QLFY_ID,l_pl_mod_id,i.qlfy_id,i.start_date,
            i.end_date,1,sysdate,i.revised_by,i.active_yn,i.created_by,i.creation_date,
            i.last_updated_by, i.LAST_UPDATE_DATE,i.LAST_UPDATE_LOGIN);
            
               UPDATE xxdm_pl_qualifiers SET PL_QLFY_ID =l_PL_QLFY_ID ,  INTERFACE_STATUS_FLAG ='P' WHERE ROWID = i.ROWID;

            commit;
            
            insert_history(i.batch_id ,l_PL_QLFY_ID);

end if;

   UPDATE xxdm_pl_qualifiers SET PL_QLFY_ID =l_PL_QLFY_ID ,  INTERFACE_STATUS_FLAG ='P' WHERE ROWID = i.ROWID;


END LOOP;
commit;
END insert_pl_qualifier;


PROCEDURE insert_history(v_batch_id IN NUMBER ,v_PL_QLFY_ID in number)
AS
CURSOR cur_dm_qualifier
IS
SELECT * FROM xxdm_pl_qualifiers
            where BATCH_ID=v_batch_id and PL_QLFY_ID=v_PL_QLFY_ID  AND nvl(History_insert,'N') ='N';
            
  CURSOR c_pl_master_h
   is
    SELECT    xph.PL_ID,
      xph.PL_NAME,
      xph.PL_NAME_TL,
      xph.DESCRIPTION,
      xph.ORG_ID,
      xph.FUNC_ID,
      xph.PL_TYPE,
      xph.PRIORITY,
      xph.USAGE,
      xph.CURRENCY_CODE,
      xph.START_DATE,
      xph.END_DATE,
      xph.REVISION_NO,
      xph.REVISION_DATE,
      xph.REVISED_BY,
      xph.STATUS,
      xph.FLOW_STATUS,
      xph.FLOW_LEVEL,
      xph.USER_GRP_ID,
      xph.BASE_PRICE_YN,
      xph.ACTIVE_YN,
      xph.CREATED_BY,
      xph.CREATION_DATE,
      xph.LAST_UPDATED_BY,
      xph.LAST_UPDATE_DATE,
      xph.LAST_UPDATE_LOGIN,
      xph.PL_NUMBER 
FROM 
xxpm_pl_qualifiers xpq ,
  xxpm_pl_modifiers xpm,
  xxpm_pl_header xph
WHERE xpq.pl_mod_id =xpm.pl_mod_id
  AND xpm.pl_id       =xph.pl_id
  AND xpq.PL_QLFY_ID =v_PL_QLFY_ID;
  
   CURSOR c_pl_history(p_pl_id_1 in number)
  IS
    SELECT 
      xpl.PLL_ID,
      xpl.PL_ID,
      xpl.PROPERTY_ID,
      xpl.BUILD_ID,
      xpl.UNIT_ID,
      xpl.UOM,
      xpl.BASE_PRICE,
      xpl.MIN_PRICE,
      xpl.START_DATE,
      xpl.END_DATE,
      xpl.REVISION_NO,
      xpl.REVISION_DATE,
      xpl.REVISED_BY,
      xpl.ACTIVE_YN,
      xpl.CREATED_BY,
      xpl.CREATION_DATE,
      xpl.LAST_UPDATED_BY,
      xpl.LAST_UPDATE_DATE,
      xpl.LAST_UPDATE_LOGIN
    FROM xxpm_pl_lines xpl 
    WHERE 
    xpl.PL_ID = p_pl_id_1;
    
     CURSOR c_pl_modifier_h(p_pl_id_2 in number)
    IS
   SELECT 
   xpm.PL_MOD_ID,
  xpm.PL_ID,
  xpm.MOD_ID,
  xpm.START_DATE,
  xpm.END_DATE,
  xpm.REVISION_NO,
  xpm.REVISION_DATE,
  xpm.REVISED_BY,
  xpm.ACTIVE_YN,
  xpm.CREATED_BY,
  xpm.CREATION_DATE,
  xpm.LAST_UPDATED_BY,
  xpm.LAST_UPDATE_DATE,
  xpm.LAST_UPDATE_LOGIN
FROM xxpm_pl_modifiers xpm 
WHERE xpm.pl_id =p_pl_id_2;

  CURSOR c_pl_qualifier_h(p_pl_id_3 in number)
    IS
    SELECT xpq.PL_QLFY_ID,
  xpq.PL_MOD_ID,
  xpq.QLFY_ID,
  xpq.START_DATE,
  xpq.END_DATE,
  xpq.REVISION_NO,
  xpq.REVISION_DATE,
  xpq.REVISED_BY,
  xpq.ACTIVE_YN,
  xpq.CREATED_BY,
  xpq.CREATION_DATE,
  xpq.LAST_UPDATED_BY,
  xpq.LAST_UPDATE_DATE,
  xpq.LAST_UPDATE_LOGIN
  FROM xxpm_pl_qualifiers xpq ,
  xxpm_pl_modifiers xpm
WHERE xpq.pl_mod_id =xpm.pl_mod_id
  AND xpm.pl_id       =p_pl_id_3;
  
  l_pl_id NUMBER;
  l_revision_no NUMBER;
  v_status varchar2(50);
  
begin

begin

select old_status into v_status from xxdm_pl_header where batch_id =v_batch_id   and  pl_number =
(SELECT xdm.pl_number FROM xxdm_pl_qualifiers xdq ,xxdm_pl_modifiers xdm 
  WHERE xdq.pl_mod_id =xdm.pl_mod_id AND xdq.batch_id =xdm.batch_id AND xdq.batch_id =v_BATCH_ID
  and xdq.PL_QLFY_ID = v_PL_QLFY_ID);
exception when others then
dbms_output.put_line('  exception in getting v_status ');
v_status :='DRA';

end;

if v_status = 'APR' then 

FOR plq IN cur_dm_qualifier
loop


 DBMS_OUTPUT.PUT_LINE('   cur_dm_qualifier history  ') ;



FOR j IN c_pl_master_h
loop

  INSERT
    INTO XXPM_PL_HEADER_H
      (
        PL_ID_H,
        PL_ID,
        PL_NAME,
        PL_NAME_TL,
        DESCRIPTION,
        ORG_ID,
        FUNC_ID,
        PL_TYPE,
        PRIORITY,
        USAGE,
        CURRENCY_CODE,
        START_DATE,
        END_DATE,
        REVISION_NO,
        REVISION_DATE,
        REVISED_BY,
        STATUS,
        FLOW_STATUS,
        FLOW_LEVEL,
        USER_GRP_ID,
        BASE_PRICE_YN,
        ACTIVE_YN,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        PL_NUMBER
      )
      VALUES
      (
        XXPM_PRICELIST_HISTORY_S.nextval,
        j.PL_ID,
        j.PL_NAME,
        j.PL_NAME_TL,
        j.DESCRIPTION,
        j.ORG_ID,
        j.FUNC_ID,
        j.PL_TYPE,
        j.PRIORITY,
        j.USAGE,
        j.CURRENCY_CODE,
        j.START_DATE,
        j.END_DATE,
        NVL(J.REVISION_NO,0),
        j.REVISION_DATE,
        j.REVISED_BY,
        j.STATUS,
        j.FLOW_STATUS,
        j.FLOW_LEVEL,
        j.USER_GRP_ID,
        j.BASE_PRICE_YN,
        j.ACTIVE_YN,
        j.CREATED_BY,
        sysdate,
        j.LAST_UPDATED_BY,
        sysdate,
        j.LAST_UPDATE_LOGIN,
        j.PL_NUMBER
      );


l_revision_no :=        NVL(j.REVISION_NO,0);
l_pl_id := j.pl_id;

END loop;


 for I in C_PL_HISTORY(l_pl_id)
  LOOP
  
--    select PLL_ID into L_PLL_ID_H from XXPM_PL_LINES_H where PLL_ID=V_PLL_ID;
--    
--    IF l_PLL_ID_h IS NULL THEN
      INSERT
      INTO XXPM_PL_LINES_H
        (
          PLL_ID_H,
          PLL_ID,
          PL_ID,
          PROPERTY_ID,
          BUILD_ID,
          UNIT_ID,
          UOM,
          BASE_PRICE,
          MIN_PRICE,
          START_DATE,
          END_DATE,
          REVISION_NO,
          REVISION_DATE,
          REVISED_BY,
          ACTIVE_YN,
          CREATED_BY,
          CREATION_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN
        )
        VALUES
        (
          XXPM_PL_LINES_H_S.nextval,
          i.PLL_ID,
          i.PL_ID,
          i.PROPERTY_ID,
          i.BUILD_ID,
          i.UNIT_ID,
          i.UOM,
          i.BASE_PRICE,
          i.MIN_PRICE,
          i.START_DATE,
          i.END_DATE,
          l_revision_no,
          sysdate,
          i.REVISED_BY,
          i.ACTIVE_YN,
          i.CREATED_BY,
          sysdate,
          i.LAST_UPDATED_BY,
          sysdate,
          i.LAST_UPDATE_LOGIN
        );
--    END IF;
  END LOOP;


 FOR k IN c_pl_modifier_h(l_pl_id)
 loop
 insert into xxpm_pl_modifiers_h  (PL_MOD_ID_H,
PL_MOD_ID,
PL_ID,
MOD_ID,
START_DATE,
END_DATE,
REVISION_NO,
REVISION_DATE,
REVISED_BY,
ACTIVE_YN,
CREATED_BY,
CREATION_DATE,
LAST_UPDATED_BY,
LAST_UPDATE_DATE,
LAST_UPDATE_LOGIN) 
VALUES
(
XXPM_PL_MODIFIERS_H_S.nextval,
k.PL_MOD_ID,
  k.PL_ID,
  k.MOD_ID,
  k.START_DATE,
  k.END_DATE,
  l_revision_no,
SYSDATE ,--  REVISION_DATE,
  k.REVISED_BY,
  k.ACTIVE_YN,
  k.CREATED_BY,
  SYSDATE,
  k.LAST_UPDATED_BY,
  SYSDATE,
  k.LAST_UPDATE_LOGIN
);
 
 END loop;
 
 
 
  FOR q IN c_pl_qualifier_h(l_pl_id)
  loop
  INSERT
INTO xxpm_pl_qualifiers_h
  (
    PL_QLFY_ID_H,
    PL_QLFY_ID,
    PL_MOD_ID,
    QLFY_ID,
    START_DATE,
    END_DATE,
    REVISION_NO,
    REVISION_DATE,
    REVISED_BY,
    ACTIVE_YN,
    CREATED_BY,
    CREATION_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN
  )
  VALUES
  (
    XXPM_PL_QUALIFIERS_H_S.nextval,
    q.PL_QLFY_ID,
    q.PL_MOD_ID,
    q.QLFY_ID,
    q.START_DATE,
    q.END_DATE,
    l_revision_no,
    SYSDATE,
    q.REVISED_BY,
    q.ACTIVE_YN,
    q.CREATED_BY,
    SYSDATE,
    q.LAST_UPDATED_BY,
    SYSDATE,
    q.LAST_UPDATE_LOGIN
  );

  
  END loop;
  
  UPDATE  xxpm_pl_header
SET revision_no = revision_no+1
WHERE pl_id = l_pl_id and status ='APR';
  
UPDATE xxdm_pl_lines SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =(SELECT PL_NUMBER FROM xxpm_pl_header WHERE pl_id =l_pl_id);

UPDATE xxdm_pl_modifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =(SELECT PL_NUMBER FROM xxpm_pl_header WHERE pl_id =l_pl_id);

UPDATE xxdm_pl_qualifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
and pl_mod_id in(
  SELECT xdm.pl_mod_id FROM xxdm_pl_modifiers xdm 
  WHERE  xdm.batch_id =v_BATCH_ID
  AND xdm.pl_number = (SELECT xdm.pl_number FROM xxdm_pl_qualifiers xdq ,xxdm_pl_modifiers xdm 
  WHERE xdq.pl_mod_id =xdm.pl_mod_id AND xdq.batch_id =xdm.batch_id AND xdq.batch_id =v_BATCH_ID
  and xdq.PL_QLFY_ID = v_PL_QLFY_ID));

COMMIT;





end loop;


end if;
end insert_history;






END XXPM_PL_QUALIFIER_PKG;
