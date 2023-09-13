CREATE OR REPLACE package xxpm_bill_invoice_pkg
is
PRAGMA SERIALLY_REUSABLE;
      g_invoice_code      VARCHAR2 (5)    := 'IN';
      G_CURRENCY_CODE     VARCHAR2 (5)    := 'AED';
      g_inv_hdr_status    VARCHAR2 (20)   := 'APR';
      g_inv_int_status    VARCHAR2 (20)   := 'ERROR';
--      g_inv_int_status    VARCHAR2 (20)   := 'READY_TO_INVOICE';

   FUNCTION get_function_id (p_func_short_code IN VARCHAR2)
      RETURN NUMBER;      
   PROCEDURE load_invoice (p_billing_id IN NUMBER,
                          p_err_code      OUT varchar2,
                          P_ERR_MSG       OUT varchar2);
   procedure XXPM_CREATE_INVOICE_TXN(P_CHARGE_TYPE in varchar2 ,P_BOOK_REF_ID  in number , P_TRANS_REF_ID in number);

   PROCEDURE GET_INV_NUMBER(P_BOOKING_HDR_ID IN NUMBER,P_INV_NUMBER OUT VARCHAR2);

--   procedure sublease_invoice(p_billing_id IN NUMBER);

PROCEDURE ms_based_invoice (p_billing_id    IN NUMBER,
                            p_err_code      OUT varchar2,
                            P_ERR_MSG       OUT varchar2);
end xxpm_bill_invoice_pkg;
/


CREATE OR REPLACE PACKAGE BODY         xxpm_bill_invoice_pkg
IS
   PRAGMA SERIALLY_REUSABLE;

   FUNCTION get_function_id (p_func_short_code IN VARCHAR2)
      RETURN NUMBER
   IS
      l_func_id      NUMBER;
   BEGIN
      SELECT func_id
        INTO l_func_id
        FROM xxfnd_functions
       WHERE UPPER (func_short_code) = UPPER (p_func_short_code);

      RETURN l_func_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_function_id;

   PROCEDURE load_invoice (p_billing_id   IN     NUMBER
                          ,p_err_code        OUT VARCHAR2
                          ,p_err_msg         OUT VARCHAR2)
   IS
      l_invoice_id   NUMBER;
      l_inv_func_id  NUMBER;
      l_invoice_number VARCHAR2 (30);
      l_inv_number   VARCHAR2 (30);
      l_error_code   VARCHAR2 (100);
      l_error_msg    VARCHAR2 (2000);
      l_date         DATE;
      l_invoice_line_id NUMBER;
      l_line_number  NUMBER;
      l_property_number VARCHAR2 (30);
      l_installment_amount NUMBER;
      l_description  VARCHAR2 (50);
      l_instalment_type VARCHAR2 (100);
      l_charge_type_flag VARCHAR2 (10);
      l_tot_amt      NUMBER;
      l_line_amount  NUMBER;
      l_tax_amount   NUMBER;
      l_prefix       VARCHAR2 (10);
      l_seq_no       NUMBER;
      l_proj_id      NUMBER;
      l_term_id      NUMBER;



      CURSOR c_book_header
      IS
         SELECT usage
           FROM xxpm_booking_header
          WHERE booking_hdr_id IN (SELECT booking_hdr_id
                                     FROM xxpm_booking_milestones
                                    WHERE billing_id = p_billing_id);


      CURSOR c_sales (cp_billing_id NUMBER)
      IS
         SELECT xb.billing_date invoice_date
               ,xb.org_id
               ,txn_source trx_source
               ,txn_type trx_type
               ,xbc.cust_id cust_id
               ,bill_to_site_id cust_site_id
               ,xbm.payment_term
               ,NVL (xbm.due_date, SYSDATE) due_date
               ,xoh.offer_hdr_id offer_id
               ,xoh.offer_number
               ,xbh.booking_hdr_id booking_id
               ,xbh.booking_number
               ,xbh.usage usage
               ,xb.created_by
               ,xb.last_updated_by
               ,xb.last_update_login
               ,xbm.uom
               ,xbm.quantity
               ,xbm.rate price
               ,NVL (xbm.installment_amount, 0) amount
               ,xbm.charge_type
               ,xbh.property_id
               ,xbm.installment_type
               ,xbm.booking_ms_dtl_id
               ,xbm.milestone_type
               ,xbm.installment_pct
               ,NVL (xbm.tax_amount, 0) tax_amount
               ,xbm.invoice_id
               ,xbm.TAX_RATE
               , xbm.TAX_CODE
           FROM xxpm_billing xb
               ,xxpm_booking_milestones xbm
               ,xxpm_booking_header xbh
               ,xxpm_booking_customer xbc
               ,xxpm_ar_setup xar
               ,xxpm_milestone_dtl xmd
               ,xxpm_offer_header xoh
          WHERE     xb.billing_id = xbm.billing_id
                --  AND xbm.source_func_ref_id = xbh.booking_hdr_id
                AND xbm.booking_hdr_id = xbh.booking_hdr_id
                AND xbh.booking_hdr_id = xbc.booking_hdr_id
                AND xbm.charge_type = xar.charge_type(+)
                AND xar.usage = xbh.usage
                AND xb.org_id = xar.business_unit_id(+)
                AND xbm.ms_dtl_id = xmd.ms_dtl_id(+)
                AND xbh.offer_hdr_id = xoh.offer_hdr_id
                AND xbc.primary_yn = 'Y'
                AND xb.billing_id = cp_billing_id;

      --
      --    cursor cur_upd_ms
      --    is
      --    SELECT MILESTONE_TYPE,CHARGE_TYPE,billing_id,BOOKING_MS_DTL_ID from xxpm_booking_milestones
      --
      --        where  billing_id     = p_billing_id;



      CURSOR c_notsales (cp_billing_id NUMBER)
      IS
           SELECT TRUNC (xb.billing_date) invoice_date
                 ,xb.org_id
                 ,txn_source trx_source
                 ,txn_type trx_type
                 ,xbc.cust_id
                 ,xbc.booking_cust_id
                 ,bill_to_site_id cust_site_id
                 ,xbm.payment_term
                 ,xoh.offer_hdr_id
                 ,xoh.offer_number
                 ,xbm.booking_hdr_id
                 ,xbh.booking_number
                 ,xb.created_by
                 ,xb.last_updated_by
                 ,xb.last_update_login
                 ,xar.accounting_rule_name
                 ,xar.invoicing_rule
                 ,xbh.booking_from_date
                 ,xbh.booking_to_date
                 ,xbm.charge_type
                 ,xbh.property_id
                 ,xbm.billing_id
                 ,xbm.installment_pct
                 ,xbm.milestone_type
             FROM xxpm_billing xb
                 ,xxpm_booking_milestones xbm
                 ,xxpm_booking_header xbh
                 ,xxpm_booking_customer xbc
                 ,xxpm_ar_setup xar
                 ,xxpm_milestone_dtl xmd
                 ,xxpm_offer_header xoh
            WHERE     xb.billing_id = xbm.billing_id
                  -- AND xbm.source_func_ref_id = xbh.booking_hdr_id
                  AND xbm.booking_hdr_id = xbh.booking_hdr_id
                  AND xbh.booking_hdr_id = xbc.booking_hdr_id
                  AND xbm.charge_type = xar.charge_type(+)
                  AND xar.usage = DECODE (xbh.usage, 'SL', 'L', 'L')
                  AND xb.org_id = xar.business_unit_id(+)
                  AND xbm.ms_dtl_id = xmd.ms_dtl_id(+)
                  AND xbh.offer_hdr_id = xoh.offer_hdr_id
                  AND xbc.primary_yn = 'Y'
                  AND xbm.billing_id = cp_billing_id
         GROUP BY TRUNC (xb.billing_date)
                 ,xb.org_id
                 ,txn_source
                 ,txn_type
                 ,xbc.cust_id
                 ,xbc.booking_cust_id
                 ,bill_to_site_id
                 ,xbm.payment_term
                 ,xoh.offer_hdr_id
                 ,xoh.offer_number
                 ,xbm.booking_hdr_id
                 ,xbh.booking_number
                 ,xb.created_by
                 ,xb.last_updated_by
                 ,xb.last_update_login
                 ,xar.accounting_rule_name
                 ,xar.invoicing_rule
                 ,xbh.booking_from_date
                 ,xbh.booking_to_date
                 ,xbm.charge_type
                 ,xbh.property_id
                 ,xbm.billing_id
                 ,xbm.installment_pct
                 ,xbm.milestone_type;

      CURSOR c2 (cp_booking_hdr_id IN NUMBER)
      IS
         SELECT booking_dtl_id
               ,tax_code
               ,tax_rate tax_perc
               ,tax_amount
               ,xpd.building_id build_id
               ,xpd.unit_id
               ,build_number
               ,unit_number
               ,xpd.property_id
               ,xpd.building_id
               ,xpd.booking_amount
               ,xpd.disc_pct
           FROM xxpm_booking_detail xpd
               ,xxpm_property_buildings xpb
               ,xxpm_property_master xpm
               ,xxpm_property_units xpu
          WHERE     xpd.property_id = xpm.property_id(+)
                AND xpb.property_id = xpm.property_id(+)
                AND xpd.building_id = xpb.build_id(+)
                AND xpd.unit_id = xpu.unit_id(+)
                AND booking_hdr_id = cp_booking_hdr_id
                AND ROWNUM = 1;
   BEGIN
      SELECT term_id
        INTO l_term_id
        FROM xxstg_pay_terms
       WHERE term_name = 'IMMEDIATE';

      FOR c_bh IN c_book_header
      LOOP
         IF TO_CHAR (c_bh.usage) = 'S'
         THEN
            BEGIN
               FOR cr1 IN c_sales (p_billing_id)
               LOOP
                  IF cr1.invoice_id IS NOT NULL
                  THEN
                     UPDATE xxpm_invoice_header
