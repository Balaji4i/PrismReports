--------------------------------------------------------
--  DDL for Package XXPM_PRICELIST_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PRICELIST_PKG" 
AS
   PROCEDURE insert_history (p_pl_revison_id in number,
                             p_user_id     IN     varchar2,
                             p_err_code       OUT varchar2,
                             p_err_msg        OUT varchar2);

   --   procedure price_renewal (   p_pricelist   in     varchar2,
   --                                 p_method      in     varchar2,
   --                                 p_value       in     number,
   --                                 p_user_id     in     varchar2,
   --                                 p_err_code       out varchar2,
   --                                 p_err_msg        out varchar2);


   PROCEDURE price_renewal (p_pl_revison_id   IN     number,
                            p_user_id       IN     varchar2,
                            p_err_code         OUT varchar2,
                            p_err_msg          OUT varchar2);

   PROCEDURE pll_main (p_pl_revison_id in number,
                       p_user_id     IN     varchar2,
                       p_err_code       OUT varchar2,
                       p_err_msg        OUT varchar2);
END xxpm_pricelist_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_PRICELIST_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_PRICELIST_PKG" 
AS
 
      /************************************************************************************
        Project            :  Al Misk
        Application        :  Custom Module
        Program Type       :  Package Specification
        Description        :  Price List Revision Update
      *************************************************************************************
                        Development and Maintenance History
                        -----------------------------------

          Date         Developed By        Version       Description                     Owner
       -----------  ------------------  ---------     ------------------------    -----------
       08/06/2018         Isai C           1.0           Initial Version                   4iApps
      *************************************************************************************/


  PROCEDURE insert_history (p_pl_revison_id   IN     number,
                             p_user_id       IN     varchar2,
                             p_err_code         OUT varchar2,
                             p_err_msg          OUT varchar2)
   IS
      CURSOR cur_pl_h
      IS
         SELECT   pl_id,
                  pl_name,
                  description,
                  org_id,
                  curr_code,
                  start_date,
                  end_date,
                  revision_no,
                  revision_date,
                  revised_by,
                  base_price_yn,
                  active_yn,
                  created_by,
                  creation_date,
                  last_updated_by,
                  last_update_date,
                  last_update_login,
                  flow_status,
                  flow_with,
                  flow_level
           FROM   xxpm_pl_header h
          WHERE   h.pl_id IN (SELECT   pl_id
                                FROM   xxpm_revision
                               WHERE   pl_revison_id = p_pl_revison_id);

      CURSOR cur_pl_l (cp_pl_id IN number)
      IS
         SELECT   pll_id,
                  pl_id,
                  property_id,
                  build_id,
                  unit_id,
                  uom,
                  base_price,
                  min_price,
                  start_date,
                  end_date,
                  premium1,
                  premium2,
                  premium3,
                  premium4,
                  premium5,
                  revision_no,
                  revision_date,
                  revised_by,
                  active_yn,
                  created_by,
                  creation_date,
                  last_updated_by,
                  last_update_date,
                  last_update_login,
                  security_deposite,
                  municipality_charges,
                  electricity_charges,
                  unit_type,
                  THIRD_PARTY_SERV_CHARGE,
                  OTHER_GOVNT_CHARGE_NEW,
                  OTHER_GOVNT_CHARGE_RNEW,
                  EJARI_PAYMENT_CHARGE
           FROM   xxpm_pl_lines
          WHERE   pl_id = cp_pl_id;

      l_pll_id_h_s   number;
      l_err_flag     varchar2 (1);
   BEGIN
      p_err_code := '0';
      p_err_msg := 'Success';
     

      FOR i IN cur_pl_h
      LOOP
         l_pll_id_h_s := NULL;
         l_err_flag := NULL;

         SELECT   xxpm_pll_id_h_s.NEXTVAL INTO l_pll_id_h_s FROM DUAL;

         BEGIN
         
         Dbms_output.put_line('pl_id '||I.pl_id);  
         
            INSERT INTO xxpm_pl_header_h (pl_id_h,
                                          pl_id,
                                          pl_name,
                                          description,
                                          org_id,
                                          curr_code,
                                          start_date,
                                          end_date,
                                          revision_no,
                                          revision_date,
                                          revised_by,
                                          base_price_yn,
                                          active_yn,
                                          created_by,
                                          creation_date,
                                          last_updated_by,
                                          last_update_date,
                                          last_update_login)
              VALUES   (l_pll_id_h_s,
                        i.pl_id,
                        i.pl_name,
                        i.description,
                        i.org_id,
                        i.curr_code,
                        i.start_date,
                        i.end_date,
                        i.revision_no,
                        i.revision_date,
                        i.revised_by,
                        i.base_price_yn,
                        i.active_yn,
                        i.created_by,
                        SYSDATE,                              --creation_date,
                        p_user_id,                          --last_updated_by,
                        SYSDATE,                           --last_update_date,
                        i.last_update_login                                --,
                                           --i.flow_status,
                                           ---i.flow_with,
                                           --i.flow_level
                        );
         EXCEPTION
            WHEN OTHERS
            THEN
               p_err_code := SQLCODE;
               p_err_msg := SUBSTR (SQLERRM, 1, 2000);
               l_err_flag := 'E';
               DBMS_OUTPUT.put_line (
                  ' Error in Inserting xxpm_pl_header_h ' || SQLERRM
               );
         END;


         FOR j IN cur_pl_l (i.pl_id)
         LOOP
            BEGIN
               INSERT INTO xxpm_pl_lines_h (pll_id_h,
                                            pll_id,
                                            pl_id,
                                            property_id,
                                            build_id,
                                            unit_id,
                                            uom,
                                            base_price,
                                            min_price,
                                            start_date,
                                            end_date,
                                            premium1,
                                            premium2,
                                            premium3,
                                            premium4,
                                            premium5,
                                            revision_no,
                                            revision_date,
                                            revised_by,
                                            active_yn,
                                            created_by,
                                            creation_date,
                                            last_updated_by,
                                            last_update_date,
                                            last_update_login,
                                            security_deposite,
                                            municipality_charges,
                                            electricity_charges,
                                            unit_type,
                                            third_party_serv_charge,
                                            other_govnt_charge_new,
                                            other_govnt_charge_rnew,
                                            ejari_payment_charge)
                 VALUES   (l_pll_id_h_s,
                           j.pll_id,
                           j.pl_id,
                           j.property_id,
                           j.build_id,
                           j.unit_id,
                           j.uom,
                           j.base_price,
                           j.min_price,
                           j.start_date,
                           j.end_date,
                           j.premium1,
                           j.premium2,
                           j.premium3,
                           j.premium4,
                           j.premium5,
                           i.revision_no,            -- header revision number
                           j.revision_date,
                           j.revised_by,
                           j.active_yn,
                           j.created_by,
                           SYSDATE,                            --creation_date
                           p_user_id,                        --last_updated_by
                           SYSDATE,                         --last_update_date
                           j.last_update_login,
                           j.security_deposite,
                           j.municipality_charges,
                           j.electricity_charges,
                           j.unit_type,
                           j.third_party_serv_charge,
                           j.other_govnt_charge_new,
                           j.other_govnt_charge_rnew,
                           j.ejari_payment_charge);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_code := SQLCODE;
                  p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                  l_err_flag := 'E';
                  DBMS_OUTPUT.put_line (
                     'Error in Inserting xxpm_pl_lines_h ' || SQLERRM
                  );
            END;
         END LOOP;

         --updating revision to base tables

         IF l_err_flag IS NULL
         THEN
            UPDATE   xxpm_pl_header
               SET   revision_no = NVL (revision_no, 0) + 1,
                     revised_by = p_user_id,
                     revision_date = SYSDATE,
                     last_update_date = SYSDATE,
                     last_updated_by = p_user_id
             WHERE   pl_id IN (SELECT   pl_id
                                 FROM   xxpm_revision
                                WHERE   pl_revison_id = p_pl_revison_id);

            UPDATE   xxpm_pl_lines
               SET   revision_no = NVL (revision_no, 0) + 1,
                     revised_by = p_user_id,
                     revision_date = SYSDATE,
                     last_update_date = SYSDATE,
                     last_updated_by = p_user_id
             WHERE   pl_id IN
                           (SELECT   pl_id
                              FROM   xxpm_pl_header
                             WHERE   pl_id IN
                                           (SELECT   pl_id
                                              FROM   xxpm_revision
                                             WHERE   pl_revison_id =
                                                        p_pl_revison_id));
         END IF;
      END LOOP;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := SQLCODE;
         p_err_msg := SUBSTR (SQLERRM, 1, 2000);
         RETURN;
   END insert_history;

   /*
                                                          procedure price_renewal (p_pricelist   in     varchar2,
                               p_method      in     varchar2,
                               p_value       in     number,
                               p_user_id     in     varchar2,
                               p_err_code       out varchar2,
                               p_err_msg        out varchar2)
      is
         cursor cur_pl_l
         is
            select   pll_id,
                     pl_id,
                     property_id,
                     build_id,
                     unit_id,
                     uom,
                     base_price,
                     min_price,
                     start_date,
                     end_date,
                     premium1,
                     premium2,
                     premium3,
                     premium4,
                     premium5,
                     revision_no,
                     revision_date,
                     revised_by,
                     active_yn,
                     created_by,
                     creation_date,
                     last_updated_by,
                     last_update_date,
                     last_update_login,
                     security_deposite,
                     municipality_charges,
                     electricity_charges
              from   xxpm_pl_lines l
             where   pl_id in (select   pl_id
                                 from   xxpm_pl_header h
                                where   h.pl_name = p_pricelist);
         l_base_perc    number;
         l_min_perc     number;
         l_base_value   number;
         l_min_value    number;
         l_sign         number;
      begin
         p_err_code := '0';
         p_err_msg := 'success';
         for i in cur_pl_l
         loop
            l_base_perc := 0;
            l_min_perc := 0;
            l_base_value := 0;
            l_min_value := 0;
            l_sign := null;
            if p_method = 'pct'                                     -- percentage
            then
               l_base_perc := (abs (i.base_price) * abs (p_value) / 100);
               l_min_perc := (abs (i.min_price) * abs (p_value) / 100);
               l_sign := sign (p_value);
               if l_sign = -1
               then
                  l_base_value := i.base_price - l_base_perc;
                  l_min_value := i.min_price - l_min_perc;
               elsif l_sign = 1
               then
                  l_base_value := i.base_price + l_base_perc;
                  l_min_value := i.min_price + l_min_perc;
               else
                  l_base_value := i.base_price;
                  l_min_value := i.min_price;
               end if;
            elsif p_method = 'amt'
            then
               --amount
               l_base_value := i.base_price + p_value;
               l_min_value := i.min_price + p_value;
            else
               l_base_value := i.base_price;
               l_min_value := i.min_price;
            end if;
            update   xxpm_pl_lines
               set   base_price = l_base_value, min_price = l_min_value
             where   pl_id = i.pl_id and pll_id = i.pll_id;
         end loop;
         commit;
      exception
         when others
         then
            p_err_code := sqlcode;
            p_err_msg := substr (sqlerrm, 1, 2000);
            return;
      end price_renewal;
      */


   PROCEDURE price_renewal (p_pl_revison_id   IN     number,
                            p_user_id       IN     varchar2,
                            p_err_code         OUT varchar2,
                            p_err_msg          OUT varchar2)
   IS
      CURSOR cur_revision (
         cp_revison_id                 number
      )
      IS
         SELECT   DISTINCT r.pl_revison_id,
                           r.pl_id,
                           r.revison_no,
                           rl.unit_type,
                           rl.rev_base_charge,
                           rl.rev_min_charge,
                           rl.third_party_serv_charge,
                           rl.other_govnt_charge_new,
                           rl.other_govnt_charge_rnew,
                           rl.ejari_payment_charge,
                           rl.rev_securitydeposit_charge, 
                           rl.rev_municipality_charge, 
                           rl.rev_electricity_charge
           FROM   xxpm_revision r, xxpm_revision_line rl
          WHERE   r.pl_revison_id = rl.pl_revison_id
                  AND r.pl_revison_id = cp_revison_id;
   BEGIN
      FOR i IN cur_revision (p_pl_revison_id)
      LOOP
         UPDATE   xxpm_pl_lines
            SET   base_price = i.rev_base_charge,
                  min_price = i.rev_min_charge,
                  third_party_serv_charge = i.third_party_serv_charge,
                  other_govnt_charge_new = i.other_govnt_charge_new,
                  other_govnt_charge_rnew = i.other_govnt_charge_rnew,
                  ejari_payment_charge = i.ejari_payment_charge,
                  security_deposite = i.rev_securitydeposit_charge, 
                  municipality_charges = i.rev_municipality_charge, 
                  electricity_charges  = i.rev_electricity_charge
          WHERE   pl_id = i.pl_id AND unit_type = i.unit_type;
      END LOOP;

      COMMIT;
   END price_renewal;

   PROCEDURE pll_main (p_pl_revison_id   IN     number,
                       p_user_id       IN     varchar2,
                       p_err_code         OUT varchar2,
                       p_err_msg          OUT varchar2)
   IS
      l_err_code   varchar2 (100);
      l_err_msg    varchar2 (3000);
   BEGIN
      l_err_code := NULL;
      l_err_msg := NULL;
      xxpm_pricelist_pkg.insert_history (p_pl_revison_id,
                                         p_user_id,
                                         l_err_code,
                                         l_err_msg);
      xxpm_pricelist_pkg.price_renewal (p_pl_revison_id,
                                        p_user_id,
                                        l_err_code,
                                        l_err_msg);
   END;
END xxpm_pricelist_pkg;
