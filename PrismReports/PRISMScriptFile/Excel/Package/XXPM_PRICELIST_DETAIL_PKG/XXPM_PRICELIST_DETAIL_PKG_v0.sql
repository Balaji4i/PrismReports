CREATE OR REPLACE PACKAGE "XXPM_PRICELIST_DETAIL_PKG" 
IS
  PROCEDURE xxpm_pricelist_detail_val
    (
      i_batch_id IN NUMBER
    )
    ;
  PROCEDURE xxdm_pl_lines_update
    (
      v_batch_id    IN NUMBER,
    v_rowid      IN VARCHAR2,
      v_err_desc    IN VARCHAR2,
      v_status_flag IN VARCHAR2,
      v_err_msg     IN VARCHAR2 )
    ;
PROCEDURE xxpm_pl_lines_insert_history(
    v_PL_ID       IN NUMBER ,
    v_pll_id      IN NUMBER ,
    v_BATCH_ID    IN NUMBER ,
    V_PROPERTY_ID IN NUMBER,
    V_BUILD_ID    IN NUMBER,
    V_UNIT_ID     IN NUMBER) ;
  PROCEDURE xxpm_pl_lines_update
    (
      v_PLL_ID      IN NUMBER,
      v_property_id IN NUMBER,
      v_build_id    IN NUMBER,
      v_unit_id     IN NUMBER,
      v_BATCH_ID    IN NUMBER
    )
    ;
  PROCEDURE xxpm_pl_lines_insert
    (
      v_batch_id      IN NUMBER

    )
    ;
END XXPM_PRICELIST_DETAIL_PKG;


/


CREATE OR REPLACE PACKAGE BODY XXPM_PRICELIST_DETAIL_PKG
AS
  --==============================================================================
  ---------------------PriceList  Validations---------------------------------------
  --==============================================================================
PROCEDURE xxpm_pricelist_detail_val(
    i_batch_id IN NUMBER)
AS
  CURSOR c_pl_temp
  is
    SELECT rowid, PLL_ID,
      PL_NUMBER,
      PROPERTY_NUMBER,
      BUILD_NUMBER,
      UNIT_NUMBER,
      UOM,
      BASE_PRICE,
      MIN_PRICE,
      START_DATE,
      END_DATE,
      REVISION_NO,
      REVISION_DATE,
      REVISED_BY,
      ACTIVE_YN,
      CREATED_BY,
      CREATION_DATE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      BUILD_ID,
      BATCH_ID,
      INTERFACE_STATUS_FLAG,
      INTERFACE_ID,
      ERR_MSG,
      ERR_DESCRIPTION
    FROM xxdm_pl_lines
    WHERE BATCH_ID=i_batch_id and
    interface_status_flag !='E'
    ;
  v_batch_id        NUMBER;
  v_ready_flag      VARCHAR2 (1);
  v_PLL_ID          VARCHAR2(150);
  v_org_id          VARCHAR2(150);
  v_pl_num          VARCHAR2(150);
  v_start_date      DATE;
  v_end_date        DATE;
  v_pl_count        NUMBER;
  v_status          VARCHAR2(150);
  v_trans_status    VARCHAR2(150);
  v_batch_id        VARCHAR2(150);
  v_pl_type         VARCHAR2(150);
  v_area_uom        VARCHAR2(150);
  v_pl_nunber       VARCHAR2(150);
  v_pl_nunber1      VARCHAR2(150);
  v_PLL_ID1         VARCHAR2(150);
  v_action_flag     VARCHAR2(10);
  v_err_reason      VARCHAR2 (2000);
  v_err_desc        VARCHAR2 (2000);
  v_errm            VARCHAR2 (2000);
  v_property_id     NUMBER;
  vu_property_id    NUMBER;
  v_build_id        NUMBER;
  v_unit_id         NUMBER;
  vuu_property_id   VARCHAR2(400);
  v_property_number VARCHAR2 (60);
  v_build_number    VARCHAR2 (60);
  v_unit_number     VARCHAR2 (60);
  V_STATUS1         VARCHAR2 (60);
  V_BASE_PRICE      NUMBER;
  V_MIN_PRICE       NUMBER;
  v_revision_no   number;
  l_cnt number ;
    l_cnt_1 number ;



