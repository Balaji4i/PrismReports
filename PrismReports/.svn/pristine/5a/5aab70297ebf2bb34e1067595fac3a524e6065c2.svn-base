--------------------------------------------------------
--  DDL for Package XXPM_BOOK_MS_REV_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_BOOK_MS_REV_PKG" is

procedure get_milestones(  p_rev_hdr_id in number,p_booking_hdr_id   in     number, 
						   p_func_id          in     number,
						   retcode            out    number,
						   errbuf             out    varchar2 );


procedure update_milestones( p_rev_hdr_id in number, p_booking_hdr_id   in    number,
							  p_func_id          in    number,
							  retcode            out   number,
							  errbuf             out   varchar2 );
							  
function get_customername(p_booking_id in xxpm_booking_customer.booking_hdr_id%type)
return varchar2;

function get_customersite(p_booking_id in xxpm_booking_customer.booking_hdr_id%type)
return number;

function get_customersiteName(p_booking_id in xxpm_booking_customer.booking_hdr_id%type)
return varchar2;

end xxpm_book_ms_rev_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_BOOK_MS_REV_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_BOOK_MS_REV_PKG" 
IS
PROCEDURE get_milestones(
  p_rev_hdr_id in number,
    p_booking_hdr_id IN NUMBER,
    p_func_id        IN NUMBER,
    retcode OUT NUMBER,
    errbuf OUT VARCHAR2 )
AS
  l_ms_rev_dtl_id NUMBER;
  l_ms_rev_id     NUMBER := p_rev_hdr_id;

  CURSOR book_ms
  IS
    SELECT booking_ms_dtl_id,
      milestone_type,
      ms_dtl_id,
      pl_mod_id,
      seq_number,
      installment_type,
      installment_pct,
      installment_amount,
      uom,
      quantity,
      rate,
      wave_off,
      included_in_rate,
      installment_method,
      installment_event,
      period_occurence,
      period_values,
      period_duration,
      charge_type,
      payment_term,
      remarks,
      due_days,
      due_days_from,
      due_date,
      attribute_category,
      attribute1,
      attribute2,
      attribute3,
      attribute4,
      attribute5,
      attribute6,
      attribute7,
      attribute8,
      attribute9,
      attribute10,
      created_by,
      creation_date,
      last_updated_by,
      last_update_date,
      last_update_login,
      source_func_id,
      source_func_ref_id,
      billing_id,
      status,
      invoice_id,
      booking_hdr_id,carparking
    FROM xxpm_booking_milestones
    WHERE booking_hdr_id = p_booking_hdr_id;

BEGIN
  retcode := 0 ;
  errbuf  := 'success' ;

  BEGIN
    FOR i IN book_ms
    LOOP
    DBMS_OUTPUT.PUT_LINE(' COUNT 1            i.booking_ms_dtl_id  '       ||   i.booking_ms_dtl_id );

      INSERT
      INTO xxpm_book_ms_rev_dtl
        (
          ms_rev_dtl_id,
          ms_rev_id,
          source_func_id,
          source_func_ref_id,
          milestone_type,
          ms_dtl_id,
          pl_mod_id,
          seq_number,
          installment_type,
          installment_pct,
          installment_amount,
          uom,
          quantity,
          rate,
          wave_off,
          included_in_rate,
          installment_method,
          installment_event,
          period_occurence,
          period_values,
          period_duration,
          charge_type,
          payment_term,
          remarks,
          due_days,
          due_days_from,
          due_date,
          billing_id,
          status,
          invoice_id,
          installment_pct_r,
          installment_amount_r,
          action_flag,
          attribute_category,
          attribute1,
          attribute2,
          attribute3,
          attribute4,
          attribute5,
          attribute6,
          attribute7,
          attribute8,
          attribute9,
          attribute10,
          created_by,
          creation_date,
          last_updated_by,
          last_update_date,
          last_update_login,
          booking_ms_dtl_id,carparking
        )
        VALUES
        (
          xxpm_booking_hdr_rev_id_s.nextval,
          l_ms_rev_id,
          i.source_func_id,
          i.source_func_ref_id,
          i.milestone_type,
          i.ms_dtl_id,
          i.pl_mod_id,
          i.seq_number,
          i.installment_type,
          i.installment_pct,
          i.installment_amount,
          i.uom,
          i.quantity,
          i.rate,
          i.wave_off,
          i.included_in_rate,
          i.installment_method,
          i.installment_event,
          i.period_occurence,
          i.period_values,
          i.period_duration,
          i.charge_type,
          i.payment_term,
          i.remarks,
          i.due_days,
          i.due_days_from,
          i.due_date,
          i.billing_id,
          i.status,
          i.invoice_id,
          i.installment_pct,
           i.installment_amount,
          nvl2(i.invoice_id,'NA','UPD'),
          i.attribute_category,
          i.attribute1,
          i.attribute2,
          i.attribute3,
          i.attribute4,
          i.attribute5,
          i.attribute6,
          i.attribute7,
          i.attribute8,
          i.attribute9,
          i.attribute10,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          i.booking_ms_dtl_id,i.carparking
        );
    END LOOP;
    
    update XXPM_BOOK_MS_REV_HDR set status = 'DRA' where ms_rev_id =l_ms_rev_id ;
     dbms_output.put_line('record inserted for the booking milestone revision booking_hdr_id');
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    retcode := 1 ;
    errbuf  := SUBSTR(sqlerrm, 1, 1000);
  END;
