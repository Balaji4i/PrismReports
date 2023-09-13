--------------------------------------------------------
--  DDL for Package XXPM_PRICELIST_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PRICELIST_MASTER_PKG" 
IS
  PROCEDURE xxpm_pricelist_master_val
    (
      i_batch_id IN NUMBER
    )
    ;
  PROCEDURE xxdm_pricelist_update
    (
      v_batch_id    IN NUMBER,
    v_rowid       IN VARCHAR2,
      v_err_desc    IN VARCHAR2,
      v_status_flag IN VARCHAR2,
      v_err_msg     IN VARCHAR2
    )
    ;
  PROCEDURE xxpm_pricelist_insert_history
    (
       v_PL_NUMBER    IN varchar2,v_batch_id in number
    )
    ;
  PROCEDURE xxpm_pricelist_update
    (
       v_PL_NUMBER    IN varchar2,v_BATCH_ID IN NUMBER
    )
    ;
  PROCEDURE xxpm_pricelist_insert
    (
       v_batch_id IN NUMBER
    )
    ;
END XXPM_PRICELIST_MASTER_PKG;
