CREATE OR REPLACE PACKAGE "XXPM_PRISM"
IS

 
 procedure revise_milestone (p_mshdr_id          in       number,
                            p_user_id          in       varchar2,
                            p_err_code         out      varchar2,
                            p_err_msg          out      varchar2 )  ;
                            
 PROCEDURE xxpm_approval_upd_response(
    p_func_id    IN NUMBER,
    p_ref_id     IN NUMBER, -- pk of respective function
    p_table_name IN VARCHAR2,
    p_err_code OUT VARCHAR2,
    p_err_msg OUT VARCHAR2)  ;  
    
function getOtherCharge_amt(p_offer_id in number,p_type in varchar2)
return number;

PROCEDURE XXPM_PROC_OFFER_REVISION(
    I_OFFER_ID   IN NUMBER,
    I_REVISED_BY IN VARCHAR2);
      
END XXPM_PRISM;
/


CREATE OR REPLACE PACKAGE BODY "XXPM_PRISM"
IS
PROCEDURE revise_milestone(
    p_mshdr_id IN NUMBER,
    p_user_id  IN VARCHAR2,
    p_err_code OUT VARCHAR2,
    p_err_msg OUT VARCHAR2 )
IS
  CURSOR c1
  IS
    SELECT MS_HDR_ID ,
      MILESTONE_NAME ,
      MILESTONE_NAME_TL ,
      MILESTONE_NUMBER ,
      MILESTONE_SHORTCODE ,
      MILESTONE_DATE ,
      FUNC_ID ,
      ORG_ID ,
      PROJECT_ID ,
      MILESTONE_TYPE ,
      USAGE ,
      NVL(REVISION_NO, 0)REVISION_NO ,
      REVISION_DATE ,
      REVISED_BY ,
      DESCRIPTION ,
      START_DATE ,
      END_DATE ,
      ACTIVE_YN ,
      STATUS ,
      FLOW_STATUS ,
      FLOW_LEVEL ,
      FLOW_WITH ,
      USER_GRP_ID ,
      ATTRIBUTE_CATEGORY ,
      ATTRIBUTE1 ,
      ATTRIBUTE2 ,
      ATTRIBUTE3 ,
      ATTRIBUTE4 ,
      ATTRIBUTE5 ,
      ATTRIBUTE6 ,
      ATTRIBUTE7 ,
      ATTRIBUTE8 ,
      ATTRIBUTE9 ,
      ATTRIBUTE10 ,
      CREATED_BY ,
      CREATION_DATE ,
      LAST_UPDATED_BY ,
      LAST_UPDATE_DATE ,
      LAST_UPDATE_LOGIN
    FROM XXPM_MILESTONE_HDR
    WHERE MS_HDR_ID = p_mshdr_id ;
  CURSOR c2
  IS
    SELECT MS_DTL_ID ,
      MS_HDR_ID ,
      SEQ_NUMBER ,
      INSTALLMENT_TYPE ,
      INSTALLMENT_PCT ,
      CHARGE_TYPE ,
      PAYMENT_TERM ,
      REMARKS ,
      DUE_DAYS ,
      DUE_DAYS_FROM ,
      PROJ_MS_ID ,
      DUE_DATE ,
      NVL(REVISION, 0)REVISION ,
      REVISION_DATE ,
      REVISED_BY ,
      ATTRIBUTE_CATEGORY ,
      ATTRIBUTE1 ,
      ATTRIBUTE2 ,
      ATTRIBUTE3 ,
      ATTRIBUTE4 ,
      ATTRIBUTE5 ,
      ATTRIBUTE6 ,
      ATTRIBUTE7 ,
      ATTRIBUTE8 ,
      ATTRIBUTE9 ,
      ATTRIBUTE10 ,
      CREATED_BY ,
      CREATION_DATE ,
      LAST_UPDATED_BY ,
      LAST_UPDATE_DATE ,
      LAST_UPDATE_LOGIN ,
      INSTALLMENT_METHOD ,
      PERIOD_OCCURENCE ,
      PERIOD_VALUES ,
      PERIOD_DURATION ,
      INSTALLMENT_EVENT
    FROM XXPM_MILESTONE_DTL
    WHERE MS_HDR_ID = p_mshdr_id ;
