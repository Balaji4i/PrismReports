--------------------------------------------------------
--  DDL for Package XXPM_LEASE_AGREEMENT_LOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_LEASE_AGREEMENT_LOAD_PKG" 
AS
   g_booking_code           VARCHAR2 (10)  := 'BK';
   g_recommend_code         VARCHAR2 (10)  := 'RC';
   g_lease_agreement_code   VARCHAR2 (10)  := 'LA';
   g_receipt_code           VARCHAR2 (10)  := 'RT';
   g_move_code              VARCHAR2 (10)  := 'MI';
   g_created_by             VARCHAR2 (100) := 'anonymous';
   g_update_login           VARCHAR2 (100) := 'anonymous';
   g_ovn                    NUMBER         := 1;

   FUNCTION get_lookup_value (
      p_lookup_type         IN   VARCHAR2,
      p_lookup_value_disp   IN   VARCHAR2
   )
      RETURN VARCHAR2;
   FUNCTION get_function_id (p_func_short_code IN VARCHAR2)
      RETURN NUMBER;      

   PROCEDURE validate_booking;

   PROCEDURE create_booking;

PROCEDURE validate_lease_milestone;
PROCEDURE create_lease_milestone;

   PROCEDURE validate_receipt;

   PROCEDURE create_receipt;

   PROCEDURE validate_move;

   PROCEDURE create_move;   
   
   --PROCEDURE delete_booking;
   procedure rollback_load;
   
END xxpm_lease_agreement_load_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_LEASE_AGREEMENT_LOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_LEASE_AGREEMENT_LOAD_PKG" 
AS
   FUNCTION get_lookup_value (
      p_lookup_type         IN   VARCHAR2,
      p_lookup_value_disp   IN   VARCHAR2
   )
      RETURN VARCHAR2
   IS
      l_lookup_value   VARCHAR2 (100);
   BEGIN
      SELECT lookup_value_name
        INTO l_lookup_value
        FROM xxfnd_lookup_types flt, xxfnd_lookup_values flv
       WHERE flt.lookup_type_id = flv.lookup_type_id
         AND flt.lookup_type_name = p_lookup_type
         AND UPPER (TRIM (flv.lookup_value_name_disp)) =
                                            UPPER (TRIM (p_lookup_value_disp))
         AND flv.active_yn = 'Y';

      RETURN l_lookup_value;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_lookup_value;

   FUNCTION get_function_id (p_func_short_code IN VARCHAR2)
      RETURN NUMBER
   IS
      l_func_id   NUMBER;
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

   PROCEDURE validate_booking
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_lease_agreement_hdr
          WHERE status IN ('NEW');



      l_booking_pay_method_code   VARCHAR2 (100);
      l_cust_category_code        VARCHAR2 (100);
      l_ms_hdr_id                 NUMBER;
      l_org_id                    NUMBER;
      l_property_id               NUMBER;
      l_building_id               NUMBER;
      l_unit_id                   NUMBER;
      l_visa_type_code            VARCHAR2 (100);
      l_nationality_code          VARCHAR2 (100);
      l_status                    VARCHAR2 (30);
      l_error_msg                 VARCHAR2 (2000);
      l_cust_id_ar                NUMBER;
      l_ship_site_count           NUMBER;
      l_bill_site_count           NUMBER;
      --Variable for validating milestone details
      l_total_booking             NUMBER          := 0;
      l_correct_records           NUMBER          := 0;
      l_milestone_type_code       VARCHAR2 (60);
      l_installment_type_code     VARCHAR2 (60);
      l_charge_type_code          VARCHAR2 (60);
      l_payment_term_id           VARCHAR2 (60);
      l_no_prop_unit_code         VARCHAR2 (30);
      l_purpose_of_rent_code      VARCHAR2 (30);
      l_discount_id               NUMBER;
      ln_booking_id               NUMBER;
      lc_booking_no               VARCHAR2 (30);
      lc_installment_type_code    VARCHAR2 (30);
      ln_ms_hdr_id                NUMBER;
      ln_term_id                  NUMBER;
      lc_term_name                VARCHAR2 (30);
      lc_seq_number               NUMBER;
      l_ms_dtl_id                 NUMBER;
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'VALIDATED';
         l_error_msg := NULL;
         l_booking_pay_method_code := NULL;
         l_visa_type_code := NULL;
         l_nationality_code := NULL;

         BEGIN
            SELECT org_id
              INTO l_org_id
              FROM xxstg_organizations
             WHERE UPPER (org_name) = UPPER (cr1.business_unit);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Exception getting Business Unit: ' || SQLERRM,
                          1,
                          2000
                         );
         --  GOTO skip_validate;
         END;

         BEGIN
            IF cr1.no_prop_unit IS NOT NULL
            THEN
               l_no_prop_unit_code :=
                   get_lookup_value ('RESIDENTIAL_DETAILS', cr1.no_prop_unit);

               IF l_no_prop_unit_code IS NULL
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR (   'Exception l_no_prop_unit_code is null: '
                             || SQLERRM,
                             1,
                             2000
                            );
               -- GOTO skip_validate;
               END IF;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting NO_PROP_UNIT_CODE: '
                             || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            l_booking_pay_method_code :=
                    get_lookup_value ('PAYMENT_MODE', cr1.booking_pay_method);

            IF l_booking_pay_method_code IS NULL
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Pay Method Code: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Pay Method Code: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            l_purpose_of_rent_code :=
                       get_lookup_value ('PURPOSE_OF_RENT', cr1.purpose_rent);

            IF l_purpose_of_rent_code IS NULL
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Purpose of Rent: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Purpose of Rent: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            l_visa_type_code := get_lookup_value ('VISA_TYPE', cr1.visa_type);

            IF l_visa_type_code IS NULL
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Visa type Code: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Visa type Code: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            l_nationality_code :=
                            get_lookup_value ('NATIONALITY', cr1.nationality);

            IF l_nationality_code IS NULL
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting nationality Code: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting nationality Code: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

        if cr1.discount_name is not null then
         BEGIN
            SELECT discount_id
              INTO l_discount_id
              FROM xxpm_pl_discounts
             WHERE UPPER (discount_name) = UPPER (cr1.discount_name);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Discount ID: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;
         end if;

         BEGIN
            SELECT ms_hdr_id
              INTO l_ms_hdr_id
              FROM xxpl_milestones_hdr
             WHERE UPPER (milestone_name) = UPPER (cr1.payment_plan);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Payment Plan ID: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            SELECT property_id
              INTO l_property_id
              FROM xxpl_property_master
             WHERE UPPER (property_name) = UPPER (cr1.property_name);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Property ID: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            SELECT build_id
              INTO l_building_id
              FROM xxpl_property_buildings
             WHERE UPPER (build_name) = UPPER (cr1.building_name)
               AND property_id = l_property_id;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Building ID: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         BEGIN
            SELECT unit_id
              INTO l_unit_id
              FROM xxpl_property_units
             WHERE UPPER (unit_name) = UPPER (cr1.unit_name)
               AND property_id = l_property_id
               AND build_id = l_building_id;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting unit ID: ' || SQLERRM, 1,
                             2000);
--               GOTO skip_validate;
         END;

         BEGIN
            IF UPPER (cr1.cust_category) = 'FAMILY'
            THEN
               l_cust_category_code := 'FMLY';
            ELSIF UPPER (cr1.cust_category) = 'BACHELOR'
            THEN
               l_cust_category_code := 'BCHLR';
            ELSE
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR
                        ('Exception getting Customer Category. You can enter Family or Bachelor',
                         1,
                         2000
                        );
--               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting unit ID: ' || SQLERRM, 1,
                             2000);
--               GOTO skip_validate;
         END;

         BEGIN
            SELECT cust_id
              INTO l_cust_id_ar
              FROM xxstg_customer
             WHERE UPPER (TRIM (customer_name)) =
                                           UPPER (TRIM (cr1.customer_name_ar))
               AND UPPER (customer_number) = UPPER (cr1.customer_number_ar);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception getting Customer AR: ' || SQLERRM,
                             1,
                             2000
                            );
--               GOTO skip_validate;
         END;

         IF cr1.ship_to_address IS NOT NULL
         THEN
            BEGIN
               SELECT COUNT (1)
                 INTO l_ship_site_count
                 FROM xxstg_cust_sites
                WHERE site_number = UPPER (cr1.ship_to_address)
                  AND cust_id = l_cust_id_ar;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR (   'Exception getting Ship to address: '
                                || SQLERRM,
                                1,
                                2000
                               );
