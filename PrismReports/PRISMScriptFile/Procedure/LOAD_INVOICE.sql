--------------------------------------------------------
--  DDL for Procedure LOAD_INVOICE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "LOAD_INVOICE" (
    p_billing_id IN NUMBER,
    p_err_code OUT VARCHAR2,
    p_err_msg OUT VARCHAR2)
IS
  l_invoice_id         NUMBER;
  l_inv_func_id        NUMBER;
  l_invoice_number     VARCHAR2 (30);
  l_error_code         VARCHAR2 (100);
  l_error_msg          VARCHAR2 (2000);
  l_date               DATE;
  l_invoice_line_id    NUMBER;
  l_line_number        NUMBER;
  l_property_number    VARCHAR2 (30);
  l_installment_amount NUMBER;
  l_description        VARCHAR2 (50);
  l_instalment_type    VARCHAR2 (100);
  l_CHARGE_TYPE_flag   VARCHAR2 (2);
        g_invoice_code      VARCHAR2 (5)    := 'IN';
      g_currency_code     VARCHAR2 (5)    := 'AED';
      g_inv_hdr_status    VARCHAR2 (20)   := 'APR';
      g_inv_int_status    VARCHAR2 (20)   := 'READY_TO_INVOICE';
  CURSOR c_book_header
  IS
    SELECT usage
    FROM xxpm_booking_header
    WHERE booking_hdr_id IN
      (SELECT booking_hdr_id
      FROM xxpm_booking_milestones
      WHERE billing_id=p_billing_id
      );
  CURSOR c_sales (cp_billing_id NUMBER)
  IS
    SELECT xb.billing_date invoice_date,
      xb.org_id,
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
      xb.created_by,
      xb.last_updated_by,
      xb.last_update_login,
      xbm.uom,
      xbm.quantity,
      xbm.rate price,
      xbm.installment_amount amount,
      xbm.charge_type,
      xbh.property_id,
      xbm.installment_type,
      xbm.BOOKING_MS_DTL_ID,
      XBM.MILESTONE_TYPE
    FROM xxpm_billing xb,
      xxpm_booking_milestones xbm,
      xxpm_booking_header xbh,
      xxpm_booking_customer xbc,
      xxpm_ar_setup xar,
      xxpm_milestone_dtl xmd,
      xxpm_offer_header xoh
    WHERE xb.billing_id = xbm.billing_id
      --  AND xbm.source_func_ref_id = xbh.booking_hdr_id
    AND xbm.booking_hdr_id = xbh.booking_hdr_id
    AND xbh.booking_hdr_id = xbc.booking_hdr_id
    AND xbm.charge_type    = xar.charge_type(+)
    AND xb.org_id          = xar.business_unit_id(+)
    AND xbm.ms_dtl_id      = xmd.ms_dtl_id(+)
    AND xbh.offer_hdr_id   = xoh.offer_hdr_id
    AND xbc.primary_yn     = 'Y'
    AND xb.billing_id      = cp_billing_id;
  CURSOR c_notsales (cp_billing_id NUMBER)
  IS
    SELECT TRUNC(xb.billing_date) invoice_date,
      xb.org_id ,
      txn_source trx_source,
      txn_type trx_type,
      xbc.cust_id ,
      xbc.booking_cust_id,
      bill_to_site_id cust_site_id,
      --  xmd.payment_term ,
      --nvl(xbm.due_date,sysdate) due_date ,
      xoh.offer_hdr_id ,
      xoh.offer_number ,
      xbm.booking_hdr_id ,
      xbm.MILESTONE_TYPE,
      xbm.BOOKING_MS_DTL_ID,
      xbh.booking_number ,
      xb.created_by ,
      xb.last_updated_by ,
      xb.last_update_login ,
      -- xbm.uom ,
      --  xbm.quantity ,
      --  xbm.rate ,
      -- sum(xbm.installment_amount),
      xbm.charge_type ,
      xbh.property_id ,
      -- xbm.installment_type ,
      xbm.billing_id
    FROM xxpm_billing xb,
      xxpm_booking_milestones xbm,
      xxpm_booking_header xbh,
      xxpm_booking_customer xbc,
      xxpm_ar_setup xar,
      xxpm_milestone_dtl xmd,
      xxpm_offer_header xoh
    WHERE xb.billing_id = xbm.billing_id
      -- AND xbm.source_func_ref_id = xbh.booking_hdr_id
    AND xbm.booking_hdr_id = xbh.booking_hdr_id
    AND xbh.booking_hdr_id = xbc.booking_hdr_id
    AND xbm.charge_type    = xar.charge_type(+)
    AND xb.org_id          = xar.business_unit_id(+)
    AND xbm.ms_dtl_id      = xmd.ms_dtl_id(+)
    AND xbh.offer_hdr_id   = xoh.offer_hdr_id
    AND xbc.primary_yn     = 'Y'
    AND xbm.billing_id     = cp_billing_id
    GROUP BY TRUNC(xb.billing_date) ,
      xb.org_id ,
      txn_source ,
      txn_type ,
      xbc.cust_id ,
      xbc.booking_cust_id,
      bill_to_site_id ,
      xoh.offer_hdr_id ,
      xoh.offer_number ,
      xbm.booking_hdr_id ,
      xbh.booking_number ,
      xb.created_by ,
      xb.last_updated_by ,
      xb.last_update_login ,
      xbm.charge_type ,
      xbh.property_id ,
      xbm.billing_id;
  CURSOR c2 (cp_booking_hdr_id IN NUMBER)
  IS
    SELECT booking_dtl_id,
      tax_code,
      tax_rate tax_perc,
      tax_amount,
      xpd.building_id build_id,
      xpd.unit_id,
      build_number,
      unit_number,
      xpd.property_id,
      xpd.building_id
    FROM xxpm_booking_detail xpd,
      xxpm_property_buildings xpb,
      xxpm_property_master xpm,
      xxpm_property_units xpu
    WHERE xpd.property_id = xpm.property_id(+)
    AND xpb.property_id   = xpm.property_id(+)
    AND xpd.building_id   = xpb.build_id(+)
    AND xpd.unit_id       = xpu.unit_id(+)
    AND booking_hdr_id    = cp_booking_hdr_id
    AND ROWNUM            = 1;
