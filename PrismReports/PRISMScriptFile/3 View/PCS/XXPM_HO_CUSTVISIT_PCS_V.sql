--------------------------------------------------------
--  DDL for View XXPM_HO_CUSTVISIT_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_HO_CUSTVISIT_PCS_V" (
    "VISIT_ID",
    "MOVE_IO_ID",
    "VISITDATE",
    "ACCEPTEDCOMPLETION",
    "ASSISTEDBY",
    "CUSTOMERCOMMENTS"
) AS
    SELECT
        xmicv.visit_id,
        xmicv.move_io_id,
        trunc(xmicv.visit_date) visitdate,
        ylv.lookup_value_name_disp   AS acceptedcompletion,
        xem.employee_name            AS assistedby,
        xmicv.description            AS customercomments
    FROM
        xxpm_move_io_cust_visit   xmicv,
        xxstg_employee            xem,
        xxfnd_lookup_v            ylv
    WHERE
        xem.emp_id = xmicv.assisted_by
        AND ylv.lookup_type_name = 'YES_NO'
        AND ylv.lookup_value_name = xmicv.accept_flag