--------------------------------------------------------
--  DDL for Procedure OFFER_MILESTONE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "OFFER_MILESTONE" (
      p_OFFER_MS_DTL_ID in number ,
      p_OFFER_HDR_ID in number ,
      p_MS_DTL_ID in VARCHAR2 ,
      p_PL_MOD_ID in VARCHAR2 ,
      p_SEQ_NUMBER in VARCHAR2 ,
      p_INSTALLMENT_TYPE in VARCHAR2 ,
      p_INSTALLMENT_PCT in VARCHAR2 ,
      p_INSTALLMENT_AMOUNT in VARCHAR2 ,
      p_CHARGE_TYPE in VARCHAR2 ,
      p_PAYMENT_TERM in VARCHAR2 ,
      p_REMARKS in VARCHAR2 ,
      p_DUE_DAYS in VARCHAR2 ,
      p_DUE_DAYS_FROM in VARCHAR2 ,
      p_DUE_DATE in VARCHAR2 ,
      p_ATTRIBUTE_CATEGORY in VARCHAR2 ,
      p_ATTRIBUTE1 in VARCHAR2 ,
      p_ATTRIBUTE2 in VARCHAR2 ,
      p_ATTRIBUTE3 in VARCHAR2 ,
      p_ATTRIBUTE4 in VARCHAR2 ,
      p_ATTRIBUTE5 in VARCHAR2 ,
      p_ATTRIBUTE6 in VARCHAR2 ,
      p_ATTRIBUTE7 in VARCHAR2 ,
      p_ATTRIBUTE8 in VARCHAR2 ,
      p_ATTRIBUTE9 in VARCHAR2 ,
      p_ATTRIBUTE10 in VARCHAR2 ,
      p_CREATED_BY in VARCHAR2 ,
      p_CREATION_DATE in VARCHAR2 ,
      p_LAST_UPDATED_BY in VARCHAR2 ,
      p_LAST_UPDATE_DATE in VARCHAR2 ,
      p_LAST_UPDATE_LOGIN in VARCHAR2 ,
      p_MILESTONE_TYPE in VARCHAR2 ,
      p_UOM in VARCHAR2 ,
      p_QUANTITY in VARCHAR2 ,
      p_RATE in VARCHAR2 ,
      p_WAVE_OFF in VARCHAR2 ,
      p_INSTALLMENT_METHOD in VARCHAR2 ,
      p_INSTALLMENT_EVENT in VARCHAR2 ,
      p_PERIOD_OCCURENCE in VARCHAR2 ,
      p_PERIOD_VALUES in VARCHAR2 ,
      p_PERIOD_DURATION in VARCHAR2 ,
      p_INCLUDED_IN_RATE in VARCHAR2 ,
    status OUT  VARCHAR2 ,
    ErrorMessage OUT VARCHAR2,
    out_offer_ms OUT VARCHAR2 )
AS
  L_CURSOR SYS_REFCURSOR;
BEGIN
  INSERT
  INTO XXPM_OFFER_milestone_detail
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
           p_OFFER_MS_DTL_ID,
      p_OFFER_HDR_ID,
      p_MS_DTL_ID,
      p_PL_MOD_ID,
      p_SEQ_NUMBER,
      p_INSTALLMENT_TYPE,
      p_INSTALLMENT_PCT,
      p_INSTALLMENT_AMOUNT,
      p_CHARGE_TYPE,
      p_PAYMENT_TERM,
      p_REMARKS,
      p_DUE_DAYS,
      p_DUE_DAYS_FROM,
      p_DUE_DATE,
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
      p_LAST_UPDATE_LOGIN,
      p_MILESTONE_TYPE,
      p_UOM,
      p_QUANTITY,
      p_RATE,
      p_WAVE_OFF,
      p_INSTALLMENT_METHOD,
      p_INSTALLMENT_EVENT,
      p_PERIOD_OCCURENCE,
      p_PERIOD_VALUES,
      p_PERIOD_DURATION,
      p_INCLUDED_IN_RATE
    );
  status        :='Success';
  ErrorMessage  := NULL;
  out_offer_ms :=p_OFFER_MS_DTL_ID;
  OPEN L_CURSOR FOR SELECT status ,
  ErrorMessage ,
  out_offer_ms FROM dual;
  APEX_JSON.WRITE(L_CURSOR);
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  out_offer_ms:= NULL;
  status       :='Failed';
  ErrorMessage :=SUBSTR (sqlerrm, 1, 2000);
  OPEN L_CURSOR FOR SELECT status ,
  ErrorMessage ,
  out_offer_ms FROM dual;
  APEX_JSON.WRITE(L_CURSOR);
  COMMIT;
END ;
