--------------------------------------------------------
--  DDL for Package XXPM_UNIT_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_UNIT_MASTER_PKG" 

IS
   PROCEDURE xxpm_unit_master_val(i_batch_id IN NUMBER);
   PROCEDURE update_unit_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_property_number IN varchar2,
                               v_build_number IN varchar2,v_unit_number IN varchar2,v_batch_id IN number);
   PROCEDURE insert_unit_master (i_batch_id IN NUMBER);


   PROCEDURE CREATE_BLOCKING_FROM_EXCEL (P_PropertyId IN NUMBER, 
                                 P_build_id IN NUMBER,
                                 P_unit_id IN NUMBER);

END XXPM_UNIT_MASTER_PKG;
