--------------------------------------------------------
--  DDL for Procedure XXPM_OFFER_DETAIL_SERVICE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_OFFER_DETAIL_SERVICE" (
    XXPM_OFFER_DETAIL_TYPE_T XXPM_OFFER_DETAIL_TYPE,
    p_offer_detail_id out number)
AS

V_TEMP NUMBER;
  cursor c1(p_offer_detail_id NUMBER)
  is
    select 1 
    from XXPM_OFFER_DETAIL 
    where OFFER_DTL_ID = p_offer_detail_id;

BEGIN
  FOR i IN 1..XXPM_OFFER_DETAIL_TYPE_T.count
  LOOP
  SELECT XXPM_OFFER_DETAIL_TYPE_T(i).OFFER_DTL_ID INTO p_offer_detail_id FROM DUAL;

      OPEN C1(p_offer_detail_id);
      FETCH C1 INTO V_TEMP;
        IF C1%NOTFOUND 
        THEN
            select OFFER_DTL_ID_S.NEXTVAL INTO p_offer_detail_id from dual;
        ELSE
            NULL;
        END IF;
      CLOSE C1;
    MERGE INTO XXPM_OFFER_DETAIL a USING
    (SELECT 
	    p_offer_detail_id                               OFFER_DTL_ID       ,
      XXPM_OFFER_DETAIL_TYPE_T(i).OFFER_HDR_ID        OFFER_HDR_ID       ,
      XXPM_OFFER_DETAIL_TYPE_T(i).PROPERTY_ID         PROPERTY_ID        ,
      XXPM_OFFER_DETAIL_TYPE_T(i).BUILDING_ID         BUILDING_ID        ,
      XXPM_OFFER_DETAIL_TYPE_T(i).UNIT_ID             UNIT_ID            ,
      XXPM_OFFER_DETAIL_TYPE_T(i).UOM                 UOM                ,
      XXPM_OFFER_DETAIL_TYPE_T(i).QUANTITY            QUANTITY           ,
      XXPM_OFFER_DETAIL_TYPE_T(i).BASE_RATE           BASE_RATE          ,
      XXPM_OFFER_DETAIL_TYPE_T(i).OFFER_AMOUNT        OFFER_AMOUNT       ,
      XXPM_OFFER_DETAIL_TYPE_T(i).PL_MOD_ID           PL_MOD_ID          ,
      XXPM_OFFER_DETAIL_TYPE_T(i).DISC_PCT            DISC_PCT           ,
      XXPM_OFFER_DETAIL_TYPE_T(i).DISC_AMOUNT         DISC_AMOUNT        ,
      XXPM_OFFER_DETAIL_TYPE_T(i).TAX_CODE            TAX_CODE           ,
      XXPM_OFFER_DETAIL_TYPE_T(i).TAX_RATE            TAX_RATE           ,
      XXPM_OFFER_DETAIL_TYPE_T(i).TAX_AMOUNT          TAX_AMOUNT         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE_CATEGORY  ATTRIBUTE_CATEGORY ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE1          ATTRIBUTE1         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE2          ATTRIBUTE2         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE3          ATTRIBUTE3         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE4          ATTRIBUTE4         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE5          ATTRIBUTE5         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE6          ATTRIBUTE6         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE7          ATTRIBUTE7         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE8          ATTRIBUTE8         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE9          ATTRIBUTE9         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE10         ATTRIBUTE10        ,
      XXPM_OFFER_DETAIL_TYPE_T(i).CREATED_BY          CREATED_BY         ,
      XXPM_OFFER_DETAIL_TYPE_T(i).CREATION_DATE       CREATION_DATE      ,
      XXPM_OFFER_DETAIL_TYPE_T(i).LAST_UPDATED_BY     LAST_UPDATED_BY    ,
      XXPM_OFFER_DETAIL_TYPE_T(i).LAST_UPDATE_DATE    LAST_UPDATE_DATE   ,
      XXPM_OFFER_DETAIL_TYPE_T(i).LAST_UPDATE_LOGIN   LAST_UPDATE_LOGIN ,
      XXPM_OFFER_DETAIL_TYPE_T(i).DISC_TYPE           DISC_TYPE ,
      XXPM_OFFER_DETAIL_TYPE_T(i).MIN_PRICE           MIN_PRICE 
    FROM DUAL
    ) b ON (a.OFFER_DTL_ID = b.OFFER_DTL_ID)
  WHEN MATCHED THEN
    UPDATE
    SET OFFER_HDR_ID       = b.OFFER_HDR_ID      ,
      PROPERTY_ID        = b.PROPERTY_ID         ,
      BUILDING_ID        = b.BUILDING_ID         ,
      UNIT_ID            = b.UNIT_ID             ,
      UOM                = b.UOM                 ,
      QUANTITY           = b.QUANTITY            ,
      BASE_RATE          = b.BASE_RATE           ,
      OFFER_AMOUNT       = b.OFFER_AMOUNT        ,
      PL_MOD_ID          = b.PL_MOD_ID           ,
      DISC_PCT           = b.DISC_PCT            ,
      DISC_AMOUNT        = b.DISC_AMOUNT         ,
      TAX_CODE           = b.TAX_CODE            ,
      TAX_RATE           = b.TAX_RATE            ,
      TAX_AMOUNT         = b.TAX_AMOUNT          ,
      ATTRIBUTE_CATEGORY = b.ATTRIBUTE_CATEGORY  ,
      ATTRIBUTE1         = b.ATTRIBUTE1          ,
      ATTRIBUTE2         = b.ATTRIBUTE2          ,
      ATTRIBUTE3         = b.ATTRIBUTE3          ,
      ATTRIBUTE4         = b.ATTRIBUTE4          ,
      ATTRIBUTE5         = b.ATTRIBUTE5          ,
      ATTRIBUTE6         = b.ATTRIBUTE6          ,
      ATTRIBUTE7         = b.ATTRIBUTE7          ,
      ATTRIBUTE8         = b.ATTRIBUTE8          ,
      ATTRIBUTE9         = b.ATTRIBUTE9          ,
      ATTRIBUTE10        = b.ATTRIBUTE10         ,
      CREATED_BY         = b.CREATED_BY          ,
      CREATION_DATE      = b.CREATION_DATE       ,
      LAST_UPDATED_BY    = b.LAST_UPDATED_BY     ,
      LAST_UPDATE_DATE   = b.LAST_UPDATE_DATE    ,
      LAST_UPDATE_LOGIN  = b.LAST_UPDATE_LOGIN   ,
      DISC_TYPE          = b.DISC_TYPE   ,
      MIN_PRICE          = b.MIN_PRICE   
	  WHEN NOT MATCHED THEN
    INSERT
      (
        OFFER_DTL_ID       ,
		OFFER_HDR_ID       ,
		PROPERTY_ID        ,
		BUILDING_ID        ,
		UNIT_ID            ,
		UOM                ,
		QUANTITY           ,
		BASE_RATE          ,
		OFFER_AMOUNT       ,
		PL_MOD_ID          ,
		DISC_PCT           ,
		DISC_AMOUNT        ,
		TAX_CODE           ,
		TAX_RATE           ,
		TAX_AMOUNT         ,
		ATTRIBUTE_CATEGORY ,
		ATTRIBUTE1         ,
		ATTRIBUTE2         ,
		ATTRIBUTE3         ,
		ATTRIBUTE4         ,
		ATTRIBUTE5         ,
		ATTRIBUTE6         ,
		ATTRIBUTE7         ,
		ATTRIBUTE8         ,
		ATTRIBUTE9         ,
		ATTRIBUTE10        ,
		CREATED_BY         ,
		CREATION_DATE      ,
		LAST_UPDATED_BY    ,
		LAST_UPDATE_DATE   ,
		LAST_UPDATE_LOGIN , 	
        DISC_TYPE          ,
        MIN_PRICE          
      )
      VALUES
      (
        p_offer_detail_id,
        XXPM_OFFER_DETAIL_TYPE_T(i).OFFER_HDR_ID      ,
        XXPM_OFFER_DETAIL_TYPE_T(i).PROPERTY_ID       ,
        XXPM_OFFER_DETAIL_TYPE_T(i).BUILDING_ID       ,
        XXPM_OFFER_DETAIL_TYPE_T(i).UNIT_ID           ,
        XXPM_OFFER_DETAIL_TYPE_T(i).UOM               ,
        XXPM_OFFER_DETAIL_TYPE_T(i).QUANTITY          ,
        XXPM_OFFER_DETAIL_TYPE_T(i).BASE_RATE         ,
        XXPM_OFFER_DETAIL_TYPE_T(i).OFFER_AMOUNT      ,
        XXPM_OFFER_DETAIL_TYPE_T(i).PL_MOD_ID         ,
        XXPM_OFFER_DETAIL_TYPE_T(i).DISC_PCT          ,
        XXPM_OFFER_DETAIL_TYPE_T(i).DISC_AMOUNT       ,
        XXPM_OFFER_DETAIL_TYPE_T(i).TAX_CODE          ,
        XXPM_OFFER_DETAIL_TYPE_T(i).TAX_RATE          ,
        XXPM_OFFER_DETAIL_TYPE_T(i).TAX_AMOUNT        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE_CATEGORY,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE1        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE2        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE3        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE4        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE5        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE6        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE7        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE8        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE9        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).ATTRIBUTE10       ,
        XXPM_OFFER_DETAIL_TYPE_T(i).CREATED_BY        ,
        XXPM_OFFER_DETAIL_TYPE_T(i).CREATION_DATE     ,
        XXPM_OFFER_DETAIL_TYPE_T(i).LAST_UPDATED_BY   ,
        XXPM_OFFER_DETAIL_TYPE_T(i).LAST_UPDATE_DATE  ,
        XXPM_OFFER_DETAIL_TYPE_T(i).LAST_UPDATE_LOGIN ,
        XXPM_OFFER_DETAIL_TYPE_T(i).DISC_TYPE         ,
        XXPM_OFFER_DETAIL_TYPE_T(i).MIN_PRICE          
      );
    -- due to db link  commit;
  END LOOP;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END XXPM_OFFER_DETAIL_SERVICE;
