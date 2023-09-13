--------------------------------------------------------
--  DDL for Package XXREP_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXREP_REPORT_PKG" IS
   PROCEDURE sync_project (p_project_id   IN number
                          ,p_xml_data     IN CLOB);

   PROCEDURE sync_task (p_project_id   IN number
                       ,p_xml_data     IN CLOB);

   PROCEDURE sync_budget (p_project_id   IN number
                         ,p_xml_data     IN CLOB);

   FUNCTION fcr_detail (p_project_id   IN number
                       ,p_date         IN string)
      RETURN CLOB;

   PROCEDURE sync_project_summary (p_bu_id      IN number
                                  ,p_batch_id   IN number
                                  ,p_date       IN string
                                  ,p_xml_data   IN CLOB);

   FUNCTION PROJECT_SUMMARY (p_bu_id      IN NUMBER
                            ,p_batch_id   IN number
                            ,p_date       IN STRING
                            ,p_status     IN string)
      RETURN CLOB;
END xxrep_report_pkg;
