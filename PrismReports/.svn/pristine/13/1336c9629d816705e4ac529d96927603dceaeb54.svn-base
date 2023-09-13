--------------------------------------------------------
--  DDL for Package Body XXPM_UTILITY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_UTILITY_PKG" AS
   FUNCTION get_lookup_value_disp (p_lookup_type_name   IN varchar2
                                  ,p_lookup_value_name  IN varchar2)
      RETURN varchar2 IS
      l_lookup_value_d   varchar2 (240);
   BEGIN
      SELECT   xlv.lookup_value_name_disp
        INTO   l_lookup_value_d
        FROM   xxfnd_lookup_types xlt
              ,xxfnd_lookup_values xlv
       WHERE   xlt.lookup_type_id = xlv.lookup_type_id(+)
           AND xlt.lookup_type_name = p_lookup_type_name
           AND xlv.lookup_value_name = p_lookup_value_name;

      RETURN (l_lookup_value_d);
   EXCEPTION
      WHEN OTHERS THEN
         RETURN (NULL);
   END get_lookup_value_disp;

   FUNCTION spell_number (p_number IN number)
      RETURN varchar2 IS
      TYPE myarray IS TABLE OF varchar2 (255);

      l_str myarray
            := myarray (''
                       ,' Thousand '
                       ,' Million '
                       ,' Billion '
                       ,' Trillion '
                       ,' Quadrillion '
                       ,' Quintillion '
                       ,' Sextillion '
                       ,' Septillion '
                       ,' Octillion '
                       ,' Nonillion '
                       ,' Decillion '
                       ,' Undecillion '
                       ,' Duodecillion ') ;
      l_num      varchar2 (50) DEFAULT TRUNC (p_number) ;
      l_return   varchar2 (4000);
   BEGIN
      FOR i IN 1 .. l_str.COUNT LOOP
         EXIT WHEN l_num IS NULL;

         IF (SUBSTR (l_num
                    ,LENGTH (l_num) - 2
                    ,3) <> 0) THEN
            l_return := TO_CHAR (TO_DATE (SUBSTR (l_num
                                                 ,LENGTH (l_num) - 2
                                                 ,3)
                                         ,'J')
                                ,'Jsp')
                        || l_str (i)
                        || l_return;
         END IF;

         l_num := SUBSTR (l_num
                         ,1
                         ,LENGTH (l_num) - 3);
      END LOOP;

      RETURN l_return;
   EXCEPTION
      WHEN OTHERS THEN
         RETURN NULL;
   END spell_number;

   FUNCTION amount_in_words (p_amount          IN number
                            ,p_currency_code   IN varchar2)
      RETURN varchar2 AS
      CURSOR cur_curr IS
         SELECT   CURRENCY_NAME ecurrency_name
                 ,2 cur_prec
                 ,description int_desc
                 ,DECODE (currency_code,'AED','Fils', NULL) dec_desc
           FROM   XXFND_CURRENCIES
          WHERE   currency_code = p_currency_code;

      rec_curr   cur_curr%ROWTYPE;
      l_int      number;
      l_dec      number;
      l_int_w    varchar2 (4000);
      l_dec_w    varchar2 (4000);
      l_return   varchar2 (4000);
   BEGIN
      OPEN cur_curr;

      FETCH cur_curr INTO   rec_curr;

      CLOSE cur_curr;

      IF NVL (p_amount, 0) = 0 THEN
         l_return := 'Zero ' || rec_curr.int_desc || ' Only';
      ELSE
         l_int := ABS (TRUNC (p_amount));
         l_dec := ABS (TRUNC (MOD (p_amount
                                  ,1)
                              * POWER (10
                                      ,rec_curr.cur_prec)));

         l_int_w := spell_number (l_int);

         IF NVL (l_dec, 0) <> 0 THEN
            l_dec_w := spell_number (l_dec);
         ELSE
            l_dec_w := NULL;
         END IF;

         SELECT   l_int_w || DECODE (l_int_w, NULL, NULL, ' ' || rec_curr.int_desc) || DECODE (l_int_w, NULL, NULL, (DECODE (l_dec_w, NULL, NULL, ' And '))) || l_dec_w || DECODE (l_dec_w, NULL, NULL, ' ' || rec_curr.dec_desc) || ' Only'
           INTO   l_return
           FROM   DUAL;
      END IF;


      RETURN l_return;
   end AMOUNT_IN_WORDS;
END xxpm_utility_pkg;
