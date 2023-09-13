--------------------------------------------------------
--  DDL for Package XXPM_DM_LIB_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_DM_LIB_PKG" IS

FUNCTION get_org_id (
    p_business_unit IN NUMBER
) RETURN NUMBER;

FUNCTION get_lookup (
    p_type_name    IN   VARCHAR2,
    p_value_name   IN   VARCHAR2
) RETURN VARCHAR2;

FUNCTION get_cust_id (
    p_customer_name IN VARCHAR2
) RETURN NUMBER;

FUNCTION get_cust_site_id (
    p_cust_id     IN   number,
    p_business_unit   IN   NUMBER
) RETURN NUMBER;
FUNCTION get_property_id (
    p_property_number   IN   VARCHAR2,
    p_business_unit     IN   NUMBER
) RETURN NUMBER;

FUNCTION get_building_id (
    p_building_number   IN VARCHAR2,
    p_property_number   IN VARCHAR2,
    p_business_unit     IN NUMBER
)
RETURN NUMBER;

FUNCTION get_unit_id( p_unit_number   IN VARCHAR2,
    p_building_number IN VARCHAR2,
    p_property_number IN VARCHAR2,
    p_business_unit IN NUMBER)
RETURN NUMBER;

FUNCTION get_unit_id_sh( p_unit_number   IN VARCHAR2,
    p_building_number IN VARCHAR2,
    p_property_number IN VARCHAR2,
    p_business_unit IN NUMBER)
RETURN NUMBER;


FUNCTION get_payment_term (
    p_pay_term IN VARCHAR2
) RETURN NUMBER;

FUNCTION get_payment_plan_id (
    p_milestone_name IN VARCHAR2
) RETURN NUMBER;

FUNCTION get_pricelist_id (
    p_pricelist_name IN VARCHAR2
) RETURN NUMBER;

FUNCTION get_lookupby_name (
    p_type_name      IN   VARCHAR2,
    p_display_name   IN   VARCHAR2
) RETURN VARCHAR2;

FUNCTION get_booking_ms_id (
    p_booking_number IN VARCHAR2
) RETURN NUMBER;

 FUNCTION get_pay_mode(
    P_PAYMODE  IN VARCHAR2,P_ORGID IN NUMBER) RETURN NUMBER;

END xxpm_dm_lib_pkg;
