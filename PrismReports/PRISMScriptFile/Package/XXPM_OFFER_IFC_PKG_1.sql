--------------------------------------------------------
--  DDL for Package XXPM_OFFER_IFC_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_OFFER_IFC_PKG" 
AS
PROCEDURE XXDM_SALES_BOOKING_VAL(P_ERR_CODE      OUT VARCHAR2,
                          P_ERR_MSG       OUT varchar2);
PROCEDURE XXPM_OFFER_INSERT(P_ERR_CODE      OUT VARCHAR2,
                          P_ERR_MSG       OUT varchar2);
PROCEDURE XXDM_SALES_MILESTONES_VAL(P_ERR_CODE      OUT VARCHAR2,
                          P_ERR_MSG       OUT varchar2);
 PROCEDURE XXDM_OFFER_MILESTONES_INSERT(P_ERR_CODE      OUT VARCHAR2,
                          P_ERR_MSG       OUT varchar2);                   
end ;


--------------------------------------------------------
--  DDL for Package Body XXPM_OFFER_IFC_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_OFFER_IFC_PKG" 
AS
PROCEDURE XXDM_SALES_BOOKING_VAL(
    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
AS
  CURSOR cur_sales_bookings
  IS
    SELECT rowid,
    BUSINESS_UNIT,
      BOOKING_NUMBER,
      BOOKING_DATE,
      PAYMENT_PLAN,
      PRICELIST,
      BOOKING_TYPE,
      CURRENCY,
      BOOKING_FLAG,
      STATUS,
      DESCRIPTION,
      CUSTOMER,
      CUSTOMER_BILL_TO,
      PROPERTY,
      BUILDING,
      UNIT,
      UOM,
      BOOKING_AMOUNT,
      DISCOUNT_PERCENTAGE,
      DISCOUNT_AMOUNT,
      TAX_CODE,
      TAX_RATE,
      TAX_AMOUNT,
      STATUS_FLAG,
      ERR_DESC,
      ORG_ID,
      CUST_ID,
      BILL_TO_SITE_ID,
      PROPERTY_ID,
      BUILDING_ID,
      UNIT_ID,
      BOOKING_RATE
    FROM xxdm_sales_bookings_bkp_24
    WHERE NVL(status_flag ,'E') ='E';
  l_err_msg          VARCHAR2(500);
  l_status_flag      VARCHAR2(5);
  l_org_id           NUMBER;
  l_offer_type       VARCHAR2(50);
  l_lead_id          NUMBER;
  l_currency         VARCHAR2(5);
  l_tax_code         VARCHAR2(5);
  l_ms_hdr_id        NUMBER;
  l_booking_number   VARCHAR2(50);
  l_cust_id          NUMBER;
  l_customer_bill_to NUMBER;
  l_property_id      NUMBER;
  l_buid_id          NUMBER;
  l_unit_id          NUMBER;
  l_uom              VARCHAR2(50);
  l_pl_id            NUMBER;
--  l_ms_hdr_id        NUMBER;
  
BEGIN
  P_ERR_CODE :=0;
  P_ERR_MSG  :='SUCCESS';
  FOR i IN cur_sales_bookings
  LOOP
    l_err_msg     := NULL;
    l_status_flag := 'V';
l_cust_id := NULL;
l_customer_bill_to := NULL;
     l_property_id := NULL;
     l_buid_id := NULL;
     l_unit_id:= NULL;
     l_err_msg:= NULL;
     l_ms_hdr_id:= NULL;
    l_pl_id  := NULL;
    --==============================================================================
    ---------------------BUSINESS_UNIT Validations----------------------------------
    --==============================================================================
    l_org_id        := xxpm_dm_lib_pkg.get_org_id(i.business_unit);
    IF l_org_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..BUSINESS_UNIT';
      l_status_flag := 'E';
      l_org_id      := NULL;
    END IF;
    --==============================================================================
    ---------------------BOOKING_NUMBER Validations----------------------------------
    --==============================================================================
    BEGIN
      SELECT COUNT(*)
      INTO l_booking_number
      FROM xxpm_booking_header
      WHERE booking_number = i.booking_number;
      IF l_booking_number  > 0 THEN
        l_err_msg         := l_err_msg ||' BOOKING_NUMBER already exsist ';
        l_status_flag     := 'E';
      END IF;
    END;
    --==============================================================================
    ---------------------CURRENCY Validations----------------------------------
    --==============================================================================
    l_currency      :=xxpm_dm_lib_pkg.get_lookup('CURRENCY',i.currency);
    IF l_currency   IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..CURRENCY';
      l_status_flag := 'E';
      l_currency    := NULL;
    END IF;
    --==============================================================================
    ---------------------CUSTOMER NAME Validations----------------------------------
    --==============================================================================
    l_cust_id       :=xxpm_dm_lib_pkg.get_cust_id(i.customer);
    IF l_cust_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..CUSTOMER';
      l_status_flag := 'E';
      l_cust_id     := NULL;
    END IF;
    --==============================================================================
    ---------------------CUSTOMER_BILL_TO Validations----------------------------------
    --==============================================================================
    L_CUSTOMER_BILL_TO   :=XXPM_DM_LIB_PKG.GET_CUST_SITE_ID(I.CUST_ID ,I.BUSINESS_UNIT);
    IF l_customer_bill_to IS NULL THEN
      l_err_msg          := l_err_msg ||' invalid..CUSTOMER_BILL_TO';
      l_status_flag      := 'E';
      l_customer_bill_to := NULL;
    END IF;
    --==============================================================================
    ---------------------PROPERTY_NAME Validations----------------------------------
    --==============================================================================
    l_property_id   :=xxpm_dm_lib_pkg.get_property_id(i.property ,i.business_unit);
    IF l_property_id IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..PROPERTY';
      l_status_flag := 'E';
      l_property_id := NULL;
    END IF;
    --==============================================================================
    ---------------------BUILDING_NAME Validations----------------------------------
    --==============================================================================
    l_buid_id       :=xxpm_dm_lib_pkg.get_building_id(i.building ,i.property,i.business_unit);
    IF l_buid_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..BUILDING';
      l_status_flag := 'E';
      l_buid_id     := NULL;
    END IF;
    --==============================================================================
    ---------------------unit Validations----------------------------------
    --==============================================================================
    l_unit_id       :=xxpm_dm_lib_pkg.get_unit_id(i.unit,i.building ,i.property,i.business_unit);
    IF l_unit_id     IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..  unit';
      l_status_flag := 'E';
      l_unit_id     := NULL;
    END IF;
    --==============================================================================
    ---------------------UOM Validations----------------------------------
    --==============================================================================
    l_uom           :=xxpm_dm_lib_pkg.get_lookup('AREA_UOM',i.uom);
    IF l_uom        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..UOM';
      l_status_flag := 'E';
      l_uom         := NULL;
    END IF;
    
    --==============================================================================
    ---------------------MILESTONE_NAME Validations----------------------------------
    --==============================================================================
    
        l_ms_hdr_id           :=xxpm_dm_lib_pkg.get_payment_plan_id(i.PAYMENT_PLAN);
    IF l_ms_hdr_id        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..payment_plan';
      l_status_flag := 'E';
      l_ms_hdr_id         := NULL;
    END IF;
    
      --==============================================================================
    ---------------------PRICELIST Validations----------------------------------
    --==============================================================================
       l_pl_id           :=xxpm_dm_lib_pkg.get_pricelist_id(i.PRICELIST);
    IF l_pl_id        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..pricelist';
      l_status_flag := 'E';
      l_pl_id         := NULL;
    END IF;
    
          --==============================================================================
    ---------------------tax_code Validations----------------------------------
    --==============================================================================
    l_tax_code :=xxpm_dm_lib_pkg.get_lookupBy_name('TAX_TYPE',i.tax_code);
      IF l_tax_code        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..tax_code';
      l_status_flag := 'E';
      l_tax_code         := NULL;
    END IF;
    
    dbms_output.put_line('l_status_flag  '||l_status_flag );
    DBMS_OUTPUT.PUT_LINE('l_err_msg  '||L_ERR_MSG );
    
    UPDATE xxdm_sales_bookings
    SET org_id           =l_org_id ,
      cust_id            = l_cust_id ,
      bill_to_site_id    =l_customer_bill_to ,
      property_id        =l_property_id ,
      building_id        =l_buid_id ,
      unit_id            = l_unit_id,
      status_flag        =l_status_flag ,
      err_desc           = l_err_msg,
      ms_hdr_id          =l_ms_hdr_id,
      pl_id              = l_pl_id
    WHERE BOOKING_NUMBER = I.BOOKING_NUMBER
    and rowid=i.rowid;
    
  END LOOP;
  COMMIT;
  
EXCEPTION
WHEN OTHERS THEN
  P_ERR_CODE := SQLCODE;
  P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);
  