BEGIN
  FOR i IN c_pl_temp
  LOOP
    v_ready_flag  := 'V';
    v_err_reason  := NULL;
    v_errm        := NULL;
    v_action_flag := NULL;
    V_ERR_DESC    := NULL;
    V_BASE_PRICE  := i.BASE_PRICE;
    V_MIN_PRICE   :=i.MIN_PRICE;
    --------------------------------------------------------------------------------
    ----------------Validate Date---------------------------------------------------
    --------------------------------------------------------------------------------
      DBMS_OUTPUT.PUT_LINE('Validate Date');
    BEGIN
      SELECT start_date,
        end_date
      INTO v_start_date,
        v_end_date
      FROM xxdm_pl_lines
      where PL_NUMBER = I.PL_NUMBER
      and rowid  = i.rowid
      AND batch_id = i.batch_id;
        DBMS_OUTPUT.PUT_LINE('Start Date '||v_start_date||','||'End Date '||v_end_date);
    EXCEPTION
    WHEN OTHERS THEN
      v_PLL_ID     :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate property_number---------------------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT property_id,
        property_number
      INTO v_property_id,
        v_property_number
      FROM xxpm_property_master
      WHERE property_number=i.property_number;
    EXCEPTION
    WHEN OTHERS THEN
      v_property_id:='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate UNIT_NUMBER---------------------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT UNIT_ID,
        UNIT_NUMBER
      INTO v_unit_id,
        v_unit_number
      FROM xxpm_property_units
      WHERE UNIT_NUMBER=i.UNIT_NUMBER;
    EXCEPTION
    WHEN OTHERS THEN
      v_property_id:='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate build_number---------------------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT build_id,
        build_number
      INTO v_build_id,
        v_build_number
      FROM xxpm_property_buildings
      WHERE build_number=i.build_number;
    EXCEPTION
    WHEN OTHERS THEN
      v_build_id   := '';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate build_number,v_property_number,UNIT_NUMBER----------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT xb.property_id,
        xu.property_id,
        xuu.property_id,
        xb.build_id,
        xu.property_number,
        xb.build_number,
        xuu.unit_id
      INTO v_property_id,
        vu_property_id,
        vuu_property_id,
        v_build_id,
        v_property_number,
        v_build_number,
        v_unit_id
      FROM xxpm_property_master xu,
        xxpm_property_buildings xb,
        xxpm_property_units xuu
      WHERE xu.property_id  =xb.PROPERTY_ID
      AND xb.BUILD_ID       =xuu.BUILD_ID
      AND xb.build_number   =i.build_number
      AND xu.property_number=i.property_number
      AND xuu.UNIT_NUMBER   =i.UNIT_NUMBER;
    EXCEPTION
    WHEN OTHERS THEN
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Update build_id,property_id,unit_id----------------------------
    --------------------------------------------------------------------------------
    BEGIN
      UPDATE xxdm_pl_lines
      SET property_id    = v_property_id,
        build_id         =v_build_id,
        unit_id          =v_unit_id
      WHERE build_number =i.build_number
      AND rowid         =i.rowid
      AND property_number=i.property_number
      AND UNIT_NUMBER    =i.UNIT_NUMBER
      AND BATCH_ID       =i.BATCH_ID;
      DBMS_OUTPUT.PUT_LINE('Unit number:- ' ||i.unit_number || 'Row Count:- ' ||v_property_id);
      COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate UOM------------------------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT lookup_value_name
      INTO v_area_uom
      FROM xxfnd_lookup_v
      WHERE lookup_type_name='AREA_UOM'
      AND lookup_value_name =i.UOM;
    EXCEPTION
    WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('1');
      v_area_uom   :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;



    ---------------------VALIDATION ------

    BEGIN


    IF I.PLL_ID IS NULL THEN


     L_CNT_1:=0;
    ELSE

L_CNT_1:=1;

    END IF;



    END ;






    --------------------------------------------------------------------------------
    ----------------Validate Master Status---------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      v_status :=NULL;

      select count(*) into l_cnt FROM xxpm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER AND status      ='APR';

     if l_cnt  >0 then  
      SELECT status,
        PL_NUMBER,revision_no
      INTO v_status,
        v_pl_nunber ,
        v_revision_no
      FROM xxpm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER
      AND status      ='APR';

      end if;
      SELECT status,
        PL_NUMBER
      INTO v_status1,
        v_pl_nunber1
      FROM xxdm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER
      AND BATCH_ID    =i.BATCH_ID
      AND status      ='APR';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('2');

      v_PLL_ID     :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Conditions---------------------------------------
    --------------------------------------------------------------------------------
    IF V_BASE_PRICE           >= V_MIN_PRICE THEN
      IF (v_property_id      IS NOT NULL) THEN
        IF (v_build_id       IS NOT NULL) THEN
          IF(v_unit_id       IS NOT NULL ) THEN
            IF(v_property_id  = vu_property_id AND vu_property_id = vuu_property_id AND v_property_id = vuu_property_id) THEN
                   IF NVL(v_start_date,sysdate) < NVL(v_end_date,v_start_date+1) THEN             --ok
