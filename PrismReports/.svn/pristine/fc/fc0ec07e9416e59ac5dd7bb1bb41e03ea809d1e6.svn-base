--------------------------------------------------------
--  DDL for Package XXPM_TEST_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_TEST_PKG" is

   function get_updateStatus (p_column_name       in varchar2,
                           p_table_name        in varchar2,
                           p_where_condtion    in varchar2,
                           p_value             in varchar2,
                           P_STATUS 			 in varchar2)
            return varchar2 ;

end XXPM_TEST_PKG;


--------------------------------------------------------
--  DDL for Package Body XXPM_TEST_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_TEST_PKG" is

function get_updateStatus( p_column_name       in varchar2,
                         p_table_name        in varchar2,
                         p_where_condtion    in varchar2,
                         p_value             in varchar2,
			 P_STATUS           in varchar2) 
            return varchar2 is

l_sql    varchar2(1000);
l_value  varchar2(500);

begin

       --l_sql := 'select DISTINCT ' || p_column_name || ' from ' || p_table_name || ' where 1 = 1 ' || 
         --       ' and ' || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;
--             execute immediate l_stmt using l_status,l_flow_status,l_flow_with,l_flow_level, l_user_grp_id ;

          
l_sql :='UPDATE' ||	p_table_name|| 
'SET' || p_column_name || '= :1' ||
' where 1 = 1 ' || 
' and ' || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;
	 
	 
       execute immediate l_sql using P_STATUS;
--      execute immediate l_sql;
--      into l_value;


return l_value;

end get_updateStatus;
end XXPM_TEST_PKG;
