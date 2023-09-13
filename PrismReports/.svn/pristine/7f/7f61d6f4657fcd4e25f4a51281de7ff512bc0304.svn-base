--------------------------------------------------------
--  DDL for Procedure XXDM_PAYMENT_MILESTONES_CREATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXDM_PAYMENT_MILESTONES_CREATION" 
AS

CURSOR c_ms_dtl is
select dtl.rowid,dtl.* from xxdm_milestone_dtl dtl where
 interface_status_flag = 'V';
--and action_flag = 'I';

v_errm          varchar2(1000);
v_ms_hdr        number;
V_MS_HDR_ID     number;
V_REVISION_NO   number;
V_REVISION_DATE DATE;
v_batch_id  NUMBER;
v_status    VARCHAR2(100);

BEGIN

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

	--xxpm_ms_history_insert(p_batch_id ,i.ms_dtl_id);

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
            ) = (SELECT  MS_HDR_ID,
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
             -- and batch_id = i.batch_id           
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
              FROM XXDM_MILESTONE_DTL          
              WHERE MILESTONE_NUMBER = i.MILESTONE_NUMBER
              and rowid = i.rowid;
                      
    ELSE

        NULL;

    END IF;             

 update xxdm_milestone_dtl
 set interface_status_flag = 'P'
 where rowid =i.rowid;
  --and milestone_number=ri.milestone_numbe

END LOOP

commit;


END XXDM_PAYMENT_MILESTONES_CREATION;