--              IF L_CNT > 0 THEN

              IF(v_area_uom   =i.UOM OR i.UOM IS NULL) THEN

              IF L_CNT > 0 THEN
                v_ready_flag := 'V';
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
                --                IF (v_status=v_status1 AND v_pl_nunber=v_pl_nunber1) THEN
                --                  xxpm_pl_lines_insert_history (i.PLL_ID);
                --                  xxpm_pl_lines_update (i.PLL_ID,v_property_id,v_build_id,v_unit_id,i.BATCH_ID);
                --                  v_ready_flag := 'V';
                --                ELSE
                --                  IF(v_status<>v_status1 AND v_pl_nunber=v_pl_nunber1) THEN
                --                    xxpm_pl_lines_update (i.PLL_ID,v_property_id,v_build_id,v_unit_id,i.BATCH_ID);
                --                  END IF;
                --                END IF;

                ELSE
                 IF   TRUNC(SYSDATE) <= TRUNC(v_start_date) THEN
                 v_ready_flag      := 'V';
                            xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

                 ELSE
                     v_ready_flag := 'E';
      v_err_desc       := 'start_date  CANNOT BE LESS THAN SYSDATE';
                                    xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);


                END IF;

                END IF;
              ELSE
                       DBMS_OUTPUT.PUT_LINE('21');

                v_ready_flag := 'E';
                v_err_desc   := 'PriceList UOM  should not be null';
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
              END IF;

          ELSE
             v_ready_flag := 'E';
        v_err_desc   := 'Start date should not be greater than End Date';
                          xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

          END IF;
            ELSE
                                   DBMS_OUTPUT.PUT_LINE('26');

              v_property_number:=i.property_number;
              v_build_number   :=i.build_number;
                              v_ready_flag := 'E';

              v_err_desc     := i.property_number || ':- PROPERTY NUMBER IS NOT BELONGS TO THE '|| i.BUILD_NUMBER ||':- BUILDING NUMBER';
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
            END IF;
          ELSE
                                             DBMS_OUTPUT.PUT_LINE('27');

                          v_ready_flag := 'E';

            v_property_number:=i.property_number;
            v_build_number   :=i.build_number;
            v_err_desc     := i.property_number||':- Property is not having the mentioned Unit Number ' ||i.UNIT_NUMBER;
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
          END IF;
        ELSE
                                                     DBMS_OUTPUT.PUT_LINE('28');

                        v_ready_flag := 'E';

          v_property_number:=i.property_number;
          v_build_number   :=i.build_number;
          v_err_desc     := i.property_number||':- Property is not having the mentioned Build Number ' ||i.build_number;
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
        END IF;
      ELSE

                                                           DBMS_OUTPUT.PUT_LINE('29');

                      v_ready_flag := 'E';

        v_property_number:=i.property_number;
        v_build_number   :=i.build_number;
        v_err_desc     := i.property_number||':- Property is not having the mentioned Property Number ' ||i.property_number;
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
      END IF;
    ELSE

                                                               DBMS_OUTPUT.PUT_LINE('30');

                          v_ready_flag := 'E';

      v_err_desc := ' Minimum Price should not be greater than base price ' ;
                xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;




    --------------------------------------------------------------------------------
    ----------------Mandatory Conditions---------------------------------------
    --------------------------------------------------------------------------------

         if  i.pl_number is null then
         dbms_output.put_line('   pl_number is null ');
        v_ready_flag := 'E';
        v_err_desc := 'pl_number should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;

    if  i.property_number is null then
         dbms_output.put_line('   property_number is null ');
        v_ready_flag := 'E';
        v_err_desc := 'property_number should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;
    if  i.build_number is null then
         dbms_output.put_line('   build_number is null ');
        v_ready_flag := 'E';
        v_err_desc := 'build_number should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;
    if  i.unit_number is null then
         dbms_output.put_line('   unit_number is null ');
        v_ready_flag := 'E';
        v_err_desc := 'unit_number should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;
    if  i.uom is null then
         dbms_output.put_line('   uom is null ');
        v_ready_flag := 'E';
        v_err_desc := 'uom should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;

    if  i.base_price is null then
         dbms_output.put_line('   base_price is null ');
        v_ready_flag := 'E';
        v_err_desc := 'base_price should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;
    if  i.min_price is null then
         dbms_output.put_line('   min_price is null ');
        v_ready_flag := 'E';
        v_err_desc := 'min_price should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;

    if  i.start_date is null then
         dbms_output.put_line('   start_date is null ');
        v_ready_flag := 'E';
        v_err_desc := 'start_date should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;
    if  i.end_date is null then
         dbms_output.put_line('   end_date is null ');
        v_ready_flag := 'E';
        v_err_desc := 'end_date should not be  null ' ;
      xxdm_pl_lines_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

    END IF;


  END LOOP;
  COMMIT;
END xxpm_pricelist_detail_val;
--------------------------------------------------------------------------------
----------------Update Demo Table-----------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE xxdm_pl_lines_update(
    v_batch_id    IN NUMBER,
    v_rowid      IN VARCHAR2,
    v_err_desc    IN VARCHAR2,
    v_status_flag IN VARCHAR2,
    v_err_msg     IN VARCHAR2
   )
AS

