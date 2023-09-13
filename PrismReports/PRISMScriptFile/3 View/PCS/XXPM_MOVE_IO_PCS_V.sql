--------------------------------------------------------
--  DDL for View XXPM_MOVE_IO_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_MOVE_IO_PCS_V" (
    "MOVE_IO_ID",
    "FUNC_ID",
    "LEASE_AGREEMENT_ID",
    "BOOKING_ID",
    "MOVE_IO_NUMBER",
    "MOVE_IO_DATE",
    "USAGE",
    "RESOURCE_NAME",
    "IO_FLAG",
    "LOOKUP_VALUE_NAME_DISP as STATUS",
    "DESCRIPTION",
    "ORG_ID",
    "USER_GRP_ID",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN",
    "ORG_NAME",
    "BOOKING_NUMBER",
    "PROPERTY_NAME",
    "PROPERTY_NUMBER",
    "BUILD_NAME",
    "BUILD_NUMBER",
    "UNIT_NAME",
    "UNIT_NUMBER",
    "CUST_ID",
    "CUSTOMER_NAME"
) AS
    SELECT DISTINCT
        mi.move_io_id,
        mi.func_id,
        mi.lease_agreement_id,
        mi.booking_id,
        mi.move_io_number,
        trunc(mi.move_io_date),
        mi.usage,
        mi.resource_name,
        mi.io_flag,
        lv.lookup_value_name_disp AS status,
        mi.description,
        mi.org_id,
        mi.user_grp_id,
        mi.created_by,
        trunc(mi.creation_date),
        mi.last_updated_by,
        trunc(mi.last_update_date),
        mi.last_update_login,
        org.org_name,
        bh.booking_number,
        pm.property_name,
        pm.property_number,
        pb.build_name,
        pb.build_number,
        pu.unit_name,
        pu.unit_number,
        bc.cust_id,
        cus.customer_name
    FROM
        xxpm_move_in_out          mi,
        xxpm_booking_header       bh,
        xxpm_booking_detail       bd,
        xxpm_property_master      pm,
        xxpm_property_buildings   pb,
        xxpm_property_units       pu,
        xxstg_organizations       org,
        xxpm_booking_customer     bc,
        xxstg_customer            cus,
        xxfnd_lookup_v            lv
    WHERE
        mi.booking_id = bh.booking_hdr_id
        AND bh.booking_hdr_id = bd.booking_hdr_id
        AND bh.property_id = pm.property_id
        AND bd.building_id = pb.build_id
        AND bd.unit_id = pu.unit_id
        AND mi.org_id = org.org_id
        AND bh.booking_hdr_id = bc.booking_hdr_id
        AND bc.cust_id = cus.cust_id
        AND bc.primary_yn = 'Y'
        AND lv.lookup_type_name = 'BOOKING_STATUS'
        AND mi.status = lv.lookup_value_name