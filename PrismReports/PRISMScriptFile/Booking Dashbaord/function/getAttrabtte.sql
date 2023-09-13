select XXPM_PCS_DATA_PKG.get_attribute(:BV_SELECT_COLUMN, :BV_TABLENAME,:BV_WHERE_COLUMN, :BV_VALUE) as id from dual

create or replace PACKAGE "XXPM_PCS_DATA_PKG" is

   function get_attribute(p_column_name       in varchar2,
                           p_table_name        in varchar2,
                           p_where_condtion    in varchar2,
                           p_value             in varchar2)
            return varchar2 ;

end XXPM_PCS_DATA_PKG;

**********************************************************************


create or replace PACKAGE BODY "XXPM_PCS_DATA_PKG" is

function get_attribute( p_column_name       in varchar2,
                         p_table_name        in varchar2,
                         p_where_condtion    in varchar2,
                         p_value             in varchar2) 
            return varchar2 is

l_sql    varchar2(1000);
l_value  varchar2(500);

begin

       l_sql := 'select DISTINCT ' || p_column_name || ' from ' || p_table_name || ' where rownum = 1 ' || 
                ' and ' || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;

      execute immediate l_sql into l_value;

return l_value;

end get_attribute;
end XXPM_PCS_DATA_PKG;

**********************************************************************