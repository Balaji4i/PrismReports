--------------------------------------------------------
--  DDL for Package XXPM_MILESTONE_DETAIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_MILESTONE_DETAIL_PKG" 

IS

   PROCEDURE xxpm_milestone_dtl_val (p_batch_id IN NUMBER);
   
--   PROCEDURE update_milestone_temp (v_status_flag IN varchar2
--                                   ,v_err_desc IN varchar2
--                                   ,v_err_msg IN varchar2
--                                   ,v_property_number IN varchar2
--                                   ,v_build_number IN varchar2
--                                   ,v_batch_id IN number);
--                                   
   PROCEDURE xxpm_ms_history_insert (p_batch_id number ,p_ms_dtl_id in number );

   PROCEDURE xxpm_milestone_dtl_insert (p_batch_id number);

END XXPM_MILESTONE_DETAIL_PKG;


--------------------------------------------------------
--  DDL for Package Body XXPM_MILESTONE_DETAIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_MILESTONE_DETAIL_PKG" 
AS

--==============================================================================
---------------------Milestone Detail Validations-------------------------------
--==============================================================================

PROCEDURE xxpm_milestone_dtl_val (p_batch_id IN NUMBER)
AS

Cursor c_ms_dtl_temp is
  SELECT dtl.ROWID,dtl.* FROM XXDM_MILESTONE_DTL dtl
  where batch_id = p_batch_id and INTERFACE_STATUS_FLAG != 'E';

v_batch_id          NUMBER;
v_ready_flag        varchar2 (1);
v_ms_hdr_id         number;
v_ms_hdr_id_dm      number;
v_ms_dtl_id         number;
v_ms_status         varchar2(30);
v_ms_hdr            number;
v_ms_dtl            number;
v_start_date        date;
v_end_date          date;
v_base_install_pct  number;
v_stg_install_pct   number;
v_status            varchar2(150);
v_status_count       number;
v_action_flag       varchar2(10);
v_history_insert    varchar2(10);
v_err_reason        varchar2 (2000);
v_err_desc          varchar2 (2000);
v_errm              varchar2 (2000);   
v_total_install_pct number;
v_installment_type   varchar2(150);  
v_charge_type        varchar2(150);
v_payment_term       varchar2(150);
v_installment_method varchar2(150);
v_installment_event  varchar2(150);
v_period_occurence   varchar2(150);
v_period_duration    varchar2(150);
v_installment_sales_project number;
v_installment_due_project number;
v_installment_timebound number;

Begin
		v_batch_id := p_batch_id;


FOR i IN c_ms_dtl_temp 
LOOP
	v_ready_flag     := 'V';
    v_action_flag    := null;
    v_history_insert := null;
	v_err_reason     := null;
	v_errm           := null;
    v_err_desc       := null;
    v_status         := null;

