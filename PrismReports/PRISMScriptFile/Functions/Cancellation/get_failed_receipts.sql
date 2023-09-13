
create or replace FUNCTION get_failed_receipts(
    i_booking_id IN NUMBER)
  RETURN VARCHAR2
IS
  receipt_numbers VARCHAR2(130);
BEGIN
  SELECT LISTAGG(RECEIPT_NUMBER, ',') WITHIN GROUP (
  ORDER BY RECEIPT_NUMBER)
  INTO receipt_numbers
  FROM XXPM_RECEIPT
  WHERE INTERFACE_STATUS IN ('ERROR' , 'Error' , 'Unapplied' , 'Draft')
  AND SOURCE_FUNC_REF_ID  = i_booking_id;
  
  if receipt_numbers is null then
  return 'NO_DATA_FOUND';
  else
  RETURN(receipt_numbers);
  end if;
END get_failed_receipts;