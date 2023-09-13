CREATE OR REPLACE PACKAGE "XXPM_FIX_FIT_MASTER_PKG" 
IS
  PROCEDURE xxpm_fix_fit_master_val(
      i_batch_id IN NUMBER);
  PROCEDURE update_fix_fit_temp(
      v_status_flag     IN VARCHAR2,
      v_err_desc        IN VARCHAR2,
      v_err_msg         IN VARCHAR2,
      v_property_number IN VARCHAR2,
      v_build_number    IN VARCHAR2,
      v_unit_number         IN VARCHAR2,
      v_batch_id        IN NUMBER
      );
  PROCEDURE insert_fix_fit_master(
      i_batch_id IN NUMBER);
END XXPM_FIX_FIT_MASTER_PKG;

/


CREATE OR REPLACE PACKAGE BODY "XXPM_FIX_FIT_MASTER_PKG" 
AS
  PROCEDURE xxpm_fix_fit_master_val(
      i_batch_id IN NUMBER)
  AS
    CURSOR c_fix_fix_temp
    IS
      SELECT FIX_ID,
        PROPERTY_NUMBER,
        BUILD_NUMBER,
        UNIT_NUMBER,
        PROPERTY_ID,
        BUILD_ID,
        UNIT_ID,
        FIX_CATEGORY,
        DESCRIPTION,
        FIX_CONDITION,
        UOM,
        VALUE,
        QUANTITY,
        RATE,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        BATCH_ID,
        INTERFACE_STATUS_FLAG,
        INTERFACE_ID,
        ERR_MSG,
        ERR_DESCRIPTION,
        VALIDATED_BY,
        VALIDATED_DATE,
        PROCESSED_BY,
        PROCESSED_DATE
      FROM XXDM_PROPERTY_FIX_FITTINGS
      WHERE BATCH_ID=i_batch_id
      AND
      INTERFACE_STATUS_FLAG !='E';
    v_batch_id        NUMBER;
    v_ready_flag      VARCHAR2 (1);
    v_property_id     NUMBER;
    vu_property_id    NUMBER;
    v_build_id        NUMBER;
    v_property_number VARCHAR2 (60);
    v_build_number    VARCHAR2 (60);
    v_err_reason      VARCHAR2 (2000);
    v_errm            VARCHAR2 (2000);
    v_fix_uom         VARCHAR2(40);
    v_unit_id         NUMBER;
    v_unit_number     VARCHAR2(400);
    v_fix_category    VARCHAR2(400);
    v_fix_num         VARCHAR2(400);
    v_fix_condition   VARCHAR2(400);
    vuu_property_id   VARCHAR2(400);
    v_count_pm_units    number;
    v_unit_number_dm    varchar2(60);

  BEGIN
    v_batch_id := i_batch_id;
    FOR i IN c_fix_fix_temp
    LOOP
      v_ready_flag := 'V';
      v_err_reason := '';
      v_errm       := '';
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

    BEGIN
    select count(1) into v_count_pm_units from xxpm_property_units  where unit_number=i.unit_number;
     if (v_count_pm_units >0)    then        
        BEGIN
            SELECT UNIT_ID,
              UNIT_NUMBER
            INTO v_unit_id,
              v_unit_number
            FROM xxpm_property_units
            WHERE UNIT_NUMBER=i.UNIT_NUMBER;
        EXCEPTION
               WHEN OTHERS THEN
                v_unit_id:='';
                v_ready_flag := 'E';
                v_errm       := SQLCODE || '-' || SQLERRM;
        END;

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
                and xb.BUILD_ID=xuu.BUILD_ID
                AND xb.build_number   =i.build_number
                AND xu.property_number=i.property_number
                and xuu.UNIT_NUMBER=i.UNIT_NUMBER;
         EXCEPTION
            WHEN OTHERS THEN
                v_ready_flag := 'E';
                v_errm       := SQLCODE || '-' || SQLERRM;
         END;

       BEGIN
            UPDATE XXDM_PROPERTY_FIX_FITTINGS
            SET property_id    = v_property_id,
                build_id         =v_build_id,
                unit_id          =v_unit_id
            WHERE build_number =i.build_number
                  AND property_number=i.property_number
                  AND UNIT_NUMBER    =i.UNIT_NUMBER
                  AND batch_id =v_batch_id;
            DBMS_OUTPUT.PUT_LINE('Unit number:- ' ||i.unit_number || 'Row Count:- ' ||v_property_id);
            COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
             v_ready_flag := 'E';
             v_errm       := SQLCODE || '-' || SQLERRM;
        END;
      else
            Begin      
                        DBMS_OUTPUT.PUT_LINE('Count=0');
                        select unit_number into v_unit_number_dm from xxdm_property_units 
                        where unit_number=i.unit_number and batch_id=v_batch_id;
                        DBMS_OUTPUT.PUT_LINE(v_unit_number_dm);
            EXCEPTION
                        WHEN OTHERS
                          THEN
                           v_unit_number_dm := ''; 
                           v_ready_flag := 'E';
                           v_errm := SQLCODE || '-' || SQLERRM;
            END;

                   BEGIN
                        SELECT xb.property_id,xu.property_id,xb.build_id,
                          xu.property_number,xb.build_number
                        INTO v_property_id,
                          vu_property_id,
                          v_build_id,
                          v_property_number,
                          v_build_number
                        FROM xxpm_property_master xu,
                          xxpm_property_buildings xb
                        WHERE xu.property_id  =xb.PROPERTY_ID
                        AND xb.build_number   =i.build_number
                        AND xu.property_number=i.property_number;
                      EXCEPTION
                      WHEN OTHERS THEN
                        v_ready_flag := 'E';
                        v_errm       := SQLCODE || '-' || SQLERRM;
                         DBMS_OUTPUT.PUT_LINE('Unit number:- ' ||i.unit_number || 'v_property_id:- ' ||v_property_id);
                 END;

                 Begin
                         UPDATE XXDM_PROPERTY_FIX_FITTINGS
                         SET property_id    = v_property_id,
                             build_id       = v_build_id,
                             unit_id        = null
                         WHERE build_number =i.build_number
                           AND property_number=i.property_number
                           AND UNIT_NUMBER    =i.UNIT_NUMBER
                           AND batch_id =v_batch_id;
                 Exception
                        WHEN OTHERS
                        THEN
                           v_ready_flag := 'E';
                           v_errm := SQLCODE || '-' || SQLERRM;
                 End;
      END IF;
      END;

      BEGIN
        SELECT count(lookup_value_name)
        INTO v_fix_category
        FROM xxfnd_lookup_v
        WHERE lookup_type_name='FITTINGS_CATEGORY'
        AND lookup_value_name =i.FIX_CATEGORY;
      EXCEPTION
      WHEN OTHERS THEN
        v_fix_category:='';
        v_ready_flag  := 'E';
        v_errm        := SQLCODE || '-' || SQLERRM;
      END;
      BEGIN
        SELECT count(lookup_value_name)
        INTO v_fix_uom
        FROM xxfnd_lookup_v
        WHERE lookup_type_name='FIX_UOM'
        AND lookup_value_name =i.UOM;
      EXCEPTION
      WHEN OTHERS THEN
        v_fix_uom    :='';
        v_ready_flag := 'E';
        v_errm       := SQLCODE || '-' || SQLERRM;
      END;
      BEGIN
        SELECT count(lookup_value_name)
        INTO v_fix_condition
        FROM xxfnd_lookup_v
        WHERE lookup_type_name='FITTINGS_OPTIONS'
        AND lookup_value_name =i.FIX_CONDITION;
      EXCEPTION
      WHEN OTHERS THEN
        v_fix_condition:='';
        v_ready_flag   := 'E';
        v_errm         := SQLCODE || '-' || SQLERRM;
      END;


      IF (v_property_id                   IS NOT NULL) THEN
        IF (v_build_id                    IS NOT NULL) THEN
          IF(v_property_id  = vu_property_id) THEN
            IF (v_fix_uom > 0) or (i.UOM is null) THEN
              IF (v_fix_category > 0) or (i.FIX_CATEGORY  IS NULL) THEN
                IF (i.QUANTITY            <=100) THEN
                  If(v_unit_id is not null)  or (v_unit_number_dm is not null)then
                      IF (v_fix_condition > 0) or (i.FIX_CONDITION is null) THEN
                        DBMS_OUTPUT.PUT_LINE('ALL VALIDATION DONE' || v_ready_flag);
                        v_property_number :=i.property_number;
                        v_build_number    :=i.build_number;
                        v_unit_number    :=i.unit_number;
                        v_err_reason      := v_err_reason;
                        update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                      ELSE
                        DBMS_OUTPUT.PUT_LINE('FIX CONDITION ISSUE');
                        v_ready_flag     := 'E';
                        v_property_number:=i.property_number;
                        v_build_number   :=i.build_number;
                        v_unit_number    :=i.unit_number;
                        v_err_reason     := i.property_number||':- Property is not having the mentioned Fix Condition ' ||i.FIX_CONDITION;
                       update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                      END IF;

                  ELSE
                    DBMS_OUTPUT.PUT_LINE('UNIT NUMBER IS NOT AVAILBLE');
                    v_ready_flag     := 'E';
                    v_property_number:=i.property_number;
                    v_build_number   :=i.build_number;
                    v_unit_number    :=i.unit_number;
                    v_err_reason     := i.property_number||':- Property is not having the mentioned Unit Number ' ||i.UNIT_NUMBER;
                     update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                  END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('QUANTITY MORE THAN 100');
                  v_ready_flag     := 'E';
                  v_errm           := SQLCODE || '-' || SQLERRM;
                  v_property_number:=i.property_number;
                  v_build_number   :=i.build_number;
                  v_unit_number    :=i.unit_number;
                  v_err_reason     := i.property_number||':-  Quantity is more then 100 ----->' ||i.QUANTITY;
                  update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
                END IF;
              ELSE
              DBMS_OUTPUT.PUT_LINE('FIX CATEGORY ISSUE');
              v_ready_flag     := 'E';
                v_property_number:=i.property_number;
                v_build_number   :=i.build_number;
                v_unit_number    :=i.unit_number;
                v_err_reason     := i.property_number||':- Property is not having the mentioned Fix category ' ||i.FIX_CATEGORY;
                 update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
              END IF;
            ELSE
            DBMS_OUTPUT.PUT_LINE('FIX UOM ISSUE');
            v_ready_flag     := 'E';
              v_property_number:=i.property_number;
              v_build_number   :=i.build_number;
              v_unit_number    :=i.unit_number;
              v_err_reason     := i.property_number||':- Property is not having the mentioned Fix UOM ' ||i.UOM;
             update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
            END IF;
          ELSE
          DBMS_OUTPUT.PUT_LINE('PROPERTY BUILDING NOT RELATED');

          v_ready_flag     := 'E';
            v_property_number:=i.property_number;
            v_build_number   :=i.build_number;
            v_unit_number    :=i.unit_number;
            v_err_reason     := i.property_number || ':- PROPERTY NUMBER IS NOT BELONGS TO THE '|| i.BUILD_NUMBER ||':- BUILDING NUMBER';
            update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
          END IF;
        ELSE
        DBMS_OUTPUT.PUT_LINE('BUILD NUMBER NOT EXIST');
        v_ready_flag     := 'E';
          v_property_number:=i.property_number;
          v_build_number   :=i.build_number;
          v_unit_number    :=i.unit_number;
          v_err_reason     := i.build_number || ' :- BUILD NUMBER IS NOT IN THE BUILD MASTER TABLE';
           update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
        END IF;
      ELSE
       DBMS_OUTPUT.PUT_LINE('PROPERTY NUMBER NOT EXIST');
       v_ready_flag     := 'E';
        v_property_number:=i.property_number;
        v_build_number   :=i.build_number;
        v_unit_number    :=i.unit_number;
        v_err_reason     := i.property_number || ' :- PROPERTY NUMBER IS NOT IN THE PROPERTY MASTER TABLE';
        update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
      END IF;

      ----------------Mandatory Condition ---------------
      ------------------------------------------
      ---------------------------------



       if i.fix_condition is null then
       DBMS_OUTPUT.PUT_LINE('fix_condition NOT EXIST');
       v_ready_flag     := 'E';
        v_property_number:=i.property_number;
        v_build_number   :=i.build_number;
        v_unit_number    :=i.unit_number;
        v_err_reason     :=  ' fix_condition NOT EXIST';
        update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
      END IF;

         if i.uom is null then
       DBMS_OUTPUT.PUT_LINE('uom NOT EXIST');
       v_ready_flag     := 'E';
        v_property_number:=i.property_number;
        v_build_number   :=i.build_number;
        v_unit_number    :=i.unit_number;
        v_err_reason     :=  ' uom NOT EXIST';
        update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
      END IF;


         if i.value is null then
       DBMS_OUTPUT.PUT_LINE('value NOT EXIST');
       v_ready_flag     := 'E';
        v_property_number:=i.property_number;
        v_build_number   :=i.build_number;
        v_unit_number    :=i.unit_number;
        v_err_reason     :=  ' value NOT EXIST';
        update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
      END IF;


         if i.quantity is null then
       DBMS_OUTPUT.PUT_LINE('quantity NOT EXIST');
       v_ready_flag     := 'E';
        v_property_number:=i.property_number;
        v_build_number   :=i.build_number;
        v_unit_number    :=i.unit_number;
        v_err_reason     :=  ' quantity NOT EXIST';
        update_fix_fit_temp(v_ready_flag,v_err_reason,v_errm,v_property_number,v_build_number,v_unit_number,v_batch_id);
      END IF;


    END LOOP;
    COMMIT;
  END xxpm_fix_fit_master_val;
