--------------------------------------------------------
--  DDL for View XXPM_AREA_CHANGE_HDR_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_AREA_CHANGE_HDR_PCS_V" ("AREA_CNG_HDR_ID", "FUNC_ID", "AREA_CNG_NUMBER", "AREA_CNG_DATE", "OBJECT_VERSION_NUMBER", "SURVEYED_BY", "SURVEYOR_ID", "SURVEY_DATE", "PROPERTY_ID  ", "STATUS       ", "DESCRIPTION  ", "ORG_ID       ", "ORG_NAME     ", "USER_GRP_ID  ", "FLOW_STATUS  ", "FLOW_LEVEL   ", "FLOW_WITH    ", "CREATED_BY   ", "CREATION_DATE", "LAST_UPDATED_BY ", "LAST_UPDATE_DATE ", "LAST_UPDATE_LOGIN ") AS 
  SELECT DISTINCT
        ach.area_cng_hdr_id,
        ach.func_id,
        ach.area_cng_number,
        trunc(ach.area_cng_date) AS area_cng_date,
        ach.object_version_number,
        ach.surveyed_by,
        ach.surveyor_id,
        trunc(ach.survey_date) AS survey_date,
        ach.property_id,
        ach.status,
        ach.description,
        ach.org_id,
        og.org_name,
        ach.user_grp_id,
        ach.flow_status,
        ach.flow_level,
        ach.flow_with,
        ach.created_by,
        trunc(ach.creation_date) AS creation_date,
        ach.last_updated_by,
        trunc(ach.last_update_date) AS last_update_date,
        ach.last_update_login
    FROM
        xxpm_area_change_hdr   ach,
        xxstg_organizations    og
    WHERE
        og.org_id = ach.org_id
