--------------------------------------------------------
--  DDL for Procedure XXDM_SALES_MILESTONES_VAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXDM_SALES_MILESTONES_VAL" 
as
CURSOR cur_sales_miles
IS 
SELECT * from XXDM_SALES_MILESTONES WHERE nvl(status_flag,'N')='N';

l_err_msg          VARCHAR2(500);
l_status_flag      VARCHAR2(5);
l_milestone_type    VARCHAR2(50);
l_installment_type   VARCHAR2(50);
l_uom       VARCHAR2(50);
l_charge_type VARCHAR2(100);
l_payment_term VARCHAR2(50);
l_offer_number VARCHAR2(50);
 
 BEGIN
  FOR i IN cur_sales_miles
  loop
    l_err_msg     := NULL;
    l_status_flag := 'V';
	
	
	BEGIN
      SELECT count(*)
      INTO l_offer_number
      FROM xxpm_offer_header
      WHERE offer_number = i.booking_number;
      IF l_offer_number  > 0 THEN
	  
	  l_milestone_type :=xxpm_dm_lib_pkg.get_lookup('MILESTONE_TYPE',i.milestone_type);
        IF l_milestone_type IS NULL THEN 
        l_err_msg     := l_err_msg ||' invalid..CURMILESTONE_TYPE';
      l_status_flag := 'E';
      l_milestone_type := NULL;
    END IF;
	
	l_installment_type :=xxpm_dm_lib_pkg.get_lookup('MILESTONE_INSTALLMENT',i.installment_type);
        IF l_installment_type IS NULL THEN 
        l_err_msg     := l_err_msg ||' invalid..MILESTONE_INSTALLMEN';
      l_status_flag := 'E';
      l_installment_type := NULL;
    END IF;
	
	l_uom :=xxpm_dm_lib_pkg.get_lookup('AREA_UOM',i.uom);
        IF l_uom IS NULL THEN 
        l_err_msg     := l_err_msg ||' invalid..AREA_UOM';
      l_status_flag := 'E';
      l_uom := NULL;
    END IF;
	
	l_charge_type :=xxpm_dm_lib_pkg.get_lookup('CHARGE_TYPE',i.uom);
        IF l_charge_type IS NULL THEN 
        l_err_msg     := l_err_msg ||' invalid..CHARGE_TYPE';
      l_status_flag := 'E';
      l_charge_type := NULL;
    END IF;
	
	
	l_payment_term :=xxpm_dm_lib_pkg.get_payment_term(i.payment_term);
        IF l_payment_term IS NULL THEN 
        l_err_msg     := l_err_msg ||' invalid..PAYMENT_TERM';
      l_status_flag := 'E';
      l_payment_term := NULL;
    END IF;
	dbms_output.put_line('l_status_flag  '||l_status_flag );
    dbms_output.put_line('l_err_msg  '||l_err_msg );
    
    
    
	 UPDATE xxdm_sales_milestones
    SET P_INSTALLMENT_TYPE       =l_installment_type ,
      P_MILESTONE_TYPE         = l_milestone_type ,
      P_CHARGE_TYPE          =l_charge_type ,
      P_PAYMENT_TERM        =l_payment_term 
   WHERE booking_number = i.booking_number;
	
	 END IF;
	END loop;     
    END;
  COMMIT;
END xxdm_sales_milestones_val;