BEGIN
  FOR c_bh IN c_book_header
  LOOP
    IF TO_CHAR(c_bh.usage) = 'S' THEN
      BEGIN
        FOR cr1 IN c_sales (p_billing_id)
        LOOP
          l_date        := SYSDATE;
          l_invoice_id  := xxpm_invoice_header_s.NEXTVAL;
          l_inv_func_id := get_function_id (g_invoice_code);
          DBMS_OUTPUT.PUT_LINE('Invoice ID ' || l_inv_func_id);
          xxfnd_pkg.get_next_number (p_func_code => g_invoice_code, p_next_num => l_invoice_number, p_func_id => l_inv_func_id, p_err_code => l_error_code, p_err_msg => l_error_msg );
          DBMS_OUTPUT.PUT_LINE('Next number:- ' || l_invoice_number || 'Function id:- ' ||l_inv_func_id);
          INSERT
          INTO xxpm_invoice_header
            (
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
              payment_terms,
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
              last_update_login
            )
            VALUES
            (
              l_invoice_id,
              l_invoice_number,
              cr1.invoice_date,
              l_inv_func_id,
              NULL,
              cr1.org_id,
              cr1.trx_source,
              cr1.trx_type,
              g_currency_code,
              NULL,
              cr1.cust_id,
              cr1.cust_site_id,
              cr1.payment_term,
              cr1.due_date,
              g_inv_hdr_status,
              g_inv_int_status,
              cr1.offer_id,
              cr1.offer_number,
              cr1.booking_id,
              cr1.booking_number,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              cr1.created_by,
              l_date,
              cr1.last_updated_by,
              l_date,
              cr1.last_update_login
            );
          l_line_number := 0;
          FOR cr2 IN c2
          (
            cr1.booking_id
          )
          LOOP
            l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
            l_line_number     := l_line_number + 1;
            
            IF cr1.MILESTONE_TYPE = 'MS'
            THEN
            BEGIN
              l_description := NULL;
              l_instalment_type  := cr1.installment_type;
               SELECT LOOKUP_VALUE_NAME_DISP
                             INTO l_description
              FROM xxfnd_lookup_v
              WHERE LOOKUP_TYPE_NAME ='MILESTONE_INSTALLMENT'
              AND LOOKUP_VALUE_NAME       = cr1.installment_type;
             
            EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('exception in getting the description ');
            END;
            ELSE
             l_description := cr1.installment_type;
             l_instalment_type := null;
                  
            END IF;
            INSERT
            INTO xxpm_invoice_lines
              (
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
                last_update_login
              )
              VALUES
              (
                l_invoice_id,
                l_invoice_line_id,
                l_line_number,
                l_description, --l_description
                'EACH',        --    cr1.uom,
                1,             --    cr1.quantity,
                cr1.price,
                cr1.amount,
                cr2.tax_code,
                cr2.tax_perc,
                cr2.tax_amount,
                cr1.charge_type,
                NULL,
                NULL,
                NULL,
                cr2.booking_dtl_id,
                cr1.property_id,
                l_property_number,
                cr2.build_id,
                cr2.build_number,
                cr2.unit_id,
                cr2.unit_number,
                p_billing_id,
                l_instalment_type,              --                cr1.installment_type,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                cr1.created_by,
                l_date,
                cr1.last_updated_by,
                l_date,
                cr1.last_update_login
              );
          END LOOP;
          UPDATE xxpm_booking_milestones
          SET invoice_id          = l_invoice_id
          WHERE BOOKING_MS_DTL_ID = cr1.BOOKING_MS_DTL_ID;
        END LOOP;
        p_err_code := 'S';
        p_err_msg  := 'Success';
        COMMIT;
      EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        p_err_code := 'E';
        p_err_msg  := sqlerrm;
      END;
    ELSE
      DBMS_OUTPUT.PUT_LINE('USAGE IS NOT SALES');
      BEGIN
        FOR cr1 IN c_notsales (p_billing_id)
        LOOP
                  DBMS_OUTPUT.PUT_LINE('Invoice ID  c_notsales ');

          l_date        := SYSDATE;
          l_invoice_id  := xxpm_invoice_header_s.NEXTVAL;
          l_inv_func_id := get_function_id (g_invoice_code);
          l_CHARGE_TYPE_flag:= null;
          DBMS_OUTPUT.PUT_LINE('Invoice ID ' || l_inv_func_id);
          xxfnd_pkg.get_next_number (p_func_code => g_invoice_code, p_next_num => l_invoice_number, p_func_id => l_inv_func_id, p_err_code => l_error_code, p_err_msg => l_error_msg );
          SELECT SUM (installment_amount)
          INTO l_installment_amount
          FROM xxpm_booking_milestones
          WHERE billing_id=p_billing_id
          AND charge_type =cr1.charge_type;
          DBMS_OUTPUT.PUT_LINE('Next number:- ' || l_invoice_number || 'Function id:- ' ||l_inv_func_id);
          DBMS_OUTPUT.PUT_LINE('cr1.charge_type ' ||cr1.charge_type );
          
                    IF (cr1.charge_type IS NULL) THEN
                    DBMS_OUTPUT.PUT_LINE('inside if ');
                    if cr1.MILESTONE_TYPE ='Charge' or cr1.MILESTONE_TYPE ='Fix'    then
                                        DBMS_OUTPUT.PUT_LINE('inside update ');

                    update   XXPM_BOOKING_MILESTONES   set CHARGE_TYPE = 'FIX_OC' where BOOKING_MS_DTL_ID =cr1.BOOKING_MS_DTL_ID;
                    COMMIT;
                    l_CHARGE_TYPE_flag := 'Y';
                    end if;
                    end if;
          
          
          
          
          IF (cr1.charge_type IS NOT NULL) or (l_CHARGE_TYPE_flag is not null) THEN
                              DBMS_OUTPUT.PUT_LINE('insert  if ');

            INSERT
            INTO xxpm_invoice_header
              (
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
                payment_terms,
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
                last_update_login
              )
              VALUES
              (
                l_invoice_id,
                l_invoice_number,
                cr1.invoice_date,
                l_inv_func_id,
                NULL,
                cr1.org_id,
                cr1.trx_source,
                cr1.trx_type,
                g_currency_code,
                NULL,
                cr1.cust_id,
                cr1.cust_site_id,
                'IMMEDIATE',
                sysdate,
                g_inv_hdr_status,
                g_inv_int_status,
                cr1.offer_hdr_id,
                cr1.offer_number,
                cr1.booking_hdr_id,
                cr1.booking_number,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                cr1.created_by,
                l_date,
                cr1.last_updated_by,
                l_date,
                cr1.last_update_login
              );
            l_line_number := 0;
            FOR cr2 IN c2
            (
              cr1.booking_hdr_id
            )
            LOOP
              l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
              l_line_number     := l_line_number + 1;
              INSERT
              INTO xxpm_invoice_lines
                (
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
                  last_update_login
                )
                VALUES
                (
                  l_invoice_id,
                  l_invoice_line_id,
                  l_line_number,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  l_installment_amount,
                  cr2.tax_code,
                  cr2.tax_perc,
                  cr2.tax_amount,
                  cr1.charge_type,
                  NULL,
                  NULL,
                  NULL,
                  cr2.booking_dtl_id,
                  cr1.property_id,
                  l_property_number,
                  cr2.build_id,
                  cr2.build_number,
                  cr2.unit_id,
                  cr2.unit_number,
                  p_billing_id,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  cr1.created_by,
                  l_date,
                  cr1.last_updated_by,
                  l_date,
                  cr1.last_update_login
                );
            END LOOP;
          ELSE
            DBMS_OUTPUT.PUT_LINE('CHARGE TYPE IS NULL FOR THE MENTIONED BILLING ID');
          END IF;
          UPDATE xxpm_booking_milestones
          SET invoice_id       = l_invoice_id
          WHERE BOOKING_HDR_ID = cr1.booking_hdr_id
          AND charge_type      =cr1.charge_type
          AND billing_id       =p_billing_id;
        END LOOP;
        p_err_code := 'S';
        p_err_msg  := 'Success';
        COMMIT;
      EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        p_err_code := 'E';
        p_err_msg  := 'ERROR MESSAGE';
      END;
    END IF;
  END LOOP;
  p_err_code := 'S';
  p_err_msg  := 'Success';
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  ROLLBACK;
  p_err_code := 'E';
  p_err_msg  := 'ERROR MESSAGE';
END load_invoice;
