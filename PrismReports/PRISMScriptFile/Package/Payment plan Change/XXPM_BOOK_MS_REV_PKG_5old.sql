CREATE OR REPLACE PACKAGE "XXPM_BOOK_MS_REV_PKG" is

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

procedure get_updated_milestones(p_rev_hdr_id in number, p_booking_hdr_id   in    number);


 FUNCTION GET_LINE_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
    )
RETURN NUMBER;

 FUNCTION GET_TAX_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
    )
RETURN NUMBER; 

end xxpm_book_ms_rev_pkg;
/


CREATE OR REPLACE PACKAGE BODY "XXPM_BOOK_MS_REV_PKG" 
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
  l_TAX_CODE VARCHAR2(60);
  l_TAX_RATE number; 
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
      booking_ms_dtl_id,
      carparking
    FROM xxpm_book_ms_rev_dtl
    WHERE ms_rev_id =  p_rev_hdr_id;


BEGIN
  retcode := 0 ;
  errbuf  := 'success' ;

begin
SELECT 
TAX_CODE, TAX_RATE
into
l_TAX_CODE, l_TAX_RATE 
FROM xxpm_booking_detail where booking_hdr_id=p_booking_hdr_id;
end;
--BASEAMOUNT
--TAX_AMOUNT
--l_LINE_AMT:=p_TOTAL_SPA/(100+l_taxper)*100;
--p_TAX_AMT:=p_TOTAL_SPA/(100+l_taxper)*l_taxper;

BEGIN
    FOR i IN book_ms_rev
    LOOP
      IF (i.booking_ms_dtl_id IS NOT NULL) THEN
        IF(i.action_flag       = 'DEL') THEN
          DELETE
          FROM xxpm_booking_milestones
          WHERE booking_ms_dtl_id = i.booking_ms_dtl_id;
          --dinesh
          delete
          FROM xxpm_book_ms_rev_dtl
          where 
          action_flag       = 'DEL'
          and booking_ms_dtl_id=i.booking_ms_dtl_id;
         dbms_output.put_line('delete'|| i.booking_ms_dtl_id); 
		 
        elsif(i.action_flag       = 'UPD') THEN
          UPDATE xxpm_booking_milestones
          SET installment_pct     = round(i.installment_pct_r,2),
              installment_amount    = i.installment_amount_r,
              status                = i.status,
SOURCE_FUNC_ID      =i.source_func_id,
SOURCE_FUNC_REF_ID  =i.source_func_ref_id,
MILESTONE_TYPE      =i.milestone_type,
MS_DTL_ID           =i.ms_dtl_id,
PL_MOD_ID           =i.pl_mod_id,
SEQ_NUMBER          =i.seq_number,
INSTALLMENT_TYPE    =i.installment_type,
UOM                 =i.uom,
QUANTITY            =i.quantity,
RATE                =i.rate,
WAVE_OFF            =i.wave_off,
INCLUDED_IN_RATE    =i.included_in_rate,
INSTALLMENT_METHOD  =i.installment_method,
INSTALLMENT_EVENT   =i.installment_event,
PERIOD_OCCURENCE    =i.period_occurence,
PERIOD_VALUES       =i.period_values,
PERIOD_DURATION     =i.period_duration,
CHARGE_TYPE         =i.charge_type,
PAYMENT_TERM        =i.payment_term,
REMARKS             =i.remarks,
DUE_DAYS            =i.due_days,
DUE_DAYS_FROM       =i.due_days_from,
DUE_DATE            =i.due_date,
BILLING_ID          =i.billing_id,
LAST_UPDATED_BY     =i.last_updated_by,
LAST_UPDATE_DATE    =i.last_update_date,
LAST_UPDATE_LOGIN   =i.last_update_login,
BOOKING_MS_DTL_ID   =i.booking_ms_dtl_id,
CARPARKING          =i.carparking,
BASEAMOUNT          =GET_LINE_AMT(i.installment_amount_r,l_TAX_CODE, NVL(l_TAX_RATE,0)),
TAX_AMOUNT          =GET_TAX_AMT(i.installment_amount_r,l_TAX_CODE, NVL(l_TAX_RATE,0)),
TAX_CODE=l_TAX_CODE, 
TAX_RATE=l_TAX_RATE

WHERE booking_ms_dtl_id = i.booking_ms_dtl_id;
        END IF;
dbms_output.put_line('==record==update');
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
              booking_hdr_id,
              carparking,
              TAX_RATE, 
              TAX_CODE, 
              TAX_AMOUNT,
              BASEAMOUNT
            )
            VALUES
            (
              l_booking_ms_dtl_id,
              i.milestone_type,
              i.ms_dtl_id,
              i.pl_mod_id,
              i.seq_number,
              i.installment_type,
              round(NVL(i.installment_pct_r,0),2),
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
              p_booking_hdr_id,
              i.carparking,
              l_TAX_RATE, 
              l_TAX_CODE, 
              GET_TAX_AMT(i.installment_amount_r,l_TAX_CODE, NVL(l_TAX_RATE,0)),
              GET_LINE_AMT(i.installment_amount_r,l_TAX_CODE, NVL(l_TAX_RATE,0))
            );
		dbms_output.put_line('record '|| xxpm_bill_invoice_pkg.GET_TAX_AMT(i.installment_amount_r,l_TAX_CODE, NVL(l_TAX_RATE,0)));
		dbms_output.put_line('record'|| xxpm_bill_invoice_pkg.GET_LINE_AMT(i.installment_amount_r,l_TAX_CODE, NVL(l_TAX_RATE,0)));		
          -- code to update booking_ms_dtl_id field in rev detail table
          UPDATE xxpm_book_ms_rev_dtl
          SET booking_ms_dtl_id = l_booking_ms_dtl_id,
            source_func_id      = 58,
            source_func_ref_id  = ms_rev_id,
            action_flag       = 'UPD'
          WHERE ms_rev_dtl_id   = i.ms_rev_dtl_id;

             UPDATE xxpm_booking_milestones
          SET 
            source_func_id      = 58,
            source_func_ref_id  = i.ms_rev_id
          WHERE booking_ms_dtl_id   = l_booking_ms_dtl_id;
		dbms_output.put_line('==record==New');
        END IF;
      END IF;
    END LOOP;
    dbms_output.put_line('record inserted for the booking milestone table booking_hdr_id');
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

