CREATE OR REPLACE package xxpm_Auto_Billing_pkg
is

procedure createBilling(P_TRANS_ID 		IN NUMBER,
						P_FUN_ID			IN NUMBER,
                        P_LOGIN_USER        IN VARCHAR2,
						P_ERROR_CODE 	OUT VARCHAR2,
						P_ERR_MSG		OUT VARCHAR2
						);


procedure create_milestone_credit_memo(
                        P_TRANS_ID 		IN NUMBER,
						P_LOGIN_USER    IN VARCHAR2,
						P_ERROR_CODE 	OUT VARCHAR2,
						P_ERR_MSG		OUT VARCHAR2
						);

end xxpm_Auto_Billing_pkg;
/


CREATE OR REPLACE PACKAGE BODY           xxpm_auto_billing_pkg
IS
   PROCEDURE createbilling (p_trans_id     IN     NUMBER,
                            p_fun_id       IN     NUMBER,
                            p_login_user   IN     VARCHAR2,
                            p_error_code      OUT VARCHAR2,
                            p_err_msg         OUT VARCHAR2)
   AS
      l_bill_fun_id            NUMBER;
      l_bill_id                NUMBER;
      l_bill_number            VARCHAR2 (60);
      l_funcode                VARCHAR2 (30);
      l_booking_id             NUMBER;
      l_org_id                 NUMBER;
      l_proj_id                NUMBER;
      l_cancel_type            VARCHAR2 (30);
      l_charge_type            VARCHAR2 (30);
      v_p_func_id              NUMBER;
      l_description            VARCHAR2 (60);
      v_p_err_code             VARCHAR2 (30);
      v_p_err_msg              VARCHAR2 (30);
      l_error_code             VARCHAR2 (30) := '500';
      l_err_msg                VARCHAR2 (30) := 'failed';
      l_exit_cust_id           NUMBER;
      l_exit_cust_ship_to      NUMBER;
      l_exit_book_cust_id      NUMBER;
      l_to_customer            NUMBER;
      l_to_customer_bill_to    NUMBER;
      l_to_customer_contacts   NUMBER;

      CURSOR booking_milestone_info (l_bill_id NUMBER)
      IS
         SELECT booking_ms_dtl_id
           FROM xxpm_booking_milestones
          WHERE billing_id = l_bill_id;
   BEGIN
      -- get function code

      SELECT func_short_code
        INTO l_funcode
        FROM xxfnd_functions
       WHERE func_id = p_fun_id;

      DBMS_OUTPUT.put_line ('function code l_funCode-->' || l_funcode);

      --checking screen type
      IF l_funcode IN ('CN', 'UNTRNS', 'SP', 'RS')
      THEN
         SELECT can.booking_id,
                bh.org_id,
                pro.proj_id,
                can.cancel_type
           INTO l_booking_id,
                l_org_id,
                l_proj_id,
                l_cancel_type
           FROM xxpm_cancellation can,
                xxpm_booking_header bh,
                xxstg_projects pro
          WHERE     can.booking_id = bh.booking_hdr_id
                AND pro.org_id = bh.org_id
                AND can.cancel_id = p_trans_id
                AND can.func_id = p_fun_id;

         --and can.CANCEL_TYPE= l_funCode;

         IF l_funcode = 'CN'
         THEN
            l_description := 'Cancellation Auto Billing';
            l_charge_type := 'CN_CHG';
         ELSIF l_funcode = 'UNTRNS'
         THEN
            l_description := 'Unit Transfer Auto Billing';
            l_charge_type := 'UN_CHG';
         ELSIF l_funcode = 'SP'
         THEN
            l_description := 'Swapping Auto Billing';
            l_charge_type := 'SW_CHG';
         ELSIF l_funcode = 'RS'
         THEN
            l_description := 'Resale Auto Billing';
            l_charge_type := 'RS_CHG';
         END IF;

         DBMS_OUTPUT.put_line ('l_booking_id-->' || l_booking_id);
         DBMS_OUTPUT.put_line ('l_org_id-->' || l_org_id);
         DBMS_OUTPUT.put_line ('l_proj_id-->' || l_proj_id);
         DBMS_OUTPUT.put_line ('l_cancel_type-->' || l_cancel_type);
         DBMS_OUTPUT.put_line ('l_charge_type-->' || l_charge_type);
      END IF;

      --Creating one billing
      BEGIN
         IF (    l_org_id IS NOT NULL
             AND l_proj_id IS NOT NULL
             AND l_cancel_type IS NOT NULL)
         THEN
            l_bill_id := xxpm_billing_s.NEXTVAL;
            l_bill_fun_id := 20;

            INSERT INTO xxpm_billing (billing_id,
                                      billing_number,
                                      billing_date,
                                      usage,
                                      org_id,
                                      status,
                                      description,
                                      func_id,
                                      flow_status,
                                      flow_level,
                                      flow_with,
                                      user_grp_id,
                                      created_by,
                                      creation_date,
                                      last_updated_by,
                                      last_update_date,
                                      last_update_login,
                                      project_id)
                 VALUES (l_bill_id,
                         'BL-' || l_bill_id,
                         SYSDATE,
                         'S',
                         l_org_id,
                         'APR',
                         l_description,
                         l_bill_fun_id,
                         NULL,
                         NULL,
                         NULL,
                         NULL,
                         p_login_user,
                         SYSTIMESTAMP,
                         p_login_user,
                         SYSTIMESTAMP,
                         p_login_user,
                         l_proj_id);

            COMMIT;

            -- updatin new billing id in booking milestone

            IF l_funcode IN ('CN', 'UNTRNS', 'SP', 'RS')
            THEN
               DBMS_OUTPUT.put_line (
                  'Completed-> 0 l_bill_id-->' || l_bill_id);
               DBMS_OUTPUT.put_line ('Completed-> 0 P_FUN_ID-->' || p_fun_id);
               DBMS_OUTPUT.put_line (
                  'Completed-> 0 P_TRANS_ID-->' || p_trans_id);
               DBMS_OUTPUT.put_line (
                  'Completed-> 0 l_booking_id-->' || l_booking_id);
               DBMS_OUTPUT.put_line (
                  'Completed-> 0 l_charge_type-->' || l_charge_type);

               --updating billing id in booking milestone
               UPDATE xxpm_booking_milestones
                  SET billing_id = l_bill_id
                WHERE     cust_type = 'EXIT_CUST'
                      AND source_func_id = p_fun_id
                      AND source_func_ref_id = p_trans_id
                      AND booking_hdr_id = l_booking_id
                      AND charge_type = l_charge_type
                      AND billing_id IS NULL;

               COMMIT;
            END IF;

            DBMS_OUTPUT.put_line ('if End-> 0 ');
         END IF;
      END;

      -- calling billing to invoice
      BEGIN
         --begin
         --xxpm_bill_invoice_pkg.load_invoice (l_bill_id, P_ERROR_CODE,P_ERR_MSG);
         --EXCEPTION
         --WHEN no_data_found THEN
         --    P_ERROR_CODE := SQLCODE ;
         --    P_ERR_MSG :=P_ERR_MSG||'Error billing to invoice'|| '-' || SQLERRM;
         --    DBMS_OUTPUT.PUT_LINE('exception no data found   ');
         --end;

         FOR ms_id IN booking_milestone_info (l_bill_id)
         LOOP
            BEGIN
               DBMS_OUTPUT.put_line (
                     'Billing-->ms_id.booking_ms_dtl_id->'
                  || ms_id.booking_ms_dtl_id);
               xxpm_bill_invoice_pkg.ms_based_invoice (
                  ms_id.booking_ms_dtl_id,
                  p_error_code,
                  p_err_msg);
               DBMS_OUTPUT.put_line (
                  'Billing to invoice--P_ERROR_CODE->' || p_error_code);
               DBMS_OUTPUT.put_line ('PKG--P_ERR_MSG->' || p_err_msg);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  p_error_code := SQLCODE;
                  p_err_msg :=
                        p_err_msg
                     || 'Error billing to invoice'
                     || '-'
                     || SQLERRM;
                  DBMS_OUTPUT.put_line ('exception no data found   ');
            END;
         END LOOP;
      END;

      --get exiting Customer information
      BEGIN
         SELECT booking_cust_id, cust_id, ship_to_site_id
           INTO l_exit_book_cust_id, l_exit_cust_id, l_exit_cust_ship_to
           FROM xxpm_booking_customer
          WHERE     ROWNUM = 1
                AND primary_yn = 'Y'
                AND booking_hdr_id = l_booking_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_error_code := SQLCODE;
            p_err_msg :=
               p_err_msg || 'Customer is not primary' || '-' || SQLERRM;
            DBMS_OUTPUT.put_line ('Customer is not primary   ');
      END;

      DBMS_OUTPUT.put_line (
         'Billing to invoice--l_exit_book_cust_id->' || l_exit_book_cust_id);
      DBMS_OUTPUT.put_line (
         'Billing to invoice--l_exit_cust_id->' || l_exit_cust_id);
      DBMS_OUTPUT.put_line (
         'Billing to invoice--l_exit_cust_ship_to->' || l_exit_cust_ship_to);

      ----removing exiting customer primary
      BEGIN
         UPDATE xxpm_booking_customer
            SET primary_yn = NULL
          WHERE     booking_cust_id = l_exit_book_cust_id
                AND cust_id = l_exit_cust_id
                AND ship_to_site_id = l_exit_cust_ship_to
                AND booking_hdr_id = l_booking_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_error_code := SQLCODE;
            p_err_msg :=
               p_err_msg || 'Error in primary Package   ' || '-' || SQLERRM;
            DBMS_OUTPUT.put_line ('Error in primary Package   ');
      END;

      ---- inserting new customer
      ---- get new customer from unit transfer table
      BEGIN
         SELECT to_customer, to_customer_bill_to, to_customer_contacts
           INTO l_to_customer, l_to_customer_bill_to, l_to_customer_contacts
           FROM XXPM_UNIT_TRANSFER_DETAILS
          WHERE     from_customer = l_exit_cust_id
                AND from_customer_bill_to = l_exit_cust_ship_to
                AND cancel_id = p_trans_id
                AND booking_hdr_id = l_booking_id
                AND unit_transfer_status = 'N';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_error_code := SQLCODE;
            p_err_msg :=
                  p_err_msg
               || 'Error in Getting new customer   '
               || '-'
               || SQLERRM;
            DBMS_OUTPUT.put_line ('Error in Getting new customer   ');
      END;

      DBMS_OUTPUT.put_line (
         'Billing to invoice--l_TO_CUSTOMER->' || l_to_customer);
      DBMS_OUTPUT.put_line (
            'Billing to invoice--l_TO_CUSTOMER_BILL_TO->'
         || l_to_customer_bill_to);
      DBMS_OUTPUT.put_line (
            'Billing to invoice--l_TO_CUSTOMER_CONTACTS->'
         || l_to_customer_contacts);
      DBMS_OUTPUT.put_line ('inserting one record in booking customer');

      --inserting one record in booking customer
      BEGIN
         IF (l_to_customer IS NOT NULL AND l_to_customer_bill_to IS NOT NULL)
         THEN
            DBMS_OUTPUT.put_line (
                  'l_TO_CUSTOMER is not null and l_TO_CUSTOMER_BILL_TO is not null'
               || l_to_customer
               || l_to_customer_bill_to);

            INSERT INTO xxpm_booking_customer (booking_cust_id,
                                               booking_hdr_id,
                                               cust_id,
                                               ship_to_site_id,
                                               bill_to_site_id,
                                               cust_contact_id,
                                               primary_yn,
                                               description,
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
                                               attribute11,
                                               attribute12,
                                               attribute13,
                                               attribute14,
                                               attribute15,
                                               attribute16,
                                               attribute17,
                                               attribute18,
                                               attribute19,
                                               attribute20,
                                               created_by,
                                               creation_date,
                                               last_updated_by,
                                               last_update_date,
                                               last_update_login)
                 VALUES (
                           xxpm_booking_customer_s.NEXTVAL,
                           l_booking_id,
                           l_to_customer,
                           l_to_customer_bill_to,
                           l_to_customer_bill_to,
                           l_to_customer_contacts,
                           'Y',
                              'On '
                           || SYSDATE
                           || '- New Customer added from Unit Transfer process',
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           p_login_user,
                           SYSTIMESTAMP,
                           p_login_user,
                           SYSTIMESTAMP,
                           p_login_user);

            --updating unit transfer details flag and approving unit transfer status
            DBMS_OUTPUT.put_line (
               'updating unit transfer details flag and approving unit transfer status');

            BEGIN
               UPDATE XXPM_UNIT_TRANSFER_DETAILS
                  SET unit_transfer_status = 'Y'
                WHERE     to_customer = l_to_customer
                      AND to_customer_bill_to = l_to_customer_bill_to
                      AND booking_hdr_id = l_booking_id
                      AND cancel_id = p_trans_id
                      AND unit_transfer_status = 'N';

               COMMIT;
            END;

            --UPDATING CANCELATION AS 'APR'
            DBMS_OUTPUT.put_line ('UPDATING CANCELATION AS APR');

            BEGIN
               UPDATE xxpm_cancellation
                  SET status = 'APR'
                WHERE cancel_id = p_trans_id AND booking_id = l_booking_id;

               COMMIT;
            END;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_error_code := SQLCODE;
            p_err_msg :=
               p_err_msg || ' Error in insert line   ' || '-' || SQLERRM;
            DBMS_OUTPUT.put_line ('Error in insert line   ');
      END;

      --commit;
      l_error_code := '200';
      l_err_msg := 'Success';
      p_error_code := l_error_code;
      p_err_msg := l_err_msg;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         p_error_code := SQLCODE || '-' || SQLERRM;
         p_err_msg := 'Error';
         DBMS_OUTPUT.put_line ('exception no data found   ');
   END createbilling;
   
   

