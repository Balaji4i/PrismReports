CREATE OR REPLACE PACKAGE "XXDM_EXCELDATA_MIGRATION_PKG" is
      
  PROCEDURE units_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_unit_tbl OUT units_type_table);

  PROCEDURE units_area_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_area_tbl OUT AREA_TYPE_TABLE);

  PROCEDURE car_park_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_carpark_tbl OUT CAR_PARK_TYPE_TABLE);

PROCEDURE features_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_features_tbl OUT FEATURES_TABLE_TYPE);

  PROCEDURE units_fix_fittings_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
       p_fix_tbl OUT PROPERTY_FIX_FITTINGS_TAB_TYPE);

    PROCEDURE owner_dtle_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_owner_tbl OUT owner_dtle_tab_Type);

     PROCEDURE milestones_header_upload(
      p_milestone_name    IN VARCHAR2,
      p_milestone_number       IN VARCHAR2,
      p_org_name        IN VARCHAR2,
      p_status      IN VARCHAR2,
      p_saleorlease IN VARCHAR2,
      p_mshdr_tbl OUT MILESTONE_HEADER_TABLE_TYPE);

  PROCEDURE milestones_line_upload(
      p_milestone_name    IN VARCHAR2,
      p_milestone_number       IN VARCHAR2,
      p_org_name        IN VARCHAR2,
      p_status      IN VARCHAR2,
      p_saleorlease IN VARCHAR2,
      p_msline_tbl OUT MILESTONE_LINE_TABLE_TYPE);


      PROCEDURE pricelist_header_upload(
     p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_saleorlease IN VARCHAR2,
       p_plhdr_tbl OUT PL_HEADER_TABLE_TYPE);

       PROCEDURE pricelist_line_upload(
     p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
       p_saleorlease IN VARCHAR2,
      p_plline_tbl OUT PL_LINE_TABLE_TYPE);

      PROCEDURE pricelist_modifiers_upload(
      p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
	  p_saleorlease IN VARCHAR2,
       p_plmod_tbl OUT PL_MODIFIERS_TABLE_TYPE);

     PROCEDURE pricelist_qualifiers_upload(
     p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
	  p_saleorlease IN VARCHAR2,
        p_plqd_tbl OUT PL_QUALIFIERS_TABLE_TYPE);

end xxdm_exceldata_migration_pkg;
/


CREATE OR REPLACE PACKAGE BODY "XXDM_EXCELDATA_MIGRATION_PKG" 
IS 
  PROCEDURE units_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_unit_tbl OUT units_type_table)
  AS
    l_unit_tbl units_type_table ;
    CURSOR c1 is
      SELECT Units_Obj_Type( pu.unit_id, pu.property_id,pu.build_id,pb.build_number, pm.property_number, pu.unit_name,pu.unit_name_tl,
        pu.unit_number, pu.unit_shortcode,  pu.func_id, pu.org_id,
        pu.parent_unit_id, pu.doc_ref_number_1,  pu.doc_ref_number_2,  pu.doc_ref_number_3,
        pu.floor_number,pu.no_of_rooms,pu.unit_type,
        pu.area_type,pu.view_type,pu.chargeable_area,pu.uom,pu.currency_code,
        pu.base_rate,pu.total_rate,pu.purchase_amount,pu.status,pu.unit_class, pu.unit_category,pu.vend_id,pu.description,pu.active_yn,
pu.saleable_yn,
pu.leaseable_yn,
pu.sale_available_yn,
pu.lease_available_yn,
pu.free_hold_yn,
pu.lease_hold_yn,
pu.list_for_brokers,
pu.list_for_internal,
pu.allot_type)
      FROM xxpm_property_master pm,
        xxpm_property_buildings pb,
        xxpm_property_units pu
      WHERE pu.property_id    = pm.property_id(+)
      AND pu.build_id         = pb.build_id(+)
      AND pb.property_id      = pm.property_id(+)
      AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
      AND (P_UNIT_NUMBER IS NULL OR PU.UNIT_NUMBER = P_UNIT_NUMBER)
      AND (P_UNIT_SHORTCODE IS NULL OR PU.UNIT_SHORTCODE = P_UNIT_SHORTCODE)
      AND (P_UNIT_TYPE IS NULL OR  PU.UNIT_TYPE=P_UNIT_TYPE)
      AND (P_STATUS IS NULL OR PU.STATUS=P_STATUS)
      ORDER BY   
        pu.unit_number;   
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_unit_tbl;
    CLOSE c1 ;
     p_unit_tbl := l_unit_tbl ;
  END units_upload;

   PROCEDURE units_area_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_area_tbl OUT AREA_TYPE_TABLE)
  AS
    l_area_tbl AREA_TYPE_TABLE ;
    CURSOR c1 is
