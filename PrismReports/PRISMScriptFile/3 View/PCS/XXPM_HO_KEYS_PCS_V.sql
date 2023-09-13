--------------------------------------------------------
--  DDL for View XXPM_HO_KEYS_PCS_V
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE VIEW "XXPM_HO_KEYS_PCS_V" (
    "KEY_ID",
    "MOVE_IO_ID",
    "KEYNAME",
    "NOOFKEYS",
    "STATUS"
) AS
    SELECT
        xmik.key_id,
        xmik.move_io_id,
        xlv.lookup_value_name_disp   AS keyname,
        xmik.key_qty                 AS noofkeys,
        ylv.lookup_value_name_disp   AS status
    FROM
        xxpm_move_io_keys   xmik,
        xxfnd_lookup_v      xlv,
        xxfnd_lookup_v      ylv
    WHERE
        xlv.lookup_type_name = 'HANDOVER_KEYS'
        AND xlv.lookup_value_name = xmik.key_code
        AND ylv.lookup_type_name = 'YES_NO'
        AND ylv.lookup_value_name = xmik.status