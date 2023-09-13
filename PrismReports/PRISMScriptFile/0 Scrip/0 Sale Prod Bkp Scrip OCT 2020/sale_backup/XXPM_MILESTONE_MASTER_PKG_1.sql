--------------------------------------------------------
--  DDL for Package Body XXPM_MILESTONE_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_MILESTONE_MASTER_PKG" 
AS

--==============================================================================
---------------------Milestone Validations---------------------------------------
--==============================================================================

PROCEDURE xxpm_milestone_master_val (i_batch_id IN NUMBER)
AS

Cursor c_milestone_temp is
  select * from XXDM_MILESTONE_HDR
  where batch_id = i_batch_id;
 -- and process_flag is null;
--  and milestone_number = 'MS-1000190';

v_batch_id           NUMBER;
v_ready_flag         varchar2 (1);
v_ms_hdr_id          number;
v_org_id             number;
v_org_id_count       number;
v_milestone_num      number;
v_bu_proj            number;
v_start_date         date;
v_end_date           date;
v_ms_count           number;
v_status             varchar2(150);
v_trans_status       varchar2(150);
v_action_flag        varchar2(10);
v_history_flag       varchar2(10);
v_err_reason         varchar2 (2000);
v_err_desc           varchar2 (2000);
v_errm               varchar2 (2000);   
v_ms_shortcode       number;   

Begin
		v_batch_id := i_batch_id;

FOR i IN c_milestone_temp 
LOOP
	v_ready_flag   := 'V';
	v_err_reason   := null;
	v_errm         := null;
    v_action_flag  := null;
    v_history_flag := null;
    v_err_desc     := null;
--------------------------------------------------------------------------------
----------------Validate Org ID-------------------------------------------------
--------------------------------------------------------------------------------

--  DBMS_OUTPUT.PUT_LINE('Validate Org ID');      


  BEGIN
        select count(org_id) 
        into v_org_id
        from XXDM_MILESTONE_HDR 
        where milestone_number = i.milestone_number
        and batch_id  = i.batch_id;

--  DBMS_OUTPUT.PUT_LINE('Org ID Count '||v_org_id);      

  EXCEPTION
			WHEN OTHERS
			  THEN
			   v_org_id:=0;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
---------------Organization lookup validation-----------------------------------
--------------------------------------------------------------------------------

    BEGIN

        select count(1) into v_org_id_count from xxstg_organizations where org_id=i.org_id;

    EXCEPTION
			WHEN OTHERS
			  THEN
			   v_org_id_count:=0;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;


--------------------------------------------------------------------------------
---------------Milestone Short code validation-----------------------------------
--------------------------------------------------------------------------------

    BEGIN

        select count(1) into v_ms_shortcode from XXDM_MILESTONE_HDR 
        where milestone_number=i.milestone_number
        and batch_id=i.batch_id;

    EXCEPTION
			WHEN OTHERS
			  THEN
			   v_ms_shortcode:=0;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validate Date---------------------------------------------------
--------------------------------------------------------------------------------

  DBMS_OUTPUT.PUT_LINE('Validate Date');      

  BEGIN
        select start_date,end_date 
        into v_start_date,v_end_date
        from XXDM_MILESTONE_HDR 
        where milestone_number = i.milestone_number
        and batch_id  = i.batch_id;

 DBMS_OUTPUT.PUT_LINE('Start Date '||v_start_date||','||'End Date '||v_end_date);      

  EXCEPTION
			WHEN OTHERS
			  THEN
        DBMS_OUTPUT.PUT_LINE('exception in date validation');      
			   v_start_date := sysdate;         
               v_end_date := sysdate;
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
          DBMS_OUTPUT.PUT_LINE('exception in date validation'||v_errm);  
	END;

--------------------------------------------------------------------------------
----------------Validate Milestone Number---------------------------------------
--------------------------------------------------------------------------------