SELECT AREA_OBJ_TYPE(pa.AREA_ID,
  pm.property_number,
  pa.PROPERTY_ID,
  pb.build_number,
  pa.BUILD_ID,
  pu.unit_number,
  pa.UNIT_ID,
  pa.AREA,
  pa.UOM,
  pa.value,
  pa.DESCRIPTION)
FROM XXPM_PROPERTY_AREA PA,
  XXPM_PROPERTY_UNITS PU,
  XXPM_PROPERTY_BUILDINGS PB,
  XXPM_PROPERTY_MASTER PM
WHERE PA.UNIT_ID=PU.UNIT_ID
AND PA.PROPERTY_ID=PM.PROPERTY_ID
AND PA.BUILD_ID=PB.BUILD_ID
AND pa.UNIT_ID IN
  (SELECT pu.UNIT_ID
  FROM XXPM_PROPERTY_UNITS pu ,
    XXPM_PROPERTY_MASTER PM,
    XXPM_PROPERTY_BUILDINGS PB
  WHERE PU.PROPERTY_ID   = PM.PROPERTY_ID
  AND PU.BUILD_ID        = PB.BUILD_ID
  AND PB.PROPERTY_ID     = PM.PROPERTY_ID
  AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
      AND (P_UNIT_NUMBER IS NULL OR PU.UNIT_NUMBER = P_UNIT_NUMBER)
      AND (P_UNIT_SHORTCODE IS NULL OR PU.UNIT_SHORTCODE = P_UNIT_SHORTCODE)
      AND (P_UNIT_TYPE IS NULL OR  PU.UNIT_TYPE=P_UNIT_TYPE)
      AND (P_STATUS IS NULL OR PU.STATUS=P_STATUS))
  order by pu.unit_number;
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_area_tbl;
    CLOSE c1 ;
     p_area_tbl := l_area_tbl ;
  END units_area_upload;

   PROCEDURE car_park_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_carpark_tbl OUT CAR_PARK_TYPE_TABLE)
  AS
    l_carpark_tbl CAR_PARK_TYPE_TABLE ;
    CURSOR c1 is
SELECT CAR_PAK_OBJ_TYPE(pc.carpark_id,
  pu.unit_number,
  pc.UNIT_ID,
  pu1.unit_number,
  pc.cp_unit_id,
  pc.allot_type)
FROM xxpm_property_carparks pc,
  XXPM_PROPERTY_UNITS PU,
  XXPM_PROPERTY_UNITS PU1
WHERE pc.UNIT_ID=PU.UNIT_ID
AND PU1.UNIT_ID = PC.CP_UNIT_ID
AND pc.UNIT_ID IN
  (SELECT pu.UNIT_ID
  FROM XXPM_PROPERTY_UNITS pu ,
    XXPM_PROPERTY_MASTER PM,
    XXPM_PROPERTY_BUILDINGS PB
  WHERE PU.PROPERTY_ID   = PM.PROPERTY_ID
  AND PU.BUILD_ID        = PB.BUILD_ID
  AND PB.PROPERTY_ID     = PM.PROPERTY_ID
 AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
      AND (P_UNIT_NUMBER IS NULL OR PU.UNIT_NUMBER = P_UNIT_NUMBER)
      AND (P_UNIT_SHORTCODE IS NULL OR PU.UNIT_SHORTCODE = P_UNIT_SHORTCODE)
      AND (P_UNIT_TYPE IS NULL OR  PU.UNIT_TYPE=P_UNIT_TYPE)
      AND (P_STATUS IS NULL OR PU.STATUS=P_STATUS))
  order by pu.unit_number;
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_carpark_tbl;
    CLOSE c1 ;
     p_carpark_tbl := l_carpark_tbl ;
  END car_park_upload;