BEGIN
  p_err_code := '0';
  p_err_msg  := 'Success';
  -- Create History Record for Header
  FOR c IN c1
  LOOP
    INSERT
    INTO XXPM_MILESTONE_HDR_H
      (
        MS_HDR_ID_H ,
        MS_HDR_ID ,
        MILESTONE_NAME ,
        MILESTONE_NAME_TL ,
        MILESTONE_NUMBER ,
        MILESTONE_SHORTCODE ,
        MILESTONE_DATE ,
        FUNC_ID ,
        ORG_ID ,
        PROJECT_ID ,
        MILESTONE_TYPE ,
        USAGE ,
        REVISION_NO ,
        REVISION_DATE ,
        REVISED_BY ,
        DESCRIPTION ,
        START_DATE ,
        END_DATE ,
        ACTIVE_YN ,
        STATUS ,
        FLOW_STATUS ,
        FLOW_LEVEL ,
        FLOW_WITH ,
        USER_GRP_ID ,
        ATTRIBUTE_CATEGORY ,
        ATTRIBUTE1 ,
        ATTRIBUTE2 ,
        ATTRIBUTE3 ,
        ATTRIBUTE4 ,
        ATTRIBUTE5 ,
        ATTRIBUTE6 ,
        ATTRIBUTE7 ,
        ATTRIBUTE8 ,
        ATTRIBUTE9 ,
        ATTRIBUTE10 ,
        CREATED_BY ,
        CREATION_DATE ,
        LAST_UPDATED_BY ,
        LAST_UPDATE_DATE ,
        LAST_UPDATE_LOGIN
      )
      VALUES
      (
        --
        XXPM_MS_HDR_H_ID_S.NEXTVAL ,
        c.MS_HDR_ID ,
        c.MILESTONE_NAME ,
        c.MILESTONE_NAME_TL ,
        c.MILESTONE_NUMBER ,
        c.MILESTONE_SHORTCODE ,
        c.MILESTONE_DATE ,
        c.FUNC_ID ,
        c.ORG_ID ,
        c.PROJECT_ID ,
        c.MILESTONE_TYPE ,
        c.USAGE ,
        c.REVISION_NO ,
        c.REVISION_DATE ,
        p_user_id, --        c.REVISED_BY ,
        c.DESCRIPTION ,
        c.START_DATE ,
        c.END_DATE ,
        c.ACTIVE_YN ,
        c.STATUS ,
        c.FLOW_STATUS ,
        c.FLOW_LEVEL ,
        c.FLOW_WITH ,
        c.USER_GRP_ID ,
        c.ATTRIBUTE_CATEGORY ,
        c.ATTRIBUTE1 ,
        c.ATTRIBUTE2 ,
        c.ATTRIBUTE3 ,
        c.ATTRIBUTE4 ,
        c.ATTRIBUTE5 ,
        c.ATTRIBUTE6 ,
        c.ATTRIBUTE7 ,
        c.ATTRIBUTE8 ,
        c.ATTRIBUTE9 ,
        c.ATTRIBUTE10 ,
        c.CREATED_BY ,
        c.CREATION_DATE ,
        c.LAST_UPDATED_BY ,
        c.LAST_UPDATE_DATE ,
        c.LAST_UPDATE_LOGIN
      ) ;
    -- Create History Record for Details
    FOR d IN c2
    LOOP
      INSERT
      INTO XXPM_MILESTONE_DTL_H
        (
          MS_DTL_ID_H ,
          MS_DTL_ID ,
          MS_HDR_ID ,
          SEQ_NUMBER ,
          INSTALLMENT_TYPE ,
          INSTALLMENT_PCT ,
          CHARGE_TYPE ,
          PAYMENT_TERM ,
          REMARKS ,
          DUE_DAYS ,
          DUE_DAYS_FROM ,
          PROJ_MS_ID ,
          DUE_DATE ,
          REVISION ,
          REVISION_DATE ,
          REVISED_BY ,
          ATTRIBUTE_CATEGORY ,
          ATTRIBUTE1 ,
          ATTRIBUTE2 ,
          ATTRIBUTE3 ,
          ATTRIBUTE4 ,
          ATTRIBUTE5 ,
          ATTRIBUTE6 ,
          ATTRIBUTE7 ,
          ATTRIBUTE8 ,
          ATTRIBUTE9 ,
          ATTRIBUTE10 ,
          CREATED_BY ,
          CREATION_DATE ,
          LAST_UPDATED_BY ,
          LAST_UPDATE_DATE ,
          LAST_UPDATE_LOGIN ,
          INSTALLMENT_METHOD ,
          PERIOD_OCCURENCE ,
          PERIOD_VALUES ,
          PERIOD_DURATION ,
          INSTALLMENT_EVENT
        )
        VALUES
        (
          XXPM_MS_DTL_H_ID_S.NEXTVAL ,
          d.MS_DTL_ID ,
          d.MS_HDR_ID ,
          d.SEQ_NUMBER ,
          d.INSTALLMENT_TYPE ,
          d.INSTALLMENT_PCT ,
          d.CHARGE_TYPE ,
          d.PAYMENT_TERM ,
          d.REMARKS ,
          d.DUE_DAYS ,
          d.DUE_DAYS_FROM ,
          d.PROJ_MS_ID ,
          d.DUE_DATE ,
          d.REVISION ,
          d.REVISION_DATE ,
          p_user_id ,--          d.REVISED_BY ,
          d.ATTRIBUTE_CATEGORY ,
          d.ATTRIBUTE1 ,
          d.ATTRIBUTE2 ,
          d.ATTRIBUTE3 ,
          d.ATTRIBUTE4 ,
          d.ATTRIBUTE5 ,
          d.ATTRIBUTE6 ,
          d.ATTRIBUTE7 ,
          d.ATTRIBUTE8 ,
          d.ATTRIBUTE9 ,
          d.ATTRIBUTE10 ,
          d.CREATED_BY ,
          d.CREATION_DATE ,
          d.LAST_UPDATED_BY ,
          d.LAST_UPDATE_DATE ,
          d.LAST_UPDATE_LOGIN ,
          d.INSTALLMENT_METHOD ,
          d.PERIOD_OCCURENCE ,
          d.PERIOD_VALUES ,
          d.PERIOD_DURATION ,
          d.INSTALLMENT_EVENT
        ) ;
    END LOOP ;
  END LOOP ;
  -- Update Revision Number and Approved Status
  UPDATE XXPM_MILESTONE_HDR
  SET REVISION_NO    = NVL(REVISION_NO, 0) + 1,
    STATUS           = 'REV',
    REVISION_DATE    = sysdate,
    REVISED_BY       = p_user_id,
    LAST_UPDATED_BY  = p_user_id,
    LAST_UPDATE_DATE = sysdate
  WHERE MS_HDR_ID    = p_mshdr_id ;
  UPDATE XXPM_MILESTONE_DTL
  SET REVISION       = NVL(REVISION, 0) + 1,
    REVISION_DATE    = sysdate,
    REVISED_BY       = p_user_id,
    LAST_UPDATED_BY  = p_user_id,
    LAST_UPDATE_DATE = sysdate
  WHERE MS_HDR_ID    = p_mshdr_id ;
  COMMIT ;
