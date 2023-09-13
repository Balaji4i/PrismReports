--------------------------------------------------------
--  DDL for View XXPM_BLOCKING_DETAILS_PCS_V_2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "XXPM_BLOCKING_DETAILS_PCS_V_2" ("BLOCK_DTL_ID", "BLOCK_ID", "PROPERTY_ID", "PROPERTY_NAME", "PROPERTY_NAME_TL", "BUILD_ID", "BUILD_NAME", "BUILD_NUMBER", "UNIT_ID", "UNIT_NAME", "UNIT_NUMBER", "UNIT_TYPE", "AREASQ", "UOM", "QUANTITY", "BASE_RATE", "OFFER_AMOUNT", "DISC_PCT", "DISC_AMOUNT", "TAX_CODE", "TAX_RATE", "TAX_AMOUNT", "MOD_NAME", "UNIT_CATEGORY", "CATEGORY_NAME", "unit_type_name", "UOM_NAME") AS select xBD.BLOCK_DTL_ID, 
xBD.BLOCK_ID, 
xBD.PROPERTY_ID, 
xPM.PROPERTY_NAME, 
xPM.PROPERTY_NAME_TL,
xBD.BUILD_ID, 
xPB.BUILD_NAME, 
xPB.BUILD_NUMBER,
xBD.UNIT_ID,
xPU.UNIT_NAME, 
xPU.UNIT_NUMBER,
xPU.UNIT_TYPE,
xPA.VALUE AS AreaSq,
xPU.UOM,
xOD.QUANTITY, 
xOD.BASE_RATE, 
NVL(xOD.OFFER_AMOUNT,0) OFFER_AMOUNT,
xOD.DISC_PCT, 
NVL(xOD.DISC_AMOUNT,0) DISC_AMOUNT, 
xOD.TAX_CODE, 
NVL(xOD.TAX_RATE,0) TAX_RATE, 
NVL(xOD.TAX_AMOUNT,0) as TAX_AMOUNT ,
xm.MOD_NAME,
xpu.unit_category ,
xlv.LOOKUP_VALUE_NAME_DISP as category_nam,
(select xlv.LOOKUP_VALUE_NAME_DISP FROM xxfnd_lookup_v xlv where xlv.LOOKUP_VALUE_NAME = xPU.UNIT_TYPE and rownum=1) as unit_type_name
,(select xlv.LOOKUP_VALUE_NAME_DISP FROM xxfnd_lookup_v xlv where xlv.LOOKUP_VALUE_NAME = xPU.UOM and rownum=1) as UOM_NAME
from XXPM_BLOCK_DETAIL  xbd
,XXPM_PROPERTY_MASTER xPM
,XXPM_PROPERTY_BUILDINGS xPB
,XXPM_PROPERTY_UNITS xPU
,XXPM_PROPERTY_AREA xPA
,XXPM_BLOCK_HEADER xbh
,XXPM_OFFER_DETAIL xOD
,xxpm_pl_modifiers xpm
,xxpm_modifiers xm
,xxfnd_lookup_v xlv

where 
 xbd.PROPERTY_ID =xPM.PROPERTY_ID
 and xbd.build_id =xpb.build_id
 and xbd.UNIT_ID  =xpu.unit_id
 and xPB.PROPERTY_ID =xpm.PROPERTY_ID
 and xPB.BUILD_ID =xPU.BUILD_ID
 and xpa.unit_id = xpu.unit_id
and xpa.build_id =xpb.build_id
 and xpa.PROPERTY_ID =xpm.PROPERTY_ID
 and xbd.BLOCK_ID =xbh.block_id
 and xOD.OFFER_HDR_ID(+) =xbh.OFFER_HDR_ID
and xod.pl_mod_id =xpm.pl_mod_id(+)
and xpm.mod_id =xm.mod_id(+)
and xlv.LOOKUP_VALUE_NAME = xpu.unit_category
and xlv.LOOKUP_TYPE_NAME = 'UNIT_CATEGORY'