--------------------------------------------------------------------------------
----------------Milestone Header Validation-------------------------------------
--------------------------------------------------------------------------------    

  BEGIN
        select count(1) 
        into v_ms_hdr
        from XXPM_MILESTONE_HDR 
        where MILESTONE_NUMBER = i.MILESTONE_NUMBER;

        DBMS_OUTPUT.PUT_LINE('MILESTONE HDR ' ||     v_ms_hdr);

          IF v_ms_hdr > 0 THEN

                      BEGIN
                        select MS_HDR_ID
                        into v_ms_hdr_id
                        from XXPM_MILESTONE_HDR 
                        where MILESTONE_NUMBER = i.MILESTONE_NUMBER;

                        DBMS_OUTPUT.PUT_LINE('Milestone HDR ID ' || v_ms_hdr_id);

                      EXCEPTION
                      WHEN OTHERS THEN
                             v_ms_hdr_id:='';
                             v_errm := SQLCODE || '-' || SQLERRM;          
                      END;
          ELSE
            DBMS_OUTPUT.PUT_LINE('Milestone HDR ID ' || i.MILESTONE_NUMBER);
             select count(1)
             into v_ms_hdr_id_dm
             from XXDM_MILESTONE_HDR 
             where MILESTONE_NUMBER = i.MILESTONE_NUMBER
             and batch_id=i.batch_id;
             DBMS_OUTPUT.PUT_LINE('Milestone HDR ID '|| v_ms_hdr_id_dm || 'COUNT');
          END IF;
    EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ms_hdr_id:='';   
               v_ms_hdr := 0;
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
--------------------------------------------------------------------------------
----------------Validation MILESTONE_INSTALLMENT loookup------------------------
--------------------------------------------------------------------------------    
-------------JULY-2019--------------------------------------------------------------------
 BEGIN
  select count(1) 
  into v_installment_type
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'MILESTONE_INSTALLMENT'  
  and LOOKUP_VALUE_NAME  = i.INSTALLMENT_TYPE;  

    DBMS_OUTPUT.PUT_LINE('INSTALLMENT TYPE LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_installment_type:=0;         
           v_ready_flag := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validation CHARGE_TYPE loookup----------------------------------
--------------------------------------------------------------------------------    

  BEGIN
  select count(1) 
  into v_charge_type
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'CHARGE_TYPE'  
  and LOOKUP_VALUE_NAME  = i.CHARGE_TYPE;  

  DBMS_OUTPUT.PUT_LINE('CHARGE TYPE LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_charge_type:=0;         
           v_ready_flag := 'E';
          v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validation INSTALLMENT_METHOD loookup---------------------------
--------------------------------------------------------------------------------    

  BEGIN
  select count(1) 
  into v_installment_method
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'MILESTONE_METHOD'  
  and LOOKUP_VALUE_NAME  = i.INSTALLMENT_METHOD;  

  DBMS_OUTPUT.PUT_LINE('INSTALLMENT METHOD LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_installment_method := 0;         
           v_ready_flag  := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validation MILESTONE_EVENT loookup------------------------------
--------------------------------------------------------------------------------    

  BEGIN
  select count(1) 
  into v_installment_event
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'MILESTONE_EVENT'  
  and LOOKUP_VALUE_NAME  = i.INSTALLMENT_EVENT;  

  DBMS_OUTPUT.PUT_LINE('INSTALLMENT EVENT LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_installment_event := 0;         
           v_ready_flag  := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
END;

--------------------------------------------------------------------------------
----------------Validation MILESTONE_EVENT loookup------------------------------
--------------------------------------------------------------------------------    

  BEGIN
     select count(1) 
      into v_installment_sales_project
     from XXDM_MILESTONE_DTL
      where INSTALLMENT_METHOD in('Sales Milestone','Project Milestone')
     and INSTALLMENT_EVENT is not null
     and rowid=i.rowid
     and milestone_number=i.milestone_number
      and batch_id=i.batch_id;

 DBMS_OUTPUT.PUT_LINE('INSTALLMENT EVENT LOOKUP VALIDATION ');


 EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
       THEN
           v_installment_event := 0;         
          v_ready_flag  := 'E';
          v_errm := SQLCODE || '-' || SQLERRM;
END;


--------------------------------------------------------------------------------
----------------Validation MILESTONE_EVENT loookup------------------------------
--------------------------------------------------------------------------------    

  BEGIN
      select count(1) 
     into v_installment_due_project
      from XXDM_MILESTONE_DTL
     where INSTALLMENT_METHOD in('Due Based')
      and due_date is not null
      and rowid=i.rowid
     and milestone_number=i.milestone_number
     and batch_id=i.batch_id;

  DBMS_OUTPUT.PUT_LINE('Due based installment  event');


  EXCEPTION
       WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
        THEN
          v_installment_event := 0;         
          v_ready_flag  := 'E';
          v_errm := SQLCODE || '-' || SQLERRM;
END;

--------------------------------------------------------------------------------
----------------Validation MILESTONE_EVENT loookup------------------------------
--------------------------------------------------------------------------------    

 BEGIN
     select count(1) 
     into v_installment_timebound
     from XXDM_MILESTONE_DTL
     where INSTALLMENT_METHOD in('Time bound')
     and due_days is not null
     and rowid=i.rowid
     and milestone_number=i.milestone_number
    and batch_id=i.batch_id;

  DBMS_OUTPUT.PUT_LINE('Due based installment  event');


 EXCEPTION
      WHEN NO_DATA_FOUND THEN
       null;
       WHEN OTHERS
         THEN
         v_installment_event := 0;         
          v_ready_flag  := 'E';
          v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validation MILESTONE_OCCURENCE loookup--------------------------
--------------------------------------------------------------------------------    



 BEGIN
  select count(1) 
 into v_period_occurence
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'MILESTONE_OCCURENCE'  
  and LOOKUP_VALUE_NAME  = i.PERIOD_OCCURENCE;  

  DBMS_OUTPUT.PUT_LINE('INSTALLMENT OCCURENCE LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
       null;
        WHEN OTHERS
          THEN
          v_period_occurence := 0;         
          v_ready_flag := 'E';
         v_errm := SQLCODE || '-' || SQLERRM;
END;

--------------------------------------------------------------------------------
----------------Validation PERIOD_DUARTION loookup------------------------------
--------------------------------------------------------------------------------    
-------------JULY-2019--------------------------------------------------------------------
  BEGIN
  select count(1) 
  into v_period_duration
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'MILESTONE_DURATION'  
  and LOOKUP_VALUE_NAME  = i.PERIOD_DURATION;  

  DBMS_OUTPUT.PUT_LINE('INSTALLMENT DURATION LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_period_duration := 0;         
           v_ready_flag := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
	END;
-------------JULY-2019--------------------------------------------------------------------
--------------------------------------------------------------------------------
----------------Validation Payment Term-----------------------------------------
--------------------------------------------------------------------------------    

  BEGIN
  select count(1) 
  into v_payment_term
  from XXSTG_PAY_TERMS
  where TERM_ID  = i.PAYMENT_TERM;  

  DBMS_OUTPUT.PUT_LINE('PAYMENT TERM LOOKUP VALIDATION ');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_payment_term := 0;         
           v_ready_flag := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Milestone Header Status Validation------------------------------
--------------------------------------------------------------------------------    

  BEGIN
        select count(1)
        into v_status_count
        from XXPM_MILESTONE_HDR 
        where ms_hdr_id = v_ms_hdr_id;
        
if v_status_count > 0 then
        select status
        into v_status
        from XXPM_MILESTONE_HDR 
        where ms_hdr_id = v_ms_hdr_id;
--        and status = 'PEN';

    DBMS_OUTPUT.PUT_LINE('STATUS VALIDATION ' || v_status);
else
    v_status:='DRA';
end if;

  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_status := null;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
  
  
  ------beforeJULY-2019-------------------
/*
  BEGIN
        select count(1) 
        into v_ms_status
        from XXPM_MILESTONE_HDR 
        where ms_hdr_id = v_ms_hdr_id
        and status = 'PEN';
  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ms_status := 0;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
*/
--------------------------------------------------------------------------------
----------------Milestone Line Installation PCT---------------------------------
--------------------------------------------------------------------------------    
--
--  BEGIN
--    select nvl(sum(INSTALLMENT_PCT),0)
--    into v_base_install_pct
--    from XXPM_MILESTONE_DTL
--    where MS_HDR_ID = v_ms_hdr_id;
--
--  dbms_output.put_line('Base Install PCT : '||v_base_install_pct);
--
--
--  EXCEPTION
--			WHEN OTHERS
--			  THEN
--			   v_base_install_pct := 0;         
--			   v_ready_flag := 'E';
--			   v_errm := SQLCODE || '-' || SQLERRM;
--	END;

  BEGIN
    select nvl(sum(INSTALLMENT_PCT),0)
    into v_stg_install_pct
    from XXDM_MILESTONE_DTL
    where MILESTONE_NUMBER = i.MILESTONE_NUMBER
    AND batch_id    = i.BATCH_ID;

  dbms_output.put_line('Stg Install PCT : '||v_stg_install_pct);

  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_stg_install_pct := 0;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

--  v_total_install_pct := nvl(v_base_install_pct,0)+nvl(v_stg_install_pct,0);
v_total_install_pct :=nvl(v_stg_install_pct,0);
  dbms_output.put_line('Total Install PCT : '||v_total_install_pct);

--------------------------------------------------------------------------------
----------------Milestone Detail Validation-------------------------------------
--------------------------------------------------------------------------------    

  BEGIN
        select count(1) 
        into v_ms_dtl
        from XXPM_MILESTONE_DTL
        where MS_HDR_ID = v_ms_hdr_id
        and MS_DTL_ID = i.MS_DTL_ID;

          IF v_ms_dtl > 0 THEN

          BEGIN
            select MS_dtl_ID
            into v_ms_dtl_id
            FROM XXPM_MILESTONE_DTL 
            where MS_HDR_ID = v_ms_hdr_id
            and MS_DTL_ID = i.MS_DTL_ID;
          EXCEPTION
          WHEN OTHERS THEN
           v_ms_dtl_id:='';
			     v_errm := SQLCODE || '-' || SQLERRM;          
          END;

          ELSE

           v_ms_dtl_id:=null;

          END IF;

  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ms_dtl_id :='';   
               v_ms_dtl    := 0;
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
    
       --------------------------------------------------------------------------------
    ------------Mandatory validation -----------------
    --------------------------------------------------------------------------------  

if i.MILESTONE_NUMBER is null then
 v_ready_flag := 'E';
     v_err_desc   := 'MILESTONE_NUMBER should not be null';      
end if;

if i.SEQ_NUMBER is null then
 v_ready_flag := 'E';
     v_err_desc   := 'SEQ_NUMBER should not be null';      
end if;

if i.INSTALLMENT_TYPE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'INSTALLMENT_TYPE should not be null';      
end if;

if i.INSTALLMENT_PCT is null then
 v_ready_flag := 'E';
     v_err_desc   := 'INSTALLMENT_PCT should not be null';      
end if;

if i.CHARGE_TYPE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'CHARGE_TYPE should not be null';      
end if;

if i.PAYMENT_TERM is null then
 v_ready_flag := 'E';
     v_err_desc   := 'PAYMENT_TERM should not be null';      
end if;

if i.INSTALLMENT_METHOD is null then
 v_ready_flag := 'E';
     v_err_desc   := 'INSTALLMENT_METHOD should not be null';      
end if;



  
  
  

--------------------------------------------------------------------------------
----------------Validate Conditions---------------------------------------------
--------------------------------------------------------------------------------  
   IF (v_ms_hdr > 0)  OR (v_ms_hdr_id_dm > 0) THEN
   
    IF (v_installment_type > 0)  THEN
     IF (v_charge_type > 0)  THEN
      IF (v_installment_method > 0)  THEN    
       IF (v_installment_event > 0) or (i.INSTALLMENT_EVENT is null) or (v_installment_sales_project >0) or (v_installment_due_project >0) or (v_installment_timebound >0) THEN
        IF (v_period_occurence > 0) or (i.PERIOD_OCCURENCE is null) THEN
         IF (v_period_duration > 0) OR (i.PERIOD_DURATION IS NULL) THEN
          IF v_payment_term > 0 THEN
          IF  v_total_install_pct = 100 THEN
                v_ready_flag     := 'V';
                
           IF v_status = 'PEN' THEN
             IF v_total_install_pct = 100 THEN
                v_ready_flag     := 'V';
             ELSE  
                v_ready_flag  := 'E';
                v_err_desc    := 'sum of INSTALLMENT_PCT should be 100.';
             END IF;
           ELSIF v_status = 'APR' THEN
             v_ready_flag     := 'V';     
             v_history_insert := 'Y';
             
           ELSE
            v_ready_flag  := 'V';
           END IF;
         ELSE
         
          v_ready_flag  := 'E';
           v_err_desc    := 'sum of INSTALLMENT_PCT should be 100. ';                              
          END IF; 
         
          ELSE
           v_ready_flag  := 'E';
           v_err_desc    := 'Invalid Payment Term';                              
          END IF; 
         ELSE
          v_ready_flag  := 'E';
          v_err_desc    := 'Invalid Period Duration';                              
         END IF; 
        ELSE
         v_ready_flag  := 'E';
         v_err_desc    := 'Invalid Period Occurence';                              
        END IF; 
       ELSE
        v_ready_flag  := 'E';
        v_err_desc    := 'Invalid Installment Event or Milestone event should not be null for the sales and project installment method
                          or Due date is null or Due days is null';                       
       END IF;
      ELSE
       v_ready_flag  := 'E';
       v_err_desc    := 'Invalid Installment Method';                
      END IF;
     ELSE
      v_ready_flag  := 'E';
      v_err_desc    := 'Invalid Charge Type';          
     END IF;
    ELSE
     v_ready_flag  := 'E';
     v_err_desc    := 'Invalid Installment Type';     
    END IF;
  
   ELSE  
      v_ready_flag  := 'E';
      v_err_desc    := 'Milestone Header Record not available.';
   END IF;  

--------------------------------------------------------------------------------
----------------Update Action Flag----------------------------------------------
--------------------------------------------------------------------------------    

 IF v_ready_flag <> 'E' THEN
   IF v_ms_dtl > 0 THEN
       v_action_flag := 'U';
   ELSE
       v_action_flag := 'I';
   END IF;    
 ELSE
   v_action_flag := null;
 END IF;


--------------------------------------------------------------------------------
----------------Update Err Msg and Process Flag---------------------------------
--------------------------------------------------------------------------------    

  update xxdm_milestone_dtl
  set ERR_DESCRIPTION     = v_err_desc
     ,ACTION_FLAG         = v_action_flag
     ,INSERT_HISTORY_FLAG = v_history_insert
     ,PROCESSED_DATE      = SYSDATE
     ,PROCESS_FLAG        = v_ready_flag
    ,interface_status_flag=v_ready_flag
     ,err_msg=v_errm
  where rowid =i.rowid
  and milestone_number=i.milestone_number
  and batch_id =i.batch_id;   

dbms_output.put_line('Ready Flag - '||v_ready_flag||'. '|| v_err_reason);

END LOOP;  

commit;

END xxpm_milestone_dtl_val;

PROCEDURE xxpm_ms_history_insert (p_batch_id number ,p_ms_dtl_id in number )
AS

v_errm          varchar2(1000);
V_MS_HDR_ID_H   number;
V_REVISION_NO   number;
V_REVISION_DATE DATE;
v_ms_dtl_id_h   NUMBER;
v_ms_hdr_id     NUMBER;
v_ms_count      NUMBER;
v_ms_dtl_id     NUMBER;
--v_REVISION_NO  number;

cursor c_ms_stg_dtl is
SELECT *
from xxdm_milestone_dtl
WHERE batch_id = p_batch_id
and ms_dtl_id =p_ms_dtl_id
--and MILESTONE_NUMBER = p_MILESTONE_NUMBER
AND interface_status_flag = 'V'
and action_flag  = 'U'
AND insert_history_flag = 'Y';

--Cursor c_ms_dtl(p_milestone_dtl_id number) is
-- select dtl.rowid,dtl.* from xxpm_milestone_dtl dtl
-- where ms_dtl_id = p_milestone_dtl_id;

BEGIN

--------------------------------------------------------------------------------
----------------Derive History Header ID----------------------------------------
--------------------------------------------------------------------------------  

FOR ri in c_ms_stg_dtl
LOOP

   BEGIN
--     select max(MS_HDR_ID_H)+1
--     into V_MS_HDR_ID_H
--     from XXPM_MILESTONE_HDR_H;
     
     select XXPM_MS_HDR_H_ID_S.nextval into V_MS_HDR_ID_H from dual;

     
     
   EXCEPTION
			WHEN OTHERS
			  THEN
			   v_errm := SQLCODE || '-' || SQLERRM;
  	END;

  Begin      
		 	 select count(1)
             into v_ms_count
             from xxpm_milestone_hdr 
             where milestone_number= ri.MILESTONE_NUMBER;

        IF v_ms_count > 0 THEN

             BEGIN
              SELECT ms_hdr_id ,nvl(REVISION_NO ,0)
              into v_ms_hdr_id ,v_REVISION_NO
              from xxpm_milestone_hdr 
              where milestone_number= ri.MILESTONE_NUMBER;
             EXCEPTION
             WHEN OTHERS THEN
             v_ms_hdr_id := null;
             END;

        ELSE
         v_ms_hdr_id := null;         
        END IF;

--  DBMS_OUTPUT.PUT_LINE('Milestone Count'||v_ms_count);      

  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ms_count:=0;         
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;


--------------------------------------------------------------------------------
----------------Insert into HDR History table-----------------------------------
--------------------------------------------------------------------------------

        INSERT INTO XXPM_MILESTONE_HDR_H
           (MS_HDR_ID_H,
            MS_HDR_ID,
            MILESTONE_NAME,
            MILESTONE_NAME_TL,
            MILESTONE_NUMBER,
            MILESTONE_SHORTCODE,
            MILESTONE_DATE,
            FUNC_ID,
            ORG_ID,
            PROJECT_ID,
            MILESTONE_TYPE,
            USAGE,
            REVISION_NO,
            REVISION_DATE,
            REVISED_BY,
            DESCRIPTION,
            START_DATE,
            END_DATE,
            ACTIVE_YN,
            STATUS,
            FLOW_STATUS,
            FLOW_LEVEL,
            FLOW_WITH,
            USER_GRP_ID,
            ATTRIBUTE_CATEGORY,
            ATTRIBUTE1,
            ATTRIBUTE2,
            ATTRIBUTE3,
            ATTRIBUTE4,
            ATTRIBUTE5,
            ATTRIBUTE6,
            ATTRIBUTE7,
            ATTRIBUTE8,
            ATTRIBUTE9,
            ATTRIBUTE10,
            CREATED_BY,
            CREATION_DATE,
            LAST_UPDATED_BY,
            LAST_UPDATE_DATE,
            LAST_UPDATE_LOGIN)
            select  V_MS_HDR_ID_H,
                    MS_HDR_ID,
                    MILESTONE_NAME,
                    MILESTONE_NAME_TL,
                    MILESTONE_NUMBER,
                    MILESTONE_SHORTCODE,
                    MILESTONE_DATE,
                    FUNC_ID,
                    ORG_ID,
                    PROJECT_ID,
                    MILESTONE_TYPE,
                    USAGE,
                    REVISION_NO,
                    REVISION_DATE,
                    REVISED_BY,
                    DESCRIPTION,
                    START_DATE,
                    END_DATE,
                    ACTIVE_YN,
                    STATUS,
                    FLOW_STATUS,
                    FLOW_LEVEL,
                    FLOW_WITH,
                    USER_GRP_ID,
                    ATTRIBUTE_CATEGORY,
                    ATTRIBUTE1,
                    ATTRIBUTE2,
                    ATTRIBUTE3,
                    ATTRIBUTE4,
                    ATTRIBUTE5,
                    ATTRIBUTE6,
                    ATTRIBUTE7,
                    ATTRIBUTE8,
                    ATTRIBUTE9,
                    ATTRIBUTE10,
                    CREATED_BY,
                    sysdate,
                    LAST_UPDATED_BY,
                    sysdate,
                    LAST_UPDATE_LOGIN
              from xxpm_milestone_hdr
              WHERE milestone_number = ri.MILESTONE_NUMBER;

DBMS_OUTPUT.PUT_LINE('History Header ID '|| V_MS_HDR_ID_H);

--------------------------------------------------------------------------------
----------------Insert into DTL History table-----------------------------------
--------------------------------------------------------------------------------

--FOR i in c_ms_dtl(v_ms_dtl_id) 
--LOOP

v_ms_dtl_id_h := null;

--         BEGIN  
----          select max(MS_DTL_ID_H)+1 
----          into v_ms_dtl_id_h
----          from xxpm_milestone_dtl_h;
--select  XXPM_MS_DTL_H_ID_S.nextval into v_ms_dtl_id_h from dual;
--
--         EXCEPTION
--         WHEN OTHERS THEN
--         v_ms_dtl_id_h := null;
--         v_errm := SQLCODE || '-' || SQLERRM;
--         END;

INSERT
INTO XXPM_MILESTONE_DTL_H
  (
    MS_DTL_ID_H,
    MS_DTL_ID,
    MS_HDR_ID,
    SEQ_NUMBER,
    INSTALLMENT_TYPE,
    INSTALLMENT_PCT,
    CHARGE_TYPE,
    PAYMENT_TERM,
    REMARKS,
    DUE_DAYS,
    DUE_DAYS_FROM,
    PROJ_MS_ID,
    DUE_DATE,
    REVISION,
    REVISION_DATE,
    REVISED_BY,
    ATTRIBUTE_CATEGORY,
    ATTRIBUTE1,
    ATTRIBUTE2,
    ATTRIBUTE3,
    ATTRIBUTE4,
    ATTRIBUTE5,
    ATTRIBUTE6,
    ATTRIBUTE7,
    ATTRIBUTE8,
    ATTRIBUTE9,
    ATTRIBUTE10,
    CREATED_BY,
    CREATION_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN,
    INSTALLMENT_METHOD,
    INSTALLMENT_EVENT,
    PERIOD_OCCURENCE,
    PERIOD_VALUES,
    PERIOD_DURATION
  )
SELECT XXPM_MS_DTL_H_ID_S.nextval,
  MS_DTL_ID,
  MS_HDR_ID,
  SEQ_NUMBER,
  INSTALLMENT_TYPE,
  INSTALLMENT_PCT,
  CHARGE_TYPE,
  PAYMENT_TERM,
  REMARKS,
  DUE_DAYS,
  DUE_DAYS_FROM,
  PROJ_MS_ID,
  DUE_DATE,
  v_REVISION_NO,
  REVISION_DATE,
  REVISED_BY,
  ATTRIBUTE_CATEGORY,
  ATTRIBUTE1,
  ATTRIBUTE2,
  ATTRIBUTE3,
  ATTRIBUTE4,
  ATTRIBUTE5,
  ATTRIBUTE6,
  ATTRIBUTE7,
  ATTRIBUTE8,
  ATTRIBUTE9,
  ATTRIBUTE10,
  CREATED_BY,
  sysdate,
  LAST_UPDATED_BY,
  sysdate,
  LAST_UPDATE_LOGIN,
  INSTALLMENT_METHOD,
  INSTALLMENT_EVENT,
  PERIOD_OCCURENCE,
  PERIOD_VALUES,
  PERIOD_DURATION
FROM xxpm_milestone_dtl
WHERE MS_HDR_ID =v_ms_hdr_id ;
       

DBMS_OUTPUT.PUT_LINE('History Detail ID '|| v_ms_dtl_id_h);

UPDATE xxdm_milestone_dtl
 set insert_history_flag = 'P'
WHERE 
--rowid =i.rowid
--  AND 
  milestone_number=ri.milestone_number
  AND batch_id =p_batch_id;   
  
  UPDATE    xxpm_milestone_hdr set revision_no =v_REVISION_NO+1 
              WHERE milestone_number = ri.MILESTONE_NUMBER;
              
              
  UPDATE xxpm_milestone_dtl SET REVISION=v_REVISION_NO+1
WHERE MS_HDR_ID =v_ms_hdr_id ;

-- END LOOP;

END LOOP;

   COMMIT;
   




END xxpm_ms_history_insert;

PROCEDURE xxpm_milestone_dtl_insert (p_batch_id number)
AS

CURSOR c_ms_dtl is
select dtl.rowid,dtl.* from xxdm_milestone_dtl dtl
where batch_id = p_batch_id
and interface_status_flag = 'V';
--and action_flag = 'I';

v_errm          varchar2(1000);
v_ms_hdr        number;
V_MS_HDR_ID     number;
V_REVISION_NO   number;
V_REVISION_DATE DATE;
v_batch_id  NUMBER;
v_status    VARCHAR2(100);

BEGIN
v_batch_id:=p_batch_id;
FOR i in c_ms_dtl
LOOP

  BEGIN
        select count(1) 
        into v_ms_hdr
        from XXPM_MILESTONE_HDR 
        where MILESTONE_NUMBER = i.MILESTONE_NUMBER;

        DBMS_OUTPUT.PUT_LINE(v_ms_hdr);

          IF v_ms_hdr > 0 THEN

          BEGIN
            SELECT MS_HDR_ID,status
            into v_ms_hdr_id ,v_status
            from XXPM_MILESTONE_HDR 
            where MILESTONE_NUMBER = i.MILESTONE_NUMBER;
          EXCEPTION
          WHEN OTHERS THEN
           v_ms_hdr_id:='';
			     v_errm := SQLCODE || '-' || SQLERRM;          
          END;

          ELSE
             v_ms_hdr_id:=null;
          END IF;

  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ms_hdr_id:='';   
               v_ms_hdr := 0;
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

    --------------------------------------------------------------------------------
----------------Update Existing DTL record in Base Table------------------------
--------------------------------------------------------------------------------  
IF i.action_flag = 'U' THEN

   IF v_status = 'APR' THEN
             DBMS_OUTPUT.PUT_LINE('INSERT INTO HISTORY inside if ');

	xxpm_ms_history_insert(p_batch_id ,i.ms_dtl_id);

  end if;


  
  
    DBMS_OUTPUT.PUT_LINE('INSERT INTO HISTORY');

UPDATE XXPM_MILESTONE_DTL
SET        (MS_HDR_ID,
            SEQ_NUMBER,
            INSTALLMENT_TYPE,
            INSTALLMENT_PCT,
            CHARGE_TYPE,
            PAYMENT_TERM,
            REMARKS,
            DUE_DAYS,
            DUE_DAYS_FROM,
            PROJ_MS_ID,
            DUE_DATE,
            REVISION,
            REVISION_DATE,
            REVISED_BY,
--                        ATTRIBUTE_CATEGORY,
--                        ATTRIBUTE1,
--                        ATTRIBUTE2,
--                        ATTRIBUTE3,
--                        ATTRIBUTE4,
--                        ATTRIBUTE5,
--                        ATTRIBUTE6,
--                        ATTRIBUTE7,
--                        ATTRIBUTE8,
--                        ATTRIBUTE9,
--                        ATTRIBUTE10,
--            CREATED_BY,
--            CREATION_DATE,
--            LAST_UPDATED_BY,
--            LAST_UPDATE_DATE,
--            LAST_UPDATE_LOGIN,
            INSTALLMENT_METHOD,
            PERIOD_OCCURENCE,
            PERIOD_VALUES,
            PERIOD_DURATION,
            INSTALLMENT_EVENT
            ) = (SELECT  v_ms_hdr_id,
                        SEQ_NUMBER,
                        INSTALLMENT_TYPE,
                        INSTALLMENT_PCT,
                        CHARGE_TYPE,
                        PAYMENT_TERM,
                        REMARKS,
                        DUE_DAYS,
                        DUE_DAYS_FROM,
                        PROJ_MS_ID,
                        DUE_DATE,
                        REVISION,
                        REVISION_DATE,
                        REVISED_BY,
--                        ATTRIBUTE_CATEGORY,
--                        ATTRIBUTE1,
--                        ATTRIBUTE2,
--                        ATTRIBUTE3,
--                        ATTRIBUTE4,
--                        ATTRIBUTE5,
--                        ATTRIBUTE6,
--                        ATTRIBUTE7,
--                        ATTRIBUTE8,
--                        ATTRIBUTE9,
--                        ATTRIBUTE10,
--                        CREATED_BY,
--                        CREATION_DATE,
--                        LAST_UPDATED_BY,
--                        LAST_UPDATE_DATE,
--                        LAST_UPDATE_LOGIN,
                        INSTALLMENT_METHOD,
                        PERIOD_OCCURENCE,
                        PERIOD_VALUES,
                        PERIOD_DURATION,
                        INSTALLMENT_EVENT
              FROM XXDM_MILESTONE_DTL          
              WHERE ms_dtl_id = i.ms_dtl_id
              and batch_id = i.batch_id           
              )
        where ms_dtl_id = i.ms_dtl_id;

--------------------------------------------------------------------------------
----------------Insert DTL Base Table-------------------------------------------
--------------------------------------------------------------------------------  
 ELSIF i.ACTION_FLAG = 'I' THEN
        DBMS_OUTPUT.PUT_LINE('Insert into original ');
        INSERT INTO XXPM_MILESTONE_DTL
                       (MS_DTL_ID,
                        MS_HDR_ID,
                        SEQ_NUMBER,
                        INSTALLMENT_TYPE,
                        INSTALLMENT_PCT,
                        CHARGE_TYPE,
                        PAYMENT_TERM,
                        REMARKS,
                        DUE_DAYS,
                        DUE_DAYS_FROM,
                        PROJ_MS_ID,
                        DUE_DATE,
                        REVISION,
                        REVISION_DATE,
                        REVISED_BY,
--                        ATTRIBUTE_CATEGORY,
--                        ATTRIBUTE1,
--                        ATTRIBUTE2,
--                        ATTRIBUTE3,
--                        ATTRIBUTE4,
--                        ATTRIBUTE5,
--                        ATTRIBUTE6,
--                        ATTRIBUTE7,
--                        ATTRIBUTE8,
--                        ATTRIBUTE9,
--                        ATTRIBUTE10,
                        CREATED_BY,
                        CREATION_DATE,
                        LAST_UPDATED_BY,
                        LAST_UPDATE_DATE,
                        LAST_UPDATE_LOGIN,
                        INSTALLMENT_METHOD,
                        PERIOD_OCCURENCE,
                        PERIOD_VALUES,
                        PERIOD_DURATION,
                        INSTALLMENT_EVENT
                        )
                SELECT  XXPM_MS_DTL_ID_S.nextval,
                        v_ms_hdr_id,
                        SEQ_NUMBER,
                        INSTALLMENT_TYPE,
                        INSTALLMENT_PCT,
                        CHARGE_TYPE,
                        PAYMENT_TERM,
                        REMARKS,
                        DUE_DAYS,
                        DUE_DAYS_FROM,
                        PROJ_MS_ID,
                        DUE_DATE,
                        REVISION,
                        REVISION_DATE,
                        REVISED_BY,
--                        ATTRIBUTE_CATEGORY,
--                        ATTRIBUTE1,
--                        ATTRIBUTE2,
--                        ATTRIBUTE3,
--                        ATTRIBUTE4,
--                        ATTRIBUTE5,
--                        ATTRIBUTE6,
--                        ATTRIBUTE7,
--                        ATTRIBUTE8,
--                        ATTRIBUTE9,
--                        ATTRIBUTE10,
                        CREATED_BY,
                        CREATION_DATE,
                        LAST_UPDATED_BY,
                        LAST_UPDATE_DATE,
                        LAST_UPDATE_LOGIN,
                        INSTALLMENT_METHOD,
                        PERIOD_OCCURENCE,
                        PERIOD_VALUES,
                        PERIOD_DURATION,
                        INSTALLMENT_EVENT
              FROM XXDM_MILESTONE_DTL          
              WHERE MILESTONE_NUMBER = i.MILESTONE_NUMBER
              and rowid = i.rowid
              and batch_id=v_batch_id;         
    ELSE

        NULL;

    END IF;             

 update xxdm_milestone_dtl
 set interface_status_flag = 'P'
 where rowid =i.rowid
  --and milestone_number=ri.milestone_number
  and batch_id =p_batch_id;   

END LOOP

commit;

END xxpm_milestone_dtl_insert;

END XXPM_MILESTONE_DETAIL_PKG;