PROCEDURE features_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_features_tbl OUT FEATURES_TABLE_TYPE)
  AS
    l_features_tbl FEATURES_TABLE_TYPE ;
    CURSOR c1 is
SELECT FEATURES_OBJ_TYPE(pf.feature_id,
  pm.property_number,
  pf.PROPERTY_ID,
  pb.build_number,
  pf.BUILD_ID,
  pu.unit_number,
  pf.UNIT_ID,
  pf.feature_type,
  pf.description,
  pf.feature_condition,
  pf.UOM,
  pf.value,
  pf.quantity,
  pf.rate)
FROM XXPM_PROPERTY_FEATURES PF,
  XXPM_PROPERTY_UNITS PU,
  XXPM_PROPERTY_BUILDINGS PB,
  XXPM_PROPERTY_MASTER PM
WHERE PF.UNIT_ID=PU.UNIT_ID
AND PF.PROPERTY_ID=PM.PROPERTY_ID
AND PF.BUILD_ID=PB.BUILD_ID
AND pf.UNIT_ID IN
  (SELECT pu.UNIT_ID
  FROM XXPM_PROPERTY_UNITS pu ,
    XXPM_PROPERTY_MASTER PM,
    XXPM_PROPERTY_BUILDINGS PB
  WHERE PU.PROPERTY_ID   = PM.PROPERTY_ID
  AND PU.BUILD_ID        = PB.BUILD_ID
  AND PB.PROPERTY_ID     = PM.PROPERTY_ID
  AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
      AND (P_UNIT_NUMBER IS NULL OR PU.UNIT_NUMBER = P_UNIT_NUMBER)
      AND (P_UNIT_SHORTCODE IS NULL OR PU.UNIT_SHORTCODE = P_UNIT_SHORTCODE)
      AND (P_UNIT_TYPE IS NULL OR  PU.UNIT_TYPE=P_UNIT_TYPE)
      AND (P_STATUS IS NULL OR PU.STATUS=P_STATUS))
  order by pu.unit_number;
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_features_tbl;
    CLOSE c1 ;
     p_features_tbl := l_features_tbl ;
  END features_upload;

  PROCEDURE units_fix_fittings_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_fix_tbl OUT PROPERTY_FIX_FITTINGS_TAB_TYPE)
  AS
    l_fix_tbl PROPERTY_FIX_FITTINGS_TAB_TYPE ;
    CURSOR c1 is
      SELECT PROPERTY_FIX_FITTINGS_OBJ_TYPE( PFF.FIX_ID,
  PM.PROPERTY_NUMBER,
  PFF.PROPERTY_ID,
  PB.BUILD_NUMBER,
  PFF.BUILD_ID,
  PU.UNIT_NUMBER,
  PFF.UNIT_ID,
  PFF.FIX_CATEGORY,
  PFF.DESCRIPTION,
  PFF.FIX_CONDITION,
  PFF.UOM,
  PFF.VALUE,
  PFF.QUANTITY,
  PFF.RATE)
FROM XXPM_PROPERTY_FIX_FITTINGS PFF,
  XXPM_PROPERTY_UNITS PU,
  XXPM_PROPERTY_BUILDINGS PB,
  XXPM_PROPERTY_MASTER PM
