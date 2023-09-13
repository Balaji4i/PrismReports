--------------------------------------------------------
--  DDL for Package XXFND_NODE_SCHEDULER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXFND_NODE_SCHEDULER" AS
    PROCEDURE get_schedule (
        p_cursor     OUT   SYS_REFCURSOR,
        p_fusion_domain   OUT   VARCHAR2,
        p_fusion_uname    OUT   VARCHAR2,
        p_fusion_pwd      OUT   VARCHAR2,
        p_err_code   OUT   VARCHAR2,
        p_err_msg    OUT   VARCHAR2
    );

    PROCEDURE ins_schdl_list (
        p_schedule_id    IN    NUMBER,
        p_table_name     IN    VARCHAR2,
        p_schdl_list     OUT   SYS_REFCURSOR,
        p_table_struct   OUT   SYS_REFCURSOR,
        p_err_code       OUT   VARCHAR2,
        p_err_msg        OUT   VARCHAR2
    );

    PROCEDURE get_table_columns (
        p_table_name   IN    VARCHAR2,
        p_cursor       OUT   SYS_REFCURSOR,
        p_err_code     OUT   VARCHAR2,
        p_err_msg      OUT   VARCHAR2
    );

    PROCEDURE execute_merge_query (
        p_table_name   IN OUT  VARCHAR2,
        p_merge        IN OUT  VARCHAR2,
        p_err_code     OUT     VARCHAR2,
        p_err_msg      OUT     VARCHAR2
    );

    PROCEDURE ins_err_log (
        p_table_name   IN   VARCHAR2,
        p_merge        IN   VARCHAR2,
        p_err_code     IN   VARCHAR2,
        p_err_msg      IN   VARCHAR2
    );

    PROCEDURE upd_schdl_list_status (
        p_schdl_list_id   IN   VARCHAR2,
        p_status          IN   VARCHAR2,
        p_err_msg         IN   VARCHAR
    );

END XXFND_NODE_SCHEDULER;
