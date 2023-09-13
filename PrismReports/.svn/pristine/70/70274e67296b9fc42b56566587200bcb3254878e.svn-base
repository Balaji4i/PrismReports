--------------------------------------------------------
--  DDL for Package XXDM_SALE_INVOICES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXDM_SALE_INVOICES" 
as
procedure sales_invoice_val(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
;

procedure sales_invoice_Insert(    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2);

    FUNCTION get_function_id(
    p_func_short_code IN VARCHAR2)
    RETURN NUMBER;



end xxdm_sale_invoices;


--------------------------------------------------------
--  DDL for Package Body XXDM_SALE_INVOICES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXDM_SALE_INVOICES" AS

    PROCEDURE sales_invoice_val( p_err_code  OUT    VARCHAR2,
        p_err_msg   OUT    VARCHAR2)AS
    
   
    
        CURSOR cur_sale_inv IS
     SELECT
    invoice_number,
    invoice_date,
    invoice_class,
    business_unit,
    currency_code,
    customer_name,
    customer_account_number,
    customer_bill_to_site_number,
    payment_term,
    due_date,
    status,
    booking_number,
    customer_transaction_number,
    status_flag,
    org_id,
    cust_id,
    bill_to_site_id,
    payment_term_name,
    err_desc,
    offer_id,
    booking_id,
    description,
    uom_code,
    quantity,
    price,
    line_amount,
    tax_code,
    tax_percenatge,
    tax_amount,
    charge_type,
    property,
    building,
    unit_short_code,
    payment_milestone,
    spa_number,
    collected_amount,
    receipt_status,
    outstanding_amount,
    charge_type_name,
    property_id,
    build_id,
unit_id,
installment_type_name
FROM
    xxdm_sales_invoices
WHERE
    nvl(status_flag, 'E') = 'E';

        l_invoice_number     NUMBER;
        l_err_msg            VARCHAR2(500);
        l_status_flag        VARCHAR2(5);
        l_org_id             NUMBER;
    l_booking_number     NUMBER;
        l_currency           VARCHAR2(5);
        l_cust_id            NUMBER;
        l_customer_bill_to   NUMBER;
        l_payment_term       VARCHAR2(50);
        l_offer_hdr_id       NUMBER;
        l_booking_id         NUMBER;
          l_tax_code         VARCHAR2(5);
          l_uom     VARCHAR2(50);
          l_charge_type   VARCHAR2(50);
          l_unit_id NUMBER;
          l_property_id NUMBER;
          l_buid_id  NUMBER;
            l_installment_type   VARCHAR2(50);

    BEGIN
        p_err_code := 0;
        p_err_msg := 'SUCCESS';
        FOR i IN cur_sale_inv LOOP
            l_invoice_number := NULL;
            l_err_msg := NULL;
            l_status_flag := 'V';
            l_org_id := NULL;
            l_cust_id := NULL;
            l_customer_bill_to := NULL;
              l_payment_term     := NULL;
        l_offer_hdr_id      := NULL;
        l_booking_id       := NULL;
          l_tax_code       := NULL;
          l_charge_type   := NULL;
          l_uom     := NULL;
          l_unit_id := NULL;
          l_property_id:= NULL;
          l_buid_id  := NULL;
          l_installment_type := NULL;


   --==============================================================================
    ---------------------INVOICE_NUMBER Validations----------------------------------
    --==============================================================================
            BEGIN
                SELECT
                    COUNT(*)
                INTO l_invoice_number
                FROM
                    xxpm_invoice_header
                WHERE
                    invoice_number = i.invoice_number;

                IF l_invoice_number > 0 THEN
                    l_err_msg := l_err_msg || ' Invoice_number is already exsist ';
                    l_status_flag := 'E';
                END IF;

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
                ELSE
                    SELECT
                        booking_hdr_id
                    INTO l_booking_id
                    FROM
                        xxpm_booking_header
                    WHERE
                        booking_number = i.booking_number and rownum=1;

                    SELECT
                        offer_hdr_id
                    INTO l_offer_hdr_id
                    FROM
                        xxpm_offer_header
                    WHERE
                        offer_number = i.booking_number and rownum=1;

                END IF;

            END;
    --==============================================================================
    ---------------------CURRENCY Validations----------------------------------
    --==============================================================================

            l_currency := xxpm_dm_lib_pkg.get_lookup('CURRENCY', i.currency_code);
            IF l_currency IS NULL THEN
                l_err_msg := l_err_msg || ' invalid..CURRENCY';
                l_status_flag := 'E';
                l_currency := NULL;
            END IF;


      --==============================================================================
    ---------------------CUSTOMER NAME Validations----------------------------------
    --==============================================================================

            l_cust_id := xxpm_dm_lib_pkg.get_cust_id(i.customer_name);
            IF l_cust_id IS NULL THEN
                l_err_msg := l_err_msg || ' invalid..CUSTOMER';
                l_status_flag := 'E';
                l_cust_id := NULL;
            END IF;
    --==============================================================================
    ---------------------CUSTOMER_BILL_TO Validations----------------------------------
    --==============================================================================

            l_customer_bill_to := xxpm_dm_lib_pkg.get_cust_site_id(i.CUST_ID, i.business_unit);
            IF l_customer_bill_to IS NULL THEN
                l_err_msg := l_err_msg || ' invalid..CUSTOMER_BILL_TO';
                l_status_flag := 'E';
                l_customer_bill_to := NULL;
            END IF;


    --==============================================================================
    ---------------------PAYMENT_TERM Validations----------------------------------
    --==============================================================================

            l_payment_term := xxpm_dm_lib_pkg.get_payment_term(i.payment_term_name);
            IF l_payment_term IS NULL THEN
                l_err_msg := l_err_msg || ' invalid..PAYMENT_TERM';
                l_status_flag := 'E';
                l_payment_term := NULL;
            END IF;

 --==============================================================================
    ---------------------AREA_UOM Validations----------------------------------
    --==============================================================================

    if i.UOM_CODE is not null then
    l_uom           :=xxpm_dm_lib_pkg.get_lookupBy_name('AREA_UOM',i.UOM_CODE);
    IF l_uom        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..AREA_UOM';
      l_status_flag := 'E';
      l_uom         := NULL;
    END IF;
    end if;


        --==============================================================================
    ---------------------CHARGE_TYPE Validations----------------------------------
    --==============================================================================



    l_charge_type    :=xxpm_dm_lib_pkg.get_lookupBy_name('CHARGE_TYPE',i.CHARGE_TYPE_NAME);
    IF l_charge_type IS NULL THEN
      l_err_msg      := l_err_msg ||' invalid..CHARGE_TYPE';
      l_status_flag  := 'E';
      l_charge_type  := NULL;
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
    l_buid_id       :=xxpm_dm_lib_pkg.get_building_id(i.building ,i.property,i.business_unit);
    IF l_buid_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..BUILDING';
      l_status_flag := 'E';
      l_buid_id     := NULL;
    END IF;
    --==============================================================================
    ---------------------unit Validations----------------------------------
    --==============================================================================
    l_unit_id       :=xxpm_dm_lib_pkg.get_unit_id_sh(i.UNIT_SHORT_CODE,i.building ,i.property,i.business_unit);
    IF l_unit_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..  unit';
      l_status_flag := 'E';
      l_unit_id     := NULL;
    END IF;
       --==============================================================================
    ---------------------MILESTONE_INSTALLMENT Validations----------------------------------
    --==============================================================================

   -- l_installment_type    :=xxpm_dm_lib_pkg.get_lookup('MILESTONE_INSTALLMENT',i.installment_type_name);
    --IF l_installment_type IS NULL THEN
    --  l_err_msg           := l_err_msg ||' invalid..MILESTONE_INSTALLMEN';
     -- l_status_flag       := 'E';
     -- l_installment_type  := NULL;
   -- END IF;

           --==============================================================================
    ---------------------tax_code Validations----------------------------------
    --==============================================================================
    l_tax_code :=xxpm_dm_lib_pkg.get_lookupBy_name('TAX_TYPE',i.tax_code);
      IF l_tax_code        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..tax_code';
      l_status_flag := 'E';
      l_tax_code         := NULL;
    END IF;

            UPDATE xxdm_sales_invoices
            SET
                org_id = l_org_id,
                cust_id = l_cust_id,
                bill_to_site_id = l_customer_bill_to,
                status_flag = l_status_flag,
                err_desc = l_err_msg,
                payment_term = l_payment_term,
                offer_id = l_offer_hdr_id,
                booking_id = l_booking_id,
               CHARGE_TYPE =l_charge_type,
                property_id        =l_property_id ,
               build_id        =l_buid_id ,
                unit_id            = l_unit_id,
                PAYMENT_MILESTONE   =l_installment_type
            WHERE
                invoice_number = i.invoice_number;

        END LOOP;
   commit;

    END sales_invoice_val;

    PROCEDURE sales_invoice_insert (
        p_err_code   OUT   VARCHAR2,
        p_err_msg    OUT   VARCHAR2
    ) AS

        CURSOR cur_insert IS
       SELECT
       rowid,
    invoice_number,
    invoice_date,
    invoice_class,
    business_unit,
    currency_code,
    customer_name,
    customer_account_number,
    customer_bill_to_site_number,
    payment_term,
    due_date,
    status,
    booking_number,
    customer_transaction_number,
    status_flag,
    org_id,
    cust_id,
    bill_to_site_id,
    payment_term_name,
    err_desc,
    offer_id,
    booking_id,
    description,
    uom_code,
    quantity,
    price,
    line_amount,
    tax_code,
    tax_percenatge,
    tax_amount,
    charge_type,
    property,
    building,
    unit_short_code,
    payment_milestone,
    spa_number,
    collected_amount,
    receipt_status,
    outstanding_amount,
    charge_type_name,
    property_id,
    build_id,
unit_id,installment_type_name
FROM
    xxdm_sales_invoices
        WHERE
            status_flag = 'V';

        l_invoice_id    NUMBER;
        l_inv_number    VARCHAR2(50);
        l_inv_func_id   NUMBER; 
        l_BOOKING_DTL_ID  NUMBER;
        l_OFFER_DTL_ID   NUMBER;
        l_PROPERTY_NUMBER VARCHAR2(50);
        l_BUILD_NUMBER VARCHAR2(50);
        l_UNIT_NUMBER VARCHAR2(50);
        l_BOOKING_MS_ID NUMBER;
    BEGIN
        FOR i IN cur_insert
        LOOP
        BEGIN
            l_invoice_id := xxpm_invoice_header_s.nextval;
            l_inv_func_id := get_function_id('IN');
            l_inv_number := i.invoice_number;
            INSERT INTO xxpm_invoice_header (
                invoice_id,
                invoice_number,
                invoice_date,
                func_id,
                invoice_class,
                org_id,
                trx_source,
                trx_type,
                currency_code,
                exchange_rate,
                cust_id,
                cust_site_id,
                due_date,
                status,
                interface_status,
                offer_id,
                offer_number,
                booking_id,
                booking_number,
                sale_lease_number,
                customer_trx_id,
                customer_trx_number,
                invoicing_rule,
                acnt_rule,
                rule_start_date,
                rule_end_date,
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
                created_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                interface_error_msg,
                payment_terms
            ) VALUES (
                l_invoice_id,                                 --    invoice_id,
                l_inv_number,                                --    invoice_number,
                i.invoice_date,                                --    invoice_date,
                l_inv_func_id,                              --    func_id,
                i.invoice_class,                            --    invoice_class,
                i.org_id,                                --    org_id,
                NULL,                              --    trx_source,
                NULL,                              --    trx_type,
                i.currency_code,                               --    currency_code,
                NULL,                              --    exchange_rate,
                i.cust_id,                              --    cust_id,
                i.bill_to_site_id,                           --    cust_site_id,
                i.due_date,                        --    due_date,
                'APR',                      --    status,
                i.status,                             --    interface_status,
                i.offer_id,                          --    offer_id,
                i.booking_number,                        --    offer_number,
                i.booking_id,                       --    booking_id,
                i.booking_number,                          --    booking_number,
                NULL,                          --    sale_lease_number,
                NULL,                      --    customer_trx_id,
                l_inv_number,                         --    customer_trx_number,
                NULL,                      --    invoicing_rule,
                NULL,                       --    acnt_rule,
                NULL,                       --    rule_start_date,
                NULL,                      --    rule_end_date,
                NULL,                      --    attribute_category,
                NULL,                     --    attribute1,
                NULL,                      --    attribute2,
                NULL,                     --    attribute3,
                NULL,                       --    attribute4,
                NULL,                     --    attribute5,
                NULL,                    --    attribute6,
                NULL,                    --    attribute7,
                NULL,                    --    attribute8,
                NULL,                     --    attribute9,
                NULL,                    --    attribute10,
                'anonymous',                   --    created_by,
                SYSDATE,                   --    created_date,
                'anonymous',                   --    last_updated_by,
                SYSDATE,               --    last_update_date,
                SYSDATE,                 --LAST_UPDATE_LOGIN,
                NULL,                --    interface_error_msg,
                i.payment_term                   --    payment_terms
            );



            begin


            select BOOKING_DTL_ID into l_BOOKING_DTL_ID  from xxpm_booking_detail where BOOKING_HDR_ID =i.booking_id;

            select OFFER_DTL_ID into l_OFFER_DTL_ID from xxpm_offer_detail where OFFER_HDR_ID = i.offer_id; 

            select PROPERTY_NUMBER into l_PROPERTY_NUMBER from xxpm_property_master where PROPERTY_ID =i.PROPERTY_ID;

            select BUILD_NUMBER  into l_BUILD_NUMBER from xxpm_property_buildings where BUILD_ID =i.build_id ;

            select UNIT_NUMBER into l_UNIT_NUMBER from xxpm_property_units where unit_id  = i.unit_id;
            
            l_BOOKING_MS_ID:=xxpm_dm_lib_pkg.get_booking_ms_id(i.booking_number);
            IF l_BOOKING_MS_ID IS NULL THEN
            l_BOOKING_MS_ID  := NULL;
            END IF;
            
            exception when others 
            then

            dbms_output.put_line('Exception occurs while getting respective values  ');
            end;

        INSERT INTO xxpm_invoice_lines (
    invoice_id,
    invoice_line_id,
    line_number,
    description,
    uom_code,
    quantity,
    price,
    amount,
    tax_code,
    tax_perc,
    tax_amount,
    charge_type,
    rev_acnt_id,
    rev_acnt_code,
    offer_dtl_id,
    booking_dtl_id,
    property_id,
    property_number,
    build_id,
    build_number,
    unit_id,
    unit_number,
    billing_ms_id,
    installment_type,
    customer_trx_line_id,
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
    created_date,
    last_updated_by,
    last_update_date,
    last_update_login,
    line_amount,
    line_type
) VALUES (
    l_invoice_id,  -- invoice_id,
  xxpm_invoice_lines_s.NEXTVAL,  -- invoice_line_id,
    1,    -- line_number,
    i.installment_type_name,  -- description,
    i.uom_code,-- uom_code,
    i.quantity, -- quantity,
   i.price, -- price,
    i.line_amount, -- amount,
    i.tax_code, -- tax_code,
    i.tax_percenatge,-- tax_perc,
    i.tax_amount,-- tax_amount,
    i.charge_type, -- charge_type,
    NULL, -- rev_acnt_id,
    NULL, -- rev_acnt_code,
    l_offer_dtl_id, -- offer_dtl_id,
    l_booking_dtl_id, -- booking_dtl_id,
    i.property_id, -- property_id,
    l_property_number, -- property_number,
    i.build_id,-- build_id,
    l_build_number,  -- build_number,
    i.unit_id,-- unit_id,
    l_unit_number, -- unit_number,
    l_BOOKING_MS_ID, -- billing_ms_id,
    i.payment_milestone, -- installment_type,
    NULL, -- customer_trx_line_id,
    NULL, -- attribute_category,
    NULL, -- attribute1,
    NULL, -- attribute2,
    NULL, -- attribute3,
    NULL,  -- attribute4,
    NULL, -- attribute5,
    NULL,  -- attribute6,
    NULL,  -- attribute7,
    NULL,  -- attribute8,
    NULL,  -- attribute9,
    NULL,  -- attribute10,
    'anonymous',-- created_by,
    SYSDATE,-- created_date,
    'anonymous', -- last_updated_by,
    SYSDATE, -- last_update_date,
    'anonymous',-- last_update_login,
    i.line_amount,-- LINE_AMOUNT,
    'LINE'-- line_type
);

  UPDATE XXDM_SALES_INVOICES
    SET status_flag      ='P'
    WHERE booking_number = i.booking_number;
    EXCEPTION
    WHEN OTHERS THEN
        P_ERR_CODE := SQLCODE;
        P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);
        UPDATE XXDM_SALES_INVOICES set STATUS_FLAG='F',ERR_DESC=P_ERR_CODE || '-' || P_ERR_MSG
        WHERE booking_number = i.booking_number
        AND rowid  = i.rowid;
    END;
        END LOOP;
           commit;

    END sales_invoice_insert;

    FUNCTION get_function_id (
        p_func_short_code IN VARCHAR2
    ) RETURN NUMBER IS
        l_func_id NUMBER;
    BEGIN
        SELECT
            func_id
        INTO l_func_id
        FROM
            xxfnd_functions
        WHERE
            upper(func_short_code) = upper(p_func_short_code);

        RETURN l_func_id;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END get_function_id;

END xxdm_sale_invoices;
