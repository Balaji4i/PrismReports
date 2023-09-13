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