EXCEPTION
WHEN OTHERS THEN
  p_err_code := SQLCODE;
  p_err_msg  := SUBSTR (sqlerrm, 1, 2000);
  RETURN;
END revise_milestone;
FUNCTION get_data(
    p_column_name    IN VARCHAR2,
    p_table_name     IN VARCHAR2,
    p_where_condtion IN VARCHAR2,
    p_value          IN VARCHAR2)
  RETURN VARCHAR2
IS
  l_sql   VARCHAR2(1000);
  l_value VARCHAR2(500);
BEGIN
  l_sql := 'select ' || p_column_name || ' from ' || p_table_name || ' where 1 = 1 ' || ' and ' || p_where_condtion || ' = ' || '''' || p_value || '''' ;
  EXECUTE immediate L_SQL INTO L_VALUE;
  RETURN l_value;
END GET_DATA;
PROCEDURE xxpm_approval_upd_response(
    p_func_id    IN NUMBER,
    p_ref_id     IN NUMBER, -- pk of respective function
    p_table_name IN VARCHAR2,
    p_err_code OUT VARCHAR2,
    p_err_msg OUT VARCHAR2)
AS
  l_booking_type   VARCHAR2(10);
  l_offer_hdr_id   NUMBER;
  L_UNIT_ID        NUMBER;
  L_BLOCK_TYPE     VARCHAR2(10);
  L_CANCEL_TYPE    VARCHAR2(10);
  L_BOOKING_HDR_ID NUMBER;
  l_count          NUMBER;
  L_ORG_ID         NUMBER;
  L_property_id    NUMBER;
  l_build_id       NUMBER;
  l_booking_number  VARCHAR2(50);
