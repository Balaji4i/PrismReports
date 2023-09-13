--------------------------------------------------------
--  DDL for Procedure GET_AREA_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "GET_AREA_DETAILS" GET_AREA_DETAILS

AS

L_CURSOR SYS_REFCURSOR;

BEGIN



OPEN L_CURSOR FOR

select AREA_ID      
,PROPERTY_ID       
,BUILD_ID          
,UNIT_ID           
,AREA              
,UOM                           
,DESCRIPTION       
,ACTIVE_YN         
,ATTRIBUTE_CATEGORY
,ATTRIBUTE1        
,ATTRIBUTE2        
,ATTRIBUTE3        
,ATTRIBUTE4        
,ATTRIBUTE5        
,ATTRIBUTE6        
,ATTRIBUTE7        
,ATTRIBUTE8        
,ATTRIBUTE9        
,ATTRIBUTE10       
,CREATED_BY        
,CREATION_DATE     
,LAST_UPDATED_BY   
,LAST_UPDATE_DATE  
,LAST_UPDATE_LOGIN 
from XXPM_PROPERTY_AREA;

 APEX_JSON.WRITE(L_CURSOR);
 COMMIT;

END;
