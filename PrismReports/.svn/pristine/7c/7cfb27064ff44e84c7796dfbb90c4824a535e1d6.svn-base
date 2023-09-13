CREATE OR REPLACE package XXPM_CANCELLATION_PKG
is

procedure xxpm_update_milestone_status(
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
);

PROCEDURE xxpm_insert_booking_ms_debit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
);

PROCEDURE xxpm_insert_cancellation_credit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
);

procedure XXPM_CREATE_AUTO_BILLING(
        p_primary_id 	IN NUMBER,
        p_func_id       IN VARCHAR2,
        p_login_user 	in VARCHAR2,
        P_ERR_MSG		OUT VARCHAR2
        );

end XXPM_CANCELLATION_PKG;
/


CREATE OR REPLACE PACKAGE BODY XXPM_CANCELLATION_PKG
IS

procedure xxpm_update_milestone_status(
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
)
as
    l_booking_id    NUMBER;
    l_status        VARCHAR2(60);
    l_staus_count   NUMBER;

BEGIN
--get cancellation booking id
    BEGIN
DBMS_OUTPUT.PUT_LINE(' Stage 0: get booking id');    
        SELECT
            booking_id
        INTO l_booking_id
        FROM
            xxpm_cancellation
        WHERE
            cancel_id = p_primary_id
            AND func_id = p_func_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_booking_id := 0;
END;
DBMS_OUTPUT.PUT_LINE(' Stage 0: get booking id'||l_booking_id);   
-- check booking status
    BEGIN
DBMS_OUTPUT.PUT_LINE(' Stage 1: get booking status - '||l_booking_id);    
        SELECT
            status
        INTO l_status
        FROM
            xxpm_booking_header
        WHERE
            booking_hdr_id = l_booking_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_status := 'NULL';
    END;
DBMS_OUTPUT.PUT_LINE(' Stage 1: get booking status - '||l_status);    
--checking if condition

    BEGIN
        IF l_status = 'CANCEL' THEN 
--updating status flag
            BEGIN
                UPDATE xxpm_booking_milestones
                SET
                    MILESTONES_STATUS = 'N',
                    last_updated_by = p_login_user,
                    last_update_date = SYSDATE,
                    last_update_login = p_login_user
                WHERE
                    INVOICE_ID is null
                    and MILESTONE_TYPE = 'MS'
                    and booking_hdr_id = l_booking_id;
            END;
                COMMIT;
DBMS_OUTPUT.PUT_LINE(' Stage 2: udpate booking status');
        END IF;
    END;

DBMS_OUTPUT.PUT_LINE(' Stage 3: get status count - '||l_status);
    SELECT
        COUNT(MILESTONES_STATUS)
    INTO l_staus_count
    FROM
        xxpm_booking_milestones
    WHERE
        booking_hdr_id = l_booking_id
        and INVOICE_ID is null;
DBMS_OUTPUT.PUT_LINE(' Stage 3: get Status count - '||l_staus_count);
    IF l_staus_count = 0 THEN
        p_out_status := 'Y';
    ELSE
        p_out_status := 'Y';
    END IF;
    begin
DBMS_OUTPUT.PUT_LINE(' Stage 4: debit memo start - ');    
    XXPM_CANCELLATION_PKG.xxpm_insert_booking_ms_debit_memo(p_primary_id,p_func_id,p_login_user,p_out_status);  
     EXCEPTION
        WHEN no_data_found THEN
            p_out_status := 'NULL';
DBMS_OUTPUT.PUT_LINE(' Stage 4-Error: debit memo start - ');    
    end;
    begin   
DBMS_OUTPUT.PUT_LINE(' Stage 5: credit memo start - ');    
    XXPM_CANCELLATION_PKG.xxpm_insert_cancellation_credit_memo(p_primary_id,p_func_id,p_login_user,p_out_status); 
         EXCEPTION
        WHEN no_data_found THEN
            p_out_status := 'NULL';
DBMS_OUTPUT.PUT_LINE(' Stage 5-Error: credit memo start - ');    
    end;

END xxpm_update_milestone_status;
   
   
PROCEDURE xxpm_insert_booking_ms_debit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
) AS
    l_booking_id       NUMBER;
    l_forfiet_amount   NUMBER;
    lms_dtlid          NUMBER;
    l_ms_count         NUMBER;
    l_P_ERR_MSG          number; 
BEGIN
--get cancellation booking id and forfeit amount
DBMS_OUTPUT.PUT_LINE(' Stage 0D -get Booking id and forfien amt');    
    BEGIN
        SELECT
            booking_id,
            forfiet_amount
        INTO
            l_booking_id,
            l_forfiet_amount
        FROM
            xxpm_cancellation
        WHERE
            status = 'APR'
            AND cancel_id = p_primary_id
            AND func_id = p_func_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_booking_id := 0;
DBMS_OUTPUT.PUT_LINE(' Stage 0D -get Booking id and forfien amt'||l_booking_id||'<---->'||l_forfiet_amount);    
    END;
--Getting Booking Ms Count

    BEGIN