WHERE PFF.UNIT_ID=PU.UNIT_ID
AND PFF.BUILD_ID = PB.BUILD_ID
AND PFF.PROPERTY_ID=PM.PROPERTY_ID
AND PFF.UNIT_ID IN
  (SELECT pu.UNIT_ID
  FROM XXPM_PROPERTY_UNITS pu ,
    XXPM_PROPERTY_MASTER PM,
    XXPM_PROPERTY_BUILDINGS PB
  WHERE PU.PROPERTY_ID   = PM.PROPERTY_ID
  AND PU.BUILD_ID        = PB.BUILD_ID
  AND PB.PROPERTY_ID     = PM.PROPERTY_ID
  AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
      AND (P_UNIT_NUMBER IS NULL OR PU.UNIT_NUMBER = P_UNIT_NUMBER)
      AND (P_UNIT_SHORTCODE IS NULL OR PU.UNIT_SHORTCODE = P_UNIT_SHORTCODE)
      AND (P_UNIT_TYPE IS NULL OR  PU.UNIT_TYPE=P_UNIT_TYPE)
      AND (P_STATUS IS NULL OR PU.STATUS=P_STATUS))
  order by pu.unit_number;
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_fix_tbl;
    CLOSE c1 ;
     p_fix_tbl := l_fix_tbl ;
  END units_fix_fittings_upload;

    PROCEDURE owner_dtle_upload(
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_unit_number      IN VARCHAR2,
      p_unit_shortcode   IN VARCHAR2,
      p_unit_type        IN VARCHAR2,
      p_status           IN VARCHAR2,
      p_owner_tbl OUT owner_dtle_tab_Type)
  AS
    l_owner_tbl owner_dtle_tab_Type ;
    CURSOR c1 is
      SELECT owner_dtle_Obj_Type(POD.owner_id,
  PM.PROPERTY_NUMBER,
  POD.PROPERTY_ID,
  PB.BUILD_NUMBER,
  POD.BUILD_ID,
  PU.UNIT_NUMBER,
  POD.UNIT_ID,
  POD.vend_id,
  POD.vend_site_id,
  POD.primary_yn,
  POD.description)
FROM xxpl_owner_dtle POD,
  XXPM_PROPERTY_UNITS PU,
  XXPM_PROPERTY_BUILDINGS PB,
  XXPM_PROPERTY_MASTER PM
WHERE POD.UNIT_ID=PU.UNIT_ID
AND POD.BUILD_ID = PB.BUILD_ID
AND POD.PROPERTY_ID=PM.PROPERTY_ID
AND POD.UNIT_ID IN
  (SELECT pu.UNIT_ID
  FROM XXPM_PROPERTY_UNITS pu ,
    XXPM_PROPERTY_MASTER PM,
    XXPM_PROPERTY_BUILDINGS PB
  WHERE PU.PROPERTY_ID   = PM.PROPERTY_ID
  AND PU.BUILD_ID        = PB.BUILD_ID
  AND PB.PROPERTY_ID     = PM.PROPERTY_ID
   AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
      AND (P_UNIT_NUMBER IS NULL OR PU.UNIT_NUMBER = P_UNIT_NUMBER)
      AND (P_UNIT_SHORTCODE IS NULL OR PU.UNIT_SHORTCODE = P_UNIT_SHORTCODE)
      AND (P_UNIT_TYPE IS NULL OR  PU.UNIT_TYPE=P_UNIT_TYPE)
      AND (P_STATUS IS NULL OR PU.STATUS=P_STATUS))
  order by pu.unit_number;
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_owner_tbl;
    CLOSE c1 ;
     p_owner_tbl := l_owner_tbl ;
  END owner_dtle_upload;

 PROCEDURE    milestones_header_upload(
        p_milestone_name    IN VARCHAR2,
      p_milestone_number       IN VARCHAR2,
      p_org_name        IN VARCHAR2,
      p_status      IN VARCHAR2,
       p_saleorlease IN VARCHAR2,
      p_mshdr_tbl OUT MILESTONE_HEADER_TABLE_TYPE)
  AS
    l_mshdr_tbl MILESTONE_HEADER_TABLE_TYPE ;
    CURSOR c1 is
      SELECT MILESTONE_HEADER_OBJ_TYPE (	
mdr.MS_HDR_ID,	
mdr.MILESTONE_NAME,
mdr.MILESTONE_NAME_TL,	
mdr.MILESTONE_NUMBER,	
mdr.MILESTONE_SHORTCODE,	
mdr.MILESTONE_DATE, 
mdr.ORG_ID,	
mdr.PROJECT_ID,	
mdr.USAGE,	
mdr.REVISION_NO,	
mdr.REVISION_DATE,	
mdr.REVISED_BY,	
mdr.DESCRIPTION,	
mdr.START_DATE,	
mdr.END_DATE,
mdr.ACTIVE_YN,	
mdr.STATUS)
      FROM XXPM_MILESTONE_HDR mdr,
       XXSTG_ORGANIZATIONS org 

      WHERE mdr.org_id    = org.org_id

      AND (p_milestone_name IS NULL OR mdr.MILESTONE_NAME = p_milestone_name)
      AND (p_milestone_number IS NULL OR mdr.MILESTONE_NUMBER = p_milestone_number)
      AND (p_org_name IS NULL OR org.ORG_NAME = p_org_name)
      AND (P_STATUS IS NULL OR mdr.STATUS=P_STATUS)
      AND (p_saleorlease IS NULL OR mdr.usage = p_saleorlease)
      ORDER BY   
        mdr.MS_HDR_ID;   
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_mshdr_tbl;
    CLOSE c1 ;
     p_mshdr_tbl := l_mshdr_tbl ;
  END milestones_header_upload;

   PROCEDURE milestones_line_upload(
      p_milestone_name    IN VARCHAR2,
      p_milestone_number       IN VARCHAR2,
      p_org_name        IN VARCHAR2,
      p_status      IN VARCHAR2,
       p_saleorlease IN VARCHAR2,
      p_msline_tbl OUT MILESTONE_LINE_TABLE_TYPE)
  AS
    l_msline_tbl MILESTONE_LINE_TABLE_TYPE ;
    CURSOR c1 is
