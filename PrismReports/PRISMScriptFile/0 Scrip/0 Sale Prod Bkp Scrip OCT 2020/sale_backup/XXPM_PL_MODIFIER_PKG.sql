--------------------------------------------------------
--  DDL for Package XXPM_PL_MODIFIER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PL_MODIFIER_PKG" 
IS
  PROCEDURE xxpm_pl_modifier_val(
      i_batch_id IN NUMBER);
  PROCEDURE update_pl_modifier_temp (v_status_flag IN varchar2,v_err_desc IN varchar2,v_err_msg IN varchar2,v_rowid IN VARCHAR2,
                                    v_mod_id IN number,v_pl_id IN  varchar2,v_batch_id IN number);
  PROCEDURE insert_pl_modifiers (i_batch_id IN NUMBER);

  procedure insert_history(   v_BATCH_ID IN NUMBER,v_pl_number in varchar2 ,v_pl_mod_id in number);
END XXPM_PL_MODIFIER_PKG;
