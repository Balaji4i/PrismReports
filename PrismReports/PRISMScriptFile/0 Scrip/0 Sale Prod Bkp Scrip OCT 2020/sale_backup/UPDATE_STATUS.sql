--------------------------------------------------------
--  DDL for Procedure UPDATE_STATUS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_STATUS" is

l_booking_id number;
l_lease_id number;
l_recommend_id number;
l_offer_hdr_id number;

--cursor c1 is
--select * from XXPM_EXTEN_CANCEL 
--where TRANS_TYPE ='CAN' and STATUS = 'APR' and
--to_DATE(due_date,'DD-MON-YY') = TO_DATE(SYSDATE,'DD-MON-YY');
--
--cursor c2(p_booking_id number) is
--select * from XXPM_BOOKING_DETAIL where BOOKING_ID = p_booking_id;

begin

--for c in c1 
--loop
--l_booking_id := c.BOOKING_ID;
--l_lease_id := c.LEASE_AGREEMENT_ID;
--
--for i in c2(l_booking_id)
--loop
--update XXPL_PROPERTY_UNITS set STATUS = 'AVAL' where UNIT_ID = i.UNIT_ID;
--
--
--end loop;
--
--SELECT RECOMMEND_ID into l_recommend_id  FROM XXPM_LEASE_AGREEMENT where LEASE_AGREEMENT_ID = l_lease_id;
--SELECT OFFER_HDR_ID into l_offer_hdr_id FROM XXPM_BOOKING_HEADER where BOOKING_ID =  l_booking_id;
--
--update XXPM_LEASE_AGREEMENT set STATUS = 'CANC' WHERE LEASE_AGREEMENT_ID = l_lease_id;
--update XXPM_RECOMMEND_HEADER set STATUS = 'CANC' WHERE RECOMMEND_ID = l_recommend_id;
--update XXPM_BOOKING_HEADER set STATUS = 'CANC' WHERE BOOKING_ID = l_booking_id;
--update XXPM_OFFER_HEADER set STATUS = 'CANC' WHERE OFFER_HDR_ID = l_offer_hdr_id;
--
--
--end loop;
--
--commit;
null;
--exception
--when others then
--dbms_output.put_line('Exception '||sqlerrm);

end update_status;
