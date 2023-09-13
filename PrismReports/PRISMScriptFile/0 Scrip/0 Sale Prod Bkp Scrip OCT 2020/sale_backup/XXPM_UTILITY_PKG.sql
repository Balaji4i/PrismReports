--------------------------------------------------------
--  DDL for Package XXPM_UTILITY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_UTILITY_PKG" IS
   -- =========================================================================
   --
   -- This function get the look value display name
   --
   -- =========================================================================
   FUNCTION get_lookup_value_disp (p_lookup_type_name   IN varchar2
                                  ,p_lookup_value_name  IN varchar2)
      RETURN varchar2;

   -- =========================================================================
   --
   -- This function converts integer number into words
   --
   -- =========================================================================

   FUNCTION spell_number (p_number IN number)
      RETURN varchar2;

   -- =========================================================================
   --
   -- This function returns amount into words pertaining to currency
   --
   -- =========================================================================

   function AMOUNT_IN_WORDS (P_AMOUNT          in number
                            ,p_currency_code   IN varchar2)
      return varchar2;
END xxpm_utility_pkg;
