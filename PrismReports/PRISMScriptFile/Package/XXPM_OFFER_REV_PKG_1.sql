--------------------------------------------------------
--  DDL for Package XXPM_OFFER_REV_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_OFFER_REV_PKG" 
AS
   PROCEDURE revise_offer (p_offer_num      IN     varchar2,
                              p_user_id    IN     varchar2  DEFAULT NULL,
                              p_err_code      OUT varchar2,
                              p_err_msg       OUT varchar2);
END xxpm_offer_rev_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_OFFER_REV_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_OFFER_REV_PKG" 
AS
   PROCEDURE load_history (
      p_offer_id   IN       NUMBER,
      p_user_id    IN       VARCHAR2 DEFAULT NULL,
      p_err_code   OUT      VARCHAR2,
      p_err_msg    OUT      VARCHAR2
   )
   IS
      l_offer_hst_id   NUMBER;
   BEGIN
      p_err_code := '0';
      p_err_msg := 'Success';
      l_offer_hst_id := offer_hst_id_s.NEXTVAL;

--Insert Header Record
      BEGIN
         INSERT INTO xxpm_offer_header_h
                     (offer_hst_id, offer_hdr_id, org_id, func_id,
                      offer_number, offer_date, offer_from_date,
                      offer_to_date, performed_by, revision_no, ms_hdr_id,
                      offer_type, lead_id, customer_id, cust_site_id,
                      salesman_id, net_offer_amount, tax_amount, status,
                      description, flow_status, flow_level, flow_with,
                      attribute_category, attribute1, attribute2, attribute3,
                      attribute4, attribute5, attribute6, attribute7,
                      attribute8, attribute9, attribute10, created_by,
                      creation_date, last_updated_by, last_update_date,
                      last_update_login, pl_id, customer_name,
                      customer_phone_no, customer_country, currency,
                      offer_total, checklist, terms, object_version_number,
                      offer_flag, lease_agreement_id, user_grp_id,
                      property_id, building_id, lease_type)
            SELECT l_offer_hst_id, offer_hdr_id, org_id, func_id,
                   offer_number, offer_date, offer_from_date, offer_to_date,
                   performed_by, revision_no, ms_hdr_id, offer_type, lead_id,
                   customer_id, cust_site_id, salesman_id, net_offer_amount,
                   tax_amount, status, description, flow_status, flow_level,
                   flow_with, attribute_category, attribute1, attribute2,
                   attribute3, attribute4, attribute5, attribute6,
                   attribute7, attribute8, attribute9, attribute10,
                   created_by, creation_date, last_updated_by,
                   last_update_date, last_update_login, pl_id, customer_name,
                   customer_phone_no, customer_country, currency,
                   offer_total, checklist, terms, object_version_number,
                   offer_flag, lease_agreement_id, user_grp_id, property_id,
                   building_id, lease_type
              FROM xxpm_offer_header
             WHERE offer_hdr_id = p_offer_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_code := SQLCODE;
            p_err_msg := SQLERRM;
            GOTO skip_insert;
      END;

--Insert Offer Details
      BEGIN
         INSERT INTO xxpm_offer_detail_h
                     (offer_dtl_hst_id, offer_dtl_id, offer_hst_id,
                      offer_hdr_id, property_id, building_id, unit_id,
                      purpose, uom, quantity, base_rate, premium_rate_1,
                      premium_rate_type_1, premium_rate_2,
                      premium_rate_type_2, premium_rate_3,
                      premium_rate_type_3, premium_rate_4,
                      premium_rate_type_4, premium_rate_5,
                      premium_rate_type_5, disc_pct_base_rate,
                      disc_base_rate, disc_pct_premium_rate_1,
                      disc_premium_rate_1, disc_pct_premium_rate_2,
                      disc_premium_rate_2, disc_pct_premium_rate_3,
                      disc_premium_rate_3, disc_pct_premium_rate_4,
                      disc_premium_rate_4, disc_pct_premium_rate_5,
                      disc_premium_rate_5, total_rate, offer_amount,
                      discount_amount, tax_amount, tax_code, tax_rate,
                      attribute_category, attribute1, attribute2, attribute3,
                      attribute4, attribute5, attribute6, attribute7,
                      attribute8, attribute9, attribute10, created_by,
                      creation_date, last_updated_by, last_update_date,
                      last_update_login, unit_type, area_sq, pl_id,
                      security_deposite, municipality_charges,
                      electricity_charges)
            Select offer_dtl_hst_id_s.NEXTVAL,A.*
            FROM
            (
            SELECT  offer_dtl_id, l_offer_hst_id,
                   offer_hdr_id, property_id, building_id, unit_id, purpose,
                   uom, quantity, base_rate, premium_rate_1,
                   premium_rate_type_1, premium_rate_2, premium_rate_type_2,
                   premium_rate_3, premium_rate_type_3, premium_rate_4,
                   premium_rate_type_4, premium_rate_5, premium_rate_type_5,
                   disc_pct_base_rate, disc_base_rate,
                   disc_pct_premium_rate_1, disc_premium_rate_1,
                   disc_pct_premium_rate_2, disc_premium_rate_2,
                   disc_pct_premium_rate_3, disc_premium_rate_3,
                   disc_pct_premium_rate_4, disc_premium_rate_4,
                   disc_pct_premium_rate_5, disc_premium_rate_5, total_rate,
                   offer_amount, discount_amount, tax_amount, tax_code,
                   tax_rate, attribute_category, attribute1, attribute2,
                   attribute3, attribute4, attribute5, attribute6,
                   attribute7, attribute8, attribute9, attribute10,
                   created_by, creation_date, last_updated_by,
                   last_update_date, last_update_login, unit_type, area_sq,
                   pl_id, security_deposite, municipality_charges,
                   electricity_charges
              FROM xxpm_offer_detail
             WHERE offer_hdr_id = p_offer_id
             ORDER BY OFFER_DTL_ID asc
             ) a;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_code := SQLCODE;
            p_err_msg := SQLERRM;
            GOTO skip_insert;
      END;

