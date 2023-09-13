--------------------------------------------------------
--  DDL for Function GET_DUE_BASED_COUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_DUE_BASED_COUNT" (
    P_DUE IN VARCHAR2,
    P_BOOK_ID NUMBER)
  RETURN NUMBER
IS
  BK_COUNT NUMBER;
BEGIN
  IF(P_DUE = 'OVER_DUE') THEN
    SELECT COUNT(*)
    INTO BK_COUNT
    FROM XXPM_BOOKING_MILESTONES
    WHERE TO_CHAR(DUE_DATE, 'dd-MON-yyyy') <= sysdate
    AND INVOICE_ID                        IS NULL
    AND BOOKING_HDR_ID                     = P_BOOK_ID;
  ELSE
    IF(P_DUE = '7_DAYS') THEN
      SELECT COUNT(*)
      INTO BK_COUNT
      FROM XXPM_BOOKING_MILESTONES
      WHERE TO_CHAR(DUE_DATE, 'dd-MON-yyyy') > sysdate
      AND TO_CHAR(DUE_DATE, 'dd-MON-yyyy')  <= sysdate + 7
      AND INVOICE_ID                       IS NULL
      AND BOOKING_HDR_ID                    = P_BOOK_ID;
    ELSE
      IF(P_DUE = 'ALL_OVER_DUE') THEN
        SELECT COUNT(*)
        INTO BK_COUNT
        FROM XXPM_BOOKING_MILESTONES
        WHERE TO_CHAR(DUE_DATE, 'dd-MON-yyyy') <= sysdate
        AND INVOICE_ID                        IS NULL;
      ELSE
        IF(P_DUE = 'ALL_7_DAYS') THEN
          SELECT COUNT(*)
          INTO BK_COUNT
          FROM XXPM_BOOKING_MILESTONES
          WHERE TO_CHAR(DUE_DATE, 'dd-MON-yyyy') > sysdate
          AND TO_CHAR(DUE_DATE, 'dd-MON-yyyy')  <= sysdate + 7
          AND INVOICE_ID                       IS NULL;
        ELSE
          BK_COUNT := 0;
        END IF;
      END IF;
    END IF;
  END IF;
RETURN BK_COUNT;
END GET_DUE_BASED_COUNT;
