create or replace PROCEDURE "CANCELLATION_NOTIFICATION" (
                        P_VALUE          IN           VARCHAR2,
                        P_SUBMIT_BY_CC     IN          VARCHAR2,
                        TRANSACTION_NUMBER OUT         VARCHAR2,
                        TO_ADDRESS          OUT         VARCHAR2,
                        CC_ADDRESS          OUT         VARCHAR2,
                        BCC_ADDRESS          OUT         VARCHAR2,
                        MESSAGE_BODY         OUT        VARCHAR2,
                        SUBJECT              OUT        VARCHAR2,
                        ATTRIBUTE1          OUT        VARCHAR2,
                        ATTRIBUTE2          OUT        VARCHAR2,
                        ATTRIBUTE3          OUT        VARCHAR2,
                        ATTRIBUTE4          OUT        VARCHAR2,
                        ATTRIBUTE5          OUT        VARCHAR2
) AS
l_CANCEL_TYPE   VARCHAR2(30);
l_CANCEL_NUMBER VARCHAR2(60);
l_CREATED_BY    VARCHAR2(240);
l_status        VARCHAR2(60);    
l_status_display VARCHAR2(60);
l_msg VARCHAR2(2400):=NULL;
l_unit_number VARCHAR2(60):=null;
l_org_number VARCHAR2(60):=null;
l_cancel_date date:=null;
l_BOOKING_ID number;
l_PROPERTY_ID number; 
l_BUILDING_ID number; 
l_UNIT_ID number;
l_ORG_ID number;
l_ORG_NAME    VARCHAR2(60):=null;
l_ORG_NAME_TL  VARCHAR2(60):=null;
l_DESCRIPTION  VARCHAR2(240):=null;

BEGIN
--Transaction table
begin
SELECT 
CANCEL_TYPE, CANCEL_NUMBER, CREATED_BY, STATUS, BOOKING_ID, ORG_ID, CANCEL_DATE, DESCRIPTION
INTO
l_CANCEL_TYPE,l_CANCEL_NUMBER,l_CREATED_BY, l_status, l_BOOKING_ID, l_ORG_ID, l_cancel_date, l_DESCRIPTION
FROM xxpm_cancellation WHERE cancel_id=P_VALUE;
EXCEPTION
      WHEN no_data_found THEN
      l_CANCEL_NUMBER:=NULL;
end;
--GET Status
begin
if(l_CANCEL_NUMBER is not null) then
SELECT LOOKUP_VALUE_NAME_DISP into l_status_display 
FROM xxfnd_lookup_v where rownum=1 and LOOKUP_VALUE_NAME=l_status;
end if;
--get unit id
SELECT 
PROPERTY_ID, BUILDING_ID, UNIT_ID 
into
l_PROPERTY_ID ,l_BUILDING_ID, l_UNIT_ID
FROM xxpm_booking_detail where booking_hdr_id=l_BOOKING_ID;
-- get unit id
SELECT UNIT_NUMBER 
into l_unit_number
FROM xxpm_property_units 
where UNIT_ID=l_UNIT_ID;
--get org
SELECT 
ORG_NAME, ORG_NAME_TL 
into 
l_ORG_NAME,l_ORG_NAME_TL 
FROM xxstg_organizations 
where ORG_ID=l_ORG_ID;
end;
--body Message
if(l_CANCEL_TYPE='CN') then

l_msg:= 'New Cancellation has been creatd in PRISM. Transaction number ('|| l_CANCEL_NUMBER ||').';
ATTRIBUTE1:=l_ORG_NAME_TL;
ATTRIBUTE2:=l_unit_number;
ATTRIBUTE3:=l_cancel_date;
ATTRIBUTE4:=l_CREATED_BY;
ATTRIBUTE5:=l_status_display;

ELSIF (l_CANCEL_TYPE='UN') then
l_msg:= 'Unit Transfer: Transaction number ('|| l_CANCEL_NUMBER ||') Status has been Changed. Status: '||l_status_display;
ATTRIBUTE1:=l_ORG_NAME_TL;
ATTRIBUTE2:=l_unit_number;
ATTRIBUTE3:=l_cancel_date;
ATTRIBUTE4:=l_CREATED_BY;
ATTRIBUTE5:=l_status_display;
else
l_msg:='NULL: No data found in Data base';
end if;

SUBJECT:='FYI-Transactoin Number '|| l_CANCEL_NUMBER||'-'||sysdate;

--Sending Process
if(l_CANCEL_NUMBER is not null) then 
TRANSACTION_NUMBER:=l_CANCEL_NUMBER;
TO_ADDRESS:='cancellation.prism@omniyat.com';
--'ibrahim.hb@4iapps.com';
--l_CREATED_BY;
CC_ADDRESS:=P_SUBMIT_BY_CC;
BCC_ADDRESS:='NULL';
MESSAGE_BODY:=l_msg;
else 
TRANSACTION_NUMBER:='NULL';
TO_ADDRESS:='NULL';
CC_ADDRESS:='NULL';
BCC_ADDRESS:='NULL';
MESSAGE_BODY:='NULL';
end if;

END;