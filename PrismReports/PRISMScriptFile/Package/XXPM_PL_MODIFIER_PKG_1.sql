--------------------------------------------------------
--  DDL for Package XXPM_PL_MODIFIER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PL_MODIFIER_PKG" 
IS
  PROCEDURE xxpm_pl_modifier_val(
      i_batch_id IN NUMBER);
  PROCEDURE update_pl_modifier_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_rowid IN VARCHAR2,
                                    v_mod_id IN number,v_pl_id IN  varchar2,v_batch_id IN number);
  PROCEDURE insert_pl_modifiers (i_batch_id IN NUMBER);
  
  procedure insert_history(   v_BATCH_ID IN NUMBER,v_pl_number in varchar2 ,v_pl_mod_id in number);
END XXPM_PL_MODIFIER_PKG;


--------------------------------------------------------
--  DDL for Package Body XXPM_PL_MODIFIER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_PL_MODIFIER_PKG" 
IS
PROCEDURE xxpm_pl_modifier_val(i_batch_id IN NUMBER)
  as
  cursor c_plmodifier_temp
  IS
  select rowid,
    PL_MOD_ID,
    PL_ID,
    PL_NUMBER,
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
    FROM xxdm_pl_modifiers
    WHERE BATCH_ID=i_batch_id 
    and INTERFACE_STATUS_FLAG  != 'E';

v_ready_flag varchar2(10);
v_errm       varchar2(2000);
v_err_reason  varchar2(2000);
v_batch_id   number;
v_pl_number   varchar2(30);
v_pl_id       number;  
v_mod_id      number;
v_mod_id_pl   number;
v_pl_id_mod   number;
v_pl_mod_count number;
v_mod_count    number;
v_pl_mod_id    NUMBER; 
v_rowid        varchar2(300);
v_start_date   DATE;
v_end_date     DATE;
v_pl_no_cnt number;
L_CNT NUMBER;

begin
    v_batch_id:=i_batch_id;

FOR i IN c_plmodifier_temp LOOP
    v_ready_flag := 'V';
	v_err_reason:= '';
	v_errm := '';
  v_pl_id := '';
    Begin      
    		select pl_number,pl_id into v_pl_number,v_pl_id from xxpm_pl_header where pl_number=i.PL_NUMBER;

    EXCEPTION
			WHEN OTHERS
			  THEN
               v_pl_number := ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
                   DBMS_OUTPUT.PUT_LINE('v_errm  16 '||v_errm);

	END;
  
  
  IF v_pl_number IS NULL THEN
  
  
  
   BEGIN      
      		SELECT pl_number INTO v_pl_number FROM xxdm_pl_header WHERE pl_number=i.PL_NUMBER and batch_id =i.batch_id;
			   v_ready_flag := 'V';
                  v_errm := NULL;


    EXCEPTION
			WHEN OTHERS
			  THEN
               v_pl_number := ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
                   DBMS_OUTPUT.PUT_LINE('v_errm  15 '||v_errm);

	END;
  
          

  
  
  end if;
  
  
    Begin      
			select mod_id into v_mod_id from xxpm_modifiers where mod_id=i.mod_id;

   	EXCEPTION
			WHEN OTHERS
			  THEN
               v_mod_id := ''; 
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
                   DBMS_OUTPUT.PUT_LINE('v_errm  14 '||v_errm);

	END;

    Begin

    update xxdm_pl_modifiers set pl_id= v_pl_id  where pl_number=i.PL_NUMBER and mod_id=i.mod_id and batch_id=v_batch_id;
    commit;

    Exception
	WHEN OTHERS
	THEN
				   v_ready_flag := 'E';
				   v_errm := SQLCODE || '-' || SQLERRM;
                     DBMS_OUTPUT.PUT_LINE('v_errm  13 '||v_errm);

	End;

    BEGIN
        SELECT start_date,
          end_date
        INTO v_start_date,
          v_end_date
        FROM xxdm_pl_modifiers
        WHERE rowid=i.rowid
        AND batch_id    = i.batch_id;
          DBMS_OUTPUT.PUT_LINE('Start Date '||v_start_date||','||'End Date '||v_end_date);
      EXCEPTION
      WHEN OTHERS THEN
        v_PL_ID      :='';
        v_ready_flag := 'E';
        v_errm       := SQLCODE || '-' || SQLERRM;
                  DBMS_OUTPUT.PUT_LINE('v_errm  12 '||v_errm);

      END;
      
      
      BEGIN
      IF I.PL_MOD_ID IS NULL THEN
      L_CNT := 0;
      
      ELSE
            L_CNT := 1;

      
      END IF;
      END;


    Begin      
			SELECT count(1) INTO v_pl_mod_count FROM xxpm_pl_modifiers WHERE pl_mod_id=i.pl_mod_id;
      			SELECT count(1) INTO v_pl_no_cnt FROM xxdm_pl_header WHERE pl_number=i.pl_number;
            


            if ( v_pl_mod_count = 1 ) then            