l_pl_number   VARCHAR2(50);
BEGIN
  UPDATE xxdm_pl_lines
  SET INTERFACE_STATUS_FLAG=v_status_flag,
    ERR_DESCRIPTION        = v_err_desc,
    ERR_MSG                =v_err_msg
  WHERE rowid             =v_rowid
  AND batch_id             =v_batch_id ;

  SELECT pl_number into l_pl_number FROM xxdm_pl_lines 
  WHERE ROWID             =v_rowid
  AND batch_id             =v_batch_id ;



   IF v_status_flag='E' THEN

    UPDATE   xxdm_pl_modifiers
            SET          INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Line item validation failed with  '||v_err_desc,
                         ERR_MSG=v_err_msg
            WHERE     l_pl_number =l_pl_number
                and batch_id=v_batch_id ;  


      UPDATE   xxdm_pl_qualifiers
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Line item validation failed with  '||v_err_desc,
                           ERR_MSG=v_err_msg
        WHERE PL_MOD_ID IN(SELECT pl_mod_id FROM xxdm_pl_modifiers WHERE pl_number =l_pl_number  AND batch_id =v_batch_id)
            and batch_id=v_batch_id ;  



  END IF;







  COMMIT;
  --    SELECT PLL_ID INTO l_pm_PLL_ID FROM xxdm_pl_header WHERE PLL_ID=v_PLL_ID;
  --    IF l_pm_PLL_ID <> v_PLL_ID THEN
  --      xxpm_pricelist_insert(v_PLL_ID);
  --    END IF;
END xxdm_pl_lines_update;
--------------------------------------------------------------------------------
----------------Insert Into History Table--------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE xxpm_pl_lines_insert_history(
    v_PL_ID IN NUMBER   ,v_pll_id in number , v_BATCH_ID in number ,V_PROPERTY_ID in number,V_BUILD_ID in number,V_UNIT_ID in number)
AS

CURSOR c_dm_lines
IS
select * from xxdm_pl_lines where batch_id =v_BATCH_ID and pll_id =v_pll_id and nvl(History_insert,'N') ='N';

  CURSOR c_pl_history
  IS
    SELECT PLL_ID,
      PL_ID,
      PROPERTY_ID,
      BUILD_ID,
      UNIT_ID,
      UOM,
      BASE_PRICE,
      MIN_PRICE,
      START_DATE,
      END_DATE,
      REVISION_NO,
      REVISION_DATE,
      REVISED_BY,
      ACTIVE_YN,
      CREATED_BY,
      CREATION_DATE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN
    FROM xxpm_pl_lines
    WHERE PL_ID =v_PL_ID;

   CURSOR c_pl_master_h
   is
    SELECT distinct   xph.PL_ID,
      xph.PL_NAME,
      xph.PL_NAME_TL,
      xph.DESCRIPTION,
      xph.ORG_ID,
      xph.FUNC_ID,
      xph.PL_TYPE,
      xph.PRIORITY,
      xph.USAGE,
      xph.CURRENCY_CODE,
      xph.START_DATE,
      xph.END_DATE,
      xph.REVISION_NO,
      xph.REVISION_DATE,
      xph.REVISED_BY,
      xph.STATUS,
      xph.FLOW_STATUS,
      xph.FLOW_LEVEL,
      xph.USER_GRP_ID,
      xph.BASE_PRICE_YN,
      xph.ACTIVE_YN,
      xph.CREATED_BY,
      xph.CREATION_DATE,
      xph.LAST_UPDATED_BY,
      xph.LAST_UPDATE_DATE,
      xph.LAST_UPDATE_LOGIN,
      xph.PL_NUMBER 
FROM 
xxpm_pl_header xph
WHERE xph.pl_id =v_PL_ID;

 CURSOR c_pl_modifier_h
    IS
   SELECT PL_MOD_ID,
  PL_ID,
  MOD_ID,
  START_DATE,
  END_DATE,
  REVISION_NO,
  REVISION_DATE,
  REVISED_BY,
  ACTIVE_YN,
  CREATED_BY,
  CREATION_DATE,
  LAST_UPDATED_BY,
  LAST_UPDATE_DATE,
  LAST_UPDATE_LOGIN
FROM xxpm_pl_modifiers xpm
WHERE xpm.pl_id =v_PL_ID;
--and xpm.PL_NUMBER =v_PL_NUMBER;

  CURSOR c_pl_qualifier_h
    IS
    SELECT xpq.PL_QLFY_ID,
  xpq.PL_MOD_ID,
  xpq.QLFY_ID,
  xpq.START_DATE,
  xpq.END_DATE,
  xpq.REVISION_NO,
  xpq.REVISION_DATE,
  xpq.REVISED_BY,
  xpq.ACTIVE_YN,
  xpq.CREATED_BY,
  xpq.CREATION_DATE,
  xpq.LAST_UPDATED_BY,
  xpq.LAST_UPDATE_DATE,
  xpq.LAST_UPDATE_LOGIN
  FROM xxpm_pl_qualifiers xpq ,
  xxpm_pl_modifiers xpm
