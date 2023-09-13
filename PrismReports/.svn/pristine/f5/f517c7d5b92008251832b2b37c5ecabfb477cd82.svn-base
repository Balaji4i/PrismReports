--------------------------------------------------------
--  DDL for Procedure XXPM_AREA_CHANGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_AREA_CHANGE" 
   (p_area_change_id   IN       NUMBER,
    p_err_code         OUT      VARCHAR2,
    p_err_msg          OUT      VARCHAR2)
IS
v_area_value number;
v_booking_milestone_s  number;
v_area_type         varchar2(30);
v_errm              varchar2(2000);
v_func_id           NUMBER;
l_invoice_id        NUMBER;
l_inv_func_id       NUMBER;
l_invoice_number    VARCHAR2 (30);
l_error_code        VARCHAR2 (100);
l_error_msg         VARCHAR2 (2000);
g_invoice_code      VARCHAR2 (5)    := 'IN';
g_currency_code     VARCHAR2 (5)    := 'AED';
l_invoice_line_id   NUMBER;
l_line_number       NUMBER;
l_status            NUMBER;
l_term_id           NUMBER;
v_org_id            NUMBER;
v_area_chng_number  VARCHAR2(60);
l_charge_type  VARCHAR2(60);
l_adj_amount    NUMBER;

--AREA_CNG_HDR_ID
cursor c_area_change_dtl
      is
      SELECT *
        FROM xxpm_area_change_dlt
       WHERE AREA_CNG_DLT_ID = p_area_change_id;

--cursor c_book_invoice (cp_booking_hdr_id number)
--is
--       select 
--        xad.area_cng_dlt_id,
--        xad.area_cng_hdr_id,
--        XAH.AREA_CNG_NUMBER,
--        xad.property_id,
--        xad.build_id,
--        xad.unit_id,
--        xad.area_id,
--        xad.booking_hdr_id,
--        xbh.org_id,
--        xbh.booking_number,
--        xar.txn_source,
--        xar.txn_type,
--        xoh.offer_hdr_id,
--        xoh.offer_number,
----        xoh.customer_id,
--        XBC.CUST_ID,
--        XBC.BILL_TO_SITE_ID,
----        xoh.cust_site_id,
--        xpb.build_number,
--        XPM.PROPERTY_NUMBER,
--        xpu.unit_number,xbm.payment_term
--        from xxpm_area_change_dlt xad,xxpm_area_change_hdr xah,xxpm_property_area xpa,
--        xxpm_booking_milestones xbm,
--        xxpm_ar_setup xar,
--        XXPM_BOOKING_HEADER XBH,
--        xxpm_booking_customer xbc,
--        xxpm_offer_header xoh,
--        xxpm_property_buildings xpb,
--        xxpm_property_master xpm,
--        xxpm_property_units xpu
--        where xad.area_id=xpa.area_id
--        and XAD.AREA_CNG_HDR_ID=XAH.AREA_CNG_HDR_ID
--        and xad.booking_hdr_id=xbm.booking_hdr_id (+)
--        AND xbm.charge_type = xar.charge_type(+)
--        AND XAD.BOOKING_HDR_ID=XBH.BOOKING_HDR_ID(+)
--        AND XBC.BOOKING_HDR_ID = XBH.BOOKING_HDR_ID
--        and xbc.PRIMARY_YN ='Y'
--        and xad.booking_hdr_id=cp_booking_hdr_id
--        and xbh.offer_hdr_id=xoh.offer_hdr_id(+)
--        and xad.property_id=xpm.property_id(+)
--        and xad.build_id=xpb.build_id(+)
--        and xad.unit_id=xpu.unit_id(+)
--        and xad.area_cng_dlt_id=p_area_change_id
--        group by
--        xad.area_cng_dlt_id,
--        xad.area_cng_hdr_id,
--        XAH.AREA_CNG_NUMBER,
--        xad.property_id,
--        xad.build_id,
--        xad.unit_id,
--        xad.area_id,
--        xad.booking_hdr_id,
--        xbh.org_id,
--        xbh.booking_number,
--        xar.txn_source,
--        xar.txn_type,
--        xoh.offer_hdr_id,
--        xoh.offer_number,
----        xoh.customer_id,
----        xoh.cust_site_id,
--        XBC.CUST_ID,
--        XBC.BILL_TO_SITE_ID,
--        xpb.build_number,
--        XPM.PROPERTY_NUMBER,
--        XPU.UNIT_NUMBER,xbm.payment_term
--        order by xad.area_cng_dlt_id;



