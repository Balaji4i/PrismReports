--------------------------------------------------------
--  DDL for Package XXPM_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_BOOKING" is

function getmileStone_amt(p_booking_id in number,p_type in varchar2)
return number;

function getBookingTotal(p_booking_id in number)
return number;

function getBookingNumber(p_invoice_id in number)
return varchar2;

function getBuildingName(p_invoice_id in number)
return varchar2;

function getUnitNumber(p_invoice_id in number)
return varchar2;

function getUsage(p_invoice_id in number)
return varchar2;

end xxpm_booking;