procedure create_milestone_credit_memo(
                        P_TRANS_ID 		IN NUMBER,
						P_LOGIN_USER    IN VARCHAR2,
						P_ERROR_CODE 	OUT VARCHAR2,
						P_ERR_MSG		OUT VARCHAR2
						)
                        is 
l_receiptCount number;
l_ERROR_CODE number :=500;
l_ERR_MSG varchar2(160):='Failed';
l_INSTALLMENT_AMOUNT number;
--l_SOURCE_FUNC_ID number; 
l_SOURCE_FUNC_REF_ID  number;
l_ms_count number;
lms_dtlId number;
l_org_id    number;
l_PROJ_ID   number;
l_bill_id number;
l_bill_fun_id number:=20;
l_msrev_count number;
l_old_inv number;
l_old_app_amt number;
l_old_invoice_id number;
-- PROCEDURE START
BEGIN
-- checking ms is already applied or not
begin
SELECT
invoice_id into l_old_inv
FROM
xxpm_booking_milestones
WHERE
CHARGE_TYPE not like 'CMC'
and (INSTALLMENT_PCT is null or INSTALLMENT_PCT !=0)
and (CUST_TYPE is null or CUST_TYPE='NEW_CUST')
--MILESTONE_TYPE='MS'
--and INSTALLMENT_PCT!=0
and BOOKING_MS_DTL_ID = P_TRANS_ID;
dbms_output.put_line('Stage 0 amount applied 00909->');
exception 
when no_data_found then
l_old_inv:=null;