END get_milestones;

PROCEDURE update_milestones
  (
   p_rev_hdr_id in number,
    p_booking_hdr_id IN NUMBER,
    p_func_id        IN NUMBER,
    retcode OUT NUMBER,
    errbuf OUT VARCHAR2
  )
AS
  l_booking_ms_dtl_id NUMBER;
--  CURSOR book_ms
--  IS
--    SELECT booking_ms_dtl_id,
--      milestone_type,
--      ms_dtl_id,
--      pl_mod_id,
--      seq_number,
--      installment_type,
--      installment_pct,
--      installment_amount,
--      uom,
--      quantity,
--      rate,
--      wave_off,
--      included_in_rate,
--      installment_method,
--      installment_event,
--      period_occurence,
--      period_values,
--      period_duration,
--      charge_type,
--      payment_term,
--      remarks,
--      due_days,
--      due_days_from,
--      due_date,
--      attribute_category,
--      attribute1,
--      attribute2,
--      attribute3,
--      attribute4,
--      attribute5,
--      attribute6,
--      attribute7,
--      attribute8,
--      attribute9,
--      attribute10,
--      created_by,
--      creation_date,
--      last_updated_by,
--      last_update_date,
--      last_update_login,
--      source_func_id,
--      source_func_ref_id,
--      billing_id,
--      status,
--      invoice_id,
--      booking_hdr_id
--    FROM xxpm_booking_milestones
--    WHERE booking_hdr_id = p_booking_hdr_id;
  CURSOR book_ms_rev
  IS
    SELECT ms_rev_dtl_id,
      ms_rev_id,
      source_func_id,
      source_func_ref_id,
      milestone_type,
      ms_dtl_id,
      pl_mod_id,
      seq_number,
      installment_type,
      installment_pct,
      installment_amount,
      uom,
      quantity,
      rate,
      wave_off,
      included_in_rate,
      installment_method,
      installment_event,
      period_occurence,
      period_values,
      period_duration,
      charge_type,
      payment_term,
      remarks,
      due_days,
      due_days_from,
      due_date,
      billing_id,
      status,
      invoice_id,
      installment_pct_r,
      installment_amount_r,
      action_flag,
      attribute_category,
      attribute1,
      attribute2,
      attribute3,
      attribute4,
      attribute5,
      attribute6,
      attribute7,
      attribute8,
      attribute9,
      attribute10,
      created_by,
      creation_date,
      last_updated_by,
      last_update_date,
      last_update_login,
      booking_ms_dtl_id,carparking
    FROM xxpm_book_ms_rev_dtl
    WHERE ms_rev_id =  p_rev_hdr_id;