DBMS_OUTPUT.PUT_LINE(' Stage 1D -get the count');        
        SELECT
            COUNT(*)
        INTO l_ms_count
        FROM
            xxpm_booking_milestones
        WHERE
            booking_hdr_id = l_booking_id;
    EXCEPTION
        WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE('Stage 1D -get the count');        
    END;
 -- Inserting Debit memo for cancellation
BEGIN
        -- Seque no
        lms_dtlid := xxpm_booking_milestones_s.nextval;
        dbms_output.put_line('next installemnt Id lms_dtlId==>' || lms_dtlid);
        DBMS_OUTPUT.PUT_LINE('Stage 1D -get the l_forfiet_amount -->'||l_forfiet_amount);        
        IF ( l_forfiet_amount != 0) THEN
            INSERT INTO xxpm_booking_milestones (
                booking_ms_dtl_id,
                milestone_type,
                seq_number,
                installment_amount,
                charge_type,
                payment_term,
                remarks,
                due_date,
                source_func_id,
                source_func_ref_id,
                booking_hdr_id,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            ) VALUES (
                lms_dtlid,
                'CNL',
                l_ms_count + 1,
                l_forfiet_amount,
                'CAN_DEB_MO',
                5,
                'Debit memo created. Cancellation-Forfeit Amount :' || l_forfiet_amount,
                SYSDATE,
                p_func_id,
                p_primary_id,
                l_booking_id,
                p_login_user,
                SYSDATE,
                p_login_user,
                SYSDATE,
                p_login_user
            );
        
            COMMIT;
            begin
            XXPM_CANCELLATION_PKG.XXPM_CREATE_AUTO_BILLING(P_PRIMARY_ID,P_FUNC_ID,p_login_user,l_P_ERR_MSG);
            DBMS_OUTPUT.PUT_LINE('Stage 1D -debit memo billing -->');
            EXCEPTION
            WHEN no_data_found THEN
            p_out_status:='N';
            end;
            p_out_status:='Y';
        END IF;
end;
END xxpm_insert_booking_ms_debit_memo;

PROCEDURE xxpm_insert_cancellation_credit_memo (
    p_primary_id   IN             NUMBER,
    p_func_id      IN             NUMBER,
    p_login_user   IN             VARCHAR2,
    p_out_status   OUT            VARCHAR2
) AS
    l_booking_id       NUMBER;
    l_ORG_ID           number;
    lms_dtlid          NUMBER;
    l_ms_count         NUMBER;
    l_P_ERR_MSG        number; 
    l_cmc_amount       number;
    l_refund_amount    number;
BEGIN
--get cancellation booking id and org id

begin
DBMS_OUTPUT.PUT_LINE('Stage 1C -credit memo billing -->');
    SELECT
    booking_id,
    ORG_ID,
    REFUND_AMOUNT    
    INTO
    l_booking_id,
    l_ORG_ID,
    l_refund_amount
    FROM
    xxpm_cancellation
    WHERE
    status = 'APR'
    AND 
    cancel_id = p_primary_id
    AND func_id = p_func_id;

    EXCEPTION
        WHEN no_data_found THEN
            l_booking_id := 0;
            l_ORG_ID:=0;
            l_refund_amount:=0;
    END;
DBMS_OUTPUT.PUT_LINE('Stage 1C -credit memo billing -->'||l_booking_id||'-----'||l_ORG_ID||'----'||l_refund_amount);
-- get credit memo amount
begin
DBMS_OUTPUT.PUT_LINE('Stage 2C - get credit memo amount -->');
SELECT 
INVOICED_AMOUNT into l_cmc_amount
FROM xxpm_booking_hdr_search_v 
where 
ORG_ID=l_ORG_ID
and BOOKING_HDR_ID=l_booking_id;
EXCEPTION
WHEN no_data_found THEN
l_cmc_amount := 0;
end;
DBMS_OUTPUT.PUT_LINE('Stage 2C - get credit memo amount l_cmc_amount-->'||l_cmc_amount);
--Getting Booking Ms Count
    begin 
        SELECT
            COUNT(*)
        INTO l_ms_count
        FROM
            xxpm_booking_milestones
        WHERE
            booking_hdr_id = l_booking_id;
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('MS Count not found ' || l_ms_count);
    end;
DBMS_OUTPUT.PUT_LINE('Stage 2C - get count l_ms_count-->'||l_ms_count);
 -- Inserting credit memo for cancellation