--select NVL(AMOUNT_APPLIED, 0) into l_receiptCount
--from xxpm_milestones_credit_memo_v
--where BOOKING_MS_DTL_ID=P_TRANS_ID;

end;

begin
if(l_old_inv is not null) then
dbms_output.put_line('Stage 0 amount applied ->');
SELECT 
--invoice_id,
count(receipt_id)
--, 
--sum(AMOUNT_APPLIED)
into
--l_old_invoice_id
--,
l_receiptCount
--,
--l_old_app_amt 
FROM
    xxpm_receipt_details
WHERE
    invoice_id =l_old_inv;
--group by invoice_id;
dbms_output.put_line('Stage 0 amount applied 0000->');

end if;
end;


dbms_output.put_line('Stage 1 amount applied ->'||l_receiptCount);
begin
SELECT
    COUNT(*) into l_msrev_count
FROM
    xxpm_book_ms_rev_dtl where booking_ms_dtl_id =P_TRANS_ID;
exception
when no_data_found then
l_msrev_count:=null;
end;
dbms_output.put_line('Stage 2 ms revision count ->'||l_msrev_count);
-- get ms details
begin
SELECT
INSTALLMENT_AMOUNT,
BOOKING_HDR_ID
into
l_INSTALLMENT_AMOUNT,
l_SOURCE_FUNC_REF_ID
FROM
xxpm_booking_milestones
WHERE
1 = 1
AND booking_ms_dtl_id = P_TRANS_ID;
end;

