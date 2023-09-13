--------------------------------------------------------
--  Constraints for Table COMPANY_LOGO
--------------------------------------------------------

  ALTER TABLE "COMPANY_LOGO" MODIFY ("SI_NO" NOT NULL ENABLE)
  ALTER TABLE "COMPANY_LOGO" ADD CONSTRAINT "COMPANY_LOGO_PK" PRIMARY KEY ("SI_NO")
  USING INDEX  ENABLE