begin
DBMS_OUTPUT.PUT_LINE('Stage 4C - insert credit memo line-->');
        -- Seque no
        lms_dtlid := xxpm_booking_milestones_s.nextval;
        dbms_output.put_line('next installemnt Id lms_dtlId==>' || lms_dtlid);
            INSERT INTO xxpm_booking_milestones (
                booking_ms_dtl_id,
                milestone_type,
                seq_number,
                installment_amount,
                charge_type,
                payment_term,
                remarks,
                due_date,
                source_func_id,
                source_func_ref_id,
                booking_hdr_id,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                ATTRIBUTE1
            ) VALUES (
                lms_dtlid,
                'CNL',
                l_ms_count + 1,
                l_cmc_amount,
                'CMC',
                5,
                'Credit memo created. Cancellation Amount :' || l_cmc_amount,
                SYSDATE,
                p_func_id,
                p_primary_id,
                l_booking_id,
                p_login_user,
                SYSDATE,
                p_login_user,
                SYSDATE,
                p_login_user,
                l_refund_amount
            );

            COMMIT;
            begin
            XXPM_CANCELLATION_PKG.XXPM_CREATE_AUTO_BILLING(P_PRIMARY_ID,P_FUNC_ID,p_login_user,l_P_ERR_MSG);
            dbms_output.put_line('Stage 7 booking ms inserted==>');
            end;
            p_out_status:='Y';
EXCEPTION
WHEN no_data_found THEN
p_out_status:='N';
DBMS_OUTPUT.PUT_LINE('Stage 4E - Error in credit memo-->');
end;
END;


   
procedure XXPM_CREATE_AUTO_BILLING(
                                p_primary_id 	IN NUMBER,
                                p_func_id       IN VARCHAR2,
                                p_login_user 	in VARCHAR2,
                                P_ERR_MSG		OUT VARCHAR2
                                )
as
l_org_id    number;
l_PROJ_ID   number;
l_bill_id   number;
l_bill_fun_id   number;
l_BOOKING_MS_DTL_ID number;
l_P_ERROR_CODE varchar(30);
l_P_ERR_MSG varchar(30);
BEGIN
--
DBMS_OUTPUT.PUT_LINE('Stage 0A - get org, proj-->');
begin
Select 
bh.org_id, 
pro.PROJ_ID,
BOOKING_MS_DTL_ID
into 
l_org_id,
l_PROJ_ID,
l_BOOKING_MS_DTL_ID
from xxpm_booking_header bh, xxstg_projects pro, xxpm_booking_milestones bms
where 
pro.ORG_ID=bh.ORG_ID
and bh.BOOKING_HDR_ID=bms.BOOKING_HDR_ID
and bms.SOURCE_FUNC_ID =p_func_id
and bms.CHARGE_TYPE='CAN_DEB_MO'
and bms.SOURCE_FUNC_REF_ID=p_primary_id;
DBMS_OUTPUT.PUT_LINE('Stage 0A - get org, proj-->'||l_org_id||''||l_PROJ_ID);
end;
--
dbms_output.put_line('inserted End==>'||l_org_id||'-'||l_PROJ_ID||'-'||l_BOOKING_MS_DTL_ID);
if(l_org_id is not null and l_PROJ_ID is not null)    then
l_bill_id:=XXPM_BILLING_S.nextval;
l_bill_fun_id:=20;
--create insert for billing
dbms_output.put_line('inserted Start==>');
INSERT INTO xxpm_billing
(
BILLING_ID               
,BILLING_NUMBER           
,BILLING_DATE             
,USAGE                    
,ORG_ID                   
,STATUS                   
,DESCRIPTION              
,FUNC_ID                  
,CREATED_BY               
,CREATION_DATE            
,LAST_UPDATED_BY          
,LAST_UPDATE_DATE         
,LAST_UPDATE_LOGIN        
,PROJECT_ID )
VALUES
(
l_bill_id,
'BL-'||l_bill_id,
sysdate,
'S',
l_org_id,
'APR',
'Billing for Credit memo against the milestone',
l_bill_fun_id,
P_LOGIN_USER,
systimestamp,
P_LOGIN_USER,
systimestamp,
P_LOGIN_USER,
l_proj_id
);
COMMIT;
dbms_output.put_line('inserted End==>');
--updating billing in booking milestone
begin
update xxpm_booking_milestones
set BILLING_ID=l_bill_id
where 
SOURCE_FUNC_ID =p_func_id
and SOURCE_FUNC_REF_ID=p_primary_id
and CHARGE_TYPE='CAN_DEB_MO';
end;
commit;
dbms_output.put_line('Booking Ms Updated==>');
begin
dbms_output.put_line('Billing-->ms_id.booking_ms_dtl_id->'||l_BOOKING_MS_DTL_ID);
xxpm_bill_invoice_pkg.ms_based_invoice (l_BOOKING_MS_DTL_ID, l_P_ERROR_CODE,l_P_ERR_MSG);
dbms_output.put_line('Billing to invoice--P_ERROR_CODE->'||l_P_ERROR_CODE);
dbms_output.put_line('PKG--P_ERR_MSG->'||P_ERR_MSG);
EXCEPTION
  WHEN no_data_found THEN
    l_P_ERROR_CODE := SQLCODE ;
    l_P_ERR_MSG :='Error billing to invoice'|| '-' || SQLERRM;
    DBMS_OUTPUT.PUT_LINE('exception no data found   ');
end;
--P_ERR_MSG:='Y';
end if;
END XXPM_CREATE_AUTO_BILLING;   
   
end XXPM_CANCELLATION_PKG;
/