--Insert Offer Milestone Details
      BEGIN
         INSERT INTO xxpm_offer_milestone_detail_h
                     (offer_ms_dtl_hst_id, offer_ms_dtl_id, offer_hst_id,
                      offer_hdr_id, ms_dtl_id, seq_number, installment_type,
                      installment_pct, installment_amount, criteria,
                      charge_type, payment_term, remarks, due_date,
                      attribute_category, attribute1, attribute2, attribute3,
                      attribute4, attribute5, attribute6, attribute7,
                      attribute8, attribute9, attribute10, created_by,
                      creation_date, last_updated_by, last_update_date,
                      last_update_login, milestone_type)
            Select offer_ms_dtl_hst_id_s.NEXTVAL,a.*
            From(
            SELECT offer_ms_dtl_id,
                   l_offer_hst_id, offer_hdr_id, ms_dtl_id, seq_number,
                   installment_type, installment_pct, installment_amount,
                   criteria, charge_type, payment_term, remarks, due_date,
                   attribute_category, attribute1, attribute2, attribute3,
                   attribute4, attribute5, attribute6, attribute7,
                   attribute8, attribute9, attribute10, created_by,
                   creation_date, last_updated_by, last_update_date,
                   last_update_login, milestone_type
              FROM xxpm_offer_milestone_detail
             WHERE offer_hdr_id = p_offer_id
             ORDER BY OFFER_MS_DTL_ID asc
             ) a;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_code := SQLCODE;
            p_err_msg := SQLERRM;
            GOTO skip_insert;
      END;

      <<skip_insert>>
      NULL;
   END load_history;

   PROCEDURE revise_offer (
      p_offer_num   IN       VARCHAR2,
      p_user_id     IN       VARCHAR2 DEFAULT NULL,
      p_err_code    OUT      VARCHAR2,
      p_err_msg     OUT      VARCHAR2
   )
   IS
      l_err_code   VARCHAR2 (100);
      l_err_msg    VARCHAR2 (1000);
      l_offer_id   NUMBER;
   BEGIN
      p_err_code := '0';
      p_err_msg := 'Success';
      SAVEPOINT revise_offer;

      BEGIN
         SELECT offer_hdr_id
           INTO l_offer_id
           FROM xxpm_offer_header
          WHERE offer_number = p_offer_num;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_code := SQLCODE;
            p_err_msg := SQLERRM;
      END;

      IF l_offer_id IS NULL
      THEN
         p_err_code := '-1';
         p_err_msg := 'Offer Number does not exists. Please Check';
      ELSE
         load_history (p_offer_id      => l_offer_id,
                       p_user_id       => p_user_id,
                       p_err_code      => l_err_code,
                       p_err_msg       => l_err_msg
                      );
         p_err_code := l_err_code;
         p_err_msg := l_err_msg;

         IF l_err_code = '0'
         THEN
            UPDATE xxpm_offer_header
               SET revision_no = revision_no + 1,
                   last_updated_by = p_user_id,
                   last_update_date = SYSDATE
             WHERE offer_hdr_id = l_offer_id;

            COMMIT;
         END IF;
      END IF;

      IF p_err_code != '0'
      THEN
         ROLLBACK TO revise_offer;
      END IF;
   END revise_offer;
   
END xxpm_offer_rev_pkg;
