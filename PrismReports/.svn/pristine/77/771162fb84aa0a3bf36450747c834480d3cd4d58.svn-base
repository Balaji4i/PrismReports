create or replace FUNCTION get_pending_invoices(
    i_booking_id IN NUMBER)
  RETURN VARCHAR2
IS
  invoice_numbers VARCHAR2(130);
BEGIN
  SELECT listagg(invoice_number, ',') WITHIN GROUP (
  ORDER BY invoice_number)
  INTO invoice_numbers
  FROM xxpm_invoice_header
  WHERE interface_status NOT IN ('INVOICED','Invoiced','Credited','CANCELLED')
  AND booking_id              = i_booking_id;
  IF invoice_numbers IS NULL THEN
    RETURN 'NO_DATA_FOUND';
  ELSE
    RETURN(invoice_numbers);
  END IF;
END get_pending_invoices;