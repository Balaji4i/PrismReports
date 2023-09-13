--------------------------------------------------------
--  DDL for View XXSF_AGENTS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXSF_AGENTS_V" ("AGENT_NAME", "SECOND_NAME", "AGENCY_ID", "CUSTOMER_OWNER", "RECORD_TYPE", "LANGUAGE", "PROPERTY_TYPE", "STATUS", "EMAIL", "EMAIL2", "MOBILE", "MOBILE2", "AGENCY_NAME") AS 
  SELECT
    agent_name,
    second_name,
    agency_id,
    customer_owner,
    record_type,
    language,
    property_type,
    status,
    email,
    email2,
    mobile,
    mobile2,
    agency_name
FROM
    xxsf_agents