--                        SET interface_status = 'READY_TO_INVOICE'
                                              SET interface_status = 'ERROR'
                      WHERE invoice_id = cr1.invoice_id;
                  ELSE
                     DBMS_OUTPUT.put_line ('entry Invoice ID ');


                     l_date      := SYSDATE;
                     l_invoice_id := xxpm_invoice_header_s.NEXTVAL;
                     l_inv_func_id := get_function_id (g_invoice_code);
                     DBMS_OUTPUT.put_line (
                        'l_inv_func_id ID   ' || l_inv_func_id);
                     xxfnd_pkg.get_next_number (p_func_code => g_invoice_code
                                               ,p_next_num  => l_inv_number
                                               ,p_func_id   => l_inv_func_id
                                               ,p_err_code  => l_error_code
                                               ,p_err_msg   => l_error_msg);
                     DBMS_OUTPUT.put_line (
                           'Next number:- '
                        || l_inv_number
                        || 'Function id:- '
                        || l_inv_func_id);
                     DBMS_OUTPUT.put_line ('exit  Invoice ID ...');

                     get_inv_number (cr1.booking_id, l_invoice_number);
                     DBMS_OUTPUT.put_line (
                        'l_invoice_number ...' || l_invoice_number);


                     --
                     --    begin
                     --
                     --        SELECT
                     --        xp.INV_PREFIX ,xp.SEQ_NO, xp.PROJ_ID  into l_prefix  ,l_seq_no ,l_PROJ_ID
                     --    FROM xxpm_booking_header xbh,
                     --    xxpm_property_master xpm,
                     --    xxstg_projects xp
                     --    where  xbh.property_id =xpm.property_id
                     --    and xpm.PROJECT_ID   =xp.PROJ_ID
                     --    and xbh.booking_hdr_id =cr1.booking_id;
                     --
                     --l_invoice_number := l_prefix ||'-'||l_seq_no;
                     --
                     --l_seq_no := l_seq_no+1 ;
                     --
                     --update  xxstg_projects set SEQ_NO = l_seq_no where PROJ_ID =l_PROJ_ID;
                     --
                     --    -- due to db link commit;
                     --
                     --
                     --    end ;



                     INSERT INTO xxpm_invoice_header (invoice_id
                                                     ,invoice_number
                                                     ,invoice_date
                                                     ,func_id
                                                     ,invoice_class
                                                     ,org_id
                                                     ,trx_source
                                                     ,trx_type
                                                     ,currency_code
                                                     ,exchange_rate
                                                     ,cust_id
                                                     ,cust_site_id
                                                     ,payment_terms
                                                     ,due_date
                                                     ,status
                                                     ,interface_status
                                                     ,offer_id
                                                     ,offer_number
                                                     ,booking_id
                                                     ,booking_number
                                                     ,sale_lease_number
                                                     ,customer_trx_id
                                                     ,customer_trx_number
                                                     ,invoicing_rule
                                                     ,acnt_rule
                                                     ,rule_start_date
                                                     ,rule_end_date
                                                     ,attribute_category
                                                     ,attribute1
                                                     ,attribute2
                                                     ,attribute3
                                                     ,attribute4
                                                     ,attribute5
                                                     ,attribute6
                                                     ,attribute7
                                                     ,attribute8
                                                     ,attribute9
                                                     ,attribute10
                                                     ,created_by
                                                     ,created_date
                                                     ,last_updated_by
                                                     ,last_update_date
                                                     ,last_update_login --              ,
                                                                       --              INVOICE_TYPE
                                                      )
                          VALUES (l_invoice_id
                                 ,l_invoice_number
                                 ,cr1.invoice_date
                                 ,l_inv_func_id
                                 ,NULL
                                 ,cr1.org_id
                                 ,cr1.trx_source
                                 ,cr1.trx_type
                                 ,g_currency_code
                                 ,NULL
                                 ,cr1.cust_id
                                 ,cr1.cust_site_id
                                 ,NVL (cr1.payment_term, l_term_id)
                                 ,cr1.due_date
                                 ,g_inv_hdr_status
                                 ,g_inv_int_status
                                 ,cr1.offer_id
                                 ,cr1.offer_number
                                 ,cr1.booking_id
                                 ,cr1.booking_number
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,                            --invoicing_rule
                                  NULL
                                 ,                                 --acnt_rule
                                  NULL
                                 ,                           --RULE_START_DATE
                                  NULL
                                 ,                             --rule_end_date
                                  NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,cr1.created_by
                                 ,l_date
                                 ,cr1.last_updated_by
                                 ,l_date
                                 ,cr1.last_update_login      --              ,
                                                       --              'AR'
                                  );

                     DBMS_OUTPUT.put_line ('l_invoice ' || l_invoice_id);

                     l_line_number := 0;

                     FOR cr2 IN c2 (cr1.booking_id)
                     LOOP
                        l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
                        l_line_number :=
                             l_line_number
                           + 1;


                        l_instalment_type := cr1.installment_type;

                        IF l_instalment_type IS NOT NULL
                        THEN
                           IF cr1.milestone_type = 'MS'
                           THEN
                              BEGIN
                                 l_description := NULL;

                                 SELECT lookup_value_name_disp
                                   INTO l_description
                                   FROM xxfnd_lookup_v
                                  WHERE     lookup_type_name =
                                               'MILESTONE_INSTALLMENT'
                                        AND lookup_value_name =
                                               cr1.installment_type;
                              EXCEPTION
                                 WHEN OTHERS
                                 THEN
                                    DBMS_OUTPUT.put_line (
                                       'exception in getting the description ');
                              END;
                           ELSE
                              l_description := cr1.installment_type;
                              l_instalment_type := NULL;
                           END IF;
                        ELSE
                           l_description := 'From Prism';
                        END IF;


                        IF cr1.milestone_type = 'MS'
                        THEN
                           l_tot_amt   :=
                                (  cr2.booking_amount
                                 * NVL (cr1.installment_pct, 0))
                              / 100;
                           --Dinesh commented  03-10-2019
                           /*l_line_amount :=
                                l_tot_amt
                              -   (  l_tot_amt
                                   * NVL (cr2.disc_pct, 0))
                                / 100;
                           l_tax_amount :=
                                l_tot_amt
                              * NVL (cr2.tax_perc, 0)
                              / 100;*/

                           --Dinesh added 03-10-2019