SELECT mo.mod_id,
  pl.pl_id
INTO v_mod_id_pl,
  v_pl_id_mod
FROM xxpm_modifiers mo,
  xxpm_pl_header pl,
  xxpm_pl_modifiers plm
              where mo.mod_id=i.mod_id
              and pl.pl_number=i.pl_number
              and pl.pl_id=plm.pl_id
              AND mo.mod_id=plm.mod_id;
            end if; 
	EXCEPTION
			WHEN OTHERS
			  THEN
               v_mod_id_pl:='';
               v_pl_id_mod:='';
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
          DBMS_OUTPUT.PUT_LINE('v_errm  1 '||v_errm);
	END;

  DBMS_OUTPUT.PUT_LINE('validation ');
if(v_pl_number is not null) then
   if (v_mod_id is not null) then
       if(v_mod_id_pl is not null) and (v_pl_id_mod is not null) then
          if(v_start_date < v_end_date) then
          IF L_CNT > 0 THEN
                v_rowid:=i.rowid;
                v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
                  DBMS_OUTPUT.PUT_LINE('1 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

                update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
                
                ELSE
--                
                IF   TRUNC(SYSDATE) <= TRUNC(v_start_date) THEN
 v_rowid:=i.rowid;
                v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
                 v_ready_flag      := 'V';
                update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);

                 ELSE
                  v_rowid:=i.rowid;
                v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
                     v_ready_flag := 'E';
      v_err_reason       := 'start_date  CANNOT BE LESS THAN SYSDATE';
                update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
                 
             
                END IF;
      
                
                
                END IF;
          else
              v_rowid:=i.rowid;
              v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
              v_ready_flag:='E';
              v_err_reason := 'Start date should be less than end date';
                 DBMS_OUTPUT.PUT_LINE('12 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

              update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);   
          end if;
       ELSif v_pl_no_cnt >0 THEN
       
        if(v_start_date < v_end_date) then
                v_rowid:=i.rowid;
                v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
                  DBMS_OUTPUT.PUT_LINE('01 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

                update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
          else
              v_rowid:=i.rowid;
              v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
              v_ready_flag:='E';
              v_err_reason := 'Start date should be less than end date';
                 DBMS_OUTPUT.PUT_LINE('12 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

              update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);   
          end if;

          else
          
            v_rowid:=i.rowid;
          v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
                              v_ready_flag:='E';

          v_err_reason := 'MOD ID IS NOT LINKED WITH THE PL ID';
                           DBMS_OUTPUT.PUT_LINE('123 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

          update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
          
          
       end if;   
   else
        v_rowid:=i.rowid;
        v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
                              v_ready_flag:='E';

        v_err_reason := 'MOD ID IS NOT EXIST IN THE MODIFIER MASTER TABLE';
                         DBMS_OUTPUT.PUT_LINE('1234 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

        update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
   end if;     
else            
    v_rowid:=i.rowid;
    v_mod_id:=i.mod_id;
                v_pl_id:=i.pl_id;
    v_err_reason := 'PL NUMBER IS NOT EXIST IN THE PL HEADER MASTER TABLE';
                  v_ready_flag:='E';

                     DBMS_OUTPUT.PUT_LINE('12345 '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

   update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
END IF;  

--------------------------Mandatory Validations -------------
-------------------------------------------------------


  if i.PL_NUMBER is null then
        v_rowid:=i.rowid;
        v_mod_id:=i.mod_id;
       v_pl_id:=i.pl_id;
             v_ready_flag:='E';

        v_err_reason := 'PL_NUMBER SHOULD NOT BE NULL';
                         DBMS_OUTPUT.PUT_LINE(' PL_NUMBER '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

        update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
   end if; 
   
   
    if i.MOD_ID is null then
        v_rowid:=i.rowid;
        v_mod_id:=i.mod_id;
       v_pl_id:=i.pl_id;
             v_ready_flag:='E';

        v_err_reason := 'MOD_ID SHOULD NOT BE NULL';
                         DBMS_OUTPUT.PUT_LINE(' MOD_ID '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

        update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
   end if; 
   
   
    if i.START_DATE is null then
        v_rowid:=i.rowid;
        v_mod_id:=i.mod_id;
       v_pl_id:=i.pl_id;
             v_ready_flag:='E';

        v_err_reason := 'START_DATE SHOULD NOT BE NULL';
                         DBMS_OUTPUT.PUT_LINE(' START_DATE '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

        update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
   end if; 
   
   
    if i.END_DATE is null then
        v_rowid:=i.rowid;
        v_mod_id:=i.mod_id;
       v_pl_id:=i.pl_id;
             v_ready_flag:='E';

        v_err_reason := 'END_DATE SHOULD NOT BE NULL';
                         DBMS_OUTPUT.PUT_LINE(' END_DATE '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

        update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
   end if; 
   
   
   
    if i.ACTIVE_YN is null then
        v_rowid:=i.rowid;
        v_mod_id:=i.mod_id;
       v_pl_id:=i.pl_id;
             v_ready_flag:='E';

        v_err_reason := 'ACTIVE_YN SHOULD NOT BE NULL';
                         DBMS_OUTPUT.PUT_LINE(' ACTIVE_YN '||v_ready_flag ||v_err_reason||v_errm||v_rowid||v_mod_id||v_pl_id||v_batch_id);

        update_pl_modifier_temp(v_ready_flag,v_err_reason,v_errm,v_rowid,v_mod_id,v_pl_id,v_batch_id);
   end if; 
   


END LOOP;
END xxpm_pl_modifier_val;
--------------------------------------------------

PROCEDURE update_pl_modifier_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_rowid IN VARCHAR2,
                                    v_mod_id IN number,v_pl_id IN  varchar2,v_batch_id IN number)
as
BEGIN
                     DBMS_OUTPUT.PUT_LINE('  UPD  ' );
            UPDATE   xxdm_pl_modifiers
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
                           ERR_DESCRIPTION= v_err_desc,
                           ERR_MSG=v_err_msg
            WHERE   rowid=nvl(v_rowid,NULL)
--            and pl_id=v_pl_id
--            and mod_id=v_mod_id
            and batch_id=v_batch_id ;
            
 if   v_status_flag ='E'  then         

       UPDATE   xxdm_pl_qualifiers
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Modifier validation failed with  '||v_err_desc,
                           ERR_MSG=v_err_msg
        WHERE PL_MOD_ID IN(SELECT pl_mod_id FROM xxdm_pl_modifiers WHERE rowid=nvl(v_rowid,NULL)  AND batch_id =v_batch_id)
            AND batch_id=v_batch_id ;  
  
            
            end if;
            
            
            
            
            commit;
End update_pl_modifier_temp;
------------------------------------------------
procedure insert_pl_modifiers (i_batch_id IN NUMBER)
as
cursor c_pl_mod_dm
is
         SELECT 
         rowid,
            PL_MOD_ID,
            PL_ID,
            PL_NUMBER,
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
          from xxdm_pl_modifiers
          where BATCH_ID=i_batch_id and INTERFACE_STATUS_FLAG='V';

v_row_count number;
v_errm  varchar2(2000);
v_batch_id     NUMBER;
v_pl_number    VARCHAR2(40);
v_pl_id         NUMBER;
l_PL_MOD_ID    NUMBER;
v_status VARCHAR2(50);


begin
v_batch_id:=i_batch_id;
for i in c_pl_mod_dm loop

            Begin
            select pl_number,pl_id into v_pl_number,v_pl_id from xxpm_pl_header where pl_number=i.PL_NUMBER;
                        
    select old_status into v_status from xxdm_pl_header where pl_number=i.PL_NUMBER and batch_id =i.batch_id;

            Exception
            WHEN OTHERS
            THEN
				   v_errm := SQLCODE || '-' || SQLERRM;
            End;

if(i.pl_mod_id is not null) then

if v_status ='APR' then
insert_history(   i.BATCH_ID,i.pl_number  ,i.pl_mod_id);
end if;

update xxpm_pl_modifiers set START_DATE=i.start_date,
                             END_DATE=i.end_date,
                             ACTIVE_YN=i.ACTIVE_YN,
                             revision_date=sysdate,
                             CREATED_BY=i.CREATED_BY,
                             CREATION_DATE=i.CREATION_DATE,
                             LAST_UPDATED_BY=i.LAST_UPDATED_BY,
                             LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
                             LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
WHERE pl_mod_id=i.pl_mod_id;
l_PL_MOD_ID :=i.pl_mod_id;


END IF;


if  (i.pl_mod_id is null) then


l_PL_MOD_ID :=XXPM_PL_MODIFIERS_S.nextval;

            insert into xxpm_pl_modifiers (PL_MOD_ID,PL_ID,MOD_ID,START_DATE,END_DATE,
            REVISION_NO,REVISION_DATE,REVISED_BY,ACTIVE_YN,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,
            LAST_UPDATE_DATE,LAST_UPDATE_LOGIN)
            VALUES 
            (l_PL_MOD_ID,
            v_pl_id,
            i.mod_id,
            i.start_date,
            i.end_date,
            null,
            sysdate,
            i.revised_by,
            i.active_yn,
            i.created_by,
            i.creation_date,
            i.last_updated_by,
            i.LAST_UPDATE_DATE,
            i.LAST_UPDATE_LOGIN
            );
            UPDATE xxdm_pl_modifiers SET PL_MOD_ID =l_PL_MOD_ID ,  INTERFACE_STATUS_FLAG ='P' WHERE ROWID = i.ROWID;
                        COMMIT;
            
            if v_status ='APR' then

            insert_history(   i.BATCH_ID,i.pl_number  ,l_PL_MOD_ID);
            end if;

END IF;
            UPDATE xxdm_pl_modifiers SET PL_MOD_ID =l_PL_MOD_ID ,  INTERFACE_STATUS_FLAG ='P' WHERE ROWID = i.ROWID;

END LOOP;
commit;
END insert_pl_modifiers;
----------------------------------------------

PROCEDURE insert_history(
   v_BATCH_ID IN NUMBER,v_pl_number in varchar2 ,v_pl_mod_id in number)
AS

CURSOR cur_dm_modifiers
is
SELECT * FROM xxdm_pl_modifiers WHERE batch_id =v_BATCH_ID AND  PL_MOD_ID =v_pl_mod_id AND nvl(History_insert,'N') ='N';


  CURSOR c_pl_history
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
    FROM xxpm_pl_lines xpl , xxpm_pl_header xph
    WHERE 
    xpl.PL_ID = xph.PL_ID
    and xph.PL_NUMBER =v_PL_NUMBER;
    
   CURSOR c_pl_master_h
   is
    SELECT distinct   xph.PL_ID,
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
xxpm_pl_header xph
WHERE xph.PL_NUMBER =v_PL_NUMBER;

 CURSOR c_pl_modifier_h
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
FROM xxpm_pl_modifiers xpm , xxpm_pl_header xph
WHERE xpm.pl_id =xph.PL_ID
    and xph.PL_NUMBER =v_PL_NUMBER;

  CURSOR c_pl_qualifier_h
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
  xxpm_pl_modifiers xpm,
  xxpm_pl_header xph
WHERE xpq.pl_mod_id =xpm.pl_mod_id
  AND xpm.pl_id       =xph.pl_id
  and xph.PL_NUMBER =v_PL_NUMBER; 
 
 v_revision_no number;
 begin
 
 FOR m IN cur_dm_modifiers
 loop
 
 DBMS_OUTPUT.PUT_LINE('   cur_dm_modifiers history  ') ;
 
--update revision number in header


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


v_revision_no :=        NVL(j.REVISION_NO,0);

END loop;

--insert into lines history

  for I in C_PL_HISTORY
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
          v_revision_no,
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
  
  
  FOR k IN c_pl_modifier_h
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
  v_revision_no,
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
 
  
  
  FOR q IN c_pl_qualifier_h
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
    v_revision_no,
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
WHERE PL_NUMBER = v_PL_NUMBER and status ='APR';


UPDATE xxdm_pl_lines SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =v_pl_number;

UPDATE xxdm_pl_modifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =v_pl_number;

UPDATE xxdm_pl_qualifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
and pl_mod_id in(
  SELECT xdm.pl_mod_id FROM xxdm_pl_modifiers xdm 
  WHERE  xdm.batch_id =v_BATCH_ID
  AND xdm.pl_number =v_pl_number );


COMMIT;


 
 
 end loop;
 
end insert_history;






END XXPM_PL_MODIFIER_PKG;