--  DBMS_OUTPUT.PUT_LINE('Validate Milestone Number');      

  Begin      
      select count(1)
      into v_ms_count
      from xxpm_milestone_hdr 
      where milestone_number= i.milestone_number;

        IF v_ms_count > 0 THEN

         BEGIN
          select ms_hdr_id
          into v_ms_hdr_id
          from xxpm_milestone_hdr 
          where milestone_number= i.milestone_number;
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
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validate Milestone Status---------------------------------------
--------------------------------------------------------------------------------

--  DBMS_OUTPUT.PUT_LINE('Validate Milestone Status');      

  Begin
        SELECT status 
        into v_status
        FROM xxpm_milestone_hdr
        where milestone_number = i.milestone_number;

--  DBMS_OUTPUT.PUT_LINE('Milestone Status'||v_status);      

	EXCEPTION
      WHEN NO_DATA_FOUND THEN
      null;
			WHEN OTHERS
			  THEN
			   v_status:=null;         
			   v_ready_flag := 'E';
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------Validate Milestone Status existence-----------------------------
--------------------------------------------------------------------------------  

  BEGIN
  select count(1) 
  into v_trans_status
  from xxfnd_lookup_v
  where LOOKUP_TYPE_NAME = 'TRANSACTION_STATUS'  
  and LOOKUP_VALUE_NAME  = i.status;  
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_trans_status:=0;         
           v_ready_flag := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
	END;

--------------------------------------------------------------------------------
----------------BU and PROJECT ID VALIDATIONS-----------------------------------
--------------------------------------------------------------------------------  

  BEGIN
  select count(1) 
  into v_bu_proj
  from XXSTG_PROJECTS pro,xxstg_organizations org
  where pro.ORG_ID=org.ORG_ID
  and pro.proj_id=i.project_id
  and org.org_id=i.org_id;
--    select 1
--    into v_bu_proj
--    from dual;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        null;
        WHEN OTHERS
          THEN
           v_bu_proj:=0;         
           v_ready_flag := 'E';
           v_errm := SQLCODE || '-' || SQLERRM;
	END;

    --------------------------------------------------------------------------------
    ------------Mandatory validation -----------------
    --------------------------------------------------------------------------------  

if i.MILESTONE_NAME is null then
 v_ready_flag := 'E';
     v_err_desc   := 'MILESTONE_NAME should not be null';      
end if;

if i.MILESTONE_NUMBER  is null then
 v_ready_flag := 'E';
     v_err_desc   := 'MILESTONE_NAME should not be null';      
end if;



if i.MILESTONE_SHORTCODE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'MILESTONE_SHORTCODE should not be null';      
end if;


if i.MILESTONE_DATE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'MILESTONE_DATE should not be null';      
end if;


if i.PROJECT_ID is null then
 v_ready_flag := 'E';
     v_err_desc   := 'PROJECT_ID should not be null';      
end if;



if i.USAGE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'USAGE should not be null';      
end if;



if i.START_DATE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'START_DATE should not be null';      
end if;




if i.END_DATE is null then
 v_ready_flag := 'E';
     v_err_desc   := 'END_DATE should not be null';      
end if;



if i.ACTIVE_YN is null then
 v_ready_flag := 'E';
     v_err_desc   := 'ACTIVE_YN should not be null';      
end if;


if i.STATUS is null then
 v_ready_flag := 'E';
     v_err_desc   := 'STATUS should not be null';      
end if;


if i.ORG_ID is null then
 v_ready_flag := 'E';
     v_err_desc   := 'ORG_ID should not be null';      
end if;



--------------------------------------------------------------------------------
----------------Validate Conditions---------------------------------------------
--------------------------------------------------------------------------------  

