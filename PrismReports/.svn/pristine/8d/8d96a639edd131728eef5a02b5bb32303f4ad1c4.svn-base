--------------------------------------------------------
--  DDL for Package Body XXPACA_HRMS_REPORT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPACA_HRMS_REPORT_PKG" 
AS
/*FUNCTION get_arabic_position(
    p_person_id NUMBER,
    p_date      DATE DEFAULT TRUNC(
      SYSDATE) )
  RETURN VARCHAR2
IS
  CURSOR C1
  IS
    SELECT REGEXP_SUBSTR (hapf.NAME, '[^.]+', 1, 1) AS position_name
    FROM per_all_assignments_f paaf,
      hr_all_positions_f_tl hapf
    WHERE paaf.person_id = p_person_id
    AND hapf.position_id = paaf.position_id
    AND p_date BETWEEN paaf.effective_start_date AND paaf.effective_end_date
    AND hapf.language        = 'AR'
    AND paaf.primary_flag    = 'Y'
    AND paaf.assignment_type = 'E';
  V_Positions C1%ROWTYPE;
BEGIN
  OPEN C1;
  FETCH C1 INTO V_Positions;
  CLOSE C1;
  RETURN V_Positions.position_name;
EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
END;
FUNCTION get_arabic_department(
    p_person_id NUMBER,
    p_date      DATE DEFAULT TRUNC(
      SYSDATE) )
  RETURN VARCHAR2
IS
  CURSOR C2
  IS
    SELECT haout.name AS department_name
    FROM per_all_assignments_f paaf,
      hr_all_organization_units_tl haout
    WHERE paaf.person_id     = p_person_id
    AND paaf.organization_id = haout.organization_id
    AND p_date BETWEEN paaf.effective_start_date AND paaf.effective_end_date
    AND haout.language       = 'AR'
    AND paaf.assignment_type = 'E'
    AND paaf.primary_flag    = 'Y';
  V_Department C2%ROWTYPE;
BEGIN
  OPEN C2;
  FETCH C2 INTO V_Department;
  CLOSE C2;
  RETURN V_Department.department_name;
EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
END;
FUNCTION get_arabic_name(
    p_person_id NUMBER,
    p_date      DATE DEFAULT TRUNC(
      SYSDATE) )
  RETURN VARCHAR2
IS
  CURSOR C3
  IS
    SELECT DECODE ( papf.sex, 'M', papf.attribute3
      || ' '
      ||
      (SELECT Meaning
      FROM Fnd_Lookup_Values
      WHERE Lookup_Type = 'XXPACA_LETTER_ARABIC_WORDS'
      AND Lookup_Code   = 'BIN'
      AND Enabled_Flag  = 'Y'
      AND language      = 'US'
      )
    || ' '
    || papf.attribute4
    || ' '
    ||
    (SELECT Meaning
    FROM Fnd_Lookup_Values
    WHERE Lookup_Type = 'XXPACA_LETTER_ARABIC_WORDS'
    AND Lookup_Code   = 'BIN'
    AND Enabled_Flag  = 'Y'
    AND language      = 'US'
    )
    || ' '
    || papf.attribute5
    || ' '
    ||
    (SELECT Meaning
    FROM Fnd_Lookup_Values
    WHERE Lookup_Type = 'XXPACA_LETTER_ARABIC_WORDS'
    AND Lookup_Code   = 'BIN'
    AND Enabled_Flag  = 'Y'
    AND language      = 'US'
    )
    || ' '
    || papf.attribute6, 'F', papf.attribute3
    || ' '
    ||
    (SELECT Meaning
    FROM Fnd_Lookup_Values
    WHERE Lookup_Type = 'XXPACA_LETTER_ARABIC_WORDS'
    AND Lookup_Code   = 'BIN'
    AND Enabled_Flag  = 'Y'
    AND language      = 'US'
    )
    || ' '
    || papf.attribute4
    || ' '
    ||
    (SELECT Meaning
    FROM Fnd_Lookup_Values
    WHERE Lookup_Type = 'XXPACA_LETTER_ARABIC_WORDS'
    AND Lookup_Code   = 'BIN'
    AND Enabled_Flag  = 'Y'
    AND language      = 'US'
    )
    || ' '
    || papf.attribute5
    || ' '
    ||
    (SELECT Meaning
    FROM Fnd_Lookup_Values
    WHERE Lookup_Type = 'XXPACA_LETTER_ARABIC_WORDS'
    AND Lookup_Code   = 'BIN'
    AND Enabled_Flag  = 'Y'
    AND language      = 'US'
    )
    || ' '
    || papf.attribute6 ) employee_name
    FROM per_all_people_f papf
    WHERE papf.person_id = p_person_id
    AND p_date BETWEEN papf.effective_start_date AND papf.effective_end_date
    AND papf.current_employee_flag = 'Y';
    V_Employees C3%ROWTYPE;
  BEGIN
    OPEN C3;
    FETCH C3 INTO V_Employees;
    CLOSE C3;
    RETURN V_Employees.employee_name;
  EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
  END;
FUNCTION get_arabic_date(
    p_date DATE DEFAULT TRUNC(
      SYSDATE) )
  RETURN VARCHAR2
AS
  v_return VARCHAR2 (240);
BEGIN
  SELECT TO_CHAR (p_date, 'day dd month yyyy', 'nls_calendar=''Arabic Hijrah''') sysdate_arabic
  INTO v_return
  FROM DUAL;
  RETURN v_return;
EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
END;
FUNCTION Get_Arabic_Nationality(
    P_Person_Id NUMBER,
    P_Date      DATE DEFAULT TRUNC(
      Sysdate) )
  RETURN VARCHAR2
IS
  CURSOR C4
  IS
    SELECT Flv.Meaning AS Nationality
    FROM Per_All_People_F Papf,
      Fnd_Lookup_Values Flv
    WHERE Papf.Person_Id =P_Person_Id
    AND Papf.Nationality = Flv.Lookup_Code
    AND P_Date BETWEEN Papf.Effective_Start_Date AND Papf.Effective_End_Date
    AND Flv.Language               ='AR'
    AND Papf.Current_Employee_Flag = 'Y'
    AND Flv.Enabled_Flag           ='Y';
  V_Nationality C4%Rowtype;
BEGIN
  OPEN C4;
  FETCH C4 INTO V_Nationality;
  CLOSE C4;
  RETURN V_Nationality.Nationality;
EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
END;
FUNCTION get_amt_in_words(
    l_amt IN NUMBER,
    l_ccode VARCHAR2)
  RETURN VARCHAR2
IS
  words    VARCHAR2 (1000);
  whole    VARCHAR2 (500) := NULL;
  frac     VARCHAR2 (500) := NULL;
  suffix1  VARCHAR2 (20);
  suffix2  VARCHAR2 (20);
  currency NUMBER (20, 3);
  code     VARCHAR2 (200);
  c2       NUMBER;
  i        NUMBER;
  p        NUMBER;
  flen     NUMBER;
  text     VARCHAR2 (30);
  tl       NUMBER;
  tl1      NUMBER;
BEGIN
  IF l_ccode IN ('BHD', 'KWD', 'OMR') THEN
    text := TO_CHAR (l_amt, '99999999.999');
    tl1  := 1000;
  ELSE
    text := TO_CHAR (l_amt, '99999999.99');
    tl1  := 100;
  END IF;
  tl       := LENGTH (text);
  p        := instr (text, '.', 1, 1);
  tl       := LENGTH (SUBSTR (text, p + 1, tl));
  currency := TRUNC (l_amt);
  c2       := l_amt - currency;
  c2       := c2    * tl1;
  code     := upper (l_ccode);
  BEGIN
    SELECT DECODE (l_ccode, 'USD', 'cents', 'GBP', 'pences', 'SAR', 'halalat', 'QAR', 'dirhams', 'AED', 'fils', 'DEM', 'pfennigs', 'EURO', 'euro cents', 'INR', 'paise', 'FRF', 'centimes', 'BHD', 'fils', 'KWD', 'fils', 'OMR', 'Bzs')
    INTO suffix2
    FROM dual;
  EXCEPTION
  WHEN OTHERS THEN
    raise;
  END;
  BEGIN
    SELECT DECODE (l_ccode, 'USD', ' US Dollars', 'BHD', ' Bahraini Dinars', 'GBP', ' Pounds', 'KWD', ' Kuwaiti Dinars', 'SAR', ' Saudi Riyals', 'QAR', ' Qatari Riyals', 'AED', ' UAE Dirhams', 'DEM', ' German Marks', 'EURO', ' Euros', 'INR', ' Indian Rupees', 'FRF', ' French Franks', 'OMR', ' Omani Rials', 'IRR', ' Iran Rials')
    INTO suffix1
    FROM dual;
  EXCEPTION
  WHEN OTHERS THEN
    raise;
  END;
  IF (currency + c2 = 0) THEN
    words          := 'Zero ' || ' and Zero ' || initcap (suffix2) || ' ' || 'Only';
  ELSE
    words := ap_amount_utilities_pkg.ap_convert_number (currency) || ',' || ap_amount_utilities_pkg.ap_convert_number (c2);
    p     := instr (words, ',', 1, 1);
    whole := whole || SUBSTR (words, 1, p - 1);
    frac  := frac || SUBSTR (words, p     + 1, LENGTH (words));
    words := initcap (REPLACE (whole, '-', ' ')) || ' and ' || initcap (frac) || ' ' || initcap (suffix2) || ' ' || 'Only';
  END IF;
  RETURN words;
EXCEPTION
WHEN OTHERS THEN
  words := 'UNKNOWN CURRENCY';
  RETURN words;
END;*/
PROCEDURE get_ar_disp_digits(
    numv    IN NUMBER,
    gndr    IN NUMBER,
    grmr    IN NUMBER,
    str_out IN OUT VARCHAR2)