--                           l_tax_amount := NVL(cr1.tax_amount,0);
                           l_tax_amount :=l_tot_amt*nvl(cr2.tax_perc,0) /100;
                           l_line_amount :=
                                NVL(cr1.amount,0)
                              - l_tax_amount;
                        ELSE
                           l_tax_amount := NVL(cr1.tax_amount,0);

                           l_line_amount :=
                                NVL(cr1.amount,0)
                              - l_tax_amount;
                        END IF;

                        DBMS_OUTPUT.put_line ('l_tot_amt   ' || l_tot_amt);
                        DBMS_OUTPUT.put_line (
                           'l_line_amount   ' || l_line_amount);

                        DBMS_OUTPUT.put_line (
                           'l_tax_amount   ' || l_tax_amount);


                        INSERT INTO xxpm_invoice_lines (invoice_id
                                                       ,invoice_line_id
                                                       ,line_number
                                                       ,description
                                                       ,uom_code
                                                       ,quantity
                                                       ,price
                                                       ,amount
                                                       ,tax_code
                                                       ,tax_perc
                                                       ,tax_amount
                                                       ,charge_type
                                                       ,rev_acnt_id
                                                       ,rev_acnt_code
                                                       ,offer_dtl_id
                                                       ,booking_dtl_id
                                                       ,property_id
                                                       ,property_number
                                                       ,build_id
                                                       ,build_number
                                                       ,unit_id
                                                       ,unit_number
                                                       ,billing_ms_id
                                                       ,installment_type
                                                       ,customer_trx_line_id
                                                       ,attribute_category
                                                       ,attribute1
                                                       ,attribute2
                                                       ,attribute3
                                                       ,attribute4
                                                       ,attribute5
                                                       ,attribute6
                                                       ,attribute7
                                                       ,attribute8
                                                       ,attribute9
                                                       ,attribute10
                                                       ,created_by
                                                       ,created_date
                                                       ,last_updated_by
                                                       ,last_update_date
                                                       ,last_update_login
                                                       ,line_amount
                                                       ,line_type)
                             VALUES (l_invoice_id
                                    ,l_invoice_line_id
                                    ,l_line_number
                                    ,l_description
                                    ,                          --l_description
                                     'EACH'
                                    ,                           --    cr1.uom,
                                     1
                                    ,                      --    cr1.quantity,
                                     cr1.price
                                    ,l_line_amount
                                    ,            --                cr1.amount,
                                     NULL
                                    ,          --                cr2.tax_code,
                                     NULL
                                    ,          --                cr2.tax_perc,
                                     NULL
                                    ,        --                cr2.tax_amount,
                                     cr1.charge_type
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr2.booking_dtl_id
                                    ,cr1.property_id
                                    ,l_property_number
                                    ,cr2.build_id
                                    ,cr2.build_number
                                    ,cr2.unit_id
                                    ,cr2.unit_number
                                    ,p_billing_id
                                    ,l_instalment_type
                                    ,  --                cr1.installment_type,
                                     NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr1.created_by
                                    ,l_date
                                    ,cr1.last_updated_by
                                    ,l_date
                                    ,cr1.last_update_login
                                    ,l_line_amount
                                    ,'LINE');

                        --            IF cr1.MILESTONE_TYPE = 'MS' then

                        DBMS_OUTPUT.put_line ('xxpm_invoice_lines,   ');

                        --              dbms_output.put_line(' ');
                        INSERT INTO xxpm_invoice_lines (invoice_id
                                                       ,invoice_line_id
                                                       ,line_number
                                                       ,description
                                                       ,uom_code
                                                       ,quantity
                                                       ,price
                                                       ,amount
                                                       ,tax_code
                                                       ,tax_perc
                                                       ,tax_amount
                                                       ,charge_type
                                                       ,rev_acnt_id
                                                       ,rev_acnt_code
                                                       ,offer_dtl_id
                                                       ,booking_dtl_id
                                                       ,property_id
                                                       ,property_number
                                                       ,build_id
                                                       ,build_number
                                                       ,unit_id
                                                       ,unit_number
                                                       ,billing_ms_id
                                                       ,installment_type
                                                       ,customer_trx_line_id
                                                       ,attribute_category
                                                       ,attribute1
                                                       ,attribute2
                                                       ,attribute3
                                                       ,attribute4
                                                       ,attribute5
                                                       ,attribute6
                                                       ,attribute7
                                                       ,attribute8
                                                       ,attribute9
                                                       ,attribute10
                                                       ,created_by
                                                       ,created_date
                                                       ,last_updated_by
                                                       ,last_update_date
                                                       ,last_update_login
                                                       ,line_amount
                                                       ,line_type)
                             VALUES (l_invoice_id
                                    ,xxpm_invoice_lines_s.NEXTVAL
                                    ,2
                                    ,                            --line_number
                                     l_description
                                    ,                          --l_description
                                     'EACH'
                                    ,                           --    cr1.uom,
                                     1
                                    ,                      --    cr1.quantity,
                                     cr1.price
                                    ,0
                                    ,            --                cr1.amount,
                                     nvl(cr1.tax_code, cr2.tax_code)
                                    ,nvl(cr1.tax_rate, cr2.tax_perc)
                                    -- Dinesh
                                    -- cr1-Booking Ms tax
                                    -- CR2-Booking Details
--                                     cr1.tax_code
--                                    ,cr1.tax_rate

                                    ,l_tax_amount
                                    ,        --                cr2.tax_amount,
                                     cr1.charge_type
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr2.booking_dtl_id
                                    ,cr1.property_id
                                    ,l_property_number
                                    ,cr2.build_id
                                    ,cr2.build_number
                                    ,cr2.unit_id
                                    ,cr2.unit_number
                                    ,p_billing_id
                                    ,l_instalment_type
                                    ,  --                cr1.installment_type,
                                     NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr1.created_by
                                    ,l_date
                                    ,cr1.last_updated_by
                                    ,l_date
                                    ,cr1.last_update_login
                                    ,l_tax_amount
                                    ,'TAX');



                        DBMS_OUTPUT.put_line ('inside loop lines if ms');

                        --              END IF;
                        DBMS_OUTPUT.put_line ('inside loop lines ms');
                     END LOOP;

                     UPDATE xxpm_booking_milestones
                        SET invoice_id   = l_invoice_id
                      WHERE booking_ms_dtl_id = cr1.booking_ms_dtl_id;

                     DBMS_OUTPUT.put_line ('update milestone ');
                  -- due to db link commit;

                  END IF;
               END LOOP;

               p_err_code  := 'S';
               p_err_msg   := 'Success';
            -- due to db link commit;
            EXCEPTION
               WHEN OTHERS
               THEN
                  ROLLBACK;
                  p_err_code  := 'E';
                  p_err_msg   := SQLERRM;
            END;
         ELSE
            DBMS_OUTPUT.put_line ('USAGE IS NOT SALES');

            BEGIN
               FOR cr1 IN c_notsales (p_billing_id)
               LOOP
                  l_date      := SYSDATE;
                  l_invoice_id := xxpm_invoice_header_s.NEXTVAL;
                  l_inv_func_id := get_function_id (g_invoice_code);
                  DBMS_OUTPUT.put_line ('Invoice ID ' || l_inv_func_id);
                  xxfnd_pkg.get_next_number (p_func_code => g_invoice_code
                                            ,p_next_num  => l_inv_number
                                            ,p_func_id   => l_inv_func_id
                                            ,p_err_code  => l_error_code
                                            ,p_err_msg   => l_error_msg);

                  get_inv_number (cr1.booking_hdr_id, l_invoice_number);
                  DBMS_OUTPUT.put_line (
                     'l_invoice_number ...' || l_invoice_number);



                  SELECT SUM (installment_amount)
                    INTO l_installment_amount
                    FROM xxpm_booking_milestones
                   WHERE     billing_id = p_billing_id
                         AND charge_type = cr1.charge_type;

                  DBMS_OUTPUT.put_line (
                        'Next number:- '
                     || l_invoice_number
                     || 'Function id:- '
                     || l_inv_func_id);
                  DBMS_OUTPUT.put_line (
                     'cr1.charge_type ' || cr1.charge_type);

                  IF (cr1.charge_type IS NOT NULL)
                  THEN
                     INSERT INTO xxpm_invoice_header (invoice_id
                                                     ,invoice_number
                                                     ,invoice_date
                                                     ,func_id
                                                     ,invoice_class
                                                     ,org_id
                                                     ,trx_source
                                                     ,trx_type
                                                     ,currency_code
                                                     ,exchange_rate
                                                     ,cust_id
                                                     ,cust_site_id
                                                     ,payment_terms
                                                     ,due_date
                                                     ,status
                                                     ,interface_status
                                                     ,offer_id
                                                     ,offer_number
                                                     ,booking_id
                                                     ,booking_number
                                                     ,sale_lease_number
                                                     ,customer_trx_id
                                                     ,customer_trx_number
                                                     ,invoicing_rule
                                                     ,acnt_rule
                                                     ,rule_start_date
                                                     ,rule_end_date
                                                     ,attribute_category
                                                     ,attribute1
                                                     ,attribute2
                                                     ,attribute3
                                                     ,attribute4
                                                     ,attribute5
                                                     ,attribute6
                                                     ,attribute7
                                                     ,attribute8
                                                     ,attribute9
                                                     ,attribute10
                                                     ,created_by
                                                     ,created_date
                                                     ,last_updated_by
                                                     ,last_update_date
                                                     ,last_update_login --                ,
                                                                       --                INVOICE_TYPE
                                                      )
                          VALUES (l_invoice_id
                                 ,l_invoice_number
                                 ,cr1.invoice_date
                                 ,l_inv_func_id
                                 ,NULL
                                 ,cr1.org_id
                                 ,cr1.trx_source
                                 ,cr1.trx_type
                                 ,g_currency_code
                                 ,NULL
                                 ,cr1.cust_id
                                 ,cr1.cust_site_id
                                 ,l_term_id
                                 , --                nvl(cr1.payment_term,l_term_id),
                                  SYSDATE
                                 ,g_inv_hdr_status
                                 ,g_inv_int_status
                                 ,cr1.offer_hdr_id
                                 ,cr1.offer_number
                                 ,cr1.booking_hdr_id
                                 ,cr1.booking_number
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,cr1.invoicing_rule
                                 ,                            --invoicing_rule
                                  cr1.accounting_rule_name
                                 ,                                 --acnt_rule
                                  cr1.booking_from_date
                                 ,                           --RULE_START_DATE
                                  cr1.booking_to_date
                                 ,                             --rule_end_date
                                  NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,cr1.created_by
                                 ,l_date
                                 ,cr1.last_updated_by
                                 ,l_date
                                 ,cr1.last_update_login    --                ,
                                                       --                'AR'
                                  );

                     l_line_number := 0;

                     FOR cr2 IN c2 (cr1.booking_hdr_id)
                     LOOP
                        l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
                        l_line_number :=
                             l_line_number
                           + 1;

                        IF cr1.milestone_type = 'MS'
                        THEN
                           l_tot_amt   :=
                                (  cr2.booking_amount
                                 * NVL (cr1.installment_pct, 0))
                              / 100;
                           l_line_amount :=
                                l_tot_amt
                              -   (  l_tot_amt
                                   * NVL (cr2.disc_pct, 0))
                                / 100;
                           l_tax_amount :=
                                l_tot_amt
                              * NVL (cr2.tax_perc, 0)
                              / 100;
                        ELSE
                           l_line_amount := l_installment_amount;
                        END IF;



                        --              l_installment_amount
                        INSERT INTO xxpm_invoice_lines (invoice_id
                                                       ,invoice_line_id
                                                       ,line_number
                                                       ,description
                                                       ,uom_code
                                                       ,quantity
                                                       ,price
                                                       ,amount
                                                       ,tax_code
                                                       ,tax_perc
                                                       ,tax_amount
                                                       ,charge_type
                                                       ,rev_acnt_id
                                                       ,rev_acnt_code
                                                       ,offer_dtl_id
                                                       ,booking_dtl_id
                                                       ,property_id
                                                       ,property_number
                                                       ,build_id
                                                       ,build_number
                                                       ,unit_id
                                                       ,unit_number
                                                       ,billing_ms_id
                                                       ,installment_type
                                                       ,customer_trx_line_id
                                                       ,attribute_category
                                                       ,attribute1
                                                       ,attribute2
                                                       ,attribute3
                                                       ,attribute4
                                                       ,attribute5
                                                       ,attribute6
                                                       ,attribute7
                                                       ,attribute8
                                                       ,attribute9
                                                       ,attribute10
                                                       ,created_by
                                                       ,created_date
                                                       ,last_updated_by
                                                       ,last_update_date
                                                       ,last_update_login
                                                       ,line_amount
                                                       ,line_type)
                             VALUES (l_invoice_id
                                    ,l_invoice_line_id
                                    ,1
                                    ,'FROM PRISM'
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,l_installment_amount
                                    , --                  l_installment_amount,
                                     NULL
                                    ,                         ---cr2.tax_code,
                                     NULL
                                    ,        --                  cr2.tax_perc,
                                     NULL
                                    ,      --                  cr2.tax_amount,
                                     cr1.charge_type
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr2.booking_dtl_id
                                    ,cr1.property_id
                                    ,l_property_number
                                    ,cr2.build_id
                                    ,cr2.build_number
                                    ,cr2.unit_id
                                    ,cr2.unit_number
                                    ,p_billing_id
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr1.created_by
                                    ,l_date
                                    ,cr1.last_updated_by
                                    ,l_date
                                    ,cr1.last_update_login
                                    ,l_line_amount
                                    ,'LINE');

                        --
                        IF cr1.milestone_type = 'MS'
                        THEN
                           INSERT
                             INTO xxpm_invoice_lines (invoice_id
                                                     ,invoice_line_id
                                                     ,line_number
                                                     ,description
                                                     ,uom_code
                                                     ,quantity
                                                     ,price
                                                     ,amount
                                                     ,tax_code
                                                     ,tax_perc
                                                     ,tax_amount
                                                     ,charge_type
                                                     ,rev_acnt_id
                                                     ,rev_acnt_code
                                                     ,offer_dtl_id
                                                     ,booking_dtl_id
                                                     ,property_id
                                                     ,property_number
                                                     ,build_id
                                                     ,build_number
                                                     ,unit_id
                                                     ,unit_number
                                                     ,billing_ms_id
                                                     ,installment_type
                                                     ,customer_trx_line_id
                                                     ,attribute_category
                                                     ,attribute1
                                                     ,attribute2
                                                     ,attribute3
                                                     ,attribute4
                                                     ,attribute5
                                                     ,attribute6
                                                     ,attribute7
                                                     ,attribute8
                                                     ,attribute9
                                                     ,attribute10
                                                     ,created_by
                                                     ,created_date
                                                     ,last_updated_by
                                                     ,last_update_date
                                                     ,last_update_login
                                                     ,line_amount
                                                     ,line_type)
                           VALUES (l_invoice_id
                                  ,xxpm_invoice_lines_s.NEXTVAL
                                  ,2
                                  ,'FROM PRISM'
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,  --                  l_installment_amount,
                                   cr2.tax_code
                                  ,cr2.tax_perc
                                  ,l_tax_amount
                                  ,        --                  cr2.tax_amount,
                                   cr1.charge_type
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,cr2.booking_dtl_id
                                  ,cr1.property_id
                                  ,l_property_number
                                  ,cr2.build_id
                                  ,cr2.build_number
                                  ,cr2.unit_id
                                  ,cr2.unit_number
                                  ,p_billing_id
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,NULL
                                  ,cr1.created_by
                                  ,l_date
                                  ,cr1.last_updated_by
                                  ,l_date
                                  ,cr1.last_update_login
                                  ,l_tax_amount
                                  ,'TAX');
                        END IF;
                     END LOOP;
                  ELSE
                     DBMS_OUTPUT.put_line (
                        'CHARGE TYPE IS NULL FOR THE MENTIONED BILLING ID');
                  END IF;

                  UPDATE xxpm_booking_milestones
                     SET invoice_id   = l_invoice_id
                   WHERE     booking_hdr_id = cr1.booking_hdr_id
                         AND charge_type = cr1.charge_type
                         AND billing_id = p_billing_id;
               END LOOP;

               --          IF TO_CHAR(c_bh.usage) = 'SL' THEN
               --        sublease_invoice(p_billing_id);
               --
               --        end if;

               p_err_code  := 'S';
               p_err_msg   := 'Success';
            -- due to db link commit;
            EXCEPTION
               WHEN OTHERS
               THEN
                  ROLLBACK;
                  p_err_code  := 'E';
                  p_err_msg   := 'ERROR MESSAGE';
            END;
         END IF;
      END LOOP;

      p_err_code  := 'S';
      p_err_msg   := 'Success';
   -- due to db link commit;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_err_code  := 'E';
         p_err_msg   := 'ERROR MESSAGE';
   END load_invoice;

   PROCEDURE xxpm_create_invoice_txn (p_charge_type  IN VARCHAR2
                                     ,p_book_ref_id  IN NUMBER
                                     ,p_trans_ref_id IN NUMBER)
   IS
      CURSOR cur_invoice_header
      IS
         SELECT xbh.org_id
               ,txn_source trx_source
               ,txn_type trx_type
               ,xar.accounting_rule_name
               ,xar.invoicing_rule
               ,xbh.booking_from_date
               ,xbh.booking_to_date
               ,xbc.cust_id cust_id
               ,bill_to_site_id cust_site_id
               ,xbm.payment_term
               ,                   --      NVL(xbm.due_date,sysdate) due_date,
                xoh.offer_hdr_id offer_id
               ,xoh.offer_number
               ,xbh.booking_hdr_id booking_id
               ,xbh.booking_number
               ,xbh.usage usage
               ,xbm.uom
               ,xbm.quantity
               ,xbm.rate price
               ,xbm.installment_amount amount
               ,xbm.charge_type
               ,xbh.property_id
               ,xbm.installment_type
               ,xbm.booking_ms_dtl_id
               ,xbm.milestone_type
           FROM xxpm_booking_milestones xbm
               ,xxpm_booking_header xbh
               ,xxpm_booking_customer xbc
               ,xxpm_ar_setup xar
               ,                               --      xxpm_milestone_dtl xmd,
                xxpm_offer_header xoh
          WHERE     xbm.booking_hdr_id = xbh.booking_hdr_id
                AND xbh.booking_hdr_id = xbc.booking_hdr_id
                AND xbm.charge_type = xar.charge_type(+)
                AND xbh.org_id = xar.business_unit_id
                --    AND xbm.ms_dtl_id          = xmd.ms_dtl_id(+)
                AND xbh.offer_hdr_id = xoh.offer_hdr_id
                AND xbh.usage = xar.usage
                AND xbc.primary_yn = 'Y'
                AND xbm.booking_hdr_id = p_book_ref_id
                AND xbm.source_func_ref_id = p_trans_ref_id
                AND xbm.charge_type = p_charge_type;

      CURSOR cur_invoice_line (cp_booking_hdr_id IN NUMBER)
      IS
         SELECT booking_dtl_id
               ,tax_code
               ,tax_rate tax_perc
               ,tax_amount
               ,xpd.building_id build_id
               ,xpd.unit_id
               ,build_number
               ,unit_number
               ,xpd.property_id
               ,xpd.building_id
               ,xpm.property_number
           FROM xxpm_booking_detail xpd
               ,xxpm_property_buildings xpb
               ,xxpm_property_master xpm
               ,xxpm_property_units xpu
          WHERE     xpd.property_id = xpm.property_id(+)
                AND xpb.property_id = xpm.property_id(+)
                AND xpd.building_id = xpb.build_id(+)
                AND xpd.unit_id = xpu.unit_id(+)
                AND booking_hdr_id = cp_booking_hdr_id;

      l_invoice_id   NUMBER;
      l_inv_func_id  NUMBER;
      l_invoice_number VARCHAR2 (30);
      l_error_code   VARCHAR2 (100);
      l_error_msg    VARCHAR2 (2000);
      l_date         DATE;
      l_invoice_line_id NUMBER;
      l_line_number  NUMBER;
      l_description  VARCHAR2 (100);
      l_instalment_type VARCHAR2 (100);
      l_invoicing_rule VARCHAR2 (100);
      l_acnt_rule    VARCHAR2 (100);
      l_rule_start_date DATE;
      l_rule_end_date DATE;
      l_due_date     DATE;
      l_term_id      NUMBER;
   BEGIN
      SELECT term_id
        INTO l_term_id
        FROM xxstg_pay_terms
       WHERE term_name = 'IMMEDIATE';

      FOR i IN cur_invoice_header
      LOOP
         IF TO_CHAR (i.usage) = 'L'
         THEN
            l_invoicing_rule := i.invoicing_rule;
            l_acnt_rule := i.accounting_rule_name;
            l_rule_start_date := i.booking_from_date;
            l_rule_end_date := i.booking_to_date;
         ELSE
            DBMS_OUTPUT.put_line ('sales ID  ');

            l_invoicing_rule := NULL;
            l_acnt_rule := NULL;
            l_rule_start_date := NULL;
            l_rule_end_date := NULL;
         END IF;

         DBMS_OUTPUT.put_line ('sales ID  ');

         l_date      := SYSDATE;
         l_invoice_id := xxpm_invoice_header_s.NEXTVAL;
         l_inv_func_id := get_function_id (g_invoice_code);
         DBMS_OUTPUT.put_line ('Invoice ID ' || l_inv_func_id);
         xxfnd_pkg.get_next_number (p_func_code => g_invoice_code
                                   ,p_next_num  => l_invoice_number
                                   ,p_func_id   => l_inv_func_id
                                   ,p_err_code  => l_error_code
                                   ,p_err_msg   => l_error_msg);
         DBMS_OUTPUT.put_line (
               'Next number:- '
            || l_invoice_number
            || 'Function id:- '
            || l_inv_func_id);

         BEGIN
            SELECT   SYSDATE
                   + NVL (term_days, 0)
              INTO l_due_date
              FROM xxstg_pay_terms
             WHERE term_id = i.payment_term;

            DBMS_OUTPUT.put_line ('L_DUE_DATE ID  ' || l_due_date);
         EXCEPTION
            WHEN OTHERS
            THEN
               DBMS_OUTPUT.put_line (' error in getting due date');
         END;

         INSERT INTO xxpm_invoice_header (invoice_id
                                         ,invoice_number
                                         ,invoice_date
                                         ,func_id
                                         ,invoice_class
                                         ,org_id
                                         ,trx_source
                                         ,trx_type
                                         ,currency_code
                                         ,exchange_rate
                                         ,cust_id
                                         ,cust_site_id
                                         ,payment_terms
                                         ,due_date
                                         ,status
                                         ,interface_status
                                         ,offer_id
                                         ,offer_number
                                         ,booking_id
                                         ,booking_number
                                         ,sale_lease_number
                                         ,customer_trx_id
                                         ,customer_trx_number
                                         ,invoicing_rule
                                         ,acnt_rule
                                         ,rule_start_date
                                         ,rule_end_date
                                         ,attribute_category
                                         ,attribute1
                                         ,attribute2
                                         ,attribute3
                                         ,attribute4
                                         ,attribute5
                                         ,attribute6
                                         ,attribute7
                                         ,attribute8
                                         ,attribute9
                                         ,attribute10
                                         ,created_by
                                         ,created_date
                                         ,last_updated_by
                                         ,last_update_date
                                         ,last_update_login)
              VALUES (l_invoice_id
                     ,l_invoice_number
                     ,SYSDATE
                     ,                                          --invoice_date
                      l_inv_func_id
                     ,NULL
                     ,i.org_id
                     ,i.trx_source
                     ,i.trx_type
                     ,g_currency_code
                     ,NULL
                     ,i.cust_id
                     ,i.cust_site_id
                     ,NVL (i.payment_term, l_term_id)
                     ,l_due_date
                     ,g_inv_hdr_status
                     ,g_inv_int_status
                     ,i.offer_id
                     ,i.offer_number
                     ,i.booking_id
                     ,i.booking_number
                     ,NULL
                     ,NULL
                     ,NULL
                     ,l_invoicing_rule
                     ,                                        --invoicing_rule
                      l_acnt_rule
                     ,                                             --acnt_rule
                      l_rule_start_date
                     ,                                       --RULE_START_DATE
                      l_rule_end_date
                     ,                                         --rule_end_date
                      NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,NULL
                     ,                                         --i.created_by,
                      l_date
                     ,NULL
                     ,                                    --i.last_updated_by,
                      l_date
                     ,NULL                               --i.last_update_login
                          );

         l_line_number := 0;

         FOR j IN cur_invoice_line (i.booking_id)
         LOOP
            l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
            l_line_number :=
                 l_line_number
               + 1;

            IF i.charge_type IS NOT NULL
            THEN
               BEGIN
                  SELECT 'For ' || lookup_value_name_disp
                    INTO l_description
                    FROM xxfnd_lookup_v
                   WHERE     lookup_type_name = 'CHARGE_TYPE'
                         AND lookup_value_name = i.charge_type;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     DBMS_OUTPUT.put_line (
                        'exception in getting the description ');
               END;
            ELSE
               l_description := i.installment_type;
               l_instalment_type := NULL;
            END IF;

            INSERT INTO xxpm_invoice_lines (invoice_id
                                           ,invoice_line_id
                                           ,line_number
                                           ,description
                                           ,uom_code
                                           ,quantity
                                           ,price
                                           ,amount
                                           ,tax_code
                                           ,tax_perc
                                           ,tax_amount
                                           ,charge_type
                                           ,rev_acnt_id
                                           ,rev_acnt_code
                                           ,offer_dtl_id
                                           ,booking_dtl_id
                                           ,property_id
                                           ,property_number
                                           ,build_id
                                           ,build_number
                                           ,unit_id
                                           ,unit_number
                                           ,billing_ms_id
                                           ,installment_type
                                           ,customer_trx_line_id
                                           ,attribute_category
                                           ,attribute1
                                           ,attribute2
                                           ,attribute3
                                           ,attribute4
                                           ,attribute5
                                           ,attribute6
                                           ,attribute7
                                           ,attribute8
                                           ,attribute9
                                           ,attribute10
                                           ,created_by
                                           ,created_date
                                           ,last_updated_by
                                           ,last_update_date
                                           ,last_update_login)
                 VALUES (l_invoice_id
                        ,l_invoice_line_id
                        ,l_line_number
                        ,l_description
                        ,                                      --l_description
                         'EACH'
                        ,                                       --    cr1.uom,
                         1
                        ,                                  --    cr1.quantity,
                         i.price
                        ,i.amount
                        ,j.tax_code
                        ,j.tax_perc
                        ,j.tax_amount
                        ,i.charge_type
                        ,NULL
                        ,NULL
                        ,NULL
                        ,j.booking_dtl_id
                        ,i.property_id
                        ,j.property_number
                        ,j.build_id
                        ,j.build_number
                        ,j.unit_id
                        ,j.unit_number
                        ,NULL
                        ,                                     -- p_billing_id,
                         i.installment_type
                        ,              --                cr1.installment_type,
                         NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,NULL
                        ,                                    --cr1.created_by,
                         l_date
                        ,NULL
                        ,                               --cr1.last_updated_by,
                         l_date
                        ,NULL                          --cr1.last_update_login
                             );
         END LOOP;

         UPDATE xxpm_booking_milestones
            SET invoice_id   = l_invoice_id
          WHERE booking_ms_dtl_id = i.booking_ms_dtl_id;
      -- due to db link commit;
      END LOOP;
   END xxpm_create_invoice_txn;



   PROCEDURE get_inv_number (p_booking_hdr_id IN   NUMBER
                            ,p_inv_number      OUT VARCHAR2)
   AS
      l_prefix       VARCHAR2 (10);
      l_seq_no       NUMBER;
      l_proj_id      NUMBER;
      l_invoice_number VARCHAR2 (50);
   BEGIN
      SELECT xp.inv_prefix, xp.seq_no, xp.proj_id
        INTO l_prefix, l_seq_no, l_proj_id
        FROM xxpm_booking_header xbh
            ,xxpm_property_master xpm
            ,xxpm_invoice_number xp
       WHERE     xbh.property_id = xpm.property_id
             AND xpm.project_id = xp.proj_id
             AND xbh.booking_hdr_id = p_booking_hdr_id;

      l_invoice_number := l_prefix || '-' || l_seq_no;

      l_seq_no    :=
           l_seq_no
         + 1;

      UPDATE xxpm_invoice_number
         SET seq_no       = l_seq_no
       WHERE proj_id = l_proj_id;


      -- due to db link commit;
      p_inv_number := l_invoice_number;
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line ('Exception  occurs');
   END get_inv_number;
