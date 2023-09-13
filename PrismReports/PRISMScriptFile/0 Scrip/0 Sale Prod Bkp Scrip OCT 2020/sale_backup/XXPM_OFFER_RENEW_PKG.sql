--------------------------------------------------------
--  DDL for Package XXPM_OFFER_RENEW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_OFFER_RENEW_PKG" 
AS
   PROCEDURE autocreate (p_offer_num      IN     varchar2,
                              p_user_id    IN     varchar2,
                              p_err_code      OUT varchar2,
                              p_err_msg       OUT varchar2);
END xxpm_offer_renew_pkg;
