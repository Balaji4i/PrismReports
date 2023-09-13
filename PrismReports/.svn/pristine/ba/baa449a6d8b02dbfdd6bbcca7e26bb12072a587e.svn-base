--------------------------------------------------------
--  DDL for View XXFND_APPR_USERS_V
--------------------------------------------------------

CREATE OR REPLACE VIEW "XXFND_APPR_USERS_V" (
    "ROW_ID",
    "APPR_USER_ID",
    "USER_LEVEL_ID",
    "SEQ_NUMBER",
    "USER_ID",
    "USER_NAME",
    "APPR_ROLE",
    "APPR_ROLE_DESC",
    "APPR_TYPE",
    "APPR_TYPE_DESC",
    "APPR_BY",
    "APPR_BY_DESC",
    "EMP_ID",
    "EMP_NAME",
    "APPR_LIMIT",
    "ACTIVE_YN",
    "CREATED_BY",
    "CREATION_DATE",
    "LAST_UPDATED_BY",
    "LAST_UPDATE_DATE",
    "LAST_UPDATE_LOGIN"
) AS
    SELECT
        u.rowid,
        u.appr_user_id,
        u.user_level_id,
        u.seq_number,
        u.user_id,
        um.user_name,
        u.appr_role,
        u.appr_role_desc,
        u.appr_type,
        l.lookup_value_name_disp,
        u.appr_by,
        xxfnd_util_pkg.get_appr_by_name(u.appr_type, u.appr_by),
        u.emp_id,
        emp.employee_name,
        u.appr_limit,
        u.active_yn,
        u.created_by,
        u.creation_date,
        u.last_updated_by,
        u.last_update_date,
        u.last_update_login
    FROM
        xxfnd_appr_users   u,
        xxfnd_lookup_v     l,
        xxfnd_user         um,
        xxstg_employee     emp
    WHERE
        l.lookup_type_name (+) = 'APPROVER_TYPE'
        AND l.lookup_value_name (+) = u.appr_type
        AND um.user_id (+) = u.user_id
        AND emp.emp_id (+) = u.emp_id;
/