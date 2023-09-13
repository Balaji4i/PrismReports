--------------------------------------------------------
--  DDL for Package XXPM_AREA_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_AREA_MASTER_PKG" 

IS
   PROCEDURE xxpm_area_master_val(i_batch_id IN NUMBER);
   PROCEDURE update_area_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_property_number IN varchar2,
                               v_build_number IN varchar2,v_unit_number IN varchar2,v_batch_id IN number,v_area in varchar2);
   PROCEDURE unit_area_value_validation (p_property_id IN number,p_build_id IN number,p_batch_id IN number,p_status OUT varchar2);                           
   PROCEDURE insert_area_master (i_batch_id IN NUMBER);
   PROCEDURE xxdm_area_validations(p_batch_id IN NUMBER);


END XXPM_AREA_MASTER_PKG;