----------------------------------------------------------------------------------
  PROCEDURE update_fix_fit_temp(
     v_status_flag      IN VARCHAR2,
      v_err_desc        IN VARCHAR2,
      v_err_msg         IN VARCHAR2,
      v_property_number IN VARCHAR2,
      v_build_number    IN VARCHAR2,
      v_unit_number     IN VARCHAR2,
      v_batch_id        IN NUMBER)
  AS
  BEGIN
  DBMS_OUTPUT.PUT_LINE('BEFORE UPDATE' || v_status_flag ||' ' || v_property_number || ' '|| v_build_number || ' '|| v_unit_number);
    UPDATE XXDM_PROPERTY_FIX_FITTINGS
    SET INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION        = v_err_desc,
      ERR_MSG                =v_err_msg
    WHERE property_number    =v_property_number
    AND build_number        =v_build_number
    AND unit_number           =v_unit_number
    AND batch_id             =v_batch_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('AFTER UPDATE');
  END update_fix_fit_temp;
------------------------------------------------------------------------------
  PROCEDURE insert_fix_fit_master(
      i_batch_id IN NUMBER)
  AS
    CURSOR c_fix_fit_dm
    IS
      SELECT FIX_ID,
        PROPERTY_NUMBER,
        BUILD_NUMBER,
        UNIT_NUMBER,
        PROPERTY_ID,
        BUILD_ID,
        UNIT_ID,
        FIX_CATEGORY,
        DESCRIPTION,
        FIX_CONDITION,
        UOM,
        VALUE,
        QUANTITY,
        RATE,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        BATCH_ID,
        INTERFACE_STATUS_FLAG,
        INTERFACE_ID,
        ERR_MSG,
        ERR_DESCRIPTION,
        VALIDATED_BY,
        VALIDATED_DATE,
        PROCESSED_BY,
        PROCESSED_DATE
      FROM XXDM_PROPERTY_FIX_FITTINGS
      WHERE BATCH_ID           =i_batch_id
      AND INTERFACE_STATUS_FLAG='V';
    v_row_count       NUMBER;
    v_errm            VARCHAR2(2000);
    v_property_id     NUMBER;
    v_build_id        NUMBER;
    v_property_number VARCHAR2(100);
    v_build_number    VARCHAR2(100);
    v_batch_id        NUMBER;
    v_unit_id         NUMBER;
    v_unit_number     VARCHAR2(400);
  BEGIN
    v_batch_id:=i_batch_id;
    FOR i IN c_fix_fit_dm
    LOOP
            Begin
                  select unit_id into v_unit_id from XXPM_PROPERTY_UNITS where
                  property_id =i.property_id and build_id =i.build_id and unit_number=i.unit_number; 
            EXCEPTION
            WHEN OTHERS
			  THEN
               v_unit_id:='';
               v_errm := SQLCODE || '-' || SQLERRM;
            end;


      update XXPM_PROPERTY_FIX_FITTINGS
      set
      FIX_CATEGORY=i.FIX_CATEGORY,
      DESCRIPTION=i.DESCRIPTION,	
      FIX_CONDITION=i.FIX_CONDITION,	
      UOM=i.UOM,
      VALUE=i.VALUE,
      QUANTITY=i.QUANTITY,
      RATE=i.RATE,
      CREATED_BY=i.CREATED_BY,
      CREATION_DATE=i.CREATION_DATE,
      LAST_UPDATED_BY=i.LAST_UPDATED_BY,
      LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN=i.LAST_UPDATE_LOGIN
      where FIX_ID=i.FIX_ID;

      v_row_count:=SQL%ROWCOUNT;
      DBMS_OUTPUT.PUT_LINE('Unit number:- ' ||i.unit_number || 'Row Count:- ' ||v_row_count);
      IF (v_row_count =0) THEN
        --dbms_output.put_line('inside if '||i.FIX_CATEGORY);
        INSERT
        INTO XXPM_PROPERTY_FIX_FITTINGS
          (
            FIX_ID,
            PROPERTY_ID,
            BUILD_ID,
            UNIT_ID,
            FIX_CATEGORY,
            DESCRIPTION,
            FIX_CONDITION,
            UOM,
            VALUE,
            CREATED_BY,
            CREATION_DATE,
            LAST_UPDATED_BY,
            LAST_UPDATE_DATE,
            LAST_UPDATE_LOGIN,
            QUANTITY,
            RATE
          )
          VALUES
          (
            XXPM_FIXTURES_ID_S.nextval,
            i.property_id,
            i.build_id,
            v_unit_id,
            i.FIX_CATEGORY,
            i.DESCRIPTION,
            i.FIX_CONDITION,
            i.UOM,
            i.VALUE,
            i.created_by,
            i.CREATION_DATE,
            i.last_updated_by,
            i.LAST_UPDATE_DATE,
            i.LAST_UPDATE_LOGIN,
            i.QUANTITY,
            i.RATE
          );
      END IF;
      UPDATE XXDM_PROPERTY_FIX_FITTINGS
      SET INTERFACE_STATUS_FLAG  = 'P',
          ERR_DESCRIPTION        = null,
          ERR_MSG                = null
        WHERE property_number    =i.property_number
          AND build_number        =i.build_number
          AND unit_number           =i.unit_number
          AND batch_id             =v_batch_id;

    END LOOP;
    COMMIT;
  END insert_fix_fit_master;
------------------------------------------
END XXPM_FIX_FIT_MASTER_PKG;

/
