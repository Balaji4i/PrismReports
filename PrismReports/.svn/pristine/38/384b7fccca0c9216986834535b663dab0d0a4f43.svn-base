--------------------------------------------------------
--  DDL for Package Body XXPL_PROPERTY_LEASE_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPL_PROPERTY_LEASE_PKG" is

function get_id( p_column_name       in varchar2,
                 p_table_name        in varchar2,
                 p_where_condtion    in varchar2,
                 p_value             in varchar2) 
            return varchar2 is

l_sql    varchar2(1000);
l_value  varchar2(500);

begin

       l_sql := 'select ' || p_column_name || ' from ' || p_table_name || ' where 1 = 1 ' || 
                ' and ' || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;

      execute immediate l_sql into l_value;

return l_value;

end get_id;
end xxpl_property_lease_pkg;
