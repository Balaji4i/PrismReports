--------------------------------------------------------
--  DDL for Package XXPM_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_REPORT_PKG" 
IS 
  FUNCTION Xxpm_offer_form( 
    p_offer_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_booking_form( 
    p_booking_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_tc_sharjah_form( 
    p_lease_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_provisional_bk_receipt( 
    p_booking_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_provisional_rec_receipt( 
    p_recommend_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_bookingreceipt_form( 
    p_receipt_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_recommendreceipt_form( 
    p_receipt_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_tc_dubai_form( 
    p_lease_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_reservation_form( 
    p_recommend_num IN VARCHAR2) 
  RETURN CLOB; 
  FUNCTION Xxpm_tax_invoice( 
    p_lease_num IN VARCHAR2)
    RETURN CLOB; 
    END xxpm_report_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_REPORT_PKG" 
IS 
  FUNCTION Xxpm_offer_form(p_offer_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_offer_num); 

      OPEN l_query_ref FOR 
        SELECT XOH1.offer_number, 
               To_char(systimestamp, 'DD-Mon-YY HH24:MI:SS') 
                                    sysdate_with_timestamp, 
               Nvl((SELECT lease_number 
                    FROM   xxpm_lease_agreement XLA 
                    WHERE  XOH1.lease_agreement_id = XLA.lease_agreement_id), 
               '-') 
                                    contracT, 
               To_char(XOH1.offer_date, 'DD/MM/YYYY') 
                                    OFFER_DATE, 
               xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
               XOH1.offer_type) 
                                    OFFER_TYPE, 
               xxpm_utility_pkg.Get_lookup_value_disp('OFFER_ADD_TYPE', 
               XOH1.offer_flag) 
                                    OFFER_flag, 
               XSO.org_name 
                                    BU_NAME, 
               XMH.milestone_name 
                                    PAYMENT_PLAN, 
               XOH1.revision_no, 
               XOH1.created_by, 
               XL.lead_number, 
               XL.lead_name 
                                    TENANT_NAME, 
               XL.phone_number 
                                    PHONE_NUMBER, 
               XL.mobile_number 
                                    MOBILE_NUMBER, 
               XOH1.checklist 
                                    CHECK_LIST_TYPE, 
               XL.email_id, 
               To_char(XOH1.offer_from_date, 'DD/MM/YYYY') 
                                    CONTRACT_START_DATE, 
               To_char(XOH1.offer_to_date, 'DD/MM/YYYY') 
                                    CONTRACT_END_DATE, 
               XOH1.currency 
                                    CURRENCY, 
               (SELECT Count(*) 
                FROM   xxpm_offer_milestone_detail XOMD 
                WHERE  offer_hdr_id = XOH1.offer_hdr_id 
                       AND XOMD.milestone_type = 'BK') 
                                    NO_OF_PAYMENT, 
               CURSOR (SELECT XPM.property_name, 
                              XPB.build_name                     BULIDING_NAME, 
                              -- XOD.unit_id   
                              XPU.unit_name                      PREMISES_NO, 
                              XPU.unit_name, 
                              --XPU.view_type          UNIT_DESC,   
                              --XOD.unit_type,   
                              (SELECT 
                      xxpm_utility_pkg.Get_lookup_value_disp('UNIT_TYPE', 
                      XPU.unit_type) 
                      UNIT_TYPE 
                               FROM   xxpl_property_units XPU 
                               WHERE  XOD.unit_id = XPU.unit_id) UNIT_TYPE, 
                              (SELECT 
                      xxpm_utility_pkg.Get_lookup_value_disp('UNIT_VIEW_TYPE', 
                      XPU.view_type) 
                      UNIT_TYPE 
                               FROM   xxpl_property_units XPU 
                               WHERE  XOD.unit_id = XPU.unit_id) UNIT_DESC, 
                              XPA.value                          AREA_IN_SQ_FT, 
                              XOD.base_rate                      OFFER_AMOUNT, 
                              XPD.discount_type, 
                              XPD.discount_value, 
                              Nvl(XOD.tax_amount, 0)             TAX_AMOUNT, 
                              Nvl(XOD.total_rate, 0)             LINE_TOTAL 
                       FROM   xxpm_offer_detail XOD, 
                              xxpl_property_buildings XPB, 
                              xxpl_property_units XPU, 
                              xxpl_property_master XPM, 
                              xxpm_pl_discounts XPD, 
                              xxpl_property_area XPA 
                       WHERE  XOH1.offer_hdr_id = XOD.offer_hdr_id 
                              AND XOD.building_id = XPB.build_id 
                              AND XOD.unit_id = XPU.unit_id 
                              AND XOD.property_id = XPM.property_id 
                              AND XOD.discount_amount = XPD.discount_id(+) 
                              AND XOD.property_id = XPA.property_id (+) 
                              AND XOD.unit_id = XPA.unit_id (+) 
                              AND XOD.building_id = XPA.build_id (+) 
                      -- AND    XPA.area = 'CHARGE'  
                      ) 
                                    Line, 
               CURSOR (SELECT 
               xxpm_utility_pkg.Get_lookup_value_disp('OTHER_PAYMENT_TYPE', 
                              XOMD.installment_type) CHAR_TYPE, 
               XOMD.installment_amount               INSTALLMENT_AMOUNT_OT 
                       FROM   xxpm_offer_milestone_detail XOMD 
                       WHERE  XOH1.offer_hdr_id = XOMD.offer_hdr_id 
                              AND XOMD.milestone_type = 'OC' 
                              AND XOMD.installment_type != 'SEC_DEP' 
                              --and xoh1.offer_number='OF-OF-1121'   
                              AND Trim(XOH1.offer_number) = 
                                  Nvl(p_offer_num, XOH1.offer_number) 
                       ORDER  BY XOMD.installment_amount DESC) 
                                    OTHER_CHARGES, 
               CURSOR (SELECT Nvl(XOMD.installment_amount, 0) 
                              INSTALLMENT_AMOUNT_AR, 
                              Nvl(XOH1.offer_total, 0)        CONTRACT_VALUE, 
                              ( Nvl(XOMD.installment_amount, 0) 
                                + Nvl(XOH1.offer_total, 0) )  AR_TOTAL 
                       FROM   xxpm_offer_milestone_detail XOMD 
                       WHERE  XOH1.offer_hdr_id = XOMD.offer_hdr_id 
                              AND XOMD.milestone_type = 'OC' 
                              AND XOMD.installment_type = 'SEC_DEP' 
                              --and xoh1.offer_number='OF-OF-1121'   
                              AND Trim(XOH1.offer_number) = 
                                  Nvl(p_offer_num, XOH1.offer_number) 
                       ORDER  BY XOMD.installment_amount DESC) 
                                    AMOUNT_RECEIVABLE, 
               CURSOR (SELECT XFC.cl_item, 
                              XCR.item_response1 
                       FROM   xxfnd_func_checklist XFC, 
                              xxfnd_checklist_response XCR 
                       WHERE  XOH1.func_id = XFC.func_id 
                              AND XOH1.offer_hdr_id = XCR.func_ref_id 
                              AND XFC.func_cl_id = XCR.func_cl_id 
                              AND XOH1.func_id = XCR.func_id) 
                                    CHECK_LIST 
        FROM   xxpm_offer_header XOH1, 
               xxpl_milestones_hdr XMH, 
               xxpm_lead XL, 
               xxstg_organizations XSO 
        WHERE  XOH1.lead_id = XL.lead_id 
               AND XOH1.ms_hdr_id = XMH.ms_hdr_id (+) 
               AND XOH1.org_id = XSO.org_id(+) 
               AND Trim(XOH1.offer_number) = Nvl(p_offer_num, 
        XOH1.offer_number); 

      l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

      dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

      dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

      dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

      l_data_xml := dbms_xmlgen.Getxml (l_handle); 

      RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_offer_form; 
  FUNCTION Xxpm_booking_form(p_booking_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_booking_num); 

      OPEN l_query_ref FOR 
        SELECT XBH.booking_number 
               BOOKING_NO, 
               (SELECT SUM(recommended_amount) 
                FROM   xxpm_receipt 
                WHERE  source_func_ref_id = XBH.booking_id 
                       AND rct_type = 'BK') 
                                    BOOKING_AMOUNT, 
               To_char(systimestamp, 'DD-Mon-YY HH24:MI:SS') 
                                    sysdate_with_timestamp, 
               ( CASE 
                   WHEN Lower(XSO.org_name) LIKE '%sharjah%' THEN 
                   'Leasing Sharjah Business Unit' 
                   WHEN Lower(XSO.org_name) LIKE '%dubai%' THEN 
                   'Leasing Dubai Business Unit' 
                 END ) 
                                    BU_NAME, 
               XBH.created_by, 
               XOH.offer_number 
                                    OFFER_NO, 
               xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
               XOH.offer_type) 
                                    OFFER_TYPE, 
               To_char(XBH.booking_date, 'DD/MM/YYYY') 
                                    BOOKING_DATE, 
               To_char(XBH.booking_due_date, 'DD/MM/YYYY') 
                                    BOOKING_DUE_DATE, 
               To_char(XOH.offer_from_date, 'DD/MM/YYYY') 
                                    CONTRACT_START_DATE, 
               To_char(XOH.offer_to_date, 'DD/MM/YYYY') 
                                    CONTRACT_END_DATE, 
               Nvl(Round(( ( XOH.offer_from_date - XBH.booking_date ) * 
                           ( 
                           (SELECT SUM(total_rate) 
                            FROM 
                               xxpm_booking_detail 
                                                                           WHERE 
                                       booking_id = XBH.booking_id 
                                       AND unit_id IN (SELECT unit_id 
                                                       FROM   xxpm_offer_detail 
                                                       WHERE 
                                           unit_type != 'CAR_PARKING' 
                                                      )) / 
                           365 ) 
                             ), 3), 0) 
                                    FREE_DAYS_DSCT, 
               (SELECT Count(*) 
                FROM   xxpm_booking_milestone_detail 
                WHERE  booking_hdr_id = XBH.booking_id 
                       AND milestone_type = 'BK') 
                                    NO_OF_PAYMENT, 
               Nvl(xc.customer_name, XBC.cust_name) 
                                    TENANT_NAME, 
               XL.phone_number 
                                    PHONE_NUMBER, 
               XL.mobile_number 
                                    MOBILE_NUMBER, 
               XL.email_id 
                                    EMAIL_ADDRESS, 
               NULL 
                                    STATUS, 
               XBH.currency 
                                    CURRENCY, 
               CURSOR (SELECT XPM.property_name, 
                              XPB.build_name                     BULIDING_NAME, 
                              XPU.unit_name, 
                              -- XOD.unit_type,   
                              (SELECT 
                      xxpm_utility_pkg.Get_lookup_value_disp('UNIT_TYPE', 
                      XPU.unit_type) 
                      UNIT_TYPE 
                               FROM   xxpl_property_units XPU 
                               WHERE  XOD.unit_id = XPU.unit_id) UNIT_TYPE, 
                              (SELECT 
                      xxpm_utility_pkg.Get_lookup_value_disp('UNIT_VIEW_TYPE', 
                      XPU.view_type) 
                      UNIT_TYPE 
                               FROM   xxpl_property_units XPU 
                               WHERE  XOD.unit_id = XPU.unit_id) UNIT_DESC, 
                              --XPU.view_type              UNIT_DESC,   
                              XPD.discount_type, 
                              Nvl(XBD.tax_amount, 0)             TAX_AMOUNT, 
                              Nvl(XBD.base_rate, 0)              TOTAL_VALUE, 
                              XPA.value                          AREA_IN_SQ_FT, 
                              XBD.total_rate                     LINE_TOTAL, 
                              Nvl(XPD.discount_value, 0)         DISCOUNT_VALUE 
                       FROM   xxpm_booking_detail XBD, 
                              xxpm_offer_header XOH, 
                              xxpm_offer_detail XOD, 
                              xxpl_property_master XPM, 
                              xxpl_property_buildings XPB, 
                              xxpl_property_units XPU, 
                              xxpm_pl_discounts XPD, 
                              xxpl_property_area XPA 
                       WHERE  XBH.booking_id = XBD.booking_id 
                              AND XBH.offer_hdr_id = XOH.offer_hdr_id 
                              AND XOH.offer_hdr_id = XOD.offer_hdr_id 
                              AND XOD.property_id = XPM.property_id 
                              AND XOD.building_id = XPB.build_id 
                              AND XOD.unit_id = XPU.unit_id 
                              AND XBD.discount_rate = XPD.discount_id(+) 
                              AND XOD.property_id = XBD.property_id 
                              AND XOD.building_id = XBD.building_id 
                              AND XOD.unit_id = XBD.unit_id 
                              AND XOD.property_id = XPA.property_id (+) 
                              AND XOD.unit_id = XPA.unit_id (+) 
                              AND XOD.building_id = XPA.build_id (+) 
                      --AND    XPA.area = 'CHARGE'  
                      ) 
               LINE 
                                    , 
               CURSOR (SELECT 
               xxpm_utility_pkg.Get_lookup_value_disp('MILESTONE_INSTALLMENT', 
                              XBMD.installment_type) INSTALLMENT_TYPE, 
               To_char(XBMD.due_date, 'DD/MM/YYYY')  DUE_DATE, 
               Nvl(XBMD.installment_amount, 0)       INSTALLMENT_AMOUNT 
                       FROM   xxpm_booking_milestone_detail XBMD 
                       WHERE  XBH.booking_id = XBMD.booking_hdr_id 
                              AND XBMD.milestone_type = 'BK') 
                                    BOOKING_MILESTONE, 
               CURSOR (SELECT XFC.cl_item, 
                              XCR.item_response1 
                       FROM   xxfnd_func_checklist XFC, 
                              xxfnd_checklist_response XCR 
                       WHERE  XBH.func_id = XFC.func_id 
                              AND XBH.booking_id = XCR.func_ref_id 
                              AND XFC.func_cl_id = XCR.func_cl_id 
                              AND XBH.func_id = XCR.func_id) 
                                    CHECK_LIST, 
               CURSOR (SELECT 
               xxpm_utility_pkg.Get_lookup_value_disp('OTHER_PAYMENT_TYPE', 
                              XBMD.installment_type) CHAR_TYPE, 
               XBMD.installment_amount               INSTALLMENT_AMOUNT_OT 
                       FROM   xxpm_booking_milestone_detail XBMD 
                       WHERE  XBH.booking_id = XBMD.booking_hdr_id 
                              AND XBMD.milestone_type = 'OC' 
                              AND XBMD.installment_type != 'SEC_DEP' 
                              AND Trim(XBH.booking_number) = 
                                  Nvl(p_booking_num, XBH.booking_number) 
                       ORDER  BY XBMD.installment_amount DESC) 
                                    OTHER_CHARGES, 
               CURSOR (SELECT XBMD.installment_amount INSTALLMENT_AMOUNT_AR 
                       FROM   xxpm_booking_milestone_detail XBMD 
                       WHERE  XBH.booking_id = XBMD.booking_hdr_id 
                              AND XBMD.milestone_type = 'OC' 
                              AND XBMD.installment_type = 'SEC_DEP' 
                              AND Trim(XBH.booking_number) = 
                                  Nvl(p_booking_num, XBH.booking_number) 
                       ORDER  BY XBMD.installment_amount DESC) 
                                    AMOUNT_RECEIVABLE 
        FROM   xxpm_booking_header XBH, 
               xxpm_offer_header XOH, 
               xxpm_lead XL, 
               xxpm_booking_customer XBC, 
               xxstg_customer XC, 
               xxstg_organizations XSO 
        WHERE  XBH.offer_hdr_id = XOH.offer_hdr_id 
               AND XOH.lead_id = XL.lead_id 
               AND XBH.booking_id = XBC.booking_id 
               AND XBC.cust_id_ar = xc.cust_id(+) 
               AND XBH.org_id = XSO.org_id(+) 
               AND Trim(XBH.booking_number) = 
                   Nvl(p_booking_num, XBH.booking_number); 

      l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

      dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

      dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

      dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

      l_data_xml := dbms_xmlgen.Getxml (l_handle); 

      RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_booking_form; 
  FUNCTION Xxpm_tc_sharjah_form(p_lease_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_lease_num); 

      OPEN l_query_ref FOR 
        --*********Sharjah*********   
        SELECT a.tenant_name_arabic, 
               a.tenant_name, 
               a.tenant_number, 
               a.nationality_arabic, 
               a.nationality, 
               a.profession, 
               a.emirate_id, 
               a.address_emirates_in_visa, 
               a.po_box, 
               a.tenant_email, 
               a.build_name, 
               a.no_of_property, 
               a.purpose_of_rent, 
               a.offer_flag, 
               a.offer_type_flag, 
               a.fax_number, 
               a.starting_date, 
               a.expiry_date, 
               a.rent, 
               a.currency, 
               a.amt_in_words, 
               a.payment_method, 
               a.building_name, 
               a.building_name_arabic, 
               a.build_no, 
               a.bond_type, 
               a.bond_type_arabic, 
               a.bond_number, 
               a.bond_date, 
               a.plot_number, 
               a.rented_property_type, 
               a.description, 
               a.property_number, 
               a.area, 
               a.city, 
               a.country, 
               a.vendor_name, 
               a.vendor_number, 
               a.nationality_arabic, 
               a.profession_vend, 
               a.emirates_id_vend, 
               a.nationality_vend, 
               a.supplier_name_arabic, 
             --  a.designation_vend, 
               a.supplier_address, 
               a.supp_phone_number, 
               a.supp_po_box, 
               a.supp_email_id, 
               a.location_name, 
               a.location_name_tl, 
               a.supp_fax_number 
        FROM   (SELECT 
               /* Details of Leasse(CUSTOMER) */ 
               xc.tenantarabicname 
               tenant_name_arabic, 
               xc.customer_name 
               tenant_name, 
               xc.customer_number 
               tenant_number, 
               xc.nationality1_arabic 
               nationality_arabic, 
               xc.nationality1 
               nationality, 
               xc.profession 
               profession, 
               xc.emirate_id 
               emirate_id, 
               xcs.city 
               address_emirates_in_visa, 
               xcs.postal_code 
               po_box, 
               xcc.email_id 
               tenant_email, 
               xpb.build_name, 
               (SELECT lookup_value_name_disp 
                       ||' ' 
                       ||lookup_value_name_disp_tl 
                FROM   xxfnd.xxfnd_lookup_values 
                WHERE 
                      lookup_value_name = xla.residential_details 
                      AND lookup_type_id IN (SELECT lookup_type_id 
                                             FROM   xxfnd.xxfnd_lookup_types 
                                             WHERE 
                          lookup_type_name = 'RESIDENTIAL_DETAILS')) 
                                              no_of_property, 
               /* Details of Rent */ 
               (SELECT lookup_value_name_disp 
                       ||' ' 
                       ||lookup_value_name_disp_tl 
                FROM   xxfnd.xxfnd_lookup_values 
                WHERE 
                      lookup_value_name = xla.residential_details 
                      AND lookup_type_id IN (SELECT lookup_type_id 
                                             FROM   xxfnd.xxfnd_lookup_types 
                                             WHERE 
                          lookup_type_name = 'PURPOSE_OF_RENT' 
                                            )) 
               purpose_of_rent 
               , 
                                                 ( CASE 
                                                     WHEN 
               (SELECT lookup_value_name_disp 
                FROM   xxfnd.xxfnd_lookup_values 
                WHERE  lookup_value_name = 
                       xoh.offer_flag 
                       AND lookup_type_id IN (SELECT 
                           lookup_type_id 
                                              FROM 
                           xxfnd.xxfnd_lookup_types 
                                              WHERE 
                           lookup_type_name = 
                           'OFFER_ADD_TYPE' 
                                             )) LIKE 
               '%New%' THEN 'N' 
                                                     WHEN 
               (SELECT lookup_value_name_disp 
                FROM   xxfnd.xxfnd_lookup_values 
                WHERE  lookup_value_name = 
                       xoh.offer_flag 
                       AND lookup_type_id IN (SELECT 
                           lookup_type_id 
                                              FROM 
                           xxfnd.xxfnd_lookup_types 
                                              WHERE 
                           lookup_type_name = 
                           'OFFER_ADD_TYPE' 
                                             )) LIKE 
               '%Renewal%' THEN 'R' 
                                                   END ) 
                                                 offer_flag, 
                                                 ( CASE 
                                                     WHEN 
               (SELECT lookup_value_name_disp 
                FROM   xxfnd.xxfnd_lookup_values 
                WHERE  lookup_value_name = 
                       xoh.offer_type 
                       AND lookup_type_id IN (SELECT 
                           lookup_type_id 
                                              FROM 
                           xxfnd.xxfnd_lookup_types 
                                              WHERE 
                           lookup_type_name = 
                           'OFFER_TYPE')) 
               LIKE 'Residential%' THEN 'R' 
                                                     WHEN 
               (SELECT lookup_value_name_disp 
                FROM   xxfnd.xxfnd_lookup_values 
                WHERE  lookup_value_name = 
                       xoh.offer_type 
                       AND lookup_type_id IN (SELECT 
                           lookup_type_id 
                                              FROM 
                           xxfnd.xxfnd_lookup_types 
                                              WHERE 
                           lookup_type_name = 
                           'OFFER_TYPE')) 
               LIKE 'Commercial%' THEN 'C' 
                                                   END ) 
                                                 offer_type_flag, 
                                                 xcc.fax_number 
                                                 fax_number, 
               To_char(xoh.offer_from_date, 'DD/MM/YYYY') 
               starting_date, 
               To_char(xoh.offer_to_date, 'DD/MM/YYYY') 
               expiry_date, 
               Round(Nvl(xoh.offer_total, 0), 2) 
               rent, 
               xoh.currency 
               currency, 
               xxpm_utility_pkg.Amount_in_words 
               (xoh.offer_total, 'AED') amt_in_words, 
               (SELECT Count(*) 
                FROM   xxpm_offer_milestone_detail 
                WHERE  offer_hdr_id = xoh.offer_hdr_id) 
               payment_method, 
               /*Leased Permises*/ 
               xpb.build_name 
               building_name, 
               xpb.build_name_tl 
               building_name_arabic, 
               xpb.build_number 
               build_no, 
               xpb.bond_type 
               bond_type, 
               xpb.bond_type_tl 
               bond_type_arabic, 
               xpb.bond_number 
               bond_number, 
               To_char(xpb.bond_date, 'DD/MM/YYYY') 
               bond_date, 
               xpb.plot_number 
               plot_number, 
               xod.unit_type 
               rented_property_type, 
               Listagg(Nvl(XPA.value, 0), ',') 
                 within GROUP(ORDER BY xpa.value ) over( 
                   PARTITION BY XLA.lease_number ) 
               area, 
               Listagg( 
                      xxpm_utility_pkg.Get_lookup_value_disp('UNIT_VIEW_TYPE', 
                      xpu.view_type), 
                                                 ',') 
               within GROUP(ORDER BY xpu.view_type) 
               over( 
                 PARTITION BY XLA.lease_number ) 
                                                 description, 
               Listagg(xpu.UNIT_NUMBER, ',') 
               within GROUP(ORDER BY xpu.UNIT_NUMBER) 
               over( 
                 PARTITION BY XLA.lease_number ) 
                                                 property_number, 
                                                 xl.city 
                                                 city, 
                                                 xl.country 
                                                 country, 
                                                 xv.vendor_name, 
                                                 xv.vendor_number, 
                                                 xv.nationality_arabic 
                                                 v_nationality_arabic, 
                                                 xv.profession 
                                                 profession_vend, 
                                                 xv.emirates_id 
                                                 emirates_id_vend, 
                                                 xv.nationality 
                                                 nationality_vend, 
                                                 xv.supplier_name_arabic, 
                                                /* xvc.designation 
                                                 designation_vend, */
                                                 xvs.address1 
                                                 supplier_address, 
                                                 xvc.phone_number 
                                                 supp_phone_number, 
                                                 xvs.postal_code 
                                                 supp_po_box, 
                                                 xvc.email_id 
                                                 supp_email_id, 
                                                 xl.location_name 
                                                 location_name, 
                                                 xl.location_name_tl 
                                                 location_name_tl, 
                                                 xvc.fax_number 
                                                 supp_fax_number 
                FROM   xxpm_offer_header xoh, 
                       xxpm_offer_detail xod, 
                       xxpm_booking_header xbh, 
                       xxpm_booking_detail xbd, 
                       xxpm_booking_customer xbc, 
                       xxstg_customer xc, 
                       xxstg_cust_contacts xcc, 
                       xxstg_cust_sites xcs, 
                       xxpl_property_buildings xpb, 
                       xxpl_property_units xpu, 
                       xxpl_property_master xpm, 
                       xxpm_pl_discounts xpd, 
                       xxpm_recommend_header xrh, 
                       xxpm_lease_agreement xla, 
                       xxpl_property_area xpa, 
                       xxstg_locations xl, 
                       xxpl_owner_dtle xow, 
                       xxstg_vendor xv, 
                       xxstg_vend_sites xvs, 
                       xxstg_vend_contacts xvc 
                WHERE  xoh.offer_hdr_id = xod.offer_hdr_id 
                       AND xoh.offer_hdr_id = xbh.offer_hdr_id 
                       AND xbh.booking_id = xbd.booking_id 
                       AND xbh.booking_id = xbc.booking_id 
                       AND xbc.cust_id_ar = xc.cust_id(+) 
                       AND xc.cust_id = xcc.cust_id(+) 
                       AND xcc.cust_site_id = xcs.cust_site_id(+) 
                       AND xbd.building_id = xpb.build_id 
                       AND xod.property_id = xbd.property_id 
                       AND xod.building_id = xbd.building_id 
                       AND xod.unit_id = xbd.unit_id 
                       AND xbd.unit_id = xpu.unit_id 
                       AND xbd.property_id = xpm.property_id 
                       AND xod.discount_amount = xpd.discount_id(+) 
                       AND xbh.booking_id = xrh.booking_id 
                       AND xrh.recommend_id = xla.recommend_id(+) 
                       AND xbd.property_id = xpa.property_id (+) 
                       AND xbd.unit_id = xpa.unit_id (+) 
                       AND xbd.building_id = xpa.build_id (+) 
                       AND xpm.location_id = xl.loc_id(+) 
                       AND xbc.cust_name != ' ' 
                       --and xv.vendor_name is not null   
                       AND xow.vend_site_id = xvs.vend_site_id(+) 
                       AND xbd.property_id = xow.property_id(+) 
                       AND xbd.building_id = xow.build_id (+) 
                       AND xbd.unit_id = xow.unit_id (+) 
                       AND xow.vend_id = xv.vend_id (+) 
                       AND xv.vend_id = xvs.vend_id(+) 
                       AND xvs.vend_id = xvc.vend_id(+) 
                       AND xvs.vend_site_id = xvc.vend_site_id(+) 
                       --AND XLA.LEASE_NUMBER    = 'LA-1017'  ;    
                       AND Trim(xla.lease_number) = Nvl(p_lease_num, 
               xla.lease_number)) 
               a 
        GROUP  BY a.tenant_name_arabic, 
                  a.tenant_name, 
                  a.tenant_number, 
                  a.nationality_arabic, 
                  a.nationality, 
                  a.profession, 
                  a.emirate_id, 
                  a.address_emirates_in_visa, 
                  a.po_box, 
                  a.tenant_email, 
                  a.build_name, 
                  a.no_of_property, 
                  a.purpose_of_rent, 
                  a.offer_flag, 
                  a.offer_type_flag, 
                  a.fax_number, 
                  a.starting_date, 
                  a.expiry_date, 
                  a.rent, 
                  a.currency, 
                  a.amt_in_words, 
                  a.payment_method, 
                  a.building_name, 
                  a.building_name_arabic, 
                  a.build_no, 
                  a.bond_type, 
                  a.bond_type_arabic, 
                  a.bond_number, 
                  a.bond_date, 
                  a.plot_number, 
                  a.rented_property_type, 
                  a.description, 
                  a.property_number, 
                  a.area, 
                  a.city, 
                  a.country, 
                  a.vendor_name, 
                  a.vendor_number, 
                  a.nationality_arabic, 
                  a.profession_vend, 
                  a.emirates_id_vend, 
                  a.nationality_vend, 
                  a.supplier_name_arabic, 
                --  a.designation_vend, 
                  a.supplier_address, 
                  a.supp_phone_number, 
                  a.supp_po_box, 
                  a.supp_email_id, 
                  a.location_name, 
                  a.location_name_tl, 
                  a.supp_fax_number; 

      l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

      dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

      dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

      dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

      l_data_xml := dbms_xmlgen.Getxml (l_handle); 

      RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_tc_sharjah_form; 
  FUNCTION Xxpm_provisional_bk_receipt(p_booking_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_booking_num); 

      OPEN l_query_ref FOR 
        SELECT a.booking_number, 
               a.unt, 
               a.property_name, 
               a.build_name, 
               a.recommend_number, 
               a.customer_name, 
               a.bu_name, 
               a.created_by, 
               a.customer_trn, 
               CURSOR (SELECT XR.receipt_number 
                              RECEIPT_NUMBER, 
                              To_char(XR.receipt_date, 'DD/MM/YYYY') 
                              RECEIPT_DATE, 
                              XR.description 
                              DESCRIPTION, 
                              To_char(XR.pay_ref_date, 'DD/MM/YYYY') 
                                     CHEQUE_MATURITY_DATE, 
                              XR.pay_ref_number 
                              CHEQUE_NO 
                              , 
               xxpm_utility_pkg.Get_lookup_value_disp('PAYMENT_MODE', 
               XR.pay_mode) 
                              PAYMENT_METHOD, 
               XR.bank_name                                            BANK_NAME 
                              , 
               XR.bank_branch_name 
                              BRANCH_NAME 
                              , 
               Nvl(XR.recommended_amount, 0) 
                              AMOUNT, 
               xxpm_utility_pkg.Amount_in_words ( 
               (SELECT SUM(XR.recommended_amount) amount_total 
                FROM   xxpm_receipt XR, 
                       xxpm_booking_header XBH 
                WHERE  XBH.booking_id = 
                       XR.source_func_ref_id(+) 
                       AND XR.rct_type = 'BK' 
                       AND Trim(XBH.booking_number) = Nvl( 
                           p_booking_num, XBH.booking_number)), 'AED') 
                              amount_in_words 
                              , 
               XR.currency_code 
                              CURRENCY_CODE 
               FROM   xxpm_receipt XR, 
               xxpm_booking_header XBH 
               WHERE  XBH.booking_id = XR.source_func_ref_id(+) 
               AND XR.rct_type = 'BK' 
               AND Trim(XBH.booking_number) = 
                   Nvl(p_booking_num, XBH.booking_number)) 
                                    LINE 
        FROM   (SELECT XBH.booking_number, 
                       XBH.performed_by                        CREATED_BY, 
                       Nvl(XC.customer_name, XBC.cust_name)    CUSTOMER_NAME, 
                       XSO.org_name                            BU_NAME, 
                       XC.trd1licenseno                        CUSTOMER_TRN, 
                       (SELECT recommend_number 
                        FROM   xxpm_recommend_header 
                        WHERE  XBH.booking_id = booking_id(+)) recommend_number, 
                       (SELECT property_name 
                        FROM   xxpl_property_master 
                        WHERE  property_id = XBD.property_id)  PROPERTY_NAME, 
                       XBH.booking_number                      BOOKING_NO, 
                       (SELECT build_name 
                        FROM   xxpl_property_buildings 
                        WHERE  build_id = XBD.building_id)     BUILD_NAME, 
                       Listagg((SELECT unit_name 
                                FROM   xxpl_property_units 
                                WHERE  unit_id = XBD.unit_id), ',') 
                         within GROUP ( ORDER BY ( SELECT unit_name FROM 
                         xxpl_property_units 
                         WHERE 
                         unit_id = xbd.unit_id )) over( 
                           PARTITION BY XBH.booking_number)    unt 
                FROM   xxpm_booking_header XBH, 
                       xxpm_booking_detail XBD, 
                       xxpm_booking_customer XBC, 
                       xxstg_organizations XSO, 
                       xxstg_customer XC 
                WHERE  XBH.booking_id = XBD.booking_id 
                       AND XBH.booking_id = XBC.booking_id 
                       AND XBC.cust_id_ar = xc.cust_id(+) 
                       AND XBH.org_id = XSO.org_id(+) 
                       AND XBC.cust_name != ' ' 
                       --AND XBH.BOOKING_NUMBER = 'BK-1059'   
                       AND Trim(XBH.booking_number) = 
                           Nvl(p_booking_num, XBH.booking_number)) a 
        GROUP  BY booking_number, 
                  unt, 
                  build_name, 
                  recommend_number, 
                  property_name, 
                  customer_name, 
                  bu_name, 
                  created_by, 
                  customer_trn; 

      l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

      dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

      dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

      dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

      l_data_xml := dbms_xmlgen.Getxml (l_handle); 

      RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_provisional_bk_receipt; 
  FUNCTION Xxpm_provisional_rec_receipt(p_recommend_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_recommend_num); 

      OPEN l_query_ref FOR 
        SELECT a.booking_number, 
               a.unt, 
               a.property_name, 
               a.build_name, 
               a.recommend_number, 
               a.customer_name, 
               a.bu_name, 
               a.created_by, 
               a.customer_trn, 
               CURSOR (SELECT XR.receipt_number 
                              RECEIPT_NUMBER, 
                              To_char(XR.receipt_date, 'DD/MM/YYYY') 
                              RECEIPT_DATE, 
                              XR.description                         DESCRIPTION 
                              , 
To_char(XR.pay_ref_date, 'DD/MM/YYYY') 
CHEQUE_MATURITY_DATE, 
XR.pay_ref_number                      CHEQUE_NO, 
xxpm_utility_pkg.Get_lookup_value_disp('PAYMENT_MODE', 
XR.pay_mode) 
           PAYMENT_METHOD, 
XR.bank_name                           BANK_NAME, 
XR.bank_branch_name                    BRANCH_NAME, 
Nvl(XR.recommended_amount, 0)          AMOUNT, 
xxpm_utility_pkg.Amount_in_words ((SELECT 
SUM(XR.recommended_amount) amount_total 
       FROM 
xxpm_receipt XR, 
xxpm_recommend_header XRH 
       WHERE 
XRH.booking_id = 
XR.source_func_ref_id(+) 
-- AND XR.rct_type = 'BK'   
AND Trim(XRH.recommend_number) 
= 
Nvl(p_recommend_num, 
XRH.recommend_number)), 
'AED') 
amount_in_words, 
XR.currency_code                       CURRENCY_CODE 
FROM   xxpm_receipt XR, 
xxpm_recommend_header XRH 
WHERE  XRH.booking_id = XR.source_func_ref_id(+) 
--AND XRH.recommend_number = a.recommend_number   
--AND XRH.RECOMMEND_NUMBER = 'RC-1035'   
AND Trim(XRH.recommend_number) = 
Nvl(p_recommend_num, XRH.recommend_number)) LINE 
FROM   (SELECT XBH.booking_number, 
XRH.recommend_number, 
XRH.created_by, 
Nvl(XC.customer_name, XBC.cust_name)   CUSTOMER_NAME, 
XC.trd1licenseno                       CUSTOMER_TRN, 
XSO.org_name                           BU_NAME, 
(SELECT property_name 
FROM   xxpl_property_master 
WHERE  property_id = XBD.property_id) PROPERTY_NAME, 
XBH.booking_number                     BOOKING_NO, 
(SELECT build_name 
FROM   xxpl_property_buildings 
WHERE  build_id = XBD.building_id)    BUILD_NAME, 
Listagg((SELECT unit_name 
FROM   xxpl_property_units 
WHERE  unit_id = XBD.unit_id), ',') 
within GROUP ( ORDER BY ( SELECT unit_name FROM 
xxpl_property_units 
WHERE 
unit_id = xbd.unit_id )) over( 
PARTITION BY XBH.booking_number)   unt 
FROM   xxpm_booking_header XBH, 
xxpm_booking_detail XBD, 
xxpm_recommend_header XRH, 
xxpm_booking_customer XBC, 
xxstg_organizations XSO, 
xxstg_customer XC 
WHERE  XBH.booking_id = XBD.booking_id 
AND XBH.booking_id = XBC.booking_id 
AND XBH.booking_id = XRH.booking_id 
AND XBC.cust_id_ar = xc.cust_id(+) 
AND XBH.org_id = XSO.org_id(+) 
AND XBC.cust_name != ' ' 
--AND XRH.RECOMMEND_NUMBER = 'RC-1035';   
AND Trim(XRH.recommend_number) = 
Nvl(p_recommend_num, XRH.recommend_number))a 
GROUP  BY booking_number, 
unt, 
build_name, 
recommend_number, 
property_name, 
customer_name, 
bu_name, 
created_by, 
customer_trn; 

l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

l_data_xml := dbms_xmlgen.Getxml (l_handle); 

RETURN ( l_data_xml ); 
EXCEPTION 
WHEN OTHERS THEN 
RETURN ( NULL ); 
END xxpm_provisional_rec_receipt; 
  FUNCTION Xxpm_bookingreceipt_form(p_receipt_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_receipt_num); 

      OPEN l_query_ref FOR 
        SELECT a.booking_no, 
               a.unt, 
               a.property_name, 
               a.build_name, 
               a.recommend_number, 
               a.customer_name, 
               a.bu_name, 
               a.created_by, 
               a.customer_trn, 
               CURSOR (SELECT XR.receipt_number 
                              RECEIPT_NUMBER, 
                              To_char(XR.receipt_date, 'DD/MM/YYYY') 
                                     RECEIPT_DATE, 
                              XR.description 
                                     DESCRIPTION, 
                              To_char(XR.pay_ref_date, 'DD/MM/YYYY') 
                                     CHEQUE_MATURITY_DATE, 
                              XR.pay_ref_number 
                                     CHEQUE_NO, 
  xxpm_utility_pkg.Get_lookup_value_disp('PAYMENT_MODE', 
  XR.pay_mode) 
         PAYMENT_METHOD, 
  XR.bank_name 
         BANK_NAME, 
  XR.bank_branch_name 
         BRANCH_NAME, 
  Nvl(XR.recommended_amount, 0) 
  AMOUNT, 
  xxpm_utility_pkg.Amount_in_words (XR.recommended_amount, 
  'AED') 
         amount_in_words, 
  XR.currency_code 
         CURRENCY_CODE 
  FROM   xxpm_receipt XR, 
  xxpm_booking_header XBH 
  WHERE  XBH.booking_id = XR.source_func_ref_id(+) 
  --AND XRH.recommend_number = a.recommend_number   
  --AND XRH.RECOMMEND_NUMBER = 'RC-1035'   
  AND Trim(XR.receipt_number) = 
      Nvl(p_receipt_num, XR.receipt_number)) LINE 
  FROM   (SELECT XBH.booking_number, 
  XRH.recommend_number, 
  XRH.created_by, 
  Nvl(XC.customer_name, XBC.cust_name)   CUSTOMER_NAME, 
  XC.trd1licenseno                       CUSTOMER_TRN, 
  XSO.org_name                           BU_NAME, 
  (SELECT property_name 
  FROM   xxpl_property_master 
  WHERE  property_id = XBD.property_id) PROPERTY_NAME, 
  XBH.booking_number                     BOOKING_NO, 
  (SELECT build_name 
  FROM   xxpl_property_buildings 
  WHERE  build_id = XBD.building_id)    BUILD_NAME, 
  Listagg((SELECT unit_name 
    FROM   xxpl_property_units 
    WHERE  unit_id = XBD.unit_id), ',') 
  within GROUP ( ORDER BY ( SELECT unit_name FROM 
  xxpl_property_units 
  WHERE 
  unit_id = xbd.unit_id )) over( 
  PARTITION BY XBH.booking_number)   unt 
  FROM   xxpm_booking_header XBH, 
  xxpm_booking_detail XBD, 
  xxpm_recommend_header XRH, 
  xxpm_booking_customer XBC, 
  xxstg_organizations XSO, 
  xxstg_customer XC, 
  xxpm_receipt XR 
  WHERE  XBH.booking_id = XBD.booking_id 
  AND XBH.booking_id = XBC.booking_id 
  AND XBH.booking_id = XRH.booking_id(+) 
  AND XBC.cust_id_ar = xc.cust_id(+) 
  AND XBH.org_id = XSO.org_id(+) 
  AND XBH.booking_id = XR.source_func_ref_id(+) 
  AND XBC.cust_name != ' ' 
  --AND XR.RECEIPT_NUMBER = 'RT-1147';   
  AND Trim(XR.receipt_number) = 
  Nvl(p_receipt_num, XR.receipt_number))a 
  GROUP  BY booking_number, 
  unt, 
  build_name, 
  recommend_number, 
  property_name, 
  customer_name, 
  bu_name, 
  created_by, 
  customer_trn; 

  l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

  dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

  dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

  dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

  l_data_xml := dbms_xmlgen.Getxml (l_handle); 

  RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_bookingreceipt_form; 
  FUNCTION Xxpm_recommendreceipt_form(p_receipt_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_receipt_num); 

      OPEN l_query_ref FOR 
        SELECT a.booking_no, 
               a.unt, 
               a.property_name, 
               a.build_name, 
               a.recommend_number, 
               a.customer_name, 
               a.bu_name, 
               a.created_by, 
               a.customer_trn, 
               CURSOR (SELECT XR.receipt_number 
                              RECEIPT_NUMBER, 
                              To_char(XR.receipt_date, 'DD/MM/YYYY') 
                                     RECEIPT_DATE, 
                              XR.description 
                                     DESCRIPTION, 
                              To_char(XR.pay_ref_date, 'DD/MM/YYYY') 
                                     CHEQUE_MATURITY_DATE, 
                              XR.pay_ref_number 
                                     CHEQUE_NO, 
  xxpm_utility_pkg.Get_lookup_value_disp('PAYMENT_MODE', 
  XR.pay_mode) 
         PAYMENT_METHOD, 
  XR.bank_name 
         BANK_NAME, 
  XR.bank_branch_name 
         BRANCH_NAME, 
  Nvl(XR.recommended_amount, 0) 
  AMOUNT, 
  xxpm_utility_pkg.Amount_in_words (XR.recommended_amount, 
  'AED') 
         amount_in_words, 
  XR.currency_code 
         CURRENCY_CODE 
  FROM   xxpm_receipt XR, 
  xxpm_recommend_header XRH 
  WHERE  XRH.booking_id = XR.source_func_ref_id(+) 
  --AND XRH.recommend_number = a.recommend_number   
  --AND XRH.RECOMMEND_NUMBER = 'RC-1035'   
  AND Trim(XR.receipt_number) = 
      Nvl(p_receipt_num, XR.receipt_number)) LINE 
  FROM   (SELECT XBH.booking_number, 
  XRH.recommend_number, 
  XRH.created_by, 
  XC.trd1licenseno                       CUSTOMER_TRN, 
  Nvl(XC.customer_name, XBC.cust_name)   CUSTOMER_NAME, 
  XSO.org_name                           BU_NAME, 
  (SELECT property_name 
  FROM   xxpl_property_master 
  WHERE  property_id = XBD.property_id) PROPERTY_NAME, 
  XBH.booking_number                     BOOKING_NO, 
  (SELECT build_name 
  FROM   xxpl_property_buildings 
  WHERE  build_id = XBD.building_id)    BUILD_NAME, 
  Listagg((SELECT unit_name 
    FROM   xxpl_property_units 
    WHERE  unit_id = XBD.unit_id), ',') 
  within GROUP ( ORDER BY ( SELECT unit_name FROM 
  xxpl_property_units 
  WHERE 
  unit_id = xbd.unit_id )) over( 
  PARTITION BY XBH.booking_number)   unt 
  FROM   xxpm_booking_header XBH, 
  xxpm_booking_detail XBD, 
  xxpm_recommend_header XRH, 
  xxpm_booking_customer XBC, 
  xxstg_organizations XSO, 
  xxstg_customer XC, 
  xxpm_receipt XR 
  WHERE  XBH.booking_id = XBD.booking_id 
  AND XBH.booking_id = XBC.booking_id 
  AND XBH.booking_id = XRH.booking_id 
  AND XBC.cust_id_ar = xc.cust_id(+) 
  AND XBH.org_id = XSO.org_id(+) 
  AND XBH.booking_id = XR.source_func_ref_id(+) 
  AND XBC.cust_name != ' ' 
  --AND XRH.RECOMMEND_NUMBER = 'RC-1035';   
  AND Trim(XR.receipt_number) = 
  Nvl(p_receipt_num, XR.receipt_number))a 
  GROUP  BY booking_number, 
  unt, 
  build_name, 
  recommend_number, 
  property_name, 
  customer_name, 
  bu_name, 
  created_by, 
  customer_trn; 

  l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

  dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

  dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

  dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

  l_data_xml := dbms_xmlgen.Getxml (l_handle); 

  RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_recommendreceipt_form; 
  FUNCTION Xxpm_tc_dubai_form(p_lease_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_lease_num); 

      OPEN l_query_ref FOR 
        SELECT To_char(SYSDATE, 'DD') 
               DT 
               , 
               xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
               XOH.offer_type) 
                                    OFFER_TYPE, 
               ( CASE 
                   WHEN xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
                        XOH.offer_type) 
                        LIKE 
                        'Residential%' THEN 'R' 
                   WHEN xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
                        XOH.offer_type) 
                        LIKE 
                        'Commercial%' THEN 'C' 
                   WHEN xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
                        XOH.offer_type) 
                        LIKE 
                        'Industrial%' THEN 'I' 
                 END ) 
                                    OFFER_TYPE_FLAG, 
               To_char(SYSDATE, 'MM') 
               MON, 
               To_char(SYSDATE, 'YYYY') 
               YR 
               , 
               XLA.lease_number, 
               XPB.build_name, 
               XC.customer_name 
                                    TENANT_NAME, 
               XCC.email_id 
                                    TENANT_EMAIL, 
               XCC.phone_number 
                                    TENANT_PHONE, 
               XPB.build_name 
                                    BULIDING_NAME, 
               XPA.value 
                                    PROPERTY_SIZE, 
               XPU.unit_name 
                                    PROPERTY_NO, 
               XPU.unit_type 
                                    PROPERTY_TYPE, 
               To_char(XOH.offer_from_date, 'DD/MM/YYYY') 
                                    CONTRACT_PERIOD_FROM, 
               To_char(XOH.offer_to_date, 'DD/MM/YYYY') 
                                    CONTRACT_PERIOD_TO, 
               XV.supplier_name_arabic 
                                    SUPP_VEND_NAME, 
               XV.vendor_name 
                                    VENDOR_NAME, 
               XV.vendor_number 
                                    VENDOR_NUMBER, 
               XVC.email_id 
                                    EMAIL_ID, 
               XVC.phone_number 
                                    PHONE_NUMBER, 
               XL.city 
               CITY 
                                    , 
               XL.country 
                                    COUNTRY, 
               XPB.plot_number 
                                    PLOT_NUMBER, 
               XV.vendor_name 
                                    vendor_name, 
               XBH.booking_number 
                                    BOOKING_NO, 
               XPU.doc_ref_number_3 
                                    PREMISES_NO_DEWA, 
               --XRH.recommend_number,   
               --XLA.lease_number,   
               -- XPB.build_number,   
               --XOH.offer_number,   
               Nvl (( CASE 
                        WHEN XPD.discount_type = '%' THEN Nvl(( XOD.base_rate - 
                        ( Nvl(XOD.base_rate, 
                          0 
                          ) * 
                        ( 
                        Nvl(XPD.discount_value, 0) / 
                      100 
                      ) 
                      ) ), 0) 
                        ELSE Nvl(XOD.base_rate, 0) - Nvl(XPD.discount_value, 0) 
                      END ) 
                    ||'/-' 
                    || ' ' 
                    || '(' 
                    ||Initcap(To_char (To_date (( CASE 
                                                    WHEN XPD.discount_type = '%' 
                                                  THEN 
                                                    Nvl(( XOD.base_rate - 
                                                    ( Nvl(XOD.base_rate, 
                                                      0 
                                                      ) * 
                                                    ( 
                                                    Nvl(XPD.discount_value, 0) / 
                                                  100 
                                                  ) 
                                                  ) ), 0) 
                                                    ELSE Nvl(XOD.base_rate, 0) - 
                                                         Nvl(XPD.discount_value, 
                                                         0 
                                                         ) 
                                                  END ), 'j'), 'jsp')) 
                    ||' Dhs Only)', ' ') 
                                    ANNUAL_RENT, 
               Nvl(XOD.base_rate, 0) 
                                    CONTRACT_VALUE, 
               ( CASE 
                   WHEN XPD.discount_type = '%' THEN ( ( 
                   XOD.base_rate * XPD.discount_value ) / 
                                                       100 ) 
                   ELSE Nvl(XPD.discount_value, 0) 
                 END ) 
                                    DISCOUNT_AMOUNT, 
               XOH.currency 
                                    CURRENCY, 
               (SELECT Count(*) 
                FROM   xxpm_offer_milestone_detail 
                WHERE  offer_hdr_id = XOH.offer_hdr_id) 
                                    MODE_OF_PAYMENT, 
               XPM.property_name, 
               XPU.unit_name, 
               xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', 
               XOH.offer_type) 
                                    PROPERTY_USAGE, 
               (SELECT XBMD.installment_amount 
                FROM   xxpm_booking_milestone_detail XBMD 
                WHERE  XBH.booking_id = XBMD.booking_hdr_id 
                       AND XBMD.installment_type = 'SEC_DEP' 
                       AND Trim(XLA.lease_number) = Nvl(p_lease_num, 
               XLA.lease_number)) 
                                    Security_Deposit_Amount 
        FROM   xxpm_offer_header XOH, 
               xxpm_offer_detail XOD, 
               xxpm_booking_header XBH, 
               xxpm_booking_detail XBD, 
               xxpm_booking_customer XBC, 
               xxstg_customer XC, 
               xxstg_cust_contacts XCC, 
               xxpl_property_buildings XPB, 
               xxpl_property_units XPU, 
               xxpl_property_master XPM, 
               xxpm_pl_discounts XPD, 
               xxpm_recommend_header XRH, 
               xxpm_lease_agreement XLA, 
               xxpl_property_area XPA, 
               xxpl_owner_dtle XOW, 
               xxstg_vendor XV, 
               xxstg_vend_sites XVS, 
               xxstg_vend_contacts XVC, 
               xxstg_locations XL 
        WHERE  XOH.offer_hdr_id = XOD.offer_hdr_id 
               AND XOH.offer_hdr_id = XBH.offer_hdr_id 
               AND XBH.booking_id = XBD.booking_id 
               AND XBH.booking_id = XBC.booking_id 
               AND XBC.cust_id_ar = xc.cust_id(+) 
               AND XC.cust_id = XCC.cust_id(+) 
               AND XBD.building_id = XPB.build_id 
               AND XBD.unit_id = XPU.unit_id 
               AND XBD.property_id = XPM.property_id 
               AND XPM.location_id = XL.loc_id(+) 
               AND XOD.discount_amount = XPD.discount_id(+) 
               AND XBH.booking_id = XRH.booking_id 
               AND XRH.recommend_id = XLA.recommend_id(+) 
               AND XOD.property_id = XBD.property_id 
               AND XOD.building_id = XBD.building_id 
               AND XOD.unit_id = XBD.unit_id 
               AND XBD.property_id = XPA.property_id 
               AND XBD.unit_id = XPA.unit_id 
               AND XBD.building_id = XPA.build_id 
               AND XBC.cust_name != ' ' 
               AND XOW.vend_site_id = XVS.vend_site_id(+) 
               AND XBD.property_id = XOW.property_id(+) 
               AND XBD.building_id = XOW.build_id (+) 
               AND XBD.unit_id = XOW.unit_id(+) 
               AND XOW.vend_id = XV.vend_id (+) 
               AND XV.vend_id = XVS.vend_id(+) 
               AND XVS.vend_id = XVC.vend_id(+) 
               AND XVS.vend_site_id = XVC.vend_site_id(+) 
               --AND XLA.LEASE_NUMBER    = 'LA-1009'   
               AND Trim(XLA.lease_number) = Nvl(p_lease_num, XLA.lease_number); 

      l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

      dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

      dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

      dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

      l_data_xml := dbms_xmlgen.Getxml (l_handle); 

      RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_tc_dubai_form; 
  FUNCTION Xxpm_reservation_form(p_recommend_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_recommend_num); 

      OPEN l_query_ref FOR 
        SELECT XRH.recommend_number 
               recommend_number, 
               To_char(XRH.creation_date, 'DD/MM/YYYY') 
                                    recommend_date, 
               xxpm_utility_pkg.Get_lookup_value_disp('OFFER_ADD_TYPE', 
               XOH.offer_flag) 
                     lease_type 
                                    , 
        xxpm_utility_pkg.Get_lookup_value_disp('OFFER_TYPE', XOH.offer_type) 
               Contract_Type, 
        To_char(systimestamp, 'DD-Mon-YY HH24:MI:SS') 
                                    sysdate_with_timestamp, 
        Nvl(xc.customer_name, XBC.cust_name) 
               TENANT_NAME 
               , 
        XL.phone_number 
               CONTACT_NUMBER, 
        (SELECT Count(*) 
         FROM   xxpm_offer_milestone_detail XOMD 
         WHERE  offer_hdr_id = XOH.offer_hdr_id 
                AND XOMD.milestone_type = 'BK') 
               NO_OF_PAYMENT, 
        ( CASE 
            WHEN Lower(XSO.org_name) LIKE '%sharjah%' THEN 
            'Leasing Sharjah Business Unit' 
            WHEN Lower(XSO.org_name) LIKE '%dubai%' THEN 
            'Leasing Dubai Business Unit' 
          END )                                                        BU_NAME, 
        To_char(XOH.offer_from_date, 'DD/MM/YYYY') 
                                    CONTRACT_START_DATE, 
        To_char(XOH.offer_to_date, 'DD/MM/YYYY') 
               CONTRACT_END_DATE 
                                    , 
        XBH.currency 
                                    CURRENCY, 
        XC.trd1licenseno 
               CUSTOMER_TRN, 
        CURSOR (SELECT XPM.property_name, 
                       XPB.build_name                     BULIDING_NAME, 
                       XOD.unit_id, 
                       XPU.unit_name                      PREMISES_NO, 
                       (SELECT 
               xxpm_utility_pkg.Get_lookup_value_disp('UNIT_TYPE', 
               XPU.unit_type) 
               UNIT_TYPE 
                        FROM   xxpl_property_units XPU 
                        WHERE  XOD.unit_id = XPU.unit_id) UNIT_TYPE, 
                       (SELECT 
               xxpm_utility_pkg.Get_lookup_value_disp('UNIT_TYPE', 
               XPU.unit_type) 
               UNIT_TYPE 
                        FROM   xxpl_property_units XPU 
                        WHERE  XOD.unit_id = XPU.unit_id) UNIT_DESC, 
                       --XPU.view_type          UNIT_DESC,   
                       --XOD.unit_type,   
                       XPA.value                          AREA_IN_SQ_FT, 
                       XOD.base_rate                      OFFER_AMOUNT, 
                       XPD.discount_type, 
                       XPD.discount_value, 
                       Nvl(XOD.tax_amount, 0)             TAX_AMOUNT, 
                       ( CASE 
                           WHEN XPD.discount_type = '%' THEN 
                           Nvl((XOD.base_rate -(Nvl(XOD.base_rate, 0 
                           ) 
                           * (Nvl(XPD.discount_value, 0)/100))) 
                           , 0) 
                           + Nvl(XOD.tax_amount, 0) 
                           ELSE Nvl(XOD.base_rate, 0) - Nvl(XPD.discount_value, 
                                                        0) 
                                + 
                                Nvl(XOD.tax_amount, 0) 
                         END )                            LINE_TOTAL 
                FROM   xxpm_offer_detail XOD, 
                       xxpl_property_buildings XPB, 
                       xxpl_property_units XPU, 
                       xxpl_property_master XPM, 
                       xxpm_booking_header XBH, 
                       xxpm_pl_discounts XPD, 
                       xxpl_property_area XPA 
                WHERE  XOH.offer_hdr_id = XOD.offer_hdr_id 
                       AND XOD.building_id = XPB.build_id 
                       AND XBH.offer_hdr_id = XOH.offer_hdr_id 
                       AND XOD.unit_id = XPU.unit_id 
                       AND XOD.property_id = XPM.property_id 
                       AND XOD.discount_amount = XPD.discount_id(+) 
                       AND XOD.property_id = XPA.property_id (+) 
                       AND XOD.unit_id = XPA.unit_id (+) 
                       AND XOD.building_id = XPA.build_id (+) 
                       AND XBH.booking_id = XRH.booking_id 
                       --AND XPA.area = 'CHARGE'  
                       AND Trim(XRH.recommend_number) = 
                           Nvl(p_recommend_num, XRH.recommend_number)) Line, 
        CURSOR (SELECT To_char(XR.receipt_date, 'DD/MM/YYYY') 
                       RECEIPT_DATE 
                              , 
                       Nvl(XR.recommended_amount, 0) 
                              AMOUNT_APPLIED, 
                       To_char(XR.receipt_date, 'DD/MM/YYYY') 
                              MATURITY_DATE, 
                       To_char(XR.pay_rec_date, 'DD/MM/YYYY') 
                              CHEQUE_RECOMMAND_DATE, 
                       Nvl(Trunc(XBMD.due_date) - Trunc(XR.pay_rec_date), 0) 
                              DIFF_IN_DAYS, 
  xxpm_utility_pkg.Get_lookup_value_disp('MILESTONE_INSTALLMENT', 
  XBMD.installment_type) 
         INSTALLMENT_TYPE, 
  To_char(XBMD.due_date, 'DD/MM/YYYY') 
         DUE_DATE, 
  Nvl(XBMD.installment_amount, 0) 
         INSTALLMENT_AMOUNT, 
  Nvl(XBMD.installment_amount, 0) 
         recommended_amount_total, 
  xxpm_utility_pkg.Get_lookup_value_disp('PAYMENT_MODE', 
  XR.pay_mode) 
         PAYMENT_MODE 
  FROM   xxpm_receipt xr, 
  xxpm_receipt_details xrd, 
  xxpm_booking_milestone_detail XBMD 
  WHERE  XRH.booking_id = xr.source_func_ref_id(+) 
  AND XR.receipt_id = XRD.receipt_id (+) 
  AND XRD.booking_ms_dtl_id = XBMD.booking_ms_dtl_id (+) 
  AND XR.rct_type = 'BK' 
  -- AND XRH.RECOMMEND_NUMBER = 'RC-1079';   
  AND Trim(XRH.recommend_number) = 
      Nvl(p_recommend_num, XRH.recommend_number)) PAYMENT_DETAILS 
  , 
  CURSOR (SELECT Nvl(SUM(XBMD.installment_amount), 0) total_amount 
  FROM   xxpm_booking_milestone_detail XBMD, 
  xxpm_recommend_header XRH 
  WHERE  XRH.booking_id = XBMD.booking_hdr_id 
  AND XBMD.milestone_type = 'BK' 
  AND Trim(XRH.recommend_number) = 
      Nvl(p_recommend_num, XRH.recommend_number)) 
               RECOMMEND_AMOUNT_TOTAL, 
  CURSOR (SELECT XFC.cl_item, 
  XCR.item_response1 
  FROM   xxfnd_func_checklist XFC, 
  xxfnd_checklist_response XCR 
  WHERE  XRH.func_id = XFC.func_id(+) 
  AND XRH.booking_id = XCR.func_ref_id(+) 
  AND XFC.func_cl_id = XCR.func_cl_id(+) 
  AND XRH.func_id = XCR.func_id(+) 
  AND Trim(XRH.recommend_number) = 
      Nvl(p_recommend_num, XRH.recommend_number)) CHECK_LIST, 
  CURSOR (SELECT xxpm_utility_pkg.Get_lookup_value_disp('OTHER_PAYMENT_TYPE', 
                 XBMD.installment_type) CHAR_TYPE, 
  XBMD.installment_amount               INSTALLMENT_AMOUNT_OT 
  FROM   xxpm_booking_milestone_detail XBMD 
  WHERE  XRH.booking_id = XBMD.booking_hdr_id 
  AND XBMD.milestone_type = 'OC' 
  AND XBMD.installment_type != 'SEC_DEP' 
  AND Trim(XRH.recommend_number) = 
      Nvl(p_recommend_num, XRH.recommend_number) 
  ORDER  BY XBMD.installment_amount DESC)                OTHER_CHARGES, 
  CURSOR (SELECT XBMD.installment_amount INSTALLMENT_AMOUNT_AR 
  FROM   xxpm_booking_milestone_detail XBMD 
  WHERE  XRH.booking_id = XBMD.booking_hdr_id 
  AND XBMD.milestone_type = 'OC' 
  AND XBMD.installment_type = 'SEC_DEP' 
  AND Trim(XRH.recommend_number) = 
      Nvl(p_recommend_num, XRH.recommend_number) 
  ORDER  BY XBMD.installment_amount DESC) 
  AMOUNT_RECEIVABLE 
  FROM   xxpm_offer_header XOH, 
  xxpm_booking_header XBH, 
  xxpm_booking_customer XBC, 
  xxstg_customer XC, 
  xxstg_cust_contacts XCC, 
  xxpm_lease_agreement XLA, 
  xxpm_lead XL, 
  xxstg_organizations XSO, 
  xxpm_recommend_header XRH 
  WHERE  XOH.offer_hdr_id = XBH.offer_hdr_id 
  AND XBH.booking_id = XBC.booking_id 
  AND XBC.cust_id_ar = xc.cust_id(+) 
  AND XC.cust_id = XCC.cust_id(+) 
  AND XOH.lead_id = XL.lead_id 
  AND XBH.booking_id = XRH.booking_id 
  AND XRH.recommend_id = XLA.recommend_id(+) 
  AND XOH.org_id = XSO.org_id(+) 
  AND XBC.cust_name != ' ' 
  AND Trim(XRH.recommend_number) = 
  Nvl(p_recommend_num, XRH.recommend_number); 

  l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

  dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

  dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

  dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

  l_data_xml := dbms_xmlgen.Getxml (l_handle); 

  RETURN ( l_data_xml ); 
  EXCEPTION 
    WHEN OTHERS THEN 
               RETURN ( NULL ); 
  END xxpm_reservation_form; 
  FUNCTION Xxpm_tax_invoice(p_lease_num IN VARCHAR2) 
  RETURN CLOB 
  IS 
    l_query_ref SYS_REFCURSOR; 
    l_handle    dbms_xmlgen.ctxhandle; 
    l_data_xml  CLOB; 
  BEGIN 
      dbms_output.Put_line(p_lease_num); 

      OPEN l_query_ref FOR 
        SELECT 
        XC.customer_name                            TENANT_NAME, 
               XCC.phone_number                            TENANT_PHONE, 
               XC.trd1licenseno                            CUSTOMER_TRN, 
               XCS.city                                    PLACE_OF_SUPPLY, 
               (SELECT DISTINCT xbd.customer_trxn_num 
                FROM   xxpm_booking_detail XBD, 
                       xxpm_recommend_header XRH, 
                       xxpm_lease_agreement XLA 
                WHERE  XBH.booking_id = XBD.booking_id 
                       AND XBH.booking_id = XRH.booking_id 
                       AND XRH.recommend_id = XLA.recommend_id(+) 
                       AND Trim(XLA.lease_number) = Nvl(p_lease_num, 
        XLA.lease_number)) 
                                                           INVOICE_NUM, 
               (SELECT DISTINCT xbmd.trxn_date 
                FROM   xxpm_booking_header XBH, 
                       xxpm_booking_detail XBD, 
                       xxpm_booking_milestone_detail xbmd, 
                       xxpm_recommend_header XRH, 
                       xxpm_lease_agreement XLA 
                WHERE  XBH.booking_id = XBMD.booking_hdr_id(+) 
                       AND XBH.booking_id = XBD.booking_id 
                       AND XBH.booking_id = XRH.booking_id 
                       AND XRH.recommend_id = XLA.recommend_id(+) 
                       AND Trim(XLA.lease_number) = Nvl(p_lease_num, 
        XLA.lease_number)) 
                                                           INVOICE_DATE, 
               xla.lease_number                            CONTRACT_NUMBER, 
               To_char(XLA.lease_start_date, 'DD/MM/YYYY') CONTRACT_START_DATE, 
               To_char(XLA.lease_end_date, 'DD/MM/YYYY')   CONTRACT_END_DATE, 
               Nvl(XBH.total_rent, 0)                      RENT_VALUE, 
               Nvl((SELECT XBMD.installment_amount 
                    FROM   xxpm_booking_milestone_detail XBMD 
                    WHERE  XBH.booking_id = XBMD.booking_hdr_id 
                           AND XBMD.installment_type = 'SEC_DEP' 
                           AND Trim(XLA.lease_number) = 
                               Nvl(p_lease_num, XLA.lease_number)), 0) 
                                  Security_Amount, 
               Nvl((SELECT SUM(total_rate) 
                    FROM   xxpm_booking_detail 
                    WHERE  booking_id = XBH.booking_id 
                           AND unit_id IN (SELECT unit_id 
                                           FROM   xxpm_offer_detail 
                                           WHERE  unit_type = 'CAR_PARKING')), 0 
        ) 
                                                           PARKING_AMOUNT, 
               Nvl(XBH.total_rent, 0) 
               + Nvl( ( SELECT XBMD.installment_amount FROM 
        xxpm_booking_milestone_detail 
        XBMD 
               WHERE XBH.booking_id = XBMD.booking_hdr_id AND 
        XBMD.installment_type = 
        'SEC_DEP' 
               AND Trim(XLA.lease_number) = Nvl(p_lease_num, XLA.lease_number) ) 
        , 
        0) 
               + Nvl( ( SELECT SUM(total_rate) FROM xxpm_booking_detail WHERE 
        booking_id 
        = 
               XBH.booking_id AND unit_id IN ( SELECT unit_id FROM 
        xxpm_offer_detail 
        WHERE 
               unit_type = 
               'CAR_PARKING')), 0)                         NET_PAYABLE_AMOUNT, 
               (SELECT SUM(xbd.tax_amount) 
                FROM   xxpm_booking_detail xbd, 
                       xxpm_recommend_header XRH, 
                       xxpm_lease_agreement XLA 
                WHERE  XBH.booking_id = XBD.booking_id (+) 
                       AND XBH.booking_id = XRH.booking_id 
                       AND XRH.recommend_id = XLA.recommend_id(+) 
                       --AND XLA.LEASE_NUMBER = 'LA-1061';   
                       AND Trim(XLA.lease_number) = Nvl(p_lease_num, 
        XLA.lease_number)) 
                                                           VAT_AMOUNT, 
               CURSOR (SELECT XPB.build_name                     BUILDING_NAME, 
                              XPU.unit_name                      PREMISES_NO, 
                              XL.address1                        LOCATION_NAME, 
                              (SELECT 
                      xxpm_utility_pkg.Get_lookup_value_disp('UNIT_VIEW_TYPE', 
                      XPU.view_type) 
                      PREMISES_DESC 
                               FROM   xxpl_property_units XPU 
                               WHERE  XOD.unit_id = XPU.unit_id) PREMISES_DESC 
                       FROM   xxpm_booking_detail XBD, 
                              xxpm_offer_header XOH, 
                              xxpm_offer_detail XOD, 
                              xxpl_property_master XPM, 
                              xxpl_property_buildings XPB, 
                              xxpl_property_units XPU, 
                              xxpm_pl_discounts XPD, 
                              xxstg_locations XL, 
                              xxpm_lease_agreement XLA, 
                              xxpm_recommend_header XRH 
                       WHERE  XBH.booking_id = XBD.booking_id 
                              AND XBH.offer_hdr_id = XOH.offer_hdr_id 
                              AND XOH.offer_hdr_id = XOD.offer_hdr_id 
                              AND XOD.property_id = XPM.property_id 
                              AND XOD.building_id = XPB.build_id 
                              AND XOD.unit_id = XPU.unit_id 
                              AND XBD.discount_rate = XPD.discount_id(+) 
                              AND XOD.property_id = XBD.property_id 
                              AND XOD.building_id = XBD.building_id 
                              AND XOD.unit_id = XBD.unit_id 
                              AND XPM.location_id = XL.loc_id(+) 
                              AND XBH.booking_id = XRH.booking_id 
                              AND XRH.recommend_id = XLA.recommend_id(+) 
                              AND Trim(XLA.lease_number) = 
                                  Nvl(p_lease_num, XLA.lease_number)) 
                                  line, 
               CURSOR (SELECT xr.receipt_number, 
                              To_char(XR.receipt_date, 'DD/MM/YYYY') 
                              RECEIPT_DATE 
                              , 
                              Nvl(XR.recommended_amount, 0) 
                              AMOUNT, 
                              To_char(XR.receipt_date, 'DD/MM/YYYY') 
                              MATURITY_DATE, 
                              To_char(XR.pay_rec_date, 'DD/MM/YYYY') 
                              CHEQUE_RECOMMAND_DATE 
                              , 
                              Nvl(xbd.tax_amount, 0) 
                              TAX_AMOUNT, 
                              Nvl(( Nvl(xbd.tax_amount, 0) 
                                    + Nvl(XR.recommended_amount, 0) ), 0) 
                              TOTAL_AMOUNT 
                       FROM   xxpm_receipt xr, 
                              xxpm_receipt_details xrd, 
                              xxpm_recommend_header XRH, 
                              xxpm_booking_milestone_detail XBMD, 
                              xxpm_booking_header xbh, 
                              xxpm_booking_detail xbd, 
                              xxpm_lease_agreement XLA 
                       WHERE  XRH.booking_id = xr.source_func_ref_id(+) 
                              AND XR.receipt_id = XRD.receipt_id (+) 
                              AND XRD.booking_ms_dtl_id = 
                                  XBMD.booking_ms_dtl_id(+) 
                              AND XBH.booking_id(+) = XBMD.booking_hdr_id 
                              AND XBH.booking_id = XBD.booking_id (+) 
                              AND XRH.recommend_id = XLA.recommend_id(+) 
                              --and XRH.RECOMMEND_NUMBER = 'RC-1111'   
                              AND Trim(XLA.lease_number) = 
                                  Nvl(p_lease_num, XLA.lease_number) 
                       ORDER  BY xr.receipt_number)        PAYMENT_DETAILS, 
               xxpm_utility_pkg.Amount_in_words ((SELECT 
               SUM(Nvl(xbd.tax_amount, 0) 
                   + Nvl(XR.recommended_amount, 0)) AMOUNT 
                                                  FROM 
               xxpm_receipt xr, 
               xxpm_receipt_details xrd, 
               xxpm_recommend_header XRH, 
               xxpm_booking_milestone_detail XBMD, 
               xxpm_booking_detail xbd, 
               xxpm_booking_header XBH, 
               xxpm_lease_agreement XLA 
                                                  WHERE  XRH.booking_id = 
xr.source_func_ref_id(+) 
AND XR.receipt_id = 
    XRD.receipt_id (+) 
AND XRD.booking_ms_dtl_id 
    = 
XBMD.booking_ms_dtl_id(+) 
AND XBH.booking_id(+) = 
XBMD.booking_hdr_id 
AND XBH.booking_id = 
XBD.booking_id (+) 
AND XRH.recommend_id = 
XLA.recommend_id(+) 
--AND XLA.LEASE_NUMBER = 'LA-1061';   
AND Trim(XLA.lease_number) = 
Nvl( 
p_lease_num, 
XLA.lease_number)), 
'AED')                                      AMT_IN_WORDS 
FROM   xxpm_offer_header XOH, 
xxpm_booking_header XBH, 
xxpm_booking_customer XBC, 
xxstg_customer XC, 
xxstg_cust_contacts XCC, 
xxstg_cust_sites XCS, 
xxpm_recommend_header XRH, 
xxpm_lease_agreement XLA 
WHERE  XOH.offer_hdr_id = XBH.offer_hdr_id 
AND XBH.booking_id = XBC.booking_id 
AND XBC.cust_id_ar = xc.cust_id(+) 
AND XC.cust_id = XCS.cust_id(+) 
AND XCS.cust_id = XCC.cust_id(+) 
AND XCS.cust_site_id = XCC.cust_site_id(+) 
AND XBH.booking_id = XRH.booking_id 
AND XRH.recommend_id = XLA.recommend_id(+) 
AND XBC.cust_name != ' ' 
--AND XLA.LEASE_NUMBER   = 'LA-1061';   
AND Trim(XLA.lease_number) = Nvl(p_lease_num, XLA.lease_number); 

l_handle := dbms_xmlgen.Newcontext (l_query_ref); 

dbms_xmlgen.Setrowsettag (l_handle, 'PC'); 

dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD'); 

dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag); 

l_data_xml := dbms_xmlgen.Getxml (l_handle); 

RETURN ( l_data_xml ); 
EXCEPTION 
WHEN OTHERS THEN 
RETURN ( NULL ); 
END xxpm_tax_invoice; 
END xxpm_report_pkg;
