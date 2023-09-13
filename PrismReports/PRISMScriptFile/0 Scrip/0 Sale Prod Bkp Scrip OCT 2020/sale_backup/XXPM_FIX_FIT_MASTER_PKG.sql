--------------------------------------------------------
--  DDL for Package XXPM_FIX_FIT_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_FIX_FIT_MASTER_PKG" 
IS
  PROCEDURE xxpm_fix_fit_master_val(
      i_batch_id IN NUMBER);
  PROCEDURE update_fix_fit_temp(
      v_status_flag     IN VARCHAR2,
      v_err_desc        IN VARCHAR2,
      v_err_msg         IN VARCHAR2,
      v_property_number IN VARCHAR2,
      v_build_number    IN VARCHAR2,
      v_unit_number         IN VARCHAR2,
      v_batch_id        IN NUMBER
      );
  PROCEDURE insert_fix_fit_master(
      i_batch_id IN NUMBER);
END XXPM_FIX_FIT_MASTER_PKG;
