--------------------------------------------------------
--  DDL for Package TO_JSON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "TO_JSON" AUTHID DEFINER
IS
   SUBTYPE index_t IS VARCHAR2 (50);

   TYPE assoc_array_t IS TABLE OF VARCHAR2 (100)
      INDEX BY index_t;

   FUNCTION to_object (key_in IN VARCHAR2, value_in IN VARCHAR2)
      RETURN json_object_t;

   FUNCTION to_array (assoc_array_in IN assoc_array_t)
      RETURN json_array_t;
END;
