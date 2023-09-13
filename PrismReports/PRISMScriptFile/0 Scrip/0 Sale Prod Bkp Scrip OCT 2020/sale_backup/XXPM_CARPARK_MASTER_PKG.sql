--------------------------------------------------------
--  DDL for Package XXPM_CARPARK_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_CARPARK_MASTER_PKG" 
IS
  PROCEDURE xxpm_carpark_master_val(
      i_batch_id IN NUMBER);
  PROCEDURE update_carpark_temp(
      v_status_flag     IN VARCHAR2,
      v_err_desc        IN VARCHAR2,
      v_err_msg         IN VARCHAR2,
      v_unit_number    IN VARCHAR2,
      v_batch_id        IN NUMBER);
  PROCEDURE insert_carpark_master(
      i_batch_id IN NUMBER);
END XXPM_CARPARK_MASTER_PKG;
