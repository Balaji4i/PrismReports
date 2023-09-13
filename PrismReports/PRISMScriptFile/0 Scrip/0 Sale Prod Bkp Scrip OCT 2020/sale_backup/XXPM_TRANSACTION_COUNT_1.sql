--------------------------------------------------------
--  DDL for Package Body XXPM_TRANSACTION_COUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_TRANSACTION_COUNT" 
AS
PROCEDURE getTransactionCount(p_count IN NUMBER,
                              p_Date        out Date,
                              p_propertyCount out NUMBER,
                              p_buildingCount out NUMBER,
                              p_unitCount out NUMBER,
                            p_milestoneCount out NUMBER,
                            p_pricelistCount out NUMBER,
                            p_offerCount out NUMBER,
                            p_bookingCount out NUMBER,
                            p_blockingCount out NUMBER,
                            p_unblockingCount out NUMBER,
                            p_billingCount out NUMBER,
                            p_invoiceCount out NUMBER,
                            p_receiptCount out NUMBER,
                            p_receiptDtlCount out NUMBER,
                            p_registrationCount out NUMBER,
                            p_moveinCount out NUMBER,
                            p_cancellationCount out NUMBER,
                            p_terminationCount out NUMBER,
                            p_areachangeCount out NUMBER,
                            p_paymentplanChangeCount out NUMBER,
                            p_UnitTransferCount out NUMBER
    )
IS
--declare 
      l_UnitTransferCount number;
      l_propertyCount NUMBER;
	  l_buildingCount	number;
	  l_unitCount NUMBER;
      l_milestoneCount NUMBER;
      l_pricelistCount NUMBER;
      l_offerCount NUMBER;
      l_bookingCount NUMBER;
      l_blockingCount NUMBER;
      l_unblockingCount NUMBER;
      l_billingCount NUMBER;
      l_invoiceCount NUMBER;
      l_receiptCount NUMBER;
      l_receiptDtlCount NUMBER;
      l_registrationCount NUMBER;
      l_moveinCount NUMBER;
      l_cancellationCount NUMBER;
      l_terminationCount NUMBER;
      l_areachangeCount NUMBER;
      l_paymentplanChangeCount NUMBER;

BEGIN
p_Date:=sysdate- p_count;
--property
begin
SELECT
    COUNT(*) into l_propertyCount
FROM
    xxpm_property_master
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_propertyCount:=l_propertyCount; 
    --dbms_output.put_line('p_propertyCount-> 1 '|| l_propertyCount);
EXCEPTION
  WHEN OTHERS THEN
  l_propertyCount :=0;
    p_propertyCount:=l_propertyCount; 
    --dbms_output.put_line('p_propertyCount-> 0 '||l_propertyCount);
end;
--Building
begin
SELECT
    COUNT(*) into l_buildingCount
FROM
    xxpm_property_buildings
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_buildingCount:=l_buildingCount; 
    --dbms_output.put_line('p_buildingCount-> 1 '|| l_buildingCount);
EXCEPTION
  WHEN OTHERS THEN
  l_buildingCount :=0;
    p_buildingCount:=l_buildingCount; 
    --dbms_output.put_line('p_buildingCount-> 0 '||l_buildingCount);
end;
--Unit
begin
SELECT
    COUNT(*) into l_unitCount
FROM
    xxpm_property_units
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_unitCount:=l_unitCount; 
    --dbms_output.put_line('p_unitCount-> 1 '|| l_unitCount);
EXCEPTION
  WHEN OTHERS THEN
  l_unitCount :=0;
    p_unitCount:=l_unitCount; 
    --dbms_output.put_line('p_unitCount-> 0 '||l_unitCount);
end;
--Milestone
begin
SELECT
    COUNT(*) into l_milestoneCount
FROM
    xxpm_milestone_hdr
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_milestoneCount:=l_milestoneCount; 
    --dbms_output.put_line('p_milestoneCount-> 1 '|| l_milestoneCount);
EXCEPTION
  WHEN OTHERS THEN
  l_milestoneCount :=0;
  p_milestoneCount:=l_milestoneCount; 
  --dbms_output.put_line('p_milestoneCount-> 0 '||l_milestoneCount);
end;
--price list
begin
SELECT
    COUNT(*) into l_pricelistCount
