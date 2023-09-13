--------------------------------------------------------
--  DDL for Package Body XXFND_SCHEDULE_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXFND_SCHEDULE_PKG" 
IS
   PROCEDURE generate_schedule
   IS
   BEGIN
      FOR i
         IN (SELECT xxfnd_schedule_list_s.NEXTVAL schedule_list_id
                   ,schedule_id
                   ,schedule_name
                   ,program_name
                   ,next_schedule_time last_refresh_time
                   ,  NVL (next_schedule_time, SYSDATE)
                    + (frequency_min / 24 / 60)
                       next_schedule_time
                   ,'PENDING' schedule_status
                   ,'-1' created_by
                   ,bi_report_path
                   ,bi_report_name
                   ,db_refresh_pkg
                   ,SYSDATE creation_date
                   ,'-1' last_updated_by
                   ,SYSDATE last_update_date
                   ,'-1' last_update_login
               FROM xxfnd_schedule_t
              WHERE     (   next_schedule_time <= SYSDATE
                         OR next_schedule_time IS NULL)
                    AND NVL (status, 'N') = 'Y')
      LOOP
         INSERT INTO xxfnd_schedule_list_t (schedule_list_id
                                           ,schedule_id
                                           ,schedule_name
                                           ,program_name
                                           ,last_refresh_time
                                           ,bi_report_path
                                           ,bi_report_name
                                           ,db_refresh_pkg
                                           ,schedule_status
                                           ,created_by
                                           ,creation_date
                                           ,last_updated_by
                                           ,last_update_date
                                           ,last_update_login)
              VALUES (i.schedule_list_id
                     ,i.schedule_id
                     ,i.schedule_name
                     ,i.program_name
                     ,i.last_refresh_time
                     ,i.bi_report_path
                     ,i.bi_report_name
                     ,i.db_refresh_pkg
                     ,i.schedule_status
                     ,i.created_by
                     ,i.creation_date
                     ,i.last_updated_by
                     ,i.last_update_date
                     ,i.last_update_login);

         UPDATE xxfnd_schedule_t
            SET next_schedule_time = i.next_schedule_time
          WHERE schedule_id = i.schedule_id;
         COMMIT;
--           XXPM_SCHEDULER.DELETE_SCHEDULER_LIST();
      END LOOP;
   END generate_schedule;
END xxfnd_schedule_pkg;
