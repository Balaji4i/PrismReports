create or replace PROCEDURE XXPM_AREA_CHANGE(
                                             p_old_area in number,
                                             p_new_area in number,
                                             p_bookinghdr in number,
                                             p_unit_id  in number,
                                             p_tolerance in number,
                                             p_login_user in varchar2,
                                             p_old_booking in number,
                                             p_type out varchar2,
                                             p_new_booking out number,
                                             p_amount_differ out number
                                             )
AS

l_tolerance_per number;
l_agreedVariation number;
l_areaVariation number;
l_count number;
p_PROPERTY_ID number;
p_BUILD_ID number;
l_flag varchar2(2);
l_range_diff number;
l_type varchar2(30):='NONE';
l_baseprice number;
l_amountdiffern number;
l_newbookingAmt number;
BEGIN
select 
PROPERTY_ID, BUILD_ID 
into
p_PROPERTY_ID, p_BUILD_ID 
from xxpm_property_area
where AREA='CHARGE'
and UNIT_ID=p_unit_id;

SELECT BOOKING_RATE 
INTO l_baseprice
FROM xxpm_booking_detail WHERE BOOKING_HDR_ID=p_bookinghdr AND UNIT_ID=p_unit_id;

--Area Variation different
l_areaVariation:=p_new_area-p_old_area;
--checking tolerance
l_agreedVariation:=((p_tolerance)*(p_old_area/100));
DBMS_OUTPUT.PUT_LINE('l_agreedVariation==>:'||l_agreedVariation);
DBMS_OUTPUT.PUT_LINE('l_areaVariation==>:'||l_areaVariation);

begin
if l_areaVariation between -l_agreedVariation and +l_agreedVariation then
DBMS_OUTPUT.PUT_LINE('==IN Ranger==>');
l_flag:=xxpm_update_unit_area(p_PROPERTY_ID, p_BUILD_ID, p_UNIT_ID,p_new_area,l_areaVariation);
else
DBMS_OUTPUT.PUT_LINE('==OUT Ranger==>');
l_range_diff:=l_areaVariation-l_agreedVariation;
DBMS_OUTPUT.PUT_LINE('l_range_diff'||l_range_diff);
l_flag:=xxpm_update_unit_area(p_PROPERTY_ID, p_BUILD_ID, p_UNIT_ID,p_new_area,l_areaVariation);
    DBMS_OUTPUT.PUT_LINE('p_old_area'||p_old_area);
    DBMS_OUTPUT.PUT_LINE('p_new_area'||p_new_area);
    if p_old_area<p_new_area then
    DBMS_OUTPUT.PUT_LINE('invoice');
    l_type:='INVOICE';
    l_amountdiffern:=l_baseprice*l_range_diff;
    else
    DBMS_OUTPUT.PUT_LINE('debit memo');
    l_type:='DEBIT';
    l_amountdiffern:=l_baseprice*l_range_diff;
    end if;
end if;
DBMS_OUTPUT.PUT_LINE('l_flag==>:'||l_flag);
--l_newbookingAmt:=l_amountdiffern+p_old_booking;
p_new_booking:=round((l_amountdiffern+p_old_booking),2);
p_type:=l_type;
p_amount_differ:=round(l_amountdiffern,2);
end;
END ;