BEGIN
     BEGIN
    SELECT func_id into v_func_id FROM xxfnd_functions where func_short_code='AC';
    select AREA_CNG_NUMBER into v_area_chng_number from xxpm_area_change_hdr where AREA_CNG_HDR_ID = (select AREA_CNG_HDR_ID from xxpm_area_change_dlt where AREA_CNG_DLT_ID=p_area_change_id);
     EXCEPTION
                    WHEN OTHERS
                    THEN
                         p_err_code := SQLCODE;
                         p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                         ROLLBACK;
                  END;
    For c_area in c_area_change_dtl
    Loop

    DBMS_OUTPUT.PUT_LINE( 'First loop' || p_area_change_id);
    DBMS_OUTPUT.PUT_LINE('Area change value :- ' || c_area.new_area_value ||'Area id :- ' ||c_area.area_id);
            update xxpm_property_area set value=c_area.new_area_value,last_update_date=sysdate,creation_date=sysdate,DESCRIPTION = c_area.DESCRIPTION
            where area_id=c_area.area_id;
            commit;
            update xxpm_area_change_dlt set status='APR' where area_id=c_area.area_id;
            BEGIN
                SELECT org_id into v_org_id FROM xxpm_property_master where PROPERTY_ID=c_area.PROPERTY_ID;
                 EXCEPTION
                    WHEN OTHERS
                    THEN
                         p_err_code := SQLCODE;
                         p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                         ROLLBACK;
                  END;
            XXPM_ACTIVITY_PKG.XXPM_PROC_ACTIVITY(v_func_id,c_area.AREA_CNG_DLT_ID,v_org_id,c_area.PROPERTY_ID,c_area.BUILD_ID,c_area.UNIT_ID,'ACAP','Area Changed with number '||v_area_chng_number||' from '||c_area.OLD_AREA_VALUE||' to '||c_area.NEW_AREA_VALUE,c_area.CREATED_BY);
            commit;

    DBMS_OUTPUT.PUT_LINE(c_area.CUST_ACCEPTED_YN);
    DBMS_OUTPUT.PUT_LINE(c_area.unit_status);
    DBMS_OUTPUT.PUT_LINE(c_area.ADJ_BOOKING_AMOUNT);

    BEGIN
        select area into v_area_type from xxpm_property_area where area_id=c_area.area_id;
        DBMS_OUTPUT.PUT_LINE (v_area_type);
    EXCEPTION
			WHEN OTHERS
			  THEN
               v_area_type := ''; 
			   v_errm := SQLCODE || '-' || SQLERRM;
	END;
        DBMS_OUTPUT.PUT_LINE ('v_area_type  ' ||v_area_type  ||'c_area.unit_status '||c_area.unit_status ||' c_area.CUST_ACCEPTED_YN  ' ||c_area.CUST_ACCEPTED_YN ||' c_area.ADJ_BOOKING_AMOUNT ' ||c_area.ADJ_BOOKING_AMOUNT);


