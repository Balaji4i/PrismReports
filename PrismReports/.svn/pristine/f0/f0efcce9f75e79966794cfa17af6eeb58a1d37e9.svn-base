--------------------------------------------------------
--  DDL for Procedure XXPM_CREATE_INVOICE_TXN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_CREATE_INVOICE_TXN" (p_charge_type in varchar2 ,p_token in varchar2 ,p_book_ref_id  in number , p_trans_ref_id in number)

is
cursor CUR_INVOICE_HEADER
is
select 
  xbh.usage,
      txn_source trx_source,
      txn_type trx_type,
      xbc.cust_id cust_id,
      bill_to_site_id cust_site_id,
      xmd.payment_term,
      NVL(xbm.due_date,sysdate) due_date,
      xoh.offer_hdr_id offer_id,
      xoh.offer_number,
      xbh.booking_hdr_id booking_id,
      xbh.booking_number,
      xbh.usage usage,
      xbm.uom,
      xbm.quantity,
      xbm.rate price,
      xbm.installment_amount amount,
      xbm.charge_type,
      xbh.property_id,
      xbm.installment_type,
      xbm.BOOKING_MS_DTL_ID,
      XBM.MILESTONE_TYPE
    FROM 
      xxpm_booking_milestones xbm,
      xxpm_booking_header xbh,
      xxpm_booking_customer xbc,
      xxpm_ar_setup xar,
      xxpm_milestone_dtl xmd,
      xxpm_offer_header xoh
    WHERE
     xbm.booking_hdr_id = xbh.booking_hdr_id
    AND xbh.booking_hdr_id = xbc.booking_hdr_id
    AND xbm.charge_type    = xar.charge_type(+)
    AND xbm.ms_dtl_id      = xmd.ms_dtl_id(+)
    and XBH.OFFER_HDR_ID   = XOH.OFFER_HDR_ID
    AND xbc.primary_yn     = 'Y';
    
    begin
    
    DBMS_OUTPUT.PUT_LINE(  '   ' );
    
    
    end xxpm_create_invoice_txn;
