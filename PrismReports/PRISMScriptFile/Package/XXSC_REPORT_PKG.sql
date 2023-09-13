--------------------------------------------------------
--  DDL for Package Body XXSC_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXSC_REPORT_PKG" IS
   FUNCTION contract_work_order (p_contact_num IN varchar2)
      RETURN CLOB IS
      l_data_xml   CLOB;
   BEGIN
      l_data_xml := DBMS_XMLGEN.getxml ('SELECT XCH.CONT_HEADER_ID,  
                                              XCH.ORG_ID,  
                                              XCH.BUSINESS_UNIT,  
                                              XCH.PAYMENT_TERM,  
                                              XCH.REMARKS,  
                                              XCH.VENDOR_NAME ,  
                                              XCH.PROJECT_NUMBER,  
                                              XCH.PROJECT_NAME,  
                                              XCH.CONTRACT_NUM,  
                                              XCH.CONTRACT_NAME,  
                                              XCH.CONTRACT_DATE,  
                                              XCH.PO_NUMBER,  
                                              XCH.CURRENCY_CODE,  
                                              xvc.PARTY_NAME,  
                                              xvc.EMAIL_ADDRESS ,  
                                              XVC.PHONE_NUMBER,  
                                              XVC.MOBILE_NUMBER,  
                                              CURSOR  (SELECT XCL.CONT_HEADER_ID,    
                                                              XCL.CONT_LINE_ID,    
                                                              XCL.CONT_LINE_NUMBER,    
                                                              XCL.VERSION,    
                                                              XCL.ITEM_NUMBER,    
                                                              XCL.ITEM_DESCRIPTION,    
                                                              XXSC_CONTRACT_PKG.GET_UOM (XCL.UOM) UOM,    
                                                              XCL.ORIG_QUANTITY,    
                                                              XCL.ORIG_UNIT_PRICE,    
                                                              XCL.ORIG_AMOUNT  
                                                        FROM XXSC_CONTRACT_LINES XCL  
                                                        WHERE 1                = 1  
                                                        AND xcL.cont_header_id = xcH.cont_header_id  
                                                        AND XCL.VERSION        = XCH.VERSION  
                                                        AND XCL.VERSION_TYPE   = ''C''  
                                                      ) qoute_line
                                              FROM  xxsc_contract_headers_v xch,  
                                                    XXSTG_VENDOR_CONTACTS xvc
                                              WHERE 1                   = 1
                                              AND XCH.VENDOR_CONTACT_ID = XVC.VENDOR_CONTACT_ID(+)
                                              AND XCH.VENDOR_ID         = xvc.VENDOR_ID(+)
                                              AND XCH.VENDOR_SITE_ID    = xvc.VENDOR_SITE_ID(+)
                                              AND XCH.VERSION_TYPE      = ''C''
                                              AND XCH.CONTRACT_NUM      = NVL(' || '''' || p_contact_num || '''' || ',XCH.CONTRACT_NUM)');
      RETURN (l_data_xml);
   EXCEPTION
      WHEN OTHERS THEN
         RETURN (NULL);
   END contract_work_order;

   FUNCTION payment_certificate (p_cert_header_id IN number)
      RETURN CLOB IS
      l_query_ref   sys_refcursor;
      l_handle      DBMS_XMLGEN.ctxhandle;
      l_data_xml    CLOB;
   BEGIN
      OPEN l_query_ref FOR
         SELECT   xch.cert_header_id
                 ,xch.vendor_name
                 ,xch.ven_bill_to_location
                 ,xch.phone_number ven_phone_number
                 ,xch.email_address ven_email_address
                 ,xch.addressline1 addressline1
                 ,xch.addressline2 addressline2
                 ,xch.city city
                 ,xch.vendor_trn vendor_trn
                 ,xch.project_name
                 ,xch.project_number
                 ,xch.payment_type
                 ,TRUNC (xch.creation_date) creation_date
                 ,xch.contract_name
                 ,xch.invoice_num
                 ,xch.invoice_date
                 ,xch.contract_num
                 ,xch.certification_number
                 ,xch.certification_date
                 ,xch.payment_term
                 ,xch.CUR_OTH_CHARGE
                 ,xch.PREV_OTH_CHARGE
                 ,xch.TOT_OTH_CHARGE
                 ,xch.PENALTY_CHARGES
             
                 ,ROUND (NVL (xsh.reten_percent, 0)
                        ,2)
                     ret_per
                 ,ROUND (NVL (xsh.adv_recovery_percent, 0)
                        ,2)
                     adv_rec_per
                 ,NVL (xch.cur_certification, 0) cur_certification
                 ,NVL (xch.total_contract_sum, 0) total_contract_sum
                 , (NVL (xch.prev_application, 0) + NVL (xsl.cert_amount, 0)) prev_application
                 , (NVL (xch.prev_ret, 0) + NVL (xsl.ret_amount, 0)) prev_ret
                 ,NVL (xch.cur_ret, 0) cur_ret
                 , (NVL (xch.prev_adv_rec, 0) + NVL (xsl.adv_rec_amount, 0)) prev_adv_rec
                 ,NVL (xch.cur_adv_rec, 0) cur_adv_rec
                 ,NVL(xch.PREV_MAT_ADV_AMT,0) PRE_MOS_REC
                 ,NVL(xch.CUR_MAT_ADV_REC,0) CUR_MOS_REC
                 ,(NVL(xch.PREV_MAT_ADV_AMT,0) + NVL(xch.CUR_MAT_ADV_REC,0)) CUM__MOS_REC
                 ,NVL(xch.CONTRA_CHARGES,0) CUR_CONTRA_CHARGE
                 , (NVL (xch.prev_application, 0) + NVL (xsl.cert_amount, 0) + NVL (xch.cur_certification, 0)) prev_cur
                 , (NVL (xch.prev_application, 0) + NVL (xsl.cert_amount, 0) ) tot_prev_pay
                 ,NVL (xch.cur_certification, 0) tot_cur_cert
                 , (NVL (xch.prev_application, 0) + NVL (xsl.cert_amount, 0) + NVL (xch.cur_certification, 0)) tot_prev_cur
                 , (NVL (xch.prev_ret, 0) + NVL (xsl.ret_amount, 0) + NVL (xch.cur_ret, 0)) prev_cur_ret
                 , (NVL (xch.prev_adv_rec, 0) + NVL (xsl.adv_rec_amount, 0) + NVL (xch.cur_adv_rec, 0)) prev_cur_adv_rec
                 , (NVL (xch.prev_ret, 0) + NVL (xsl.ret_amount, 0) + NVL (xch.prev_adv_rec, 0) + NVL (xsl.adv_rec_amount, 0) + NVL(xch.PREV_MAT_ADV_AMT,0)+ NVL(xch.PREV_OTH_CHARGE,0)+
                   nvl((SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
AND PAYMENT_TYPE='Interim'
and CERT_HEADER_ID < NVL (p_cert_header_id, xch.cert_header_id)),0)) tot_prev
                 , (NVL (xch.cur_ret, 0) + NVL (xch.cur_adv_rec, 0) + NVL(xch.CUR_MAT_ADV_REC,0) + NVL(xch.CONTRA_CHARGES,0) + NVL (CUR_OTH_CHARGE,0)+
                     (SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
AND PAYMENT_TYPE='Interim'
and CERT_HEADER_ID = NVL (p_cert_header_id, xch.cert_header_id))) tot_cur
                 , (NVL (xch.prev_ret, 0)
                    + NVL (xsl.ret_amount, 0)
                    + NVL (xch.cur_ret, 0)
                    + NVL (xch.prev_adv_rec, 0)
                    + NVL (xsl.adv_rec_amount, 0)
                    + NVL (xch.cur_adv_rec, 0) 
                    + (NVL(xch.PREV_MAT_ADV_AMT,0) + NVL(xch.CUR_MAT_ADV_REC,0))+ NVL(xch.TOT_OTH_CHARGE,0)
                    +
                       nvl((SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
and PAYMENT_TYPE='Interim'
and CERT_HEADER_ID <= p_cert_header_id),0))
                     tot_cum_ded
                 , (NVL (xch.prev_application, 0)
                    + NVL (xsl.cert_amount, 0)
                    - NVL (xch.prev_ret, 0)
                    - NVL (xsl.ret_amount, 0)
                    - NVL (xch.prev_adv_rec, 0)
                    - NVL (xsl.adv_rec_amount, 0)
					- NVL(xch.PREV_MAT_ADV_AMT,0)
          +
         nvl(  (SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
AND PAYMENT_TYPE='Interim'
and CERT_HEADER_ID < NVL (p_cert_header_id, xch.cert_header_id),0))
         )
           tot_pay_ded_prev
                 , (NVL (xch.cur_certification, 0) - NVL (xch.cur_ret, 0) - NVL (xch.cur_adv_rec, 0)- NVL(xch.CUR_MAT_ADV_REC,0) - NVL(xch.CONTRA_CHARGES,0)
               +
               (SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
AND PAYMENT_TYPE='Interim'
and CERT_HEADER_ID = NVL (p_cert_header_id, xch.cert_header_id))) tot_pay_ded_cur
                 , (NVL (xch.prev_application, 0)
                    + NVL (xsl.cert_amount, 0)
                    + NVL (xch.cur_certification, 0)
                    - NVL (xch.prev_ret, 0)
                    - NVL (xsl.ret_amount, 0)
                    - NVL (xch.cur_ret, 0)
                    - NVL (xch.prev_adv_rec, 0)
                    - NVL (xsl.adv_rec_amount, 0)
                    - NVL (xch.cur_adv_rec, 0)
					- (NVL(xch.PREV_MAT_ADV_AMT,0) + NVL(xch.CUR_MAT_ADV_REC,0)))
                     tot_pay_ded_cum
                 ,NULL vat_code
                 ,xch.tax_rate vat_per
                 , ( (NVL (xch.cur_certification, 0) - NVL (xch.cur_ret, 0) - NVL (xch.cur_adv_rec, 0)- NVL(xch.CUR_MAT_ADV_REC,0) - NVL(xch.CONTRA_CHARGES,0)) * xch.tax_rate / 100) vat_amount
                 , ( (NVL (xch.cur_certification, 0) - NVL (xch.cur_ret, 0) - NVL (xch.cur_adv_rec, 0)- NVL(xch.CUR_MAT_ADV_REC,0) - NVL(xch.CONTRA_CHARGES,0))
                    + ( (NVL (xch.cur_certification, 0) - NVL (xch.cur_ret, 0) - NVL (xch.cur_adv_rec, 0)- NVL(xch.CUR_MAT_ADV_REC,0) - NVL(xch.CONTRA_CHARGES,0)) * xch.tax_rate / 100))
                     total_amount
                 ,xxsc_utility_pkg.amount_in_words (
                     ( (NVL (xch.cur_certification, 0) - NVL (xch.cur_ret, 0) - NVL (xch.cur_adv_rec, 0)- NVL(xch.CUR_MAT_ADV_REC,0) - NVL(xch.CONTRA_CHARGES,0))
                      + ( (NVL (xch.cur_certification, 0) - NVL (xch.cur_ret, 0) - NVL (xch.cur_adv_rec, 0)- NVL(xch.CUR_MAT_ADV_REC,0) - NVL(xch.CONTRA_CHARGES,0)) * xch.tax_rate / 100))
                    ,'AED'
                  )
                     tot_pay_ded_cur_w,
                    nvl( (SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
and PAYMENT_TYPE='Interim'
and CERT_HEADER_ID <= p_cert_header_id),0) CUMM_PENALTY_CHARGES,

                     nvl(   (SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
AND PAYMENT_TYPE='Interim'
and CERT_HEADER_ID < NVL (p_cert_header_id, xch.cert_header_id),0)) PREV_PENALTY_CHARGES,     

                      nvl(  (SELECT sum(PENALTY_CHARGES) 
FROM XXSC_CERTIFICATION_HEADERS
where 
CONT_HEADER_ID=XSH.CONT_HEADER_ID 
AND PAYMENT_TYPE='Interim'
and CERT_HEADER_ID = NVL (p_cert_header_id, xch.cert_header_id),0)) CURR_PENALTY_CHARGES   
                 ,cursor (SELECT   xpc.category_name category_name
                                  ,xpc.description category_desc
                                  ,xcol.task_number task_number
                                  ,xpt.name task_name
                                  ,xcol.item_number item_number
                                  ,xcol.item_description item_desc
                                  ,xu.unit_of_measure uom
                                  ,nvl(xcol.orig_quantity,0) quantity
                                  ,nvl(xcol.orig_unit_price,0) unit_price
                                  ,nvl(xcol.orig_amount,0) amount
                                  ,xcl.cert_line_id cert_line_id
                                  ,nvl(xcl.curr_perc,0) curr_perc
                                  ,nvl(xcl.curr_tot_qty,0) curr_qty
                                  ,nvl(xcl.curr_amount,0) curr_amount
                                  ,nvl(xcl.prev_perc,0) prev_perc
                                  ,nvl(xcl.prev_tot_qty,0) prev_tot_qty
                                  ,nvl(xcl.prev_amount,0) prev_amount
                                  ,nvl(xcl.cum_perc,0) cum_perc
                                  ,nvl(xcl.cum_tot_qty,0) cum_qty
                                  ,nvl(xcl.cum_amount,0) cum_amount
                            FROM   xxsc_certification_lines xcl
                                  ,xxsc_contract_lines xcol
                                  ,xxstg_po_category xpc
                                  ,xxstg_project_tasks xpt
                                  ,xxstg_uom xu
                           WHERE   xcl.cont_line_id = xcol.cont_line_id
                               AND xcol.category_id = xpc.category_id(+)
                               AND xcol.task_id = xpt.proj_element_id(+)
                               AND xcol.uom = xu.uom_code(+)
                               AND xcl.cert_header_id = xch.cert_header_id)
                     pc_line
           FROM   xxsc_certification_headers_v xch
                 ,xxsc_contract_headers xsh
                 , (  SELECT   xcl.cont_header_id
                              ,xoc.po_header_id
                              ,SUM (xoc.cert_amount) cert_amount
                              ,SUM (xoc.ret_amount) ret_amount
                              ,SUM (xoc.adv_rec_amount) adv_rec_amount
                              ,SUM (xoc.mat_adv_rec_amount) mat_adv_rec_amount
                              ,SUM (xoc.contra_charges) contra_charges
                        FROM   xxstg_old_certificate xoc
                              , (  SELECT   cont_header_id
                                           ,po_header_id
                                           ,po_line_id
                                     FROM   xxsc_contract_lines
                                 GROUP BY   cont_header_id
                                           ,po_header_id
                                           ,po_line_id) xcl
                       WHERE   xoc.po_line_id = xcl.po_line_id
                           AND xoc.po_header_id = xcl.po_header_id
                    GROUP BY   xcl.cont_header_id
                              ,xoc.po_header_id) xsl
          WHERE   1 = 1
              AND xch.cont_header_id = xsh.cont_header_id(+)
              AND xsh.cont_header_id = xsl.cont_header_id(+)
              AND xsh.po_header_id = xsl.po_header_id(+)
              AND xch.cert_header_id = NVL (p_cert_header_id, xch.cert_header_id);


      l_handle := DBMS_XMLGEN.newcontext (l_query_ref);

      DBMS_XMLGEN.setrowsettag (l_handle
                               ,'PC');
      DBMS_XMLGEN.setrowtag (l_handle
                            ,'PC_HEAD');
      DBMS_XMLGEN.setnullhandling (l_handle
                                  ,DBMS_XMLGEN.empty_tag);
      l_data_xml := DBMS_XMLGEN.getxml (l_handle);
      RETURN (l_data_xml);
   EXCEPTION
      WHEN OTHERS THEN
         RETURN (NULL);
   END payment_certificate;

   FUNCTION contract_summary (p_cont_header_id IN number)
      RETURN CLOB IS
      l_query_ref   sys_refcursor;
      l_handle      DBMS_XMLGEN.ctxhandle;
      l_data_xml    CLOB;
   BEGIN
      OPEN l_query_ref FOR
         SELECT   xch.cont_header_id cont_header_id
                 ,xch.contract_num cont_num
                 ,xch.contract_name cont_name
                 ,xch.contract_date cont_date
                 ,xch.start_date cont_start_date
                 ,xch.end_date cont_end_date
                 ,xxsc_contract_pkg.get_lookup_meaning ('CONTRACT_TYPE'
                                                       ,xch.contract_type)
                     cont_type
                 ,xch.contract_amount cont_amount
                 ,xch.variation_amount cont_var_amount
                 ,xch.revised_contract_amount cont_rev_amount
                 ,xch.adv_percent cont_adv_percent
                 ,xch.adv_amount cont_adv_amount
                 ,xch.reten_percent cont_reten_percent
                 ,xch.reten_amount cont_reten_amount
                 ,xch.mat_onsite_percent cont_mat_onsite_percent
                 ,xch.material_on_site cont_material_on_site
                 ,xch.penalty_percent cont_penalty_percent
                 ,xch.penalty_amount cont_penalty_amount
                 ,xch.provisional_sum cont_prov_amount
                 ,xch.total_contract_sum cont_net_amount
                 ,xxsc_contract_pkg.get_lookup_meaning ('CONTR_STATUS'
                                                       ,xch.contract_status)
                     cont_status
                 ,xxsc_contract_pkg.get_lookup_meaning ('APPR_STATUS'
                                                       ,xch.approval_status)
                     cont_approval_status
                 ,xv.segment1 supplier_num
                 ,xv.vendor_name supplier_name
                 ,xvs.vendor_site_code supplier_site
                 ,xp.segment1 project_num
                 ,xp.name project_name
                 ,xbu.bu_name bu_name
                 ,cursor (SELECT   xph.appl_header_id appl_header_id
                                  ,xph.cont_header_id cont_header_id
                                  ,xph.application_number application_number
                                  ,xph.application_date application_date
                                  ,xxsc_contract_pkg.get_lookup_meaning ('PAYMENT_TYPE'
                                                                        ,xph.payment_type)
                                      appl_payment_type
                                  ,xxsc_contract_pkg.get_lookup_meaning ('CONTR_STATUS'
                                                                        ,xph.application_status)
                                      application_status
                                  ,xxsc_contract_pkg.get_lookup_meaning ('APPR_STATUS'
                                                                        ,xph.approval_status)
                                      appl_approval_status
                                  ,xph.cur_application appl_cur_amount
                                  ,xph.cur_adv_rec appl_cur_adv_rec
                                  ,xph.cur_ret appl_cur_ret
                                  ,xph.cur_mat_adv_rec appl_cur_mat_adv_rec
                                  ,xph.cur_pay_amount appl_cur_pay_amount
                                  ,xceh.certification_number certification_number
                                  ,xceh.certification_date certification_date
                                  ,xxsc_contract_pkg.get_lookup_meaning ('PAYMENT_TYPE'
                                                                        ,xceh.payment_type)
                                      cert_payment_type
                                  ,xxsc_contract_pkg.get_lookup_meaning ('CONTR_STATUS'
                                                                        ,xceh.certification_status)
                                      certification_status
                                  ,xxsc_contract_pkg.get_lookup_meaning ('APPR_STATUS'
                                                                        ,xceh.approval_status)
                                      cert_approval_status
                                  ,xceh.cur_certification cert_cur_amount
                                  ,xceh.cur_adv_rec cert_cur_adv_rec
                                  ,xceh.cur_ret cert_cur_ret
                                  ,xceh.cur_mat_adv_rec cert_cur_mat_adv_rec
                                  ,xceh.cur_pay_amount cert_cur_pay_amount
                                  ,xceh.invoice_num supp_invoice_num
                                  ,xceh.invoice_date supp_invoice_date
                                  ,xceh.inv_status supp_inv_status
                            FROM   xxsc_pay_appl_headers xph
                                  ,xxsc_certification_headers xceh
                           WHERE   xph.appl_header_id = xceh.appl_header_id(+)
                               AND xph.cont_header_id = xch.cont_header_id)
                     cont_appl
           FROM   xxsc_contract_headers xch
                 ,xxstg_vendors xv
                 ,xxstg_vendor_sites xvs
                 ,xxstg_projects xp
                 ,xxstg_business_units xbu
          WHERE   xch.vendor_id = xv.vendor_id(+)
              AND xch.vendor_site_id = xvs.vendor_site_id(+)
              AND xch.project_id = xp.project_id(+)
              AND xch.org_id = xbu.bu_id(+)
              AND xch.cont_header_id = p_cont_header_id;

      l_handle := DBMS_XMLGEN.newcontext (l_query_ref);

      DBMS_XMLGEN.setrowsettag (l_handle
                               ,'CONT_APPL_PC');
      DBMS_XMLGEN.setrowtag (l_handle
                            ,'CONT_HEAD');
      DBMS_XMLGEN.setnullhandling (l_handle
                                  ,DBMS_XMLGEN.empty_tag);
      l_data_xml := DBMS_XMLGEN.getxml (l_handle);
      RETURN (l_data_xml);
   EXCEPTION
      WHEN OTHERS THEN
         RETURN (NULL);
   END contract_summary;
END xxsc_report_pkg;
