--------------------------------------------------------
--  DDL for Procedure XXPM_PROC_BOOKING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_PROC_BOOKING" (
    I_OFFER_HDR_ID   IN NUMBER,
    I_BOOK_TYPE      IN VARCHAR2,
    I_BOOKING_HDR_ID IN NUMBER,
    I_BOOKING_EXE_BY IN NUMBER,
    O_BOOKING_NUMBER OUT VARCHAR2)
AS
  v_errm                 VARCHAR2 (2000);
  V_BOOKING_NUMBER       VARCHAR2 (20);
  V_BOOK_TYPE            VARCHAR2(5);
  V_FUNC_ID              NUMBER;
  V_BOOKING_HDR_ID       NUMBER;
  V_ORG_ID               NUMBER;
  V_PROPERTY_ID          NUMBER;
  V_OFFER_HDR_ID         NUMBER;
  V_USAGE                VARCHAR2(30);
  V_CREATED_BY           VARCHAR2(60);
  V_MS_HDR_ID            NUMBER;
  V_PL_ID                NUMBER;
  V_OFFER_END_DATE       DATE;
  V_OFFER_FROM_DATE      DATE;
  V_OFFER_TO_DATE        DATE;
  V_LEAD_ID              NUMBER;
  V_SALESMAN_ID          NUMBER;
  V_CURRENCY_CODE        VARCHAR2(5);
  V_TERMS_DESC           VARCHAR2(2000);
  V_TAX_CODE             VARCHAR2(60);
  V_VEND_ID              NUMBER;
  V_VEND_SITE_ID         NUMBER;
  V_VEND_CONTRACT_NO     VARCHAR2(240);
  V_DESCRIPTION          VARCHAR2(240);
  V_BOOKING_HDR_ID_1     NUMBER;
  V_CUSTOMER_ID          NUMBER;
  V_CUST_SITE_ID         NUMBER;
  V_PROPERTY_ID_D        NUMBER;
  V_BUILDING_ID_D        NUMBER;
  V_UNIT_ID_D            NUMBER;
  V_UOM_D                VARCHAR2(60);
  V_QUANTITY_D           NUMBER;
  V_BASE_RATE_D          NUMBER;
  V_OFFER_AMOUNT_D       NUMBER;
  V_PL_MOD_ID_D          NUMBER;
  V_DISC_PCT_D           NUMBER;
  V_DISC_AMOUNT_D        NUMBER;
  V_TAX_CODE_D           VARCHAR2(60);
  V_TAX_RATE_D           NUMBER;
  V_TAX_AMOUNT_D         NUMBER;
  V_BOOKING_HDR_ID_2     NUMBER;
  V_MILESTONE_TYPE_M     VARCHAR2(60);
  V_MS_DTL_ID_M          NUMBER;
  V_PL_MOD_ID_M          NUMBER;
  V_SEQ_NUMBER_M         NUMBER;
  V_INSTALLMENT_TYPE_M   VARCHAR2(60);
  V_INSTALLMENT_PCT_M    NUMBER;
  V_INSTALLMENT_AMOUNT_M NUMBER;
  V_UOM_M                VARCHAR2(30);
  V_QUANTITY_M           NUMBER;
  V_RATE_M               NUMBER;
  V_WAVE_OFF_M           VARCHAR2(30);
  V_INCLUDED_IN_RATE_M   VARCHAR2(30);
  V_INSTALLMENT_METHOD_M VARCHAR2(30);
  V_INSTALLMENT_EVENT_M  VARCHAR2(30);
  V_PERIOD_OCCURENCE_M   VARCHAR2(30);
  V_PERIOD_VALUES_M      NUMBER;
  V_PERIOD_DURATION_M    VARCHAR2(30);
  V_CHARGE_TYPE_M        VARCHAR2(60);
  V_PAYMENT_TERM_M       VARCHAR2(60);
  V_REMARKS_M            VARCHAR2(4000);
  V_DUE_DAYS_M           NUMBER;
  V_DUE_DAYS_FROM_M      VARCHAR2(60);
  V_DUE_DATE_M           DATE;
  V_BOOKING_HDR_ID_3     NUMBER;
  V_FUNC_ID_1            NUMBER;
  V_NEXT_NUM             VARCHAR2(20);
  V_p_func_id            NUMBER;
  V_p_err_code           VARCHAR2(30);
  V_p_err_msg            VARCHAR2(30);
  V_LEAD_SOURCE_CHANNEL  VARCHAR2(255);
  V_LEAD_SOURCE_NAME     VARCHAR2(255);
  V_BLOCK_ID             NUMBER;
  V_BOOKING_EXE_BY       NUMBER;
  V_ATTRIBUTE1           VARCHAR2(60);
  V_ATTRIBUTE2           VARCHAR2(60);
  V_ATTRIBUTE3           VARCHAR2(60);
  V_ATTRIBUTE4           VARCHAR2(60);
  V_ATTRIBUTE5           VARCHAR2(60);
  V_ATTRIBUTE6           VARCHAR2(60);
  V_ATTRIBUTE7           VARCHAR2(60);
  V_ATTRIBUTE8           VARCHAR2(60);
  V_ATTRIBUTE9           VARCHAR2(60);
  V_ATTRIBUTE10          VARCHAR2(60);
  l_charge_type          VARCHAR2(60);
  L_DUE_DATE             DATE;
  v_CUST_CONTACT_ID      NUMBER;
  l_cnt_cus      NUMBER;



  CURSOR book_detail (v_offer_id NUMBER)
  IS
    SELECT PROPERTY_ID,
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
      TAX_AMOUNT
    FROM XXPM_OFFER_DETAIL
    WHERE OFFER_HDR_ID =v_offer_id;
  CURSOR book_milestone(v_offer_id_1 NUMBER)
  IS
    SELECT MILESTONE_TYPE,
      MS_DTL_ID,
      PL_MOD_ID,
      SEQ_NUMBER,
      INSTALLMENT_TYPE,
      INSTALLMENT_PCT,
      INSTALLMENT_AMOUNT,
      UOM,
      QUANTITY,
      RATE,
      WAVE_OFF,
      INCLUDED_IN_RATE,
      INSTALLMENT_METHOD,
      INSTALLMENT_EVENT,
      PERIOD_OCCURENCE,
      PERIOD_VALUES,
      PERIOD_DURATION,
      CHARGE_TYPE,
      PAYMENT_TERM,
      REMARKS,
      DUE_DAYS,
      DUE_DAYS_FROM,
      DUE_DATE
    FROM XXPM_OFFER_MILESTONE_DETAIL
    WHERE OFFER_HDR_ID =I_OFFER_HDR_ID
  UNION
  SELECT m.MILESTONE_TYPE,
    m.MS_DTL_ID,
    m.PL_MOD_ID,
    m.SEQ_NUMBER,
    m.INSTALLMENT_TYPE,
    m.INSTALLMENT_PCT,
    m.INSTALLMENT_AMOUNT,
    m.UOM,
    m.QUANTITY,
    m.RATE,
    m.WAVE_OFF,
    m.INCLUDED_IN_RATE,
    m.INSTALLMENT_METHOD,
    m.INSTALLMENT_EVENT,
    m.PERIOD_OCCURENCE,
    m.PERIOD_VALUES,
    m.PERIOD_DURATION,
    m.CHARGE_TYPE,
    m.PAYMENT_TERM,
    m.REMARKS,
    m.DUE_DAYS,
    m.DUE_DAYS_FROM,
    m.DUE_DATE
  FROM XXPM_OFFER_MILESTONE_DETAIL m,
    xxpm_offer_detail d
  WHERE 1            =1
  AND m.ms_dtl_id    = d.OFFER_DTL_ID
  AND d.OFFER_HDR_ID =I_OFFER_HDR_ID;
