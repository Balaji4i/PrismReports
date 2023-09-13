--------------------------------------------------------
--  DDL for Function XX_TEST_BLOB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "XX_TEST_BLOB" (
    p_org_id IN NUMBER )
  RETURN CLOB
IS
  l_query_ref SYS_REFCURSOR;
  l_handle dbms_xmlgen.ctxhandle;
  l_data_xml CLOB;
BEGIN
  dbms_output.Put_line(p_org_id);
  OPEN l_query_ref FOR SELECT org_id, logo_name, logo FROM COMPANY_LOGO WHERE org_id = p_org_id;
  l_handle                                                                          := dbms_xmlgen.Newcontext (l_query_ref);
  dbms_xmlgen.Setrowsettag (l_handle, 'PC');
  dbms_xmlgen.Setrowtag (l_handle, 'PC_HEAD');
  dbms_xmlgen.Setnullhandling (l_handle, dbms_xmlgen.empty_tag);
  l_data_xml := dbms_xmlgen.Getxml (l_handle);
  RETURN ( l_data_xml );
EXCEPTION
WHEN OTHERS THEN
  RETURN ( NULL );
END XX_TEST_BLOB;
