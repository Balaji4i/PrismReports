--------------------------------------------------------
--  DDL for Package XXPM_MILESTONE_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_MILESTONE_MASTER_PKG" 

IS

   PROCEDURE xxpm_milestone_master_val (i_batch_id IN NUMBER);

--   PROCEDURE update_milestone_temp (v_status_flag IN varchar2
--                                   ,v_err_desc IN varchar2
--                                   ,v_err_msg IN varchar2
--                                   ,v_property_number IN varchar2
--                                   ,v_build_number IN varchar2
--                                   ,v_batch_id IN number);
--                                   
   PROCEDURE xxpm_milestone_insert_history (p_batch_id NUMBER , p_milestone_number in varchar2);

   PROCEDURE xxpm_milestone_insert (p_batch_id NUMBER);

END XXPM_MILESTONE_MASTER_PKG;