SELECT MILESTONE_LINE_OBJ_TYPE(msdtl.MS_DTL_ID,
msdtl.ms_hdr_id,
mdr.MILESTONE_NUMBER,
msdtl.SEQ_NUMBER,
msdtl.INSTALLMENT_TYPE,
msdtl.INSTALLMENT_PCT,
msdtl.CHARGE_TYPE,
msdtl.PAYMENT_TERM,
msdtl.REMARKS,
msdtl.DUE_DAYS,
msdtl.DUE_DAYS_FROM	,
msdtl.PROJ_MS_ID,
msdtl.DUE_DATE,
msdtl.REVISION,
msdtl.REVISION_DATE,
msdtl.REVISED_BY,
msdtl.INSTALLMENT_METHOD,
msdtl.INSTALLMENT_EVENT,
msdtl.PERIOD_OCCURENCE,
msdtl.PERIOD_VALUES,
msdtl.PERIOD_DURATION)
FROM XXPM_MILESTONE_DTL msdtl,
XXPM_MILESTONE_HDR mdr,
XXSTG_ORGANIZATIONS org
where
mdr.MS_HDR_ID=msdtl.MS_HDR_ID and
org.org_id=mdr.org_id 
AND (p_milestone_name IS NULL OR mdr.MILESTONE_NAME = p_milestone_name)
      AND (p_milestone_number IS NULL OR mdr.MILESTONE_NUMBER = p_milestone_number)
      AND (p_org_name IS NULL OR org.ORG_NAME = p_org_name)
      AND (P_STATUS IS NULL OR mdr.STATUS=P_STATUS)
      AND (p_saleorlease IS NULL OR mdr.usage = p_saleorlease)
      ORDER BY   
        mdr.MS_HDR_ID;   
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_msline_tbl;
    CLOSE c1 ;
     p_msline_tbl := l_msline_tbl ;
  END milestones_line_upload;



  PROCEDURE pricelist_header_upload(
    p_price_list_name  IN VARCHAR2,
	  p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_saleorlease IN VARCHAR2,
      p_plhdr_tbl OUT PL_HEADER_TABLE_TYPE)
  AS
    l_plhdr_tbl PL_HEADER_TABLE_TYPE ;
    CURSOR c1 is
      select PL_HEADER_OBJ_TYPE (PL_NUMBER,
PL_NAME,
PL_NAME_TL,
DESCRIPTION,
ORG_ID,
PL_TYPE,
PRIORITY,
USAGE,
CURRENCY_CODE,
START_DATE,
END_DATE,
STATUS,
BASE_PRICE_YN,
ACTIVE_YN)
from 
xxpm_pl_header
where pl_id IN (SELECT 
ph.PL_ID
      FROM xxpm_property_master pm,
        xxpm_property_buildings pb,
        xxpm_property_units pu,
		xxpm_pl_header ph,
		xxpm_pl_lines pl
                , XXSTG_ORGANIZATIONS xo	
      WHERE ph.pl_id=pl.pl_id(+) and
	       pl.property_id    = pm.property_id(+)
      AND pl.build_id         = pb.build_id(+)
      AND pl.unit_id      = pu.unit_id(+)
      AND ph.org_id = xo.org_id
      and xo.ORG_NAME = p_business_unit
      AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME like '%'||P_UNIT_NAME||'%')
     AND (p_revision_no IS NULL OR PH.REVISION_NO = p_revision_no)
	 AND (p_price_list_name IS NULL OR PH.PL_NAME like '%'||p_price_list_name||'%')
     AND (p_saleorlease IS NULL OR PH.USAGE = p_saleorlease))
      ORDER BY   
        pl_id;   
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_plhdr_tbl;
    CLOSE c1 ;
     p_plhdr_tbl := l_plhdr_tbl ;
  END pricelist_header_upload;

  PROCEDURE pricelist_line_upload(
      p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
      p_saleorlease IN VARCHAR2,
      p_plline_tbl OUT PL_LINE_TABLE_TYPE)
  AS
    l_plline_tbl PL_LINE_TABLE_TYPE ;
    CURSOR c1 is
      SELECT 