--  xxpm_pl_header xph
WHERE xpq.pl_mod_id =xpm.pl_mod_id
--AND xpm.pl_id       =xph.pl_id
AND xpm.pl_id =v_PL_ID;

  l_pll_id_h NUMBER;
  v_revision_no number;
BEGIN


FOR o IN c_dm_lines
loop

 DBMS_OUTPUT.PUT_LINE('   c_dm_lines history  ') ;



--insert into header history
FOR j IN c_pl_master_h
loop

  INSERT
    INTO XXPM_PL_HEADER_H
      (
        PL_ID_H,
        PL_ID,
        PL_NAME,
        PL_NAME_TL,
        DESCRIPTION,
        ORG_ID,
        FUNC_ID,
        PL_TYPE,
        PRIORITY,
        USAGE,
        CURRENCY_CODE,
        START_DATE,
        END_DATE,
        REVISION_NO,
        REVISION_DATE,
        REVISED_BY,
        STATUS,
        FLOW_STATUS,
        FLOW_LEVEL,
        USER_GRP_ID,
        BASE_PRICE_YN,
        ACTIVE_YN,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        PL_NUMBER
      )
      VALUES
      (
        XXPM_PRICELIST_HISTORY_S.nextval,
        j.PL_ID,
        j.PL_NAME,
        j.PL_NAME_TL,
        j.DESCRIPTION,
        j.ORG_ID,
        j.FUNC_ID,
        j.PL_TYPE,
        j.PRIORITY,
        j.USAGE,
        j.CURRENCY_CODE,
        j.START_DATE,
        j.END_DATE,
        NVL(J.REVISION_NO,0),
        j.REVISION_DATE,
        j.REVISED_BY,
        j.STATUS,
        j.FLOW_STATUS,
        j.FLOW_LEVEL,
        j.USER_GRP_ID,
        j.BASE_PRICE_YN,
        j.ACTIVE_YN,
        j.CREATED_BY,
        sysdate,
        j.LAST_UPDATED_BY,
        sysdate,
        j.LAST_UPDATE_LOGIN,
        j.PL_NUMBER
      );


v_revision_no :=        NVL(j.REVISION_NO,0);

END loop;

--insert into lines history

  for I in C_PL_HISTORY
  LOOP

--    select PLL_ID into L_PLL_ID_H from XXPM_PL_LINES_H where PLL_ID=V_PLL_ID;
--    
--    IF l_PLL_ID_h IS NULL THEN
      INSERT
      INTO XXPM_PL_LINES_H
        (
          PLL_ID_H,
          PLL_ID,
          PL_ID,
          PROPERTY_ID,
          BUILD_ID,
          UNIT_ID,
          UOM,
          BASE_PRICE,
          MIN_PRICE,
          START_DATE,
          END_DATE,
          REVISION_NO,
          REVISION_DATE,
          REVISED_BY,
          ACTIVE_YN,
          CREATED_BY,
          CREATION_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN
        )
        VALUES
        (
          XXPM_PL_LINES_H_S.nextval,
          i.PLL_ID,
          i.PL_ID,
          i.PROPERTY_ID,
          i.BUILD_ID,
          i.UNIT_ID,
          i.UOM,
          i.BASE_PRICE,
          i.MIN_PRICE,
          i.START_DATE,
          i.END_DATE,
          v_revision_no,
          sysdate,
          i.REVISED_BY,
          i.ACTIVE_YN,
          i.CREATED_BY,
         sysdate,
          i.LAST_UPDATED_BY,
          sysdate,
          i.LAST_UPDATE_LOGIN
        );
--    END IF;
  END LOOP;


  FOR k IN c_pl_modifier_h
 loop
 insert into xxpm_pl_modifiers_h  (PL_MOD_ID_H,
PL_MOD_ID,
PL_ID,
MOD_ID,
START_DATE,
END_DATE,
REVISION_NO,
REVISION_DATE,
REVISED_BY,
ACTIVE_YN,
CREATED_BY,
CREATION_DATE,
LAST_UPDATED_BY,
LAST_UPDATE_DATE,
LAST_UPDATE_LOGIN) 
VALUES
(
XXPM_PL_MODIFIERS_H_S.nextval,
k.PL_MOD_ID,
  k.PL_ID,
  k.MOD_ID,
  k.START_DATE,
  k.END_DATE,
  v_revision_no,
SYSDATE ,--  REVISION_DATE,
  k.REVISED_BY,
  k.ACTIVE_YN,
  k.CREATED_BY,
  SYSDATE,
  k.LAST_UPDATED_BY,
  SYSDATE,
  k.LAST_UPDATE_LOGIN
);

 END loop;



  FOR q IN c_pl_qualifier_h
  loop
  INSERT
