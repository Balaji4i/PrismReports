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

--------------------------------------------------------
--  DDL for Package Body TO_JSON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "TO_JSON" 
IS
   FUNCTION to_object (key_in IN VARCHAR2, value_in IN VARCHAR2)
      RETURN json_object_t
   IS
   BEGIN
      RETURN json_object_t ('{"' || key_in || '":"' || value_in || '"}');
   END;

   FUNCTION to_array (assoc_array_in IN assoc_array_t)
      RETURN json_array_t
   IS
      l_index        index_t := assoc_array_in.FIRST;
      l_json_array   json_array_t := json_array_t ();
   BEGIN
      WHILE l_index IS NOT NULL
      LOOP
         --DBMS_OUTPUT.put_line ( 'Appending ' || l_index || ':' || assoc_array_in (l_index));
         l_json_array.append (to_object (l_index, assoc_array_in (l_index)));
         --DBMS_OUTPUT.put_line ('Watch it grow! ' || l_json_array.get_size ());
         l_index     := assoc_array_in.NEXT (l_index);
      END LOOP;

      RETURN l_json_array;
   END;
END;