BEGIN
  V_BOOK_TYPE     :=I_BOOK_TYPE;
  V_BOOKING_HDR_ID:=I_BOOKING_HDR_ID;
  V_BOOKING_EXE_BY:=I_BOOKING_EXE_BY;
  BEGIN
    xxfnd_pkg.get_next_number('BK',V_NEXT_NUM,V_p_func_id,V_p_err_code,V_p_err_msg);
    DBMS_OUTPUT.PUT_LINE(V_NEXT_NUM);
  END;
  --  BEGIN
  --
  --  -- offer hea usage--S/L
  --  -- S----SB
  --  ---L---LB
  --    SELECT FUNC_ID INTO V_FUNC_ID FROM xxfnd_functions WHERE FUNC_SHORT_CODE='BK';
  --  EXCEPTION
  --  WHEN no_data_found THEN
  --    v_errm := SQLCODE || '-' || SQLERRM;
  --  WHEN OTHERS THEN
  --    v_errm := SQLCODE || '-' || SQLERRM;
  --  END;
  BEGIN
    SELECT BLOCK_ID
    INTO V_BLOCK_ID
    FROM xxpm_block_header
    WHERE OFFER_HDR_ID = I_OFFER_HDR_ID ;
  EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    SELECT BLOCK_ID
    INTO V_BLOCK_ID
    FROM xxpm_block_header
    WHERE OFFER_HDR_ID = I_OFFER_HDR_ID
    AND rownum         =1 ;
  WHEN OTHERS THEN
    V_BLOCK_ID := NULL;
  END;
  BEGIN
    SELECT ORG_ID,
      PROPERTY_ID,
      OFFER_HDR_ID,
      USAGE,
      CREATED_BY,
      MS_HDR_ID,
      PL_ID,
      OFFER_END_DATE,
      OFFER_FROM_DATE,
      OFFER_TO_DATE,
      LEAD_ID,
      SALESMAN_ID,
      CURRENCY_CODE,
      TERMS_DESC,
      TAX_CODE,
      VEND_ID,
      VEND_SITE_ID,
      VEND_CONTRACT_NO,
      DESCRIPTION,
      LEAD_SOURCE_CHANNEL,
      LEAD_SOURCE_NAME,
      ATTRIBUTE1,
      ATTRIBUTE2,
      ATTRIBUTE3,
      ATTRIBUTE4,
      ATTRIBUTE5,
      ATTRIBUTE6,
      ATTRIBUTE7,
      ATTRIBUTE8,
      ATTRIBUTE9,
      ATTRIBUTE10
    INTO V_ORG_ID,
      V_PROPERTY_ID,
      V_OFFER_HDR_ID,
      V_USAGE,
      V_CREATED_BY,
      V_MS_HDR_ID,
      V_PL_ID,
      V_OFFER_END_DATE,
      V_OFFER_FROM_DATE,
      V_OFFER_TO_DATE,
      V_LEAD_ID,
      V_SALESMAN_ID,
      V_CURRENCY_CODE,
      V_TERMS_DESC,
      V_TAX_CODE,
      V_VEND_ID,
      V_VEND_SITE_ID,
      V_VEND_CONTRACT_NO,
      V_DESCRIPTION,
      V_LEAD_SOURCE_CHANNEL,
      V_LEAD_SOURCE_NAME,
      V_ATTRIBUTE1,
      V_ATTRIBUTE2,
      V_ATTRIBUTE3,
      V_ATTRIBUTE4,
      V_ATTRIBUTE5,
      V_ATTRIBUTE6,
      V_ATTRIBUTE7,
      V_ATTRIBUTE8,
      V_ATTRIBUTE9,
      V_ATTRIBUTE10
    FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
    DBMS_OUTPUT.PUT_LINE(V_OFFER_HDR_ID);
    BEGIN
      IF V_USAGE = 'L' THEN
        SELECT FUNC_ID INTO V_FUNC_ID FROM xxfnd_functions WHERE FUNC_SHORT_CODE='LB';
      END IF;
      IF V_USAGE = 'S' THEN
        SELECT FUNC_ID INTO V_FUNC_ID FROM xxfnd_functions WHERE FUNC_SHORT_CODE='SB';
      END IF;
    EXCEPTION
    WHEN no_data_found THEN
      v_errm := SQLCODE || '-' || SQLERRM;
    WHEN OTHERS THEN
      v_errm := SQLCODE || '-' || SQLERRM;
    END;
    IF (I_BOOK_TYPE='QB' ) THEN
      BEGIN
        IF I_OFFER_HDR_ID IS NOT NULL THEN

       select count(CUSTOMER_ID) into l_cnt_cus  FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID  =I_OFFER_HDR_ID;

       if l_cnt_cus > 0 then
          SELECT CUSTOMER_ID,
      CUST_SITE_ID
    INTO V_CUSTOMER_ID,
      V_CUST_SITE_ID
    FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID  =I_OFFER_HDR_ID;
    else

    SELECT
    cust_id INTO V_CUSTOMER_ID
