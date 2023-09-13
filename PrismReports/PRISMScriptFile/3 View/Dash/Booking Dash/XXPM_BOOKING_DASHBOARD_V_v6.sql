CREATE OR REPLACE VIEW "XXPM_BOOKING_DASHBOARD_V" ("BOOKING_HDR_ID", "ORG_ID", "FUNC_ID", "BOOKING_NUMBER", "BOOKING_DATE", "USAGE", "MS_HDR_ID", "PL_ID", "CURRENCY_CODE", "BOOKING_STATUS", "STATUS_DISP", "BOOKING_DTL_ID", "PROPERTY_ID", "BUILDING_ID", "UNIT_ID", "UOM", "BOOKING_RATE", "BOOKING_AMOUNT", "DISC_PCT", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "UNIT_NUMBER", "UNIT_SHORTCODE", "STATUS", "UNIT_CATEGORY", "BUILD_NAME", "BUILD_NUMBER", "PROPERTY_NAME", "PROPERTY_NUMBER", "BOOKING_CUST_ID", "CUST_ID", "SHIP_TO_SITE_ID", "BILL_TO_SITE_ID", "CUSTOMER_NUMBER", "CUSTOMER_NAME", "MILESTONE_NAME", "MILESTONE_NUMBER", "PL_NUMBER", "ORG_NAME", "ORG_NAME_TL", "INSTALLMENTAMOUNT", "INVOICED_AMOUNT", "UN_INVOICE", "RECEIPT_AMOUNT", "APPLIED_RECEIPT_AMOUNT", "BALANCE_AMT","OVER_DUE","DUE_7_COUNT") AS 
  WITH booking_hdr
     AS (SELECT bh.booking_hdr_id,
                bh.org_id,
                bh.func_id,
                bh.booking_number,
                bh.booking_date,
                bh.usage,
                bh.ms_hdr_id,
                bh.pl_id,
                bh.currency_code,
                bh.status AS booking_status,
                lk.lookup_value_name_disp AS status_disp,
                bd.booking_dtl_id,
                bd.property_id,
                bd.building_id,
                bd.unit_id,
                bd.uom,
                bd.booking_rate,
                bd.booking_amount,
                bd.disc_pct,
                bd.disc_amount,
                bd.tax_code,
                bd.tax_rate,
                bd.tax_amount,
                pu.unit_number,
                pu.unit_shortcode,
                pu.status,
                pu.unit_category,
                pb.build_name,
                pb.build_number,
                pm.property_name,
                pm.property_number,
                bc.booking_cust_id,
                bc.cust_id,
                bc.ship_to_site_id,
                bc.bill_to_site_id,
                cus.customer_number,
                cus.customer_name,
                mh.milestone_name,
                mh.milestone_number,
                plh.pl_number,
                org.org_name,
                org.org_name_tl
           FROM xxpm_booking_header bh,
                xxpm_booking_detail bd,
                xxpm_property_units pu,
                xxpm_property_buildings pb,
                xxpm_property_master pm,
                xxpm_booking_customer bc,
                xxstg_customer cus,
                xxstg_cust_sites cussite,
                xxstg_organizations org,
                xxpm_milestone_hdr mh,
                xxpm_pl_header plh,
                xxfnd_lookup_v lk
          WHERE     bh.booking_hdr_id = bd.booking_hdr_id
                AND pu.unit_id = bd.unit_id
                AND pu.property_id = bd.property_id
                AND pu.build_id = bd.building_id
                AND pb.build_id = bd.building_id
                AND pb.property_id = bd.property_id
                AND pm.property_id = bd.property_id
                AND bd.booking_hdr_id = bd.booking_hdr_id + 0
                AND bd.property_id = bd.property_id + 0
                AND bd.building_id = bd.building_id + 0
                AND bd.unit_id = bd.unit_id + 0
                AND pm.property_id = pm.property_id + 0
                AND bc.booking_hdr_id = bh.booking_hdr_id
                AND bh.booking_hdr_id = bh.booking_hdr_id + 0
                AND bc.primary_yn = 'Y'
                AND cus.cust_id = bc.cust_id
                AND cussite.cust_id = bc.cust_id
                AND cussite.org_id = bh.org_id
                AND org.org_id = bh.org_id
                AND mh.ms_hdr_id = bh.ms_hdr_id
                AND plh.pl_id = bh.pl_id
                AND lk.lookup_type_name = 'BOOKING_STATUS'
                AND lk.lookup_value_name = bh.status --and bh.BOOKING_HDR_ID=196
                                                    ),
     booking_line
     AS (  SELECT ih.booking_id,
                  SUM (NVL (il.amount, 0) + NVL (il.tax_amount, 0))
                     invoiced_amount
             FROM xxpm_invoice_header ih, xxpm_invoice_lines il
            WHERE     il.invoice_id = ih.invoice_id
                  -- AND ih.invoice_id = ih.invoice_id + 0
                  AND ih.booking_id = ih.booking_id + 0
                  AND il.invoice_id = il.invoice_id + 0
         --and ih.booking_id=196
         GROUP BY ih.booking_id),
     not_inv_amt
     AS (  SELECT booking_hdr_id,
                  ROUND (SUM (installment_amount), 2) AS un_invoice
             FROM xxpm_booking_milestones
            WHERE     invoice_id IS NULL
                  AND booking_ms_dtl_id = booking_ms_dtl_id + 0 --AND booking_hdr_id = booking_hdr_id + 0
         --and booking_hdr_id=196
         GROUP BY booking_hdr_id),
     booking_colleted_amt
     AS (  SELECT inv_hdr.booking_id,
                  SUM (rd.amount_applied) AS receipt_amount,
                  SUM (rd.amount_applied) AS applied_receipt_amount
             FROM xxpm_invoice_header inv_hdr,
                  xxpm_receipt_details rd,
                  xxpm_receipt r
            WHERE     inv_hdr.invoice_id = rd.invoice_id
                  AND inv_hdr.invoice_id = inv_hdr.invoice_id + 0
                  AND r.receipt_id = rd.receipt_id
                  AND rd.receipt_id = rd.receipt_id + 0
                  AND rd.invoice_id = rd.invoice_id + 0
                  AND r.receipt_id = r.receipt_id + 0
         GROUP BY inv_hdr.booking_id)