--                  GOTO skip_validate;
            END;

            IF l_ship_site_count = 0
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Ship to Address does not exists', 1, 2000);
--               GOTO skip_validate;
            ELSIF l_ship_site_count > 1
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Multiple Ship to Address exists', 1, 2000);
--               GOTO skip_validate;
            END IF;
         END IF;

         IF cr1.bill_to_address IS NOT NULL
         THEN
            BEGIN
               SELECT COUNT (1)
                 INTO l_bill_site_count
                 FROM xxstg_cust_sites
                WHERE site_number = UPPER (cr1.bill_to_address)
                  AND cust_id = l_cust_id_ar;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR (   'Exception getting bill to address: '
                                || SQLERRM,
                                1,
                                2000
                               );
--                  GOTO skip_validate;
            END;

            IF l_bill_site_count = 0
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Bill to Address does not exists', 1, 2000);
--               GOTO skip_validate;
            ELSIF l_bill_site_count > 1
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Multiple Bill to Address exists', 1, 2000);
--               GOTO skip_validate;
            END IF;
         END IF;

         IF (cr1.total_rate <>
                (  NVL (cr1.base_rate, 0)
                 + NVL (cr1.electricity_charges, 0)
                 + NVL (cr1.municipality_charges, 0)
--                 + NVL (cr1.security_deposite, 0)
                 + NVL (cr1.tax_amount, 0)
                 - NVL (cr1.discount_rate, 0)
                )
            )
         THEN
            l_status := 'ERROR';
            l_error_msg :=
                  ' '
               || l_error_msg
               || ' '
               || CHR (10)
               || SUBSTR ('Total Amount doesnot match with detailed total.',
                          1,
                          2000
                         );
--            GOTO skip_validate;
         END IF;

         <<skip_validate>>
         IF l_status = 'VALIDATED'
         THEN
            UPDATE xxstg_lease_agreement_hdr
               SET booking_pay_method_code = l_booking_pay_method_code,
                   ms_hdr_id = l_ms_hdr_id,
                   org_id = l_org_id,
                   property_id = l_property_id,
                   building_id = l_building_id,
                   cust_category_code = l_cust_category_code,
                   visa_type_code = l_visa_type_code,
                   nationality_code = l_nationality_code,
                   unit_id = l_unit_id,
                   cust_id_ar = l_cust_id_ar,
                   purpose_rent_code = l_purpose_of_rent_code,
                   no_prop_unit_code = l_no_prop_unit_code,
                   discount_id = l_discount_id,
                   --BOOK_CUST_ID = l_BOOK_CUST_ID,
                   status = l_status,
                   error_msg = NULL
             WHERE s_no = cr1.s_no;
         ELSIF l_status = 'ERROR'
         THEN
            UPDATE xxstg_lease_agreement_hdr
               SET status = l_status,
                   error_msg = l_error_msg
             WHERE s_no = cr1.s_no;
         END IF;
      END LOOP;

      --Cursor for validating milestone details
     
   END validate_booking;

   PROCEDURE create_booking
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_lease_agreement_hdr
          WHERE status IN ('VALIDATED');

      l_offer_id             NUMBER;
      l_offer_func_id        NUMBER;
      l_offer_dtl_id         NUMBER;
      l_booking_id           NUMBER;
      l_booking_num          VARCHAR2 (30);
      l_function_id          NUMBER;
      l_status               VARCHAR2 (30);
      l_error_code           VARCHAR2 (100);
      l_error_msg            VARCHAR2 (2000);
      l_total_rent           NUMBER;
      l_hdr_count            NUMBER          := 0;
      l_book_cust_id         NUMBER          := 0;
      l_recommend_id         NUMBER          := 0;
      l_rec_func_id          NUMBER;
      l_recommend_num        VARCHAR2 (30);
      l_lease_agreement_id   NUMBER;
      l_lease_func_id        NUMBER;
      l_lease_number         VARCHAR2 (30);
      l_booking_dtl_id       NUMBER;
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'BH_SUCCESS';
         l_error_msg := NULL;
         l_hdr_count := 0;
         --l_function_id := get_function_id(g_booking_code);
         SAVEPOINT lease_creation;

         --Check if header is created. If Count is > 0 Booking header is
         -- already created for the booking group. So it will be skipped
         SELECT COUNT (1)
           INTO l_hdr_count
           FROM xxstg_lease_agreement_hdr
          WHERE booking_id IS NOT NULL AND booking_number = cr1.booking_number;

         --
         IF l_hdr_count = 0
         THEN
            l_booking_id := xxpm_booking_id_s.NEXTVAL;
--            xxfnd_pkg.get_next_number (p_func_code      => g_booking_code,
--                                       p_next_num       => l_booking_num,
--                                       p_func_id        => l_function_id,
--                                       p_err_code       => l_error_code,
--                                       p_err_msg        => l_error_msg
--                                      );
            l_function_id := get_function_id (g_booking_code);
            l_error_code := '0';
            l_error_msg := NULL;

            IF l_error_code <> '0'
            THEN
               l_status := 'BH_ERROR';
               l_error_msg :=
                  SUBSTR (   'Exception generating Booking code: '
                          || cr1.s_no
                          || '. Error Msg: '
                          || l_error_msg,
                          1,
                          2000
                         );
               ROLLBACK TO lease_creation;
               GOTO skip_create;
            END IF;

            BEGIN
               SELECT SUM (total_rate)
                 INTO l_total_rent
                 FROM xxstg_lease_agreement_hdr
                WHERE booking_number = cr1.booking_number;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'BH_ERROR';
                  l_error_msg :=
                     SUBSTR (   'Exception getting total rate: '
                             || cr1.s_no
                             || '. Error Msg: '
                             || SQLERRM,
                             1,
                             2000
                            );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

            BEGIN
               l_offer_id := offer_hdr_id_s.NEXTVAL;
               l_offer_func_id :=
                         xxpm_lease_agreement_load_pkg.get_function_id ('OF');

               INSERT INTO xxpm_offer_header
                           (offer_hdr_id, org_id, func_id,
                            offer_number, offer_date,
                            offer_from_date, offer_to_date, revision_no,
                            ms_hdr_id, status, description,
                            created_by, creation_date, last_updated_by,
                            last_update_date, last_update_login, currency,
                            offer_total, object_version_number, offer_flag,
                            property_id, building_id, lease_type
                           )
                    VALUES (l_offer_id, cr1.org_id, l_offer_func_id,
                            'OF-' || cr1.booking_number, cr1.booking_date,
                            cr1.lease_start_date, cr1.lease_end_date, 0,
                            cr1.ms_hdr_id, 'APR', 'Open Migration',
                            g_created_by, SYSDATE, g_created_by,
                            SYSDATE, g_update_login, 'AED',
                            cr1.booking_amount, 0, 'N',
                            cr1.property_id, cr1.building_id, 'DEFAULT'
                           );
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'BH_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Booking Header for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

            BEGIN
               INSERT INTO xxpm_booking_header
                           (booking_id, func_id, offer_hdr_id,
                            booking_number, booking_date,
                            booking_due_date, cust_req_movein_date,
                            performed_by, booking_amount,
                            booking_pay_method, currency,
                            total_rent, appointment_date, status,
                            description, flow_status, flow_level, flow_with,
                            created_by, creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            object_version_number, property_id, building_id,
                            org_id, user_grp_id, ms_hdr_id
                           )
                    VALUES (l_booking_id, l_function_id, NULL,
                            cr1.booking_number, cr1.booking_date,
                            cr1.booking_due_date, cr1.cust_req_movein_date,
                            NULL, cr1.booking_amount,
                            cr1.booking_pay_method_code, cr1.currency,
                            l_total_rent, cr1.appointment_date, 'APR',
                            NULL, NULL, NULL, NULL,
                            g_created_by, SYSDATE, g_created_by,
                            SYSDATE, g_update_login,
                            g_ovn, cr1.property_id, cr1.building_id,
                            cr1.org_id, NULL, cr1.ms_hdr_id
                           );
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'BH_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Booking Header for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