BEGIN
  p_err_code            := '0';
  p_err_msg             := 'Success';
  IF upper(p_table_name) ='XXPM_BOOKING_HEADER' THEN
    BEGIN
      SELECT BOOKING_TYPE,
        OFFER_HDR_ID,
        org_id, booking_number
      INTO l_booking_type,
        l_offer_hdr_id,
        l_org_id,l_booking_number
      FROM XXPM_BOOKING_HEADER
      WHERE BOOKING_HDR_ID = p_ref_id
      AND FUNC_ID          =p_func_id;
    EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('exception in getting OFFER_HDR_ID ,BOOKING_TYPE ');
      p_err_msg := 'invalid BOOKING_TYPE,OFFER_HDR_ID  ';
    END;
    BEGIN
      SELECT DISTINCT UNIT_ID,
        PROPERTY_ID,
        BUILDING_ID
      INTO l_unit_id,
        L_property_id,
        l_build_id
      FROM XXPM_BOOKING_detail
      WHERE BOOKING_HDR_ID =p_ref_id;
    EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('exception in getting UNIT_ID  ');
      p_err_msg:= p_err_msg|| 'invalid UNIT_ID ';
    END;
    IF l_booking_type ='SB' OR l_booking_type ='BL' THEN
      UPDATE XXPM_BOOKING_HEADER
      SET BOOKING_STAGE    ='BD',
        STATUS             = 'APR'
      WHERE BOOKING_HDR_ID =p_ref_id
      AND FUNC_ID          =p_func_id;
      UPDATE xxpm_offer_header SET status ='BK' WHERE OFFER_HDR_ID=l_offer_hdr_id;
      UPDATE XXPM_PROPERTY_UNITS SET status ='BOOK' WHERE UNIT_ID =L_UNIT_ID;
    END IF;
    IF l_booking_type ='BL' THEN
      UPDATE XXPM_BLOCK_HEADER SET status ='BO' WHERE OFFER_HDR_ID =l_offer_hdr_id;
    END IF;
    XXPM_ACTIVITY_PKG.XXPM_PROC_ACTIVITY( SOURCE_FUNC_ID => p_func_id, SOURCE_FUNC_REF_ID => p_ref_id, ORG_ID => l_ORG_ID, PROPERTY_ID => L_property_id, BUILD_ID => l_build_id, UNIT_ID => l_unit_id, ACTIVITY_TYPE => 'BKSB', DESCRIPTION => l_booking_number, CREATED_BY => '' );
  END IF;
  IF UPPER(P_TABLE_NAME) ='XXPM_BLOCK_HEADER' THEN
    SELECT BLOCK_TYPE,
      OFFER_HDR_ID
    INTO L_BLOCK_TYPE,
      L_OFFER_HDR_ID
    FROM XXPM_BLOCK_HEADER
    WHERE BLOCK_ID =P_REF_ID
    AND FUNC_ID    =P_FUNC_ID;
    SELECT UNIT_ID INTO L_UNIT_ID FROM XXPM_BLOCK_DETAIL WHERE BLOCK_ID =P_REF_ID;
    IF L_BLOCK_TYPE = 'ROF' THEN
      UPDATE XXPM_BLOCK_HEADER
      SET STATUS     ='APR'
      WHERE BLOCK_ID =P_REF_ID
      AND FUNC_ID    =P_FUNC_ID;
      UPDATE XXPM_OFFER_HEADER SET STATUS ='BLK' WHERE OFFER_HDR_ID=L_OFFER_HDR_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='ROF' WHERE UNIT_ID =L_UNIT_ID;
    elsif L_BLOCK_TYPE = 'BFF' THEN
      UPDATE XXPM_BLOCK_HEADER
      SET STATUS     ='APR'
      WHERE BLOCK_ID =P_REF_ID
      AND FUNC_ID    =P_FUNC_ID;
      UPDATE XXPM_OFFER_HEADER SET STATUS ='BLK' WHERE OFFER_HDR_ID=L_OFFER_HDR_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='BFF' WHERE UNIT_ID =L_UNIT_ID;
    elsif L_BLOCK_TYPE = 'QR' THEN
      UPDATE XXPM_BLOCK_HEADER
      SET STATUS     ='APR'
      WHERE BLOCK_ID =P_REF_ID
      AND FUNC_ID    =P_FUNC_ID;
      UPDATE XXPM_OFFER_HEADER SET STATUS ='BLK' WHERE OFFER_HDR_ID=L_OFFER_HDR_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='QR' WHERE UNIT_ID =L_UNIT_ID;
    elsif L_BLOCK_TYPE = 'SB' THEN
      UPDATE XXPM_BLOCK_HEADER
      SET STATUS     ='APR'
      WHERE BLOCK_ID =P_REF_ID
      AND FUNC_ID    =P_FUNC_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='SB' WHERE UNIT_ID =L_UNIT_ID;
    elsif L_BLOCK_TYPE = 'SBT' THEN
      UPDATE XXPM_BLOCK_HEADER
      SET STATUS     ='APR'
      WHERE BLOCK_ID =P_REF_ID
      AND FUNC_ID    =P_FUNC_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='SBT' WHERE UNIT_ID =L_UNIT_ID;
    elsif L_BLOCK_TYPE = 'MB' THEN
      UPDATE XXPM_BLOCK_HEADER
      SET STATUS     ='APR'
      WHERE BLOCK_ID =P_REF_ID
      AND FUNC_ID    =P_FUNC_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='MNG_BLOCK' WHERE UNIT_ID =L_UNIT_ID;
    END IF;
  END IF;
  --
  IF UPPER(P_TABLE_NAME) ='XXPM_REGISTRATION' THEN
    UPDATE XXPM_REGISTRATION
    SET STATUS    ='APR'
    WHERE REGN_ID =P_REF_ID
    AND FUNC_ID   =P_FUNC_ID;
  END IF;
  --
  IF UPPER(P_TABLE_NAME) ='XXPM_EXTEN_CANCEL' THEN
    SELECT BOOKING_ID
    INTO l_booking_HDR_ID
    FROM XXPM_EXTEN_CANCEL
    WHERE EXTN_CANCL_ID = P_REF_ID
    AND FUNC_ID         =P_FUNC_ID;
    UPDATE XXPM_EXTEN_CANCEL
    SET STATUS          ='APR'
    WHERE EXTN_CANCL_ID = P_REF_ID
    AND FUNC_ID         =P_FUNC_ID;
    UPDATE XXPM_BOOKING_HEADER
    SET STATUS           ='EXTN'
    WHERE BOOKING_HDR_ID = l_booking_HDR_ID;
  END IF;
  --
  IF UPPER(P_TABLE_NAME) ='XXPM_CANCELLATION' THEN
    SELECT CANCEL_TYPE ,
      BOOKING_ID
    INTO L_CANCEL_TYPE,
      L_BOOKING_HDR_ID
    FROM XXPM_CANCELLATION
    WHERE CANCEL_ID= P_REF_ID
    AND FUNC_ID    =P_FUNC_ID ;
    SELECT COUNT(XCN.PAY_RECEIVED_YN)
    INTO L_COUNT
    FROM XXPM_CANCEL_NOTIFY XCN ,
      XXPM_CANCELLATION XC
    WHERE XC.CANCEL_ID = XCN.CANCEL_ID
    AND XC.CANCEL_ID   = P_REF_ID
    AND XC.FUNC_ID     =P_FUNC_ID
    AND xc.CANCEL_TYPE ='TN';
    SELECT DISTINCT UNIT_ID
    INTO l_unit_id
    FROM XXPM_BOOKING_DETAIL
    WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    UPDATE XXPM_PROPERTY_UNITS SET STATUS ='AVAL' WHERE UNIT_ID =L_UNIT_ID;
    IF L_CANCEL_TYPE ='CN' THEN
      UPDATE XXPM_CANCELLATION
      SET STATUS     ='APR'
      WHERE CANCEL_ID= P_REF_ID
      AND FUNC_ID    =P_FUNC_ID ;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='CANCEL'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    ELSIF L_CANCEL_TYPE    ='TN' THEN
      IF L_COUNT           > 0 THEN
        UPDATE XXPM_CANCELLATION
        SET STATUS     ='CANCEL'
        WHERE CANCEL_ID= P_REF_ID
        AND FUNC_ID    =P_FUNC_ID ;
      ELSE
        UPDATE XXPM_CANCELLATION
        SET STATUS     ='APR'
        WHERE CANCEL_ID= P_REF_ID
        AND FUNC_ID    =P_FUNC_ID ;
      END IF;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='TR'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    ELSIF L_CANCEL_TYPE    ='SP' THEN
      UPDATE XXPM_CANCELLATION
      SET STATUS     ='APR'
      WHERE CANCEL_ID= P_REF_ID
      AND FUNC_ID    =P_FUNC_ID ;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='SWAP'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    ELSIF L_CANCEL_TYPE    ='RS' THEN
      UPDATE XXPM_CANCELLATION
      SET STATUS     ='APR'
      WHERE CANCEL_ID= P_REF_ID
      AND FUNC_ID    =P_FUNC_ID ;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='RESALE'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    END IF;
    --xxpm_bill_invoice_pkg.XXPM_CREATE_INVOICE_TXN();
  END IF;
  --
  IF UPPER(P_TABLE_NAME) ='XXPM_BILLING' THEN
    UPDATE XXPM_BILLING
    SET STATUS      ='APR'
    WHERE BILLING_ID= P_REF_ID
    AND FUNC_ID     =P_FUNC_ID ;
    xxpm_bill_invoice_pkg.load_invoice(P_REF_ID,p_err_code,p_err_msg);
  END IF;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  p_err_code := '1';
  p_err_msg  := SUBSTR (sqlerrm, 1, 2000);
  DBMS_OUTPUT.PUT_LINE('STAUS==>  ' || P_ERR_CODE ||' ' || P_ERR_MSG ) ;
