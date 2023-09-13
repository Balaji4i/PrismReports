SELECT      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','ALL','ALL') as  All_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','APR','NULL') as  APR_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','DRA','NULL') as DRA_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','PEN','NULL') as PEN_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','REJ','NULL') as REJ_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','CANCEL','NULL') as CANCEL_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','RESALE','NULL') as RESALE_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','TR','NULL') as TERM_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','SWAP','NULL') as SWAP_BOOKING,      
GET_TOTALCOUNT('XXPM_BOOKING_HEADER','STATUS','HAND','NULL') as HAND_BOOKING,    
GET_DUE_BASED_COUNT('ALL_OVER_DUE',0) AS OVER_DUE_COUNT,    
GET_DUE_BASED_COUNT('ALL_7_DAYS',0) AS DUE_7_COUNT    
FROM dual;

create or replace function GET_TotalCount( 
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