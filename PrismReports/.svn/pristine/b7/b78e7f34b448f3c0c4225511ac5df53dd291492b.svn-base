--------------------------------------------------------
--  DDL for View XXPM_QUALIFIERS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_QUALIFIERS_V" ("ROW_ID", "QLFY_ID", "QUALIFIERS", "QUALIFIERS_DESC", "OPERATOR", "OPERATOR_DESC", "QUALIFIER_FROM", "QUALIFIER_TO", "START_DATE", "END_DATE", "DESCRIPTION", "ACTIVE_YN", "REVISION_NO", "REVISION_DATE", "REVISED_BY", "CREATED_BY", "CREATION_DATE", "LAST_UPDATED_BY", "LAST_UPDATE_DATE", "LAST_UPDATE_LOGIN") AS 
  SELECT
        q.rowid,
        q.qlfy_id,
        q.qualifiers,
        l1.lookup_value_name_disp,
        q.operator,
        l2.lookup_value_name_disp,
        q.qualifier_from,
        q.qualifier_to,
        q.start_date,
        q.end_date,
        q.description,
        q.active_yn,
        q.revision_no,
        q.revision_date,
        q.revised_by,

--       e.employee_number,

--       e.employee_name,
        q.created_by,
        q.creation_date,
        q.last_updated_by,
        q.last_update_date,
        q.last_update_login
    FROM
        xxpm_qualifiers   q,
        xxfnd_lookup_v    l1,
        xxfnd_lookup_v    l2 -- xxstg_employee e
    WHERE
        l1.lookup_type_name (+) = 'QUALIFIERS'
        AND l1.lookup_value_name (+) = q.qualifiers
        AND l2.lookup_type_name (+) = 'OPERATOR'

--and    q.revised_by(+)          = e.emp_id
        AND l2.lookup_value_name (+) = q.operator