END XXDM_SALES_BOOKING_VAL;

PROCEDURE XXPM_OFFER_INSERT(
    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
AS
  CURSOR cur_sales_bookings
  IS
    SELECT rowid,
     BUSINESS_UNIT,
      BOOKING_NUMBER,
      BOOKING_DATE,
      PAYMENT_PLAN,
      PRICELIST,
      BOOKING_TYPE,
      CURRENCY,
      BOOKING_FLAG,
      STATUS,
      DESCRIPTION,
      CUSTOMER,
      CUSTOMER_BILL_TO,
      PROPERTY,
      BUILDING,
      UNIT,
      UOM,
      BOOKING_AMOUNT,
      DISCOUNT_PERCENTAGE,
      DISCOUNT_AMOUNT,
      TAX_CODE,
      TAX_RATE,
      TAX_AMOUNT,
      STATUS_FLAG,
      ERR_DESC,
      ORG_ID,
      CUST_ID,
      BILL_TO_SITE_ID,
      PROPERTY_ID,
      BUILDING_ID,
      UNIT_ID,
      BOOKING_RATE,
      MS_HDR_ID,
      PL_ID
      
    FROM xxdm_sales_bookings_bkp_24
    WHERE status_flag = 'V' and property='STE';
  l_offer_hdr_id NUMBER;
  l_offer_dtl_id NUMBER;
  l_func_id      NUMBER;

BEGIN
  P_ERR_CODE :=0;
  P_ERR_MSG  :='SUCCESS';

  FOR i IN cur_sales_bookings
  LOOP
    BEGIN
    L_OFFER_HDR_ID :=OFFER_HDR_ID_S.NEXTVAL;
    l_func_id      :=6;
    INSERT
    INTO xxpm_offer_header
      (
        offer_hdr_id,
        org_id,
        func_id,
        offer_number,
        offer_date,
        offer_from_date,
        offer_to_date,
        performed_by,
        revision_no,
        revision_date,
        revised_by,
        ms_hdr_id,
        pl_id,
        offer_type,
        lead_id,
        customer_id,
        cust_site_id,
        customer_name,
        customer_phone_no,
        customer_country,
        salesman_id,
        currency_code,
        checklist,
        terms_desc,
        object_version_number,
        offer_flag,
        tax_code,
        prev_booking_id,
        status,
        description,
        flow_status,
        flow_level,
        flow_with,
        user_grp_id,
        attribute_category,
        attribute1,
        attribute2,
        attribute3,
        attribute4,
        attribute5,
        attribute6,
        attribute7,
        attribute8,
        attribute9,
        attribute10,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date,
        last_update_login,
        offer_end_date,
        USAGE,
        lead_source_channel,
        lead_source_name,
        vend_id,
        vend_site_id,
        vend_contract_no,
        property_id,
        email_id,
        lease_agreement_id,
        car_park_lease_agre_id,
        cust_accept,
        MIGRATED_DATA
      )
      VALUES
      (
        l_offer_hdr_id,    --                            OFFER_HDR_ID,
        i.org_id,          --                ORG_ID,
        l_func_id ,        --                     FUNC_ID,
        i.BOOKING_NUMBER,  --    OFFER_NUMBER,
        i.booking_date,    --    OFFER_DATE,
        NULL,              --    OFFER_FROM_DATE,
        NULL,              --    OFFER_TO_DATE,
        NULL,              --    PERFORMED_BY,
        NULL,              --    REVISION_NO,
        NULL,              --    REVISION_DATE,
        NULL,              --    REVISED_BY,
        i.MS_HDR_ID,              --    MS_HDR_ID,
        i.PL_ID,              --    PL_ID,
        NULL,              --    OFFER_TYPE,
        NULL,              --    LEAD_ID,
        i.cust_id,         --    CUSTOMER_ID,
        i.bill_to_site_id ,--    CUST_SITE_ID,
        NULL,              --    CUSTOMER_NAME,
        NULL,              --    CUSTOMER_PHONE_NO,
        NULL,              --    CUSTOMER_COUNTRY,
        NULL,              --    SALESMAN_ID,
        i.currency ,       --    CURRENCY_CODE,
        NULL,              --    CHECKLIST,
        NULL,              --    TERMS_DESC,
        NULL,              --    OBJECT_VERSION_NUMBER,
        'N',               --    OFFER_FLAG,
        i.tax_code,        --    TAX_CODE,
        NULL,              --    PREV_BOOKING_ID,
        'BK',              --    STATUS,
        i.DESCRIPTION,              --    DESCRIPTION,
        NULL,              --    FLOW_STATUS,
        NULL,              --    FLOW_LEVEL,
        NULL,              --    FLOW_WITH,
        NULL,              --    USER_GRP_ID,
        NULL,              --    ATTRIBUTE_CATEGORY,
        NULL,              --    ATTRIBUTE1,
        NULL,              --    ATTRIBUTE2,
        NULL,              --    ATTRIBUTE3,
        NULL,              --    ATTRIBUTE4,
        NULL,              --    ATTRIBUTE5,
        NULL,              --    ATTRIBUTE6,
        NULL,              --    ATTRIBUTE7,
        NULL,              --    ATTRIBUTE8,
        NULL,              --    ATTRIBUTE9,
        NULL,              --    ATTRIBUTE10,
        NULL,              --    CREATED_BY,
        NULL,              --    CREATION_DATE,
        NULL,              --    LAST_UPDATED_BY,
        NULL,              --    LAST_UPDATE_DATE,
        NULL,              --    LAST_UPDATE_LOGIN,
        NULL,              --    OFFER_END_DATE,
        'S',               --    USAGE,
        NULL,              --    LEAD_SOURCE_CHANNEL,
        NULL,              --    LEAD_SOURCE_NAME,
        NULL,              --    VEND_ID,
        NULL,              --    VEND_SITE_ID,
        NULL,              --    VEND_CONTRACT_NO,
        i.property_id,     --    PROPERTY_ID,
        NULL,              --    EMAIL_ID,
        NULL,              --    LEASE_AGREEMENT_ID,
        NULL,              --    CAR_PARK_LEASE_AGRE_ID,
        NULL,               --    CUST_ACCEPT
        NULL                 --      MIGRATED_DATA
      );
    ----insert into detail
    l_offer_dtl_id :=offer_dtl_id_s.nextval;

    INSERT
    INTO xxpm_offer_detail
      (
        offer_dtl_id,
        offer_hdr_id,
        property_id,
        building_id,
        unit_id,
        uom,
        quantity,
        base_rate,
        offer_amount,
        pl_mod_id,
        disc_pct,
        disc_amount,
        tax_code,
        tax_rate,
        tax_amount,
        attribute_category,
        attribute1,
        attribute2,
        attribute3,
        attribute4,
        attribute5,
        attribute6,
        attribute7,
        attribute8,
        attribute9,
        attribute10,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date,
        last_update_login
      )
      VALUES
      (
        l_offer_dtl_id ,      --    OFFER_DTL_ID,
        l_offer_hdr_id,       --    OFFER_HDR_ID,
        i.property_id,        --    PROPERTY_ID,
        i.building_id,        --    BUILDING_ID,
        i.unit_id,            --    UNIT_ID,
        i.uom,                --    UOM,
        NULL,                 --    QUANTITY,
        i.booking_rate,       --    BASE_RATE,
        i.booking_amount,     --    OFFER_AMOUNT,
        NULL,                 --    PL_MOD_ID,
        i.discount_percentage,--    DISC_PCT,
        i.discount_amount,    --    DISC_AMOUNT,
        i.tax_code,           --    TAX_CODE,
        i.tax_rate,           --    TAX_RATE,
        i.tax_amount,         --    TAX_AMOUNT,
        NULL,                 --    ATTRIBUTE_CATEGORY,
        NULL,                 --    ATTRIBUTE1,
        NULL,                 --    ATTRIBUTE2,
        NULL,                 --    ATTRIBUTE3,
        NULL,                 --    ATTRIBUTE4,
        NULL,                 --    ATTRIBUTE5,
        NULL,                 --    ATTRIBUTE6,
        NULL,                 --    ATTRIBUTE7,
        NULL,                 --    ATTRIBUTE8,
        NULL,                 --    ATTRIBUTE9,
        NULL,                 --    ATTRIBUTE10,
        NULL,                 --    CREATED_BY,
        NULL,                 --    CREATION_DATE,
        NULL,                 --    LAST_UPDATED_BY,
        NULL,                 --    LAST_UPDATE_DATE,
        NULL                  --    LAST_UPDATE_LOGIN
      );

    UPDATE xxdm_sales_bookings
    SET status_flag      ='P'
    WHERE booking_number = i.booking_number;
     EXCEPTION
    WHEN OTHERS THEN
        P_ERR_CODE := SQLCODE;
        P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);
        UPDATE xxdm_sales_bookings set STATUS_FLAG='F',ERR_DESC=P_ERR_CODE || '-' || P_ERR_MSG
        WHERE booking_number = i.booking_number
        AND rowid  = i.rowid;
    END;
  END LOOP;
  COMMIT;

