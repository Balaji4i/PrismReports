--------------------------------------------------------
--  DDL for Function GET_REFUND_AMOUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_REFUND_AMOUNT" (p_receipt_amt in number ,p_booking_tot_amt in number)
return number
as

l_percent number;
l_refund_amt number;
begin

l_percent := (p_receipt_amt/p_booking_tot_amt)*100;
if l_percent <=40 then
   l_refund_amt :=0;
   else
   l_refund_amt:=((l_percent-40)*p_booking_tot_amt)/100;
end if;

return l_refund_amt;
end get_refund_amount;
