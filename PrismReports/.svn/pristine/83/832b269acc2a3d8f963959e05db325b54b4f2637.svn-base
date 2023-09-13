--------------------------------------------------------
--  DDL for Function GET_SOURCE_NUMBER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_SOURCE_NUMBER" (p_SOURCE_FUNC_ID in number , p_SOURCE_FUNC_REF_ID in number)
return varchar2 
is
l_FUNC_SHORT_CODE varchar2(20);
l_source_number varchar2(200);

begin

select FUNC_SHORT_CODE into l_FUNC_SHORT_CODE from xxfnd_functions where FUNC_ID =p_SOURCE_FUNC_ID;

if upper(l_FUNC_SHORT_CODE) = upper('SB') then

select booking_number into l_source_number from xxpm_booking_header where booking_hdr_id = p_SOURCE_FUNC_REF_ID;

elsif upper(l_FUNC_SHORT_CODE) = upper('CN') or  upper(l_FUNC_SHORT_CODE) = upper('TN') or upper(l_FUNC_SHORT_CODE) = upper('SP') or upper(l_FUNC_SHORT_CODE) = upper('RS')    then

select cancel_number into l_source_number from xxpm_cancellation where cancel_id = p_SOURCE_FUNC_REF_ID;

elsif upper(l_FUNC_SHORT_CODE) = upper('RG') then

select regn_number into l_source_number from xxpm_registration where regn_id = p_SOURCE_FUNC_REF_ID;

elsif upper(l_FUNC_SHORT_CODE) = upper('PC') then

select ms_rev_number into l_source_number from xxpm_book_ms_rev_hdr where ms_rev_id = p_SOURCE_FUNC_REF_ID;

elsif upper(l_FUNC_SHORT_CODE) = upper('AC') then

select AREA_CNG_NUMBER  into l_source_number  from xxpm_area_change_hdr where AREA_CNG_HDR_ID = p_SOURCE_FUNC_REF_ID;

end if;

return l_source_number;

exception when others
then
return null;
end;