EXCEPTION
WHEN OTHERS THEN
  P_ERR_CODE := SQLCODE;
  P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);
  
END XXPM_OFFER_INSERT;

PROCEDURE XXDM_SALES_MILESTONES_VAL(
    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
AS
  CURSOR cur_sales_miles
  IS
SELECT sm.rowid,
      SM.BOOKING_NUMBER,
      SM.MILESTONE_TYPE,
      SM.INSTALLMENT_TYPE,
      SM.INSTALLMENT_PERCENATGE,
      SM.INSTALLMENT_AMOUNT,
      SM.UOM,
      SM.QUANTITY,
      SM.RATE,
      SM.CHARGE_TYPE,
      SM.PAYMENT_TERM,
      SM.REMARKS,
      SM.DUE_DAYS,
      SM.DUE_DAYS_FROM,
      SM.DUE_DATE,
      SM.INVOICE_NUMBER,
      SM.STATUS_FLAG,
      SM.ERR_DESC,
      SM.MILESTONE_TYPE_NAME,
      SM.INSTALLMENT_TYPE_NAME,
      SM.CHARGE_TYPE_NAME,
      SM.PAYMENT_TERM_NAME
    FROM  XXDM_SALES_MILESTONES_EAST2 SM 
    WHERE NVL(sm.status_flag,'E')='E';
  l_err_msg          VARCHAR2(500);
  l_status_flag      VARCHAR2(5);
  l_milestone_type   VARCHAR2(50);
  l_installment_type VARCHAR2(50);
  l_uom              VARCHAR2(50);
  l_charge_type      VARCHAR2(100);
  L_PAYMENT_TERM     VARCHAR2(50);
  l_offer_HDR_ID     NUMBER;

BEGIN
  P_ERR_CODE :=0;
  P_ERR_MSG  :='SUCCESS';

  FOR i IN cur_sales_miles
  LOOP
    l_err_msg     := NULL;
    l_status_flag := 'V';

    --==============================================================================
    ---------------------OFFER_NUMBER Validations----------------------------------
    --==============================================================================
    BEGIN
      SELECT OFFER_HDR_ID
      INTO l_offer_HDR_ID
      FROM xxpm_offer_header
      WHERE OFFER_NUMBER = I.BOOKING_NUMBER and rownum=1;
    EXCEPTION
    WHEN OTHERS THEN
      L_ERR_MSG      := L_ERR_MSG ||' invalid..booking_number ';
      L_STATUS_FLAG  := 'E';
      l_offer_HDR_ID := NULL;
    END;

   --==============================================================================
    ---------------------MILESTONE_TYPE Validations----------------------------------
    --==============================================================================

    l_milestone_type    :=xxpm_dm_lib_pkg.get_lookupBy_name('MILESTONE_TYPE',i.milestone_type_name);
    IF l_milestone_type IS NULL THEN
      l_err_msg         := l_err_msg ||' not a valid   MILESTONE_TYPE';
      l_status_flag     := 'E';
      l_milestone_type  := NULL;
    END IF;
    
       --==============================================================================
    ---------------------MILESTONE_INSTALLMENT Validations----------------------------------
    --==============================================================================
    
    l_installment_type    :=xxpm_dm_lib_pkg.get_lookup('MILESTONE_INSTALLMENT',i.installment_type_name);
    IF l_installment_type IS NULL THEN
      l_err_msg           := l_err_msg ||' invalid..MILESTONE_INSTALLMEN';
      l_status_flag       := 'E';
      l_installment_type  := NULL;
    END IF;
    
       --==============================================================================
    ---------------------AREA_UOM Validations----------------------------------
    --==============================================================================
    
    if i.uom is not null then
    l_uom           :=xxpm_dm_lib_pkg.get_lookupBy_name('AREA_UOM',i.uom);
    IF l_uom        IS NULL THEN
      l_err_msg     := l_err_msg ||' invalid..AREA_UOM';
      l_status_flag := 'E';
      l_uom         := NULL;
    END IF;
    end if;
       --==============================================================================
    ---------------------CHARGE_TYPE Validations----------------------------------
    --==============================================================================
    
    
    
    l_charge_type    :=xxpm_dm_lib_pkg.get_lookupBy_name('CHARGE_TYPE',i.CHARGE_TYPE_NAME);
    IF l_charge_type IS NULL THEN
      l_err_msg      := l_err_msg ||' invalid..CHARGE_TYPE';
      l_status_flag  := 'E';
      l_charge_type  := NULL;
    END IF;
    
       --==============================================================================
    ---------------------PAYMENT_TERM Validations----------------------------------
    --==============================================================================
    
    
    
    L_PAYMENT_TERM    :=XXPM_DM_LIB_PKG.GET_PAYMENT_TERM(I.PAYMENT_TERM_NAME);
    IF l_payment_term IS NULL THEN
      l_err_msg       := l_err_msg ||' invalid..PAYMENT_TERM';
      l_status_flag   := 'E';
      l_payment_term  := NULL;
    END IF;
    
    
    
    DBMS_OUTPUT.PUT_LINE('l_status_flag  '||L_STATUS_FLAG );
    dbms_output.put_line('l_err_msg  '||l_err_msg );
    
    
    UPDATE XXDM_SALES_MILESTONES_EAST2
    SET INSTALLMENT_TYPE =l_installment_type ,
      MILESTONE_TYPE     = l_milestone_type ,
      CHARGE_TYPE        =L_CHARGE_TYPE ,
      PAYMENT_TERM       =L_PAYMENT_TERM ,
      OFFER_HDR_ID       =l_OFFER_HDR_ID,
      STATUS_FLAG        = L_STATUS_FLAG ,
      ERR_DESC           =l_err_msg
    WHERE booking_number = i.booking_number
    AND rowid            =i.rowid;
 
  END LOOP;
  COMMIT;

EXCEPTION
WHEN OTHERS THEN
  P_ERR_CODE := SQLCODE;
  P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);

