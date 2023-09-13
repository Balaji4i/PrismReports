--------------------------------------------------------
--  DDL for Procedure INV_CNCL_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INV_CNCL_AMT" (p_invoice_id in number,p_inv_amount out number  ,p_amount_applied out number ,p_bal_amount out number,p_can_amount out number)
as
cursor cur_ins_amt
is
select nvl(xbm.INSTALLMENT_AMOUNT,0) INSTALLMENT_AMOUNT ,nvl(xc.refund_amount,0) refund_amount
from xxpm_invoice_header xih ,xxpm_invoice_lines xil,xxpm_booking_milestones xbm
,xxpm_cancellation xc
where xih.INVOICE_ID =xil.INVOICE_ID 
and xih.INVOICE_ID=xbm.INVOICE_ID
and xbm.SOURCE_FUNC_REF_ID= xc.cancel_id
and xil.CHARGE_TYPE ='CN_CHG' 
and xih.INVOICE_ID  =p_invoice_id;

cursor cur_inv_amt
is
select sum(nvl(xil.amount,0))+ sum(nvl(xil.tax_amount,0)) inv_amount ,xil.INVOICE_ID
from
 XXPM_INVOICE_lines xil
where
 xil.invoice_id =p_invoice_id
group by xil.INVOICE_ID
;

l_can_amount number := null;
l_inv_amount number := null;
l_amount_applied number := null;
l_bal_amount number := null;
l_flag varchar2(2):='N';





begin

for i in cur_ins_amt
loop
l_flag :='C';
if  i.refund_amount is not null and i.INSTALLMENT_AMOUNT is not null   then

if i.INSTALLMENT_AMOUNT < i.refund_amount  then
l_can_amount := 0;
 else

l_can_amount:= i.INSTALLMENT_AMOUNT - i.refund_amount ;

end if;

end if;


end loop;

for j in cur_inv_amt
loop
l_inv_amount :=j.inv_amount;

begin
select sum(nvl(amount_applied,0)) into l_amount_applied from xxpm_receipt_details where invoice_id =j.INVOICE_ID;
exception when others then

l_amount_applied:=0;

end ;

--l_amount_applied :=j.AMOUNT_APPLIED;
l_bal_amount := l_inv_amount - l_amount_applied;
--if l_bal_amount = 0 then
--l_amount_applied := l_inv_amount;
--end if;

DBMS_OUTPUT.PUT_LINE(' l_inv_amount ' ||l_inv_amount || ' l_amount_applied '|| l_amount_applied ||' l_bal_amount  ' || l_bal_amount );
end loop;

if l_flag ='C' and l_can_amount = 0 then
l_amount_applied:= l_inv_amount;
end if;

p_inv_amount := l_inv_amount;
  p_amount_applied:=  l_amount_applied;
  p_bal_amount:=   l_bal_amount;
  p_can_amount :=l_can_amount;
  
  

end;
