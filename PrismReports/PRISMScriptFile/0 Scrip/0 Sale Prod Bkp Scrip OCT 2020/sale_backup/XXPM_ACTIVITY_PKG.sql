--------------------------------------------------------
--  DDL for Package XXPM_ACTIVITY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_ACTIVITY_PKG" is
PROCEDURE XXPM_PROC_ACTIVITY(
    SOURCE_FUNC_ID     IN NUMBER,
    SOURCE_FUNC_REF_ID IN NUMBER,
    ORG_ID             IN NUMBER,
    PROPERTY_ID        IN NUMBER,
    BUILD_ID           IN NUMBER,
    UNIT_ID            IN NUMBER,
    ACTIVITY_TYPE      IN VARCHAR2,
    DESCRIPTION        IN VARCHAR2,
	CREATED_BY		   IN VARCHAR2
	);
end XXPM_ACTIVITY_PKG;