END XXDM_SALES_MILESTONES_VAL;



PROCEDURE XXDM_OFFER_MILESTONES_INSERT(
    P_ERR_CODE OUT VARCHAR2,
    P_ERR_MSG OUT VARCHAR2)
AS
  CURSOR cur_sales_milestones
  IS
    SELECT rowid,
      BOOKING_NUMBER,
      MILESTONE_TYPE,
      INSTALLMENT_TYPE,
      INSTALLMENT_PERCENATGE,
      INSTALLMENT_AMOUNT,
      UOM,
      QUANTITY,
      RATE,
      CHARGE_TYPE,
      PAYMENT_TERM,
      REMARKS,
      DUE_DAYS,
      DUE_DAYS_FROM,
      DUE_DATE,
      INVOICE_NUMBER,
      STATUS_FLAG,
      ERR_DESC,
      MILESTONE_TYPE_NAME,
      INSTALLMENT_TYPE_NAME,
      CHARGE_TYPE_NAME,
      PAYMENT_TERM_NAME,
      OFFER_HDR_ID
    FROM XXDM_SALES_MILESTONES_EAST2
    WHERE STATUS_FLAG = 'V' ;

BEGIN

  P_ERR_CODE :=0;
  P_ERR_MSG  :='SUCCESS';

  FOR I IN CUR_SALES_MILESTONES
  LOOP
  BEGIN
    INSERT
    INTO xxpm_offer_milestone_detail
      (
        OFFER_MS_DTL_ID,
        OFFER_HDR_ID,
        MS_DTL_ID,
        PL_MOD_ID,
        SEQ_NUMBER,
        INSTALLMENT_TYPE,
        INSTALLMENT_PCT,
        INSTALLMENT_AMOUNT,
        CHARGE_TYPE,
        PAYMENT_TERM,
        REMARKS,
        DUE_DAYS,
        DUE_DAYS_FROM,
        DUE_DATE,
        ATTRIBUTE_CATEGORY,
        ATTRIBUTE1,
        ATTRIBUTE2,
        ATTRIBUTE3,
        ATTRIBUTE4,
        ATTRIBUTE5,
        ATTRIBUTE6,
        ATTRIBUTE7,
        ATTRIBUTE8,
        ATTRIBUTE9,
        ATTRIBUTE10,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        MILESTONE_TYPE,
        UOM,
        QUANTITY,
        RATE,
        WAVE_OFF,
        INSTALLMENT_METHOD,
        INSTALLMENT_EVENT,
        PERIOD_OCCURENCE,
        PERIOD_VALUES,
        PERIOD_DURATION,
        INCLUDED_IN_RATE
      )
      VALUES
      (
        OFFER_MS_DTL_ID.NEXTVAL,
        i.OFFER_HDR_ID,
        NULL,
        NULL,
        NULL,
        i.INSTALLMENT_TYPE,
        i.INSTALLMENT_PERCENATGE,
        I.INSTALLMENT_AMOUNT,
        I.CHARGE_TYPE,
        i.PAYMENT_TERM,
        i.REMARKS,
        i.DUE_DAYS,
        NULL,
        i.DUE_DATE,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'anonymous',
        SYSDATE,
        'anonymous',
        SYSDATE,
        'anonymous',
        i.MILESTONE_TYPE,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
      );

    UPDATE XXDM_SALES_MILESTONES_EAST2
    SET STATUS_FLAG      ='P'
    WHERE booking_number = i.booking_number
    AND rowid            = i.rowid;
    
    
    update xxpm_offer_header   set  MIGRATED_DATA ='I' where  offer_number =i.booking_number;
    
    EXCEPTION
    WHEN OTHERS THEN
        P_ERR_CODE := SQLCODE;
        P_ERR_MSG  := SUBSTR (SQLERRM, 1, 2000);
        UPDATE XXDM_SALES_MILESTONES_EAST2 set STATUS_FLAG='F',ERR_DESC=P_ERR_CODE || '-' || P_ERR_MSG
        WHERE booking_number = i.booking_number
        AND rowid  = i.rowid;
    END;
    END LOOP; 
  COMMIT;
   
END XXDM_OFFER_MILESTONES_INSERT;

  
END xxpm_offer_ifc_pkg;
