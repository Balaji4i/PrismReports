--------------------------------------------------------
--  DDL for Package Body XXREP_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXREP_REPORT_PKG" IS
   PROCEDURE sync_project (p_project_id   IN number
                          ,p_xml_data     IN CLOB) IS
      l_xml_data   xmltype := xmltype.createxml (p_xml_data);

      TYPE l_rec IS TABLE OF xxrep_project%ROWTYPE
                      INDEX BY binary_integer;

      l_tbl        l_rec;

      CURSOR c_1 IS
         SELECT   project_id
                 ,project_number
                 ,project_name
                 ,plot_num
                 ,TO_DATE (baseline_date
                          ,'YYYY-MM-DD')
                     baseline_date
                 ,org_id
           FROM   XMLTABLE ('/DATA_DS/G_1' PASSING l_xml_data COLUMNS project_id number PATH 'PROJECT_ID',
                            project_number varchar2 (240) PATH 'PROJECT_NUMBER', project_name varchar2 (240) PATH
                            'PROJECT_NAME', org_id number PATH 'ORG_ID', plot_num varchar2 (150) PATH 'PLOT_NUM',
                            baseline_date varchar2 (240) PATH 'BASELINE_DATE');
   BEGIN
      DELETE FROM   xxrep_project
            WHERE   project_id = p_project_id;



      OPEN c_1;

      FETCH c_1 BULK COLLECT INTO   l_tbl;

      CLOSE c_1;

      FOR i IN l_tbl.FIRST .. l_tbl.LAST LOOP
         INSERT INTO xxrep_project (project_id
                                   ,project_number
                                   ,project_name
                                   ,org_id
                                   ,plot_num
                                   ,baseline_date)
           VALUES   (l_tbl (i).project_id
                    ,l_tbl (i).project_number
                    ,l_tbl (i).project_name
                    ,l_tbl (i).org_id
                    ,l_tbl (i).plot_num
                    ,l_tbl (i).baseline_date);
      END LOOP;

      COMMIT;
   END sync_project;

   PROCEDURE sync_task (p_project_id   IN number
                       ,p_xml_data     IN CLOB) IS
      l_xml_data   xmltype := xmltype.createxml (p_xml_data);

      TYPE l_rec IS TABLE OF xxrep_task%ROWTYPE
                      INDEX BY binary_integer;

      l_tbl        l_rec;

      CURSOR c_1 IS
         SELECT   project_id
                 ,task_id
                 ,task_number
                 ,task_name
                 ,display_sequence
                 ,top_task_id
                 ,wbs_level
                 ,parent_task_id
                 ,sub_contractor
                 ,contract_amount
                 ,pc_amount
                 ,pc_amount_paid
           FROM   XMLTABLE ('/DATA_DS/G_1' PASSING l_xml_data COLUMNS project_id number PATH 'PROJECT_ID', task_id
                            number PATH 'TASK_ID', task_number varchar2 (240) PATH 'TASK_NUMBER', task_name varchar2 (
                            240) PATH 'TASK_NAME', display_sequence number PATH 'DISPLAY_SEQUENCE', top_task_id number
                            PATH 'TOP_TASK_ID', wbs_level number PATH 'WBS_LEVEL', parent_task_id number PATH
                            'PARENT_TASK_ID', sub_contractor varchar2 (40) PATH 'SUB_CONTRACTOR', contract_amount
                            number PATH 'CONTRACT_AMOUNT', pc_amount number PATH 'PC_AMOUNT', pc_amount_paid number
                            PATH 'PC_AMOUNT_PAID');
   BEGIN
      DELETE FROM   xxrep_task
            WHERE   project_id = p_project_id;

      OPEN c_1;

      FETCH c_1 BULK COLLECT INTO   l_tbl;

      CLOSE c_1;

      FOR i IN l_tbl.FIRST .. l_tbl.LAST LOOP
         INSERT INTO xxrep_task (project_id
                                ,task_id
                                ,task_number
                                ,task_name
                                ,display_sequence
                                ,top_task_id
                                ,wbs_level
                                ,parent_task_id
                                ,sub_contractor
                                ,contract_amount
                                ,pc_amount
                                ,pc_amount_paid)
           VALUES   (l_tbl (i).project_id
                    ,l_tbl (i).task_id
                    ,l_tbl (i).task_number
                    ,l_tbl (i).task_name
                    ,l_tbl (i).display_sequence
                    ,l_tbl (i).top_task_id
                    ,l_tbl (i).wbs_level
                    ,l_tbl (i).parent_task_id
                    ,l_tbl (i).sub_contractor
                    ,l_tbl (i).contract_amount
                    ,l_tbl (i).pc_amount
                    ,l_tbl (i).pc_amount_paid);
      END LOOP;

      COMMIT;
   END sync_task;

   PROCEDURE sync_budget (p_project_id   IN number
                         ,p_xml_data     IN CLOB) IS
      l_xml_data   xmltype := xmltype.createxml (p_xml_data);

      TYPE l_rec IS TABLE OF xxrep_project_budget%ROWTYPE
                      INDEX BY binary_integer;

      l_tbl        l_rec;

      CURSOR c_1 IS
         SELECT   project_id
                 ,task_id
                 ,budget_value_o
                 ,budget_value_c
                 ,budget_value_p
                 ,pvo_approved_lm
                 ,pvo_submitted_lm
                 ,pvo_approved
                 ,pvo_submitted
                 ,pc_paid
                 ,vendor_name
                 ,contract_value_o
                 ,vo_lm
                 ,vo
           FROM   XMLTABLE ('/DATA_DS/G_1' PASSING l_xml_data COLUMNS project_id number PATH 'PROJECT_ID', task_id
                            number PATH 'TASK_ID', budget_value_o number PATH 'BUDGET_COST_O', budget_value_c number
                            PATH 'BUDGET_COST_C', budget_value_p number PATH 'BUDGET_COST_P', pvo_approved_lm number
                            PATH 'PVO_APPROVED_LM', pvo_submitted_lm number PATH 'PVO_SUBMITTED_LM', pvo_approved
                            number PATH 'PVO_APPROVED', pvo_submitted number PATH 'PVO_SUBMITTED', pc_paid number PATH
                            'PC_PAID', vendor_name varchar2 (240) PATH 'VENDOR_NAME', contract_value_o number PATH
                            'CONTRACT_VALUE_O', vo_lm number PATH 'VO_LM', vo number PATH 'VO');
   BEGIN
      DELETE FROM   xxrep_project_budget
            WHERE   project_id = p_project_id;

      OPEN c_1;

      FETCH c_1 BULK COLLECT INTO   l_tbl;

      CLOSE c_1;

      FOR i IN l_tbl.FIRST .. l_tbl.LAST LOOP
         INSERT INTO xxrep_project_budget (project_id
                                          ,task_id
                                          ,budget_value_o
                                          ,budget_value_c
                                          ,budget_value_p
                                          ,pvo_approved_lm
                                          ,pvo_submitted_lm
                                          ,pvo_approved
                                          ,pvo_submitted
                                          ,pc_paid
                                          ,vendor_name
                                          ,contract_value_o
                                          ,vo_lm
                                          ,vo)
           VALUES   (l_tbl (i).project_id
                    ,l_tbl (i).task_id
                    ,l_tbl (i).budget_value_o
                    ,l_tbl (i).budget_value_c
                    ,l_tbl (i).budget_value_p
                    ,l_tbl (i).pvo_approved_lm
                    ,l_tbl (i).pvo_submitted_lm
                    ,l_tbl (i).pvo_approved
                    ,l_tbl (i).pvo_submitted
                    ,l_tbl (i).pc_paid
                    ,l_tbl (i).vendor_name
                    ,l_tbl (i).contract_value_o
                    ,l_tbl (i).vo_lm
                    ,l_tbl (i).vo);
      END LOOP;

      COMMIT;
   END sync_budget;

   FUNCTION fcr_detail (p_project_id   IN number
                       ,p_date         IN string)
      RETURN CLOB IS
      l_query_ref   sys_refcursor;
      l_handle      DBMS_XMLGEN.ctxhandle;
      l_data_xml    CLOB;
      l_date date
            := TO_DATE (TO_CHAR (TO_DATE (p_date
                                         ,'dd-MM-yyyy')
                                ,'DD-MM-RR')
                       ,'DD-MM-RR') ;
      l_fc_cm       number;
   BEGIN
      BEGIN
         SELECT   SUM (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0))
           INTO   l_fc_cm
           FROM   xxrep_project_budget_v
          WHERE   project_id = p_project_id;

         IF l_fc_cm = 0
         THEN
            l_fc_cm := NULL;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            l_fc_cm := NULL;
      END;

      OPEN l_query_ref FOR
         SELECT   xp.project_id
                 ,xp.project_number
                 ,xp.project_name
                 ,xp.plot_num
                 ,TO_CHAR (xp.baseline_date
                          ,'Month-YYYY')
                     baseline_date
                 ,xp.org_id
                 ,TO_CHAR (xp.baseline_date
                          ,'Month-YYYY')
                     p_date
                 ,TO_CHAR (l_date
                          ,'DD-Mon-YYYY')
                     cut_off_date
                 ,TO_CHAR (l_date
                          ,'Month-YYYY')
                     cut_off_month
                 ,TO_CHAR (ADD_MONTHS (l_date
                                      ,-1)
                          ,'Month-YYYY')
                     cut_off_pre_month
                 ,cursor (
                     SELECT   project_id
                             ,LPAD (task_number
                                   , (LENGTH (task_number) + (2 * wbs_level) - 2)
                                   ,' ')
                                 task_number
                             ,LPAD (task_name
                                   , (LENGTH (task_name) + (2 * wbs_level) - 2)
                                   ,' ')
                                 task_name
                             ,display_sequence
                             ,top_task_id
                             ,wbs_level
                             ,parent_task_id
                             ,budget_value_o
                             ,budget_value_c
                             ,budget_value_p
                             ,contract_value contract_sum
                             ,vo_approved
                             ,pvo_approved
                             ,pvo_submitted
                             , (NVL (contract_value, 0)
                                + NVL (vo_approved, 0)
                                + NVL (pvo_approved, 0)
                                + NVL (pvo_submitted, 0))
                                 curr_month_cm
                             ,forecast_lm forecast_lm
                             ,pc_amount payments_certified
                             --,pc_amount_net payments_certified_net
                             ,NULL payments_certified_net
                             ,pc_amount_paid pc_paid
                             ,supplier_name supplier_name
                             , ( (NVL (contract_value, 0)
                                  + NVL (vo_approved, 0)
                                  + NVL (pvo_approved, 0)
                                  + NVL (pvo_submitted, 0))
                                * 100
                                / l_fc_cm)
                                 per_tot_cost
                             , ( (NVL (contract_value, 0)
                                  + NVL (vo_approved, 0)
                                  + NVL (pvo_approved, 0)
                                  + NVL (pvo_submitted, 0))
                                - NVL (budget_value_c, 0))
                                 var_budget
                             ,CASE
                                 WHEN NVL (budget_value_c, 0) <> 0
                                 THEN
                                    ROUND (
                                       ( ( (NVL (contract_value, 0)
                                            + NVL (vo_approved, 0)
                                            + NVL (pvo_approved, 0)
                                            + NVL (pvo_submitted, 0))
                                          - NVL (budget_value_c, 0))
                                        * 100
                                        / budget_value_c)
                                      ,2
                                    )
                                 ELSE
                                    NULL
                              END
                                 var_budget_per
                             , ( (NVL (contract_value, 0)
                                  + NVL (vo_approved, 0)
                                  + NVL (pvo_approved, 0)
                                  + NVL (pvo_submitted, 0))
                                - NVL (forecast_lm, 0))
                                 var_last_month
                             ,CASE
                                 WHEN NVL (forecast_lm, 0) <> 0
                                 THEN
                                    ROUND (
                                       ( ( (NVL (contract_value, 0)
                                            + NVL (vo_approved, 0)
                                            + NVL (pvo_approved, 0)
                                            + NVL (pvo_submitted, 0))
                                          - NVL (forecast_lm, 0))
                                        * 100
                                        / NVL (forecast_lm, 0))
                                      ,2
                                    )
                                 ELSE
                                    NULL
                              END
                                 var_last_month_per
                             , (NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0)) vo_total
                             , (NVL (budget_value_c, 0) + (NVL (contract_value, 0) + NVL (vo_approved, 0)))
                                 current_estimate
                             , (NVL (contract_value, 0) + NVL (vo_approved, 0)) commit_to_date
                             ,CASE
                                 WHEN (NVL (contract_value, 0)
                                       + NVL (vo_approved, 0)
                                       + NVL (pvo_approved, 0)
                                       + NVL (pvo_submitted, 0)) <> 0
                                 THEN
                                    ROUND (
                                       (pc_amount * 100
                                        / (NVL (contract_value, 0)
                                           + NVL (vo_approved, 0)
                                           + NVL (pvo_approved, 0)
                                           + NVL (pvo_submitted, 0)))
                                      ,2
                                    )
                                 ELSE
                                    NULL
                              END
                                 works_certified_per
                             , ( (NVL (contract_value, 0)
                                  + NVL (vo_approved, 0)
                                  + NVL (pvo_approved, 0)
                                  + NVL (pvo_submitted, 0))
                                - NVL (pc_amount, 0))
                                 balance_certify
                             ,CASE
                                 WHEN (NVL (contract_value, 0)
                                       + NVL (vo_approved, 0)
                                       + NVL (pvo_approved, 0)
                                       + NVL (pvo_submitted, 0)) <> 0
                                 THEN
                                    ROUND (
                                       (pc_amount_net * 100
                                        / (NVL (contract_value, 0)
                                           + NVL (vo_approved, 0)
                                           + NVL (pvo_approved, 0)
                                           + NVL (pvo_submitted, 0)))
                                      ,2
                                    )
                                 ELSE
                                    NULL
                              END
                                 works_certified_per_net
                             ,/*( (NVL (contract_value, 0)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        + NVL (vo_approved, 0)
  + NVL (pvo_approved, 0)
  + NVL (pvo_submitted, 0))
- NVL (pc_amount_net, 0))*/
                              NULL balance_certify_net
                             ,CASE
                                 WHEN (NVL (contract_value, 0)
                                       + NVL (vo_approved, 0)
                                       + NVL (pvo_approved, 0)
                                       + NVL (pvo_submitted, 0)) <> 0
                                 THEN
                                    ROUND (
                                       (pc_amount_paid * 100
                                        / (NVL (contract_value, 0)
                                           + NVL (vo_approved, 0)
                                           + NVL (pvo_approved, 0)
                                           + NVL (pvo_submitted, 0)))
                                      ,2
                                    )
                                 ELSE
                                    NULL
                              END
                                 actual_amt_per
                             , ( (NVL (contract_value, 0)
                                  + NVL (vo_approved, 0)
                                  + NVL (pvo_approved, 0)
                                  + NVL (pvo_submitted, 0))
                                - NVL (pc_amount_paid, 0))
                                 balance_pay
                       FROM   (    SELECT   xpb.project_id
                                           ,xpb.task_number
                                           ,xpb.task_name
                                           ,xpb.display_sequence
                                           ,xpb.top_task_id
                                           ,xpb.wbs_level
                                           ,xpb.parent_task_id
                                           ,supplier_name
                                           , (    SELECT   SUM (budget_value_o)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               budget_value_o
                                           , (    SELECT   SUM (budget_value_c)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               budget_value_c
                                           , (    SELECT   SUM (budget_value_p)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               budget_value_p
                                           , (    SELECT   SUM (contract_value)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               contract_value
                                           , (    SELECT   SUM (vo_approved)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               vo_approved
                                           , (    SELECT   SUM (pvo_approved)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               pvo_approved
                                           , (    SELECT   SUM (pvo_submitted)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               pvo_submitted
                                           , (    SELECT   SUM (forecast_lm)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               forecast_lm
                                           , (    SELECT   SUM (pc_amount)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               pc_amount
                                           , (    SELECT   SUM (pc_amount_net)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               pc_amount_net
                                           , (    SELECT   SUM (pc_amount_paid)
                                                    FROM   xxrep_project_budget_v
                                              START WITH   task_id = xpb.task_id
                                              CONNECT BY   PRIOR task_id = parent_task_id)
                                               pc_amount_paid
                                     FROM   xxrep_project_budget_v xpb
                                    WHERE   1 = 1
                               START WITH   xpb.task_id = xpb.top_task_id
                               CONNECT BY   PRIOR xpb.task_id = xpb.parent_task_id)
                      WHERE   project_id = xp.project_id
                     UNION ALL
                       SELECT   xpb.project_id
                               ,'Total' task_number
                               ,NULL task_name
                               ,MAX (display_sequence) + 1 display_sequence
                               ,TO_NUMBER (NULL) top_task_id
                               ,TO_NUMBER (NULL) wbs_level
                               ,TO_NUMBER (NULL) parent_task_id
                               ,SUM (xpb.budget_value_o) budget_value_o
                               ,SUM (xpb.budget_value_c) budget_value_c
                               ,SUM (xpb.budget_value_p) budget_value_p
                               ,SUM (xpb.contract_value) contract_value
                               ,SUM (vo_approved) vo_approved
                               ,SUM (pvo_approved) pvo_approved
                               ,SUM (pvo_submitted) pvo_submitted
                               ,SUM (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0))
                                   curr_month_cm
                               ,SUM (forecast_lm) forecast_lm
                               ,SUM (pc_amount) pc_amount
                               ,SUM (pc_amount_net) pc_amount_net
                               ,SUM (pc_amount_paid) pc_amount_paid
                               ,NULL supplier_name
                               ,TO_NUMBER (NULL) per_tot_cost
                               ,SUM (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0) - NVL (budget_value_c, 0))
                                   var_budget
                               ,TO_NUMBER (NULL) var_budget_per
                               ,SUM (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0) - NVL (forecast_lm, 0))
                                   var_last_month
                               ,TO_NUMBER (NULL) var_last_month_per
                               ,SUM (NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0)) vo_total
                               ,SUM (NVL (budget_value_c, 0) + (NVL (contract_value, 0) + NVL (vo_approved, 0)))
                                   current_estimate
                               ,SUM (NVL (contract_value, 0) + NVL (vo_approved, 0)) commit_to_date
                               ,TO_NUMBER (NULL) works_certified_per
                               ,SUM ( (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0)) - NVL (pc_amount, 0))
                                   balance_certify
                               ,TO_NUMBER (NULL) works_certified_per_net
                               ,SUM ( (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0)) - NVL (pc_amount, 0))
                                   balance_certify_net
                               ,TO_NUMBER (NULL) actual_amt_per
                               ,SUM (NVL (contract_value, 0) + NVL (vo_approved, 0) + NVL (pvo_approved, 0) + NVL (pvo_submitted, 0) - NVL (pc_amount_paid, 0))
                                   balance_pay
                         FROM   xxrep_project_budget_v xpb
                        WHERE   project_id = xp.project_id
                     GROUP BY   xpb.project_id
                  )
                     g2_dtl
           FROM   xxrep_project xp
          WHERE   1 = 1
              AND xp.project_id = NVL (p_project_id, xp.project_id);



      l_handle := DBMS_XMLGEN.newcontext (l_query_ref);

      DBMS_XMLGEN.setrowsettag (l_handle
                               ,'FCR');
      DBMS_XMLGEN.setrowtag (l_handle
                            ,'FCR_HEAD');
      DBMS_XMLGEN.setnullhandling (l_handle
                                  ,DBMS_XMLGEN.empty_tag);
      l_data_xml := DBMS_XMLGEN.getxml (l_handle);
      RETURN (l_data_xml);
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN (NULL);
   END fcr_detail;

   PROCEDURE sync_project_summary (p_bu_id      IN number
                                  ,p_batch_id   IN number
                                  ,p_date       IN string
                                  ,p_xml_data   IN CLOB) IS
      l_xml_data   xmltype := xmltype.createxml (p_xml_data);

      TYPE l_rec IS TABLE OF xxrep_project_summary%ROWTYPE
                      INDEX BY binary_integer;

      l_tbl        l_rec;

      CURSOR c_1 IS
         SELECT   p_batch_id batch_id
                 ,project_id
                 ,project_num
                 ,project_name
                 ,project_status
                 ,bu_id
                 ,budget_value_o
                 ,budget_value_c
                 ,budget_value_p
                 ,contract_value
                 ,pvo_approved
                 ,pvo_submitted
                 ,vo
                 ,land_area
                 ,floor_area
                 ,saleable_area
                 ,build_area
                 ,pc_amount
                 ,pc_paid
                 ,revenue_value
           FROM   XMLTABLE ('/DATA_DS/G_1' PASSING l_xml_data COLUMNS project_id number PATH 'PROJECT_ID', project_num
                            varchar2 (25) PATH 'PROJECT_NUM', project_name varchar2 (240) PATH 'PROJECT_NAME',
                            project_status varchar2 (80) PATH 'PROJECT_STATUS', bu_id number PATH 'BU_ID',
                            budget_value_o number PATH 'BUDGET_VALUE_O', budget_value_c number PATH 'BUDGET_VALUE_C',
                            budget_value_p number PATH 'BUDGET_VALUE_P', pvo_approved number PATH 'PVO_APPROVED',
                            pvo_submitted number PATH 'PVO_SUBMITTED', land_area number PATH 'LAND_AREA', floor_area
                            number PATH 'FLOOR_AREA', saleable_area number PATH 'SALEABLE_AREA', build_area number
                            PATH 'BUILD_AREA', contract_value number PATH 'CONTRACT_VALUE', vo number PATH 'VO',
                            pc_amount number PATH 'PC_AMOUNT', pc_paid number PATH 'PC_PAID', revenue_value number
                            PATH 'REVENUE_VALUE');
   BEGIN
      OPEN c_1;

      FETCH c_1 BULK COLLECT INTO   l_tbl;

      CLOSE c_1;

      FOR i IN l_tbl.FIRST .. l_tbl.LAST LOOP
         INSERT INTO xxrep_project_summary (batch_id
                                           ,project_id
                                           ,project_num
                                           ,project_name
                                           ,project_status
                                           ,bu_id
                                           ,budget_value_o
                                           ,budget_value_c
                                           ,budget_value_p
                                           ,contract_value
                                           ,pvo_approved
                                           ,pvo_submitted
                                           ,vo
                                           ,land_area
                                           ,floor_area
                                           ,saleable_area
                                           ,build_area
                                           ,pc_amount
                                           ,pc_paid
                                           ,revenue_value)
           VALUES   (l_tbl (i).batch_id
                    ,l_tbl (i).project_id
                    ,l_tbl (i).project_num
                    ,l_tbl (i).project_name
                    ,l_tbl (i).project_status
                    ,l_tbl (i).bu_id
                    ,l_tbl (i).budget_value_o
                    ,l_tbl (i).budget_value_c
                    ,l_tbl (i).budget_value_p
                    ,l_tbl (i).contract_value
                    ,l_tbl (i).pvo_approved
                    ,l_tbl (i).pvo_submitted
                    ,l_tbl (i).vo
                    ,l_tbl (i).land_area
                    ,l_tbl (i).floor_area
                    ,l_tbl (i).saleable_area
                    ,l_tbl (i).build_area
                    ,l_tbl (i).pc_amount
                    ,l_tbl (i).pc_paid
                    ,l_tbl (i).revenue_value);
      END LOOP;

      COMMIT;
   END sync_project_summary;

   FUNCTION project_summary (p_bu_id      IN number
                            ,p_batch_id   IN number
                            ,p_date       IN string
                            ,p_status     IN string)
      RETURN CLOB IS
      l_query_ref   sys_refcursor;
      l_handle      DBMS_XMLGEN.ctxhandle;
      l_data_xml    CLOB;
      l_date date
            := TO_DATE (TO_CHAR (TO_DATE (p_date
                                         ,'dd-MM-yyyy')
                                ,'DD-MM-RR')
                       ,'DD-MM-RR') ;
      l_fc_cm       number;
   BEGIN
      OPEN l_query_ref FOR
         SELECT   xps.project_num
                 ,xps.project_name
                 ,xps.project_status
                 ,xps.budget_value_o
                 ,xps.budget_value_c
                 ,xps.budget_value_p
                 ,xps.contract_value
                 , (NVL (xps.pvo_approved, 0) + NVL (xps.pvo_submitted, 0)) pvo_value
                 ,xps.vo vo_value
                 , (NVL (xps.contract_value, 0)
                    + NVL (xps.pvo_approved, 0)
                    + NVL (xps.pvo_submitted, 0)
                    + NVL (xps.vo, 0))
                     forecast_value
                 , (NVL (xps.contract_value, 0) + NVL (xps.vo, 0)) commitment_value
                 ,xps.floor_area
                 ,xps.saleable_area
                 ,xps.build_area
                 ,xps.pc_paid
                 ,xps.land_area
                 , (CASE WHEN NVL (xps.land_area, 0) <> 0 THEN (xps.floor_area / xps.land_area) ELSE NULL END) far
                 ,NVL (xcd.pc_amount, 0) + NVL (xps.pc_amount, 0) pc_value_gross
                 ,xcd.pc_amount_net pc_value_net
                 ,sale_value
                 ,xps.revenue_value
           FROM   xxrep_project_summary xps
                 , (  SELECT   xcch.project_id
                              ,SUM (xch.cur_certification) pc_amount
                              ,SUM (xch.cur_pay_amount) pc_amount_net
                        FROM   xxsc_certification_headers xch
                              ,xxsc_contract_headers xcch
                       WHERE   xch.cont_header_id = xcch.cont_header_id
                           AND xch.payment_type IN ('Final', 'Interim')
                           AND xcch.version_type = 'C'
                    GROUP BY   xcch.project_id) xcd
                 , (  SELECT   xpm.project_id
                              ,SUM (NVL (xbd.booking_amount, 0) + NVL (xbm.installment_amount, 0)) sale_value
                        FROM   xxpm_booking_header xbh
                              ,xxpm_booking_detail xbd
                              ,xxpm_property_master xpm
                              ,xxpm_booking_milestones xbm
                       WHERE   xbh.booking_hdr_id = xbd.booking_hdr_id
                           AND xbh.property_id = xpm.property_id
                           AND xbh.booking_hdr_id = xbm.source_func_ref_id(+)
                           AND xbm.milestone_type(+) IN ('Charge', 'Fix')
                           AND NVL (xbm.wave_off, 'N') = 'N'
                    GROUP BY   xpm.project_id) xsd
          WHERE   xps.project_id = xcd.project_id(+)
              AND xps.project_id = xsd.project_id(+)
              AND xps.batch_id = p_batch_id
              AND xps.project_status = p_status;


      l_handle := DBMS_XMLGEN.newcontext (l_query_ref);

      DBMS_XMLGEN.setrowsettag (l_handle
                               ,'PROJECT_SUMMARY');
      DBMS_XMLGEN.setrowtag (l_handle
                            ,'PROJECT_SUMMARY_HEAD');
      DBMS_XMLGEN.setnullhandling (l_handle
                                  ,DBMS_XMLGEN.empty_tag);
      l_data_xml := DBMS_XMLGEN.getxml (l_handle);
      RETURN (l_data_xml);
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN (NULL);
   END project_summary;
END xxrep_report_pkg;
