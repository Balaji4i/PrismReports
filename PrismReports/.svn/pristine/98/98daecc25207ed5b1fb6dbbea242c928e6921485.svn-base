--------------------------------------------------------
--  DDL for Function GET_SPA_SIGNED_EVENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_SPA_SIGNED_EVENT" (
    i_booking_id IN NUMBER)
  RETURN NUMBER
IS
  event_count NUMBER; 
BEGIN
  SELECT count(*) into event_count
  FROM XXPM_BOOKING_EVENTS 
  WHERE 
  EVENT_TYPE = 'SSD' AND ACTIVE_YN = 'Y' 
  AND BOOKING_HDR_ID = i_booking_id;
    
    RETURN(event_count); 
END get_spa_signed_event;