--            <<skip_bh_create>>
--            IF l_status = 'BH_SUCCESS'
--            THEN
--               UPDATE xxstg_lease_agreement_hdr
--                  SET booking_id = l_booking_id,
--                      status = l_status,
--                      error_msg = NULL
--                WHERE booking_number = cr1.booking_number;
--            ELSIF l_status = 'BH_ERROR'
--            THEN
--               UPDATE xxstg_lease_agreement_hdr
--                  SET status = l_status,
--                      error_msg = l_error_msg
--                WHERE booking_number = cr1.booking_number;
--            END IF;

            -- Loading Booking Customer Data
            BEGIN
               l_book_cust_id := xxpm_booking_cust_id_s.NEXTVAL;

               INSERT INTO xxpm_booking_customer
                           (book_cust_id, booking_id, cust_id, cust_site_id,
                            cust_contact_id, cust_name, trn_number,
                            cust_category, cust_acc_name,
                            ship_to_addr, bill_to_addr, religion,
                            visa_type, nationality,
                            cust_bank_name, cust_branch_name,
                            cust_bank_acc_number, created_by, creation_date,
                            last_updated_by, last_update_date,
                            last_update_login, customer_name_ar,
                            customer_number_ar, cust_id_ar
                           )
                    VALUES (l_book_cust_id, l_booking_id, NULL, NULL,
                            NULL, cr1.cust_name, cr1.trn_number,
                            cr1.cust_category_code, cr1.cust_acc_name,
                            cr1.ship_to_address, cr1.bill_to_address, NULL,
                            cr1.visa_type_code, cr1.nationality_code,
                            cr1.cust_bank_name, cr1.cust_branch_name,
                            cr1.cust_bank_acc_number, g_created_by, SYSDATE,
                            g_created_by, SYSDATE,
                            g_update_login, cr1.customer_name_ar,
                            cr1.customer_number_ar, cr1.cust_id_ar
                           );

               l_status := 'BC_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'BC_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Booking Customer for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

            -- Load Recommendation Data
            l_recommend_id := xxpm_recommend_id_s.NEXTVAL;
--            xxfnd_pkg.get_next_number (p_func_code      => g_recommend_code,
--                                       p_next_num       => l_recommend_num,
--                                       p_func_id        => l_rec_func_id,
--                                       p_err_code       => l_error_code,
--                                       p_err_msg        => l_error_msg
--                                      );
            l_rec_func_id := get_function_id (g_recommend_code);
            l_error_code := '0';
            l_error_msg := NULL;

            IF l_error_code <> '0'
            THEN
               l_status := 'RC_ERROR';
               l_error_msg :=
                  SUBSTR (   'Exception generating Recommendation code: '
                          || cr1.s_no
                          || '. Error Msg: '
                          || l_error_msg,
                          1,
                          2000
                         );
               ROLLBACK TO lease_creation;
               GOTO skip_create;
            END IF;

            BEGIN
               INSERT INTO xxpm_recommend_header
                           (recommend_id, func_id, booking_id,
                            recommend_number, status, description,
                            flow_status, flow_level, flow_with, created_by,
                            creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            object_version_number, org_id, property_id,
                            building_id, user_grp_id, recommend_date
                           )
                    VALUES (l_recommend_id, l_rec_func_id, l_booking_id,
                            cr1.recommend_number, 'APR', NULL,
                            NULL, NULL, NULL, g_created_by,
                            SYSDATE, g_created_by,
                            SYSDATE, g_update_login,
                            g_ovn, cr1.org_id, cr1.property_id,
                            cr1.building_id, NULL, cr1.recommendation_date
                           );

               l_status := 'RC_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'RC_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Recommendation for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

--Insert Lease Agreement header
--            SELECT NVL (MAX (lease_agreement_id), 0) + 1
--              INTO l_lease_agreement_id
--              FROM xxpm_lease_agreement;
            l_lease_agreement_id := lease_agreement_id_s.NEXTVAL;
            --l_lease_agreement_id := XXPM_RECOMMEND_ID_S.NEXTVAL;
--            xxfnd_pkg.get_next_number (p_func_code      => g_lease_agreement_code,
--                                       p_next_num       => l_lease_number,
--                                       p_func_id        => l_lease_func_id,
--                                       p_err_code       => l_error_code,
--                                       p_err_msg        => l_error_msg
--                                      );
            l_lease_func_id := get_function_id (g_lease_agreement_code);
            l_error_code := '0';
            l_error_msg := NULL;

            IF l_error_code <> '0'
            THEN
               l_status := 'LA_ERROR';
               l_error_msg :=
                  SUBSTR (   'Exception generating Lease agreement code: '
                          || cr1.s_no
                          || '. Error Msg: '
                          || l_error_msg,
                          1,
                          2000
                         );
               ROLLBACK TO lease_creation;
               GOTO skip_create;
            END IF;

            BEGIN
               INSERT INTO xxpm_lease_agreement
                           (lease_agreement_id, func_id,
                            booking_id, recommend_id,
                            tenancy_con_doc_no, status, description,
                            flow_status, flow_level, flow_with, created_by,
                            creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            lease_number, org_id, property_id,
                            building_id, user_grp_id, lease_start_date,
                            lease_end_date, residential_details,
                            purpose_of_rent,
                            no_of_years
                              -- PURPOSE_OF_RENT,NO_OF_YEARS added on  14-8-18
                           )
                    VALUES (l_lease_agreement_id, l_lease_func_id,
                            l_booking_id, l_recommend_id,
                            cr1.tenancy_con_doc_no, 'APR', NULL,
                            NULL, NULL, NULL, g_created_by,
                            cr1.lease_date, g_created_by,
                            SYSDATE, g_update_login,
                            cr1.lease_number, cr1.org_id, cr1.property_id,
                            cr1.building_id, NULL, cr1.lease_start_date,
                            cr1.lease_end_date, cr1.no_prop_unit_code,
                            cr1.purpose_rent_code,
                            cr1.no_of_years
                           );

               l_status := 'LA_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'LA_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Lease Agreement for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

            <<skip_create>>
            IF l_status = 'LA_SUCCESS'
            THEN
               UPDATE xxstg_lease_agreement_hdr
                  SET booking_id = l_booking_id,
                      offer_id = l_offer_id,
                      book_cust_id = l_book_cust_id,
                      recommend_id = l_recommend_id,
                      lease_agreement_id = l_lease_agreement_id,
                      status = l_status,
                      error_msg = NULL
                WHERE booking_number = cr1.booking_number;
            ELSE
               UPDATE xxstg_lease_agreement_hdr
                  SET status = l_status,
                      error_msg = l_error_msg
                WHERE booking_number = cr1.booking_number;
            END IF;
         END IF;

         l_status := NULL;
         l_error_msg := NULL;

         SELECT status
           INTO l_status
           FROM xxstg_lease_agreement_hdr
          WHERE s_no = cr1.s_no;

         -- Insert record in booking details only if header details are
         -- inserted successfully
         IF l_status = 'LA_SUCCESS'
         THEN
            BEGIN
               SELECT DISTINCT booking_id
                          INTO l_booking_id
                          FROM xxstg_lease_agreement_hdr
                         WHERE booking_number = cr1.booking_number;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'BD_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception creating booking milestone details: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || l_error_msg,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_line_create;
            END;

            IF l_booking_id IS NULL
            THEN
               l_status := 'BD_ERROR';
               l_error_msg :=
                  SUBSTR
                     (   'Exception getting booking id for booking detail: '
                      || cr1.s_no,
                      1,
                      2000
                     );
               ROLLBACK TO lease_creation;
               GOTO skip_line_create;
            END IF;

            BEGIN
               l_booking_dtl_id := xxpm_booking_dtl_id_s.NEXTVAL;

               INSERT INTO xxpm_booking_detail
                           (booking_dtl_id, booking_id, property_id,
                            building_id, unit_id, purpose, uom, quantity,
                            base_rate, total_rate, discount_rate,
                            tax_amount, tax_code, tax_rate, unit_avl_status,
                            unit_avl_from, created_by, creation_date,
                            last_updated_by, last_update_date,
                            last_update_login, security_deposite,
                            municipality_charges, electricity_charges
                           )
                    VALUES (l_booking_dtl_id, l_booking_id, cr1.property_id,
                            cr1.building_id, cr1.unit_id, NULL, NULL, NULL,
                            cr1.base_rate, cr1.total_rate,
                                                          /*cr1.discount_rate*/
                                                          cr1.discount_id,
                            cr1.tax_amount, NULL, NULL, NULL,
                            NULL,
                                 --Need to check actual values for UNIT_AVL_STATUS, UNIT_AVL_FROM
                                 g_created_by, SYSDATE,
                            g_created_by, SYSDATE,
                            g_update_login, cr1.security_deposite,
                            cr1.municipality_charges, cr1.electricity_charges
                           );

               l_status := 'BD_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'BD_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Booking Details for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
            --GOTO skip_create;
            END;

            BEGIN
               SELECT DISTINCT offer_id
                          INTO l_offer_id
                          FROM xxstg_lease_agreement_hdr
                         WHERE booking_number = cr1.booking_number;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'OF_ERROR';
                  l_error_msg :=
                     SUBSTR (   'Exception creating offer details: '
                             || cr1.s_no
                             || '. Error Msg: '
                             || l_error_msg,
                             1,
                             2000
                            );
                  ROLLBACK TO lease_creation;
                  GOTO skip_line_create;
            END;

            IF l_offer_id IS NULL
            THEN
               l_status := 'OF_ERROR';
               l_error_msg :=
                  SUBSTR (   'Exception getting offer id for offer detail: '
                          || cr1.s_no,
                          1,
                          2000
                         );
               ROLLBACK TO lease_creation;
               GOTO skip_line_create;
            END IF;

            --Insert offer details
            BEGIN
               l_offer_dtl_id := offer_dtl_id_s.NEXTVAL;

               INSERT INTO xxpm_offer_detail
                           (offer_dtl_id, offer_hdr_id, property_id,
                            building_id, unit_id, purpose, uom, quantity,
                            base_rate, total_rate, discount_amount,
                            tax_amount, tax_code, tax_rate, created_by,
                            creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            security_deposite, municipality_charges,
                            electricity_charges
                           )
                    VALUES (l_offer_dtl_id, l_offer_id, cr1.property_id,
                            cr1.building_id, cr1.unit_id, NULL, NULL, NULL,
                            cr1.base_rate, cr1.total_rate, cr1.discount_id,
                            cr1.tax_amount, NULL, NULL, g_created_by,
                            SYSDATE, g_created_by,
                            SYSDATE, g_update_login,
                            cr1.security_deposite, cr1.municipality_charges,
                            cr1.electricity_charges
                           );

               l_status := 'BD_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'OF_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Booking Details for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
            --GOTO skip_create;
            END;

            <<skip_line_create>>
            IF l_status = 'BD_SUCCESS'
            THEN
               UPDATE xxstg_lease_agreement_hdr
                  SET booking_dtl_id = l_booking_dtl_id,
                      status = l_status,
                      error_msg = NULL
                WHERE s_no = cr1.s_no;
            ELSE
               UPDATE xxstg_lease_agreement_hdr
                  SET status = l_status,
                      error_msg = l_error_msg
                WHERE s_no = cr1.s_no;
            END IF;
         END IF;
      END LOOP;
   END create_booking;

