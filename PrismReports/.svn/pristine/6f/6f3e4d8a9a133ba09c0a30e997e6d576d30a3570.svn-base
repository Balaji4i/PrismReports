
  CREATE OR REPLACE  VIEW "XXPM_BOOKING_HDR_SEARCH_V" ("ROW_ID", "BOOKING_NUMBER", "OFFER_NUMBER", "SEARCH_OFFER_NUMBER", "ORG_ID", "PROPERTY_ID", "BOOKING_HDR_ID", "FUNC_ID", "OFFER_HDR_ID", "BLOCK_ID", "BLOCK_NUMBER", "CUST_ID", "BOOKING_DATE", "BOOKING_END_DATE", "BOOKING_FROM_DATE", "BOOKING_TO_DATE", "SPA_PCT", "AREA_VARIATION_PCT", "USAGE", "USAGEDESC", "BOOKING_EXE_BY", "EMPLOYEE_NAME", "REVISION_NO", "REVISION_DATE", "REVISED_BY", "MS_HDR_ID", "MILESTONE_NAME", "PL_ID", "PL_NAME", "BOOKING_TYPE", "BOOKING_TYPE_DESC", "BOOKING_STAGE", "BOOKING_STAGE_DESC", "LEAD_ID", "SALESMAN_ID", "CURRENCY_CODE", "CURRENCY_DESC", "CHECKLIST", "CHECKLIST_DESC", "TERMS_DESC", "OBJECT_VERSION_NUMBER", "BOOKING_FLAG", "TAX_CODE", "PREV_BOOKING_ID", "LEAD_SOURCE_CHANNEL", "LEAD_SOURCE_NAME", "VEND_ID", "VEND_SITE_ID", "VEND_CONTRACT_NO", "STATUS", "STATUS_DESC", "DESCRIPTION", "FLOW_STATUS", "FLOW_LEVEL", "FLOW_WITH", "USER_GRP_ID", "ATTRIBUTE_CATEGORY", "ATTRIBUTE1", "ATTRIBUTE2", "ATTRIBUTE3", "ATTRIBUTE4", "ATTRIBUTE5", "ATTRIBUTE6", "ATTRIBUTE7", "ATTRIBUTE8", "ATTRIBUTE9", "ATTRIBUTE10", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN", "INVOICED_AMOUNT", "RECEIPT_AMOUNT", "UNITNAME_TRANS", "CUSTNAME_TRANS", "UNIT_DUMMY", "CUST_DUMMY", "PRIMARY_CUSTOMER", "APPLIED_RECEIPT_AMOUNT", "ACTIVE_YN", "AGENCY_NAME", "AGENT_NAME", "AGENT_COMMISSION_PERC", "AGENT_COMMISSION", "NATIONALITY", "EMIRATES_ID") AS 
  WITH booking_invoiced_amount
     AS (  SELECT ih.booking_id
                 ,SUM (  NVL (il.amount, 0)
                       + NVL (il.tax_amount, 0))
                     invoiced_amount
             FROM xxpm_invoice_header ih, xxpm_invoice_lines il, xxpm_booking_milestones ms
            WHERE     il.invoice_id = ih.invoice_id
                  AND ih.invoice_id =   ih.invoice_id
                                      + 0
                  AND il.invoice_id =   il.invoice_id
                                      + 0
				  and il.invoice_id=ms.INVOICE_ID
                  and ms.INSTALLMENT_AMOUNT !=0

            --Dinesh credit memo amt should not add
            AND nvl(ih.trx_type,'XXX') NOT IN ('Sale Swapping','Customer Adjustment')
         GROUP BY ih.booking_id)
    ,booking_receipt_amount
     AS (  SELECT inv_hdr.booking_id
                 ,SUM (rd.amount_applied) AS receipt_amount
                 ,SUM (
                     DECODE (r.interface_status
                            ,'READY_TO_APPLY', rd.amount_applied
                            ,0))
                     applied_receipt_amount
             FROM xxpm_invoice_header inv_hdr
                 ,xxpm_receipt_details rd
                 ,xxpm_receipt r
            WHERE     inv_hdr.invoice_id = rd.invoice_id
                  AND inv_hdr.invoice_id =   inv_hdr.invoice_id
                                           + 0
                  AND r.receipt_id = rd.receipt_id
                  AND r.receipt_id =   r.receipt_id
                                     + 0
         GROUP BY inv_hdr.booking_id)
    ,booking_unit
     AS (  SELECT xbd.booking_hdr_id
                 ,LISTAGG ( (SELECT xpm.unit_number
                               FROM xxpm_property_units xpm
                              WHERE xpm.unit_id = xbd.unit_id)
                          ,',')
                  WITHIN GROUP (ORDER BY xbd.booking_hdr_id)
                     AS unitname_trans
             FROM xxpm_booking_detail xbd
            WHERE xbd.booking_hdr_id =   xbd.booking_hdr_id
                                       + 0
         GROUP BY xbd.booking_hdr_id)
    ,booking_customer
     AS (  SELECT xbc.booking_hdr_id
                 ,LISTAGG ( (SELECT xst.customer_name
                               FROM xxstg_customer xst
                              WHERE xst.cust_id = xbc.cust_id)
                          ,',')
                  WITHIN GROUP (ORDER BY xbc.booking_hdr_id)
                     AS custname_trans
             FROM xxpm_booking_customer xbc
            WHERE xbc.booking_hdr_id =   xbc.booking_hdr_id
                                       + 0
         GROUP BY xbc.booking_hdr_id)
SELECT xbh.row_id
      ,xbh.booking_number
      ,xbh.offer_number
      ,xbh.offer_number AS search_offer_number
      ,xbh.org_id
      ,xbh.property_id
      ,xbh.booking_hdr_id
      ,xbh.func_id
      ,xbh.offer_hdr_id
      ,xbh.block_id
      ,xbh.block_number
      ,xbh.cust_id
      ,xbh.booking_date
      ,xbh.booking_end_date
      ,xbh.booking_from_date
      ,xbh.booking_to_date
      ,xbh.spa_pct
      ,xbh.area_variation_pct
      ,xbh.usage
      ,xbh.usagedesc
      ,xbh.booking_exe_by
      ,xbh.employee_name
      ,xbh.revision_no
      ,xbh.revision_date
      ,xbh.revised_by
      ,xbh.ms_hdr_id
      ,xbh.milestone_name
      ,xbh.pl_id
      ,xbh.pl_name
      ,xbh.booking_type
      ,xbh.booking_type_desc
      ,xbh.booking_stage
      ,xbh.booking_stage_desc
      ,xbh.lead_id
      ,xbh.salesman_id
      ,xbh.currency_code
      ,xbh.currency_desc
      ,xbh.checklist
      ,xbh.checklist_desc
      ,xbh.terms_desc
      ,xbh.object_version_number
      ,xbh.booking_flag
      ,xbh.tax_code
      ,xbh.prev_booking_id
      ,xbh.lead_source_channel
      ,xbh.lead_source_name
      ,xbh.vend_id
      ,xbh.vend_site_id
      ,xbh.vend_contract_no
      ,xbh.status
      ,xbh.status_desc
      ,xbh.description
      ,xbh.flow_status
      ,xbh.flow_level
      ,xbh.flow_with
      ,xbh.user_grp_id
      ,xbh.attribute_category
      ,xbh.attribute1
      ,xbh.attribute2
      ,xbh.attribute3
      ,xbh.attribute4
      ,xbh.attribute5
      ,xbh.attribute6
      ,xbh.attribute7
      ,xbh.attribute8
      ,xbh.attribute9
      ,xbh.attribute10
      ,xbh.created_by
      ,xbh.creation_date
      ,xbh.last_updated_by
      ,xbh.last_update_date
      ,xbh.last_update_login
      ,bia.invoiced_amount
      ,bra.receipt_amount
      ,bu.unitname_trans
      ,bc.custname_trans
      , (SELECT unit_number
           FROM xxpm_property_units xpm
          WHERE     ROWNUM = 1
                AND unit_id =   unit_id
                              + 0)
          AS unit_dummy
      , (SELECT customer_name
           FROM xxstg_customer xst
          WHERE     ROWNUM = 1
                AND cust_id =   cust_id
                              + 0)
          AS cust_dummy
      , (SELECT scus.customer_name
           FROM xxpm_booking_customer bcus, xxstg_customer scus
          WHERE     bcus.booking_hdr_id = xbh.booking_hdr_id
                AND bcus.cust_id = scus.cust_id
                AND bcus.primary_yn = 'Y'
                AND ROWNUM = 1)
          AS primary_customer
      ,bra.applied_receipt_amount
      ,xbh.active_yn
      ,xbh.agency_name
      ,xbh.agent_name
      ,xbh.agent_commission_perc
      ,xbh.agent_commission
      ,xbh.nationality
      ,xbh.emirates_id
  FROM xxpm_booking_header_v xbh
      ,booking_invoiced_amount bia
      ,booking_receipt_amount bra
      ,booking_unit bu
      ,booking_customer bc
 WHERE     xbh.booking_hdr_id = bia.booking_id(+)
       AND xbh.booking_hdr_id = bra.booking_id(+)
       AND xbh.booking_hdr_id = bu.booking_hdr_id(+)
       AND xbh.booking_hdr_id = bc.booking_hdr_id(+);