if (v_area_type='CHARGE') and (c_area.unit_status ='BOOK') and (c_area.CUST_ACCEPTED_YN ='Y') and (c_area.ADJ_BOOKING_AMOUNT <> 0)
   then


   if c_area.ADJ_BOOKING_AMOUNT > 0 
   then
   l_charge_type :='AC_CHG';
   l_adj_amount := c_area.ADJ_BOOKING_AMOUNT;
   else

      l_charge_type :='CMC';
      l_adj_amount := -c_area.ADJ_BOOKING_AMOUNT;


   end if;

       BEGIN
         SELECT   XXPM_BOOKING_MILESTONES_S.nextval
         INTO   v_booking_milestone_s FROM   DUAL;



                  BEGIN
    select TERM_ID into l_term_id from xxstg_pay_terms where term_name='IMMEDIATE';    
    EXCEPTION
                    WHEN OTHERS
                    THEN
                         p_err_code := SQLCODE;
                         p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                         ROLLBACK;
                  END;


      DBMS_OUTPUT.PUT_LINE('INSERTING INTO BOOKING MILESTONES');            

      INSERT
      INTO XXPM_BOOKING_MILESTONES
        (
          BOOKING_MS_DTL_ID,
          SOURCE_FUNC_ID,
          SOURCE_FUNC_REF_ID,
          MILESTONE_TYPE,
          MS_DTL_ID,
          PL_MOD_ID,
          SEQ_NUMBER,
          INSTALLMENT_TYPE,
          INSTALLMENT_PCT,
          INSTALLMENT_AMOUNT,
          UOM,
          QUANTITY,
          RATE,
          WAVE_OFF,
          INCLUDED_IN_RATE,
          INSTALLMENT_METHOD,
          INSTALLMENT_EVENT,
          PERIOD_OCCURENCE,
          PERIOD_VALUES,
          PERIOD_DURATION,
          CHARGE_TYPE,
          PAYMENT_TERM,
          REMARKS,
          DUE_DAYS,
          DUE_DAYS_FROM,
          DUE_DATE,
          BILLING_ID,
          STATUS,
          INVOICE_ID,
          ATTRIBUTE_CATEGORY,
          ATTRIBUTE1,
          ATTRIBUTE2,
          ATTRIBUTE3,
          ATTRIBUTE4,
          ATTRIBUTE5,
          ATTRIBUTE6,
          ATTRIBUTE7,
          ATTRIBUTE8,
          ATTRIBUTE9,
          ATTRIBUTE10,
          CREATED_BY,
          CREATION_DATE,
          LAST_UPDATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATE_LOGIN,
		  BOOKING_HDR_ID
        )
        VALUES
        (
          v_booking_milestone_s,
          v_func_id,
          c_area.AREA_CNG_HDR_ID,
           'AC_CHG',
          null,
          null,
          null,
          NULL,
          null,
          l_adj_amount,
          c_area.UOM,
          1,
          l_adj_amount,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          l_charge_type,
         l_term_id,
          c_area.description,
          null,
          null,
          null,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          c_area.CREATED_BY,
          c_area.CREATION_DATE,
          c_area.LAST_UPDATED_BY,
          sysdate,
          c_area.LAST_UPDATE_LOGIN,
		  c_area.Booking_hdr_id
        );
        dbms_output.put_line(' after insertion    ');
        EXCEPTION
		WHEN OTHERS
             THEN
                   p_err_code := SQLCODE;
                   p_err_msg := SUBSTR (SQLERRM, 1, 2000);
                   ROLLBACK;
       END;