procedure validate_lease_milestone
is
      CURSOR c2
      IS
         SELECT *
           FROM xxstg_lease_ms_dtl
          WHERE status IN ('NEW');
          
          
      
      --Variable for validating milestone details
      l_status                    VARCHAR2 (30);
      l_error_msg                 VARCHAR2 (2000);
      l_total_booking             NUMBER          := 0;
      l_correct_records           NUMBER          := 0;
      l_milestone_type_code       VARCHAR2 (60);
      l_installment_type_code     VARCHAR2 (60);
      l_charge_type_code          VARCHAR2 (60);
      l_payment_term_id           VARCHAR2 (60);
      l_no_prop_unit_code         VARCHAR2 (30);
      l_purpose_of_rent_code      VARCHAR2 (30);
      l_discount_id               NUMBER;
      ln_booking_id               NUMBER;
      lc_booking_no               VARCHAR2 (30);
      lc_installment_type_code    VARCHAR2 (30);
      ln_ms_hdr_id                NUMBER;
      ln_term_id                  NUMBER;
      lc_term_name                VARCHAR2 (30);
      lc_seq_number               NUMBER;
      l_ms_dtl_id                 NUMBER;
begin
 FOR cr2 IN c2
      LOOP
         l_status := 'VALIDATED';
         l_error_msg := NULL;
         l_milestone_type_code := NULL;
         l_installment_type_code := NULL;
         l_charge_type_code := NULL;
         l_payment_term_id := NULL;
         l_total_booking := 0;
         l_correct_records := 0;
         lc_seq_number  := null;
         l_ms_dtl_id := null;

         BEGIN
            IF cr2.booking_number IS NULL
            THEN
               SELECT booking_id
                 INTO ln_booking_id
                 FROM xxpm_lease_agreement
                WHERE lease_number = cr2.lease_number;

               DBMS_OUTPUT.put_line ('LN_BOOKING_ID: ' || ln_booking_id);

               SELECT booking_number
                 INTO lc_booking_no
                 FROM xxpm_booking_header
                WHERE booking_id = ln_booking_id;

               DBMS_OUTPUT.put_line ('LC_BOOKING_NO: ' || lc_booking_no);

               UPDATE xxstg_lease_ms_dtl
                  SET booking_number = lc_booking_no
                WHERE s_no = cr2.s_no;
            ELSE
               DBMS_OUTPUT.put_line ('Inside Booking Else Part...');
               lc_booking_no := cr2.booking_number;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception in getting Booking No: ' || SQLERRM,
                             1,
                             2000
                            );
               GOTO skip_ms_validate;
         END;

         BEGIN
            lc_installment_type_code :=
               get_lookup_value ('MILESTONE_INSTALLMENT',
                                 cr2.installment_type
                                );
            DBMS_OUTPUT.put_line (   'lc_installment_type_code: '
                                  || lc_installment_type_code
                                 );
            DBMS_OUTPUT.put_line ('LC_BOOKING_NO: ' || lc_booking_no);

            SELECT ms_hdr_id
              INTO ln_ms_hdr_id
              FROM xxpm_booking_header
             WHERE booking_number = lc_booking_no;

            DBMS_OUTPUT.put_line ('ln_ms_hdr_id: ' || ln_ms_hdr_id);

            SELECT payment_term,seq_number,ms_dtl_id
              INTO ln_term_id,lc_seq_number,l_ms_dtl_id
              FROM xxpl_milestones_dtl
             WHERE ms_hdr_id = ln_ms_hdr_id
               AND installment_type = lc_installment_type_code;

            DBMS_OUTPUT.put_line ('ln_term_id: ' || ln_term_id);

            SELECT term_name
              INTO lc_term_name
              FROM xxstg_pay_terms
             WHERE term_id = ln_term_id;

            DBMS_OUTPUT.put_line ('lc_term_name: ' || lc_term_name);

            UPDATE xxstg_lease_ms_dtl
               SET payment_term = lc_term_name
             WHERE s_no = cr2.s_no;

            DBMS_OUTPUT.put_line (   'lc_installment_type_code  '
                                  || lc_installment_type_code
                                  || 'LC_BOOKING_NO '
                                  || lc_booking_no
                                  || 'ln_ms_hdr_id '
                                  || ln_ms_hdr_id
                                  || ' lc_term_name '
                                  || lc_term_name
                                 );
         EXCEPTION
            WHEN OTHERS
            THEN
               DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Exception in getting Payment Term: ' || SQLERRM,
                             1,
                             2000
                            );
         END;

         SELECT COUNT (1),
                SUM (DECODE (status, 'VALIDATED', 1, 'BD_SUCCESS', 1, 0))
                                                              correct_records
           INTO l_total_booking,
                l_correct_records
           FROM xxstg_lease_agreement_hdr
          WHERE booking_number = lc_booking_no
            AND lease_number = cr2.lease_number;

         IF l_total_booking = l_correct_records
         THEN
            IF UPPER (cr2.milestone_type) = 'CONTRACT PAYMENTS'
            THEN
               l_milestone_type_code := 'BK';
            ELSIF UPPER (cr2.milestone_type) = 'OTHER CHARGES'
            THEN
               l_milestone_type_code := 'OT';
            ELSE
               l_status := 'ERROR';
               l_error_msg :=
                     ' '
                  || l_error_msg
                  || ' '
                  || CHR (10)
                  || SUBSTR ('Entered Milestone Type is incorrect', 1, 2000);
