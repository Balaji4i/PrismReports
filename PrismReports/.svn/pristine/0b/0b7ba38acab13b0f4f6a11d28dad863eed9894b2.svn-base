--------------------------------------------------------
--  File created - Thursday-April-15-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure XXPM_PAYMENT_DUE_DATE_UPDATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_PAYMENT_DUE_DATE_UPDATE" (
    p_booking_hdr_id   IN    NUMBER,
    p_booking_ms_id    IN    NUMBER,
    p_new_date             IN    VARCHAR2,
    p_login_user       IN    VARCHAR2,
    p_status       OUT   VARCHAR2
) AS
l_old_Date date;
l_value number;
l_due_date_id number:=DUE_DATE_ID_S.nextval;
BEGIN
--------------
begin
SELECT 
to_date(DUE_DATE, 'DD-MON-YYYY')
into l_old_Date
FROM xxpm_booking_milestones 
where 
BOOKING_MS_DTL_ID=p_booking_ms_id
and BOOKING_HDR_ID =p_booking_hdr_id;
exception 
when OTHERS then
l_old_Date:=null;
end;
--------------
--Insert
INSERT INTO xxpm_payment_plan_due_date (
    due_date_id,
    due_date,
    booking_ms_dtl_id,
    booking_hdr_id,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login
) VALUES (
    l_due_date_id,
    TO_DATE(l_old_Date, 'DD-MON-RRRR'),
    p_booking_ms_id,
    p_booking_hdr_id,
    p_login_user,
    sysdate,
    p_login_user,
    sysdate,
    p_login_user
);
commit;
--UPDATE MS
update xxpm_booking_milestones 
set DUE_DATE=to_date(p_new_date, 'DD-MON-YYYY'),
last_updated_by=p_login_user,
last_update_date=SYSDATE
where 
BOOKING_MS_DTL_ID=p_booking_ms_id
and BOOKING_HDR_ID =p_booking_hdr_id;
commit;
--
begin
SELECT 
NVL(count(*),0) 
into l_value
FROM xxpm_payment_plan_due_date
where DUE_DATE_ID=l_due_date_id;
exception when others then
l_value:=0;
end;
--
if(l_value=0) then 
p_status:='N';
else
p_status:='Y';
end if;


END;

/
