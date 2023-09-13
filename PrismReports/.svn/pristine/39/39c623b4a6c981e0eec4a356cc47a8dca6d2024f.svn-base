--------------------------------------------------------
--  DDL for Procedure XXPM_APPROVAL_UPD_RESPONSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_APPROVAL_UPD_RESPONSE" (
    p_func_id    IN NUMBER,
    p_ref_id     IN NUMBER, -- pk of respective function
    p_table_name IN VARCHAR2,
    p_err_code OUT VARCHAR2,
    p_err_msg OUT VARCHAR2)
AS
  l_booking_type NUMBER;
  l_offer_hdr_id NUMBER;
  l_unit_id      NUMBER;
BEGIN
  p_err_code            := '0';
  p_err_msg             := 'Success';
  IF upper(p_table_name) ='XXPM_BOOKING_HEADER' THEN
    BEGIN
      SELECT BOOKING_TYPE,
        OFFER_HDR_ID
      INTO l_booking_type,
        l_offer_hdr_id
      FROM XXPM_BOOKING_HEADER
      WHERE BOOKING_HDR_ID = p_ref_id
      AND FUNC_ID          =p_func_id;
    EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('exception in getting OFFER_HDR_ID ,BOOKING_TYPE ');
      p_err_msg := 'invalid BOOKING_TYPE,OFFER_HDR_ID  ';
    END;
    BEGIN
      SELECT UNIT_ID
      INTO l_unit_id
      FROM XXPM_BOOKING_detail
      WHERE BOOKING_HDR_ID =p_ref_id;
    EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('exception in getting UNIT_ID  ');
      p_err_msg:= p_err_msg|| 'invalid UNIT_ID ';
    END;
    
    if l_booking_type ='SB' or l_booking_type ='BL' then
    UPDATE XXPM_BOOKING_HEADER
    SET BOOKING_STAGE    ='BD',
      STATUS             = 'APR'
    WHERE BOOKING_HDR_ID =p_ref_id
    AND FUNC_ID          =p_func_id;
    UPDATE xxpm_offer_header SET status ='BK' WHERE OFFER_HDR_ID=l_offer_hdr_id;
    UPDATE XXPM_PROPERTY_UNITS SET status ='BOOK' WHERE UNIT_ID =L_UNIT_ID;
    end if;
    IF l_booking_type ='BL' THEN
      UPDATE XXPM_BLOCK_HEADER SET status ='BO' WHERE OFFER_HDR_ID =l_offer_hdr_id;
    END IF;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  p_err_code := '1';
  p_err_msg  := SUBSTR (sqlerrm, 1, 2000);
  dbms_output.put_line('STAUS==>  ' || p_err_code ||' ' || p_err_msg ) ;
END;
