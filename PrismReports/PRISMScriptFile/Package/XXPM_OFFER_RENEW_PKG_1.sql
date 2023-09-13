--------------------------------------------------------
--  DDL for Package XXPM_OFFER_RENEW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_OFFER_RENEW_PKG" 
AS
   PROCEDURE autocreate (p_offer_num      IN     varchar2,
                              p_user_id    IN     varchar2,
                              p_err_code      OUT varchar2,
                              p_err_msg       OUT varchar2);
END xxpm_offer_renew_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_OFFER_RENEW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_OFFER_RENEW_PKG" 
AS
   PROCEDURE autocreate (p_offer_num   IN     varchar2,
                         p_user_id     IN     varchar2,
                         p_err_code       OUT varchar2,
                         p_err_msg        OUT varchar2)
   IS
      CURSOR cur_off_renew
      IS
         SELECT   o.offer_hdr_id,
                  la.lease_agreement_id,
                  la.booking_id,
                  la.recommend_id
           FROM   xxpm_offer_header o, xxpm_lease_agreement la
          WHERE       o.lease_agreement_id = la.lease_agreement_id
                  AND offer_flag = 'R'
                  AND offer_number = p_offer_num;

      CURSOR cur_booking_hdr (cp_book_id number)
      IS
         SELECT   booking_id,
                  func_id,
                  offer_hdr_id,
                  booking_number,
                  booking_date,
                  booking_due_date,
                  cust_req_movein_date,
                  performed_by,
                  booking_amount,
                  booking_pay_method,
                  currency,
                  total_rent,
                  appointment_date,
                  status,
                  description,
                  flow_status,
                  flow_level,
                  flow_with,
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
                  object_version_number,
                  property_id,
                  building_id,
                  org_id,
                  user_grp_id
           FROM   xxpm_booking_header
          WHERE   booking_id = cp_book_id;

      CURSOR cur_booking_dtl (cp_book_id number)
      IS
         SELECT   booking_dtl_id,
                  booking_id,
                  property_id,
                  building_id,
                  unit_id,
                  purpose,
                  uom,
                  quantity,
                  base_rate,
                  premium_rate_1,
                  premium_rate_type_1,
                  premium_rate_2,
                  premium_rate_type_2,
                  premium_rate_3,
                  premium_rate_type_3,
                  premium_rate_4,
                  premium_rate_type_4,
                  premium_rate_5,
                  premium_rate_type_5,
                  disc_pct_base_rate,
                  disc_base_rate,
                  disc_pct_premium_rate_1,
                  disc_premium_rate_1,
                  disc_pct_premium_rate_2,
                  disc_premium_rate_2,
                  disc_pct_premium_rate_3,
                  disc_premium_rate_3,
                  disc_pct_premium_rate_4,
                  disc_premium_rate_4,
                  disc_pct_premium_rate_5,
                  disc_premium_rate_5,
                  total_rate,
                  discount_rate,
                  tax_amount,
                  tax_code,
                  tax_rate,
                  unit_avl_status,
                  unit_avl_from,
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
                  security_deposite,
                  municipality_charges,
                  electricity_charges,
                  third_party_serv_charge,
                  other_govnt_charge_new,
                  other_govnt_charge_rnew,
                  ejari_payment_charge,
                  municipality_percentage,
                  created_by,
                  creation_date,
                  last_updated_by,
                  last_update_date,
                  last_update_login
           FROM   xxpm_booking_detail
          WHERE   booking_id = cp_book_id;

      CURSOR cur_book_milestone (cp_book_id IN number)
      IS
         SELECT   booking_ms_dtl_id,
                  booking_hdr_id,
                  offer_ms_dtl_id,
                  seq_number,
                  installment_type,
                  installment_pct,
                  installment_amount,
                  criteria,
                  charge_type,
                  payment_term,
                  remarks,
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
                  milestone_type
           FROM   xxpm_booking_milestone_detail
          WHERE   booking_hdr_id = cp_book_id;

      CURSOR cur_booking_cust (cp_book_id IN number)
      IS
         SELECT   book_cust_id,
                  booking_id,
                  cust_id,
                  cust_site_id,
                  cust_contact_id,
                  cust_name,
                  trn_number,
                  cust_category,
                  cust_acc_name,
                  ship_to_addr,
                  bill_to_addr,
                  religion,
                  visa_type,
                  nationality,
                  cust_bank_name,
                  cust_branch_name,
                  cust_bank_acc_number,
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
                  customer_number_ar,
                  customer_name_ar,
                  cust_id_ar
           FROM   xxpm_booking_customer
          WHERE   booking_id = cp_book_id;

      CURSOR cur_recommend_hdr (cp_recommend_id IN number)
      IS
         SELECT   recommend_id,
                  func_id,
                  booking_id,
                  recommend_number,
                  status,
                  description,
                  flow_status,
                  flow_level,
                  flow_with,
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
                  object_version_number,
                  org_id,
                  property_id,
                  building_id,
                  user_grp_id
           FROM   xxpm_recommend_header
          WHERE   recommend_id = cp_recommend_id;

      CURSOR cur_recommend_dtl (cp_recommend_id IN number)
      IS
         SELECT   recommend_dtl_id,
                  recommend_id,
                  seq_number,
                  installment_type,
                  installment_pct,
                  installment_amount,
                  criteria,
                  charge_type,
                  payment_term,
                  remarks,
                  due_date,
                  cheque_no,
                  cheque_date,
                  amount_received,
                  received_date,
                  bank_name,
                  payee_name,
                  status,
                  receipt_id,
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
                  last_update_login
           FROM   xxpm_recommend_detail
          WHERE   recommend_id = cp_recommend_id;

      l_book_next_num    varchar2 (1000);
      l_recom_next_num   varchar2 (1000);
      l_book_func_id     number;
      l_recom_func_id    number;
      l_err_code         varchar2 (100);
      l_err_msg          varchar2 (3000);
   BEGIN
      p_err_code := '0';
      p_err_msg := 'Success';

      FOR i IN cur_off_renew
      LOOP
         FOR j IN cur_booking_hdr (i.booking_id)
         LOOP
            --Getting Next Booking Number
            BEGIN
               BEGIN
                  l_book_next_num := NULL;

                  xxfnd_pkg.get_next_number ('BK',
                                             l_book_next_num,
                                             l_book_func_id,
                                             p_err_code,
                                             p_err_msg);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     p_err_code := SQLCODE;
                     p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                     RETURN;
                     DBMS_OUTPUT.put_line (
                        'Error in Getting Next Booking Number ' || SQLERRM
                     );
               END;


               --insert booking header
               INSERT INTO xxpm_booking_header (booking_id,
                                                func_id,
                                                offer_hdr_id,
                                                booking_number,
                                                booking_date,
                                                booking_due_date,
                                                cust_req_movein_date,
                                                performed_by,
                                                booking_amount,
                                                booking_pay_method,
                                                currency,
                                                total_rent,
                                                appointment_date,
                                                status,
                                                description,
                                                flow_status,
                                                flow_level,
                                                flow_with,
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
                                                object_version_number,
                                                property_id,
                                                building_id,
                                                org_id,
                                                user_grp_id)
                 VALUES   (xxpm_booking_id_s.NEXTVAL,             --booking_id
                           j.func_id,
                           i.offer_hdr_id,          -- renewal offer header id
                           l_book_next_num,                  --booking_number,
                           SYSDATE,                           -- booking_date,
                           SYSDATE,                        --booking_due_date,
                           j.cust_req_movein_date,
                           j.performed_by,
                           j.booking_amount,
                           j.booking_pay_method,
                           j.currency,
                           j.total_rent,
                           j.appointment_date,
                           'APR',                                     --status
                           j.description,
                           j.flow_status,
                           j.flow_level,
                           j.flow_with,
                           j.attribute_category,
                           j.attribute1,
                           j.attribute2,
                           j.attribute3,
                           j.attribute4,
                           j.attribute5,
                           j.attribute6,
                           j.attribute7,
                           j.attribute8,
                           j.attribute9,
                           j.attribute10,
                           j.attribute11,
                           j.attribute12,
                           j.attribute13,
                           j.attribute14,
                           j.attribute15,
                           j.attribute16,
                           j.attribute17,
                           j.attribute18,
                           j.attribute19,
                           j.attribute20,
                           j.created_by,
                           SYSDATE,                           --creation_date,
                           j.last_updated_by,
                           SYSDATE,                        --last_update_date,
                           j.last_update_login,
                           j.object_version_number,
                           j.property_id,
                           j.building_id,
                           j.org_id,
                           j.user_grp_id);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_code := SQLCODE;
                  p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                  RETURN;

                  DBMS_OUTPUT.put_line (
                     'Exception in Inserting Booking Header ' || SQLERRM
                  );
            END;

            --insert booking detail
            FOR k IN cur_booking_dtl (i.booking_id)
            LOOP
               BEGIN
                  INSERT INTO xxpm_booking_detail (booking_dtl_id,
                                                   booking_id,
                                                   property_id,
                                                   building_id,
                                                   unit_id,
                                                   purpose,
                                                   uom,
                                                   quantity,
                                                   base_rate,
                                                   premium_rate_1,
                                                   premium_rate_type_1,
                                                   premium_rate_2,
                                                   premium_rate_type_2,
                                                   premium_rate_3,
                                                   premium_rate_type_3,
                                                   premium_rate_4,
                                                   premium_rate_type_4,
                                                   premium_rate_5,
                                                   premium_rate_type_5,
                                                   disc_pct_base_rate,
                                                   disc_base_rate,
                                                   disc_pct_premium_rate_1,
                                                   disc_premium_rate_1,
                                                   disc_pct_premium_rate_2,
                                                   disc_premium_rate_2,
                                                   disc_pct_premium_rate_3,
                                                   disc_premium_rate_3,
                                                   disc_pct_premium_rate_4,
                                                   disc_premium_rate_4,
                                                   disc_pct_premium_rate_5,
                                                   disc_premium_rate_5,
                                                   total_rate,
                                                   discount_rate,
                                                   tax_amount,
                                                   tax_code,
                                                   tax_rate,
                                                   unit_avl_status,
                                                   unit_avl_from,
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
                                                   security_deposite,
                                                   municipality_charges,
                                                   electricity_charges,
                                                   third_party_serv_charge,
                                                   other_govnt_charge_new,
                                                   other_govnt_charge_rnew,
                                                   ejari_payment_charge,
                                                   municipality_percentage,
                                                   created_by,
                                                   creation_date,
                                                   last_updated_by,
                                                   last_update_date,
                                                   last_update_login)
                    VALUES   (xxpm_booking_dtl_id_s.NEXTVAL,
                              xxpm_booking_id_s.CURRVAL,
                              k.property_id,
                              k.building_id,
                              k.unit_id,
                              k.purpose,
                              k.uom,
                              k.quantity,
                              k.base_rate,
                              k.premium_rate_1,
                              k.premium_rate_type_1,
                              k.premium_rate_2,
                              k.premium_rate_type_2,
                              k.premium_rate_3,
                              k.premium_rate_type_3,
                              k.premium_rate_4,
                              k.premium_rate_type_4,
                              k.premium_rate_5,
                              k.premium_rate_type_5,
                              k.disc_pct_base_rate,
                              k.disc_base_rate,
                              k.disc_pct_premium_rate_1,
                              k.disc_premium_rate_1,
                              k.disc_pct_premium_rate_2,
                              k.disc_premium_rate_2,
                              k.disc_pct_premium_rate_3,
                              k.disc_premium_rate_3,
                              k.disc_pct_premium_rate_4,
                              k.disc_premium_rate_4,
                              k.disc_pct_premium_rate_5,
                              k.disc_premium_rate_5,
                              k.total_rate,
                              k.discount_rate,
                              k.tax_amount,
                              k.tax_code,
                              k.tax_rate,
                              k.unit_avl_status,
                              k.unit_avl_from,
                              k.attribute_category,
                              k.attribute1,
                              k.attribute2,
                              k.attribute3,
                              k.attribute4,
                              k.attribute5,
                              k.attribute6,
                              k.attribute7,
                              k.attribute8,
                              k.attribute9,
                              k.attribute10,
                              k.attribute11,
                              k.attribute12,
                              k.attribute13,
                              k.attribute14,
                              k.attribute15,
                              k.attribute16,
                              k.attribute17,
                              k.attribute18,
                              k.attribute19,
                              k.attribute20,
                              k.security_deposite,
                              k.municipality_charges,
                              k.electricity_charges,
                              k.third_party_serv_charge,
                              k.other_govnt_charge_new,
                              k.other_govnt_charge_rnew,
                              k.ejari_payment_charge,
                              k.municipality_percentage,
                              k.created_by,
                              SYSDATE,                        --creation_date,
                              k.last_updated_by,
                              SYSDATE,                     --last_update_date,
                              k.last_update_login);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     p_err_code := SQLCODE;
                     p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                     RETURN;
                     DBMS_OUTPUT.put_line (
                        'Exception in Inserting Booking Detail ' || SQLERRM
                     );
               END;
            END LOOP;

            --inserting booking milestone

            FOR ms IN cur_book_milestone (i.booking_id)
            LOOP
               INSERT INTO xxpm_booking_milestone_detail (booking_ms_dtl_id,
                                                          booking_hdr_id,
                                                          offer_ms_dtl_id,
                                                          seq_number,
                                                          installment_type,
                                                          installment_pct,
                                                          installment_amount,
                                                          criteria,
                                                          charge_type,
                                                          payment_term,
                                                          remarks,
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
                                                          milestone_type)
                 VALUES   (XXPL_MS_DTL_ID_S.NEXTVAL,       --booking_ms_dtl_id
                           xxpm_booking_id_s.CURRVAL,         --booking_hdr_id
                           NULL,                            --offer_ms_dtl_id,
                           ms.seq_number,
                           ms.installment_type,
                           ms.installment_pct,
                           ms.installment_amount,
                           ms.criteria,
                           ms.charge_type,
                           ms.payment_term,
                           ms.remarks,
                           SYSDATE,                                 --due_date
                           ms.attribute_category,
                           ms.attribute1,
                           ms.attribute2,
                           ms.attribute3,
                           ms.attribute4,
                           ms.attribute5,
                           ms.attribute6,
                           ms.attribute7,
                           ms.attribute8,
                           ms.attribute9,
                           ms.attribute10,
                           ms.created_by,
                           SYSDATE,                           --creation_date,
                           ms.last_updated_by,
                           SYSDATE,                        --last_update_date,
                           ms.last_update_login,
                           ms.milestone_type);
            END LOOP;

            --inserting booking customer
            FOR bc IN cur_booking_cust (i.booking_id)
            LOOP
               INSERT INTO xxpm_booking_customer (book_cust_id,
                                                  booking_id,
                                                  cust_id,
                                                  cust_site_id,
                                                  cust_contact_id,
                                                  cust_name,
                                                  trn_number,
                                                  cust_category,
                                                  cust_acc_name,
                                                  ship_to_addr,
                                                  bill_to_addr,
                                                  religion,
                                                  visa_type,
                                                  nationality,
                                                  cust_bank_name,
                                                  cust_branch_name,
                                                  cust_bank_acc_number,
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
                                                  customer_number_ar,
                                                  customer_name_ar,
                                                  cust_id_ar)
                 VALUES   (xxpm_booking_cust_id_s.NEXTVAL,      --book_cust_id
                           xxpm_booking_id_s.CURRVAL,             --booking_id
                           bc.cust_id,
                           bc.cust_site_id,
                           bc.cust_contact_id,
                           bc.cust_name,
                           bc.trn_number,
                           bc.cust_category,
                           bc.cust_acc_name,
                           bc.ship_to_addr,
                           bc.bill_to_addr,
                           bc.religion,
                           bc.visa_type,
                           bc.nationality,
                           bc.cust_bank_name,
                           bc.cust_branch_name,
                           bc.cust_bank_acc_number,
                           bc.attribute_category,
                           bc.attribute1,
                           bc.attribute2,
                           bc.attribute3,
                           bc.attribute4,
                           bc.attribute5,
                           bc.attribute6,
                           bc.attribute7,
                           bc.attribute8,
                           bc.attribute9,
                           bc.attribute10,
                           bc.attribute11,
                           bc.attribute12,
                           bc.attribute13,
                           bc.attribute14,
                           bc.attribute15,
                           bc.attribute16,
                           bc.attribute17,
                           bc.attribute18,
                           bc.attribute19,
                           bc.attribute20,
                           bc.created_by,
                           SYSDATE,                            --creation_date
                           bc.last_updated_by,
                           SYSDATE,                         --last_update_date
                           bc.last_update_login,
                           bc.customer_number_ar,
                           bc.customer_name_ar,
                           bc.cust_id_ar);
            END LOOP;
         END LOOP;

         --inserting recommend header
         FOR r IN cur_recommend_hdr (i.recommend_id)
         LOOP
            --Getting Next Recommendation Number

            BEGIN
               l_recom_next_num := NULL;

               xxfnd_pkg.get_next_number ('RC',
                                          l_recom_next_num,
                                          l_recom_func_id,
                                          p_err_code,
                                          p_err_msg);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_code := SQLCODE;
                  p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                  RETURN;
                  DBMS_OUTPUT.put_line('Error in Getting Next Recommendation Number '
                                       || SQLERRM);
            END;


            BEGIN
               INSERT INTO xxpm_recommend_header (recommend_id,
                                                  func_id,
                                                  booking_id,
                                                  recommend_number,
                                                  status,
                                                  description,
                                                  flow_status,
                                                  flow_level,
                                                  flow_with,
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
                                                  object_version_number,
                                                  org_id,
                                                  property_id,
                                                  building_id,
                                                  user_grp_id)
                 VALUES   (xxpm_recommend_id_s.NEXTVAL,         --recommend_id
                           r.func_id,
                           xxpm_booking_id_s.CURRVAL,             --booking_id
                           l_recom_next_num,                --recommend_number
                           'DRA',                                     --status
                           r.description,
                           r.flow_status,
                           r.flow_level,
                           r.flow_with,
                           r.attribute_category,
                           r.attribute1,
                           r.attribute2,
                           r.attribute3,
                           r.attribute4,
                           r.attribute5,
                           r.attribute6,
                           r.attribute7,
                           r.attribute8,
                           r.attribute9,
                           r.attribute10,
                           r.attribute11,
                           r.attribute12,
                           r.attribute13,
                           r.attribute14,
                           r.attribute15,
                           r.attribute16,
                           r.attribute17,
                           r.attribute18,
                           r.attribute19,
                           r.attribute20,
                           r.created_by,
                           SYSDATE,                            --creation_date
                           r.last_updated_by,
                           SYSDATE,                         --last_update_date
                           r.last_update_login,
                           r.object_version_number,
                           r.org_id,
                           r.property_id,
                           r.building_id,
                           r.user_grp_id);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_code := SQLCODE;
                  p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                  RETURN;
                  DBMS_OUTPUT.put_line (
                     'Exception in Inserting Recommend Header ' || SQLERRM
                  );
            END;

            FOR rd IN cur_recommend_dtl (i.recommend_id)
            LOOP
               BEGIN
                  INSERT INTO xxpm_recommend_detail (recommend_dtl_id,
                                                     recommend_id,
                                                     seq_number,
                                                     installment_type,
                                                     installment_pct,
                                                     installment_amount,
                                                     criteria,
                                                     charge_type,
                                                     payment_term,
                                                     remarks,
                                                     due_date,
                                                     cheque_no,
                                                     cheque_date,
                                                     amount_received,
                                                     received_date,
                                                     bank_name,
                                                     payee_name,
                                                     status,
                                                     receipt_id,
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
                                                     last_update_login)
                    VALUES   (xxpm_recommend_dtl_id_s.NEXTVAL, --recommend_dtl_id
                              xxpm_recommend_id_s.CURRVAL,      --recommend_id
                              rd.seq_number,
                              rd.installment_type,
                              rd.installment_pct,
                              rd.installment_amount,
                              rd.criteria,
                              rd.charge_type,
                              rd.payment_term,
                              rd.remarks,
                              SYSDATE,                              --due_date
                              rd.cheque_no,
                              rd.cheque_date,
                              rd.amount_received,
                              rd.received_date,
                              rd.bank_name,
                              rd.payee_name,
                              rd.status,
                              rd.receipt_id,
                              rd.attribute_category,
                              rd.attribute1,
                              rd.attribute2,
                              rd.attribute3,
                              rd.attribute4,
                              rd.attribute5,
                              rd.attribute6,
                              rd.attribute7,
                              rd.attribute8,
                              rd.attribute9,
                              rd.attribute10,
                              rd.attribute11,
                              rd.attribute12,
                              rd.attribute13,
                              rd.attribute14,
                              rd.attribute15,
                              rd.attribute16,
                              rd.attribute17,
                              rd.attribute18,
                              rd.attribute19,
                              rd.attribute20,
                              rd.created_by,
                              SYSDATE,                         --creation_date
                              rd.last_updated_by,
                              SYSDATE,                      --last_update_date
                              rd.last_update_login);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     p_err_code := SQLCODE;
                     p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                     RETURN;
                     DBMS_OUTPUT.put_line (
                        'Exception in Inserting Recommend Detail ' || SQLERRM
                     );
               END;
            END LOOP;
         END LOOP;
      END LOOP;

      COMMIT;
   END;
END xxpm_offer_renew_pkg;
