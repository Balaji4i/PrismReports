--------------------------------------------------------
--  DDL for Package XXPM_UTIL_PACKAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_UTIL_PACKAGE" 
IS
   FUNCTION get_lookup_value_disp (
      p_lookup_type    IN   VARCHAR2,
      p_lookup_value   IN   VARCHAR2
   )
      RETURN VARCHAR2;

   PROCEDURE get_rem_installment_amount (
      p_booking_id     IN       NUMBER,
      p_milestone_id   IN       NUMBER,
      x_amount         OUT      NUMBER,
      x_err_code       OUT      VARCHAR2,
      x_err_msg        OUT      VARCHAR2
   );

   PROCEDURE get_install_status (
      p_booking_id     IN       NUMBER,
      p_milestone_id   IN       NUMBER,
      x_status         OUT      VARCHAR2,
      x_err_code       OUT      VARCHAR2,
      x_err_msg        OUT      VARCHAR2
   );

--    Function get_gl_code(p_business_unit_id in number,p_charge_type_code in varchar2,p_unit_id in number)
--    return varchar2;
   PROCEDURE get_gl_code (
      p_business_unit_id   IN       NUMBER,
      p_charge_type_code   IN       VARCHAR2,
      p_unit_id            IN       NUMBER,
      x_gl_code            OUT      VARCHAR2,
      x_err_code           OUT      VARCHAR2,
      x_err_msg            OUT      VARCHAR2
   );

   PROCEDURE update_customer_trx_id (
      p_lease_number       IN   VARCHAR2,
      p_charge_type_code   IN   VARCHAR2 DEFAULT NULL,
      p_customer_trx_id    IN   NUMBER,
      p_trx_number         IN   VARCHAR2
   );
END xxpm_util_package;


--------------------------------------------------------
--  DDL for Package Body XXPM_UTIL_PACKAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_UTIL_PACKAGE" 
IS
   FUNCTION get_lookup_value_disp (
      p_lookup_type    IN   VARCHAR2,
      p_lookup_value   IN   VARCHAR2
   )
      RETURN VARCHAR2
   IS
      l_lookup_value_disp   VARCHAR2 (100);
   BEGIN
      SELECT lookup_value_name_disp
        INTO l_lookup_value_disp
        FROM xxfnd_lookup_types flt, xxfnd_lookup_values flv
       WHERE flt.lookup_type_id = flv.lookup_type_id
         AND flt.lookup_type_name = p_lookup_type
         AND UPPER (TRIM (flv.lookup_value_name)) =
                                                 UPPER (TRIM (p_lookup_value))
         AND flv.active_yn = 'Y';

      RETURN l_lookup_value_disp;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_lookup_value_disp;

   PROCEDURE get_rem_installment_amount (
      p_booking_id     IN       NUMBER,
      p_milestone_id   IN       NUMBER,
      x_amount         OUT      NUMBER,
      x_err_code       OUT      VARCHAR2,
      x_err_msg        OUT      VARCHAR2
   )
   IS
      l_receipt_amount     NUMBER;
      l_booking_amount     NUMBER;
      l_remaining_amount   NUMBER;
   BEGIN
      x_err_code := '0';
      x_err_msg := 'Success';

      BEGIN
         SELECT amount_applied
           INTO l_receipt_amount
           FROM xxpm_receipt_details
          WHERE booking_ms_dtl_id = p_milestone_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_receipt_amount := 0;
         WHEN OTHERS
         THEN
            x_err_code := SQLCODE;
            x_err_msg := SQLERRM;
            GOTO skip_process;
      END;

      BEGIN
         SELECT installment_amount
           INTO l_booking_amount
           FROM xxpm_booking_milestone_detail
          WHERE booking_ms_dtl_id = p_milestone_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            x_err_code := SQLCODE;
            x_err_msg := SQLERRM;
            GOTO skip_process;
      END;

      l_remaining_amount := l_booking_amount - l_receipt_amount;
      x_amount := l_remaining_amount;

      <<skip_process>>
      NULL;
   END get_rem_installment_amount;

   PROCEDURE get_install_status (
      p_booking_id     IN       NUMBER,
      p_milestone_id   IN       NUMBER,
      x_status         OUT      VARCHAR2,
      x_err_code       OUT      VARCHAR2,
      x_err_msg        OUT      VARCHAR2
   )
   IS
      l_status           VARCHAR2 (50);
      l_receipt_amount   NUMBER;
      l_booking_amount   NUMBER;
   --l_remaining_amount   NUMBER;
   BEGIN
      x_err_code := '0';
      x_err_msg := 'Success';

      BEGIN
         SELECT amount_applied
           INTO l_receipt_amount
           FROM xxpm_receipt_details
          WHERE booking_ms_dtl_id = p_milestone_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_receipt_amount := 0;
         WHEN OTHERS
         THEN
            x_err_code := SQLCODE;
            x_err_msg := SQLERRM;
            GOTO skip_process;
      END;

      BEGIN
         SELECT installment_amount
           INTO l_booking_amount
           FROM xxpm_booking_milestone_detail
          WHERE booking_ms_dtl_id = p_milestone_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            x_err_code := SQLCODE;
            x_err_msg := SQLERRM;
            GOTO skip_process;
      END;

