--------------------------------------------------------
--  DDL for Package XXPM_MILESTONE_DETAIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_MILESTONE_DETAIL_PKG" 

IS

   PROCEDURE xxpm_milestone_dtl_val (p_batch_id IN NUMBER);

--   PROCEDURE update_milestone_temp (v_status_flag IN varchar2
--                                   ,v_err_desc IN varchar2
--                                   ,v_err_msg IN varchar2
--                                   ,v_property_number IN varchar2
--                                   ,v_build_number IN varchar2
--                                   ,v_batch_id IN number);
--                                   
   PROCEDURE xxpm_ms_history_insert (p_batch_id number ,p_ms_dtl_id in number );

   PROCEDURE xxpm_milestone_dtl_insert (p_batch_id number);

END XXPM_MILESTONE_DETAIL_PKG;