IS
BEGIN
  SELECT DECODE (numv, 0, '', 1, '????', 2, '?????', 3, '????', 4, '????', 5, '???', 6, '??', 7, '???', 8, '????', 9, '???', 'Err-Dgts')
  INTO str_out
  FROM Sys.Dual;
END Get_Ar_Disp_Digits;
PROCEDURE get_ar_disp_tens(
    num     IN NUMBER,
    gndr    IN NUMBER,
    grmr    IN NUMBER,
    str_out IN OUT VARCHAR2)
IS
  str_digit VARCHAR2 (20);
  str_ten   VARCHAR2 (20);
  tens      NUMBER;
  digits    NUMBER;
BEGIN
  str_out := ' ';
  tens    := FLOOR (num / 10);
  digits  := MOD (num, 10);
  SELECT DECODE (tens, 0, '', 1, '???? ', 2, '????? ', 3, '?????? ', 4, '?????? ', 5, '????? ', 6, '???? ', 7, '????? ', 8, '?????? ', 9, '????? ', 'Err-Tens')
  INTO str_ten
  FROM sys.DUAL;
  str_digit := '';
  get_ar_disp_digits (digits, gndr, grmr, str_digit);
  IF (tens   > 1 AND digits > 0) THEN
    str_out := ' ? ';
  END IF;
  IF (num      = 11) THEN
    str_digit := '???? ';
  ELSIF (num   = 12) THEN
    str_digit := '????? ';
  END IF;
  str_out := str_digit || str_out || str_ten;