--               GOTO skip_ms_validate;
            END IF;

            BEGIN
               IF UPPER (cr2.milestone_type) = 'CONTRACT PAYMENTS'
               THEN
                  IF UPPER (cr2.installment_type) = 'SECURITY DEPOSIT'
                  THEN
                     l_installment_type_code :=
                        get_lookup_value ('OTHER_PAYMENT_TYPE',
                                          cr2.installment_type
                                         );
                  ELSE
                     l_installment_type_code :=
                        get_lookup_value ('MILESTONE_INSTALLMENT',
                                          cr2.installment_type
                                         );
                  END IF;
               ELSIF UPPER (cr2.milestone_type) = 'OTHER CHARGES'
               THEN
                  l_installment_type_code :=
                     get_lookup_value ('OTHER_PAYMENT_TYPE',
                                       cr2.installment_type
                                      );
               END IF;

               IF l_installment_type_code IS NULL
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR
                              (   'Exception getting Installment type Code: '
                               || SQLERRM,
                               1,
                               2000
                              );
--                  GOTO skip_ms_validate;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR
                              (   'Exception getting Installment type Code: '
                               || SQLERRM,
                               1,
                               2000
                              );
--                  GOTO skip_ms_validate;
            END;

            BEGIN
               l_charge_type_code :=
                            get_lookup_value ('CHARGE_TYPE', cr2.charge_type);

               IF l_charge_type_code IS NULL
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR (   'Exception getting charge type Code: '
                                || SQLERRM,
                                1,
                                2000
                               );
--                  GOTO skip_ms_validate;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR (   'Exception getting charge type Code: '
                                || SQLERRM,
                                1,
                                2000
                               );
--                  GOTO skip_ms_validate;
            END;

            BEGIN
               SELECT term_id
                 INTO l_payment_term_id
                 FROM xxstg_pay_terms
                WHERE UPPER (term_name) = UPPER (lc_term_name);

               IF l_payment_term_id IS NULL
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR (   'Exception getting payment term id: '
                                || SQLERRM,
                                1,
                                2000
                               );
--                  GOTO skip_ms_validate;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                        ' '
                     || l_error_msg
                     || ' '
                     || CHR (10)
                     || SUBSTR (   'Exception getting payment term id 1: '
                                || SQLERRM,
                                1,
                                2000
                               );
--                  GOTO skip_ms_validate;
            END;
         ELSIF l_total_booking = 0
         THEN
            l_status := 'ERROR';
            l_error_msg :=
                  ' '
               || l_error_msg
               || ' '
               || CHR (10)
               || SUBSTR ('No Booking Header exists for the Milestone line',
                          1,
                          2000
                         );
--            GOTO skip_ms_validate;
         ELSIF l_total_booking <> l_correct_records
         THEN
            l_status := 'ERROR';
            l_error_msg :=
                  ' '
               || l_error_msg
               || ' '
               || CHR (10)
               || SUBSTR ('Some lines in Booking header is not validated',
                          1,
                          2000
                         );
--            GOTO skip_ms_validate;
         END IF;

         <<skip_ms_validate>>
         IF l_status = 'VALIDATED'
         THEN
            UPDATE xxstg_lease_ms_dtl
               SET milestone_type_code = l_milestone_type_code,
                   installment_type_code = l_installment_type_code,
                   charge_type_code = l_charge_type_code,
                   payment_term_id = l_payment_term_id,
                   seq_number = lc_seq_number,
                   ms_dtL_id = l_ms_dtl_id,
                   status = l_status,
                   error_msg = NULL
             WHERE s_no = cr2.s_no;
         ELSIF l_status = 'ERROR'
         THEN
            UPDATE xxstg_lease_ms_dtl
               SET status = l_status,
                   error_msg = l_error_msg
             WHERE s_no = cr2.s_no;
         END IF;
      END LOOP;
end validate_lease_milestone; 

   PROCEDURE create_lease_milestone
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_lease_ms_dtl
          WHERE status IN ('VALIDATED')
          order by BOOKING_NUMBER, LEASE_NUMBER, INSTALLMENT_TYPE_CODE asc;

      l_status              VARCHAR2 (30);
      l_error_msg           VARCHAR2 (2000);
      l_total_booking       NUMBER          := 0;
      l_correct_records     NUMBER          := 0;
      l_booking_ms_dtl_id   NUMBER          := 0;
      l_booking_id          NUMBER          := 0;
      l_seq_number          NUMBER          := 0;
      l_offer_id            NUMBER          := 0;     
      l_OFFER_MS_DTL_ID     NUMBER          := 0;
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'SUCCESS';
         l_error_msg := NULL;
         l_total_booking := 0;
         l_correct_records := 0;
         l_booking_id := 0;
         SAVEPOINT lease_creation;

         SELECT COUNT (1),
                SUM (DECODE (status, 'BD_SUCCESS', 1, 0)) correct_records
           INTO l_total_booking,
                l_correct_records
           FROM xxstg_lease_agreement_hdr
          WHERE booking_number = cr1.booking_number
            AND lease_number = cr1.lease_number;

         IF l_total_booking = l_correct_records
         THEN
            BEGIN
               SELECT DISTINCT booking_id,offer_id
                          INTO l_booking_id,l_offer_id
                          FROM xxstg_lease_agreement_hdr
                         WHERE booking_number = cr1.booking_number
                           AND status = 'BD_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR (   'Exception getting booking id'
                             || cr1.s_no
                             || '. Error Msg: '
                             || SQLERRM,
                             1,
                             2000
                            );
                  ROLLBACK TO lease_creation;
            --GOTO skip_create;
            END;
