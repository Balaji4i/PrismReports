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
    P_PAYMODE  IN VARCHAR2)
  RETURN NUMBER;

END xxpm_dm_lib_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_DM_LIB_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_DM_LIB_PKG" 
IS

----------------Org Validation -----------

FUNCTION get_org_id(
    p_business_unit IN NUMBER)
  RETURN NUMBER
IS
  CURSOR cur_org_id
  IS
    SELECT org_id
    FROM xxstg_organizations
    --WHERE upper(org_name) = upper(p_business_unit);
    WHERE org_id=p_business_unit;
  l_org_id NUMBER;
BEGIN

  OPEN cur_org_id ;
  fetch cur_org_id INTO l_org_id ;
  IF cur_org_id%notfound THEN
    CLOSE CUR_ORG_ID ;
    RETURN null ;
  END IF ;
  CLOSE cur_org_id ;
  RETURN l_org_id ;
  
END get_org_id;


----------------Lookup Validation By value Name -----------

FUNCTION get_lookup(
    p_type_name  IN VARCHAR2,
    p_value_name IN VARCHAR2)
  RETURN VARCHAR2
IS
  CURSOR cur_lookups
  IS
    SELECT lookup_value_name
    FROM xxfnd_lookup_v
    WHERE upper(lookup_type_name) = upper(p_type_name)
    AND upper(lookup_value_name)  =upper(p_value_name);
  l_value_name VARCHAR2(50);
BEGIN

  OPEN cur_lookups ;
  fetch cur_lookups INTO l_value_name ;
  IF cur_lookups%notfound THEN
    CLOSE cur_lookups ;
    RETURN NULL ;
  END IF ;
  CLOSE cur_lookups ;
  RETURN l_value_name ;
  
  
  
  
END get_lookup;


----------------Customer Validation -----------

FUNCTION get_cust_id(
    p_customer_name IN VARCHAR2)
  RETURN NUMBER
IS
  CURSOR cur_customer
  IS
    SELECT cust_id
    FROM xxstg_customer
    WHERE upper(customer_name) =upper(p_customer_name);
  l_cust_id NUMBER;
  
BEGIN
  OPEN cur_customer ;
  fetch cur_customer INTO l_cust_id ;
  
  IF cur_customer%notfound THEN
    CLOSE CUR_CUSTOMER ;
    RETURN null ;
  END IF ;
  
  CLOSE cur_customer ;
  RETURN l_cust_id ;
END get_cust_id;



----------------Customer Site Validation -----------

FUNCTION get_cust_site_id(
    p_cust_id   IN number,
    p_business_unit IN NUMBER)
  RETURN NUMBER
IS
  CURSOR cur_cust_site
  IS
    SELECT xcs.cust_site_id
    FROM xxstg_cust_sites xcs,   xxstg_organizations xo
    WHERE 
     xo.org_id        = xcs.org_id
     AND cust_id =p_cust_id
   --AND upper(xo.org_name)         = upper(p_business_unit)
   AND xo.org_id=p_business_unit and rownum=1;
  l_cust_site_id NUMBER;
  l_org_id       NUMBER;
  
BEGIN
  OPEN cur_cust_site ;
  fetch cur_cust_site INTO l_cust_site_id ;
  
  IF cur_cust_site%notfound THEN
    CLOSE CUR_CUST_SITE ;
    RETURN null ;
  END IF ;
  
  CLOSE cur_cust_site ;
  RETURN l_cust_site_id ;
END get_cust_site_id;


----------------Property Validation -----------

FUNCTION get_property_id(
    p_property_number IN VARCHAR2,
    p_business_unit IN NUMBER)
  RETURN NUMBER
IS
  CURSOR cur_property
  IS
    SELECT xpm.property_id
    FROM xxpm_property_master xpm,
      xxstg_organizations xo
    WHERE upper(xpm.property_number) =upper(p_property_number)
    AND xpm.org_id                 =xo.org_id
   -- AND upper(xo.org_name)         = upper(p_business_unit);
   AND xo.org_id=p_business_unit;
  l_property_id NUMBER;
  
BEGIN
  OPEN cur_property;
  fetch cur_property INTO l_property_id;
  
  IF cur_property%notfound THEN
    CLOSE cur_property;
    RETURN null;
  END IF;
  
  CLOSE cur_property;
  RETURN l_property_id;