dbms_output.put_line('l_INSTALLMENT_AMOUNT ->'||l_INSTALLMENT_AMOUNT);
dbms_output.put_line('l_SOURCE_FUNC_REF_ID ->'||l_SOURCE_FUNC_REF_ID);

-- get ms count
begin
SELECT
    COUNT(*) into l_ms_count
FROM
    xxpm_booking_milestones
WHERE
    booking_hdr_id = (
        SELECT
            booking_hdr_id
        FROM
            xxpm_booking_milestones
        WHERE
            1 = 1
            AND booking_ms_dtl_id = P_TRANS_ID
    );
end;
dbms_output.put_line('Stage 4 get _ms_count==>'||l_ms_count);

-- get booking hdr info
begin
select 
bh.org_id   , 
pro.PROJ_ID
into 
l_org_id,
l_PROJ_ID
from xxpm_booking_header bh, xxstg_projects pro
where 
pro.ORG_ID=bh.ORG_ID
and bh.BOOKING_HDR_ID=l_SOURCE_FUNC_REF_ID;
--and bh.FUNC_ID=l_SOURCE_FUNC_ID ;
end;
-- Seque no
lms_dtlId:=XXPM_BOOKING_MILESTONES_S.nextval;
dbms_output.put_line('Stage 5 lms_dtlId==>'||lms_dtlId);
if (l_receiptCount=0) then
dbms_output.put_line('Stage 6 acess granded==>');
-- get booking Ms information
begin
dbms_output.put_line('l_ms_dtl_Id-->'|| lms_dtlId);

