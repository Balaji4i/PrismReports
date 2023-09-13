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