PL_LINE_OBJ_TYPE(pl.pll_id,
ph.pl_number,
xpm.property_number,
xpb.build_number,
xpu.unit_number,
pl.uom,
pl.base_price,
pl.min_price,
pl.start_date,
pl.end_date,
pl.active_yn)
      FROM 
		xxpm_pl_lines pl,
        xxpm_pl_header ph,
        xxpm_property_master xpm,
        xxpm_property_buildings xpb,
        xxpm_property_units xpu 
      , XXSTG_ORGANIZATIONS xo
    where pl.pl_id = ph.pl_id(+)
    and xpm.property_id = pl.property_id
    and xpb.build_id = pl.build_id
    and xpu.unit_id = pl.unit_id
      AND ph.org_id = xo.org_id
      and xo.ORG_NAME = p_business_unit
    AND (P_PROPERTY_NAME IS NULL OR XPM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR XPB.BUILD_NAME = P_BUILD_NAME)
    and ( P_UNIT_NAME is null OR xpu.UNIT_NAME like '%'||P_UNIT_NAME||'%')
    and pl.pl_id IN (SELECT 
ph.PL_ID
      FROM xxpm_property_master pm,
        xxpm_property_buildings pb,
        xxpm_property_units pu,
		xxpm_pl_header ph,
		xxpm_pl_lines pl		
      WHERE ph.pl_id=pl.pl_id(+) and
	       pl.property_id    = pm.property_id(+)
      AND pl.build_id         = pb.build_id(+)
      AND pl.unit_id      = pu.unit_id(+)
     AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME like '%'||P_UNIT_NAME||'%')
     AND (p_revision_no IS NULL OR PH.REVISION_NO = p_revision_no)
	 AND (p_price_list_name IS NULL OR PH.PL_NAME like '%'||p_price_list_name||'%')
     AND (p_saleorlease IS NULL OR PH.USAGE = p_saleorlease))
      ORDER BY   
        pl.pl_id;
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_plline_tbl;
    CLOSE c1 ;
     p_plline_tbl := l_plline_tbl ;
  END pricelist_line_upload;


  PROCEDURE pricelist_modifiers_upload(
      p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
	  p_saleorlease IN VARCHAR2,
      p_plmod_tbl OUT PL_MODIFIERS_TABLE_TYPE)
  AS
    l_plmod_tbl PL_MODIFIERS_TABLE_TYPE ;
    CURSOR c1 is
      select 
