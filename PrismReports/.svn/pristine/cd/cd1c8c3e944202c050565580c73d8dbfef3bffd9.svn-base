--------------------------------------------------------
--  DDL for Package XXPM_PRICELIST_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_PRICELIST_MASTER_PKG" 
IS
  PROCEDURE xxpm_pricelist_master_val
    (
      i_batch_id IN NUMBER
    )
    ;
  PROCEDURE xxdm_pricelist_update
    (
      v_batch_id    IN NUMBER,
    v_rowid       IN VARCHAR2,
      v_err_desc    IN VARCHAR2,
      v_status_flag IN VARCHAR2,
      v_err_msg     IN VARCHAR2
    )
    ;
  PROCEDURE xxpm_pricelist_insert_history
    (
       v_PL_NUMBER    IN varchar2,v_batch_id in number
    )
    ;
  PROCEDURE xxpm_pricelist_update
    (
       v_PL_NUMBER    IN varchar2,v_BATCH_ID IN NUMBER
    )
    ;
  PROCEDURE xxpm_pricelist_insert
    (
       v_batch_id IN NUMBER
    )
    ;
END XXPM_PRICELIST_MASTER_PKG;


--------------------------------------------------------
--  DDL for Package Body XXPM_PRICELIST_MASTER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_PRICELIST_MASTER_PKG" 
AS
  --==============================================================================
  ---------------------PriceList Validations---------------------------------------
  --==============================================================================
PROCEDURE xxpm_pricelist_master_val(
    i_batch_id IN NUMBER)
AS
  CURSOR c_pl_temp
  IS
    SELECT rowid,PL_ID,
      PL_NAME,
      PL_NAME_TL,
      PL_NUMBER,
      ORG_ID,
      DESCRIPTION,
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
      FLOW_WITH,
      FLOW_LEVEL,
      USER_GRP_ID,
      BASE_PRICE_YN,
      ACTIVE_YN,
      BATCH_ID,
      INTERFACE_STATUS_FLAG,
      INTERFACE_ID,
      ERR_MSG,
      ERR_DESCRIPTION
    FROM xxdm_pl_header
    WHERE batch_id = i_batch_id;
  v_batch_id     NUMBER;
  v_ready_flag   VARCHAR2 (1);
  v_PL_ID        VARCHAR2(150);
  v_org_id       VARCHAR2(150);
  v_pl_num       VARCHAR2(150);
  v_start_date   DATE;
  v_end_date     DATE;
  v_pl_count     NUMBER;
  v_status       VARCHAR2(150);
  v_trans_status VARCHAR2(150);
  v_batch_id     VARCHAR2(150);
  v_pl_type      VARCHAR2(150);
  v_pl_cur       VARCHAR2(150);
  v_pl_name      VARCHAR2(150);
  v_PL_ID1       VARCHAR2(150);
  v_action_flag  VARCHAR2(10);
  v_err_reason   VARCHAR2 (2000);
  v_err_desc     VARCHAR2 (2000);
  v_errm         VARCHAR2 (2000);
  l_org_id      number;
  L_CNT    number;