FROM
    xxpm_pl_header
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_pricelistCount:=l_pricelistCount; 
    --dbms_output.put_line('p_pricelistCount-> 1 '|| l_pricelistCount);
EXCEPTION
  WHEN OTHERS THEN
  l_pricelistCount :=0;
  p_pricelistCount:=l_pricelistCount; 
  --dbms_output.put_line('p_pricelistCount-> 0 '||l_pricelistCount);
end;
--Offer
begin
SELECT
    COUNT(*) into l_offerCount
FROM
    xxpm_offer_header
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_offerCount:=l_offerCount; 
    --dbms_output.put_line('p_offerCount-> 1 '|| l_offerCount);
EXCEPTION
  WHEN OTHERS THEN
  l_offerCount :=0;
    p_offerCount:=l_offerCount; 
    --dbms_output.put_line('p_offerCount-> 0 '||l_offerCount);
end;
--Booking
begin
SELECT
    COUNT(*) into l_bookingCount
FROM
    xxpm_booking_header
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_bookingCount:=l_bookingCount; 
    --dbms_output.put_line('p_bookingCount-> 1 '|| l_bookingCount);
EXCEPTION
  WHEN OTHERS THEN
  l_bookingCount :=0;
    p_bookingCount:=l_bookingCount; 
    --dbms_output.put_line('p_bookingCount-> 0 '||l_bookingCount);
end;
--Blocking
begin
SELECT
    COUNT(*) into l_blockingCount
FROM
    XXPM_BLOCK_HEADER
WHERE
    trunc(CREATED_DATE) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_blockingCount:=l_blockingCount; 
    --dbms_output.put_line('p_blockingCount-> 1 '|| l_blockingCount);
EXCEPTION
  WHEN OTHERS THEN
  l_blockingCount :=0;
    p_blockingCount:=l_blockingCount; 
    --dbms_output.put_line('p_blockingCount-> 0 '||l_blockingCount);
end;
--Unblocking
begin
SELECT
    COUNT(*) into l_unblockingCount
FROM
    XXPM_UNBLOCK_HEADER
WHERE
    trunc(CREATED_DATE) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_unblockingCount:=l_unblockingCount; 
    --dbms_output.put_line('p_unblockingCount-> 1 '|| l_unblockingCount);
EXCEPTION
  WHEN OTHERS THEN
  l_unblockingCount :=0;
    p_unblockingCount:=l_unblockingCount; 
    --dbms_output.put_line('p_unblockingCount-> 0 '||l_unblockingCount);
end;
--Billing
begin
SELECT
    COUNT(*) into l_billingCount
FROM
    xxpm_billing
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_billingCount:=l_billingCount; 
    --dbms_output.put_line('p_billingCount-> 1 '|| l_billingCount);
EXCEPTION
  WHEN OTHERS THEN
  l_billingCount :=0;
    p_billingCount:=l_billingCount; 
    --dbms_output.put_line('p_billingCount-> 0 '||l_billingCount);
end;
--Invoice
begin
SELECT
    COUNT(*) into l_invoiceCount
FROM
    xxpm_invoice_header
WHERE
    trunc(CREATED_DATE) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_invoiceCount:=l_invoiceCount; 
    --dbms_output.put_line('p_invoiceCount-> 1 '|| l_invoiceCount);
EXCEPTION
  WHEN OTHERS THEN
  l_invoiceCount :=0;
    p_invoiceCount:=l_invoiceCount; 
    --dbms_output.put_line('p_invoiceCount-> 0 '||l_invoiceCount);
end;
--Receipt
begin
SELECT
    COUNT(*) into l_receiptCount
FROM
    xxpm_receipt
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_receiptCount:=l_receiptCount; 
    --dbms_output.put_line('p_receiptCount-> 1 '|| l_receiptCount);
EXCEPTION
  WHEN OTHERS THEN
  l_receiptCount :=0;
    p_receiptCount:=l_receiptCount; 
    --dbms_output.put_line('p_receiptCount-> 0 '||l_receiptCount);
end;
--Receipt Dtl
begin
SELECT
    COUNT(*) into l_receiptDtlCount
FROM
    xxpm_receipt_details
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_receiptDtlCount:=l_receiptDtlCount; 
    --dbms_output.put_line('p_receiptDtlCount-> 1 '|| l_receiptDtlCount);