FROM xxstg_customer where ORIG_SYSTEM_REF = (select
ATTRIBUTE3 from XXPM_OFFER_HEADER where OFFER_HDR_ID  =I_OFFER_HDR_ID);
    V_CUST_SITE_ID := null;

    end if;
        END IF;
      EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('exception  in getting customer details in QB');
      END;
      INSERT
      INTO XXPM_BOOKING_HEADER
        (
          BOOKING_HDR_ID,
          ORG_ID,
          FUNC_ID,
          PROPERTY_ID,
          OFFER_HDR_ID,
          BLOCK_ID,
          BOOKING_NUMBER,
          BOOKING_DATE,
          BOOKING_END_DATE,
          BOOKING_FROM_DATE,
          BOOKING_TO_DATE,
          SPA_PCT,
          AREA_VARIATION_PCT,
          USAGE,
          BOOKING_EXE_BY,
          REVISION_NO,
          REVISION_DATE,
          REVISED_BY,
          MS_HDR_ID,
          PL_ID,
          BOOKING_TYPE,
          BOOKING_STAGE,
          LEAD_ID,
          SALESMAN_ID,
          CURRENCY_CODE,
          CHECKLIST,
          TERMS_DESC,
          OBJECT_VERSION_NUMBER,
          BOOKING_FLAG,
          TAX_CODE,
          PREV_BOOKING_ID,
          LEAD_SOURCE_CHANNEL,
          LEAD_SOURCE_NAME,
          VEND_ID,
          VEND_SITE_ID,
          VEND_CONTRACT_NO,
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
          ACTIVE_YN
        )
        VALUES
        (
          XXPM_BOOKING_HEADER_S.nextval,
          V_ORG_ID,
          V_FUNC_ID,
          V_PROPERTY_ID,
          V_OFFER_HDR_ID,
          V_BLOCK_ID,
          'BK-'
          || XXPM_BOOKING_HEADER_S.nextval,
          sysdate,
          V_OFFER_END_DATE,
          V_OFFER_FROM_DATE,
          V_OFFER_TO_DATE,
          NULL,
          NULL,
          V_USAGE,
          V_BOOKING_EXE_BY,
          NULL,
          NULL,
          NULL,
          V_MS_HDR_ID,
          V_PL_ID,
          V_BOOK_TYPE,
          NULL,
          V_LEAD_ID,
          V_SALESMAN_ID,
          V_CURRENCY_CODE,
          NULL,
          V_TERMS_DESC,
          1,
          'New',
          V_TAX_CODE,
          NULL,
          V_LEAD_SOURCE_CHANNEL,
          V_LEAD_SOURCE_NAME,
          V_VEND_ID,
          V_VEND_SITE_ID,
          V_VEND_CONTRACT_NO,
          'DRA',
          V_DESCRIPTION,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          --ATTRIBUTE
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
          --
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          'Y'
        );
      DBMS_OUTPUT.PUT_LINE('Record inserted into BOOKING_HEADER for the offer_id '||I_OFFER_HDR_ID || '' || I_BOOK_TYPE || '' ||I_BOOKING_HDR_ID);
      COMMIT;
    elsif (I_BOOK_TYPE ='SB') THEN
      BEGIN
        IF I_OFFER_HDR_ID IS NOT NULL THEN

       select count(CUSTOMER_ID) into l_cnt_cus  FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID  =I_OFFER_HDR_ID;

       if l_cnt_cus > 0 then
          SELECT CUSTOMER_ID,
      CUST_SITE_ID
    INTO V_CUSTOMER_ID,
      V_CUST_SITE_ID
    FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID  =I_OFFER_HDR_ID;

    SELECT CUST_CONTACT_ID
    INTO v_CUST_CONTACT_ID
    FROM XXSTG_CUST_CONTACTS
    WHERE CUST_ID    =V_CUSTOMER_ID
    AND CUST_SITE_ID =V_CUST_SITE_ID;

    else

    SELECT
    cust_id INTO V_CUSTOMER_ID
