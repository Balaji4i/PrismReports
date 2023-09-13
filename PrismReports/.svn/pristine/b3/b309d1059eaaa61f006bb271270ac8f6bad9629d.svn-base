--------------------------------------------------------
--  DDL for Package XXSF_AGENT_SYNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXSF_AGENT_SYNC" AS
    PROCEDURE merge_agency_sync (
        p_agency_id       IN   VARCHAR2,
        p_agency_name     IN   VARCHAR2,
        p_agency_type     IN   VARCHAR2,
        p_contract_type   IN   VARCHAR2,
        p_creation_date   IN   DATE,
        p_current_owner   IN   VARCHAR2,
        p_email           IN   VARCHAR2,
        p_mobile          IN   VARCHAR2,
        p_record_type     IN   VARCHAR2,
        p_status          IN   VARCHAR2
    );

    PROCEDURE merge_agent_sync (
        p_agency_id        IN   VARCHAR2,
        p_agency_name      IN   VARCHAR2,
        p_agent_name       IN   VARCHAR2,
        p_customer_owner   IN   VARCHAR2,
        p_email2           IN   VARCHAR2
    );

END xxsf_agent_sync;