procedure get_updated_milestones(p_rev_hdr_id in number, p_booking_hdr_id   in    number)
as

l_old_ms_rev_id number;

begin
begin
if(p_rev_hdr_id is null) then
SELECT MS_REV_ID into l_old_ms_rev_id
FROM xxpm_book_ms_rev_hdr 
where BOOKING_HDR_ID=p_booking_hdr_id;
else 
l_old_ms_rev_id:=p_rev_hdr_id;
end if;
exception 
when no_data_found then
DBMS_OUTPUT.PUT_LINE('P_ERROR_CODE');
end;
            MERGE INTO xxpm_book_ms_rev_dtl a
              USING (SELECT BOOKING_MS_DTL_ID, MILESTONE_TYPE, MS_DTL_ID, PL_MOD_ID, SEQ_NUMBER, INSTALLMENT_TYPE, INSTALLMENT_PCT, INSTALLMENT_AMOUNT, UOM, QUANTITY, RATE, WAVE_OFF, INCLUDED_IN_RATE, INSTALLMENT_METHOD, INSTALLMENT_EVENT, PERIOD_OCCURENCE, PERIOD_VALUES, PERIOD_DURATION, CHARGE_TYPE, PAYMENT_TERM, REMARKS, DUE_DAYS, DUE_DAYS_FROM, DUE_DATE, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, SOURCE_FUNC_ID, SOURCE_FUNC_REF_ID, BILLING_ID, STATUS, INVOICE_ID, BOOKING_HDR_ID, BASEAMOUNT, TAX_RATE, TAX_CODE, TAX_AMOUNT, CARPARKING
                       FROM xxpm_booking_milestones WHERE booking_hdr_id = p_booking_hdr_id) i
                 ON (a.booking_ms_dtl_id = i.booking_ms_dtl_id)
         WHEN MATCHED
         THEN
                    UPDATE SET installment_pct     = i.installment_pct,
            installment_amount    = i.installment_amount,
            status                = i.status

         WHEN NOT MATCHED
         THEN
            INSERT     (
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
                VALUES (XXPM_BOOKING_REV_ID_S.nextval,
--          p_rev_hdr_id,
            l_old_ms_rev_id,
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

    COMMIT;
end get_updated_milestones;

FUNCTION GET_LINE_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
) RETURN NUMBER as 

l_LINE_AMT  NUMBER;
l_taxper NUMBER;

BEGIN
IF p_TAX_PERC IS NOT NULL THEN
l_LINE_AMT:=p_TOTAL_SPA/(100+p_TAX_PERC)*100;
--DBMS_OUTPUT.PUT_LINE('HAVING PERCENTAGE');
ELSE

IF(p_TAX_CODE='COMMERCIAL') THEN
l_taxper:=5;
ELSIF(p_TAX_CODE='COMMERCIAL EXEMPT') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL EXEMPT')THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='STANDARD RATE') THEN
l_taxper:=5;
else 
l_taxper:=0;
END IF;

l_LINE_AMT:=p_TOTAL_SPA/(100+l_taxper)*100;
DBMS_OUTPUT.PUT_LINE('NO PERCENTAGE');
END IF;
RETURN l_LINE_AMT;

EXCEPTION 
WHEN no_data_found THEN
        l_LINE_AMT := 0;
        RETURN l_LINE_AMT;
END GET_LINE_AMT;

FUNCTION GET_TAX_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
) RETURN NUMBER AS

p_TAX_AMT  NUMBER;
l_taxper NUMBER;

BEGIN
IF p_TAX_PERC IS NOT NULL THEN

p_TAX_AMT:=p_TOTAL_SPA/(100+p_TAX_PERC)*p_TAX_PERC;
--DBMS_OUTPUT.PUT_LINE('HAVING PERCENTAGE');
ELSE

IF(p_TAX_CODE='COMMERCIAL') THEN
l_taxper:=5;
ELSIF(p_TAX_CODE='COMMERCIAL EXEMPT') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL') THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='RESIDENTIAL EXEMPT')THEN
l_taxper:=0;
ELSIF(p_TAX_CODE='STANDARD RATE') THEN
l_taxper:=5;
else 
l_taxper:=0;
END IF;

p_TAX_AMT:=p_TOTAL_SPA/(100+l_taxper)*l_taxper;
DBMS_OUTPUT.PUT_LINE('NO PERCENTAGE');
END IF;
RETURN p_TAX_AMT;

EXCEPTION 
WHEN no_data_found THEN
        p_TAX_AMT := 0;
        RETURN p_TAX_AMT;
END GET_TAX_AMT;



END xxpm_book_ms_rev_pkg;
/
