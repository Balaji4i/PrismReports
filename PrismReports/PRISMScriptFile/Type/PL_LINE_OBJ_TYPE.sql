--------------------------------------------------------
--  DDL for Type PL_LINE_OBJ_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "PL_LINE_OBJ_TYPE" force AS OBJECT (	
PLL_ID	NUMBER,
PL_NUMBER	VARCHAR2(60),
PROPERTY_NUMBER	VARCHAR2(60),
BUILD_NUMBER	VARCHAR2(60),
UNIT_NUMBER	VARCHAR2(260),
UOM	VARCHAR2(5),
BASE_PRICE	NUMBER,
MIN_PRICE	NUMBER,
START_DATE	VARCHAR2(200),
END_DATE	VARCHAR2(200),
ACTIVE_YN	VARCHAR2(1),
CONSTRUCTOR FUNCTION PL_LINE_OBJ_TYPE RETURN SELF AS RESULT);