END get_property_id;


----------------Building  Validation -----------

FUNCTION get_building_id(
    p_building_number IN VARCHAR2,
    p_property_number IN VARCHAR2,
    p_business_unit IN NUMBER)
  RETURN NUMBER
IS
  CURSOR cur_build
  IS
    SELECT build_id
    FROM xxpm_property_buildings xpb,
      xxpm_property_master xpm,
      xxstg_organizations xo
    WHERE xpb.property_id        =xpm.property_id
    AND xpm.org_id               =xo.org_id
    AND upper(xpb.BUILD_NUMBER)        =upper(p_building_number)
    AND upper(xpm.property_number) =upper(p_property_number)
    --AND upper(xo.org_name)       = upper(p_business_unit);
    and xo.org_id=p_business_unit;
  l_build_id NUMBER;
BEGIN
  OPEN cur_build;
  fetch cur_build INTO l_build_id;
  
  IF cur_build%notfound THEN
    CLOSE CUR_BUILD;
    RETURN null;
  END IF;
  
  CLOSE cur_build;
  RETURN l_build_id;
END get_building_id;


----------------Unit  Validation -----------


FUNCTION get_unit_id(
    p_unit_number   IN VARCHAR2,
    p_building_number IN VARCHAR2,
    p_property_number IN VARCHAR2,
    p_business_unit IN NUMBER)
  RETURN NUMBER
IS
  CURSOR cur_unit
  IS
    SELECT xpu.unit_id
    FROM xxpm_property_buildings xpb,
      xxpm_property_master xpm,
      xxstg_organizations xo,
      xxpm_property_units xpu
    WHERE xpb.property_id        =xpm.property_id
    AND xpm.org_id               =xo.org_id
    AND xpu.build_id             =xpb.build_id
    AND upper(xpm.property_number) =upper(p_property_number)
    AND upper(xpb.build_number)    =upper(p_building_number)
    --AND upper(xo.org_name)       = upper(p_business_unit)
    AND xo.org_id=p_business_unit
    AND upper(xpu.unit_name)     = upper(p_unit_number);
  l_unit_id NUMBER;
  
BEGIN
  OPEN cur_unit;
  fetch cur_unit INTO l_unit_id;
  
  IF cur_unit%notfound THEN
    CLOSE CUR_UNIT;
    RETURN null;
  END IF;
  
  CLOSE cur_unit;
  RETURN l_unit_id;
END get_unit_id;

FUNCTION get_unit_id_sh(
    p_unit_number   IN VARCHAR2,
    p_building_number IN VARCHAR2,
    p_property_number IN VARCHAR2,
    p_business_unit IN NUMBER)
  RETURN NUMBER
IS
  CURSOR cur_unit
  IS
    SELECT xpu.unit_id
    FROM xxpm_property_buildings xpb,
      xxpm_property_master xpm,
      xxstg_organizations xo,
      xxpm_property_units xpu
    WHERE xpb.property_id        =xpm.property_id
    AND xpm.org_id               =xo.org_id
    AND xpu.build_id             =xpb.build_id
    AND upper(xpm.property_number) =upper(p_property_number)
    AND upper(xpb.build_number)    =upper(p_building_number)
    --AND upper(xo.org_name)       = upper(p_business_unit)
    AND xo.org_id=p_business_unit
    AND upper(xpu.unit_shortcode)     = upper(p_unit_number);
  l_unit_id NUMBER;
  
BEGIN
  OPEN cur_unit;
  fetch cur_unit INTO l_unit_id;
  
  IF cur_unit%notfound THEN
    CLOSE CUR_UNIT;
    RETURN null;
  END IF;
  
  CLOSE cur_unit;
  RETURN l_unit_id;
END get_unit_id_sh;
----------------Payment_term  Validation -----------

FUNCTION get_payment_term(
    p_pay_term IN VARCHAR2)
  RETURN NUMBER
IS
  CURSOR cur_term_id
  IS
    SELECT term_id
    FROM XXSTG_PAY_TERMS
    WHERE upper(term_name) = upper(p_pay_term);
  l_term_id NUMBER;