END get_ar_disp_tens;
PROCEDURE get_ar_disp_hundreds(
    num     IN NUMBER,
    gndr    IN NUMBER,
    grmr    IN NUMBER,
    str_out IN OUT VARCHAR2)
IS
  str_subval VARCHAR2 (100);
  str_lvlval VARCHAR2 (100);
  lvlval     NUMBER;
  subval     NUMBER;
  flg1       BOOLEAN := FALSE;
BEGIN
  str_out   := '';
  subval    := num;
  IF subval >= 100 THEN
    lvlval  := FLOOR (subval / 100);
    subval  := MOD (subval, 100);
    SELECT DECODE (lvlval, 1, '????', 2, '?????', 3, '????????', 4, '????????', 5, '???????', 6, '??????', 7, '???????', 8, '????????', 9, '???????', 'Err-hnds')
    INTO str_lvlval
    FROM sys.DUAL;
    str_out := str_out || str_lvlval;
    flg1    := TRUE;
  END IF;
  IF subval > 0 THEN
    IF (flg1) THEN
      str_out := str_out || ' ? ';
    END IF;
    get_ar_disp_tens (subval, gndr, grmr, str_subval);
    str_out := str_out || str_subval;
  END IF;
END get_ar_disp_hundreds;
PROCEDURE get_arabic_disp_numbers(
    num     IN NUMBER,
    gndr    IN NUMBER,
    grmr    IN NUMBER,
    str_out IN OUT VARCHAR2)
