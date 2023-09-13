--------------------------------------------------------
--  DDL for Package Body XXPM_SCHEDULER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_SCHEDULER" is 
procedure DELETE_SCHEDULER_LIST
is 
begin 
delete FROM xxfnd_schedule_list_t  
where 
SCHEDULE_LIST_ID 
not in (
SELECT SCHEDULE_LIST_ID   FROM xxfnd_schedule_list_t 
where 
to_char(CREATION_DATE, 'HH24:MI:SS') >= to_char(sysdate-(0.125/24), 'HH24:MI:SS')
);
COMMIT;
end DELETE_SCHEDULER_LIST ; 

end XXPM_SCHEDULER;