FROM xxstg_customer where ORIG_SYSTEM_REF = (select
ATTRIBUTE3 from XXPM_OFFER_HEADER where OFFER_HDR_ID  =I_OFFER_HDR_ID);
    V_CUST_SITE_ID := null;

    end if;
        END IF;
      EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('exception  in getting customer details in SB');
      END;
      IF(I_BOOKING_HDR_ID IS NOT NULL ) THEN
        INSERT
        INTO XXPM_BOOKING_HEADER
          (
            BOOKING_HDR_ID,
            ORG_ID,
            FUNC_ID,
            PROPERTY_ID,
            OFFER_HDR_ID,
            BLOCK_ID,
            BOOKING_NUMBER,
            BOOKING_DATE,
            BOOKING_END_DATE,
            BOOKING_FROM_DATE,
            BOOKING_TO_DATE,
            SPA_PCT,
            AREA_VARIATION_PCT,
            USAGE,
            BOOKING_EXE_BY,
            REVISION_NO,
            REVISION_DATE,
            REVISED_BY,
            MS_HDR_ID,
            PL_ID,
            BOOKING_TYPE,
            BOOKING_STAGE,
            LEAD_ID,
            SALESMAN_ID,
            CURRENCY_CODE,
            CHECKLIST,
            TERMS_DESC,
            OBJECT_VERSION_NUMBER,
            BOOKING_FLAG,
            TAX_CODE,
            PREV_BOOKING_ID,
            LEAD_SOURCE_CHANNEL,
            LEAD_SOURCE_NAME,
            VEND_ID,
            VEND_SITE_ID,
            VEND_CONTRACT_NO,
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
            LAST_UPDATE_LOGIN
          )
          VALUES
          (
            V_BOOKING_HDR_ID,
            V_ORG_ID,
            V_FUNC_ID,
            V_PROPERTY_ID,
            V_OFFER_HDR_ID,
            V_BLOCK_ID,
            'BK-'
            || XXPM_BOOKING_HEADER_S.nextval,
            sysdate,
            V_OFFER_END_DATE,
            V_OFFER_FROM_DATE,
            V_OFFER_TO_DATE,
            NULL,
            NULL,
            V_USAGE,
            V_BOOKING_EXE_BY,
            NULL,
            NULL,
            NULL,
            V_MS_HDR_ID,
            V_PL_ID,
            V_BOOK_TYPE,
            NULL,
            V_LEAD_ID,
            V_SALESMAN_ID,
            V_CURRENCY_CODE,
            NULL,
            V_TERMS_DESC,
            1,
            'New',
            V_TAX_CODE,
            NULL,
            V_LEAD_SOURCE_CHANNEL,
            V_LEAD_SOURCE_NAME,
            V_VEND_ID,
            V_VEND_SITE_ID,
            V_VEND_CONTRACT_NO,
            'DRA',
            V_DESCRIPTION,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            --ATTR
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
            --
            NULL,
            NULL,
            NULL,
            NULL,
            NULL
          );
        DBMS_OUTPUT.PUT_LINE('Record inserted into BOOKING_HEADER for the offer_id '||I_OFFER_HDR_ID || '' || I_BOOK_TYPE || '' ||I_BOOKING_HDR_ID);
        COMMIT;
      END IF;
    elsif (I_BOOK_TYPE ='BL') THEN
      BEGIN
        IF I_OFFER_HDR_ID IS NOT NULL THEN
          SELECT CUST_ID,
            CUST_SITE_ID
          INTO V_CUSTOMER_ID,
            V_CUST_SITE_ID
          FROM XXPM_BLOCK_HEADER
          WHERE OFFER_HDR_ID =I_OFFER_HDR_ID;
        END IF;
      EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('exception  in getting customer details in BL');
      END;
      IF(I_BOOKING_HDR_ID IS NOT NULL ) THEN
        INSERT
        INTO XXPM_BOOKING_HEADER
          (
            BOOKING_HDR_ID,
            ORG_ID,
            FUNC_ID,
            PROPERTY_ID,
            OFFER_HDR_ID,
            BLOCK_ID,
            BOOKING_NUMBER,
            BOOKING_DATE,
            BOOKING_END_DATE,
            BOOKING_FROM_DATE,
            BOOKING_TO_DATE,
            SPA_PCT,
            AREA_VARIATION_PCT,
            USAGE,
            BOOKING_EXE_BY,
            REVISION_NO,
            REVISION_DATE,
            REVISED_BY,
            MS_HDR_ID,
            PL_ID,
            BOOKING_TYPE,
            BOOKING_STAGE,
            LEAD_ID,
            SALESMAN_ID,
            CURRENCY_CODE,
            CHECKLIST,
            TERMS_DESC,
            OBJECT_VERSION_NUMBER,
            BOOKING_FLAG,
            TAX_CODE,
            PREV_BOOKING_ID,
            LEAD_SOURCE_CHANNEL,
            LEAD_SOURCE_NAME,
            VEND_ID,
            VEND_SITE_ID,
            VEND_CONTRACT_NO,
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
            LAST_UPDATE_LOGIN
          )
          VALUES
          (
            V_BOOKING_HDR_ID,
            V_ORG_ID,
            V_FUNC_ID,
            V_PROPERTY_ID,
            V_OFFER_HDR_ID,
            V_BLOCK_ID,
            'BK-'
            || XXPM_BOOKING_HEADER_S.nextval,
            sysdate,
            V_OFFER_END_DATE,
            V_OFFER_FROM_DATE,
            V_OFFER_TO_DATE,
            NULL,
            NULL,
            V_USAGE,
            V_BOOKING_EXE_BY,
            NULL,
            NULL,
            NULL,
            V_MS_HDR_ID,
            V_PL_ID,
            V_BOOK_TYPE,
            NULL,
            V_LEAD_ID,
            V_SALESMAN_ID,
            V_CURRENCY_CODE,
            NULL,
            V_TERMS_DESC,
            1,
            'New',
            V_TAX_CODE,
            NULL,
            V_LEAD_SOURCE_CHANNEL,
            V_LEAD_SOURCE_NAME,
            V_VEND_ID,
            V_VEND_SITE_ID,
            V_VEND_CONTRACT_NO,
            'DRA',
            V_DESCRIPTION,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            --
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
            --
            NULL,
            NULL,
            NULL,
            NULL,
            NULL
          );
        DBMS_OUTPUT.PUT_LINE('Record inserted into BOOKING_HEADER for the offer_id '||I_OFFER_HDR_ID || '' || I_BOOK_TYPE || '' ||I_BOOKING_HDR_ID);
        COMMIT;
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Record inserted  for the offer_id '||I_OFFER_HDR_ID || '' || I_BOOK_TYPE || '' ||I_BOOKING_HDR_ID);
      NULL;
    END IF;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    SELECT BOOKING_HDR_ID
    INTO V_BOOKING_HDR_ID_1
    FROM XXPM_BOOKING_HEADER
    WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    SELECT CUST_CONTACT_ID
    INTO v_CUST_CONTACT_ID
    FROM XXSTG_CUST_CONTACTS
    WHERE CUST_ID    =V_CUSTOMER_ID
    AND CUST_SITE_ID =V_CUST_SITE_ID;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    IF (I_OFFER_HDR_ID IS NOT NULL) THEN
      INSERT
      INTO XXPM_BOOKING_CUSTOMER
        (
          BOOKING_CUST_ID,
          BOOKING_HDR_ID,
          CUST_ID,
          SHIP_TO_SITE_ID,
          BILL_TO_SITE_ID,
          CUST_CONTACT_ID,
          PRIMARY_YN,
          DESCRIPTION,
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
          ATTRIBUTE11,
          ATTRIBUTE12,
          ATTRIBUTE13,
          ATTRIBUTE14,
          ATTRIBUTE15,
          ATTRIBUTE16,
          ATTRIBUTE17,
          ATTRIBUTE18,
          ATTRIBUTE19,
          ATTRIBUTE20,
          CREATED_BY,
          CREATION_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN
        )
        VALUES
        (
          XXPM_BOOKING_CUST_ID_S.nextval,
          V_BOOKING_HDR_ID_1,
          V_CUSTOMER_ID,
          V_CUST_SITE_ID,
          V_CUST_SITE_ID,
          v_CUST_CONTACT_ID,
          'Y',
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
          NULL,
          NULL,
          NULL,
          NULL,
          NULL
        );
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Record inserted for the BOOKING CUSTOMER booking_hdr_id '||V_BOOKING_HDR_ID_1 ||'OFFER_ID' ||I_OFFER_HDR_ID);
    END IF;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
    DBMS_OUTPUT.PUT_LINE('exception no data found   ');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('exception  ');
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    SELECT BOOKING_HDR_ID
    INTO V_BOOKING_HDR_ID_2
    FROM XXPM_BOOKING_HEADER
    WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    FOR i IN book_detail (I_OFFER_HDR_ID)
    LOOP
      INSERT
      INTO XXPM_BOOKING_DETAIL
        (
          BOOKING_DTL_ID,
          BOOKING_HDR_ID,
          PROPERTY_ID,
          BUILDING_ID,
          UNIT_ID,
          UOM,
          QUANTITY,
          BOOKING_RATE,
          BOOKING_AMOUNT,
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
          LAST_UPDATE_LOGIN
        )
        VALUES
        (
          XXPM_BOOKING_DETAIL_S.nextval,
          V_BOOKING_HDR_ID_2,
          i.property_id,
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
          NULL,
          NULL,
          NULL,
          NULL,
          NULL
        );
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Record inserted for the BOOKING DETAIL offer_hdr_id '|| I_OFFER_HDR_ID);
    COMMIT;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    SELECT BOOKING_HDR_ID,
      FUNC_ID
    INTO V_BOOKING_HDR_ID_3,
      V_FUNC_ID_1
    FROM XXPM_BOOKING_HEADER
    WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    FOR i IN book_milestone (I_OFFER_HDR_ID)
    LOOP
      IF i.MILESTONE_TYPE    = 'MS' THEN
        l_charge_type       := i.CHARGE_TYPE;
      elsif i.MILESTONE_TYPE = 'Fix' THEN
        l_charge_type       :='FIX_FIT';
      elsif i.MILESTONE_TYPE = 'Charge' THEN
        l_charge_type       := 'OTHER_CHARGE';
      END IF;
      IF upper(i.INSTALLMENT_METHOD) = upper('Sales Milestone') THEN
        l_DUE_DATE                  := NULL;
      ELSE
        l_DUE_DATE:=i.due_date;
      END IF;
      INSERT
      INTO XXPM_BOOKING_MILESTONES
        (
          BOOKING_MS_DTL_ID,
          SOURCE_FUNC_ID,
          SOURCE_FUNC_REF_ID,
          MILESTONE_TYPE,
          MS_DTL_ID,
          PL_MOD_ID,
          SEQ_NUMBER,
          INSTALLMENT_TYPE,
          INSTALLMENT_PCT,
          INSTALLMENT_AMOUNT,
          UOM,
          QUANTITY,
          RATE,
          WAVE_OFF,
          INCLUDED_IN_RATE,
          INSTALLMENT_METHOD,
          INSTALLMENT_EVENT,
          PERIOD_OCCURENCE,
          PERIOD_VALUES,
          PERIOD_DURATION,
          CHARGE_TYPE,
          PAYMENT_TERM,
          REMARKS,
          DUE_DAYS,
          DUE_DAYS_FROM,
          DUE_DATE,
          BILLING_ID,
          STATUS,
          INVOICE_ID,
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
          BOOKING_HDR_ID
        )
        VALUES
        (
          XXPM_BOOKING_MILESTONES_S.nextval,
          V_FUNC_ID_1,
          V_BOOKING_HDR_ID_3,
          i.MILESTONE_TYPE,
          i.MS_DTL_ID,
          i.PL_MOD_ID,
          i.SEQ_NUMBER,
          i.INSTALLMENT_TYPE,
          i.INSTALLMENT_PCT,
          i.INSTALLMENT_AMOUNT,
          i.UOM,
          i.QUANTITY,
          i.RATE,
          i.WAVE_OFF,
          i.INCLUDED_IN_RATE,
          i.INSTALLMENT_METHOD,
          i.INSTALLMENT_EVENT,
          i.PERIOD_OCCURENCE,
          i.PERIOD_VALUES,
          i.PERIOD_DURATION,
          l_charge_type, --          i.CHARGE_TYPE,
          i.PAYMENT_TERM,
          i.REMARKS,
          i.DUE_DAYS,
          i.DUE_DAYS_FROM,
          l_DUE_DATE, --          i.DUE_DATE,
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
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          V_BOOKING_HDR_ID_3
        );
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Record inserted for the BOOKING MILESTONE offer_hdr_id '|| I_OFFER_HDR_ID);
    COMMIT;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  SELECT BOOKING_NUMBER
  INTO V_BOOKING_NUMBER
  FROM XXPM_BOOKING_HEADER
  WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
  O_BOOKING_NUMBER :=V_BOOKING_NUMBER;
  RETURN;
EXCEPTION
WHEN no_data_found THEN
  v_errm := SQLCODE || '-' || SQLERRM;
  RETURN;
WHEN OTHERS THEN
  v_errm := SQLCODE || '-' || SQLERRM;
  RETURN;
END;
