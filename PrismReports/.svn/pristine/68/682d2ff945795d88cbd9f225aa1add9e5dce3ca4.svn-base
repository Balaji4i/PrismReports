--------------------------------------------------------
--  DDL for Function GET_FORFEIT_AMOUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_FORFEIT_AMOUNT" (p_receipt_amt in number ,p_booking_tot_amt in number)
return number
as

l_percent number;
l_forfeit_amt number;
begin

l_percent := (p_receipt_amt/p_booking_tot_amt)*100;
if l_percent <=40 then
   l_forfeit_amt :=p_receipt_amt;
   else
   l_forfeit_amt:=(40*p_booking_tot_amt)/100;
end if;

return l_forfeit_amt;
end get_forfeit_amount;
