--------------------------------------------------------
--  DDL for Type XXPM_OFFER_HEADER_TYP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "XXPM_OFFER_HEADER_TYP" AS OBJECT (
    offer_hdr_id             NUMBER,
    org_id                   NUMBER,
    func_id                  NUMBER,
    offer_number             VARCHAR2(60 BYTE),
    offer_date               DATE,
    offer_from_date          DATE,
    offer_to_date            DATE,
    performed_by             NUMBER,
    revision_no              NUMBER,
    revision_date            DATE,
    revised_by               VARCHAR2(60 BYTE),
    ms_hdr_id                NUMBER,
    pl_id                    NUMBER,
    offer_type               VARCHAR2(60 BYTE),
    lead_id                  NUMBER,
    customer_id              NUMBER,
    cust_site_id             NUMBER,
    customer_name            VARCHAR2(250 BYTE),
    customer_phone_no        VARCHAR2(250 BYTE),
    customer_country         VARCHAR2(250 BYTE),
    salesman_id              NUMBER,
    currency_code            VARCHAR2(3 BYTE),
    checklist                VARCHAR2(250 BYTE),
    terms_desc               VARCHAR2(2000 BYTE),
    object_version_number    NUMBER,
    offer_flag               VARCHAR2(60 BYTE),
    tax_code                 VARCHAR2(60 BYTE),
    prev_booking_id          NUMBER,
    status                   VARCHAR2(60 BYTE),
    description              VARCHAR2(240 BYTE),
    flow_status              VARCHAR2(60 BYTE),
    flow_level               NUMBER,
    flow_with                NUMBER,
    user_grp_id              NUMBER,
    attribute_category       VARCHAR2(240 BYTE),
    attribute1               VARCHAR2(240 BYTE),
    attribute2               VARCHAR2(240 BYTE),
    attribute3               VARCHAR2(240 BYTE),
    attribute4               VARCHAR2(240 BYTE),
    attribute5               VARCHAR2(240 BYTE),
    attribute6               VARCHAR2(240 BYTE),
    attribute7               VARCHAR2(240 BYTE),
    attribute8               VARCHAR2(240 BYTE),
    attribute9               VARCHAR2(240 BYTE),
    attribute10              VARCHAR2(240 BYTE),
    created_by               VARCHAR2(60 BYTE),
    creation_date            TIMESTAMP,
    last_updated_by          VARCHAR2(60 BYTE),
    last_update_date         TIMESTAMP,
    last_update_login        VARCHAR2(150 BYTE),
    offer_end_date           DATE,
    usage                    VARCHAR2(30 BYTE),
    lead_source_channel      VARCHAR2(240 BYTE),
    lead_source_name         VARCHAR2(240 BYTE),
    vend_id                  NUMBER,
    vend_site_id             NUMBER,
    vend_contract_no         VARCHAR2(240 BYTE),
    property_id              NUMBER,
    email_id                 VARCHAR2(60 BYTE),
    lease_agreement_id       NUMBER,
    car_park_lease_agre_id   NUMBER,
    cust_accept              VARCHAR2(1),
    agency_name              VARCHAR2(300),
    sales_manager_name       VARCHAR2(300),
    agent_commission         NUMBER,
    agent_commission_perc    NUMBER,
    agent_name               VARCHAR2(300)
);