INSERT INTO xxpm_booking_milestones
(
 BOOKING_MS_DTL_ID               
,MILESTONE_TYPE           
,SEQ_NUMBER             
,INSTALLMENT_AMOUNT                    
,CHARGE_TYPE                   
,PAYMENT_TERM                   
,REMARKS
,DUE_DATE
,SOURCE_FUNC_ID                  
,SOURCE_FUNC_REF_ID              
,BOOKING_HDR_ID 
,CREATED_BY
,CREATION_DATE
,LAST_UPDATED_BY
,LAST_UPDATE_DATE
,LAST_UPDATE_LOGIN              
)
VALUES
(
lms_dtlId,
'MS_CMC',
l_ms_count+1,
l_INSTALLMENT_AMOUNT,
'CMC',
5,
'Credit memo created against milestone.Credit memo amount'||l_INSTALLMENT_AMOUNT,
sysdate,
7,
l_SOURCE_FUNC_REF_ID,
l_SOURCE_FUNC_REF_ID,
P_LOGIN_USER,
sysdate,
P_LOGIN_USER,
sysdate,
P_LOGIN_USER
);
commit;
dbms_output.put_line('Stage 7 booking ms inserted==>');
--billing header creation-Start
begin
if (l_org_id is not null and l_PROJ_ID is not null) then
l_bill_id:=XXPM_BILLING_S.nextval;
l_bill_fun_id:=20;
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
,FLOW_STATUS              
,FLOW_LEVEL               
,FLOW_WITH                
,USER_GRP_ID              
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
null,
null,
null,
null,
P_LOGIN_USER,
systimestamp,
P_LOGIN_USER,
systimestamp,
P_LOGIN_USER,
l_proj_id
);
--updating billing
begin
update xxpm_booking_milestones
set BILLING_ID=l_bill_id
where BOOKING_MS_DTL_ID=lms_dtlId;
end;
commit;
dbms_output.put_line('Stage 8 billing inserted==>');
--billing to invoice
begin
dbms_output.put_line('Billing-->ms_id.booking_ms_dtl_id->'||lms_dtlId);
xxpm_bill_invoice_pkg.ms_based_invoice (lms_dtlId, P_ERROR_CODE,P_ERR_MSG);
dbms_output.put_line('Billing to invoice--P_ERROR_CODE->'||P_ERROR_CODE);
dbms_output.put_line('PKG--P_ERR_MSG->'||P_ERR_MSG);
EXCEPTION
  WHEN no_data_found THEN
    P_ERROR_CODE := SQLCODE ;
    P_ERR_MSG :=P_ERR_MSG||'Error billing to invoice'|| '-' || SQLERRM;
    DBMS_OUTPUT.PUT_LINE('exception no data found   ');
