--------------------------------------------------------
--  DDL for Function GET_TOTALCOUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_TOTALCOUNT" ( 
								p_table_name        in varchar2,
								p_where_condtion    in varchar2,
								p_value             in varchar2,
								p_ALL       in varchar2
						   ) 
            return number is

l_sql    varchar2(1000);
l_value  number;
y_val varchar2(10) := 'Y';
begin

if(p_ALL='NULL') then
null;
        l_sql := 'select count(*)  from ' || p_table_name || ' where ACTIVE_YN = ''Y'' AND '
                 || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;
else 
        l_sql := 'select count(*)  from ' || p_table_name ||' WHERE ACTIVE_YN =''Y'' ';
end if;
       DBMS_OUTPUT.put_line('l_sql-->'||l_sql); 
      execute immediate l_sql into l_value;

return l_value;

end GET_TotalCount;
