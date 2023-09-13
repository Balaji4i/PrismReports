--------------------------------------------------------
--  DDL for Procedure XXPM_OFFER_HEADER_SERVICE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_OFFER_HEADER_SERVICE" (
    xxpm_offer_header_type_t xxpm_offer_header_type,
    p_offer_header_id OUT NUMBER
) AS
    v_temp NUMBER;
    CURSOR c1 (
        p_offer_header_id NUMBER
    ) IS
    SELECT
        1
    FROM
        xxpm_offer_header
    WHERE
        offer_hdr_id = p_offer_header_id;

BEGIN
    FOR i IN 1..xxpm_offer_header_type_t.count LOOP
        dbms_output.put_line('  loop   ');
        SELECT
            xxpm_offer_header_type_t(i).offer_hdr_id
        INTO p_offer_header_id
        FROM
            dual;

        OPEN c1(p_offer_header_id);
        FETCH c1 INTO v_temp;
        IF c1%notfound THEN
            SELECT
                offer_hdr_id_s.NEXTVAL
            INTO p_offer_header_id
            FROM
                dual;

        ELSE
            NULL;
        END IF;

        CLOSE c1;
        MERGE INTO xxpm_offer_header a USING (
                                                 SELECT
                                                     p_offer_header_id offer_hdr_id,
                                                     xxpm_offer_header_type_t(i).org_id org_id,
                                                     xxpm_offer_header_type_t(i).func_id func_id,
                                                     xxpm_offer_header_type_t(i).offer_number offer_number,
                                                     xxpm_offer_header_type_t(i).offer_date offer_date,
                                                     xxpm_offer_header_type_t(i).offer_from_date offer_from_date,
                                                     xxpm_offer_header_type_t(i).offer_to_date offer_to_date,
                                                     xxpm_offer_header_type_t(i).performed_by performed_by,
                                                     xxpm_offer_header_type_t(i).revision_no revision_no,
                                                     xxpm_offer_header_type_t(i).revision_date revision_date,
                                                     xxpm_offer_header_type_t(i).revised_by revised_by,
                                                     xxpm_offer_header_type_t(i).ms_hdr_id ms_hdr_id,
                                                     xxpm_offer_header_type_t(i).pl_id pl_id,
                                                     xxpm_offer_header_type_t(i).offer_type offer_type,
                                                     xxpm_offer_header_type_t(i).lead_id lead_id,
                                                     xxpm_offer_header_type_t(i).customer_id customer_id,
                                                     xxpm_offer_header_type_t(i).cust_site_id cust_site_id,
                                                     xxpm_offer_header_type_t(i).customer_name customer_name,
                                                     xxpm_offer_header_type_t(i).customer_phone_no customer_phone_no,
                                                     xxpm_offer_header_type_t(i).customer_country customer_country,
                                                     xxpm_offer_header_type_t(i).salesman_id salesman_id,
                                                     xxpm_offer_header_type_t(i).currency_code currency_code,
                                                     xxpm_offer_header_type_t(i).checklist checklist,
                                                     xxpm_offer_header_type_t(i).terms_desc terms_desc,
                                                     xxpm_offer_header_type_t(i).object_version_number object_version_number,
                                                     xxpm_offer_header_type_t(i).offer_flag offer_flag,
                                                     xxpm_offer_header_type_t(i).tax_code tax_code,
                                                     xxpm_offer_header_type_t(i).prev_booking_id prev_booking_id,
                                                     xxpm_offer_header_type_t(i).status status,
                                                     xxpm_offer_header_type_t(i).description description,
                                                     xxpm_offer_header_type_t(i).flow_status flow_status,
                                                     xxpm_offer_header_type_t(i).flow_level flow_level,
                                                     xxpm_offer_header_type_t(i).flow_with flow_with,
                                                     xxpm_offer_header_type_t(i).user_grp_id user_grp_id,
                                                     xxpm_offer_header_type_t(i).attribute_category attribute_category,
                                                     xxpm_offer_header_type_t(i).attribute1 attribute1,
                                                     xxpm_offer_header_type_t(i).attribute2 attribute2,
                                                     xxpm_offer_header_type_t(i).attribute3 attribute3,
                                                     xxpm_offer_header_type_t(i).attribute4 attribute4,
                                                     xxpm_offer_header_type_t(i).attribute5 attribute5,
                                                     xxpm_offer_header_type_t(i).attribute6 attribute6,
                                                     xxpm_offer_header_type_t(i).attribute7 attribute7,
                                                     xxpm_offer_header_type_t(i).attribute8 attribute8,
                                                     xxpm_offer_header_type_t(i).attribute9 attribute9,
                                                     xxpm_offer_header_type_t(i).attribute10 attribute10,
                                                     xxpm_offer_header_type_t(i).created_by created_by,
                                                     xxpm_offer_header_type_t(i).creation_date creation_date,
                                                     xxpm_offer_header_type_t(i).last_updated_by last_updated_by,
                                                     xxpm_offer_header_type_t(i).last_update_date last_update_date,
                                                     xxpm_offer_header_type_t(i).last_update_login last_update_login,
                                                     xxpm_offer_header_type_t(i).offer_end_date offer_end_date,
                                                     xxpm_offer_header_type_t(i).usage usage,
                                                     xxpm_offer_header_type_t(i).lead_source_channel lead_source_channel,
                                                     xxpm_offer_header_type_t(i).lead_source_name lead_source_name,
                                                     xxpm_offer_header_type_t(i).vend_id vend_id,
                                                     xxpm_offer_header_type_t(i).vend_site_id vend_site_id,
                                                     xxpm_offer_header_type_t(i).vend_contract_no vend_contract_no,
                                                     xxpm_offer_header_type_t(i).property_id property_id,
                                                     xxpm_offer_header_type_t(i).email_id email_id,
                                                     xxpm_offer_header_type_t(i).agency_name agency_name,
                                                     xxpm_offer_header_type_t(i).sales_manager_name sales_manager_name,
                                                     xxpm_offer_header_type_t(i).agent_commission agent_commission,
                                                     xxpm_offer_header_type_t(i).agent_commission_perc agent_commission_perc,
                                                     xxpm_offer_header_type_t(i).agent_name agent_name
                                                 FROM
                                                     dual
                                             )
        b ON ( a.offer_hdr_id = b.offer_hdr_id )
        WHEN MATCHED THEN UPDATE SET org_id = b.org_id,
        func_id = b.func_id,
        offer_number = b.offer_number,
        offer_date = b.offer_date,
        offer_from_date = b.offer_from_date,
        offer_to_date = b.offer_to_date,
        performed_by = b.performed_by,
        revision_no = b.revision_no,
        revision_date = b.revision_date,
        revised_by = b.revised_by,
        ms_hdr_id = b.ms_hdr_id,
        pl_id = b.pl_id,
        offer_type = b.offer_type,
        lead_id = b.lead_id,
        customer_id = b.customer_id,
        cust_site_id = b.cust_site_id,
        customer_name = b.customer_name,
        customer_phone_no = b.customer_phone_no,
        customer_country = b.customer_country,
        salesman_id = b.salesman_id,
        currency_code = b.currency_code,
        checklist = b.checklist,
        terms_desc = b.terms_desc,
        object_version_number = b.object_version_number,
        offer_flag = b.offer_flag,
        tax_code = b.tax_code,
        prev_booking_id = b.prev_booking_id,
        status = b.status,
        description = b.description,
        flow_status = b.flow_status,
        flow_level = b.flow_level,
        flow_with = b.flow_with,
        user_grp_id = b.user_grp_id,
        attribute_category = b.attribute_category,
        attribute1 = b.attribute1,
        attribute2 = b.attribute2,
        attribute3 = b.attribute3,
        attribute4 = b.attribute4,
        attribute5 = b.attribute5,
        attribute6 = b.attribute6,
        attribute7 = b.attribute7,
        attribute8 = b.attribute8,
        attribute9 = b.attribute9,
        attribute10 = b.attribute10,
        created_by = b.created_by,
        creation_date = b.creation_date,
        last_updated_by = b.last_updated_by,
        last_update_date = b.last_update_date,
        last_update_login = b.last_update_login,
        offer_end_date = b.offer_end_date,
        usage = b.usage,
        lead_source_channel = b.lead_source_channel,
        lead_source_name = b.lead_source_name,
        vend_id = b.vend_id,
        vend_site_id = b.vend_site_id,
        vend_contract_no = b.vend_contract_no,
        property_id = b.property_id,
        email_id = b.email_id,
        agency_name = b.agency_name,
        sales_manager_name = b.sales_manager_name,
        agent_commission = b.agent_commission,
        agent_commission_perc = b.agent_commission_perc,
                                     agent_name = b.agent_name
        WHEN NOT MATCHED THEN INSERT (
            offer_hdr_id,
            org_id,
            func_id,
            offer_number,
            offer_date,
            offer_from_date,
            offer_to_date,
            performed_by,
            revision_no,
            revision_date,
            revised_by,
            ms_hdr_id,
            pl_id,
            offer_type,
            lead_id,
            customer_id,
            cust_site_id,
            customer_name,
            customer_phone_no,
            customer_country,
            salesman_id,
            currency_code,
            checklist,
            terms_desc,
            object_version_number,
            offer_flag,
            tax_code,
            prev_booking_id,
            status,
            description,
            flow_status,
            flow_level,
            flow_with,
            user_grp_id,
            attribute_category,
            attribute1,
            attribute2,
            attribute3,
            attribute4,
            attribute5,
            attribute6,
            attribute7,
            attribute8,
            attribute9,
            attribute10,
            created_by,
            creation_date,
            last_updated_by,
            last_update_date,
            last_update_login,
            offer_end_date,
            usage,
            lead_source_channel,
            lead_source_name,
            vend_id,
            vend_site_id,
            vend_contract_no,
            property_id,
            email_id,
            agency_name,
            sales_manager_name,
            agent_commission,
            agent_commission_perc,
            agent_name         

--    ,
--    LEASE_AGREEMENT_ID     ,
--    CAR_PARK_LEASE_AGRE_ID  ,
--    CUST_ACCEPT
             ) VALUES (
            p_offer_header_id,--OFFER_HDR_ID_S.NEXTVAL , 
            xxpm_offer_header_type_t(i).org_id,
            xxpm_offer_header_type_t(i).func_id,
            xxpm_offer_header_type_t(i).offer_number,
            xxpm_offer_header_type_t(i).offer_date,
            xxpm_offer_header_type_t(i).offer_from_date,
            xxpm_offer_header_type_t(i).offer_to_date,
            xxpm_offer_header_type_t(i).performed_by,
            xxpm_offer_header_type_t(i).revision_no,
            xxpm_offer_header_type_t(i).revision_date,
            xxpm_offer_header_type_t(i).revised_by,
            xxpm_offer_header_type_t(i).ms_hdr_id,
            xxpm_offer_header_type_t(i).pl_id,
            xxpm_offer_header_type_t(i).offer_type,
            xxpm_offer_header_type_t(i).lead_id,
            xxpm_offer_header_type_t(i).customer_id,
            xxpm_offer_header_type_t(i).cust_site_id,
            xxpm_offer_header_type_t(i).customer_name,
            xxpm_offer_header_type_t(i).customer_phone_no,
            xxpm_offer_header_type_t(i).customer_country,
            xxpm_offer_header_type_t(i).salesman_id,
            xxpm_offer_header_type_t(i).currency_code,
            xxpm_offer_header_type_t(i).checklist,
            xxpm_offer_header_type_t(i).terms_desc,
            xxpm_offer_header_type_t(i).object_version_number,
            xxpm_offer_header_type_t(i).offer_flag,
            xxpm_offer_header_type_t(i).tax_code,
            xxpm_offer_header_type_t(i).prev_booking_id,
            xxpm_offer_header_type_t(i).status,
            xxpm_offer_header_type_t(i).description,
            xxpm_offer_header_type_t(i).flow_status,
            xxpm_offer_header_type_t(i).flow_level,
            xxpm_offer_header_type_t(i).flow_with,
            xxpm_offer_header_type_t(i).user_grp_id,
            xxpm_offer_header_type_t(i).attribute_category,
            xxpm_offer_header_type_t(i).attribute1,
            xxpm_offer_header_type_t(i).attribute2,
            xxpm_offer_header_type_t(i).attribute3,
            xxpm_offer_header_type_t(i).attribute4,
            xxpm_offer_header_type_t(i).attribute5,
            xxpm_offer_header_type_t(i).attribute6,
            xxpm_offer_header_type_t(i).attribute7,
            xxpm_offer_header_type_t(i).attribute8,
            xxpm_offer_header_type_t(i).attribute9,
            xxpm_offer_header_type_t(i).attribute10,
            xxpm_offer_header_type_t(i).created_by,
            xxpm_offer_header_type_t(i).creation_date,
            xxpm_offer_header_type_t(i).last_updated_by,
            xxpm_offer_header_type_t(i).last_update_date,
            xxpm_offer_header_type_t(i).last_update_login,
            xxpm_offer_header_type_t(i).offer_end_date,
            xxpm_offer_header_type_t(i).usage,
            xxpm_offer_header_type_t(i).lead_source_channel,
            xxpm_offer_header_type_t(i).lead_source_name,
            xxpm_offer_header_type_t(i).vend_id,
            xxpm_offer_header_type_t(i).vend_site_id,
            xxpm_offer_header_type_t(i).vend_contract_no,
            xxpm_offer_header_type_t(i).property_id,
            xxpm_offer_header_type_t(i).email_id,
            xxpm_offer_header_type_t(i).agency_name,
            xxpm_offer_header_type_t(i).sales_manager_name,
            xxpm_offer_header_type_t(i).agent_commission,
            xxpm_offer_header_type_t(i).agent_commission_perc,
            xxpm_offer_header_type_t(i).agent_name            
-- XXPM_OFFER_HEADER_TYPE_T (i).LEASE_AGREEMENT_ID	    ,
--      XXPM_OFFER_HEADER_TYPE_T (i).CAR_PARK_LEASE_AGRE_ID     ,
--      XXPM_OFFER_HEADER_TYPE_T (i).CUST_ACCEPT		       
             );

        COMMIT;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END xxpm_offer_header_service;