--Sequence Number taken from xxpl_milestones_dtl table. Since  it is not accurate 
-- we are not using it.
            SELECT NVL (MAX (seq_number), 0) + 1
              INTO l_seq_number
              FROM xxstg_lease_ms_dtl
             WHERE booking_id = l_booking_id;

            l_booking_ms_dtl_id := booking_ms_dtl_id_s.NEXTVAL;
            
            BEGIN
               INSERT INTO xxpm_booking_milestone_detail
                           (booking_ms_dtl_id, booking_hdr_id,
                            offer_ms_dtl_id, seq_number, installment_type,
                            installment_pct, installment_amount,
                            criteria, charge_type, payment_term,
                            remarks, due_date, created_by,
                            creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            milestone_type
                           )
                    VALUES (l_booking_ms_dtl_id, l_booking_id,
                            NULL, l_seq_number/*cr1.seq_number*/, cr1.installment_type_code,
                            cr1.installment_pct, cr1.installment_amount,
                            NULL, cr1.charge_type_code, cr1.payment_term_id,
                            cr1.remarks, cr1.due_date, g_created_by,
                            SYSDATE, g_created_by,
                            SYSDATE, g_update_login,
                            cr1.milestone_type_code
                           );

               l_status := 'SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Booking Details for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                --  ROLLBACK TO lease_creation;
            --GOTO skip_create;
            END;            
            
            --Load offer milestone
            l_OFFER_MS_DTL_ID := OFFER_MS_DTL_ID.nextval;

            BEGIN
               INSERT INTO XXPM_offer_MILESTONE_DETAIL
                           (OFFER_MS_DTL_ID, OFFER_HDR_ID, MS_DTL_ID,
                            seq_number, installment_type,
                            installment_pct, installment_amount,
                            criteria, charge_type, payment_term,
                            remarks, due_date, created_by,
                            creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            milestone_type
                           )
                    VALUES (l_OFFER_MS_DTL_ID,l_offer_id,cr1.ms_dtl_id,
                            l_seq_number/*cr1.seq_number*/, cr1.installment_type_code,
                            cr1.installment_pct, cr1.installment_amount,
                            NULL, cr1.charge_type_code, cr1.payment_term_id,
                            cr1.remarks, cr1.due_date, g_created_by,
                            SYSDATE, g_created_by,
                            SYSDATE, g_update_login,
                            cr1.milestone_type_code
                           );

               l_status := 'SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Offer Milestone Details for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                --  ROLLBACK TO lease_creation;
            --GOTO skip_create;
            END;
         ELSIF l_total_booking = 0
         THEN
            l_status := 'ERROR';
            l_error_msg :=
               SUBSTR ('No Booking Header exists for the Milestone line',
                       1,
                       2000
                      );
            GOTO skip_create;
         ELSIF l_total_booking <> l_correct_records
         THEN
            l_status := 'ERROR';
            l_error_msg :=
               SUBSTR ('Booking Header is not created for booking line',
                       1,
                       2000
                      );
            GOTO skip_create;
         END IF;

         <<skip_create>>
         IF l_status = 'SUCCESS'
         THEN
            UPDATE xxstg_lease_ms_dtl
               SET booking_ms_dtl_id = l_booking_ms_dtl_id,
                   booking_id = l_booking_id,
                   seq_number = l_seq_number,
                   status = l_status,
                   error_msg = NULL
             WHERE s_no = cr1.s_no;
         ELSE
            UPDATE xxstg_lease_ms_dtl
               SET status = l_status,
                   error_msg = l_error_msg
             WHERE s_no = cr1.s_no;
         END IF;
      END LOOP;
   END create_lease_milestone;

   PROCEDURE validate_receipt
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_receipt
          WHERE status IN ('NEW');

      l_source_func_ref_id          NUMBER;
      l_pay_mode_code               VARCHAR2 (60);
      l_rct_type_code               VARCHAR2 (60);
      l_booking_type_code           VARCHAR2 (60);
      l_book_customer_name          VARCHAR2 (250);
      l_book_currency_code          VARCHAR2 (10);
      l_booking_ms_dtl_id           NUMBER;
      l_customer_trx_id             NUMBER;
      l_receivable_application_id   NUMBER;
      l_status                      VARCHAR2 (30);
      l_error_msg                   VARCHAR2 (2000);
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'VALIDATED';
         l_error_msg := NULL;
         l_booking_type_code := NULL;
         l_pay_mode_code := NULL;
         l_rct_type_code := NULL;
         l_booking_ms_dtl_id := NULL;
         l_book_customer_name := NULL;
         l_book_currency_code := NULL;

         BEGIN
            IF UPPER (cr1.receipt_ref_type) = 'BOOKING'
            THEN
               BEGIN
                  SELECT DISTINCT booking_id
                             INTO l_source_func_ref_id
                             FROM xxstg_lease_agreement_hdr
                            WHERE booking_number = cr1.receipt_ref_num;

                  IF l_source_func_ref_id IS NULL
                  THEN
                     l_status := 'ERROR';
                     l_error_msg :=
                        SUBSTR (   'Booking ID from Booking Number is null.'
                                || SQLERRM,
                                1,
                                2000
                               );
                     GOTO skip_validate;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     l_status := 'ERROR';
                     l_error_msg :=
                        SUBSTR
                           (   'Exception Getting Booking ID from Booking Number.'
                            || SQLERRM,
                            1,
                            2000
                           );
                     GOTO skip_validate;
               END;
            ELSIF UPPER (cr1.receipt_ref_type) = 'LEASE AGREEMENT'
            THEN
               BEGIN
                  SELECT DISTINCT booking_id
                             INTO l_source_func_ref_id
                             FROM xxstg_lease_agreement_hdr
                            WHERE lease_number = cr1.receipt_ref_num;

                  IF l_source_func_ref_id IS NULL
                  THEN
                     l_status := 'ERROR';
                     l_error_msg :=
                        SUBSTR (   'Booking ID from Lease Number is null.'
                                || SQLERRM,
                                1,
                                2000
                               );
                     GOTO skip_validate;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     l_status := 'ERROR';
                     l_error_msg :=
                        SUBSTR
                           (   'Exception Getting Booking ID from Lease Number.'
                            || SQLERRM,
                            1,
                            2000
                           );
                     GOTO skip_validate;
               END;
            ELSE
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Incorrect Receipt Reference Type entered.',
                          1,
                          2000
                         );
               GOTO skip_validate;
            END IF;
         END;

         BEGIN
--            SELECT xs.customer_name
--              INTO l_book_customer_name
--              FROM xxpm_booking_customer xbc, xxstg_customer xs
--             WHERE 1 = 1
--               AND xs.cust_id = xbc.cust_id_ar
--               AND xbc.booking_id = l_source_func_ref_id;
            SELECT cust_name
              INTO l_book_customer_name
              FROM xxpm_booking_customer
             WHERE booking_id = l_source_func_ref_id;

            IF UPPER (TRIM (l_book_customer_name)) =
                                              UPPER (TRIM (cr1.customer_name))
            THEN
               NULL;
            ELSE
               l_status := 'ERROR';
               l_error_msg :=
                         SUBSTR ('Incorrect Customer Name entered.', 1, 2000);
               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Exception validating customer Name: ' || SQLERRM,
                          1,
                          2000
                         );
               GOTO skip_validate;
         END;

--l_book_currency_code
         BEGIN
            SELECT currency
              INTO l_book_currency_code
              FROM xxpm_booking_header
             WHERE booking_id = l_source_func_ref_id;

            IF UPPER (l_book_currency_code) = UPPER (cr1.currency_code)
            THEN
               NULL;
            ELSE
               l_status := 'ERROR';
               l_error_msg :=
                         SUBSTR ('Incorrect Currency Code entered.', 1, 2000);
               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Exception Validating Currency Code: ' || SQLERRM,
                          1,
                          2000
                         );
               GOTO skip_validate;
         END;

         BEGIN
            l_pay_mode_code :=
                              get_lookup_value ('PAYMENT_MODE', cr1.pay_mode);

            IF l_pay_mode_code IS NULL
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Exception getting Payment Mode Code: ' || SQLERRM,
                          1,
                          2000
                         );
               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Exception getting Payment Mode Code: ' || SQLERRM,
                          1,
                          2000
                         );
               GOTO skip_validate;
         END;

         IF cr1.rct_type IS NOT NULL
         THEN
            BEGIN
               l_rct_type_code :=
                              get_lookup_value ('CHARGE_CODES', cr1.rct_type);

               IF l_rct_type_code IS NULL
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR
                          (   'Exception getting Receipt Charge Type Code: '
                           || SQLERRM,
                           1,
                           2000
                          );
                  GOTO skip_validate;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR
                          (   'Exception getting Receipt Charge Type Code: '
                           || SQLERRM,
                           1,
                           2000
                          );
                  GOTO skip_validate;
            END;
         END IF;

         --Get Booking Milestone ID for receipt details
         IF cr1.booking_type IS NOT NULL
         THEN
            BEGIN
               IF get_lookup_value ('MILESTONE_INSTALLMENT',
                                    cr1.booking_type) IS NOT NULL
               THEN
                  l_booking_type_code :=
                     get_lookup_value ('MILESTONE_INSTALLMENT',
                                       cr1.booking_type
                                      );
               ELSIF get_lookup_value ('OTHER_PAYMENT_TYPE', cr1.booking_type) IS NOT NULL
               THEN
                  l_booking_type_code :=
                     get_lookup_value ('OTHER_PAYMENT_TYPE',
                                       cr1.booking_type);
               END IF;

               IF l_booking_type_code IS NULL
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR ('Exception getting Booking type Code: '
                             || SQLERRM,
                             1,
                             2000
                            );
                  GOTO skip_validate;
               ELSE
                  BEGIN
                     SELECT DISTINCT booking_ms_dtl_id
                                INTO l_booking_ms_dtl_id
                                FROM xxpm_booking_milestone_detail
                               WHERE installment_type = l_booking_type_code
                                 AND booking_hdr_id = l_source_func_ref_id;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        l_status := 'ERROR';
                        l_error_msg :=
                           SUBSTR
                              (   'Exception getting Booking milestone id: '
                               || SQLERRM,
                               1,
                               2000
                              );
                        GOTO skip_validate;
                  END;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR ('Exception getting Booking type Code: '
                             || SQLERRM,
                             1,
                             2000
                            );
                  GOTO skip_validate;
            END;
         END IF;

         <<skip_validate>>
         IF l_status = 'VALIDATED'
         THEN
            UPDATE xxstg_receipt
               SET pay_mode_code = l_pay_mode_code,
                   rct_type_code = l_rct_type_code,
                   booking_ms_dtl_id = l_booking_ms_dtl_id,
                   source_func_ref_id = l_source_func_ref_id,
                   customer_name = l_book_customer_name,
                   status = l_status,
                   error_msg = NULL
             WHERE s_no = cr1.s_no;
         ELSIF l_status = 'ERROR'
         THEN
            UPDATE xxstg_receipt
               SET status = l_status,
                   error_msg = l_error_msg
             WHERE s_no = cr1.s_no;
         END IF;
      END LOOP;
   END validate_receipt;

   PROCEDURE create_receipt
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_receipt
          WHERE status IN ('VALIDATED');

      l_status           VARCHAR2 (30);
      l_error_code       VARCHAR2 (100);
      l_error_msg        VARCHAR2 (2000);
      l_receipt_num      VARCHAR2 (30);
      l_receipt_id       NUMBER;
      l_function_id      NUMBER;
      l_receipt_dtl_id   NUMBER;
      l_hdr_count        NUMBER          := 0;
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'HDR_SUCCESS';
         l_error_msg := NULL;
         l_receipt_num := NULL;
         l_receipt_id := NULL;
         l_receipt_dtl_id := NULL;
         l_function_id := NULL;
         SAVEPOINT receipt_creation;
         l_hdr_count := 0;

         --Check if header is created. If Count is > 0 Receipt header is
         -- already created for the receipt group. So it will be skipped
         SELECT COUNT (1)
           INTO l_hdr_count
           FROM xxstg_receipt
          WHERE receipt_id IS NOT NULL AND receipt_number = cr1.receipt_number;

         --
         IF l_hdr_count = 0
         THEN
            l_receipt_id := xxpm_receipt_id_s.NEXTVAL;
