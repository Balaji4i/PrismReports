--------------------------------------------------------
--  DDL for View XXREP_PROJECT_BUDGET_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXREP_PROJECT_BUDGET_V" (
    "PROJECT_ID",
    "TASK_ID",
    "TASK_NUMBER",
    "TASK_NAME",
    "DISPLAY_SEQUENCE",
    "TOP_TASK_ID",
    "WBS_LEVEL",
    "PARENT_TASK_ID",
    "BUDGET_VALUE_O",
    "BUDGET_VALUE_C",
    "BUDGET_VALUE_P",
    "CONTRACT_VALUE",
    "VO_APPROVED",
    "PVO_APPROVED",
    "PVO_SUBMITTED",
    "VO_APPROVED_LM",
    "PVO_APPROVED_LM",
    "PVO_SUBMITTED_LM",
    "FORECAST_LM",
    "PC_AMOUNT",
    "PC_AMOUNT_NET",
    "PC_AMOUNT_PAID",
    "SUPPLIER_NAME"
) AS
    SELECT
        xt.project_id          project_id,
        xt.task_id             task_id,
        xt.task_number         task_number,
        xt.task_name           task_name,
        xt.display_sequence    display_sequence,
        xt.top_task_id         top_task_id,
        xt.wbs_level           wbs_level,
        xt.parent_task_id      parent_task_id,
        xpb.budget_value_o     budget_value_o,
        xpb.budget_value_c     budget_value_c,
        xpb.budget_value_p     budget_value_p,
        nvl(xt.contract_amount, 0) + nvl(xpb.contract_value_o, 0) contract_value,
        xpb.vo                 vo_approved,
        xpb.pvo_approved       pvo_approved,
        xpb.pvo_submitted      pvo_submitted,
        xpb.vo_lm              vo_approved_lm,
        xpb.pvo_approved_lm    pvo_approved_lm,
        xpb.pvo_submitted_lm   pvo_submitted_lm,
        nvl(xt.contract_amount, 0) + nvl(xpb.contract_value_o, 0) + nvl(xpb.vo_lm, 0) + nvl(xpb.pvo_approved_lm, 0) + nvl(xpb.pvo_submitted_lm
        , 0) forecast_lm,
        nvl(xt.pc_amount, 0) + nvl(xpc.pc_amount, 0) pc_amount,
        pc_amount_net          pc_amount_net,
        nvl(xt.pc_amount_paid, 0) + nvl(xpb.pc_paid, 0) pc_amount_paid,
        nvl(xt.sub_contractor, xpb.vendor_name) supplier_name
    FROM
        xxrep_task             xt,
        xxrep_project_budget   xpb,
        (
            SELECT
                xccl.project_id,
                xccl.task_id,
                SUM(xcl.curr_amount) pc_amount,
                NULL pc_amount_net
            FROM
                xxsc_certification_headers   xch,
                xxsc_certification_lines     xcl,
                xxsc_contract_lines          xccl
            WHERE
                xch.cert_header_id = xcl.cert_header_id
                AND xcl.contract_header_id = xccl.cont_header_id
                AND xcl.cont_line_id = xccl.cont_line_id
                AND xch.payment_type IN (
                    'Final',
                    'Interim'
                )
                AND xccl.version_type = 'C'
           --AND xch.certification_date<=
            GROUP BY
                xccl.project_id,
                xccl.task_id
        ) xpc
    WHERE
        xt.project_id = xpb.project_id (+)
        AND xt.task_id = xpb.task_id (+)
        AND xt.project_id = xpc.project_id (+)
        AND xt.task_id = xpc.task_id (+)