--    if (c_area.new_area_value<>0)
--    then
--          For c_invoice in c_book_invoice (c_area.booking_hdr_id)
--            Loop
--           DBMS_OUTPUT.PUT_LINE('SECOND LOOP ' || p_area_change_id);
--            l_invoice_id := xxpm_invoice_header_s.NEXTVAL;
--            l_inv_func_id := v_func_id;
--            DBMS_OUTPUT.PUT_LINE('Invoice ID ' || l_inv_func_id);
--            xxfnd_pkg.get_next_number (p_func_code      => g_invoice_code,
--                                       p_next_num       => l_invoice_number,
--                                       p_func_id        => l_inv_func_id,
--                                       p_err_code       => l_error_code,
--                                       p_err_msg        => l_error_msg
--                                       );
--            DBMS_OUTPUT.PUT_LINE(l_invoice_number || ' ' || l_inv_func_id || ' ' || g_invoice_code);  
--
--
--             INSERT INTO xxpm_invoice_header
--                     (invoice_id, invoice_number, invoice_date,func_id,
--                      invoice_class, org_id, trx_source,
--                      trx_type, currency_code, exchange_rate, cust_id,
--                      cust_site_id, payment_terms, due_date,
--                      status, interface_status, offer_id,
--                      offer_number, booking_id, booking_number,
--                      sale_lease_number, customer_trx_id,
--                      customer_trx_number, invoicing_rule, acnt_rule,
--                      rule_start_date, rule_end_date, attribute_category,
--                      attribute1, attribute2, attribute3, attribute4,
--                      attribute5, attribute6, attribute7, attribute8,
--                      attribute9, attribute10, created_by, created_date,
--                      last_updated_by, last_update_date, last_update_login)
--               values
--                     (l_invoice_id,l_invoice_number,sysdate,l_inv_func_id,
--                     NULL,C_INVOICE.ORG_ID,C_INVOICE.TXN_SOURCE,C_INVOICE.TXN_TYPE,'AED',NULL,
--                     c_invoice.CUST_ID,c_invoice.BILL_TO_SITE_ID,c_invoice.payment_term,sysdate+1,'APR'
--                     ,'READY_TO_INVOICE',c_invoice.offer_hdr_id,
--                      c_invoice.offer_number,c_invoice.booking_hdr_id,c_invoice.booking_number,
--                       NULL, NULL,NULL, NULL, NULL,NULL, NULL, NULL,NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL,
--                      NULL, NULL,c_area.CREATED_BY,
--                      c_area.CREATION_DATE,c_area.LAST_UPDATED_BY,
--                      sysdate,c_area.LAST_UPDATE_LOGIN);
--
--
--           ------Invoice lines-------
--
--           l_invoice_line_id := xxpm_invoice_lines_s.NEXTVAL;
--           l_line_number := l_line_number + 1;
--
--           INSERT INTO xxpm_invoice_lines
--					(invoice_id, invoice_line_id, line_number,
--					 description, uom_code, quantity, price, amount,
--					 tax_code, tax_perc, tax_amount,
--					 charge_type, rev_acnt_id, rev_acnt_code,
--					 offer_dtl_id, booking_dtl_id, property_id,
--					 property_number, build_id, build_number,
--					 unit_id, unit_number, billing_ms_id,
--					 installment_type, customer_trx_line_id,
--					 attribute_category, attribute1, attribute2,
--					 attribute3, attribute4, attribute5, attribute6,
--					 attribute7, attribute8, attribute9, attribute10,
--					 created_by, created_date, last_updated_by,
--					 last_update_date, last_update_login)
--           VALUES ( l_invoice_id, l_invoice_line_id, l_line_number,
--					'AREA CHANGE FOR DONE FOR THE AREA NUMBER:- ' || c_invoice.AREA_CNG_NUMBER, 'EACH', 1, c_area.ADJ_BOOKING_AMOUNT, c_area.ADJ_BOOKING_AMOUNT,
--					NULL, NULL, NULL,
--					'AC_CHG', NULL, NULL,NULL, 123,
--					c_area.property_id,c_invoice.property_number, c_area.build_id, c_invoice.build_number,
--					c_area.unit_id, c_invoice.unit_number,null,null, 
--					NULL,NULL, NULL, NULL,NULL, NULL, NULL, NULL,
--					NULL, NULL, NULL, NULL,c_area.CREATED_BY,
--                    c_area.CREATION_DATE,c_area.LAST_UPDATED_BY,
--                    sysdate,c_area.LAST_UPDATE_LOGIN);
--           end loop;           
--    end if;
end if;   
    commit;
--    update XXPM_BOOKING_MILESTONES set invoice_id=l_invoice_id where  BOOKING_MS_DTL_ID=v_booking_milestone_s;
    commit;

    select count(1) into l_status from xxpm_area_change_dlt where status<>'APR' and AREA_CNG_HDR_ID=c_area.AREA_CNG_HDR_ID; 

    if (l_status = 0) then

    DBMS_OUTPUT.PUT_LINE('STATUS TO BE UPDATED AS APPROVED IN HEADER TABLE IF ALL THE LINE ITEM HAS BEEN APPROVED');

    update xxpm_area_change_hdr set status='APR' where AREA_CNG_HDR_ID=c_area.AREA_CNG_HDR_ID;
    commit;

    end if;
     END LOOP;


END xxpm_area_change;