-- procedure sublease_invoice(p_billing_id IN NUMBER)
--as
--CURSOR c_notsales
--  IS
--    SELECT TRUNC(xb.billing_date) invoice_date,
--      xb.org_id ,
--      txn_source trx_source,
--      txn_type trx_type,
--      xbc.cust_id ,
--      xbc.booking_cust_id,
--      bill_to_site_id cust_site_id,
--        xbm.payment_term ,
--      xoh.offer_hdr_id ,
--      xoh.offer_number ,
--      xbm.booking_hdr_id ,
--      xbh.booking_number ,
--      xb.created_by ,
--      xb.last_updated_by ,
--      XB.LAST_UPDATE_LOGIN ,
--        XAR.ACCOUNTING_RULE_NAME,
--      XAR.INVOICING_RULE,
--      XBH.BOOKING_FROM_DATE,
--      xbh.BOOKING_TO_DATE,
--         xbm.charge_type ,
--      xbh.property_id ,
--            xbm.billing_id,
--            xbm.installment_pct,
--            xbm.MILESTONE_TYPE
--    FROM xxpm_billing xb,
--      xxpm_booking_milestones xbm,
--      xxpm_booking_header xbh,
--      xxpm_booking_customer xbc,
--      xxpm_ar_setup xar,
--      xxpm_milestone_dtl xmd,
--      xxpm_offer_header xoh
--    WHERE xb.billing_id = xbm.billing_id
--      -- AND xbm.source_func_ref_id = xbh.booking_hdr_id
--    AND xbm.booking_hdr_id = xbh.booking_hdr_id
--    AND xbh.booking_hdr_id = xbc.booking_hdr_id
--    AND xbm.charge_type    = xar.charge_type(+)
--        AND XAR.USAGE   =decode(XBH.USAGE , 'SL' ,'L','L')
--    AND xb.org_id          = xar.business_unit_id(+)
--    AND xbm.ms_dtl_id      = xmd.ms_dtl_id(+)
--    AND xbh.offer_hdr_id   = xoh.offer_hdr_id
--    AND xbc.primary_yn     = 'Y'
--    AND xbm.billing_id     = p_billing_id
--    GROUP BY TRUNC(xb.billing_date) ,
--   xb.org_id ,
--      txn_source ,
--      txn_type ,
--      xbc.cust_id ,
--      xbc.booking_cust_id,
--      bill_to_site_id ,
--        xbm.payment_term ,
--      xoh.offer_hdr_id ,
--      xoh.offer_number ,
--      xbm.booking_hdr_id ,
--      xbh.booking_number ,
--      xb.created_by ,
--      xb.last_updated_by ,
--      XB.LAST_UPDATE_LOGIN ,
--        XAR.ACCOUNTING_RULE_NAME,
--      XAR.INVOICING_RULE,
--      XBH.BOOKING_FROM_DATE,
--      xbh.BOOKING_TO_DATE,
--         xbm.charge_type ,
--      xbh.property_id ,
--            xbm.billing_id,
--            xbm.installment_pct,
--            XBM.MILESTONE_TYPE;
--
--  CURSOR c2 (cp_booking_hdr_id IN NUMBER)
--  IS
--    SELECT booking_dtl_id,
--      tax_code,
--      tax_rate tax_perc,
--      tax_amount,
--      xpd.building_id build_id,
--      xpd.unit_id,
--      build_number,
--      unit_number,
--      xpd.property_id,
--      xpd.building_id,xpd.BOOKING_AMOUNT,xpd.DISC_PCT
--    FROM xxpm_booking_detail xpd,
--      xxpm_property_buildings xpb,
--      xxpm_property_master xpm,
--      xxpm_property_units xpu
--    WHERE xpd.property_id = xpm.property_id(+)
--    AND xpb.property_id   = xpm.property_id(+)
--    AND xpd.building_id   = xpb.build_id(+)
--    AND xpd.unit_id       = xpu.unit_id(+)
--    AND BOOKING_HDR_ID    = CP_BOOKING_HDR_ID
--    AND ROWNUM            = 1;
--
--
--  l_invoice_id         NUMBER;
--  l_inv_func_id        NUMBER;
--  l_invoice_number     VARCHAR2 (30);
--  l_inv_number          VARCHAR2 (30);
--  l_error_code         VARCHAR2 (100);
--  l_error_msg          VARCHAR2 (2000);
--  l_date               DATE;
--  l_invoice_line_id    NUMBER;
--  l_line_number        NUMBER;
--  l_property_number    VARCHAR2 (30);
--  l_installment_amount NUMBER;
--  l_description        VARCHAR2 (50);
--  l_instalment_type    VARCHAR2 (100);
--  l_CHARGE_TYPE_flag   VARCHAR2 (10);
--  l_tot_amt number;
--  l_line_amount number;
--  l_tax_amount number;
--  l_prefix VARCHAR2 (10);
--  l_seq_no NUMBER;
--  L_PROJ_ID NUMBER;
--  l_term_id NUMBER;
--  l_TOTAL_VALUE NUMBER;
--  l_contract_amt  NUMBER;
--   l_VEND_ID NUMBER;
--   l_VEND_SITE_ID NUMBER;
--
--
--
--BEGIN
--
--
--   FOR cr1 IN c_notsales
--        LOOP
--          l_date        := SYSDATE;
--          l_invoice_id  := xxpm_invoice_header_s.NEXTVAL;
--          l_inv_func_id := get_function_id (g_invoice_code);
--          DBMS_OUTPUT.PUT_LINE('Invoice ID ' || l_inv_func_id);
--          xxfnd_pkg.get_next_number (p_func_code => g_invoice_code, p_next_num => l_inv_number, p_func_id => l_inv_func_id, p_err_code => l_error_code, p_err_msg => l_error_msg );
--
--       get_inv_number(cr1.booking_hdr_id ,l_invoice_number);
--      DBMS_OUTPUT.PUT_LINE('l_invoice_number ...'||l_invoice_number );
--
--
--
--
--
--
--
--          DBMS_OUTPUT.PUT_LINE('Next number:- ' || L_INVOICE_NUMBER || 'Function id:- ' ||L_INV_FUNC_ID);
--          DBMS_OUTPUT.PUT_LINE('cr1.charge_type ' ||CR1.CHARGE_TYPE );
--
--          begin
--
--        select xvs.VEND_ID  ,xvs.VEND_SITE_ID  into l_VEND_ID  ,l_VEND_SITE_ID  from
--          xxpm_booking_detail xbd
--          ,XXPM_LEASEREQUEST_DTL xld
--          ,XXSTG_VENDOR xv
--          ,XXSTG_VEND_SITEs xvs
--          where xbd.BOOKING_HDR_ID= cr1.booking_hdr_id
--          and xld.UNIT_ID = xbd.UNIT_ID
--          and xv.VEND_ID  =xld.OWNER_ID
--          and  xv.VEND_ID  = xvs.VEND_ID  ;
--
--          exception when others then
--
--          DBMS_OUTPUT.PUT_LINE('exception '||sqlerrm ) ;
--
--
--          end;
--
--
--
--
--
--            INSERT
--            INTO xxpm_invoice_header
--              (
--                invoice_id,
--                invoice_number,
--                invoice_date,
--                func_id,
--                invoice_class,
--                org_id,
--                trx_source,
--                trx_type,
--                currency_code,
--                exchange_rate,
--                cust_id,
--                cust_site_id,
--                payment_terms,
--                due_date,
--                status,
--                interface_status,
--                offer_id,
--                offer_number,
--                booking_id,
--                booking_number,
--                sale_lease_number,
--                customer_trx_id,
--                customer_trx_number,
--                invoicing_rule,
--                acnt_rule,
--                rule_start_date,
--                rule_end_date,
--                attribute_category,
--                attribute1,
--                attribute2,
--                attribute3,
--                attribute4,
--                attribute5,
--                attribute6,
--                attribute7,
--                attribute8,
--                attribute9,
--                attribute10,
--                created_by,
--                created_date,
--                last_updated_by,
--                last_update_date,
--                last_update_login
----                ,
----                INVOICE_TYPE
--              )
--              VALUES
--              (
--                l_invoice_id,
--                l_invoice_number,
--                cr1.invoice_date,
--                l_inv_func_id,
--                NULL,
--                cr1.org_id,
--                cr1.trx_source,
--                cr1.trx_type,
--                g_currency_code,
--                NULL,
--               l_VEND_ID,
--                l_VEND_SITE_ID,
--                l_term_id,
----                nvl(cr1.payment_term,l_term_id),
--                sysdate,
--                g_inv_hdr_status,
--                g_inv_int_status,
--                cr1.offer_hdr_id,
--                cr1.offer_number,
--                cr1.booking_hdr_id,
--                cr1.booking_number,
--                NULL,
--                NULL,
--                null,
--                   CR1.INVOICING_RULE,--invoicing_rule
--                  CR1.ACCOUNTING_RULE_NAME, --acnt_rule
--      CR1.BOOKING_FROM_DATE, --RULE_START_DATE
--      CR1.BOOKING_TO_DATE,   --rule_end_date
--
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                NULL,
--                cr1.created_by,
--                l_date,
--                cr1.last_updated_by,
--                l_date,
--                cr1.last_update_login,
--                'AP'
--              );
--
--
--
--
--
--           FOR cr2 IN c2
--            (
--              cr1.booking_hdr_id
--            )
--            LOOP
--              l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
--
--
--                     begin
--
--         select CONTRACT_AMT  into  l_CONTRACT_AMT from XXPM_LEASEREQUEST_DTL where UNIT_ID = cr2.unit_id;
--              select sum(xlo.TOTAL_VALUE)   into  l_TOTAL_VALUE  from XXPM_LEASEREQUEST_OC xlo,XXPM_LEASEREQUEST_DTL xld where  xlo.LEASE_REQ_DTL_ID=  xld.LEASE_REQ_DTL_ID and xld.UNIT_ID =cr2.unit_id;
--
--
--          exception when others then
--
--          DBMS_OUTPUT.PUT_LINE('exception '||sqlerrm ) ;
--
--
--          end;
--
--
--
--
--
--
--              INSERT
--              INTO xxpm_invoice_lines
--                (
--                  invoice_id,
--                  invoice_line_id,
--                  line_number,
--                  description,
--                  uom_code,
--                  quantity,
--                  price,
--                  amount,
--                  tax_code,
--                  tax_perc,
--                  tax_amount,
--                  charge_type,
--                  rev_acnt_id,
--                  rev_acnt_code,
--                  offer_dtl_id,
--                  booking_dtl_id,
--                  property_id,
--                  property_number,
--                  build_id,
--                  build_number,
--                  unit_id,
--                  unit_number,
--                  billing_ms_id,
--                  installment_type,
--                  customer_trx_line_id,
--                  attribute_category,
--                  attribute1,
--                  attribute2,
--                  attribute3,
--                  attribute4,
--                  attribute5,
--                  attribute6,
--                  attribute7,
--                  attribute8,
--                  attribute9,
--                  attribute10,
--                  created_by,
--                  created_date,
--                  last_updated_by,
--                  last_update_date,
--                  last_update_login,
--                   line_amount ,
--                line_type
--                )
--                VALUES
--                (
--                  l_invoice_id,
--                  l_invoice_line_id,
--                  1,
--                  'FROM PRISM',
--                  NULL,
--                  NULL,
--                  NULL,
--                                    l_CONTRACT_AMT,  --                  l_installment_amount,
--                  NULL,                                ---cr2.tax_code,
--NULL,--                  cr2.tax_perc,
--null,--                  cr2.tax_amount,
--                  cr1.charge_type,
--                  NULL,
--                  NULL,
--                  NULL,
--                  cr2.booking_dtl_id,
--                  cr1.property_id,
--                  l_property_number,
--                  cr2.build_id,
--                  cr2.build_number,
--                  cr2.unit_id,
--                  cr2.unit_number,
--                  p_billing_id,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  cr1.created_by,
--                  l_date,
--                  CR1.LAST_UPDATED_BY,
--                  l_date,
--                  CR1.LAST_UPDATE_LOGIN,
--                  '',
--                  'LINE'
--                );
--
--
--
--                 INSERT
--                INTO xxpm_invoice_lines
--                (
--                  invoice_id,
--                  invoice_line_id,
--                  line_number,
--                  description,
--                  uom_code,
--                  quantity,
--                  price,
--                  amount,
--                  tax_code,
--                  tax_perc,
--                  tax_amount,
--                  charge_type,
--                  rev_acnt_id,
--                  rev_acnt_code,
--                  offer_dtl_id,
--                  booking_dtl_id,
--                  property_id,
--                  property_number,
--                  build_id,
--                  build_number,
--                  unit_id,
--                  unit_number,
--                  billing_ms_id,
--                  installment_type,
--                  customer_trx_line_id,
--                  attribute_category,
--                  attribute1,
--                  attribute2,
--                  attribute3,
--                  attribute4,
--                  attribute5,
--                  attribute6,
--                  attribute7,
--                  attribute8,
--                  attribute9,
--                  attribute10,
--                  created_by,
--                  created_date,
--                  last_updated_by,
--                  last_update_date,
--                  last_update_login,
--                   line_amount ,
--                line_type
--                )
--                VALUES
--                (
--                  l_invoice_id,
--                  xxpm_invoice_lines_s.NEXTVAL,
--                  1,
--                  'FROM PRISM',
--                  NULL,
--                  NULL,
--                  NULL,
--                 l_TOTAL_VALUE,  --                  l_installment_amount,
--                  NULL,                                ---cr2.tax_code,
--NULL,--                  cr2.tax_perc,
--null,--                  cr2.tax_amount,
--                  cr1.charge_type,
--                  NULL,
--                  NULL,
--                  NULL,
--                  cr2.booking_dtl_id,
--                  cr1.property_id,
--                  l_property_number,
--                  cr2.build_id,
--                  cr2.build_number,
--                  cr2.unit_id,
--                  cr2.unit_number,
--                  p_billing_id,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  NULL,
--                  cr1.created_by,
--                  l_date,
--                  cr1.last_updated_by,
--                  l_date,
--                  CR1.LAST_UPDATE_LOGIN,
--                  null,
--                  'LINE'
--                );
--          end loop;
--
--          end loop;
--
--
--
--
--end sublease_invoice;

   PROCEDURE ms_based_invoice (p_billing_id   IN     NUMBER
                          ,p_err_code        OUT VARCHAR2
                          ,p_err_msg         OUT VARCHAR2)
   IS
      l_invoice_id   NUMBER;
      l_inv_func_id  NUMBER;
      l_invoice_number VARCHAR2 (30);
      l_inv_number   VARCHAR2 (30);
      l_error_code   VARCHAR2 (100);
      l_error_msg    VARCHAR2 (2000);
      l_date         DATE;
      l_invoice_line_id NUMBER;
      l_line_number  NUMBER;
      l_property_number VARCHAR2 (30);
      l_installment_amount NUMBER;
      l_description  VARCHAR2 (50);
      l_instalment_type VARCHAR2 (100);
      l_charge_type_flag VARCHAR2 (10);
      l_tot_amt      NUMBER;
      l_line_amount  NUMBER;
      l_tax_amount   NUMBER;
      l_prefix       VARCHAR2 (10);
      l_seq_no       NUMBER;
      l_proj_id      NUMBER;
      l_term_id      NUMBER;



      CURSOR c_book_header
      IS
         SELECT usage
           FROM xxpm_booking_header
          WHERE booking_hdr_id IN (SELECT booking_hdr_id
                                     FROM xxpm_booking_milestones
                                    WHERE BOOKING_MS_DTL_ID = p_billing_id);


      CURSOR c_sales (cp_billing_id NUMBER)
      IS
         SELECT xb.billing_date invoice_date
               ,xb.org_id
               ,txn_source trx_source
               ,txn_type trx_type
               ,xbc.cust_id cust_id
               ,bill_to_site_id cust_site_id
               ,xbm.payment_term
               ,NVL (xbm.due_date, SYSDATE) due_date
               ,xoh.offer_hdr_id offer_id
               ,xoh.offer_number
               ,xbh.booking_hdr_id booking_id
               ,xbh.booking_number
               ,xbh.usage usage
               ,xb.created_by
               ,xb.last_updated_by
               ,xb.last_update_login
               ,xbm.uom
               ,xbm.quantity
               ,xbm.rate price
               ,xbm.installment_amount amount
               ,xbm.charge_type
               ,xbh.property_id
               ,xbm.installment_type
               ,xbm.booking_ms_dtl_id
               ,xbm.milestone_type
               ,xbm.installment_pct
               ,xbm.tax_amount
               ,xbm.invoice_id
               ,xbm.TAX_RATE
               , xbm.TAX_CODE
           FROM xxpm_billing xb
               ,xxpm_booking_milestones xbm
               ,xxpm_booking_header xbh
               ,xxpm_booking_customer xbc
               ,xxpm_ar_setup xar
               ,xxpm_milestone_dtl xmd
               ,xxpm_offer_header xoh
          WHERE     xb.billing_id = xbm.billing_id
                --  AND xbm.source_func_ref_id = xbh.booking_hdr_id
                AND xbm.booking_hdr_id = xbh.booking_hdr_id
                AND xbh.booking_hdr_id = xbc.booking_hdr_id
                AND xbm.charge_type = xar.charge_type(+)
                AND xar.usage = xbh.usage
                AND xb.org_id = xar.business_unit_id(+)
                AND xbm.ms_dtl_id = xmd.ms_dtl_id(+)
                AND xbh.offer_hdr_id = xoh.offer_hdr_id
                AND xbc.primary_yn = 'Y'
                AND xbm.booking_ms_dtl_id = cp_billing_id;

      --
      --    cursor cur_upd_ms
      --    is
      --    SELECT MILESTONE_TYPE,CHARGE_TYPE,billing_id,BOOKING_MS_DTL_ID from xxpm_booking_milestones
      --
      --        where  billing_id     = p_billing_id;



      CURSOR c_notsales (cp_billing_id NUMBER)
      IS
           SELECT TRUNC (xb.billing_date) invoice_date
                 ,xb.org_id
                 ,txn_source trx_source
                 ,txn_type trx_type
                 ,xbc.cust_id
                 ,xbc.booking_cust_id
                 ,bill_to_site_id cust_site_id
                 ,xbm.payment_term
                 ,xoh.offer_hdr_id
                 ,xoh.offer_number
                 ,xbm.booking_hdr_id
                 ,xbh.booking_number
                 ,xb.created_by
                 ,xb.last_updated_by
                 ,xb.last_update_login
                 ,xar.accounting_rule_name
                 ,xar.invoicing_rule
                 ,xbh.booking_from_date
                 ,xbh.booking_to_date
                 ,xbm.charge_type
                 ,xbh.property_id
                 ,xbm.billing_id
                 ,xbm.installment_pct
                 ,xbm.milestone_type
             FROM xxpm_billing xb
                 ,xxpm_booking_milestones xbm
                 ,xxpm_booking_header xbh
                 ,xxpm_booking_customer xbc
                 ,xxpm_ar_setup xar
                 ,xxpm_milestone_dtl xmd
                 ,xxpm_offer_header xoh
            WHERE     xb.billing_id = xbm.billing_id
                  -- AND xbm.source_func_ref_id = xbh.booking_hdr_id
                  AND xbm.booking_hdr_id = xbh.booking_hdr_id
                  AND xbh.booking_hdr_id = xbc.booking_hdr_id
                  AND xbm.charge_type = xar.charge_type(+)
                  AND xar.usage = DECODE (xbh.usage, 'SL', 'L', 'L')
                  AND xb.org_id = xar.business_unit_id(+)
                  AND xbm.ms_dtl_id = xmd.ms_dtl_id(+)
                  AND xbh.offer_hdr_id = xoh.offer_hdr_id
                  AND xbc.primary_yn = 'Y'
                  AND xbm.billing_id = cp_billing_id
         GROUP BY TRUNC (xb.billing_date)
                 ,xb.org_id
                 ,txn_source
                 ,txn_type
                 ,xbc.cust_id
                 ,xbc.booking_cust_id
                 ,bill_to_site_id
                 ,xbm.payment_term
                 ,xoh.offer_hdr_id
                 ,xoh.offer_number
                 ,xbm.booking_hdr_id
                 ,xbh.booking_number
                 ,xb.created_by
                 ,xb.last_updated_by
                 ,xb.last_update_login
                 ,xar.accounting_rule_name
                 ,xar.invoicing_rule
                 ,xbh.booking_from_date
                 ,xbh.booking_to_date
                 ,xbm.charge_type
                 ,xbh.property_id
                 ,xbm.billing_id
                 ,xbm.installment_pct
                 ,xbm.milestone_type;

      CURSOR c2 (cp_booking_hdr_id IN NUMBER)
      IS
         SELECT booking_dtl_id
               ,tax_code
               ,tax_rate tax_perc
               ,tax_amount
               ,xpd.building_id build_id
               ,xpd.unit_id
               ,build_number
               ,unit_number
               ,xpd.property_id
               ,xpd.building_id
               ,xpd.booking_amount
               ,xpd.disc_pct
           FROM xxpm_booking_detail xpd
               ,xxpm_property_buildings xpb
               ,xxpm_property_master xpm
               ,xxpm_property_units xpu
          WHERE     xpd.property_id = xpm.property_id(+)
                AND xpb.property_id = xpm.property_id(+)
                AND xpd.building_id = xpb.build_id(+)
                AND xpd.unit_id = xpu.unit_id(+)
                AND booking_hdr_id = cp_booking_hdr_id
                AND ROWNUM = 1;
   BEGIN
      SELECT term_id
        INTO l_term_id
        FROM xxstg_pay_terms
       WHERE term_name = 'IMMEDIATE';

      FOR c_bh IN c_book_header
      LOOP
         IF TO_CHAR (c_bh.usage) = 'S'
         THEN
            BEGIN
               FOR cr1 IN c_sales (p_billing_id)
               LOOP
                  IF cr1.invoice_id IS NOT NULL
                  THEN
                     UPDATE xxpm_invoice_header
