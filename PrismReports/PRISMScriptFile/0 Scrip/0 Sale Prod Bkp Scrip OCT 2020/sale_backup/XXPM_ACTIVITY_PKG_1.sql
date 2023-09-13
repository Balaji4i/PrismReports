--------------------------------------------------------
--  DDL for Package Body XXPM_ACTIVITY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_ACTIVITY_PKG" is

PROCEDURE XXPM_PROC_ACTIVITY(
    SOURCE_FUNC_ID     IN NUMBER,
    SOURCE_FUNC_REF_ID IN NUMBER,
    ORG_ID             IN NUMBER,
    PROPERTY_ID        IN NUMBER,
    BUILD_ID           IN NUMBER,
    UNIT_ID            IN NUMBER,
    ACTIVITY_TYPE      IN VARCHAR2,
    DESCRIPTION        IN VARCHAR2,
	CREATED_BY		   IN VARCHAR2	)
AS
  v_errm               VARCHAR2 (2000);
  V_ACTIVITY_NUMBER    VARCHAR2(30); 
  V_FUNC_ID            NUMBER;
  V_p_err_code         VARCHAR2(30); 
  V_p_err_msg          VARCHAR2(30);
BEGIN
  BEGIN
    xxfnd_pkg.get_next_number('AL',V_ACTIVITY_NUMBER,V_FUNC_ID,V_p_err_code,V_p_err_msg);
    DBMS_OUTPUT.PUT_LINE(V_ACTIVITY_NUMBER);
    DBMS_OUTPUT.PUT_LINE(V_FUNC_ID);
  END;
  BEGIN
    INSERT
    INTO XXPM_ACTIVITY_LOG
      (
        ACTIVITY_ID,
        ACTIVITY_NUMBER,
        ACTIVITY_DATE,
        FUNC_ID,
        SOURCE_FUNC_ID,
        SOURCE_FUNC_REF_ID,
        ORG_ID,
        PROPERTY_ID,
        BUILD_ID,
        UNIT_ID,
        ACTIVITY_TYPE,
        DESCRIPTION,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN
      )
      VALUES
      (
        XXPM_ACTIVITY_ID_S.nextval,
        V_ACTIVITY_NUMBER,
        sysdate,
        V_FUNC_ID,
        SOURCE_FUNC_ID,
        SOURCE_FUNC_REF_ID,
        ORG_ID,
        PROPERTY_ID,
        BUILD_ID,
        UNIT_ID,
        ACTIVITY_TYPE,
        DESCRIPTION ,
        CREATED_BY,
        sysdate,
        CREATED_BY,
        sysdate,
        CREATED_BY
      );

  EXCEPTION
  WHEN no_data_found THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  WHEN OTHERS THEN
    v_errm := SQLCODE || '-' || SQLERRM;
  END;
EXCEPTION
WHEN no_data_found THEN
  v_errm := SQLCODE || '-' || SQLERRM;
WHEN OTHERS THEN
  v_errm := SQLCODE || '-' || SQLERRM;
END;
end XXPM_ACTIVITY_PKG;
