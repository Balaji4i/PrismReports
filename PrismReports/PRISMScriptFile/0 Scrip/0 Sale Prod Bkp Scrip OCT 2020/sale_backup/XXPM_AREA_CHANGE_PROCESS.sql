--------------------------------------------------------
--  DDL for Package XXPM_AREA_CHANGE_PROCESS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_AREA_CHANGE_PROCESS" 
AS

PROCEDURE XXPM_AREA_CHANGE_CALC( 
						p_old_area in number,
						p_new_area in number,
						p_bookinghdr in number,
						p_unit_id  in number,
						p_tolerance in number,
						p_login_user in varchar2,
						p_old_booking in number,
						p_type out varchar2,
						p_new_booking out number,
						p_amount_differ out number
  );

FUNCTION xxpm_update_unit_area (
                        p_property_id       IN             NUMBER,
                        p_build_id          IN             NUMBER,
                        p_unitid            IN             number,
                        p_new_area          IN             NUMBER, 
                        p_valuediff         IN             number
                        )
return varchar2;

PROCEDURE XXPM_AREA_CHANGE_SUBMIT(
                        p_area_change_Id in number,
                        p_flag out varchar2
                        );


FUNCTION GET_LINE_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
) 
RETURN NUMBER ;

FUNCTION GET_TAX_AMT (
    p_TOTAL_SPA     IN             NUMBER,
    p_TAX_CODE      IN             VARCHAR2,
    p_TAX_PERC      IN             NUMBER
)
RETURN NUMBER ;



END;
