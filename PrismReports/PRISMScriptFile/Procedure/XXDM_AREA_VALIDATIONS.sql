--------------------------------------------------------
--  DDL for Procedure XXDM_AREA_VALIDATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXDM_AREA_VALIDATIONS" (p_batch_id in number)
AS
CURSOR cur_dm_property_area
IS
SELECT 
  BUILD_ID,area,
  sum(DIFF_VAL) as diff_val
FROM XXDM_PROPERTY_AREA WHERE batch_id =p_batch_id AND INTERFACE_STATUS_FLAG ='V'
GROUP BY build_id,area;

l_unit_value NUMBER;
l_actual_unit_value  NUMBER;
l_total_unit_value NUMBER;
l_status_flag  varchar2(10);

BEGIN

FOR i IN cur_dm_property_area
loop

begin
SELECT sum(VALUE) INTO l_unit_value FROM xxpm_property_area WHERE build_id =i.build_id AND area =i.area AND unit_id IS NOT NULL;
SELECT VALUE INTO l_actual_unit_value FROM xxpm_property_area WHERE build_id =i.build_id AND area =i.area AND unit_id IS  NULL;



l_total_unit_value := l_unit_value+ i.diff_val ;
dbms_output.put_line(' l_unit_value  ' || l_unit_value || '     '||' i.diff_val  '||i.diff_val || '  l_total_unit_value   '  ||l_total_unit_value  ||'  l_actual_unit_value  '||l_actual_unit_value ) ;

IF l_total_unit_value  <= l_actual_unit_value THEN

l_status_flag := 'V' ;
ELSE

l_status_flag := 'E' ;
END IF;
dbms_output.put_line(' l_status_flag  '||l_status_flag );

exception when others then
l_status_flag := 'E' ;
dbms_output.put_line(' exception  occurs' );
end;

UPDATE XXDM_PROPERTY_AREA SET INTERFACE_STATUS_FLAG= l_status_flag   WHERE batch_id =p_batch_id AND  build_id =i.build_id AND area =i.area ;
COMMIT;
end loop;

end;
