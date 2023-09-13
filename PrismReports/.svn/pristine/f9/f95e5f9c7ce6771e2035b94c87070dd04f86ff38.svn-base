--------------------------------------------------------
--  DDL for Package XXDM_SALE_RECEIPTS_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXDM_SALE_RECEIPTS_PKG" 
AS
procedure sales_receipts_val(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);
     PROCEDURE sales_receipts_insert( P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);

end xxdm_sale_receipts_pkg;


--------------------------------------------------------
--  DDL for Package Body XXDM_SALE_RECEIPTS_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXDM_SALE_RECEIPTS_PKG" 
AS
procedure sales_receipts_val
(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
    AS
   
    cursor cur_receipt_val
    is
    select
RECEIPT_NUMBER,
INVOICE_NUMBER,
RECEIPT_DATE,
BUSINESS_UNIT,
RECEIPT_TYPE,
PROPERTY,
UNIT,
BUILDING,
CUSTOMER,
CUSTOMER_BILL_TO_SITE,
CURRENCY,
RECEIPT_AMOUNT,
PAYMENT_MODE,
PAYMENT_REFERNCE_NUMBER,
PYAMENT_REFERNCE_DATE,
BANK_NAME,
BANK_BRANCH_NAME,
STATUS,
DESCRIPTION,
TAX_AMOUNT,
TAX,
TAX_RATE,
GL_DATE,
PAYMENT_MILESTONE,
AMOUNT_APPLIED,
APPLIED_DATE,
BOOKING_NUMBER,
SPA_NUMBER,
status_flag,
ORG_ID,
PROPERTY_ID,
BUILD_ID,
UNIT_ID,
CUST_ID,
CUST_SITE_ID,
ERR_DESC,
RECEIPT_TYPE_NAME,
PAY_MODE_ID


from xxdm_sales_receipts
where nvl(status_flag,'E') = 'E' ;


l_RECEIPT_NUMBER number;
l_org_id  number;
l_invoice_number number;
l_property_id number;
l_build_id number;
l_unit_id number;
l_currency varchar2(10);
l_cust_id number;
L_CUSTOMER_BILL_TO  number;
l_err_msg  varchar2(250);
l_status_flag  varchar2(100);
l_booking_number number;
l_invoice_id number;
l_tax_code  varchar2(10);
l_receipt_type varchar2(250);
l_pay_mode number;

    Begin

      p_err_code := 0;
        p_err_msg := 'SUCCESS';



    for i in cur_receipt_val
    loop
            l_err_msg := NULL;
            l_status_flag := 'V';



   --==============================================================================
    ---------------------RECEIPT_NUMBER Validations----------------------------------
    --==============================================================================
            BEGIN
                SELECT
                    COUNT(*)
                INTO l_RECEIPT_NUMBER
                FROM
                    xxpm_receipt
                WHERE
                    RECEIPT_NUMBER = i.RECEIPT_NUMBER;

                IF l_RECEIPT_NUMBER > 0 THEN
                    l_err_msg := l_err_msg || ' RECEIPT_NUMBER is already exsist ';
                    l_status_flag := 'E';
                END IF;

            END;

    --==============================================================================
    ---------------------INVOICE_NUMBER Validations----------------------------------
    --==============================================================================
          BEGIN
                SELECT
                 invoice_id
                INTO l_invoice_id
                FROM
                  xxpm_invoice_header
               WHERE
                  invoice_number = i.invoice_number;

              exception when others then
                   l_err_msg := l_err_msg || ' Invoice_number does not exsist ';
                    l_status_flag := 'E';

          END;

               --==============================================================================
    ---------------------BUSINESS_UNIT Validations----------------------------------
    --==============================================================================

            l_org_id := xxpm_dm_lib_pkg.get_org_id(i.business_unit);
            IF l_org_id IS NULL THEN
                l_err_msg := l_err_msg || ' invalid..BUSINESS_UNIT';
                l_status_flag := 'E';
                l_org_id := NULL;
            END IF;

             --==============================================================================
    ---------------------PROPERTY_NAME Validations----------------------------------
    --==============================================================================
    l_property_id   :=xxpm_dm_lib_pkg.get_property_id(i.property ,i.business_unit);
    IF l_property_id IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..PROPERTY';
      l_status_flag := 'E';
      l_property_id := NULL;
    END IF;
    --==============================================================================
    ---------------------BUILDING_NAME Validations----------------------------------
    --==============================================================================
    l_build_id       :=xxpm_dm_lib_pkg.get_building_id(i.building ,i.property,i.business_unit);
    IF l_build_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..BUILDING';
      l_status_flag := 'E';
      l_build_id     := NULL;
    END IF;
    --==============================================================================
    ---------------------unit Validations----------------------------------
    --==============================================================================
    l_unit_id       :=xxpm_dm_lib_pkg.get_unit_id(i.unit,i.building ,i.property,i.business_unit);
    IF l_unit_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..  unit';
      l_status_flag := 'E';
      l_unit_id     := NULL;
    END IF;

     --==============================================================================
    ---------------------CURRENCY Validations----------------------------------
    --==============================================================================
    l_currency      :=xxpm_dm_lib_pkg.get_lookup('CURRENCY',i.currency);
    IF l_currency   IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..CURRENCY';
      l_status_flag := 'E';
      l_currency    := NULL;
    END IF;
    --==============================================================================
    ---------------------CUSTOMER NAME Validations----------------------------------
    --==============================================================================
    l_cust_id       :=xxpm_dm_lib_pkg.get_cust_id(i.customer);
    IF l_cust_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..CUSTOMER';
      l_status_flag := 'E';
      l_cust_id     := NULL;
    END IF;
    --==============================================================================
    ---------------------CUSTOMER_BILL_TO Validations----------------------------------
    --==============================================================================
    L_CUSTOMER_BILL_TO   :=XXPM_DM_LIB_PKG.GET_CUST_SITE_ID(I.CUST_ID ,I.BUSINESS_UNIT);
    IF l_customer_bill_to IS NULL THEN
      l_err_msg          := l_err_msg ||' invalid..CUSTOMER_BILL_TO';
      l_status_flag      := 'E';
      l_customer_bill_to := NULL;
    END IF;
    
     --==============================================================================
    ---------------------RECEIPT TYPE VALIDATIONS----------------------------------
    --==============================================================================

   l_receipt_type   :=XXPM_DM_LIB_PKG.get_lookupBy_name('RECEIPT_TYPE' ,I.RECEIPT_TYPE_NAME);
    IF l_receipt_type IS NULL THEN
      l_err_msg          := l_err_msg ||' invalid..RECEIPT_TYPE';
      l_status_flag      := 'E';
      l_receipt_type := NULL;
    END IF;
--==============================================================================
    ---------------------RECEIPT METHOD -- PAY MODE VALIDATIONS----------------------------------
    --==============================================================================


 l_pay_mode   :=XXPM_DM_LIB_PKG.get_pay_mode(I.PAYMENT_MODE);
    IF l_pay_mode IS NULL THEN
      l_err_msg          := l_err_msg ||' invalid..PAYMENT_MODE';
      l_status_flag      := 'E';
      l_pay_mode := NULL;
    END IF;



      --==============================================================================
    ---------------------BOOKING_NUMBER Validations----------------------------------
    --==============================================================================

            BEGIN
                SELECT
                    COUNT(*)
                INTO l_booking_number
                FROM
                    xxpm_booking_header
                WHERE
                    booking_number = i.booking_number;

                IF l_booking_number = 0 THEN
                    l_err_msg := l_err_msg || ' BOOKING_NUMBER is not exsist ';
                    l_status_flag := 'E';
                end if;
        end;
             --==============================================================================
    ---------------------tax_code Validations----------------------------------
    --==============================================================================
    l_tax_code :=xxpm_dm_lib_pkg.get_lookupBy_name('TAX_TYPE',i.tax);
      IF l_tax_code        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..tax_code';
      l_status_flag := 'E';
      l_tax_code         := NULL;
    END IF;

    update xxdm_sales_receipts
    set org_id =l_org_id ,
    property_id=l_property_id,
    build_id=l_build_id,
    unit_id=l_unit_id,
    cust_id=l_cust_id,
    cust_site_id=L_CUSTOMER_BILL_TO,
    status_flag=l_status_flag,
    err_desc =l_err_msg,
    invoice_id =l_invoice_id,
    receipt_type=l_receipt_type,
    PAY_MODE_ID=l_pay_mode
    where RECEIPT_NUMBER =i.RECEIPT_NUMBER ;




    end loop;
       commit;

    END sales_receipts_val;

    PROCEDURE sales_receipts_insert( P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
    as
    cursor receipts_insert
    is
select
rowid,
RECEIPT_NUMBER,
INVOICE_NUMBER,
RECEIPT_DATE,
BUSINESS_UNIT,
RECEIPT_TYPE,
PROPERTY,
UNIT,
BUILDING,
CUSTOMER,
CUSTOMER_BILL_TO_SITE,
CURRENCY,
RECEIPT_AMOUNT,
PAYMENT_MODE,
PAYMENT_REFERNCE_NUMBER,
PYAMENT_REFERNCE_DATE,
BANK_NAME,
BANK_BRANCH_NAME,
STATUS,
DESCRIPTION,
TAX_AMOUNT,
TAX,
TAX_RATE,
GL_DATE,
PAYMENT_MILESTONE,
AMOUNT_APPLIED,
applied_date,
BOOKING_NUMBER,
SPA_NUMBER,
status_flag,
ORG_ID,
PROPERTY_ID,
BUILD_ID,
UNIT_ID,
CUST_ID,
CUST_SITE_ID,
ERR_DESC,invoice_id,
RECEIPT_TYPE_NAME,
PAY_MODE_ID,
BANK_ACCOUNT_NUM
from xxdm_sales_receipts
where status_flag = 'V' and property= 'STE';
   l_receipt_id number;
   l_booking_ms_id number;
   l_booking_id number;
    begin

    for i in  receipts_insert
    loop
    BEGIN
    l_receipt_id :=XXPM_RECEIPT_ID_S.nextval;
    
            l_booking_ms_id:=xxpm_dm_lib_pkg.get_booking_ms_id(i.booking_number);
            IF l_booking_ms_id IS NULL THEN
            l_booking_ms_id  := NULL;
            END IF;
               select BOOKING_HDR_ID into l_booking_id from xxpm_booking_header where BOOKING_NUMBER  = i.BOOKING_NUMBER;
    
    
    INSERT INTO xxpm_receipt (
        receipt_id,
        func_id        ,
        source_func_id,
        source_func_ref_id,
        receipt_number,
        receipt_date,
        org_id,
        receipt_type,
        property_id,
        unit_id,
        build_id,
        lead_id,
        cust_id,
        cust_site_id,
        salesman_id        ,
        customer_name,
        currency_code,
        receipt_amount,
        pay_mode,
        pay_ref_number,
        pay_ref_date,
        bank_name,
        bank_branch_name        ,
        drawn_by,
        status,
        description,
        flow_status,
        flow_level,
        flow_with,
        tax_amount,
        tax_code,
        tax_rate,
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
        attribute11,
        attribute12, 
        ATTRIBUTE13,
        attribute14,
        attribute15,
        attribute16,
        attribute17,
        attribute18,
        attribute19,
        attribute20,
        created_by,
        CREATION_DATE,
        last_updated_by,
        last_update_date,
        last_update_login,
        recommended_amount,
        received_amount,
        diff_in_days,
        pay_rec_date,
        pay_rev_date,
        rct_type,
        rct_desc,
        interface_status,
        gl_date,
        rev_date,
        rev_gl_date,
        rev_category,
        rev_reason,
        rev_desc,
        rev_int_status,
        receipt_risk_yn,
        interface_error_msg,
        bank_account_num
    ) VALUES (
    l_receipt_id ,     --        receipt_id,
             9             ,--        func_id,
7,--        source_func_id,
l_booking_id,--        source_func_ref_id,
i.RECEIPT_NUMBER,--        receipt_number,
i.RECEIPT_DATE,--        receipt_date,
i.ORG_ID,--        org_id,
i.RECEIPT_TYPE,--        receipt_type,
i.property_id,--        property_id,
i.unit_id,         --        unit_id,
i.build_id,--        build_id,
null,--        lead_id,
i.cust_id,--        cust_id,
i.CUST_SITE_ID,--        cust_site_id,
null,--        salesman_id,
i.CUSTOMER,--        customer_name,
i.CURRENCY,--        currency_code,
i.RECEIPT_AMOUNT,--        receipt_amount,
i.PAY_MODE_ID,  --        pay_mode,
i.PAYMENT_REFERNCE_NUMBER,  --        pay_ref_number,
i.PYAMENT_REFERNCE_DATE ,--        pay_ref_date,
i.BANK_NAME, --        bank_name,
i.BANK_BRANCH_NAME
,  --        bank_branch_name,
null,--        drawn_by,
'APR',--        status,
i.description,--        description,
null,--        flow_status,
null,--        flow_level,
null,--        flow_with,
i.tax_amount,--        tax_amount,
i.tax,--        tax_code,
i.tax_rate,--        tax_rate,
null,--        attribute_category,
null,--        attribute1,
null,--        attribute2,
null,--        attribute3,
null,--        attribute4,
null,--        attribute5,
null,--        attribute6,
null,--        attribute7,
null,--        attribute8,
null,--        attribute9,
null,--        attribute10,
null,--        attribute11,
null,--        attribute12,
null,--        attribute13,
null,--        attribute14,
null,--        attribute15,
null,--        attribute16,
null,--        attribute17,
null,--        attribute18,
null,--        attribute19,
null,--        attribute20,
'anonymous',--        created_by,
sysdate,--        creation_date,
'anonymous',--        last_updated_by,
sysdate,--        last_update_date,
'anonymous',--        last_update_login,
null,--        recommended_amount,
null,--        received_amount,
null,--        diff_in_days,
null,--        pay_rec_date,
null,--        pay_rev_date,
null,--        rct_type,
null,--        rct_desc,
null,--        interface_status,
i.GL_DATE,--        gl_date,
null,--        rev_date,
null,--        rev_gl_date,
null,--        rev_category,
null,--        rev_reason,
null,--        rev_desc,
i.STATUS,--        rev_int_status,
null,--        receipt_risk_yn,
null,--        interface_error_msg,
i.BANK_ACCOUNT_NUM--        bank_account_num
    );


    insert into xxpm_receipt_details
    ( receipt_dtl_id,
    receipt_id,
    booking_ms_dtl_id,
    amount_applied,
    applied_date,
    receivable_application_id,
    customer_trx_id,
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
    attribute11,
    attribute12,
    attribute13,
    attribute14,
    attribute15,
    attribute16,
    attribute17,
    attribute18,
    attribute19,
    attribute20,
    created_by,
    creation_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    invoice_id,
    interface_status,
    interface_error_msg)
    values
    (
RECEIPT_DTL_ID_S.nextval,--    receipt_dtl_id,
l_receipt_id ,--    receipt_id,
l_booking_ms_id,--    booking_ms_dtl_id,
i.AMOUNT_APPLIED,--    amount_applied,
i.applied_date,--    applied_date,
null,--    receivable_application_id,
null,--    customer_trx_id,
null,--    attribute_category,
null,--    attribute1,
null,--    attribute2,
null,--    attribute3,
null,--    attribute4,
null,--    attribute5,
null,--    attribute6,
null,--    attribute7,
null,--    attribute8,
null,--    attribute9,
null,--    attribute10,
null,--    attribute11,
null,--    attribute12,
null,--    attribute13,
null,--    attribute14,
null,--    attribute15,
null,--    attribute16,
null,--    attribute17,
null,--    attribute18,
null,--    attribute19,
null,--    attribute20,
'anonymous',--    created_by,
sysdate,--    creation_date,
'anonymous',--    last_updated_by,
sysdate,--    last_update_date,
'anonymous',--    last_update_login,
i.invoice_id,--    invoice_id,
null,--    interface_status,
null--    interface_error_msg
    );


UPDATE xxdm_sales_receipts
    SET status_flag      ='P'
    WHERE booking_number = i.booking_number;
 EXCEPTION
    WHEN OTHERS THEN
        P_ERR_CODE := SQLCODE;
        P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);
        UPDATE xxdm_sales_receipts set STATUS_FLAG='F',ERR_DESC=P_ERR_CODE || '-' || P_ERR_MSG
        WHERE booking_number = i.booking_number
        AND rowid  = i.rowid;
    END;
    end loop;

   commit;

    end sales_receipts_insert;



end xxdm_sale_receipts_pkg;