end;
dbms_output.put_line('Stage 9 invoice created==>');
end if;
end;
--billing header creation-end
--check Revised Ms
if(l_msrev_count=0) then
--record in booking milestone revison table
dbms_output.put_line('Stage 10 set amount 0 in ms ==>');
update xxpm_booking_milestones
set 
INSTALLMENT_PCT_R=INSTALLMENT_PCT,
INSTALLMENT_AMOUNT_R=INSTALLMENT_AMOUNT
where
BOOKING_MS_DTL_ID=P_TRANS_ID
--and SOURCE_FUNC_ID=l_SOURCE_FUNC_ID
and SOURCE_FUNC_REF_ID=l_SOURCE_FUNC_REF_ID;
commit;

update xxpm_booking_milestones
set 
INSTALLMENT_PCT=0,
INSTALLMENT_AMOUNT=0
where
BOOKING_MS_DTL_ID=P_TRANS_ID
--and SOURCE_FUNC_ID=l_SOURCE_FUNC_ID 
and SOURCE_FUNC_REF_ID=l_SOURCE_FUNC_REF_ID;
commit;

else 
dbms_output.put_line('Stage 11 set amount 0 in rev ms==>');
--record in booking milestone revison table
-- updating payment plan change table
update xxpm_book_ms_rev_dtl
set 
INSTALLMENT_PCT_RCM=INSTALLMENT_PCT_R, 
INSTALLMENT_AMOUNT_RCM=INSTALLMENT_AMOUNT_R
where 
BOOKING_MS_DTL_ID=P_TRANS_ID
--and SOURCE_FUNC_ID=l_SOURCE_FUNC_ID 
and SOURCE_FUNC_REF_ID=l_SOURCE_FUNC_REF_ID;
commit;
-- again updating table
update xxpm_book_ms_rev_dtl
set 
INSTALLMENT_PCT_R=0, 
INSTALLMENT_AMOUNT_R=0
where 
BOOKING_MS_DTL_ID=P_TRANS_ID
--and SOURCE_FUNC_ID=l_SOURCE_FUNC_ID 
and SOURCE_FUNC_REF_ID=l_SOURCE_FUNC_REF_ID;
--Ms table
update xxpm_booking_milestones
set 
INSTALLMENT_PCT_R=INSTALLMENT_PCT,
INSTALLMENT_AMOUNT_R=INSTALLMENT_AMOUNT
where
BOOKING_MS_DTL_ID=P_TRANS_ID
--and SOURCE_FUNC_ID=l_SOURCE_FUNC_ID
and SOURCE_FUNC_REF_ID=l_SOURCE_FUNC_REF_ID;
commit;
--Ms table
update xxpm_booking_milestones
set 
INSTALLMENT_PCT=0,
INSTALLMENT_AMOUNT=0
where
BOOKING_MS_DTL_ID=P_TRANS_ID
--and SOURCE_FUNC_ID=l_SOURCE_FUNC_ID 
and SOURCE_FUNC_REF_ID=l_SOURCE_FUNC_REF_ID;
commit;
commit;
end if;
l_ERROR_CODE := '200';
l_ERR_MSG    := 'Success'; 
P_ERROR_CODE:=l_ERROR_CODE;
P_ERR_MSG:=l_ERR_MSG;

end;
else  
l_ERROR_CODE:='500';
P_ERROR_CODE:=l_ERROR_CODE;
l_ERR_MSG:='Pleasea check Amount is already applied. Receipted Amount : '|| l_old_app_amt;
P_ERR_MSG:=l_ERR_MSG;
end if;


exception 
when no_data_found then
P_ERROR_CODE := SQLCODE || '-' || SQLERRM;
P_ERR_MSG :='exception no data found';
--DBMS_OUTPUT.PUT_LINE('exception no data found   ');
---- PROCEDURE END;
DBMS_OUTPUT.PUT_LINE('P_ERROR_CODE = ' || P_ERROR_CODE);
DBMS_OUTPUT.PUT_LINE('P_ERR_MSG = ' || P_ERR_MSG);
END create_milestone_credit_memo;




   
END xxpm_auto_billing_pkg;
/
