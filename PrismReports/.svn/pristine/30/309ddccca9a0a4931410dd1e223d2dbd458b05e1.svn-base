--------------------------------------------------------
--  DDL for Procedure OFFER_DETAIL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "OFFER_DETAIL" (
p_OFFER_DTL_ID in varchar2,
  p_OFFER_HDR_ID in varchar2,
  p_PROPERTY_ID in varchar2,
  p_BUILDING_ID in varchar2,
  p_UNIT_ID in varchar2,
  p_UOM in varchar2,
  p_QUANTITY in varchar2,
  p_BASE_RATE  in varchar2,
  p_OFFER_AMOUNT in varchar2,
  p_PL_MOD_ID in varchar2,
  p_DISC_PCT in varchar2,
  p_DISC_AMOUNT in varchar2,
  p_TAX_CODE in varchar2,
  p_TAX_RATE in varchar2,
  p_TAX_AMOUNT in varchar2,
  p_ATTRIBUTE_CATEGORY in varchar2,
  p_ATTRIBUTE1 in varchar2,
  p_ATTRIBUTE2 in varchar2,
  p_ATTRIBUTE3 in varchar2,
  p_ATTRIBUTE4 in varchar2,
  p_ATTRIBUTE5 in varchar2,
  p_ATTRIBUTE6 in varchar2,
  p_ATTRIBUTE7 in varchar2,
  p_ATTRIBUTE8 in varchar2,
  p_ATTRIBUTE9 in varchar2,
  p_ATTRIBUTE10 in varchar2,
  p_CREATED_BY in varchar2,
  p_CREATION_DATE in varchar2,
  p_LAST_UPDATED_BY in varchar2,
  p_LAST_UPDATE_DATE in varchar2,
  p_LAST_UPDATE_LOGIN in varchar2 ,
      status out varchar2 ,
      ErrorMessage out varchar2,
     out_offer_dtl out varchar2
  )
AS
  L_CURSOR SYS_REFCURSOR;
BEGIN
  INSERT
  INTO XXPM_OFFER_DETAIL
    (
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
  LAST_UPDATE_LOGIN
    )
    VALUES
    (
  p_OFFER_DTL_ID,
  p_OFFER_HDR_ID,
  p_PROPERTY_ID,
  p_BUILDING_ID,
  p_UNIT_ID,
  p_UOM,
  p_QUANTITY,
  p_BASE_RATE,
  p_OFFER_AMOUNT,
  p_PL_MOD_ID,
  p_DISC_PCT,
  p_DISC_AMOUNT,
  p_TAX_CODE,
  p_TAX_RATE,
  p_TAX_AMOUNT,
  p_ATTRIBUTE_CATEGORY,
  p_ATTRIBUTE1,
  p_ATTRIBUTE2,
  p_ATTRIBUTE3,
  p_ATTRIBUTE4,
  p_ATTRIBUTE5,
  p_ATTRIBUTE6,
  p_ATTRIBUTE7,
  p_ATTRIBUTE8,
  p_ATTRIBUTE9,
  p_ATTRIBUTE10,
  p_CREATED_BY,
  p_CREATION_DATE,
  p_LAST_UPDATED_BY,
  p_LAST_UPDATE_DATE,
  p_LAST_UPDATE_LOGIN
    );
  status :='Success';
  ErrorMessage := null;
  out_offer_dtl :=p_OFFER_HDR_ID;
    OPEN L_CURSOR FOR select status ,ErrorMessage , out_offer_dtl from dual;
    APEX_JSON.WRITE(L_CURSOR);
  COMMIT;
  
   exception when others then
    out_offer_dtl:= null;
  status :='Failed';
  ErrorMessage :=substr (sqlerrm, 1, 2000);
    OPEN L_CURSOR FOR select status ,ErrorMessage , out_offer_dtl from dual;
    APEX_JSON.WRITE(L_CURSOR);
  COMMIT;
  
END ;
