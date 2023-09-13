--------------------------------------------------------
--  DDL for Package XXDM_EXCELDATA_MIGRATION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXDM_EXCELDATA_MIGRATION_PKG" is
      
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
