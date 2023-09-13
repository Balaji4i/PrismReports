--------------------------------------------------------
--  DDL for Package XXPM_PRICELIST_DETAIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PRICELIST_DETAIL_PKG" 
IS
  PROCEDURE xxpm_pricelist_detail_val
    (
      i_batch_id IN NUMBER
    )
    ;
  PROCEDURE xxdm_pl_lines_update
    (
      v_batch_id    IN NUMBER,
    v_rowid      IN VARCHAR2,
      v_err_desc    IN VARCHAR2,
      v_status_flag IN VARCHAR2,
      v_err_msg     IN VARCHAR2 )
    ;
PROCEDURE xxpm_pl_lines_insert_history(
    v_PL_ID       IN NUMBER ,
    v_pll_id      IN NUMBER ,
    v_BATCH_ID    IN NUMBER ,
    V_PROPERTY_ID IN NUMBER,
    V_BUILD_ID    IN NUMBER,
    V_UNIT_ID     IN NUMBER) ;
  PROCEDURE xxpm_pl_lines_update
    (
      v_PLL_ID      IN NUMBER,
      v_property_id IN NUMBER,
      v_build_id    IN NUMBER,
      v_unit_id     IN NUMBER,
      v_BATCH_ID    IN NUMBER
    )
    ;
  PROCEDURE xxpm_pl_lines_insert
    (
      v_batch_id      IN NUMBER

    )
    ;
END XXPM_PRICELIST_DETAIL_PKG;