PL_MODIFIERS_OBJ_TYPE (xpm.pl_mod_id,
xph.pl_number,
xpm.mod_id,
xpm.start_date,
xpm.end_date,
xpm.active_yn,
null)
from 
XXPM_PL_MODIFIERS xpm,
xxpm_pl_header xph
where xpm.pl_id = xph.pl_id
and xpm.pl_id IN (SELECT 
ph.PL_ID
      FROM xxpm_property_master pm,
        xxpm_property_buildings pb,
        xxpm_property_units pu,
		xxpm_pl_header ph,
		xxpm_pl_lines pl		
      WHERE ph.pl_id=pl.pl_id(+) and
	       pl.property_id    = pm.property_id(+)
      AND pl.build_id         = pb.build_id(+)
      AND pl.unit_id      = pu.unit_id(+)
     AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
     AND (p_revision_no IS NULL OR PH.REVISION_NO = p_revision_no)
	 AND (p_price_list_name IS NULL OR PH.PL_NAME = p_price_list_name)
     AND (p_saleorlease IS NULL OR PH.USAGE = p_saleorlease))
 order by xpm.pl_id;  
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_plmod_tbl;
    CLOSE c1 ;
     p_plmod_tbl := l_plmod_tbl ;
  END pricelist_modifiers_upload;

      PROCEDURE pricelist_qualifiers_upload(
     p_price_list_name  IN VARCHAR2,
	 p_revision_no     IN VARCHAR2,
	 p_business_unit   IN VARCHAR2,
      p_property_name    IN VARCHAR2,
      p_build_name       IN VARCHAR2,
      p_unit_name        IN VARCHAR2,
	  p_saleorlease IN VARCHAR2,
        p_plqd_tbl OUT PL_QUALIFIERS_TABLE_TYPE)
  AS
    l_plqd_tbl PL_QUALIFIERS_TABLE_TYPE ;
    CURSOR c1 is
      select 
PL_QUALIFIERS_OBJ_TYPE(xpq.PL_QLFY_ID,
xpq.PL_MOD_ID,
xpq.QLFY_ID,
xpq.START_DATE,
xpq.END_DATE,
xpq.ACTIVE_YN,
null)
from 
xxpm_pl_qualifiers xpq,
xxpm_pl_modifiers xpm
where xpq.pl_mod_id = xpm.pl_mod_id
and xpm.pl_id IN (SELECT 
ph.PL_ID
      FROM xxpm_property_master pm,
        xxpm_property_buildings pb,
        xxpm_property_units pu,
		xxpm_pl_header ph,
		xxpm_pl_lines pl		
      WHERE ph.pl_id=pl.pl_id(+) and
	       pl.property_id    = pm.property_id(+)
      AND pl.build_id         = pb.build_id(+)
      AND pl.unit_id      = pu.unit_id(+)
      AND (P_PROPERTY_NAME IS NULL OR PM.PROPERTY_NAME = P_PROPERTY_NAME)
      AND (P_BUILD_NAME IS NULL OR PB.BUILD_NAME = P_BUILD_NAME)
      AND (P_UNIT_NAME IS NULL OR PU.UNIT_NAME = P_UNIT_NAME)
     AND (p_revision_no IS NULL OR PH.REVISION_NO = p_revision_no)
	 AND (p_price_list_name IS NULL OR PH.PL_NAME = p_price_list_name)
     AND (p_saleorlease IS NULL OR PH.USAGE = p_saleorlease))
     order by xpm.pl_id;  
  BEGIN
   OPEN c1 ;
    FETCH c1 bulk collect INTO l_plqd_tbl;
    CLOSE c1 ;
     p_plqd_tbl := l_plqd_tbl ;
  END pricelist_qualifiers_upload;

END xxdm_exceldata_migration_pkg;
/
