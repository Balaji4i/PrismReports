create or replace procedure XXPM_DASHBOARD_RECEIPT(
                                P_INVOICE 	        IN NUMBER,
                                P_BOOKING_ID        IN NUMBER,
                                P_TOAL_INV_AMT      IN NUMBER,
                                P_LOGIN_USER        IN varchar2,
                                P_RECEIPT_Id       OUT NUMBER
                                )
as
l_RECEIPT_ID NUMBER;
l_FUNC_ID NUMBER;
l_RECEIPT_NUMBER varchar2(30);
--l_SOURCE_FUNC_ID NUMBER;
--l_SOURCE_FUNC_REF_ID NUMBER;
l_RECEIPT_DATE DATE;
l_RECEIPT_DTL_ID number;

BEGIN
l_RECEIPT_ID:=XXPM_RECEIPT_ID_S.NEXTVAL;
l_FUNC_ID:=9;
l_RECEIPT_NUMBER:='RT-'||l_RECEIPT_ID||to_char(sysdate, 'MONddyy');
l_RECEIPT_DATE:=sysdate;
l_RECEIPT_DTL_ID:=RECEIPT_DTL_ID_S.nextval;

--dbms_output.put_line('l_RECEIPT_ID-->'||l_RECEIPT_ID);
--dbms_output.put_line('l_FUNC_ID-->'||l_FUNC_ID);
--dbms_output.put_line('l_RECEIPT_NUMBER-->'||l_RECEIPT_NUMBER);
--dbms_output.put_line('l_RECEIPT_DATE->'||l_RECEIPT_DATE);
--dbms_output.put_line('l_RECEIPT_DTL_ID->'||l_RECEIPT_DTL_ID);
INSERT INTO xxpm_receipt
(
    RECEIPT_ID,
    FUNC_ID,
    RECEIPT_NUMBER,
    RECEIPT_DATE,
    SOURCE_FUNC_ID,
    SOURCE_FUNC_REF_ID,  
    ORG_ID,
    PROPERTY_ID,
    UNIT_ID,
    BUILD_ID,
    CUST_ID,
    CUST_SITE_ID,
    CUSTOMER_NAME,
    CURRENCY_CODE,
    RECEIPT_TYPE,
    INTERFACE_STATUS,
    CREATED_BY,
    CREATION_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN,
    RECOMMENDED_AMOUNT

)
(
SELECT 
 l_RECEIPT_ID
,l_FUNC_ID
,l_RECEIPT_NUMBER
,l_RECEIPT_DATE
,BH.FUNC_ID
,BH.BOOKING_HDR_ID
,BH.ORG_ID
,BD.PROPERTY_ID
,BD.UNIT_ID
,BD.BUILDING_ID
,inv.CUST_ID
,inv.CUST_SITE_ID
,cus.CUSTOMER_NAME
,BH.CURRENCY_CODE
,BM.CHARGE_TYPE
,'Draft'
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,P_TOAL_INV_AMT
FROM 
xxpm_booking_milestones BM, xxpm_booking_header BH, xxpm_booking_detail BD, xxpm_invoice_header inv, xxstg_customer cus
WHERE 
BH.BOOKING_HDR_ID=BM.BOOKING_HDR_ID
AND BD.BOOKING_HDR_ID=BH.BOOKING_HDR_ID
and inv.INVOICE_ID=BM.INVOICE_ID
and BH.BOOKING_HDR_ID=inv.BOOKING_ID
and cus.CUST_ID=inv.CUST_ID
AND BM.INVOICE_ID=P_INVOICE);
--insert line
insert into xxpm_receipt_details
(
RECEIPT_DTL_ID,
RECEIPT_ID    ,
BOOKING_MS_DTL_ID,
INVOICE_ID       ,
INTERFACE_STATUS ,
CREATED_BY       ,
CREATION_DATE    ,
LAST_UPDATED_BY ,
LAST_UPDATE_DATE ,
LAST_UPDATE_LOGIN
)
(SELECT 
l_RECEIPT_DTL_ID
,l_RECEIPT_ID
,BOOKING_MS_DTL_ID 
,invoice_id
,'Draft'
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
,sysdate
,P_LOGIN_USER
FROM 
xxpm_booking_milestones 
where invoice_id=P_INVOICE);
commit;
P_RECEIPT_Id:=l_RECEIPT_ID;
END;