--  DBMS_OUTPUT.PUT_LINE('Validate Conditions');      

  IF v_org_id > 0 THEN
     IF v_org_id_count > 0 THEN
       IF (v_ms_shortcode =1) or (i.milestone_shortcode is not null) THEN 
        IF nvl(v_start_date,sysdate) < nvl(v_end_date,v_start_date+1) THEN
          -- IF(v_bu_proj >0) THEN
              IF v_trans_status > 0  THEN
                IF v_ms_count > 0 THEN 
                 -- IF v_status = i.status THEN
                    IF i.status = 'APR' THEN
                        v_ready_flag   := 'V';
                        v_action_flag  := 'U';
                        v_history_flag := 'Y';
                        dbms_output.put_line('Insert into History Table and Update Base Table');
                    ELSE
                        v_ready_flag  := 'V';
                        v_action_flag := 'U';
                        dbms_output.put_line('Update Base Table');
                    END IF;

                ELSE  
                   v_ready_flag  := 'V';
                   v_action_flag := 'I';
                END IF;
              ELSE           
                   v_ready_flag := 'E';
                   v_err_desc   := 'Invalid Status';                 
              END IF;  
          -- ELSE
           -- v_ready_flag := 'E';
           -- v_err_desc   := 'ORGANIZATION UNIT IS NOT LINKED WITH PROJECT ID';       
          -- END IF;       
        ELSE
            v_ready_flag := 'E';
            v_err_desc   := 'Start date should not be greater than End Date';       
        END IF;  
      ELSE
        v_ready_flag := 'E';
        v_err_desc   := 'Milestone short code is null or duplicated';       
      END IF;  
     ELSE
     v_ready_flag := 'E';
     v_err_desc   := 'Org ID not exist in Lookup table';       
     END IF;      
  ELSE
     v_ready_flag := 'E';
     v_err_desc   := 'Org ID should not be null';       
  END IF;                        

--------------------------------------------------------------------------------
----------------Update Err Msg and Process Flag---------------------------------
--------------------------------------------------------------------------------    

  update xxdm_milestone_hdr
  set ERR_DESCRIPTION = v_err_desc
     ,ACTION_FLAG     = v_action_flag
     ,PROCESSED_DATE  = SYSDATE
     ,PROCESS_FLAG    = v_ready_flag
     ,INSERT_HISTORY_FLAG = v_history_flag
     ,interface_status_flag=v_ready_flag
     ,err_msg=v_errm
  where milestone_number = i.milestone_number
  and batch_id  = i.batch_id;


  IF v_ready_flag = 'E' THEN

  UPDATE xxdm_milestone_dtl
  SET
  INTERFACE_STATUS_FLAG =v_ready_flag ,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc
  WHERE    milestone_number=i.milestone_number
  and batch_id =i.batch_id;   
  end if;



dbms_output.put_line('Ready Flag - '||v_ready_flag||'. '|| v_err_reason);
dbms_output.put_line('Action Flag - '||v_action_flag||'. '|| v_err_reason);

END LOOP;  

commit;

END xxpm_milestone_master_val;

PROCEDURE xxpm_milestone_insert_history (p_batch_id NUMBER , p_milestone_number in varchar2)
AS

v_errm          varchar2(1000);
V_MS_HDR_ID_H   number;
V_REVISION_NO   number;
V_REVISION_DATE DATE;
v_ms_dtl_id_h   NUMBER;
v_ms_hdr_id     NUMBER;
v_ms_count      NUMBER;

cursor c_ms_stg_hdr is
SELECT *
from xxdm_milestone_hdr 
WHERE batch_id = p_batch_id
and MILESTONE_NUMBER =p_milestone_number
AND interface_status_flag = 'V'
and action_flag  = 'U'
--AND insert_history_flag = 'Y
;

Cursor c_ms_dtl(p_milestone_id number) is
 select * from xxpm_milestone_dtl
 where ms_hdr_id = p_milestone_id;

BEGIN

--------------------------------------------------------------------------------
----------------Derive History Header ID----------------------------------------
--------------------------------------------------------------------------------  

FOR ri in c_ms_stg_hdr
LOOP

   BEGIN