BEGIN
  retcode := 0 ;
  errbuf  := 'success' ;
  BEGIN
    FOR i IN book_ms_rev
    LOOP
      IF (i.booking_ms_dtl_id IS NOT NULL) THEN
        IF(i.action_flag       = 'DEL') THEN
          DELETE
          FROM xxpm_booking_milestones
          WHERE booking_ms_dtl_id = i.booking_ms_dtl_id;
        elsif(i.action_flag       = 'UPD') THEN
          UPDATE xxpm_booking_milestones
          SET installment_pct     = i.installment_pct_r,
            installment_amount    = i.installment_amount_r,
            status                = i.status
          WHERE booking_ms_dtl_id = i.booking_ms_dtl_id;
        END IF;
      ELSE
        IF(i.action_flag = 'NEW') THEN
          SELECT xxpm_booking_milestones_s.nextval INTO l_booking_ms_dtl_id FROM dual;
          INSERT
          INTO xxpm_booking_milestones
            (
              booking_ms_dtl_id,
              milestone_type,
              ms_dtl_id,
              pl_mod_id,
              seq_number,
              installment_type,
              installment_pct,
              installment_amount,
              uom,
              quantity,
              rate,
              wave_off,
              included_in_rate,
              installment_method,
              installment_event,
              period_occurence,
              period_values,
              period_duration,
              charge_type,
              payment_term,
              remarks,
              due_days,
              due_days_from,
              due_date,
              attribute_category,
              attribute1,
              attribute2,
              attribute3,
              attribute4,
              attribute5,
              attribute6,
              attribute7,
              attribute8,
              attribute9,
              attribute10,
              created_by,
              creation_date,
              last_updated_by,
              last_update_date,
              last_update_login,
              source_func_id,
              source_func_ref_id,
              billing_id,
              status,
              invoice_id,
              booking_hdr_id,carparking
            )
            VALUES
            (
              l_booking_ms_dtl_id,
              i.milestone_type,
              i.ms_dtl_id,
              i.pl_mod_id,
              i.seq_number,
              i.installment_type,
              i.installment_pct_r,
              i.installment_amount_r,
              i.uom,
              i.quantity,
              i.rate,
              i.wave_off,
              i.included_in_rate,
              i.installment_method,
              i.installment_event,
              i.period_occurence,
              i.period_values,
              i.period_duration,
              i.charge_type,
              i.payment_term,
              i.remarks,
              i.due_days,
              i.due_days_from,
              i.due_date,
              i.attribute_category,
              i.attribute1,
              i.attribute2,
              i.attribute3,
              i.attribute4,
              i.attribute5,
              i.attribute6,
              i.attribute7,
              i.attribute8,
              i.attribute9,
              i.attribute10,
              i.created_by,
              i.creation_date,
              i.last_updated_by,
              i.last_update_date,
              i.last_update_login,
              i.source_func_id,
              i.source_func_ref_id,
              i.billing_id,
              i.status,
              i.invoice_id,
              p_booking_hdr_id,i.carparking
            );
          -- code to update booking_ms_dtl_id field in rev detail table
          UPDATE xxpm_book_ms_rev_dtl
          SET booking_ms_dtl_id = l_booking_ms_dtl_id,
            source_func_id      = 58,
            source_func_ref_id  = ms_rev_id
          WHERE ms_rev_dtl_id   = i.ms_rev_dtl_id;
          
             UPDATE xxpm_booking_milestones
          SET 
            source_func_id      = 58,
            source_func_ref_id  = i.ms_rev_id
          WHERE booking_ms_dtl_id   = l_booking_ms_dtl_id;
          
          
        END IF;
      END IF;
    END LOOP;
    -- dbms_output.put_line('record inserted for the booking milestone table booking_hdr_id'|| i_booking_id);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    retcode := 1 ;
    errbuf  := SUBSTR(sqlerrm, 1, 1000);
  END;
  BEGIN
--    FOR j IN book_ms
--    LOOP
--      UPDATE xxpm_book_ms_rev_dtl
--      SET installment_amount =j.installment_amount,
--        installment_pct      =j.installment_pct
--      WHERE booking_ms_dtl_id=j.booking_ms_dtl_id;
--    END LOOP;
    update XXPM_BOOK_MS_REV_HDR set status = 'APR' where ms_rev_id =p_rev_hdr_id ;


    -- dbms_output.put_line('record inserted for the booking milestone table booking_hdr_id'|| i_booking_id);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    retcode := 1 ;
    errbuf  := SUBSTR(sqlerrm, 1, 1000);
  END;
END update_milestones;
FUNCTION get_customername(
    p_booking_id xxpm_booking_customer.booking_hdr_id%type)
  RETURN VARCHAR2
IS
  l_cust_name xxstg_customer.customer_name%type;
  l_cust_id xxstg_customer.cust_id%type;
BEGIN
  SELECT cust_id
  INTO l_cust_id
  FROM xxpm_booking_customer
  WHERE booking_hdr_id = p_booking_id
  AND primary_yn       = 'Y'
  AND rownum           = 1;
  SELECT customer_name
  INTO l_cust_name
  FROM xxstg_customer
  WHERE cust_id = l_cust_id;
  RETURN l_cust_name;
END get_customername;
FUNCTION get_customersite(
    p_booking_id xxpm_booking_customer.booking_hdr_id%type)
  RETURN NUMBER
IS
  l_cust_site_id xxpm_booking_customer.bill_to_site_id%type;
BEGIN
  SELECT bill_to_site_id
  INTO l_cust_site_id
  FROM xxpm_booking_customer
  WHERE booking_hdr_id = p_booking_id
  AND primary_yn       = 'Y'
  AND rownum           = 1;
  RETURN l_cust_site_id;
END get_customersite;

FUNCTION get_customersiteName(
    p_booking_id xxpm_booking_customer.booking_hdr_id%type)
  RETURN VARCHAR2
IS
  l_cust_site_id xxpm_booking_customer.bill_to_site_id%type;
  l_cust_site_name VARCHAR2(130);
  l_org_id NUMBER;
BEGIN
  SELECT bill_to_site_id
  INTO l_cust_site_id
  FROM xxpm_booking_customer
  WHERE booking_hdr_id = p_booking_id
  AND primary_yn       = 'Y'
  AND rownum           = 1;
  
  select org_id 
  into l_org_id
  from xxpm_booking_header
  where booking_hdr_id = p_booking_id;
  
  select country ||' '|| city into l_cust_site_name from xxstg_cust_sites where CUST_SITE_ID = l_cust_site_id and org_id=l_org_id;
  RETURN l_cust_site_name;
END get_customersiteName;

END xxpm_book_ms_rev_pkg;