--                        SET interface_status = 'READY_TO_INVOICE'
                        SET interface_status = 'ERROR'
                      WHERE invoice_id = cr1.invoice_id;


                  ELSE
                     DBMS_OUTPUT.put_line ('entry Invoice ID ');


                     l_date      := SYSDATE;
                     l_invoice_id := xxpm_invoice_header_s.NEXTVAL;
                     l_inv_func_id := get_function_id (g_invoice_code);
                     DBMS_OUTPUT.put_line (
                        'l_inv_func_id ID   ' || l_inv_func_id);
                     xxfnd_pkg.get_next_number (p_func_code => g_invoice_code
                                               ,p_next_num  => l_inv_number
                                               ,p_func_id   => l_inv_func_id
                                               ,p_err_code  => l_error_code
                                               ,p_err_msg   => l_error_msg);
                     DBMS_OUTPUT.put_line (
                           'Next number:- '
                        || l_inv_number
                        || 'Function id:- '
                        || l_inv_func_id);
                     DBMS_OUTPUT.put_line ('exit  Invoice ID ...');

                     get_inv_number (cr1.booking_id, l_invoice_number);
                     DBMS_OUTPUT.put_line (
                        'l_invoice_number ...' || l_invoice_number);


                     --
                     --    begin
                     --
                     --        SELECT
                     --        xp.INV_PREFIX ,xp.SEQ_NO, xp.PROJ_ID  into l_prefix  ,l_seq_no ,l_PROJ_ID
                     --    FROM xxpm_booking_header xbh,
                     --    xxpm_property_master xpm,
                     --    xxstg_projects xp
                     --    where  xbh.property_id =xpm.property_id
                     --    and xpm.PROJECT_ID   =xp.PROJ_ID
                     --    and xbh.booking_hdr_id =cr1.booking_id;
                     --
                     --l_invoice_number := l_prefix ||'-'||l_seq_no;
                     --
                     --l_seq_no := l_seq_no+1 ;
                     --
                     --update  xxstg_projects set SEQ_NO = l_seq_no where PROJ_ID =l_PROJ_ID;
                     --
                     --    -- due to db link commit;
                     --
                     --
                     --    end ;



                     INSERT INTO xxpm_invoice_header (invoice_id
                                                     ,invoice_number
                                                     ,invoice_date
                                                     ,func_id
                                                     ,invoice_class
                                                     ,org_id
                                                     ,trx_source
                                                     ,trx_type
                                                     ,currency_code
                                                     ,exchange_rate
                                                     ,cust_id
                                                     ,cust_site_id
                                                     ,payment_terms
                                                     ,due_date
                                                     ,status
                                                     ,interface_status
                                                     ,offer_id
                                                     ,offer_number
                                                     ,booking_id
                                                     ,booking_number
                                                     ,sale_lease_number
                                                     ,customer_trx_id
                                                     ,customer_trx_number
                                                     ,invoicing_rule
                                                     ,acnt_rule
                                                     ,rule_start_date
                                                     ,rule_end_date
                                                     ,attribute_category
                                                     ,attribute1
                                                     ,attribute2
                                                     ,attribute3
                                                     ,attribute4
                                                     ,attribute5
                                                     ,attribute6
                                                     ,attribute7
                                                     ,attribute8
                                                     ,attribute9
                                                     ,attribute10
                                                     ,created_by
                                                     ,created_date
                                                     ,last_updated_by
                                                     ,last_update_date
                                                     ,last_update_login --              ,
                                                                       --              INVOICE_TYPE
                                                      )
                          VALUES (l_invoice_id
                                 ,l_invoice_number
                                 ,cr1.invoice_date
                                 ,l_inv_func_id
                                 ,NULL
                                 ,cr1.org_id
                                 ,cr1.trx_source
                                 ,cr1.trx_type
                                 ,g_currency_code
                                 ,NULL
                                 ,cr1.cust_id
                                 ,cr1.cust_site_id
                                 ,NVL (cr1.payment_term, l_term_id)
                                 ,cr1.due_date
                                 ,g_inv_hdr_status
                                 ,g_inv_int_status
                                 ,cr1.offer_id
                                 ,cr1.offer_number
                                 ,cr1.booking_id
                                 ,cr1.booking_number
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,                            --invoicing_rule
                                  NULL
                                 ,                                 --acnt_rule
                                  NULL
                                 ,                           --RULE_START_DATE
                                  NULL
                                 ,                             --rule_end_date
                                  NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,NULL
                                 ,cr1.created_by
                                 ,l_date
                                 ,cr1.last_updated_by
                                 ,l_date
                                 ,cr1.last_update_login      --              ,
                                                       --              'AR'
                                  );

                     DBMS_OUTPUT.put_line ('l_invoice ' || l_invoice_id);

                     l_line_number := 0;

                     FOR cr2 IN c2 (cr1.booking_id)
                     LOOP
                        l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
                        l_line_number :=
                             l_line_number
                           + 1;


                        l_instalment_type := cr1.installment_type;

                        IF l_instalment_type IS NOT NULL
                        THEN
                           IF cr1.milestone_type = 'MS'
                           THEN
                              BEGIN
                                 l_description := NULL;

                                 SELECT lookup_value_name_disp
                                   INTO l_description
                                   FROM xxfnd_lookup_v
                                  WHERE     lookup_type_name =
                                               'MILESTONE_INSTALLMENT'
                                        AND lookup_value_name =
                                               cr1.installment_type;
                              EXCEPTION
                                 WHEN OTHERS
                                 THEN
                                    DBMS_OUTPUT.put_line (
                                       'exception in getting the description ');
                              END;
                           ELSE
                              l_description := cr1.installment_type;
                              l_instalment_type := NULL;
                           END IF;
                        ELSE
                           l_description := 'From Prism';
                        END IF;


                        IF cr1.milestone_type = 'MS'
                        THEN
                           l_tot_amt   :=
                                (  cr2.booking_amount
                                 * NVL (cr1.installment_pct, 0))
                              / 100;
                           --Dinesh commented  31-10-2019
                           /*l_line_amount :=
                                l_tot_amt
                              -   (  l_tot_amt
                                   * NVL (cr2.disc_pct, 0))
                                / 100;
                           l_tax_amount :=
                                l_tot_amt
                              * NVL (cr2.tax_perc, 0)
                              / 100;*/

                           --Dinesh added 03-10-2019