END XXPM_APPROVAL_UPD_RESPONSE;

-- Other Charge Total Amout
function getOtherCharge_amt(p_offer_id in number,p_type in varchar2)
return number is
l_value number;
begin 
select sum(INSTALLMENT_AMOUNT) as amount into l_value
from XXPM_OFFER_MILESTONE_DETAIL 
where OFFER_HDR_ID = p_offer_id
and MILESTONE_TYPE = p_type
group by MILESTONE_TYPE  ;
return l_value;
end getOtherCharge_amt;

PROCEDURE XXPM_PROC_OFFER_REVISION(
    I_OFFER_ID   IN NUMBER,
    I_REVISED_BY IN VARCHAR2)
AS
  V_OFFER_HDR_ID           NUMBER;
  V_ORG_ID                 NUMBER;
  V_FUNC_ID                NUMBER;
  V_OFFER_NUMBER           VARCHAR2(60 BYTE);
  V_OFFER_DATE             DATE;
  V_OFFER_FROM_DATE        DATE;
  V_OFFER_TO_DATE          DATE;
  V_PERFORMED_BY           NUMBER;
  V_REVISION_NO            NUMBER;
  V_REVISION_DATE          DATE;
  V_REVISED_BY             VARCHAR2(60 BYTE);
  V_MS_HDR_ID              NUMBER;
  V_PL_ID                  NUMBER;
  V_OFFER_TYPE             VARCHAR2(60 BYTE);
  V_LEAD_ID                NUMBER;
  V_CUSTOMER_ID            NUMBER;
  V_CUST_SITE_ID           NUMBER;
  V_CUSTOMER_NAME          VARCHAR2(250 BYTE);
  V_CUSTOMER_PHONE_NO      VARCHAR2(250 BYTE);
  V_CUSTOMER_COUNTRY       VARCHAR2(250 BYTE);
  V_SALESMAN_ID            NUMBER;
  V_CURRENCY_CODE          VARCHAR2(3 BYTE);
  V_CHECKLIST              VARCHAR2(250 BYTE);
  V_TERMS_DESC             VARCHAR2(2000 BYTE);
  V_OBJECT_VERSION_NUMBER  NUMBER;
  V_OFFER_FLAG             VARCHAR2(60 BYTE);
  V_TAX_CODE               VARCHAR2(60 BYTE);
  V_PREV_BOOKING_ID        NUMBER;
  V_STATUS                 VARCHAR2(60 BYTE);
  V_DESCRIPTION            VARCHAR2(240 BYTE);
  V_FLOW_STATUS            VARCHAR2(60 BYTE);
  V_FLOW_LEVEL             NUMBER;
  V_FLOW_WITH              NUMBER;
  V_USER_GRP_ID            NUMBER;
  V_ATTRIBUTE_CATEGORY     VARCHAR2(240 BYTE);
  V_ATTRIBUTE1             VARCHAR2(240 BYTE);
  V_ATTRIBUTE2             VARCHAR2(240 BYTE);
  V_ATTRIBUTE3             VARCHAR2(240 BYTE);
  V_ATTRIBUTE4             VARCHAR2(240 BYTE);
  V_ATTRIBUTE5             VARCHAR2(240 BYTE);
  V_ATTRIBUTE6             VARCHAR2(240 BYTE);
  V_ATTRIBUTE7             VARCHAR2(240 BYTE);
  V_ATTRIBUTE8             VARCHAR2(240 BYTE);
  V_ATTRIBUTE9             VARCHAR2(240 BYTE);
  V_ATTRIBUTE10            VARCHAR2(240 BYTE);
  V_CREATED_BY             VARCHAR2(60 BYTE);
  V_CREATION_DATE          TIMESTAMP(6);
  V_LAST_UPDATED_BY        VARCHAR2(60 BYTE);
  V_LAST_UPDATE_DATE       TIMESTAMP(6);
  V_LAST_UPDATE_LOGIN      VARCHAR2(150 BYTE);
  V_OFFER_END_DATE         DATE;
  V_USAGE                  VARCHAR2(30 BYTE);
  V_LEAD_SOURCE_CHANNEL    VARCHAR2(240 BYTE);
  V_LEAD_SOURCE_NAME       VARCHAR2(240 BYTE);
  V_VEND_ID                NUMBER;
  V_VEND_SITE_ID           NUMBER;
  V_VEND_CONTRACT_NO       VARCHAR2(240 BYTE);
  V_PROPERTY_ID            NUMBER;
  V_EMAIL_ID               VARCHAR2(60 BYTE);
  V_LEASE_AGREEMENT_ID     NUMBER;
  V_CAR_PARK_LEASE_AGRE_ID NUMBER;
  V_CUST_ACCEPT            VARCHAR2(1 BYTE);
  V_MIGRATED_DATA          VARCHAR2(5 BYTE);
  V_AGENCY_NAME            VARCHAR2(300 BYTE);
  V_SALES_MANAGER_NAME     VARCHAR2(300 BYTE);
  V_AGENT_COMMISSION       NUMBER;
  V_AGENT_NAME             VARCHAR2(300 BYTE);
  V_AGENT_COMMISSION_PERC  NUMBER;
  V_NATIONALITY            VARCHAR2(150 BYTE);
  V_EMIRATES_ID            VARCHAR2(150 BYTE);
  V_ERRM VARCHAR2(1000);
  CURSOR GET_OFFER_DETAIL(V_OFFER_HDR_ID NUMBER)
  IS
    SELECT OFFER_DTL_ID,
      OFFER_HDR_ID,
      PROPERTY_ID,
      BUILDING_ID,
      UNIT_ID,
      UOM,
      QUANTITY,
      BASE_RATE,
      OFFER_AMOUNT,
      PL_MOD_ID,
      DISC_PCT,
      DISC_AMOUNT,
      TAX_CODE,
      TAX_RATE,
      TAX_AMOUNT,
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
      DISC_TYPE,
      MIN_PRICE
    FROM XXPM_OFFER_DETAIL
    WHERE OFFER_HDR_ID = V_OFFER_HDR_ID;
  CURSOR GET_OFFER_MILESTONE_DETAIL(V_OFFER_HDR_ID NUMBER)
  IS
    SELECT OFFER_MS_DTL_ID,
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
      INCLUDED_IN_RATE,
      TAX_RATE,
      TAX_CODE,
      TAX_AMOUNT,
      CARPARKING,
      OTHER_CHARGE_TYPE
    FROM XXPM_OFFER_MILESTONE_DETAIL
    WHERE OFFER_HDR_ID = V_OFFER_HDR_ID;
