--------------------------------------------------------
--  DDL for Package XXPM_DATALOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_DATALOAD_PKG" 
IS
   PROCEDURE property_master_ins;

   PROCEDURE property_building_val;

   PROCEDURE property_building_ins;

   PROCEDURE property_units_val;

   PROCEDURE property_units_ins;

   PROCEDURE property_area_val1;

   PROCEDURE property_area_val2;

   PROCEDURE property_area_ins;

   /*PROCEDURE milestone_master_ins;

   PROCEDURE milestone_detail_val;

   PROCEDURE milestone_detail_ins;
   
   PROCEDURE prop_samebuildunit_ins_temp;
   
   PROCEDURE prop_samebuildunit_val1;

   PROCEDURE prop_samebuildunit_val2;

   PROCEDURE prop_samebuildunit_ins;*/
END xxpm_dataload_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_DATALOAD_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_DATALOAD_PKG" 
IS
   PROCEDURE property_master_ins
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_master_temp1 a
          WHERE   1 = 1 AND property_id IS NULL;

      v_seq    number;
      v_errm   varchar2 (2000);
   BEGIN
      FOR r1 IN c1
      LOOP
         v_seq := NULL;
         v_errm := NULL;

         SELECT   xxpl_property_id_s.NEXTVAL INTO v_seq FROM DUAL;

         BEGIN
            INSERT INTO xxpl_property_master (property_id,
                                              property_name,
                                              property_number,
                                              property_shortcode,
                                              project_id,
                                              org_id,
                                              location_id,
                                              no_of_units,
                                              PROPERTY_TYPE,
--                                              parcel_type,
                                              active_yn,
                                              bank_acnt_id,
                                              created_by,
                                              creation_date,
                                              last_updated_by,
                                              last_update_date,
                                              LAST_UPDATE_LOGIN)  --added 28-May
              VALUES   (v_seq,
                        r1.property_name,
                        'PT-' || v_seq,
                        r1.property_shortcode,
                        NULL,
                        r1.org_id,
                        r1.location_id,
                        r1.no_of_units,
                        r1.property_type,
                        'Y',
                        NULL,
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS'); --added 28-May
         EXCEPTION
            WHEN OTHERS
            THEN
               v_errm := SQLCODE || '-' || SQLERRM;
         END;

         UPDATE   xxtest_property_master_temp1
            SET   property_id = v_seq, error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;

         COMMIT;
      END LOOP;
   END property_master_ins;

   PROCEDURE property_building_val
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_build_temp1 a
          WHERE   1 = 1 AND build_id IS NULL;

      v_ready_flag    varchar2 (1);
      v_property_id   number;
      v_errm          varchar2 (2000);
   BEGIN
      FOR r1 IN c1
      LOOP
         BEGIN
            v_property_id := NULL;
            v_ready_flag := 'Y';

            SELECT   property_id
              INTO   v_property_id
              FROM   xxpl_property_master
             WHERE   1 = 1 AND property_name = r1.property_name;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_property_id := NULL;
               v_ready_flag := 'N';
               v_errm := SQLCODE || '-' || SQLERRM;
         END;


         UPDATE   xxtest_property_build_temp1
            SET   property_id = v_property_id,
                  ready_to_process_flag = v_ready_flag,
                  error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;

         COMMIT;
      END LOOP;
   END property_building_val;

   PROCEDURE property_building_ins
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_build_temp1 a
          WHERE   1 = 1 AND ready_to_process_flag = 'Y' AND build_id IS NULL;

      v_seq    number;
      v_errm   varchar2 (2000);
   BEGIN
      FOR r1 IN c1
      LOOP
         v_seq := NULL;
         v_errm := NULL;

         SELECT   xxpl_build_id_s.NEXTVAL INTO v_seq FROM DUAL;

         BEGIN
            INSERT INTO xxpl_property_buildings (build_id,
                                                 property_id,
                                                 build_name,
                                                 build_number,
                                                 build_shortcode,
                                                 build_type,
                                                 active_yn,
                                                 created_by,
                                                 creation_date,
                                                 last_updated_by,
                                                 last_update_date,
                                                 LAST_UPDATE_LOGIN)  --added 28-May
              VALUES   (v_seq,
                        r1.property_id,
                        r1.build_name,
                        'BD-' || v_seq,
                        r1.build_shortcode,
                        r1.build_type,
                        'Y',
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS');  --added 28-May
         EXCEPTION
            WHEN OTHERS
            THEN
               v_errm := SQLCODE || '-' || SQLERRM;
         END;

         UPDATE   xxtest_property_build_temp1
            SET   build_id = v_seq, error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;

         COMMIT;
      END LOOP;
   END property_building_ins;

   PROCEDURE property_units_val
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_units_temp1 a
          WHERE   1 = 1 AND unit_id IS NULL;

      v_ready_flag    varchar2 (1);
      v_property_id   number;
      v_build_id      number;
      v_errm          varchar2 (2000);
   BEGIN
      FOR r1 IN c1
      LOOP
         v_errm := NULL;
         v_ready_flag := 'Y';
         v_property_id := NULL;
         v_build_id := NULL;

         IF r1.unit_name IS NULL
         THEN
            v_errm := 'Unit name is not available';
            v_ready_flag := 'N';
         ELSE
            BEGIN
               v_property_id := NULL;

               SELECT   property_id
                 INTO   v_property_id
                 FROM   xxpl_property_master
                WHERE   1 = 1 AND property_name = r1.property_name;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_property_id := NULL;
                  v_ready_flag := 'N';
                  v_errm := SQLCODE || '-' || SQLERRM;
            END;

            IF r1.build_name IS NOT NULL
            THEN
               BEGIN
                  v_build_id := NULL;

                  SELECT   build_id
                    INTO   v_build_id
                    FROM   xxpl_property_buildings
                   WHERE       1 = 1
                           AND property_id = v_property_id
                           AND build_name = r1.build_name;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     v_build_id := NULL;
                     v_ready_flag := 'N';
                     v_errm :=
                           v_errm
                        || '-'
                        || 'Building is not available in Building Master';
                  WHEN OTHERS
                  THEN
                     v_build_id := NULL;
                     v_ready_flag := 'N';
                     v_errm := v_errm || '-' || SQLCODE || '-' || SQLERRM;
               END;
            END IF;
         END IF;

         UPDATE   xxtest_property_units_temp1
            SET   property_id = v_property_id,
                  build_id = v_build_id,
                  ready_process_flag = v_ready_flag,
                  error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;

         COMMIT;
      END LOOP;
   END property_units_val;

   PROCEDURE property_units_ins
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_units_temp1 a
          WHERE   1 = 1 AND ready_process_flag = 'Y' AND unit_id IS NULL;

      v_errm   varchar2 (2000);
      v_seq    number;
   BEGIN
      FOR r1 IN c1
      LOOP
         v_seq := NULL;
         v_errm := NULL;

         SELECT   xxpl_unit_id_s.NEXTVAL INTO v_seq FROM DUAL;

         BEGIN
            INSERT INTO xxpl_property_units (unit_id,
                                             property_id,
                                             build_id,
                                             unit_name,
                                             unit_number,
                                             unit_shortcode,
                                             parent_unit_id,
                                             doc_ref_number_1,
                                             doc_ref_number_2,
                                             doc_ref_number_3,
                                             floor_number,
                                             no_of_rooms,
                                             unit_type,
                                             area_type,
                                             view_type,
                                             chargeable_area,
                                             uom,
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
                                             total_rate,
                                             purchase_amount,
                                             milestone_id,
                                             status,
                                             active_yn,
                                             created_by,
                                             creation_date,
                                             last_updated_by,
                                             last_update_date,
--                                             currency_code,
                                             unit_flag,
                                             LAST_UPDATE_LOGIN) --added 28-May
              VALUES   (v_seq,
                        r1.property_id,
                        r1.build_id,
                        r1.unit_name,
                        'UT-' || v_seq,
                        'UT-' || v_seq,
                        r1.parent_unit_id,
                        r1.doc_ref_number_1,
                        r1.doc_ref_number_2,
                        r1.doc_ref_number_3,
                        r1.floor_number,
                        r1.no_of_rooms,
                        r1.unit_type,
                        r1.area_type,
                        r1.view_type,
                        r1.chargeable_area,
                        r1.uom,
                        r1.base_rate,
                        r1.premium_rate_1,
                        r1.premium_rate_type_1,
                        r1.premium_rate_2,
                        r1.premium_rate_type_2,
                        r1.premium_rate_3,
                        r1.premium_rate_type_3,
                        r1.premium_rate_4,
                        r1.premium_rate_type_4,
                        r1.premium_rate_5,
                        r1.premium_rate_type_5,
                        r1.total_rate,
                        r1.purchase_amount,
                        r1.milestone_id,
                        r1.status,
                        'Y',
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS',
                        SYSDATE,
--                        'AED',
                        'U',
                        'ANONYMOUS'); --added 28-May
         EXCEPTION
            WHEN OTHERS
            THEN
               v_errm := SQLCODE || '-' || SQLERRM;
         END;

         UPDATE   xxtest_property_units_temp1
            SET   unit_id = v_seq, error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;

         COMMIT;
      END LOOP;
   END property_units_ins;

   PROCEDURE property_area_val1
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_area_temp1 a
          WHERE   1 = 1 AND area_id IS NULL;

      v_create_flag         varchar2 (1);
      v_property_name_new   varchar2 (100);
      v_build_name_new      varchar2 (100);
      v_unit_name_new       varchar2 (100);
      v_property_id         number;
      v_build_id            number;
      v_unit_id             number;
      v_errm                varchar2 (2000);
   BEGIN
      FOR r1 IN c1
      LOOP
         v_create_flag := 'Y';
         v_property_name_new := NULL;
         v_build_name_new := NULL;
         v_unit_name_new := NULL;
         v_property_id := NULL;
         v_build_id := NULL;
         v_unit_id := NULL;
         v_errm := NULL;


         v_property_name_new := r1.property_name;



         IF r1.build_name IS NULL AND r1.unit_name IS NOT NULL
         THEN
            BEGIN
               SELECT   build_name
                 INTO   v_build_name_new
                 FROM   xxpl_property_buildings
                WHERE   1 = 1
                        AND property_id =
                              (SELECT   property_id
                                 FROM   xxpl_property_master
                                WHERE   1 = 1
                                        AND property_name = r1.property_name)
                        AND build_id =
                              (SELECT   build_id
                                 FROM   xxpl_property_units
                                WHERE   1 = 1
                                        AND unit_name = TRIM (r1.unit_name)
                                        AND property_id =
                                              (SELECT   property_id
                                                 FROM   xxpl_property_master
                                                WHERE   1 = 1
                                                        AND property_name =
                                                              r1.property_name));
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_build_name_new := NULL;
            END;
         ELSE
            v_build_name_new := r1.build_name;
         END IF;


         IF     r1.build_name IS NOT NULL
            AND r1.unit_name IS NOT NULL
            AND r1.build_name = r1.unit_name
         THEN
            v_unit_name_new := NULL;
         ELSE
            v_unit_name_new := r1.unit_name;
         END IF;

         UPDATE   xxtest_property_area_temp1
            SET   property_name_new = v_property_name_new,
                  build_name_new = v_build_name_new,
                  unit_name_new = v_unit_name_new
          WHERE   1 = 1 AND ROWID = r1.ROWID;



         COMMIT;
      END LOOP;
   END property_area_val1;

   PROCEDURE property_area_val2
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_area_temp1 a
          WHERE   1 = 1 AND area_id IS NULL;

      v_create_flag   varchar2 (1);
      v_property_id   number;
      v_build_id      number;
      v_unit_id       number;
      v_errm          varchar2 (2000);
   BEGIN
      FOR r1 IN c1
      LOOP
         v_create_flag := NULL;
         v_property_id := NULL;
         v_build_id := NULL;
         v_unit_id := NULL;
         v_errm := NULL;



         IF r1.property_name_new IS NOT NULL
         THEN
            BEGIN
               v_property_id := NULL;

               SELECT   property_id
                 INTO   v_property_id
                 FROM   xxpl_property_master
                WHERE   1 = 1 AND property_name = r1.property_name_new;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_property_id := NULL;
                  v_errm :=
                     'Property is not available in the property master table';
            END;
         END IF;


         IF r1.build_name_new IS NOT NULL
         THEN
            BEGIN
               v_build_id := NULL;

               SELECT   build_id
                 INTO   v_build_id
                 FROM   xxpl_property_buildings
                WHERE       1 = 1
                        AND property_id = v_property_id
                        AND build_name = r1.build_name_new;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_build_id := NULL;
                  v_errm :=
                     v_errm
                     || 'Building is not available in the building master table';
            END;
         END IF;


         IF r1.unit_name_new IS NOT NULL AND r1.build_name_new IS NOT NULL
         THEN
            BEGIN
               v_unit_id := NULL;

               SELECT   unit_id
                 INTO   v_unit_id
                 FROM   xxpl_property_units
                WHERE       1 = 1
                        AND property_id = v_property_id
                        AND build_id = v_build_id
                        AND unit_name = TRIM (r1.unit_name_new);
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_unit_id := NULL;

                  v_errm :=
                        v_errm
                     || '-'
                     || 'Unit is not available in the unit master table';
            END;
         END IF;


         IF r1.unit_name_new IS NOT NULL AND r1.build_name_new IS NULL
         THEN
            BEGIN
               v_unit_id := NULL;

               SELECT   unit_id
                 INTO   v_unit_id
                 FROM   xxpl_property_units
                WHERE       1 = 1
                        AND property_id = v_property_id -- and build_id = v_build_id
                        AND unit_name = TRIM (r1.unit_name_new);
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_unit_id := NULL;

                  v_errm :=
                        v_errm
                     || '-'
                     || 'Unit is not available in the unit master table';
            END;
         END IF;

         IF r1.area IS NULL
         THEN
            v_errm := v_errm || '-' || 'Area is not given';
            v_create_flag := 'N';
         END IF;

         IF v_errm IS NOT NULL
         THEN
            v_create_flag := 'N';
         ELSE
            v_create_flag := 'Y';
         END IF;


         UPDATE   xxtest_property_area_temp1
            SET   property_id = v_property_id,
                  build_id = v_build_id,
                  unit_id = v_unit_id,
                  create_flag = v_create_flag,
                  error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;



         COMMIT;
      END LOOP;
   END property_area_val2;

   PROCEDURE property_area_ins
   IS
      CURSOR c1
      IS
         SELECT   a.ROWID, a.*
           FROM   xxtest_property_area_temp1 a
          WHERE       1 = 1
                  AND area IS NOT NULL
                  AND area_id IS NULL
                  AND create_flag = 'Y'
                  AND error_message IS NULL;

      v_errm   varchar2 (2000);
      v_seq    number;
      v_seq2   number;
   BEGIN
      FOR r1 IN c1
      LOOP
         v_seq := NULL;
         v_seq2 := NULL;
         v_errm := NULL;


         SELECT   xxpl_area_id_s.NEXTVAL INTO v_seq FROM DUAL;

         BEGIN
            INSERT INTO xxpl_property_area (area_id,
                                            property_id,
                                            build_id,
                                            unit_id,
                                            area,
                                            uom,
                                            VALUE,
                                            description,
                                            active_yn,
                                            created_by,
                                            creation_date,
                                            last_updated_by,
                                            last_update_date,
                                            LAST_UPDATE_LOGIN) --added 28-May
              VALUES   (v_seq,
                        r1.property_id,
                        r1.build_id,
                        r1.unit_id,
                        r1.area,
                        r1.uom,
                        r1.VALUE,
                        r1.description,
                        'Y',
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS',
                        SYSDATE,
                        'ANONYMOUS'); --added 28-May
         EXCEPTION
            WHEN OTHERS
            THEN
               v_errm := SQLCODE || '-' || SQLERRM;
         END;

         /*IF r1.area = 'SALE'
         THEN
            SELECT   xxpm_area_id_s.NEXTVAL INTO v_seq2 FROM DUAL;

            BEGIN
               INSERT INTO xxpm_property_area (area_id,
                                               property_id,
                                               build_id,
                                               unit_id,
                                               area,
                                               uom,
                                               VALUE,
                                               description,
                                               active_yn,
                                               created_by,
                                               creation_date,
                                               last_updated_by,
                                               last_update_date)
                 VALUES   (v_seq2,
                           r1.property_id,
                           r1.build_id,
                           r1.unit_id,
                           'CHARGE',
                           r1.uom,
                           r1.VALUE,
                           r1.description,
                           'Y',
                           -1,
                           SYSDATE,
                           -1,
                           SYSDATE);
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_errm := v_errm || '-' || SQLCODE || '-' || SQLERRM;
            END;
         END IF;*/

         UPDATE   xxtest_property_area_temp1
            SET   area_id = v_seq, error_message = v_errm
          WHERE   1 = 1 AND ROWID = r1.ROWID;

         COMMIT;
      END LOOP;
   END property_area_ins;

  
END xxpm_dataload_pkg;