--                           l_tax_amount := NVL(cr1.tax_amount,0);
                         l_tax_amount :=l_tot_amt*nvl(cr2.tax_perc,0) /100;
                           l_line_amount :=
                                NVL(cr1.amount,0)
                              - l_tax_amount;
                        ELSE
                           l_tax_amount := NVL(cr1.tax_amount,0);

                           l_line_amount :=
                                NVL(cr1.amount,0)
                              - l_tax_amount;
                        END IF;

                        DBMS_OUTPUT.put_line ('l_tot_amt   ' || l_tot_amt);
                        DBMS_OUTPUT.put_line (
                           'l_line_amount   ' || l_line_amount);

                        DBMS_OUTPUT.put_line (
                           'l_tax_amount   ' || l_tax_amount);


                        INSERT INTO xxpm_invoice_lines (invoice_id
                                                       ,invoice_line_id
                                                       ,line_number
                                                       ,description
                                                       ,uom_code
                                                       ,quantity
                                                       ,price
                                                       ,amount
                                                       ,tax_code
                                                       ,tax_perc
                                                       ,tax_amount
                                                       ,charge_type
                                                       ,rev_acnt_id
                                                       ,rev_acnt_code
                                                       ,offer_dtl_id
                                                       ,booking_dtl_id
                                                       ,property_id
                                                       ,property_number
                                                       ,build_id
                                                       ,build_number
                                                       ,unit_id
                                                       ,unit_number
                                                       ,billing_ms_id
                                                       ,installment_type
                                                       ,customer_trx_line_id
                                                       ,attribute_category
                                                       ,attribute1
                                                       ,attribute2
                                                       ,attribute3
                                                       ,attribute4
                                                       ,attribute5
                                                       ,attribute6
                                                       ,attribute7
                                                       ,attribute8
                                                       ,attribute9
                                                       ,attribute10
                                                       ,created_by
                                                       ,created_date
                                                       ,last_updated_by
                                                       ,last_update_date
                                                       ,last_update_login
                                                       ,line_amount
                                                       ,line_type)
                             VALUES (l_invoice_id
                                    ,l_invoice_line_id
                                    ,l_line_number
                                    ,l_description
                                    ,                          --l_description
                                     'EACH'
                                    ,                           --    cr1.uom,
                                     1
                                    ,                      --    cr1.quantity,
                                     cr1.price
                                    ,l_line_amount
                                    ,            --                cr1.amount,
                                     NULL
                                    ,          --                cr2.tax_code,
                                     NULL
                                    ,          --                cr2.tax_perc,
                                     NULL
                                    ,        --                cr2.tax_amount,
                                     cr1.charge_type
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr2.booking_dtl_id
                                    ,cr1.property_id
                                    ,l_property_number
                                    ,cr2.build_id
                                    ,cr2.build_number
                                    ,cr2.unit_id
                                    ,cr2.unit_number
                                    ,p_billing_id
                                    ,l_instalment_type
                                    ,  --                cr1.installment_type,
                                     NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr1.created_by
                                    ,l_date
                                    ,cr1.last_updated_by
                                    ,l_date
                                    ,cr1.last_update_login
                                    ,l_line_amount
                                    ,'LINE');

                        --            IF cr1.MILESTONE_TYPE = 'MS' then

                        DBMS_OUTPUT.put_line ('xxpm_invoice_lines,   ');

                        --              dbms_output.put_line(' ');
                        INSERT INTO xxpm_invoice_lines (invoice_id
                                                       ,invoice_line_id
                                                       ,line_number
                                                       ,description
                                                       ,uom_code
                                                       ,quantity
                                                       ,price
                                                       ,amount
                                                       ,tax_code
                                                       ,tax_perc
                                                       ,tax_amount
                                                       ,charge_type
                                                       ,rev_acnt_id
                                                       ,rev_acnt_code
                                                       ,offer_dtl_id
                                                       ,booking_dtl_id
                                                       ,property_id
                                                       ,property_number
                                                       ,build_id
                                                       ,build_number
                                                       ,unit_id
                                                       ,unit_number
                                                       ,billing_ms_id
                                                       ,installment_type
                                                       ,customer_trx_line_id
                                                       ,attribute_category
                                                       ,attribute1
                                                       ,attribute2
                                                       ,attribute3
                                                       ,attribute4
                                                       ,attribute5
                                                       ,attribute6
                                                       ,attribute7
                                                       ,attribute8
                                                       ,attribute9
                                                       ,attribute10
                                                       ,created_by
                                                       ,created_date
                                                       ,last_updated_by
                                                       ,last_update_date
                                                       ,last_update_login
                                                       ,line_amount
                                                       ,line_type)
                             VALUES (l_invoice_id
                                    ,xxpm_invoice_lines_s.NEXTVAL
                                    ,2
                                    ,                            --line_number
                                     l_description
                                    ,                          --l_description
                                     'EACH'
                                    ,                           --    cr1.uom,
                                     1
                                    ,                      --    cr1.quantity,
                                     cr1.price
                                    ,0
                                    ,            --                cr1.amount,
                                     nvl(cr1.tax_code, cr2.tax_code)
                                    ,nvl(cr1.tax_rate, cr2.tax_perc)
                                    -- Dinesh
                                    -- cr1-Booking Ms tax
                                    -- CR2-Booking Details
--                                     cr2.tax_code
--                                    ,cr2.tax_perc
                                    ,l_tax_amount
                                    ,        --                cr2.tax_amount,
                                     cr1.charge_type
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr2.booking_dtl_id
                                    ,cr1.property_id
                                    ,l_property_number
                                    ,cr2.build_id
                                    ,cr2.build_number
                                    ,cr2.unit_id
                                    ,cr2.unit_number
                                    ,p_billing_id
                                    ,l_instalment_type
                                    ,  --                cr1.installment_type,
                                     NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,NULL
                                    ,cr1.created_by
                                    ,l_date
                                    ,cr1.last_updated_by
                                    ,l_date
                                    ,cr1.last_update_login
                                    ,l_tax_amount
                                    ,'TAX');



                        DBMS_OUTPUT.put_line ('inside loop lines if ms');

                        --              END IF;
                        DBMS_OUTPUT.put_line ('inside loop lines ms');
                     END LOOP;
                     commit;   
                     UPDATE xxpm_booking_milestones
                        SET invoice_id   = l_invoice_id
                      WHERE booking_ms_dtl_id = cr1.booking_ms_dtl_id;
                    commit;
                     DBMS_OUTPUT.put_line ('update milestone ');
                  -- due to db link commit;

                  END IF;
               END LOOP;

               p_err_code  := 'S';
               p_err_msg   := 'Success';
            -- due to db link commit;
            EXCEPTION
               WHEN OTHERS
               THEN
                  ROLLBACK;
                  p_err_code  := 'E';
                  p_err_msg   := SQLERRM;
            END;
         ELSE
            DBMS_OUTPUT.put_line ('USAGE IS NOT SALES');


         END IF;
      END LOOP;

      p_err_code  := 'S';
      p_err_msg   := 'Success';
   -- due to db link commit;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_err_code  := 'E';
         p_err_msg   := 'ERROR MESSAGE';
   END ms_based_invoice;





END xxpm_bill_invoice_pkg;
/