--            xxfnd_pkg.get_next_number (p_func_code      => g_receipt_code,
--                                       p_next_num       => l_receipt_num,
--                                       p_func_id        => l_function_id,
--                                       p_err_code       => l_error_code,
--                                       p_err_msg        => l_error_msg
--                                      );
            l_function_id := get_function_id (g_receipt_code);
            l_error_code := '0';
            l_error_msg := NULL;

            BEGIN
               INSERT INTO xxpm_receipt
                           (receipt_id, func_id, source_func_id,
                            source_func_ref_id, receipt_number,
                            receipt_date, org_id, receipt_type, property_id,
                            unit_id, build_id, lead_id, cust_id,
                            cust_site_id, salesman_id, customer_name,
                            currency_code, receipt_amount,
                            pay_mode, pay_ref_number,
                            pay_ref_date, bank_name,
                            bank_branch_name, drawn_by, status,
                            description, flow_status, flow_level, flow_with,
                            tax_amount, tax_code, tax_rate,
                            created_by, creation_date, last_updated_by,
                            last_update_date, last_update_login,
                            recommended_amount, received_amount,
                            diff_in_days, pay_rec_date, pay_rev_date,
                            rct_type, rct_desc
                           )
                    VALUES (l_receipt_id, l_function_id, NULL,
                            cr1.source_func_ref_id, cr1.receipt_number,
                            cr1.receipt_date, NULL, NULL, NULL,
                            NULL, NULL, NULL, NULL,
                            NULL, NULL, cr1.customer_name,
                            cr1.currency_code, cr1.receipt_amount,
                            cr1.pay_mode_code, cr1.pay_ref_number,
                            cr1.pay_ref_date, cr1.bank_name,
                            cr1.bank_branch_name, cr1.drawn_by, NULL,
                            cr1.description, NULL, NULL, NULL,
                            cr1.tax_amount, cr1.tax_code, cr1.tax_rate,
                            g_created_by, SYSDATE, g_created_by,
                            SYSDATE, g_update_login,
                            cr1.recommended_amount, cr1.received_amount,
                            cr1.diff_in_days, cr1.pay_rec_date, NULL,
                            cr1.rct_type, NULL
                           );

               l_status := 'HDR_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in Receipt Header for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO lease_creation;
                  GOTO skip_create;
            END;

            <<skip_create>>
            IF l_status = 'HDR_SUCCESS'
            THEN
               UPDATE xxstg_receipt
                  SET receipt_id = l_receipt_id,
                      status = l_status,
                      error_msg = NULL
                WHERE s_no = cr1.s_no;
            ELSE
               UPDATE xxstg_receipt
                  SET status = l_status,
                      error_msg = l_error_msg
                WHERE s_no = cr1.s_no;
            END IF;
         END IF;

         l_status := NULL;
         l_error_msg := NULL;
         l_receipt_dtl_id := 0;
         l_receipt_id := 0;

         IF cr1.booking_type IS NOT NULL
         THEN
            BEGIN
               SELECT DISTINCT receipt_id
                          INTO l_receipt_id
                          FROM xxstg_receipt
                         WHERE receipt_number = cr1.receipt_number;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'DTL_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception getting receipt id for receipt details: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || l_error_msg,
                         1,
                         2000
                        );
                  ROLLBACK TO receipt_creation;
                  GOTO skip_line_create;
            END;

            IF l_receipt_id IS NULL
            THEN
               l_status := 'DTL_ERROR';
               l_error_msg :=
                  SUBSTR
                     (   'Exception getting receipt id for receipt detail. No Receipt Id Found'
                      || cr1.s_no,
                      1,
                      2000
                     );
               ROLLBACK TO receipt_creation;
               GOTO skip_line_create;
            END IF;

            l_receipt_dtl_id := receipt_dtl_id_s.NEXTVAL;

            BEGIN
               INSERT INTO xxpm_receipt_details
                           (receipt_dtl_id, receipt_id,
                            booking_ms_dtl_id, amount_applied,
                            applied_date, receivable_application_id,
                            customer_trx_id, created_by, creation_date,
                            last_updated_by, last_update_date,
                            last_update_login
                           )
                    VALUES (l_receipt_dtl_id, l_receipt_id,
                            cr1.booking_ms_dtl_id, cr1.amount_applied,
                            cr1.applied_date, cr1.receivable_application_id,
                            cr1.customer_trx_id, g_created_by, SYSDATE,
                            g_created_by, SYSDATE,
                            g_update_login
                           );

               l_status := 'DTL_SUCCESS';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_status := 'DTL_ERROR';
                  l_error_msg :=
                     SUBSTR
                        (   'Exception Inserting in receipt Details for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
                  ROLLBACK TO receipt_creation;
                  GOTO skip_line_create;
            END;

            <<skip_line_create>>
            IF l_status = 'DTL_SUCCESS'
            THEN
               UPDATE xxstg_receipt
                  SET receipt_dtl_id = l_receipt_dtl_id,
                      status = l_status,
                      error_msg = NULL
                WHERE s_no = cr1.s_no;
            ELSE
               UPDATE xxstg_receipt
                  SET status = l_status,
                      error_msg = l_error_msg
                WHERE s_no = cr1.s_no;
            END IF;
         END IF;
      END LOOP;
   END create_receipt;

   PROCEDURE validate_move
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_move_in_out
          WHERE status IN ('NEW');

      l_status               VARCHAR2 (30);
      l_error_msg            VARCHAR2 (2000);
      l_booking_id           NUMBER;
      l_lease_agreement_id   NUMBER;
      l_building_id          NUMBER;
      l_property_id          NUMBER;
      l_org_id               NUMBER;
      l_lease_end_date       DATE;
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'VALIDATED';
         l_error_msg := NULL;
         l_booking_id := NULL;
         l_lease_end_date := NULL;
         l_lease_agreement_id := NULL;
         l_building_id := NULL;
         l_property_id := NULL;
         l_org_id := NULL;

         BEGIN
            SELECT DISTINCT booking_id,
                            lease_agreement_id      --,building_id,property_id
                       INTO l_booking_id,
                            l_lease_agreement_id
                       --,l_building_id,l_property_id
            FROM            xxstg_lease_agreement_hdr xlah
                      WHERE UPPER (xlah.lease_number) =
                                                      UPPER (cr1.lease_number)
                        AND UPPER (xlah.booking_number) =
                                                    UPPER (cr1.booking_number);

            IF l_booking_id IS NULL OR l_lease_agreement_id IS NULL
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR
                        ('Invalid Booking Number or Lease Agreement Number.',
                         1,
                         2000
                        );
               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR
                     (   'Exception getting booking and lease agreement id: '
                      || SQLERRM,
                      1,
                      2000
                     );
               GOTO skip_validate;
         END;

         BEGIN
            SELECT property_id, building_id, org_id
              INTO l_property_id, l_building_id, l_org_id
              FROM xxpm_booking_header
             WHERE booking_id = l_booking_id;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                    SUBSTR ('Exception getting org_id: ' || SQLERRM, 1, 2000);
               GOTO skip_validate;
         END;

         BEGIN
            SELECT lease_end_date
              INTO l_lease_end_date
              FROM xxpm_lease_agreement
             WHERE lease_agreement_id = l_lease_agreement_id;

            IF l_lease_end_date < cr1.move_in_out_date
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR
                     ('Move In/Out Date should not be greater than Lease End Date.',
                      1,
                      2000
                     );
               GOTO skip_validate;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR ('Exception getting lease end date: ' || SQLERRM,
                          1,
                          2000
                         );
               GOTO skip_validate;
         END;

         <<skip_validate>>
         IF l_status = 'VALIDATED'
         THEN
            UPDATE xxstg_move_in_out
               SET booking_id = l_booking_id,
                   lease_agreement_id = l_lease_agreement_id,
                   building_id = l_building_id,
                   property_id = l_property_id,
                   org_id = l_org_id,
                   status = l_status,
                   error_msg = NULL
             WHERE s_no = cr1.s_no;
         ELSIF l_status = 'ERROR'
         THEN
            UPDATE xxstg_move_in_out
               SET status = l_status,
                   error_msg = l_error_msg
             WHERE s_no = cr1.s_no;
         END IF;
      END LOOP;
   END validate_move;

   PROCEDURE create_move
   IS
      CURSOR c1
      IS
         SELECT *
           FROM xxstg_move_in_out
          WHERE status IN ('VALIDATED');

      l_status               VARCHAR2 (30);
      l_error_code           VARCHAR2 (100);
      l_error_msg            VARCHAR2 (2000);
      l_function_id          NUMBER;
      l_move_in_out_id       NUMBER;
      l_move_in_out_number   VARCHAR2 (60);
   BEGIN
      FOR cr1 IN c1
      LOOP
         l_status := 'SUCCESS';
         l_error_msg := NULL;
         l_error_code := NULL;
         l_function_id := NULL;
         l_move_in_out_number := NULL;
         SAVEPOINT move_creation;
         l_move_in_out_id := move_in_out_id_s.NEXTVAL;
--            xxfnd_pkg.get_next_number (p_func_code      => g_move_code,
--                                       p_next_num       => l_MOVE_IN_OUT_NUMBER,
--                                       p_func_id        => l_function_id,
--                                       p_err_code       => l_error_code,
--                                       p_err_msg        => l_error_msg
--                                      );
         l_function_id := get_function_id (g_move_code);
         l_error_code := '0';
         l_error_msg := NULL;

         BEGIN
            INSERT INTO xxpm_move_in_out
                        (move_in_out_id, func_id,
                         lease_agreement_id, booking_id,
                         move_in_out_number, move_in_out_date,
                         resource_name, in_out_flag, status,
                         description, created_by, creation_date,
                         last_updated_by, last_update_date,
                         last_update_login, org_id, property_id,
                         building_id, user_grp_id, flow_status, flow_level,
                         flow_with
                        )
                 VALUES (l_move_in_out_id, l_function_id,
                         cr1.lease_agreement_id, cr1.booking_id,
                         cr1.move_in_out_number, cr1.move_in_out_date,
                         cr1.resource_name, cr1.in_out_flag, 'APR',
                         cr1.description, g_created_by, SYSDATE,
                         g_created_by, SYSDATE,
                         g_update_login, cr1.org_id, cr1.property_id,
                         cr1.building_id, NULL, NULL, NULL,
                         NULL
                        );

            l_status := 'SUCCESS';
         EXCEPTION
            WHEN OTHERS
            THEN
               l_status := 'ERROR';
               l_error_msg :=
                  SUBSTR
                        (   'Exception Inserting in Receipt Header for id: '
                         || cr1.s_no
                         || '. Error Msg: '
                         || SQLERRM,
                         1,
                         2000
                        );
               ROLLBACK TO move_creation;
               GOTO skip_create;
         END;

         <<skip_create>>
         IF l_status = 'SUCCESS'
         THEN
            UPDATE xxstg_move_in_out
               SET move_in_out_id = l_move_in_out_id,
                   status = l_status,
                   error_msg = NULL
             WHERE s_no = cr1.s_no;
         ELSE
            UPDATE xxstg_move_in_out
               SET status = l_status,
                   error_msg = l_error_msg
             WHERE s_no = cr1.s_no;
         END IF;
      END LOOP;
   END create_move;

   PROCEDURE delete_booking
   IS
      CURSOR c1
      IS
         SELECT booking_id
           FROM xxstg_lease_agreement_hdr
          WHERE status = 'DELETED';

      CURSOR c2
      IS
         SELECT receipt_id
           FROM xxstg_receipt
          WHERE status = 'DELETED';
   BEGIN
      FOR c IN c1
      LOOP
         DELETE FROM xxpm_booking_header
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_booking_customer
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_recommend_header
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_lease_agreement
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_booking_detail
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_booking_milestone_detail
               WHERE booking_hdr_id = c.booking_id;
      END LOOP;

      FOR i IN c2
      LOOP
         DELETE FROM xxpm_receipt_details
               WHERE receipt_id = i.receipt_id;

         DELETE FROM xxpm_receipt
               WHERE receipt_id = i.receipt_id;
      END LOOP;
   END delete_booking;

   PROCEDURE rollback_load
   IS
      l_booking_id   NUMBER;

      CURSOR c1
      IS
         SELECT booking_id, lease_number,offer_id
           FROM xxstg_lease_agreement_hdr
          WHERE status = 'DELETED';

      CURSOR c2 (cp_booking_id IN NUMBER)
      IS
         SELECT receipt_id
           FROM xxstg_receipt
          WHERE source_func_ref_id = cp_booking_id;
   BEGIN
      FOR c IN c1
      LOOP
         DELETE FROM xxpm_booking_header
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_booking_customer
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_recommend_header
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_lease_agreement
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_booking_detail
               WHERE booking_id = c.booking_id;

         DELETE FROM xxpm_booking_milestone_detail
               WHERE booking_hdr_id = c.booking_id;

         DELETE FROM xxpm_offer_detail
               WHERE offer_hdr_id = c.offer_id;

         DELETE FROM xxpm_offer_milestone_detail
               WHERE offer_hdr_id = c.offer_id;               

         DELETE FROM xxpm_offer_header
               WHERE offer_hdr_id = c.offer_id;               

         UPDATE xxstg_lease_agreement_hdr
            SET booking_pay_method_code = NULL,
                ms_hdr_id = NULL,
                org_id = NULL,
                property_id = NULL,
                building_id = NULL,
                cust_category_code = NULL,
                visa_type_code = NULL,
                nationality_code = NULL,
                unit_id = NULL,
                cust_id_ar = NULL,
                purpose_rent_code = NULL,
                no_prop_unit_code = NULL,
                discount_id = NULL,
                booking_id = NULL,
                book_cust_id = NULL,
                recommend_id = NULL,
                lease_agreement_id = NULL,
                booking_dtl_id = NULL,
                OFFER_ID  =null,
                status = 'NEW',
                error_msg = NULL
          WHERE lease_number = c.lease_number;

         UPDATE xxstg_lease_ms_dtl
            SET booking_ms_dtl_id = NULL,
                booking_id = NULL,
                payment_term = NULL,
                seq_number = NULL,
                milestone_type_code = NULL,
                installment_type_code = NULL,
                charge_type_code = NULL,
                payment_term_id = NULL,
                status = 'NEW',
                error_msg = NULL
          WHERE lease_number = c.lease_number;

         FOR cr2 IN c2 (c.booking_id)
         LOOP
            DELETE FROM xxpm_receipt_details
                  WHERE receipt_id = cr2.receipt_id;

            DELETE FROM xxpm_receipt
                  WHERE receipt_id = cr2.receipt_id;
         END LOOP;

         UPDATE xxstg_receipt
            SET pay_mode_code = NULL,
                rct_type_code = NULL,
                booking_ms_dtl_id = NULL,
                source_func_ref_id = NULL,
                customer_name = NULL,
                status = 'NEW',
                error_msg = NULL,
                receipt_id = NULL,
                receipt_dtl_id = NULL
          WHERE invoice_num = c.lease_number;
      END LOOP;
   END rollback_load;
END xxpm_lease_agreement_load_pkg;