INTO xxpm_pl_qualifiers_h
  (
    PL_QLFY_ID_H,
    PL_QLFY_ID,
    PL_MOD_ID,
    QLFY_ID,
    START_DATE,
    END_DATE,
    REVISION_NO,
    REVISION_DATE,
    REVISED_BY,
    ACTIVE_YN,
    CREATED_BY,
    CREATION_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN
  )
  VALUES
  (
    XXPM_PL_QUALIFIERS_H_S.nextval,
    q.PL_QLFY_ID,
    q.PL_MOD_ID,
    q.QLFY_ID,
    q.START_DATE,
    q.END_DATE,
    v_revision_no,
    SYSDATE,
    q.REVISED_BY,
    q.ACTIVE_YN,
    q.CREATED_BY,
    SYSDATE,
    q.LAST_UPDATED_BY,
    SYSDATE,
    q.LAST_UPDATE_LOGIN
  );


  END loop;

--  update
--update the revision
      XXPM_PL_LINES_UPDATE (v_pll_id,V_PROPERTY_ID,V_BUILD_ID,V_UNIT_ID,v_BATCH_ID);


UPDATE xxdm_pl_lines SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =(SELECT PL_NUMBER FROM xxpm_pl_header WHERE pl_id =v_pl_id);

UPDATE xxdm_pl_modifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =(SELECT PL_NUMBER FROM xxpm_pl_header WHERE pl_id =v_pl_id);

UPDATE xxdm_pl_qualifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
and pl_mod_id in(
  SELECT xdm.pl_mod_id FROM xxdm_pl_modifiers xdm 
  WHERE  xdm.batch_id =v_BATCH_ID
  AND xdm.pl_number =(SELECT PL_NUMBER FROM xxpm_pl_header WHERE pl_id =v_pl_id) );

commit;

end loop;

  COMMIT;
END xxpm_pl_lines_insert_history;
--------------------------------------------------------------------------------
----------------Update PriceList base table Revision number-----------------------
--------------------------------------------------------------------------------
PROCEDURE xxpm_pl_lines_update
  (
    v_PLL_ID      IN NUMBER,
    v_property_id IN NUMBER,
    v_build_id    IN NUMBER,
    v_unit_id     IN NUMBER,
    v_BATCH_ID    IN NUMBER  )
AS
  CURSOR c_pl_base
  IS
    SELECT PLL_ID,
      PL_NUMBER,
      PROPERTY_NUMBER,
      BUILD_NUMBER,
      UNIT_NUMBER,
      UOM,
      BASE_PRICE,
      MIN_PRICE,
      START_DATE,
      END_DATE,
      REVISION_NO,
      REVISION_DATE,
      REVISED_BY,
      ACTIVE_YN,
      CREATED_BY,
      CREATION_DATE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      BUILD_ID,
      BATCH_ID,
      INTERFACE_STATUS_FLAG,
      INTERFACE_ID,
      ERR_MSG,
      ERR_DESCRIPTION
    FROM xxdm_pl_lines
    WHERE PLL_ID = v_PLL_ID
    AND BATCH_ID =v_BATCH_ID;
  l_rev_num NUMBER ;
  v_pl_id   NUMBER;
  v_status varchar2(20);

BEGIN

BEGIN

  SELECT xph.PL_ID,  NVL(xph.REVISION_NO,0) INTO v_pl_id , l_rev_num 
    FROM xxpm_pl_header xph,
    xxpm_pl_lines xpl
    WHERE xph.pl_id =xpl.pl_id
    and xpl.pll_id =v_PLL_ID;
    exception WHEN others THEN
dbms_output.put_line(' exception in getting revision number  ');
end;

BEGIN
select 
xph.old_status into v_status
  FROM xxdm_pl_lines xdl ,xxdm_pl_header xph
    WHERE 
    xph.PL_NUMBER =xdl.PL_NUMBER
    and    xdl.PLL_ID = v_PLL_ID
       AND xdl.BATCH_ID=xph.BATCH_ID
    AND xdl.BATCH_ID =v_BATCH_ID;
--   
    exception WHEN others THEN
dbms_output.put_line(' exception in getting OLD  status   ');
end;

if v_status = 'APR'  then

l_rev_num :=l_rev_num+1;

UPDATE  xxpm_pl_header
SET revision_no = l_rev_num
WHERE pl_id = (select distinct pl_id from xxpm_pl_lines where pll_id =v_PLL_ID);

end if;


--update revision number in header


  FOR i IN c_pl_base
  LOOP
