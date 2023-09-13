--------------------------------------------------------
--  DDL for View XXPM_PRICELIST_HEADER_PCS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_PRICELIST_HEADER_PCS_V" ("PL_ID", "PL_NAME", "DESCRIPTION", "ORG_ID", "ORG_NAME", "FUNC_ID", "PL_TYPE_CODE", "PL_TYPE_NAME", "USAGE", "CURRENCY_CODE", "CURRENCY_NAME", "START_DATE", "END_DATE", "REVISION_NO", "PRIORITY") AS 
  SELECT DISTINCT
        pl_id,
        pl_name,
        description,
        plh.org_id,
        org.org_name,
        func_id,
        plh.pl_type,
        lp2.lookup_value_name_disp,
        usage,
        plh.currency_code,
        lp1.lookup_value_name_disp,
        trunc(start_date),
        trunc(end_date),
        revision_no,
        priority
    FROM
        xxpm_pl_header        plh,
        xxstg_organizations   org,
        xxfnd_lookup_v        lp1,
        xxfnd_lookup_v        lp2
    WHERE
        plh.org_id = org.org_id
        AND lp1.lookup_type_name = 'CURRENCY'
        AND lp1.lookup_value_name = plh.currency_code
        AND lp2.lookup_type_name = 'PRICE_LIST_TYP'
        AND lp2.lookup_value_name = plh.pl_type
    ORDER BY
        plh.pl_id DESC