BEGIN
  FOR i IN c_pl_temp
  LOOP
    v_ready_flag  := 'V';
    v_err_reason  := NULL;
    v_errm        := NULL;
    v_action_flag := NULL;
    v_err_desc    := NULL;
    --------------------------------------------------------------------------------
    ----------------Validate Org ID-------------------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
    
      SELECT ORG_ID       INTO l_org_id
 FROM xxstg_organizations WHERE ORG_ID =I.ORG_ID;

      SELECT COUNT(org_id)
      INTO v_org_id
      FROM xxdm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER
      AND batch_id    = i.batch_id;
    EXCEPTION
    WHEN OTHERS THEN
    l_org_id:=null;
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Date---------------------------------------------------
    --------------------------------------------------------------------------------
    --  DBMS_OUTPUT.PUT_LINE('Validate Date');
    BEGIN
      SELECT start_date,
        end_date
      INTO v_start_date,
        v_end_date
      FROM xxdm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER
      AND batch_id    = i.batch_id;
      --  DBMS_OUTPUT.PUT_LINE('Start Date '||v_start_date||','||'End Date '||v_end_date);
    EXCEPTION
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    
    
       --------------------------------------------------------------------------------
    ---------------- Date VALIDATION---------------------------------------------------
    --------------------------------------------------------------------------------
    
    
    BEGIN
      SELECT  COUNT(*)      INTO  L_CNT
      FROM xxPm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER;
      
     
      
      
    EXCEPTION
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    
    
    
    
    
    
    
    
    --------------------------------------------------------------------------------
    ----------------Validate PriceList PL_NAME---------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT PL_NAME
      INTO v_pl_name
      FROM xxdm_pl_header
      WHERE PL_NUMBER = i.PL_NUMBER
      AND batch_id    = i.batch_id;
    EXCEPTION
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Master Status---------------------------------------
    --------------------------------------------------------------------------------
    BEGIN
      v_status :=NULL;
      SELECT status,
        PL_ID
      INTO v_status,
        v_PL_ID1
      FROM xxpm_pl_header
      WHERE PL_ID = I.PL_ID
      AND status  ='APR';
      --        IF (v_status=i.status) THEN
      --          xxpm_pricelist_insert_history (i.PL_ID);
      --          xxpm_pricelist_update (i.PL_ID);
      --        END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Pricelist Status existence-----------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT LOOKUP_VALUE_NAME
      INTO v_trans_status
      FROM xxfnd_lookup_v
      WHERE LOOKUP_TYPE_NAME = 'TRANSACTION_STATUS'
      AND LOOKUP_VALUE_NAME  = i.status;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Pricelist Type existence-----------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT LOOKUP_VALUE_NAME
      INTO v_pl_type
      FROM xxfnd_lookup_v
      WHERE LOOKUP_TYPE_NAME = 'PRICE_LIST_TYP'
      AND LOOKUP_VALUE_NAME  = i.PL_TYPE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Pricelist Currency existence-----------------------------
    --------------------------------------------------------------------------------
    BEGIN
      SELECT LOOKUP_VALUE_NAME
      INTO v_pl_cur
      FROM xxfnd_lookup_v
      WHERE LOOKUP_TYPE_NAME = 'CURRENCY'
      AND LOOKUP_VALUE_NAME  = i.CURRENCY_CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
      v_PL_ID      :='';
      v_ready_flag := 'E';
      v_errm       := SQLCODE || '-' || SQLERRM;
    END;
    --------------------------------------------------------------------------------
    ----------------Validate Conditions---------------------------------------------
    --------------------------------------------------------------------------------
      DBMS_OUTPUT.PUT_LINE('Validate Conditions');
    IF v_org_id                    > 0 and l_org_id is not null THEN                                          --ok
      IF NVL(v_start_date,sysdate) < NVL(v_end_date,v_start_date+1) THEN             --ok
        IF v_trans_status          =i.status OR i.status IS NULL THEN                --ok
          IF v_pl_type             = i.PL_TYPE OR i.PL_TYPE IS NULL THEN             --ok
            IF v_pl_cur            = i.CURRENCY_CODE OR i.CURRENCY_CODE IS NULL THEN --ok
              IF v_pl_name        IS NOT NULL THEN        --ok
              IF L_CNT > 0  THEN
              
                v_ready_flag      := 'V';
                --                    xxpm_pricelist_insert_history (i.PL_ID);
                --                    xxpm_pricelist_update (i.PL_ID);
                                           dbms_output.put_line(' 1 '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

                xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
                --                  IF (v_status=i.status AND v_PL_ID1=i.PL_ID) THEN
                --                    xxpm_pricelist_insert_history (i.PL_ID);
                --                    xxpm_pricelist_update (i.PL_ID,i.BATCH_ID);
                --                  ELSE
                --                    IF(v_status<>i.status AND v_PL_ID1=i.PL_ID) THEN
                --                      xxpm_pricelist_update (i.PL_ID,i.BATCH_ID);
                --                    END IF;
                --                  END IF;
                ELSE
                IF   TRUNC(SYSDATE) <= TRUNC(v_start_date) THEN
                 v_ready_flag      := 'V';
                --                    xxpm_pricelist_insert_history (i.PL_ID);
                --                    xxpm_pricelist_update (i.PL_ID);
                                           dbms_output.put_line(' 1 '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

                xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
                ELSE
    
        v_ready_flag := 'E';
      v_err_desc       := 'start_date  CANNOT BE LESS THAN SYSDATE';
                      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);

                         END IF;

                  END IF;
              ELSE
                v_ready_flag := 'E';
                v_err_desc   := 'PriceList Name  should not be null';
                           dbms_output.put_line('PriceList Name '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

                xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
              END IF;
            
              
            
            ELSE
              v_ready_flag := 'E';
              v_err_desc   := 'Invalid Currency Code';
           dbms_output.put_line('Invalid Currency '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

              xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
            END IF;
          ELSE
            v_ready_flag := 'E';
            v_err_desc   := 'Invalid PriceList Type';
                              dbms_output.put_line('Invalid PriceList '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

            xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
          END IF;
          --            ELSE
          --              v_ready_flag := 'E';
          --              v_err_desc   := 'PriceList status is not matched with base table status';
          --              xxdm_pricelist_update(i.BATCH_ID,i.PL_ID,v_err_desc,v_ready_flag,v_errm);
          --            END IF;
        ELSE
          v_ready_flag := 'E';
          v_err_desc   := 'Invalid Transaction Status';
                  dbms_output.put_line('Invalid Transaction Status '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

          xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
        END IF;
      ELSE
        v_ready_flag := 'E';
        v_err_desc   := 'Start date should not be greater than End Date';
        dbms_output.put_line('Start date '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);
        xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
      END IF;
    ELSE
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid Org ID ';
              dbms_output.put_line('Invalid Org ID '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
    ---------------------Mandatory Validations ---------------
    -------------------------------------------------------
    -----------------------------------------------------
    
      if i.pl_number is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid pl_number  ';
              dbms_output.put_line('Invalid pl_number '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.pl_name is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid pl_name  ';
              dbms_output.put_line('Invalid pl_name '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.org_id is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid org_id  ';
              dbms_output.put_line('Invalid org_id '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.pl_type is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid pl_type  ';
              dbms_output.put_line('Invalid pl_type '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.usage is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid usage  ';
              dbms_output.put_line('Invalid usage  '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.currency_code is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid currency_code  ';
              dbms_output.put_line('Invalid currency_code '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.start_date is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid start_date  ';
              dbms_output.put_line('Invalid start_date  '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.end_date is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid end_date  ';
              dbms_output.put_line('Invalid end_date ID '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
        if i.status is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid status  ';
              dbms_output.put_line('Invalid status ID '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
          if i.active_yn is null then
      v_ready_flag := 'E';
      v_err_desc   := 'Invalid active_yn  ';
              dbms_output.put_line('Invalid active_yn  '||i.BATCH_ID || i.rowid||v_err_desc||v_ready_flag||v_errm);

      xxdm_pricelist_update(i.BATCH_ID,i.rowid,v_err_desc,v_ready_flag,v_errm);
    END IF;
    
    
    
    
  END LOOP;
  COMMIT;
END xxpm_pricelist_master_val;
--------------------------------------------------------------------------------
----------------Update Demo Table-----------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE xxdm_pricelist_update(
    v_batch_id    IN NUMBER,
    v_rowid       IN VARCHAR2,
    v_err_desc    IN VARCHAR2,
    v_status_flag IN VARCHAR2,
    v_err_msg     IN VARCHAR2 )
AS
  l_pm_pl_id VARCHAR2(200);
  l_pl_number   VARCHAR2(200);
BEGIN
              dbms_output.put_line('upd  '||v_batch_id||'  v_rowid  ' || v_rowid||v_err_desc||'    '||v_status_flag||'  '||v_err_msg);

  UPDATE xxdm_pl_header
  SET INTERFACE_STATUS_FLAG=v_status_flag,
    ERR_DESCRIPTION        = v_err_desc,
    ERR_MSG                =v_err_msg
  WHERE rowid              =v_rowid
  AND batch_id             =v_batch_id ;
  
  
  SELECT pl_number INTO l_pl_number FROM xxdm_pl_header
  WHERE   ROWID              =v_rowid
  AND batch_id             =v_batch_id ;
  
  
  
  IF v_status_flag='E' THEN
    
    UPDATE xxdm_pl_lines
  SET INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
    ERR_MSG                =v_err_msg
  WHERE 
  pl_number =l_pl_number
  and  batch_id             =v_batch_id ;
  
    UPDATE   xxdm_pl_modifiers
            SET          INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
                         ERR_MSG=v_err_msg
            WHERE     pl_number =l_pl_number
                and batch_id=v_batch_id ;  
                
                
      UPDATE   xxdm_pl_qualifiers
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
                           ERR_MSG=v_err_msg
        WHERE PL_MOD_ID IN(SELECT pl_mod_id FROM xxdm_pl_modifiers WHERE pl_number =l_pl_number  AND batch_id =v_batch_id)
            and batch_id=v_batch_id ;  
  
  UPDATE   xxdm_pl_qualifiers
            SET            INTERFACE_STATUS_FLAG=v_status_flag,
      ERR_DESCRIPTION= 'Header item validation failed with  '||v_err_desc,
                           ERR_MSG=v_err_msg
        WHERE PL_MOD_NUMBER IN(SELECT PL_MOD_NUMBER  FROM xxdm_pl_modifiers WHERE pl_number =l_pl_number  AND batch_id =v_batch_id)
        and PL_MOD_ID is null and PL_QLFY_ID  is null
            and batch_id=v_batch_id ;
  
  end if;
  
  COMMIT;
  
  
 
END xxdm_pricelist_update;
--------------------------------------------------------------------------------
----------------Insert History Table--------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE XXPM_PRICELIST_INSERT_HISTORY(
    v_PL_NUMBER IN VARCHAR2,v_batch_id IN NUMBER)
AS
  CURSOR c_pl_history
  IS
    SELECT PL_ID,
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
    FROM xxpm_pl_header
    WHERE PL_NUMBER =v_PL_NUMBER;
    
    CURSOR c_pl_lines_h
    IS 
     SELECT xpl.PLL_ID,
      xpl.PL_ID,
      xpl.PROPERTY_ID,
      xpl.BUILD_ID,
      xpl.UNIT_ID,
      xpl.UOM,
      xpl.BASE_PRICE,
      xpl.MIN_PRICE,
      xpl.START_DATE,
      xpl.END_DATE,
      xpl.REVISION_NO,
      xpl.REVISION_DATE,
      xpl.REVISED_BY,
      xpl.ACTIVE_YN,
      xpl.CREATED_BY,
      xpl.CREATION_DATE,
      xpl.LAST_UPDATED_BY,
      xpl.LAST_UPDATE_DATE,
      xpl.LAST_UPDATE_LOGIN
    FROM 
xxpm_pl_header xph
,xxpm_pl_lines xpl
WHERE xph.pl_id =xpl.pl_id
and xph.PL_NUMBER =v_PL_NUMBER;
    
    CURSOR c_pl_modifier_h
    IS
   SELECT xpm.PL_MOD_ID,
  xpm.PL_ID,
  xpm.MOD_ID,
  xpm.START_DATE,
  xpm.END_DATE,
  xpm.REVISION_NO,
  xpm.REVISION_DATE,
  xpm.REVISED_BY,
  xpm.ACTIVE_YN,
  xpm.CREATED_BY,
  xpm.CREATION_DATE,
  xpm.LAST_UPDATED_BY,
  xpm.LAST_UPDATE_DATE,
  xpm.LAST_UPDATE_LOGIN
FROM xxpm_pl_modifiers xpm,xxpm_pl_header xph
WHERE xpm.pl_id =xph.pl_id
and xph.PL_NUMBER =v_PL_NUMBER;
    
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
  xpq.LAST_UPDATE_LOGIN,
  xph.pl_number
FROM xxpm_pl_qualifiers xpq ,
  xxpm_pl_modifiers xpm,
  xxpm_pl_header xph
WHERE xpq.pl_mod_id =xpm.pl_mod_id
AND xpm.pl_id       =xph.pl_id
and xph.pl_number =v_PL_NUMBER;
    
    
  l_pl_id_h NUMBER;
  v_revision_no number;
BEGIN
  FOR i IN c_pl_history
  LOOP
  
   DBMS_OUTPUT.PUT_LINE('  master c_pl_history history  ') ;

  
  
    --  begin
    --    select PL_ID into L_PL_ID_H from XXPM_PL_HEADER_H where PL_NUMBER =V_PL_NUMBER;
    --    EXCEPTION when OTHERS then
    --
    --    L_PL_ID_H := null;
    --
    --    end;
    --    DBMS_OUTPUT.PUT_LINE('  L_PL_ID_H  ' ||L_PL_ID_H);
    --
    --    IF l_pl_id_h IS NULL THEN
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
        i.PL_ID,
        i.PL_NAME,
        i.PL_NAME_TL,
        i.DESCRIPTION,
        i.ORG_ID,
        i.FUNC_ID,
        i.PL_TYPE,
        i.PRIORITY,
        i.USAGE,
        i.CURRENCY_CODE,
        i.START_DATE,
        i.END_DATE,
        NVL(i.REVISION_NO,0),
        i.REVISION_DATE,
        i.REVISED_BY,
        i.STATUS,
        i.FLOW_STATUS,
        i.FLOW_LEVEL,
        i.USER_GRP_ID,
        i.BASE_PRICE_YN,
        i.ACTIVE_YN,
        i.CREATED_BY,
        sysdate,
        i.LAST_UPDATED_BY,
        sysdate,
        i.LAST_UPDATE_LOGIN,
        i.PL_NUMBER
      );
    --    ELSE
    --      NULL;
    --    END IF;
    
    v_revision_no :=NVL(i.REVISION_NO,0);
  END LOOP;
  
  -- insert into lines history
  
   for j in c_pl_lines_h
  LOOP
  
     DBMS_OUTPUT.PUT_LINE('  master c_pl_lines_h history  ') ;

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
          j.PLL_ID,
          j.PL_ID,
          j.PROPERTY_ID,
          j.BUILD_ID,
          j.UNIT_ID,
          j.UOM,
          j.BASE_PRICE,
          j.MIN_PRICE,
          j.START_DATE,
          j.END_DATE,
          v_revision_no,
          j.REVISION_DATE,
          j.REVISED_BY,
          j.ACTIVE_YN,
          j.CREATED_BY,
          j.CREATION_DATE,
          j.LAST_UPDATED_BY,
          j.LAST_UPDATE_DATE,
          j.LAST_UPDATE_LOGIN
        );
--    END IF;
  END LOOP;
 
 FOR k IN c_pl_modifier_h
 loop
 
      DBMS_OUTPUT.PUT_LINE('  master xxpm_pl_modifiers_h history  ') ;

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
 
 end loop;
  
  
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

  
  end loop;
  
  UPDATE xxdm_pl_lines SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =v_PL_NUMBER;

UPDATE xxdm_pl_modifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =v_PL_NUMBER;

UPDATE xxdm_pl_qualifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
and pl_mod_id in(
  SELECT xdm.pl_mod_id FROM xxdm_pl_modifiers xdm 
  WHERE  xdm.batch_id =v_BATCH_ID
  AND xdm.pl_number =v_PL_NUMBER);

  
  COMMIT;
END xxpm_pricelist_insert_history;
--------------------------------------------------------------------------------
----------------Update PriceList base table Revision number-----------------------
--------------------------------------------------------------------------------
PROCEDURE xxpm_pricelist_update
  (
    v_PL_NUMBER IN VARCHAR2,
    v_BATCH_ID  IN NUMBER
  )
AS
  CURSOR c_pl_base
  IS
    SELECT PL_ID,
      PL_NAME,
      PL_NAME_TL,
      PL_NUMBER,
      ORG_ID,
      DESCRIPTION,
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
      FLOW_WITH,
      FLOW_LEVEL,
      USER_GRP_ID,
      BASE_PRICE_YN,
      ACTIVE_YN,
      BATCH_ID,
      INTERFACE_STATUS_FLAG,
      INTERFACE_ID,
      ERR_MSG,
      ERR_DESCRIPTION,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATED_BY,
      CREATION_DATE
    FROM XXDM_PL_HEADER
    WHERE PL_NUMBER = v_PL_NUMBER
    AND BATCH_ID    =v_BATCH_ID;
  l_rev_num NUMBER ;
  v_status varchar2(50);
BEGIN
  FOR i IN c_pl_base
  LOOP
    SELECT NVL(REVISION_NO,0),status
    INTO l_rev_num,v_status
    FROM xxpm_pl_header
    WHERE PL_NUMBER =V_PL_NUMBER;
    DBMS_OUTPUT.PUT_LINE('inside  update    l_rev_num '||l_rev_num);
    
    IF v_status = 'APR' THEN
    l_rev_num :=l_rev_num+1;
    
    end if;
    
    
    UPDATE xxpm_pl_header
    SET REVISION_NO   =l_rev_num,
      REVISION_DATE   =sysdate,
      PL_NAME         =i.PL_NAME,
      PL_NAME_TL      =i.PL_NAME_TL,
      PL_NUMBER       =i.PL_NUMBER,
      ORG_ID          =i.ORG_ID,
      DESCRIPTION     =i.DESCRIPTION,
      PL_TYPE         =i.PL_TYPE,
      PRIORITY        =i.PRIORITY,
      USAGE           =i.USAGE,
      CURRENCY_CODE   =i.CURRENCY_CODE,
      START_DATE      =i.START_DATE,
      END_DATE        =i.END_DATE,
      STATUS          =i.STATUS,
      ACTIVE_YN       =i.ACTIVE_YN,
      CREATION_DATE   =i.CREATION_DATE,
      LAST_UPDATE_DATE=i.LAST_UPDATE_DATE,
      LAST_UPDATED_BY =I.LAST_UPDATED_BY
    WHERE PL_NUMBER   =v_PL_NUMBER ;
    
--     UPDATE xxpm_pl_lines
--SET revision_no = l_rev_num+1
--WHERE pl_id = (select pl_id from xxpm_pl_header where pl_number =v_PL_NUMBER);
    
    
    COMMIT;
  END LOOP;
END xxpm_pricelist_update;
--------------------------------------------------------------------------------
----------------Insert  base table----------------------------------------------
--------------------------------------------------------------------------------
PROCEDURE xxpm_pricelist_insert(
    v_batch_id IN NUMBER)
AS
  CURSOR C_PL_BASE
  IS
    SELECT rowid,
      PL_ID,
      PL_NAME,
      PL_NAME_TL,
      PL_NUMBER,
      ORG_ID,
      DESCRIPTION,
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
      FLOW_WITH,
      FLOW_LEVEL,
      USER_GRP_ID,
      BASE_PRICE_YN,
      ACTIVE_YN,
      BATCH_ID,
      INTERFACE_STATUS_FLAG,
      INTERFACE_ID,
      ERR_MSG,
      ERR_DESCRIPTION,
      CREATED_BY,
      CREATION_DATE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN
    FROM xxdm_pl_header
    WHERE BATCH_ID           =v_batch_id
    AND INTERFACE_STATUS_FLAG='V';
  V_COUNT  NUMBER;
  V_STATUS VARCHAR2(10);
  l_pl_id  NUMBER;
  l_func_id  number;
  
BEGIN
  FOR I IN C_PL_BASE
  LOOP
    SELECT COUNT(PL_NUMBER)
    INTO V_COUNT
    FROM XXPM_PL_HEADER
    WHERE PL_NUMBER = I.PL_NUMBER;
    DBMS_OUTPUT.PUT_LINE('V_COUNT   '||V_COUNT);
    
    IF V_COUNT > 0 THEN
      BEGIN
        SELECT STATUS,
          pl_id
        INTO V_STATUS,
          l_pl_id
        FROM XXPM_PL_HEADER
        WHERE PL_NUMBER = I.PL_NUMBER;
        UPDATE xxdm_pl_header SET OLD_STATUS=V_STATUS WHERE BATCH_ID=v_batch_id AND PL_NUMBER = I.PL_NUMBER;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('V_STATUS   '||V_STATUS);
      EXCEPTION
      WHEN OTHERS THEN
        V_STATUS := NULL;
        l_pl_id  := NULL;
      END;
      ELSE
      UPDATE xxdm_pl_header SET OLD_STATUS='DRA' WHERE BATCH_ID=v_batch_id AND PL_NUMBER = I.PL_NUMBER;
      UPDATE xxdm_pl_lines SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =I.PL_NUMBER;

UPDATE xxdm_pl_modifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
AND PL_NUMBER =I.PL_NUMBER;

UPDATE xxdm_pl_qualifiers SET History_insert ='P'  WHERE  batch_id =v_BATCH_ID
and pl_mod_id in(
  SELECT xdm.pl_mod_id FROM xxdm_pl_modifiers xdm 
  WHERE  xdm.batch_id =v_BATCH_ID
  AND xdm.pl_number =I.PL_NUMBER);
  
    END IF;
    
    IF V_COUNT > 0 AND V_STATUS ='APR' THEN
     
      DBMS_OUTPUT.PUT_LINE('inside if    ');
      xxpm_pricelist_insert_history (i.PL_NUMBER,I.BATCH_ID);
      xxpm_pricelist_update (I.PL_NUMBER,I.BATCH_ID);
   
    ELSIF V_COUNT > 0 AND V_STATUS <> 'APR' THEN
    
      DBMS_OUTPUT.PUT_LINE('inside  else if    ');
      xxpm_pricelist_update (i.PL_NUMBER,i.BATCH_ID);
  
    ELSE
    
      DBMS_OUTPUT.PUT_LINE('inside  else     ');
--         xxpm_pricelist_insert_history (i.PL_NUMBER,I.BATCH_ID);
--      xxpm_pricelist_update (I.PL_NUMBER,I.BATCH_ID);
    
    select func_id into  l_func_id from xxfnd_functions where FUNC_SHORT_CODE ='PL';
      
      l_pl_id := XXPM_PL_HEADER_S.nextval;
      
      
      INSERT
      INTO xxpm_pl_header
        (
          PL_ID,
          PL_NAME,
          PL_NAME_TL,
          DESCRIPTION,
          ORG_ID,
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
          PL_NUMBER,
          FUNC_ID
        )
        VALUES
        (
          l_pl_id,
          i.PL_NAME,
          i.PL_NAME_TL,
          i.DESCRIPTION,
          i.ORG_ID,
          i.PL_TYPE,
          i.PRIORITY,
          i.USAGE,
          i.CURRENCY_CODE,
          i.START_DATE,
          i.END_DATE,
          i.REVISION_NO,
          i.REVISION_DATE,
          i.REVISED_BY,
          i.STATUS,
          i.FLOW_STATUS,
          i.FLOW_LEVEL,
          i.USER_GRP_ID,
          i.BASE_PRICE_YN,
          i.ACTIVE_YN,
          i.CREATED_BY,
          sysdate,
          i.LAST_UPDATED_BY,
          sysdate + 1,
          i.LAST_UPDATE_LOGIN,
          I.PL_NUMBER,
          l_func_id
        );
    END IF;
    UPDATE XXDM_PL_HEADER
    SET INTERFACE_STATUS_FLAG='P',
      PL_ID                  =L_PL_ID
    WHERE BATCH_ID           =V_BATCH_ID
    AND PL_NUMBER            =I.PL_NUMBER
    AND rowid                =I.rowid;
  END LOOP;
  COMMIT;
END XXPM_PRICELIST_INSERT;
END XXPM_PRICELIST_MASTER_PKG;