BEGIN
  SELECT XOH.OFFER_HDR_ID,
    XOH.ORG_ID,
    XOH.FUNC_ID,
    XOH.OFFER_NUMBER,
    XOH.OFFER_DATE,
    XOH.OFFER_FROM_DATE,
    XOH.OFFER_TO_DATE,
    XOH.PERFORMED_BY,
    XOH.REVISION_NO,
    XOH.REVISION_DATE,
    XOH.REVISED_BY,
    XOH.MS_HDR_ID,
    XOH.PL_ID,
    XOH.OFFER_TYPE,
    XOH.LEAD_ID,
    XOH.CUSTOMER_ID,
    XOH.CUST_SITE_ID,
    XOH.CUSTOMER_NAME,
    XOH.CUSTOMER_PHONE_NO,
    XOH.CUSTOMER_COUNTRY,
    XOH.SALESMAN_ID,
    XOH.CURRENCY_CODE,
    XOH.CHECKLIST,
    XOH.TERMS_DESC,
    XOH.OBJECT_VERSION_NUMBER,
    XOH.OFFER_FLAG,
    XOH.TAX_CODE,
    XOH.PREV_BOOKING_ID,
    XOH.STATUS,
    XOH.DESCRIPTION,
    XOH.FLOW_STATUS,
    XOH.FLOW_LEVEL,
    XOH.FLOW_WITH,
    XOH.USER_GRP_ID,
    XOH.ATTRIBUTE_CATEGORY,
    XOH.ATTRIBUTE1,
    XOH.ATTRIBUTE2,
    XOH.ATTRIBUTE3,
    XOH.ATTRIBUTE4,
    XOH.ATTRIBUTE5,
    XOH.ATTRIBUTE6,
    XOH.ATTRIBUTE7,
    XOH.ATTRIBUTE8,
    XOH.ATTRIBUTE9,
    XOH.ATTRIBUTE10,
    XOH.CREATED_BY,
    XOH.CREATION_DATE,
    XOH.LAST_UPDATED_BY,
    XOH.LAST_UPDATE_DATE,
    XOH.LAST_UPDATE_LOGIN,
    XOH.OFFER_END_DATE,
    XOH.USAGE,
    XOH.LEAD_SOURCE_CHANNEL,
    XOH.LEAD_SOURCE_NAME,
    XOH.VEND_ID,
    XOH.VEND_SITE_ID,
    XOH.VEND_CONTRACT_NO,
    XOH.PROPERTY_ID,
    XOH.EMAIL_ID,
    XOH.LEASE_AGREEMENT_ID,
    XOH.CAR_PARK_LEASE_AGRE_ID,
    XOH.CUST_ACCEPT,
    XOH.MIGRATED_DATA,
    XOH.AGENCY_NAME,
    XOH.SALES_MANAGER_NAME,
    XOH.AGENT_COMMISSION,
    XOH.AGENT_NAME,
    XOH.AGENT_COMMISSION_PERC,
    XOH.NATIONALITY,
    XOH.EMIRATES_ID
  INTO V_OFFER_HDR_ID,
    V_ORG_ID,
    V_FUNC_ID,
    V_OFFER_NUMBER,
    V_OFFER_DATE,
    V_OFFER_FROM_DATE,
    V_OFFER_TO_DATE,
    V_PERFORMED_BY,
    V_REVISION_NO,
    V_REVISION_DATE,
    V_REVISED_BY,
    V_MS_HDR_ID,
    V_PL_ID,
    V_OFFER_TYPE,
    V_LEAD_ID,
    V_CUSTOMER_ID,
    V_CUST_SITE_ID,
    V_CUSTOMER_NAME,
    V_CUSTOMER_PHONE_NO,
    V_CUSTOMER_COUNTRY,
    V_SALESMAN_ID,
    V_CURRENCY_CODE,
    V_CHECKLIST,
    V_TERMS_DESC,
    V_OBJECT_VERSION_NUMBER,
    V_OFFER_FLAG,
    V_TAX_CODE,
    V_PREV_BOOKING_ID,
    V_STATUS,
    V_DESCRIPTION,
    V_FLOW_STATUS,
    V_FLOW_LEVEL,
    V_FLOW_WITH,
    V_USER_GRP_ID,
    V_ATTRIBUTE_CATEGORY,
    V_ATTRIBUTE1,
    V_ATTRIBUTE2,
    V_ATTRIBUTE3,
    V_ATTRIBUTE4,
    V_ATTRIBUTE5,
    V_ATTRIBUTE6,
    V_ATTRIBUTE7,
    V_ATTRIBUTE8,
    V_ATTRIBUTE9,
    V_ATTRIBUTE10,
    V_CREATED_BY,
    V_CREATION_DATE,
    V_LAST_UPDATED_BY,
    V_LAST_UPDATE_DATE,
    V_LAST_UPDATE_LOGIN,
    V_OFFER_END_DATE,
    V_USAGE,
    V_LEAD_SOURCE_CHANNEL,
    V_LEAD_SOURCE_NAME,
    V_VEND_ID,
    V_VEND_SITE_ID,
    V_VEND_CONTRACT_NO,
    V_PROPERTY_ID,
    V_EMAIL_ID,
    V_LEASE_AGREEMENT_ID,
    V_CAR_PARK_LEASE_AGRE_ID,
    V_CUST_ACCEPT,
    V_MIGRATED_DATA,
    V_AGENCY_NAME,
    V_SALES_MANAGER_NAME,
    V_AGENT_COMMISSION,
    V_AGENT_NAME,
    V_AGENT_COMMISSION_PERC,
    V_NATIONALITY,
    V_EMIRATES_ID
  FROM XXPM_OFFER_HEADER XOH
  WHERE OFFER_HDR_ID = I_OFFER_ID;
  IF V_REVISION_NO  IS NULL THEN
    UPDATE XXPM_OFFER_HEADER
    SET REVISION_NO    =1,
      STATUS           ='REV',
      REVISION_DATE    =SYSDATE,
      REVISED_BY       =I_REVISED_BY
    WHERE OFFER_HDR_ID = I_OFFER_ID;
    COMMIT;
  END IF;
  IF V_REVISION_NO IS NOT NULL THEN
    UPDATE XXPM_OFFER_HEADER
    SET REVISION_NO    =V_REVISION_NO+1,
      STATUS           ='REV',
      REVISION_DATE    =SYSDATE ,
      REVISED_BY       =I_REVISED_BY
    WHERE OFFER_HDR_ID = I_OFFER_ID;
    COMMIT;
  END IF;
  BEGIN
    SELECT REVISION_NO
    INTO V_REVISION_NO
    FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID = I_OFFER_ID;
  EXCEPTION
  WHEN OTHERS THEN
    V_ERRM := SQLCODE || '-' || SQLERRM;
  END;
  
  INSERT
  INTO XXPM_OFFER_HEADER_H
    (
      OFFER_HDR_ID_H,
      OFFER_HDR_ID,
      ORG_ID,
      FUNC_ID,
      OFFER_NUMBER,
      OFFER_DATE,
      OFFER_FROM_DATE,
      OFFER_TO_DATE,
      PERFORMED_BY,
      REVISION_NO,
      REVISION_DATE,
      REVISED_BY,
      MS_HDR_ID,
      PL_ID,
      OFFER_TYPE,
      LEAD_ID,
      CUSTOMER_ID,
      CUST_SITE_ID,
      CUSTOMER_NAME,
      CUSTOMER_PHONE_NO,
      CUSTOMER_COUNTRY,
      SALESMAN_ID,
      CURRENCY_CODE,
      CHECKLIST,
      TERMS_DESC,
      OBJECT_VERSION_NUMBER,
      OFFER_FLAG,
      TAX_CODE,
      PREV_BOOKING_ID,
      STATUS,
      DESCRIPTION,
      FLOW_STATUS,
      FLOW_LEVEL,
      FLOW_WITH,
      USER_GRP_ID,
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
      OFFER_END_DATE,
      USAGE,
      LEAD_SOURCE_CHANNEL,
      LEAD_SOURCE_NAME,
      VEND_ID,
      VEND_SITE_ID,
      VEND_CONTRACT_NO,
      PROPERTY_ID,
      EMAIL_ID,
      LEASE_AGREEMENT_ID,
      CAR_PARK_LEASE_AGRE_ID,
      CUST_ACCEPT,
      MIGRATED_DATA,
      AGENCY_NAME,
      SALES_MANAGER_NAME,
      AGENT_COMMISSION,
      AGENT_NAME,
      AGENT_COMMISSION_PERC,
      NATIONALITY,
      EMIRATES_ID
    )
    VALUES
    (
      XXPM_OFFER_HEADER_H_S.nextval,
      V_OFFER_HDR_ID,
      V_ORG_ID,
      V_FUNC_ID,
      V_OFFER_NUMBER,
      V_OFFER_DATE,
      V_OFFER_FROM_DATE,
      V_OFFER_TO_DATE,
      V_PERFORMED_BY,
      V_REVISION_NO,
      V_REVISION_DATE,
      V_REVISED_BY,
      V_MS_HDR_ID,
      V_PL_ID,
      V_OFFER_TYPE,
      V_LEAD_ID,
      V_CUSTOMER_ID,
      V_CUST_SITE_ID,
      V_CUSTOMER_NAME,
      V_CUSTOMER_PHONE_NO,
      V_CUSTOMER_COUNTRY,
      V_SALESMAN_ID,
      V_CURRENCY_CODE,
      V_CHECKLIST,
      V_TERMS_DESC,
      V_OBJECT_VERSION_NUMBER,
      V_OFFER_FLAG,
      V_TAX_CODE,
      V_PREV_BOOKING_ID,
      V_STATUS,
      V_DESCRIPTION,
      V_FLOW_STATUS,
      V_FLOW_LEVEL,
      V_FLOW_WITH,
      V_USER_GRP_ID,
      V_ATTRIBUTE_CATEGORY,
      V_ATTRIBUTE1,
      V_ATTRIBUTE2,
      V_ATTRIBUTE3,
      V_ATTRIBUTE4,
      V_ATTRIBUTE5,
      V_ATTRIBUTE6,
      V_ATTRIBUTE7,
      V_ATTRIBUTE8,
      V_ATTRIBUTE9,
      V_ATTRIBUTE10,
      V_CREATED_BY,
      V_CREATION_DATE,
      V_LAST_UPDATED_BY,
      V_LAST_UPDATE_DATE,
      V_LAST_UPDATE_LOGIN,
      V_OFFER_END_DATE,
      V_USAGE,
      V_LEAD_SOURCE_CHANNEL,
      V_LEAD_SOURCE_NAME,
      V_VEND_ID,
      V_VEND_SITE_ID,
      V_VEND_CONTRACT_NO,
      V_PROPERTY_ID,
      V_EMAIL_ID,
      V_LEASE_AGREEMENT_ID,
      V_CAR_PARK_LEASE_AGRE_ID,
      V_CUST_ACCEPT,
      V_MIGRATED_DATA,
      V_AGENCY_NAME,
      V_SALES_MANAGER_NAME,
      V_AGENT_COMMISSION,
      V_AGENT_NAME,
      V_AGENT_COMMISSION_PERC,
      V_NATIONALITY,
      V_EMIRATES_ID
    );
  COMMIT;
  BEGIN
    FOR i IN GET_OFFER_DETAIL
    (
      I_OFFER_ID
    )
    LOOP
      INSERT
      INTO XXPM_OFFER_DETAIL_H
        (
          OFFER_DTL_ID_H,
          OFFER_HDR_ID_H,
          OFFER_DTL_ID,
          OFFER_HDR_ID,
          PROPERTY_ID,
          BUILDING_ID,
          UNIT_ID,
          UOM,
          QUANTITY,
          BASE_RATE,
          OFFER_AMOUNT,
          PL_MOD_ID,
          DISC_PCT,
          DISC_AMOUNT,
          TAX_CODE,
          TAX_RATE,
          TAX_AMOUNT,
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
          DISC_TYPE,
          MIN_PRICE
        )
        VALUES
        (
          XXPM_OFFER_DETAIL_H_S.nextval,
          XXPM_OFFER_HEADER_H_S.CURRVAL,
          i.OFFER_DTL_ID,
          i.OFFER_HDR_ID,
          i.PROPERTY_ID,
          i.BUILDING_ID,
          i.UNIT_ID,
          i.UOM,
          i.QUANTITY,
          i.BASE_RATE,
          i.OFFER_AMOUNT,
          i.PL_MOD_ID,
          i.DISC_PCT,
          i.DISC_AMOUNT,
          i.TAX_CODE,
          i.TAX_RATE,
          i.TAX_AMOUNT,
          i.ATTRIBUTE_CATEGORY,
          i.ATTRIBUTE1,
          i.ATTRIBUTE2,
          i.ATTRIBUTE3,
          i.ATTRIBUTE4,
          i.ATTRIBUTE5,
          i.ATTRIBUTE6,
          i.ATTRIBUTE7,
          i.ATTRIBUTE8,
          i.ATTRIBUTE9,
          i.ATTRIBUTE10,
          i.CREATED_BY,
          i.CREATION_DATE,
          i.LAST_UPDATED_BY,
          i.LAST_UPDATE_DATE,
          i.LAST_UPDATE_LOGIN,
          i.DISC_TYPE,
          i.MIN_PRICE
        );
    END LOOP;
    COMMIT;
  END;
  BEGIN
    FOR i IN GET_OFFER_MILESTONE_DETAIL
    (
      I_OFFER_ID
    )
    LOOP
      INSERT
      INTO XXPM_OFFER_MILESTONE_DETAIL_H
        (
          OFFER_MS_DTL_ID_H,
          OFFER_HDR_ID_H,
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
          INCLUDED_IN_RATE,
          TAX_RATE,
          TAX_CODE,
          TAX_AMOUNT,
          CARPARKING,
          OTHER_CHARGE_TYPE
        )
        VALUES
        (
          XXPM_OFFER_MILESTONE_DTL_H_S.nextval,
          XXPM_OFFER_HEADER_H_S.CURRVAL,
          i.OFFER_MS_DTL_ID,
          i.OFFER_HDR_ID,
          i.MS_DTL_ID,
          i.PL_MOD_ID,
          i.SEQ_NUMBER,
          i.INSTALLMENT_TYPE,
          i.INSTALLMENT_PCT,
          i.INSTALLMENT_AMOUNT,
          i.CHARGE_TYPE,
          i.PAYMENT_TERM,
          i.REMARKS,
          i.DUE_DAYS,
          i.DUE_DAYS_FROM,
          i.DUE_DATE,
          i.ATTRIBUTE_CATEGORY,
          i.ATTRIBUTE1,
          i.ATTRIBUTE2,
          i.ATTRIBUTE3,
          i.ATTRIBUTE4,
          i.ATTRIBUTE5,
          i.ATTRIBUTE6,
          i.ATTRIBUTE7,
          i.ATTRIBUTE8,
          i.ATTRIBUTE9,
          i.ATTRIBUTE10,
          i.CREATED_BY,
          i.CREATION_DATE,
          i.LAST_UPDATED_BY,
          i.LAST_UPDATE_DATE,
          i.LAST_UPDATE_LOGIN,
          i.MILESTONE_TYPE,
          i.UOM,
          i.QUANTITY,
          i.RATE,
          i.WAVE_OFF,
          i.INSTALLMENT_METHOD,
          i.INSTALLMENT_EVENT,
          i.PERIOD_OCCURENCE,
          i.PERIOD_VALUES,
          i.PERIOD_DURATION,
          i.INCLUDED_IN_RATE,
          i.TAX_RATE,
          i.TAX_CODE,
          i.TAX_AMOUNT,
          i.CARPARKING,
          i.OTHER_CHARGE_TYPE
        );
    END LOOP;
    COMMIT;
  END;
EXCEPTION
WHEN OTHERS THEN
  V_ERRM := SQLCODE || '-' || SQLERRM;
END;

END XXPM_PRISM;
/
