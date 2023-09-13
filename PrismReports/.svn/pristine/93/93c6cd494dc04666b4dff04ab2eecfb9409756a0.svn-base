create or replace function GET_TotalCount( 
								p_table_name        in varchar2,
								p_where_condtion    in varchar2,
								p_value             in varchar2,
								p_ALL       in varchar2
						   ) 
            return number is

l_sql    varchar2(1000);
l_value  number;

begin

if(p_ALL='NULL') then
        l_sql := 'select count(*)  from ' || p_table_name || ' where '
                 || p_where_condtion || ' = ' || '''' ||  p_value || '''' ;
else 
        l_sql := 'select count(*)  from ' || p_table_name;
end if;
       DBMS_OUTPUT.put_line('l_sql-->'||l_sql); 
      execute immediate l_sql into l_value;

return l_value;

end GET_TotalCount;