EXCEPTION
  WHEN OTHERS THEN
  l_receiptDtlCount :=0;
    p_receiptDtlCount:=l_receiptDtlCount; 
    --dbms_output.put_line('p_receiptDtlCount-> 0 '||l_receiptDtlCount);
end;
--Registration
begin
SELECT
    COUNT(*) into l_registrationCount
FROM
    XXPM_REGISTRATION
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_registrationCount:=l_registrationCount; 
    --dbms_output.put_line('p_registrationCount-> 1 '|| l_registrationCount);
EXCEPTION
  WHEN OTHERS THEN
  l_registrationCount :=0;
    p_registrationCount:=l_registrationCount; 
    --dbms_output.put_line('p_registrationCount-> 0 '||l_registrationCount);
end;
--Move In 
begin
SELECT
    COUNT(*) into l_moveinCount
FROM
    XXPM_MOVE_IN_OUT
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_moveinCount:=l_moveinCount; 
    --dbms_output.put_line('p_moveinCount-> 1 '|| l_moveinCount);
EXCEPTION
  WHEN OTHERS THEN
  l_moveinCount :=0;
    p_moveinCount:=l_moveinCount; 
    --dbms_output.put_line('p_moveinCount-> 0 '||l_moveinCount);
end;
--Cancellation
begin
SELECT
    COUNT(*) into l_cancellationCount
FROM
    XXPM_CANCELLATION
WHERE
    CANCEL_TYPE ='CN'
    and trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_cancellationCount:=l_cancellationCount; 
    --dbms_output.put_line('p_cancellationCount-> 1 '|| l_cancellationCount);
EXCEPTION
  WHEN OTHERS THEN
  l_cancellationCount :=0;
    p_cancellationCount:=l_cancellationCount; 
    --dbms_output.put_line('p_cancellationCount-> 0 '||l_cancellationCount);
end;
--Termination
begin
SELECT
    COUNT(*) into l_terminationCount
FROM
    XXPM_EXTEN_CANCEL
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_terminationCount:=l_terminationCount; 
    --dbms_output.put_line('p_terminationCount-> 1 '|| l_terminationCount);
EXCEPTION
  WHEN OTHERS THEN
  l_terminationCount :=0;
    p_terminationCount:=l_terminationCount; 
    --dbms_output.put_line('p_terminationCount-> 0 '||l_terminationCount);
end;
--area Change
begin
SELECT
    COUNT(*) into l_areachangeCount
FROM
    XXPM_AREA_CHANGE_HDR
WHERE
    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_areachangeCount:=l_areachangeCount; 
    --dbms_output.put_line('p_areachangeCount-> 1 '|| l_areachangeCount);
EXCEPTION
  WHEN OTHERS THEN
  l_areachangeCount :=0;
    p_areachangeCount:=l_areachangeCount; 
    --dbms_output.put_line('p_areachangeCount-> 0 '||l_areachangeCount);
end;
--Payment Plan change
begin
SELECT
    COUNT(*) into l_paymentplanChangeCount
FROM
    XXPM_BOOK_MS_REV_HDR
WHERE
--    trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    trunc(MS_REV_DATE) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_paymentplanChangeCount:=l_paymentplanChangeCount; 
    --dbms_output.put_line('p_paymentplanChangeCount-> 1 '|| l_paymentplanChangeCount);
EXCEPTION
  WHEN OTHERS THEN
  l_paymentplanChangeCount :=0;
    p_paymentplanChangeCount:=l_paymentplanChangeCount; 
    --dbms_output.put_line('p_paymentplanChangeCount-> 0 '||l_paymentplanChangeCount);
end;

--UnitTransfer
begin
SELECT
    COUNT(*) into l_UnitTransferCount
FROM
    XXPM_CANCELLATION
WHERE
    CANCEL_TYPE ='UT'
    and trunc(creation_date) = TO_DATE(SYSDATE - p_count, 'DD-MM-YY');
    p_UnitTransferCount:=l_UnitTransferCount; 
    --dbms_output.put_line('p_cancellationCount-> 1 '|| l_cancellationCount);
EXCEPTION
  WHEN OTHERS THEN
  l_UnitTransferCount :=0;
    p_UnitTransferCount:=l_UnitTransferCount; 
    --dbms_output.put_line('p_cancellationCount-> 0 '||l_cancellationCount);
end;

END getTransactionCount;    
END XXPM_TRANSACTION_COUNT;
