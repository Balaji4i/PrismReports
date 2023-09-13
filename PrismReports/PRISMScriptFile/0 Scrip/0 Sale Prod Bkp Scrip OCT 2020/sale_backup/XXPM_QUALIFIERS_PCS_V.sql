--------------------------------------------------------
--  DDL for View XXPM_QUALIFIERS_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_QUALIFIERS_PCS_V" ("MOD_CATEGORY", "PL_ID", "PL_QLFY_ID", "PL_MOD_ID", "START_DATE", "END_DATE", "QUALIFIERS", "OPERATOR", "QUALIFIER_FROM", "QUALIFIER_TO") AS 
  SELECT DISTINCT
        pmod.mod_category,
        plm.pl_id,
        plq.pl_qlfy_id,
        plq.pl_mod_id,
        trunc(plq.start_date),
        trunc(plq.end_date),
        pqfy.qualifiers,
        pqfy.operator,
        CASE pqfy.qualifiers
            WHEN 'UIT'   THEN
                (
                    SELECT
                        unit_name
                    FROM
                        xxpm_property_units
                    WHERE
                        unit_number = pqfy.qualifier_from
                )
            WHEN 'PTY'   THEN
                (
                    SELECT
                        property_name
                    FROM
                        xxpm_property_master
                    WHERE
                        property_number = pqfy.qualifier_from
                )
            WHEN 'BDG'   THEN
                (
                    SELECT
                        build_name
                    FROM
                        xxpm_property_buildings
                    WHERE
                        build_number = pqfy.qualifier_from
                )
            WHEN 'VTY'   THEN
                (
                    SELECT
                        view_type
                    FROM
                        xxpm_property_units
                    WHERE
                        view_type = pqfy.qualifier_from
                )
            WHEN 'FLR'   THEN
                (
                    SELECT
                        TO_CHAR(no_of_rooms)
                    FROM
                        xxpm_property_units
                    WHERE
                        TO_CHAR(no_of_rooms) = TO_CHAR(pqfy.qualifier_from)
                )
            WHEN 'UTY'   THEN
                (
                    SELECT
                        unit_type
                    FROM
                        xxpm_property_units
                    WHERE
                        unit_type = pqfy.qualifier_from
                        AND ROWNUM = 1
                )
            ELSE
                NULL
        END qualifier_from,
        CASE pqfy.qualifiers
            WHEN 'UIT'   THEN
                (
                    SELECT
                        unit_name
                    FROM
                        xxpm_property_units
                    WHERE
                        unit_number = pqfy.qualifier_to
                )
            WHEN 'PTY'   THEN
                (
                    SELECT
                        property_name
                    FROM
                        xxpm_property_master
                    WHERE
                        property_number = pqfy.qualifier_to
                )
            WHEN 'BDG'   THEN
                (
                    SELECT
                        build_name
                    FROM
                        xxpm_property_buildings
                    WHERE
                        build_number = pqfy.qualifier_to
                )
            WHEN 'VTY'   THEN
                (
                    SELECT
                        view_type
                    FROM
                        xxpm_property_units
                    WHERE
                        view_type = pqfy.qualifier_to
                )
            WHEN 'FLR'   THEN
                (
                    SELECT
                        TO_CHAR(no_of_rooms)
                    FROM
                        xxpm_property_units
                    WHERE
                        TO_CHAR(no_of_rooms) = TO_CHAR(pqfy.qualifier_to)
                )
            WHEN 'UTY'   THEN
                (
                    SELECT
                        unit_type
                    FROM
                        xxpm_property_units
                    WHERE
                        unit_type = pqfy.qualifier_to
                )
            ELSE
                NULL
        END qualifier_to
    FROM
        xxpm_pl_qualifiers   plq,
        xxpm_pl_modifiers    plm,
        xxpm_qualifiers      pqfy,
        xxpm_modifiers       pmod
    WHERE
        plq.qlfy_id = pqfy.qlfy_id
        AND plq.pl_mod_id = plm.pl_mod_id
        AND pmod.mod_id = plm.mod_id
    ORDER BY
        plq.pl_qlfy_id DESC
