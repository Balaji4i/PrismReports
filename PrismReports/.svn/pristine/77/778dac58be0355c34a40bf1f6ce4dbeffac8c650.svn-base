--------------------------------------------------------
--  DDL for Package XXPM_PL_QUALIFIER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PL_QUALIFIER_PKG" 
IS
  PROCEDURE xxpm_pl_qualifier_val(
      i_batch_id IN NUMBER);
 PROCEDURE update_pl_qualifier_temp (v_status_flag IN VARCHAR2,v_err_desc IN VARCHAR2,v_err_msg IN VARCHAR2,v_rowid IN VARCHAR2,
                                    v_qlfy_id IN number,v_batch_id IN number);
  PROCEDURE insert_pl_qualifier (i_batch_id IN NUMBER);

  procedure insert_history(v_batch_id IN NUMBER ,v_PL_QLFY_ID in number);

END XXPM_PL_QUALIFIER_PKG;