--     select max(nvl(MS_HDR_ID_H,0))+1
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
  	  where milestone_number= ri.milestone_number;

        IF v_ms_count > 0 THEN

         BEGIN
          SELECT ms_hdr_id,REVISION_NO
          into v_ms_hdr_id,V_REVISION_NO
          from xxpm_milestone_hdr 
          where milestone_number= ri.milestone_number;
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
              WHERE milestone_number = ri.milestone_number;

DBMS_OUTPUT.PUT_LINE('History Header ID '|| V_MS_HDR_ID_H);

--------------------------------------------------------------------------------
----------------Insert into DTL History table-----------------------------------
--------------------------------------------------------------------------------

FOR i in c_ms_dtl(v_ms_hdr_id) 
LOOP

v_ms_dtl_id_h := null;

         BEGIN  
--          select max(MS_DTL_ID_H)+1 
--          into v_ms_dtl_id_h
--          from xxpm_milestone_dtl_h;

select  XXPM_MS_DTL_H_ID_S.nextval into v_ms_dtl_id_h from dual;
         EXCEPTION
         WHEN OTHERS THEN
         v_ms_dtl_id_h := null;
         v_errm := SQLCODE || '-' || SQLERRM;
         END;


          INSERT INTO XXPM_MILESTONE_DTL_H
                       (MS_DTL_ID_H,
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
                      VALUES (v_ms_dtl_id_h,
                              i.MS_DTL_ID,
                              i.MS_HDR_ID,
                              i.SEQ_NUMBER,
                              i.INSTALLMENT_TYPE,
                              i.INSTALLMENT_PCT,
                              i.CHARGE_TYPE,
                              i.PAYMENT_TERM,
                              i.REMARKS,
                              i.DUE_DAYS,
                              i.DUE_DAYS_FROM,
                              i.PROJ_MS_ID,
                              i.DUE_DATE,
                              V_REVISION_NO,
                              i.REVISION_DATE,
                              i.REVISED_BY,
                              i.ATTRIBUTE_CATEGORY,
                              i.ATTRIBUTE1,
                              i.ATTRIBUTE2,
                              i.ATTRIBUTE3,
                              i.ATTRIBUTE4,
                              i.ATTRIBUTE5,
                              i.ATTRIBUTE6,
                              i.ATTRIBUTE7,
                              i.ATTRIBUTE8,
                              i.ATTRIBUTE9,
                              i.ATTRIBUTE10,
                              i.CREATED_BY,
                              sysdate,
                              i.LAST_UPDATED_BY,
                              sysdate,
                              i.LAST_UPDATE_LOGIN,
                              i.INSTALLMENT_METHOD,
                              i.INSTALLMENT_EVENT,
                              i.PERIOD_OCCURENCE,
                              i.PERIOD_VALUES,
                              i.PERIOD_DURATION );

DBMS_OUTPUT.PUT_LINE('History Detail ID '|| v_ms_dtl_id_h);

 END LOOP;

 update xxdm_milestone_hdr
 set insert_history_flag = 'P'
 where milestone_number = ri.milestone_number
 and batch_id = ri.batch_id;

END LOOP;

   Commit;

END xxpm_milestone_insert_history;

PROCEDURE xxpm_milestone_insert (p_batch_id NUMBER)
AS

cursor c_ms_stg_hdr_ins is
select *
from xxdm_milestone_hdr 
where batch_id = p_batch_id
and process_flag = 'V';

v_errm          varchar2(1000);
V_MS_HDR_ID_H   number;
V_REVISION_NO   number;
V_REVISION_DATE DATE;
v_ms_dtl_id_h   NUMBER;
v_status        VARCHAR2(100);
v_func_id       number;

BEGIN

FOR i in c_ms_stg_hdr_ins
LOOP

BEGIN

SELECT FUNC_ID INTO v_func_id FROM xxfnd_functions WHERE FUNC_SHORT_CODE ='MS';
 EXCEPTION
         WHEN OTHERS THEN
         v_func_id := null;
         v_errm := SQLCODE || '-' || SQLERRM;

end;



         BEGIN  
          select nvl(max(REVISION_NO),0)+1 
          into v_revision_no
          from xxpm_milestone_hdr
          where milestone_number = i.milestone_number;
         EXCEPTION
         WHEN OTHERS THEN
         v_ms_dtl_id_h := null;
         v_errm := SQLCODE || '-' || SQLERRM;
         END;

dbms_output.put_line('Revision No '||v_revision_no);

IF i.action_flag = 'U' THEN

----------------Update HDR Base table----------------------------------------

 BEGIN  
          SELECT STATUS 
          into v_status
          FROM xxpm_milestone_hdr
          where milestone_number = i.milestone_number;
         EXCEPTION
         WHEN OTHERS THEN
         v_ms_dtl_id_h := null;
         v_errm := SQLCODE || '-' || SQLERRM;
         END;

         if v_status = 'APR' then

         			xxpm_milestone_insert_history(p_batch_id,i.milestone_number);
              			DBMS_OUTPUT.PUT_LINE('HISTORY INSERT DONE if ');

              ELSE

              v_revision_no:=v_revision_no -1;

                       			DBMS_OUTPUT.PUT_LINE('HISTORY INSERT DONE else ');

         end if;




			DBMS_OUTPUT.PUT_LINE('HISTORY INSERT DONE ');

           UPDATE xxpm_milestone_hdr
           SET (MILESTONE_NAME,
                MILESTONE_NAME_TL,
                MILESTONE_NUMBER,
                MILESTONE_SHORTCODE,
                MILESTONE_DATE,
--                FUNC_ID,
                ORG_ID,
                PROJECT_ID,
--                MILESTONE_TYPE,
                USAGE,
                REVISION_NO,
                REVISION_DATE,
                REVISED_BY,
                DESCRIPTION,
                START_DATE,
                END_DATE,
                ACTIVE_YN,
                STATUS
--                FLOW_STATUS,
--                FLOW_LEVEL,
--                FLOW_WITH,
--                USER_GRP_ID,
--                ATTRIBUTE_CATEGORY,
--                ATTRIBUTE1,
--                ATTRIBUTE2,
--                ATTRIBUTE3,
--                ATTRIBUTE4,
--                ATTRIBUTE5,
--                ATTRIBUTE6,
--                ATTRIBUTE7,
--                ATTRIBUTE8,
--                ATTRIBUTE9,
--                ATTRIBUTE10,
--                CREATED_BY,
--                CREATION_DATE,
--                LAST_UPDATED_BY,
--                LAST_UPDATE_DATE,
--                LAST_UPDATE_LOGIN
                ) = (SELECT
                      MILESTONE_NAME,
                      MILESTONE_NAME_TL,
                      MILESTONE_NUMBER,
                      MILESTONE_SHORTCODE,
                      MILESTONE_DATE,
--                      FUNC_ID,
                      ORG_ID,
                      PROJECT_ID,
--                      MILESTONE_TYPE,
                      USAGE,
                      v_revision_no,
                      SYSDATE, --REVISION_DATE,
                      REVISED_BY,
                      DESCRIPTION,
                      START_DATE,
                      END_DATE,
                      ACTIVE_YN,
                      STATUS
--                      FLOW_STATUS,
--                      FLOW_LEVEL,
--                      FLOW_WITH,
--                      USER_GRP_ID,
--                      ATTRIBUTE_CATEGORY,
--                      ATTRIBUTE1,
--                      ATTRIBUTE2,
--                      ATTRIBUTE3,
--                      ATTRIBUTE4,
--                      ATTRIBUTE5,
--                      ATTRIBUTE6,
--                      ATTRIBUTE7,
--                      ATTRIBUTE8,
--                      ATTRIBUTE9,
--                      ATTRIBUTE10,
--                      CREATED_BY,
--                      CREATION_DATE,
--                      LAST_UPDATED_BY,
--                      LAST_UPDATE_DATE,
--                      LAST_UPDATE_LOGIN
                    FROM xxdm_milestone_hdr
                    where milestone_number = i.milestone_number
                    AND batch_id = p_batch_id
                      )
          WHERE milestone_number = i.milestone_number;

           update xxdm_milestone_hdr
           set process_flag = 'P'
           where milestone_number = i.milestone_number
           and batch_id = i.batch_id;


     ELSIF i.ACTION_FLAG = 'I' THEN

----------------Insert into HDR Base table--------------------------------------

                INSERT INTO XXPM_MILESTONE_HDR
           (MS_HDR_ID,
            MILESTONE_NAME,
            MILESTONE_NAME_TL,
            MILESTONE_NUMBER,
            MILESTONE_SHORTCODE,
            MILESTONE_DATE,
--            FUNC_ID,
              ORG_ID,
            PROJECT_ID,
--            MILESTONE_TYPE,
            USAGE,
            REVISION_NO,
            REVISION_DATE,
            REVISED_BY,
            DESCRIPTION,
            START_DATE,
            END_DATE,
            ACTIVE_YN,
            STATUS,
--            FLOW_STATUS,
--            FLOW_LEVEL,
--            FLOW_WITH,
--            USER_GRP_ID,
--            ATTRIBUTE_CATEGORY,
--            ATTRIBUTE1,
--            ATTRIBUTE2,
--            ATTRIBUTE3,
--            ATTRIBUTE4,
--            ATTRIBUTE5,
--            ATTRIBUTE6,
--            ATTRIBUTE7,
--            ATTRIBUTE8,
--            ATTRIBUTE9,
--            ATTRIBUTE10,
            CREATED_BY,
            CREATION_DATE,
            LAST_UPDATED_BY,
            LAST_UPDATE_DATE,
            LAST_UPDATE_LOGIN
            )
            select  XXPM_MILESTONE_ID_S.nextval,
                    MILESTONE_NAME,
                    MILESTONE_NAME_TL,
                    MILESTONE_NUMBER,
                    MILESTONE_SHORTCODE,
                    MILESTONE_DATE,
--                    FUNC_ID,
                    ORG_ID,
                    PROJECT_ID,
--                    MILESTONE_TYPE,
                    USAGE,
                    v_revision_no,
                    REVISION_DATE,
                    REVISED_BY,
                    DESCRIPTION,
                    START_DATE,
                    END_DATE,
                    ACTIVE_YN,
                    STATUS,
--                    FLOW_STATUS,
--                    FLOW_LEVEL,
--                    FLOW_WITH,
--                    USER_GRP_ID,
--                    ATTRIBUTE_CATEGORY,
--                    ATTRIBUTE1,
--                    ATTRIBUTE2,
--                    ATTRIBUTE3,
--                    ATTRIBUTE4,
--                    ATTRIBUTE5,
--                    ATTRIBUTE6,
--                    ATTRIBUTE7,
--                    ATTRIBUTE8,
--                    ATTRIBUTE9,
--                    ATTRIBUTE10,
                    nvl(CREATED_BY,1),
                    SYSDATE, --CREATION_DATE,
                    nvl(LAST_UPDATED_BY,1),
                    SYSDATE, --LAST_UPDATE_DATE,
                    nvl(LAST_UPDATE_LOGIN,1)
              from xxdm_milestone_hdr
                WHERE MILESTONE_NUMBER = i.milestone_number
              AND batch_id = p_batch_id;

           update xxdm_milestone_hdr
           set process_flag = 'P'
           where milestone_number = i.milestone_number
           and batch_id = i.batch_id;

    ELSE

        NULL;

    END IF;                          

END LOOP;

              commit;

END xxpm_milestone_insert;

END XXPM_MILESTONE_MASTER_PKG;