SELECT bhr.booking_hdr_id,
       bhr.org_id,
       bhr.func_id,
       bhr.booking_number,
       bhr.booking_date,
       bhr.usage,
       bhr.ms_hdr_id,
       bhr.pl_id,
       bhr.currency_code,
       bhr.booking_status,
       bhr.status_disp,
       bhr.booking_dtl_id,
       bhr.property_id,
       bhr.building_id,
       bhr.unit_id,
       bhr.uom,
       bhr.booking_rate,
       bhr.booking_amount,
       bhr.disc_pct,
       bhr.disc_amount,
       bhr.tax_code,
       bhr.tax_rate,
       bhr.tax_amount,
       bhr.unit_number,
       bhr.unit_shortcode,
       bhr.status,
       bhr.unit_category,
       bhr.build_name,
       bhr.build_number,
       bhr.property_name,
       bhr.property_number,
       bhr.booking_cust_id,
       bhr.cust_id,
       bhr.ship_to_site_id,
       bhr.bill_to_site_id,
       bhr.customer_number,
       bhr.customer_name,
       bhr.milestone_name,
       bhr.milestone_number,
       bhr.pl_number,
       bhr.org_name,
       bhr.org_name_tl,
         NVL (bhr.booking_amount, 0)
       - NVL (bhr.disc_amount, 0)
       + NVL (bhr.tax_amount, 0)
          AS installmentamount,
       bkl.invoiced_amount,
       bmsuniv.un_invoice,
       receamt.receipt_amount,
       receamt.applied_receipt_amount,
         NVL (receamt.receipt_amount, 0)
       - NVL (receamt.applied_receipt_amount, 0)
          balance_amt,
          GET_DUE_BASED_COUNT('OVER_DUE',bhr.booking_hdr_id) as OVER_DUE,
          GET_DUE_BASED_COUNT('7_DAYS',bhr.booking_hdr_id) AS DUE_7_COUNT
  --count(*)
  FROM booking_hdr bhr,
       booking_line bkl,
       not_inv_amt bmsuniv,
       booking_colleted_amt receamt
 WHERE     bhr.booking_hdr_id = bkl.booking_id
       AND bhr.booking_hdr_id = bmsuniv.booking_hdr_id(+)
       AND receamt.booking_id = bhr.booking_hdr_id(+);
