--------------------------------------------------------
--  DDL for Package XXPM_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_BOOKING" is

function getmileStone_amt(p_booking_id in number,p_type in varchar2)
return number;

function getBookingTotal(p_booking_id in number)
return number;

function getBookingNumber(p_invoice_id in number)
return varchar2;

function getBuildingName(p_invoice_id in number)
return varchar2;

function getUnitNumber(p_invoice_id in number)
return varchar2;

function getUsage(p_invoice_id in number)
return varchar2;

end xxpm_booking;


--------------------------------------------------------
--  DDL for Package Body XXPM_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_BOOKING" is

function getmileStone_amt(p_booking_id in number,p_type in varchar2)
return number is
l_value number;
begin 
select sum(INSTALLMENT_AMOUNT) as amount into l_value
from XXPM_BOOKING_MILESTONES 
where BOOKING_HDR_ID = p_booking_id
and MILESTONE_TYPE = p_type
group by MILESTONE_TYPE  ;
return l_value;
end getmileStone_amt;
--
function getBookingTotal(p_booking_id in number)
return number is

l_total number;

begin 
select ((nvl(BOOKING_AMOUNT,0)-nvl(DISC_AMOUNT,0))+nvl(TAX_AMOUNT,0))as bookingAmt into l_total from XXPM_BOOKING_DETAIL where BOOKING_HDR_ID= p_booking_id and rownum=1;
return l_total;
end getBookingTotal;
---

function getBookingNumber(p_invoice_id in number)
return varchar2 is
l_value varchar2  (30);
begin 

SELECT
    booking_number into l_value
FROM
    xxpm_booking_header
WHERE
    booking_hdr_id = (
        SELECT
            booking_id
        FROM
            xxpm_invoice_header
        WHERE
            rownum=1
            AND invoice_id = p_invoice_id
    );
return l_value;
end getBookingNumber;


function getBuildingName(p_invoice_id in number)
return varchar2 is
l_value varchar2 (30);
l_bookingid Number;
l_buildingid number;

begin 
-- getting booking id
begin
l_bookingid :=null;
SELECT BOOKING_ID into l_bookingid
FROM xxpm_invoice_header 
where rownum=1
and INVOICE_ID=p_invoice_id;
exception
when others then
l_bookingid:=null;
end;
-- getting building id
begin
l_buildingid :=null;
SELECT BUILDING_ID into l_buildingid 
FROM xxpm_booking_detail 
where rownum=1
and BOOKING_HDR_ID=l_bookingid;
exception
when others then
l_bookingid:=null;
end;
--get building number
begin
l_value :=null;
SELECT BUILD_NUMBER into l_value
FROM xxpm_property_buildings
where rownum=1
and  BUILD_ID=l_buildingid;
exception
when others then
l_value:=null;
end;

return l_value;
end getBuildingName;

function getUnitNumber(p_invoice_id in number)
return varchar2 is
l_value varchar2 (30);
l_bookingid Number;
l_unitId number;

begin 
-- getting booking id
begin
l_bookingid :=null;
SELECT BOOKING_ID into l_bookingid
FROM xxpm_invoice_header 
where rownum=1
and INVOICE_ID=p_invoice_id;
exception
when others then
l_bookingid:=null;
end;
-- getting building id
begin
l_unitId :=null;
SELECT UNIT_ID into l_unitId 
FROM xxpm_booking_detail 
where rownum=1
and BOOKING_HDR_ID=l_bookingid;
exception
when others then
l_bookingid:=null;
end;
--get building number
begin
l_value :=null;
SELECT UNIT_NUMBER into l_value
FROM xxpm_property_units
where rownum=1
and  UNIT_ID=l_unitId;
exception
when others then
l_value:=null;
end;
return l_value;
end getUnitNumber;


function getUsage(p_invoice_id in number)
return varchar2 is
l_value varchar2  (30);
begin 

SELECT
    usage into l_value
FROM
    xxpm_booking_header
WHERE
    booking_hdr_id = (
        SELECT
            booking_id
        FROM
            xxpm_invoice_header
        WHERE
            rownum=1
            AND invoice_id = p_invoice_id
    );
return l_value;
end getUsage;

end xxpm_booking;
