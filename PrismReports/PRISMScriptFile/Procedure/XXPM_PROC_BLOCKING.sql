--------------------------------------------------------
--  DDL for Procedure XXPM_PROC_BLOCKING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_PROC_BLOCKING" (
    I_OFFER_HDR_ID   IN NUMBER,
    I_BLOCK_TYPE     IN VARCHAR2,
    O_BLOCK_NUMBER OUT VARCHAR2)
AS
  v_errm                 VARCHAR2 (2000);
  V_BLOCK_TYPE            VARCHAR2(5);
  V_BLOCK_ID             NUMBER;
  V_ORG_ID               NUMBER;
  V_PROPERTY_ID          NUMBER;
  V_STATUS               VARCHAR2(60);
  V_USAGE                VARCHAR2(30);
  V_DESCRIPTION          VARCHAR2(240);
  V_OFFER_HDR_ID         NUMBER;
  V_LEAD_ID              NUMBER;
  V_CUSTOMER_ID          NUMBER;
  V_CUST_SITE_ID         NUMBER;
  V_BLOCK_NUMBER         VARCHAR2 (20);
  V_FUNC_ID              NUMBER;
   CURSOR block_detail (v_offer_id NUMBER)
  IS
    SELECT BUILDING_ID,
      UNIT_ID,
      OFFER_DTL_ID
    FROM XXPM_OFFER_DETAIL
    WHERE OFFER_HDR_ID =v_offer_id;
BEGIN
  V_BLOCK_TYPE     :=I_BLOCK_TYPE;
  BEGIN
    SELECT FUNC_ID
    INTO V_FUNC_ID
    FROM xxfnd_functions
    WHERE FUNC_SHORT_CODE='BL';
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
     SELECT 
      ORG_ID,
      PROPERTY_ID,
      OFFER_HDR_ID,
      USAGE,
      LEAD_ID,
      DESCRIPTION,
      STATUS,
      CUSTOMER_ID, 
      CUST_SITE_ID
    INTO 
      V_ORG_ID,
      V_PROPERTY_ID,
      V_OFFER_HDR_ID,
      V_USAGE,
      V_LEAD_ID,
      V_DESCRIPTION,
      V_STATUS,
      V_CUSTOMER_ID,
      V_CUST_SITE_ID
    FROM XXPM_OFFER_HEADER
    WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
    IF (I_OFFER_HDR_ID IS NOT NULL) THEN
   INSERT INTO xxpm_block_header
        (
          BLOCK_ID,
          BLOCK_NUMBER,
          BLOCK_DATE,
          BLOCK_TYPE,
          BLOCKED_BY,
          ORG_ID,
          STATUS,
          USAGE,
          DESCRIPTION,
          FUNC_ID,
          FLOW_STATUS,
          FLOW_LEVEL,
          FLOW_WITH,
          USER_GRP_ID,
          RECEIPT_YN,
          OFFER_HDR_ID,
          LEAD_ID,
          CUST_ID,
          CUST_SITE_ID,
          VALID_UPTO,
          EXTN_REASON,
          EXTN_COUNT,
          CREATED_BY,
          CREATED_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN,
          
          
                PROPERTY_ID
)
          VALUES
        (
          XXPM_BLOCK_HEADER_S.nextval,
          'BL-'|| XXPM_BLOCK_HEADER_S.nextval,
          sysdate,
          V_BLOCK_TYPE,
          null,
          V_ORG_ID,
          V_STATUS,
          V_USAGE,
          V_DESCRIPTION,
          V_FUNC_ID,
          NULL,
          NULL,
          NULL,
          NULL,
          'Y',
          V_OFFER_HDR_ID,
          V_LEAD_ID,
          V_CUSTOMER_ID,
          V_CUST_SITE_ID,
          NULL,
          NULL,
          0,
          NULL,
          SYSDATE,
          NULL,
          SYSDATE,
          NULL,V_PROPERTY_ID);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Record inserted into BLOCKING_HEADER for the offer_id '||I_OFFER_HDR_ID || '' || I_BLOCK_TYPE);
    END IF;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    SELECT BLOCK_ID
    INTO V_BLOCK_ID
    FROM XXPM_BLOCK_HEADER
    WHERE OFFER_HDR_ID=I_OFFER_HDR_ID;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
  BEGIN
    FOR i IN block_detail (I_OFFER_HDR_ID)
    LOOP
      INSERT
      INTO XXPM_BLOCK_DETAIL
        (
          BLOCK_DTL_ID,
          BLOCK_ID,
          PROPERTY_ID,
          BUILD_ID,
          UNIT_ID,
          UNBLOCK_FLAG,
          UNBLOCK_ID,
          OFFER_DTL_ID,
          CREATED_BY,
          CREATED_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN                 
        )
        VALUES
        (
          XXPM_BLOCK_DETAIL_S.nextval,
          V_BLOCK_ID,
          V_PROPERTY_ID,
          i.BUILDING_ID,
          i.UNIT_ID,
          'N',
          null,
          i.OFFER_DTL_ID,
          NULL,
          SYSDATE,
          NULL,
          sysdate,
          NULL
        );
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Record inserted for the BLOCK DETAIL offer_hdr_id '|| I_OFFER_HDR_ID);
    COMMIT;
  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
select BLOCK_NUMBER into V_BLOCK_NUMBER from XXPM_BLOCK_HEADER where OFFER_HDR_ID=I_OFFER_HDR_ID;
O_BLOCK_NUMBER:=V_BLOCK_NUMBER;
return;
EXCEPTION
WHEN no_data_found THEN
  v_errm := SQLCODE || '-' || SQLERRM;
  return;
WHEN OTHERS THEN
  v_errm := SQLCODE || '-' || SQLERRM;
  return;
END;