--    SELECT NVL(REVISION_NO,0)
--    INTO l_rev_num
--    FROM xxpm_pl_lines
--    WHERE PLL_ID =v_PLL_ID;
--    SELECT PL_ID,  NVL(REVISION_NO,0) INTO v_pl_id , l_rev_num FROM xxpm_pl_header WHERE PL_NUMBER=i.PL_NUMBER;

    UPDATE xxpm_pl_lines
    SET UOM            =i.UOM,
      BASE_PRICE       =i.BASE_PRICE,
      MIN_PRICE        =i.MIN_PRICE,
      START_DATE       =i.START_DATE,
      END_DATE         =i.END_DATE,
      REVISION_NO      =l_rev_num,
      REVISION_DATE    =sysdate,
      CREATED_BY       =i.CREATED_BY,
      CREATION_DATE    =i.CREATION_DATE,
      LAST_UPDATED_BY  =i.LAST_UPDATED_BY,
      LAST_UPDATE_DATE =i.LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
    WHERE PLL_ID       =v_PLL_ID ;
    COMMIT;
  END LOOP;
END xxpm_pl_lines_update;
--------------------------------------------------------------------------------
----------------Insert  base table----------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE xxpm_pl_lines_insert(
    v_batch_id IN NUMBER )
AS
  CURSOR c_pl_base
  IS
    SELECT rowid,
      PLL_ID,
      PL_NUMBER,
      PROPERTY_NUMBER,
      BUILD_NUMBER,
      UNIT_NUMBER,
      UOM,
      BASE_PRICE,
      MIN_PRICE,
      START_DATE,
      END_DATE,
      REVISION_NO,
      REVISION_DATE,
      REVISED_BY,
      ACTIVE_YN,
      CREATED_BY,
      CREATION_DATE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      BUILD_ID,
      BATCH_ID,
      INTERFACE_STATUS_FLAG,
      INTERFACE_ID,
      ERR_MSG,
      ERR_DESCRIPTION
    FROM xxdm_pl_lines
    WHERE BATCH_ID           =v_batch_id
    AND INTERFACE_STATUS_FLAG='V';
  V_PL_ID       NUMBER;
  v_property_id NUMBER;
  v_build_id    NUMBER;
  V_UNIT_ID     NUMBER;
  V_COUNT       NUMBER;
  V_STATUS      VARCHAR2(50);
  l_PLL_ID      NUMBER;
  lpl_count     number;
  L_AREASF      NUMBER;

  k number := 0;
BEGIN
  FOR i IN c_pl_base
  LOOP
  k:=k+1;
    SELECT COUNT(PL_NUMBER)
    INTO V_COUNT
    FROM XXPM_PL_HEADER
    where PL_NUMBER = I.PL_NUMBER;

    DBMS_OUTPUT.PUT_LINE('V_COUNT   '||V_COUNT);
    IF V_COUNT > 0 THEN
      BEGIN
        SELECT old_STATUS INTO V_STATUS FROM XXDM_PL_HEADER WHERE PL_NUMBER = I.PL_NUMBER and batch_id =i.batch_id;
        DBMS_OUTPUT.PUT_LINE('V_STATUS   '||V_STATUS);
      EXCEPTION
      WHEN OTHERS THEN
        V_STATUS := NULL;
      END;
    END IF;
    BEGIN
      SELECT PL_ID INTO V_PL_ID FROM XXPM_PL_HEADER WHERE PL_NUMBER=I.PL_NUMBER;
    EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(' exception in getting  V_PL_ID  ' );
    END;
    BEGIN
      SELECT xb.property_id,
        xb.build_id,
        xuu.unit_id
      INTO v_property_id,
        v_build_id,
        v_unit_id
      FROM xxpm_property_master xu,
        xxpm_property_buildings xb,
        xxpm_property_units xuu
      WHERE xu.property_id  =xb.PROPERTY_ID
      AND xb.BUILD_ID       =xuu.BUILD_ID
      AND xb.build_number   =i.build_number
      AND xu.property_number=i.property_number
      AND xuu.UNIT_NUMBER   =i.UNIT_NUMBER;
    EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(' exception in getting  xb.property_id,  xb.build_id,  xuu.unit_id  ' );
    END;
    IF I.PLL_ID IS NOT NULL AND V_STATUS = 'APR' AND V_COUNT >0 THEN
      l_PLL_ID  :=I.PLL_ID;
      DBMS_OUTPUT.PUT_LINE('inside  if    ');

      xxpm_pl_lines_insert_history (V_PL_ID,i.pll_id ,I.BATCH_ID,V_PROPERTY_ID,V_BUILD_ID,V_UNIT_ID);
      --update is called inside insert history


    ELSIF i.PLL_ID IS NOT NULL AND V_COUNT > 0 AND V_STATUS <> 'APR' THEN
      L_PLL_ID     :=I.PLL_ID;
      DBMS_OUTPUT.PUT_LINE('inside  else if    ');

      XXPM_PL_LINES_UPDATE (I.PLL_ID,V_PROPERTY_ID,V_BUILD_ID,V_UNIT_ID,I.BATCH_ID);

    ELSE

      DBMS_OUTPUT.PUT_LINE('inside  else  ');

      l_PLL_ID := XXPM_PL_LINES_S.nextval;