BEGIN

  OPEN cur_term_id ;
  fetch cur_term_id INTO l_term_id ;
  IF cur_term_id%notfound THEN
    CLOSE cur_term_id ;
    RETURN null ;
  END IF ;
  CLOSE cur_term_id ;
  RETURN l_term_id ;
  
END get_payment_term;

----------------payment_plan  Validation -----------

FUNCTION get_payment_plan_id(p_MILESTONE_NAME IN VARCHAR2)
RETURN NUMBER
IS
CURSOR ms_hdr_id
IS
SELECT MS_HDR_ID FROM xxpm_milestone_hdr WHERE upper(MILESTONE_NAME) = upper(p_MILESTONE_NAME) ;

l_ms_hdr_id NUMBER;
BEGIN
OPEN ms_hdr_id;
fetch ms_hdr_id INTO l_ms_hdr_id;

  IF ms_hdr_id%notfound THEN
    CLOSE ms_hdr_id ;
    RETURN null ;
  END IF ;
  CLOSE ms_hdr_id ;
  RETURN l_ms_hdr_id ;
  
end get_payment_plan_id;


----------------pricelist  Validation -----------


FUNCTION get_pricelist_id(p_PriceList_NAME IN VARCHAR2)
RETURN NUMBER
IS
CURSOR pl_id
IS 
SELECT PL_ID FROM xxpm_pl_header WHERE upper(PL_NAME) =upper(p_PriceList_NAME);

l_pl_id number;
begin

OPEN pl_id;
fetch pl_id INTO l_pl_id;

  IF pl_id%notfound THEN
    CLOSE pl_id ;
    RETURN null ;
  END IF ;
  CLOSE pl_id ;
  RETURN l_pl_id ;

end get_pricelist_id;


----------------lookup  Validation By Display Name -----------

function get_lookupBy_name(p_type_name IN VARCHAR2,p_display_name IN VARCHAR2) 
RETURN VARCHAR2
is
 CURSOR cur_lookup_byName
  IS
    SELECT lookup_value_name
    FROM xxfnd_lookup_v
    WHERE upper(lookup_type_name) = upper(p_type_name)
    AND upper(LOOKUP_VALUE_NAME_DISP)  =upper(p_display_name);
  l_value_name VARCHAR2(50);
BEGIN

  OPEN cur_lookup_byName ;
  fetch cur_lookup_byName INTO l_value_name ;
  IF cur_lookup_byName%notfound THEN
    CLOSE cur_lookup_byName ;
    RETURN NULL ;
  END IF ;
  CLOSE cur_lookup_byName ;
  RETURN l_value_name ;
  
END get_lookupBy_name;

FUNCTION get_booking_ms_id(
    p_booking_number  IN VARCHAR2)
  RETURN NUMBER
IS
  CURSOR cur_booking_ms
  IS
    select BOOKING_MS_DTL_ID FROM XXPM_BOOKING_MILESTONES MS,XXPM_BOOKING_HEADER BH
where MS.BOOKING_HDR_ID=BH.BOOKING_HDR_ID and BH.BOOKING_NUMBER=p_booking_number;
  l_booking_ms_id NUMBER;
  
BEGIN

  OPEN cur_booking_ms ;
  fetch cur_booking_ms INTO l_booking_ms_id ;
  IF cur_booking_ms%notfound THEN
    CLOSE cur_booking_ms ;
    RETURN NULL ;
  END IF ;
  CLOSE cur_booking_ms ;
  RETURN l_booking_ms_id ;
  
END get_booking_ms_id;

FUNCTION get_pay_mode(
    P_PAYMODE  IN VARCHAR2)
  RETURN NUMBER
IS
  CURSOR cur_paymode
  IS
    select RECEIPT_METHOD_ID FROM XXSTG_RECEIPT_METHOD
where RECEIPT_METHOD_NAME=P_PAYMODE;
  l_rec_mthd_id NUMBER;
  
BEGIN

  OPEN cur_paymode ;
  fetch cur_paymode INTO l_rec_mthd_id ;
  IF cur_paymode%notfound THEN
    CLOSE cur_paymode ;
    RETURN NULL ;
  END IF ;
  CLOSE cur_paymode ;
  RETURN l_rec_mthd_id ;
  
END get_pay_mode;

END xxpm_dm_lib_pkg ;