IS
  str_subval VARCHAR2 (100);
  str_lvlval VARCHAR2 (100);
  lvlval     NUMBER;
  subval     NUMBER;
  flg1       BOOLEAN := FALSE;
BEGIN
  str_out   := '';
  subval    := num;
  IF subval >= 1000000000 THEN
    lvlval  := FLOOR (subval / 1000000000);
    subval  := MOD (subval, 1000000000);
    get_ar_disp_hundreds (lvlval, gndr, grmr, str_lvlval);
    IF (lvlval    = 1) THEN
      str_out    := ' ????? ';
    ELSIF (lvlval = 2) THEN
      str_out    := ' ??????? ';
    ELSIF (lvlval < 10) THEN
      str_out    := str_lvlval || ' ??????? ';
    ELSE
      str_out := str_lvlval || ' ????? ';
    END IF;
    flg1 := TRUE;
  END IF;
  IF subval             >= 1000000 THEN
    lvlval              := FLOOR (subval / 1000000);
    subval              := MOD (subval, 1000000);
    IF (flg1 AND lvlval != 0) THEN
      str_out           := str_out || '? ';
    END IF;
    get_ar_disp_hundreds (lvlval, gndr, grmr, str_lvlval);
    IF (lvlval    = 1) THEN
      str_out    := str_out || ' ????? ';
    ELSIF (lvlval = 2) THEN
      str_out    := str_out || ' ??????? ';
    ELSIF (lvlval < 10) THEN
      str_out    := str_out || str_lvlval || ' ?????? ';
    ELSE
      str_out := str_out || str_lvlval || ' ????? ';
    END IF;
    flg1 := TRUE;
  END IF;
  IF subval             >= 1000 THEN
    lvlval              := FLOOR (subval / 1000);
    subval              := MOD (subval, 1000);
    IF (flg1 AND lvlval != 0) THEN
      str_out           := str_out || '? ';
    END IF;
    get_ar_disp_hundreds (lvlval, gndr, grmr, str_lvlval);
    IF (lvlval    = 1) THEN
      str_out    := str_out || ' ??? ';
    ELSIF (lvlval = 2) THEN
      str_out    := str_out || ' ????? ';
    ELSIF (lvlval < 10) THEN
      str_out    := str_out || str_lvlval || ' ???? ';
    ELSE
      str_out := str_out || str_lvlval || ' ??? ';
    END IF;
    flg1 := TRUE;
  END IF;
  lvlval              := subval;
  IF (flg1 AND lvlval != 0) THEN
    str_out           := str_out || '? ';
  END IF;
  get_ar_disp_hundreds (lvlval, gndr, grmr, str_lvlval);
  str_out   := str_out || str_lvlval;
  IF (num    = 0) THEN
    str_out := '???';
  END IF;
EXCEPTION
WHEN OTHERS THEN
  Str_Out := 'wrong value ???  termionate';
END get_arabic_disp_numbers;
FUNCTION get_eng_num_to_arab_word(
    p_num NUMBER)
  RETURN VARCHAR2
IS
  NUM               NUMBER;
  GNDR              NUMBER;
  GRMR              NUMBER;
  STR_OUT           VARCHAR2(32767);
  v_rials           VARCHAR2(1000);
  v_baizas          VARCHAR2(1000);
  v_rial_in_arabic  VARCHAR2(100) :='????? ?????? ';
  v_baisa_in_arabic VARCHAR2(100) := '???? ';
  v_only_in_arab    VARCHAR2(100) := '';
BEGIN
  NUM     := p_num;
  GNDR    := NULL;
  GRMR    := NULL;
  STR_OUT := NULL;
  get_arabic_disp_numbers ( regexp_substr(NUM||'','[^.]+',1,1), GNDR, GRMR, v_rials );
  v_rials                              := v_rials||' '||v_rial_in_arabic;
  IF regexp_substr(NUM||'','[^.]+',1,2) >0 THEN
    get_arabic_disp_numbers ( regexp_substr(NUM||'','[^.]+',1,2), GNDR, GRMR, v_baizas );
    RETURN v_rials||' '||v_baizas||' '||v_baisa_in_arabic;
  END IF;
  RETURN v_rials;
EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
end;
END xxpaca_hrms_report_pkg;
