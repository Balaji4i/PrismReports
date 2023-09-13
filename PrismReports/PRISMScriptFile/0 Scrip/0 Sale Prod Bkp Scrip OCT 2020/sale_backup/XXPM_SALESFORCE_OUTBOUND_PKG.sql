--------------------------------------------------------
--  DDL for Package XXPM_SALESFORCE_OUTBOUND_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_SALESFORCE_OUTBOUND_PKG" IS
    PROCEDURE get_area_details;

    PROCEDURE get_qualifiers_details;

    PROCEDURE get_modifiers_details;

    PROCEDURE get_fix_fittings_details;

    PROCEDURE get_property_buildings;

    PROCEDURE get_organizations;
--    XXPM_SALESFORCE_OUTBOUND_PKG


    PROCEDURE get_lookup_types;

    PROCEDURE get_lookup_values;

    PROCEDURE get_milestone_dtl;

    PROCEDURE get_property_master_details;

    PROCEDURE get_projects_details;

    PROCEDURE get_project_milestones_details;

    PROCEDURE get_pl_qualifiers_details;

    PROCEDURE get_pl_modifiers_details;

    PROCEDURE get_pl_lines_details;

    PROCEDURE get_pl_header_details;

    PROCEDURE get_pay_terms_details;

    PROCEDURE get_milestone_hdr_details;

    PROCEDURE get_property_features;

    PROCEDURE get_property_units;

    PROCEDURE offer_hdr (
        p_offer_hdr_id             IN                         NUMBER,
        p_org_id                   IN                         VARCHAR2,
        p_func_id                  IN                         VARCHAR2,
        p_offer_number             IN                         VARCHAR2,
        p_offer_date               IN                         VARCHAR2,
        p_offer_from_date          IN                         VARCHAR2,
        p_offer_to_date            IN                         VARCHAR2,
        p_performed_by             IN                         VARCHAR2,
        p_revision_no              IN                         VARCHAR2,
        p_revision_date            IN                         VARCHAR2,
        p_revised_by               IN                         VARCHAR2,
        p_ms_hdr_id                IN                         VARCHAR2,
        p_pl_id                    IN                         VARCHAR2,
        p_offer_type               IN                         VARCHAR2,
        p_lead_id                  IN                         VARCHAR2,
        p_customer_id              IN                         VARCHAR2,
        p_cust_site_id             IN                         VARCHAR2,
        p_customer_name            IN                         VARCHAR2,
        p_customer_phone_no        IN                         VARCHAR2,
        p_customer_country         IN                         VARCHAR2,
        p_salesman_id              IN                         VARCHAR2,
        p_currency_code            IN                         VARCHAR2,
        p_checklist                IN                         VARCHAR2,
        p_terms_desc               IN                         VARCHAR2,
        p_object_version_number    IN                         VARCHAR2,
        p_offer_flag               IN                         VARCHAR2,
        p_tax_code                 IN                         VARCHAR2,
        p_prev_booking_id          IN                         VARCHAR2,
        p_status                   IN                         VARCHAR2,
        p_description              IN                         VARCHAR2,
        p_flow_status              IN                         VARCHAR2,
        p_flow_level               IN                         VARCHAR2,
        p_flow_with                IN                         VARCHAR2,
        p_user_grp_id              IN                         VARCHAR2,
        p_attribute_category       IN                         VARCHAR2,
        p_attribute1               IN                         VARCHAR2,
        p_attribute2               IN                         VARCHAR2,
        p_attribute3               IN                         VARCHAR2,
        p_attribute4               IN                         VARCHAR2,
        p_attribute5               IN                         VARCHAR2,
        p_attribute6               IN                         VARCHAR2,
        p_attribute7               IN                         VARCHAR2,
        p_attribute8               IN                         VARCHAR2,
        p_attribute9               IN                         VARCHAR2,
        p_attribute10              IN                         VARCHAR2,
        p_created_by               IN                         VARCHAR2,
        p_creation_date            IN                         VARCHAR2,
        p_last_updated_by          IN                         VARCHAR2,
        p_last_update_date         IN                         VARCHAR2,
        p_last_update_login        IN                         VARCHAR2,
        p_offer_end_date           IN                         VARCHAR2,
        p_usage                    IN                         VARCHAR2,
        p_lead_source_channel      IN                         VARCHAR2,
        p_lead_source_name         IN                         VARCHAR2,
        p_vend_id                  IN                         VARCHAR2,
        p_vend_site_id             IN                         VARCHAR2,
        p_vend_contract_no         IN                         VARCHAR2,
        p_property_id              IN                         VARCHAR2,
        p_email_id                 IN                         VARCHAR2,
        p_lease_agreement_id       IN                         VARCHAR2,
        p_car_park_lease_agre_id   IN                         VARCHAR2,
        p_cust_accept              IN                         VARCHAR2,
        p_agency_name              IN                         VARCHAR2,
        p_sales_manager_name       IN                         VARCHAR2,
        p_agent_commission         IN                         VARCHAR2,
        p_agent_commission_perc    IN                         VARCHAR2,
        p_agent_name               IN                         VARCHAR2,
        p_NATIONALITY               IN                         VARCHAR2,       
        p_EMIRATES_ID               IN                         VARCHAR2,       
        l_status                   OUT                        VARCHAR2,
        l_errormessage             OUT                        VARCHAR2,
        l_out_offer_hdr            OUT                        NUMBER
    );

    PROCEDURE offer_detail (
        p_offer_dtl_id         IN                     VARCHAR2,
        p_offer_hdr_id         IN                     VARCHAR2,
        p_property_id          IN                     VARCHAR2,
        p_building_id          IN                     VARCHAR2,
        p_unit_id              IN                     VARCHAR2,
        p_uom                  IN                     VARCHAR2,
        p_quantity             IN                     VARCHAR2,
        p_base_rate            IN                     VARCHAR2,
        p_offer_amount         IN                     VARCHAR2,
        p_pl_mod_id            IN                     VARCHAR2,
        p_disc_pct             IN                     VARCHAR2,
        p_disc_amount          IN                     VARCHAR2,
        p_tax_code             IN                     VARCHAR2,
        p_tax_rate             IN                     VARCHAR2,
        p_tax_amount           IN                     VARCHAR2,
        p_attribute_category   IN                     VARCHAR2,
        p_attribute1           IN                     VARCHAR2,
        p_attribute2           IN                     VARCHAR2,
        p_attribute3           IN                     VARCHAR2,
        p_attribute4           IN                     VARCHAR2,
        p_attribute5           IN                     VARCHAR2,
        p_attribute6           IN                     VARCHAR2,
        p_attribute7           IN                     VARCHAR2,
        p_attribute8           IN                     VARCHAR2,
        p_attribute9           IN                     VARCHAR2,
        p_attribute10          IN                     VARCHAR2,
        p_created_by           IN                     VARCHAR2,
        p_creation_date        IN                     VARCHAR2,
        p_last_updated_by      IN                     VARCHAR2,
        p_last_update_date     IN                     VARCHAR2,
        p_last_update_login    IN                     VARCHAR2,
        p_DISC_TYPE            IN                     VARCHAR2,
        p_MIN_PRICE            IN                     VARCHAR2,
        l_status               OUT                    VARCHAR2,
        l_errormessage         OUT                    VARCHAR2,
        l_out_offer_dtl        OUT                    NUMBER
    );

    PROCEDURE offer_milestone (
        p_offer_ms_dtl_id      IN                     NUMBER,
        p_offer_hdr_id         IN                     NUMBER,
        p_ms_dtl_id            IN                     VARCHAR2,
        p_pl_mod_id            IN                     VARCHAR2,
        p_seq_number           IN                     VARCHAR2,
        p_installment_type     IN                     VARCHAR2,
        p_installment_pct      IN                     VARCHAR2,
        p_installment_amount   IN                     VARCHAR2,
        p_charge_type          IN                     VARCHAR2,
        p_payment_term         IN                     VARCHAR2,
        p_remarks              IN                     VARCHAR2,
        p_due_days             IN                     VARCHAR2,
        p_due_days_from        IN                     VARCHAR2,
        p_due_date             IN                     VARCHAR2,
        p_attribute_category   IN                     VARCHAR2,
        p_attribute1           IN                     VARCHAR2,
        p_attribute2           IN                     VARCHAR2,
        p_attribute3           IN                     VARCHAR2,
        p_attribute4           IN                     VARCHAR2,
        p_attribute5           IN                     VARCHAR2,
        p_attribute6           IN                     VARCHAR2,
        p_attribute7           IN                     VARCHAR2,
        p_attribute8           IN                     VARCHAR2,
        p_attribute9           IN                     VARCHAR2,
        p_attribute10          IN                     VARCHAR2,
        p_created_by           IN                     VARCHAR2,
        p_creation_date        IN                     VARCHAR2,
        p_last_updated_by      IN                     VARCHAR2,
        p_last_update_date     IN                     VARCHAR2,
        p_last_update_login    IN                     VARCHAR2,
        p_milestone_type       IN                     VARCHAR2,
        p_uom                  IN                     VARCHAR2,
        p_quantity             IN                     VARCHAR2,
        p_rate                 IN                     VARCHAR2,
        p_wave_off             IN                     VARCHAR2,
        p_installment_method   IN                     VARCHAR2,
        p_installment_event    IN                     VARCHAR2,
        p_period_occurence     IN                     VARCHAR2,
        p_period_values        IN                     VARCHAR2,
        p_period_duration      IN                     VARCHAR2,
        p_included_in_rate     IN                     VARCHAR2,
        p_tax_rate             IN                     NUMBER,
        p_tax_code             IN                     VARCHAR2,
        p_tax_amount           IN                     NUMBER,
        p_CARPARKING             IN                     VARCHAR2,
        p_OTHER_CHARGE_TYPE      IN                    VARCHAR2,
        l_status               OUT                    VARCHAR2,
        l_errormessage         OUT                    VARCHAR2,
        l_out_offer_ms         OUT                    NUMBER
    );

END xxpm_salesforce_outbound_pkg;