DBMS_OUTPUT.PUT_LINE('v_pl_id  '||v_pl_id);
DBMS_OUTPUT.PUT_LINE('v_property_id  '||v_property_id);
DBMS_OUTPUT.PUT_LINE('v_build_id  '||v_build_id);
DBMS_OUTPUT.PUT_LINE('v_unit_id  '||v_unit_id);

    begin
    SELECT count(*) into lpl_count 
    FROM xxpm_pl_lines where unit_id=v_unit_id and PL_ID=v_pl_id;
    exception when others then 
    lpl_count:=0;
    end;

    begin
    SELECT nvl(ROUND(VALUE, 2), 0) INTO L_AREASF 
    FROM xxpm_property_area where ROWNUM=1 AND AREA='CHARGE' AND unit_id=v_unit_id;
    exception when others then 
    L_AREASF:=0;
    end;

    if(lpl_count>=1) then 
        update xxpm_pl_lines
        set 
        PLL_ID=l_PLL_ID
        ,PROPERTY_ID=v_property_id
        ,BUILD_ID=v_build_id
        ,UNIT_ID=v_unit_id
        ,UOM=i.UOM
        ,BASE_PRICE=ROUND((nvl(i.BASE_PRICE, 0)/nvl(L_AREASF, 0)), 2)
        ,MIN_PRICE=ROUND((nvl(i.BASE_PRICE, 0)/nvl(L_AREASF, 0)), 2)-500
        ,START_DATE=i.START_DATE
        ,END_DATE=i.END_DATE
        ,REVISION_NO=i.REVISION_NO
        ,REVISION_DATE=i.REVISION_DATE
        ,REVISED_BY=i.REVISED_BY
        ,ACTIVE_YN=i.ACTIVE_YN
        ,CREATED_BY=i.CREATED_BY
        ,CREATION_DATE=sysdate
        ,LAST_UPDATED_BY=i.LAST_UPDATED_BY
        ,LAST_UPDATE_DATE=sysdate + 1
        ,LAST_UPDATE_LOGIN=I.LAST_UPDATE_LOGIN
        ,PL_AMOUNT=i.BASE_PRICE
        where 
        unit_id=v_unit_id 
        and PL_ID=v_pl_id;
        commit;
        --
        UPDATE xxdm_pl_lines
            SET PLL_ID             =l_PLL_ID,
          INTERFACE_STATUS_FLAG='P'
            WHERE BATCH_ID         =v_batch_id
            AND rowid              = i.rowid;
        COMMIT;

    xxpm_pl_lines_insert_history (V_PL_ID,l_PLL_ID ,I.BATCH_ID,V_PROPERTY_ID,V_BUILD_ID,V_UNIT_ID);

    UPDATE xxdm_pl_lines
    SET PLL_ID             =l_PLL_ID,
      INTERFACE_STATUS_FLAG='P'
    WHERE BATCH_ID         =v_batch_id
    AND rowid              = i.rowid; 


    else 
        INSERT
      INTO xxpm_pl_lines
        (
          PLL_ID,
          PL_ID,
          PROPERTY_ID,
          BUILD_ID,
          UNIT_ID,
          UOM,
          BASE_PRICE,
          MIN_PRICE,
          START_DATE,
          END_DATE,
          REVISION_NO,
          REVISION_DATE,
          REVISED_BY,
          ACTIVE_YN,
          CREATED_BY,
          CREATION_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN,
          PL_AMOUNT
        )
        VALUES
        (
          l_PLL_ID,
          v_pl_id,
          v_property_id,
          v_build_id,
          v_unit_id,
          i.UOM,
          ROUND((nvl(i.BASE_PRICE, 0)/nvl(L_AREASF, 0)), 2),
          ROUND((nvl(i.BASE_PRICE, 0)/nvl(L_AREASF, 0)), 2)-500,
          i.START_DATE,
          i.END_DATE,
          i.REVISION_NO,
          i.REVISION_DATE,
          i.REVISED_BY,
          i.ACTIVE_YN,
          i.CREATED_BY,
          sysdate,
          i.LAST_UPDATED_BY,
          sysdate + 1,
          I.LAST_UPDATE_LOGIN,
          i.BASE_PRICE
        );

         UPDATE xxdm_pl_lines
            SET PLL_ID             =l_PLL_ID,
          INTERFACE_STATUS_FLAG='P'
            WHERE BATCH_ID         =v_batch_id
            AND rowid              = i.rowid;
        COMMIT;

    xxpm_pl_lines_insert_history (V_PL_ID,l_PLL_ID ,I.BATCH_ID,V_PROPERTY_ID,V_BUILD_ID,V_UNIT_ID);

    END IF;

    UPDATE xxdm_pl_lines
    SET PLL_ID             =l_PLL_ID,
      INTERFACE_STATUS_FLAG='P'
    WHERE BATCH_ID         =v_batch_id
    AND rowid              = i.rowid; 

    end if;

  END LOOP;
  COMMIT;
END xxpm_pl_lines_insert;
END XXPM_PRICELIST_DETAIL_PKG;

/