--
--      l_remaining_amount := l_booking_amount - l_receipt_amount;
--      x_amount := l_remaining_amount;
      IF l_booking_amount > l_receipt_amount
      THEN
         l_status := 'UNAPPLIED';
      ELSE
         l_status := 'APPLIED';
      END IF;

      x_status := l_status;

      <<skip_process>>
      NULL;
   END get_install_status;

   PROCEDURE get_gl_code (
      p_business_unit_id   IN       NUMBER,
      p_charge_type_code   IN       VARCHAR2,
      p_unit_id            IN       NUMBER,
      x_gl_code            OUT      VARCHAR2,
      x_err_code           OUT      VARCHAR2,
      x_err_msg            OUT      VARCHAR2
   )
   --RETURN VARCHAR2
   IS
      l_gl_code     VARCHAR2 (240);
      l_segment1    VARCHAR2 (30);
      l_segment2    VARCHAR2 (30);
      l_segment3    VARCHAR2 (30);
      l_segment4    VARCHAR2 (30);
      l_segment5    VARCHAR2 (30);
      l_segment6    VARCHAR2 (30);
      l_segment7    VARCHAR2 (30)  := '000';
      l_segment8    VARCHAR2 (30)  := '000';
      l_delimiter   VARCHAR2 (1)   := '.';
   BEGIN
      x_err_code := 'S';
      x_err_msg := NULL;

      BEGIN
         SELECT unit_shortcode
           Into L_Segment3
           FROM xxpm_property_units
          WHERE unit_id = p_unit_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            x_err_code := 'E';
            x_err_msg := SQLERRM;
            GOTO last_line;
      --l_gl_code 'Exception getting Unit Short Code..';
      END;

      BEGIN
         SELECT xo.ledger_gl_code segment1, xo.org_gl_code segment2,
                xas.cost_center_gl_code segment4,
                xxpm_util_package.get_lookup_value_disp ('NATURAL_ACC',
                                                         xas.charge_type
                                                        ) segment5,
                xas.intercompany_gl_code segment6
           INTO l_segment1, l_segment2,
                l_segment4,
                l_segment5,
                l_segment6
           FROM xxpm_ar_setup xas,
                xxstg_ar_txn_type xatt,
                xxstg_ar_txn_source xats,
                xxstg_organizations xo
          WHERE xas.txn_type_id = xatt.cust_trx_type_id
            AND xas.txn_source_id = xats.batch_source_id
            AND xas.business_unit_id = xo.org_id
            AND xas.charge_type = p_charge_type_code
            AND xas.business_unit_id = p_business_unit_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            x_err_code := 'E';
            x_err_msg := SQLERRM;
            GOTO last_line;
      END;

      l_gl_code :=
            l_segment1
         || l_delimiter
         || l_segment2
         || l_delimiter
         || l_segment3
         || l_delimiter
         || l_segment4
         || l_delimiter
         || l_segment5
         || l_delimiter
         || l_segment6
         || l_delimiter
         || l_segment7
         || l_delimiter
         || l_segment8;

      <<last_line>>
      x_gl_code := l_gl_code;
   --    RETURN l_gl_code;
   END get_gl_code;

   PROCEDURE update_customer_trx_id (
      p_lease_number       IN   VARCHAR2,
      p_charge_type_code   IN   VARCHAR2,
      p_customer_trx_id    IN   NUMBER,
      p_trx_number         IN   VARCHAR2
   )
   IS
      l_booking_id          NUMBER;
      l_cust_trx_id_count   NUMBER;
   BEGIN
      SELECT booking_id
        INTO l_booking_id
        FROM xxpm_lease_agreement
       WHERE lease_number = p_lease_number;

      SELECT COUNT (1)
        INTO l_cust_trx_id_count
        FROM xxpm_booking_milestone_detail
       WHERE booking_hdr_id = l_booking_id AND customer_trxn_id IS NOT NULL;

      IF l_cust_trx_id_count = 0
      THEN
         UPDATE xxpm_booking_milestone_detail
            SET customer_trxn_id = p_customer_trx_id,
                customer_trxn_num = p_trx_number
          WHERE booking_hdr_id = l_booking_id AND charge_type = 'LOU';

         UPDATE xxpm_booking_detail
            SET customer_trxn_id = p_customer_trx_id,
                customer_trxn_num = p_trx_number
          WHERE booking_id = l_booking_id;
      END IF;

      COMMIT;
   END update_customer_trx_id;
END xxpm_util_package;
