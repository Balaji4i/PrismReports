--------------------------------------------------------
--  DDL for Package XXPM_PRISM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PRISM" 
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

      
END XXPM_PRISM;


--------------------------------------------------------
--  DDL for Package Body XXPM_PRISM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_PRISM" 
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

l_area_header_id  number;
l_area_line_total_count   number;
l_area_line_approved_count number;
l_AREA_CNG_NUMBER  varchar2(300);
l_billing_apr_type  VARCHAR2(4000 BYTE);

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
    AND PAY_RECEIVED_YN = 'Y'
    AND xc.CANCEL_TYPE ='TN';
    SELECT DISTINCT UNIT_ID
    INTO l_unit_id
    FROM XXPM_BOOKING_DETAIL
    WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
--    UPDATE XXPM_PROPERTY_UNITS SET STATUS ='AVAL' WHERE UNIT_ID =L_UNIT_ID;
    IF L_CANCEL_TYPE ='CN' THEN
--      UPDATE XXPM_CANCELLATION
--      SET STATUS     ='APR'
--      WHERE CANCEL_ID= P_REF_ID
--      AND FUNC_ID    =P_FUNC_ID ;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='CANCEL'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    UPDATE XXPM_PROPERTY_UNITS SET STATUS ='AVAL' WHERE UNIT_ID =L_UNIT_ID;
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
        
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='TR'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
      
    UPDATE XXPM_PROPERTY_UNITS SET STATUS ='AVAL' WHERE UNIT_ID =L_UNIT_ID;
      
      END IF; 
    ELSIF L_CANCEL_TYPE    ='SP' THEN
      UPDATE XXPM_CANCELLATION
      SET STATUS     ='APR'
      WHERE CANCEL_ID= P_REF_ID
      AND FUNC_ID    =P_FUNC_ID ;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='SWAP'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
      UPDATE XXPM_PROPERTY_UNITS SET STATUS ='AVAL' WHERE UNIT_ID =L_UNIT_ID;
    ELSIF L_CANCEL_TYPE    ='RS' THEN
      UPDATE XXPM_CANCELLATION
      SET STATUS     ='APR'
      WHERE CANCEL_ID= P_REF_ID
      AND FUNC_ID    =P_FUNC_ID ;
      UPDATE XXPM_BOOKING_HEADER
      SET STATUS           ='RESALE'
      WHERE BOOKING_HDR_ID = L_BOOKING_HDR_ID;
    UPDATE XXPM_PROPERTY_UNITS SET STATUS ='AVAL' WHERE UNIT_ID =L_UNIT_ID;
    END IF;
    --xxpm_bill_invoice_pkg.XXPM_CREATE_INVOICE_TXN();
  END IF;
  --
  IF UPPER(P_TABLE_NAME) ='XXPM_BILLING' THEN
    UPDATE XXPM_BILLING
    SET STATUS      ='APR'
    WHERE BILLING_ID= P_REF_ID
    AND FUNC_ID     =P_FUNC_ID ;
    
    commit;
    
    begin
l_billing_apr_type :=null;
SELECT LOOKUP_ADDL_VALUE 
into l_billing_apr_type
FROM 
xxfnd_lookup_values 
where lookup_value_name='BILLING_APR_TYPE';
exception
when others then
l_billing_apr_type :=null;
end;

if l_billing_apr_type = 'AUTO' then
 xxpm_bill_invoice_pkg.load_invoice(P_REF_ID,p_err_code,p_err_msg);
end if;

  END IF;

  IF upper(p_table_name) ='XXPM_AREA_CHANGE_DLT' THEN

 UPDATE XXPM_AREA_CHANGE_DLT
    SET STATUS      ='APR'
    WHERE AREA_CNG_DLT_ID= P_REF_ID;
    
  XXPM_AREA_CHANGE(
    P_AREA_CHANGE_ID => P_REF_ID,
    P_ERR_CODE => p_err_code,
    P_ERR_MSG => p_err_msg
  );  
    
COMMIT;

begin
l_area_header_id := null;
select AREA_CNG_HDR_ID
 into l_area_header_id
from XXPM_AREA_CHANGE_DLT
where AREA_CNG_DLT_ID =p_ref_id;
exception
when others then
l_area_header_id := null;
end;

begin
l_area_line_total_count :=0;
select count(*)  
into l_area_line_total_count
from XXPM_AREA_CHANGE_DLT
where AREA_CNG_HDR_ID = l_area_header_id;
exception
when others then
l_area_line_total_count :=0;
end;

begin
 l_area_line_approved_count :=0;
select count(*)
  into  l_area_line_approved_count
from XXPM_AREA_CHANGE_DLT
where AREA_CNG_HDR_ID = l_area_header_id
and status= 'APR';
exception
when others then
l_area_line_approved_count :=0;
end;

if l_area_line_total_count   =  l_area_line_approved_count then

update XXPM_AREA_CHANGE_HDR   
set status = 'APR'
where AREA_CNG_HDR_ID = l_area_header_id;

commit;

begin
l_org_id := null;
 l_AREA_CNG_NUMBER := null;
select org_id, AREA_CNG_NUMBER
into l_org_id, l_AREA_CNG_NUMBER
from XXPM_AREA_CHANGE_HDR 
where  AREA_CNG_HDR_ID = l_area_header_id;
exception
when others then
l_org_id := null;
end;

begin
l_property_id :=null;
l_build_id :=null;
l_unit_id  :=null;
select property_id, build_id, unit_id
into  l_property_id, l_build_id, l_unit_id
from XXPM_AREA_CHANGE_DLT
where  AREA_CNG_DLT_ID =p_ref_id;
exception
when others then
l_property_id :=null;
l_build_id :=null;
l_unit_id  :=null;
end;

XXPM_ACTIVITY_PKG.XXPM_PROC_ACTIVITY(
    SOURCE_FUNC_ID => p_func_id,
    SOURCE_FUNC_REF_ID => p_ref_id,
    ORG_ID => l_ORG_ID,
    PROPERTY_ID => L_property_id,
    BUILD_ID => l_build_id,
    UNIT_ID => l_unit_id,
    ACTIVITY_TYPE => 'ACAP',
    DESCRIPTION => l_AREA_CNG_NUMBER,
    CREATED_BY => '' );

end if;



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

END XXPM_PRISM;
