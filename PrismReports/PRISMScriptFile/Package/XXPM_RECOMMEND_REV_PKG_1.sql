--------------------------------------------------------
--  DDL for Package XXPM_RECOMMEND_REV_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXPM_RECOMMEND_REV_PKG" 
is
   PROCEDURE revise_recommend (
      p_recommend_num   IN       VARCHAR2,
      p_user_id     IN       VARCHAR2 DEFAULT NULL,
      p_err_code    OUT      VARCHAR2,
      p_err_msg     OUT      VARCHAR2
   );
end xxpm_recommend_rev_pkg;


--------------------------------------------------------
--  DDL for Package Body XXPM_RECOMMEND_REV_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_RECOMMEND_REV_PKG" 
AS
   PROCEDURE load_history (
      p_recommend_id   IN       NUMBER,
      p_user_id    IN       VARCHAR2 DEFAULT NULL,
      p_err_code   OUT      VARCHAR2,
      p_err_msg    OUT      VARCHAR2
   )
   IS
      l_recommend_hst_id   NUMBER;
   BEGIN
      p_err_code := '0';
      p_err_msg := 'Success';
      l_recommend_hst_id := xxpm_recommend_header_h_s.NEXTVAL;

--Insert Header Record
      BEGIN
         INSERT INTO xxpm_recommend_header_h
                     (recommend_hst_id, RECOMMEND_ID, FUNC_ID, BOOKING_ID, 
                     RECOMMEND_NUMBER, STATUS, DESCRIPTION, FLOW_STATUS, 
                     FLOW_LEVEL, FLOW_WITH, ATTRIBUTE_CATEGORY, 
                     ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, 
                     ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, 
                     ATTRIBUTE11, ATTRIBUTE12, ATTRIBUTE13, ATTRIBUTE14, 
                     ATTRIBUTE15, ATTRIBUTE16, ATTRIBUTE17, ATTRIBUTE18, 
                     ATTRIBUTE19, ATTRIBUTE20, 
                     CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, 
                     LAST_UPDATE_LOGIN, OBJECT_VERSION_NUMBER, ORG_ID, PROPERTY_ID, 
                     BUILDING_ID, USER_GRP_ID, RECOMMEND_DATE, REVISION_NO)
            SELECT l_recommend_hst_id, RECOMMEND_ID, FUNC_ID, BOOKING_ID, 
                     RECOMMEND_NUMBER, STATUS, DESCRIPTION, FLOW_STATUS, 
                     FLOW_LEVEL, FLOW_WITH, ATTRIBUTE_CATEGORY, 
                     ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, 
                     ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, 
                     ATTRIBUTE11, ATTRIBUTE12, ATTRIBUTE13, ATTRIBUTE14, 
                     ATTRIBUTE15, ATTRIBUTE16, ATTRIBUTE17, ATTRIBUTE18, 
                     ATTRIBUTE19, ATTRIBUTE20, 
                     CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, 
                     LAST_UPDATE_LOGIN, OBJECT_VERSION_NUMBER, ORG_ID, PROPERTY_ID, 
                     BUILDING_ID, USER_GRP_ID, RECOMMEND_DATE, REVISION_NO
              FROM xxpm_recommend_header
             WHERE RECOMMEND_ID = p_recommend_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_code := SQLCODE;
            p_err_msg := SQLERRM;
            --GOTO skip_insert;
      END;
      --<<skip_insert>>
      --NULL;
   END load_history;

   PROCEDURE revise_recommend (
      p_recommend_num   IN       VARCHAR2,
      p_user_id     IN       VARCHAR2 DEFAULT NULL,
      p_err_code    OUT      VARCHAR2,
      p_err_msg     OUT      VARCHAR2
   )
   IS
      l_err_code   VARCHAR2 (100);
      l_err_msg    VARCHAR2 (1000);
      l_recommend_id   NUMBER;
   BEGIN
      p_err_code := '0';
      p_err_msg := 'Success';
      SAVEPOINT revise_recommend;

      BEGIN
         SELECT recommend_id
           INTO l_recommend_id
           FROM xxpm_recommend_header
          WHERE recommend_number = p_recommend_num;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_code := SQLCODE;
            p_err_msg := SQLERRM;
      END;

      IF l_recommend_id IS NULL
      THEN
         p_err_code := '-1';
         p_err_msg := 'Recommend Number does not exists. Please Check';
      ELSE
         load_history (p_recommend_id      => l_recommend_id,
                       p_user_id       => p_user_id,
                       p_err_code      => l_err_code,
                       p_err_msg       => l_err_msg
                      );
         p_err_code := l_err_code;
         p_err_msg := l_err_msg;

         IF l_err_code = '0'
         THEN
            UPDATE xxpm_recommend_header
               SET revision_no = nvl(revision_no,1) + 1,
                   last_updated_by = p_user_id,
                   last_update_date = SYSDATE
             WHERE RECOMMEND_ID = l_recommend_id;

            COMMIT;
         END IF;
      END IF;

--      IF p_err_code != '0'
--      THEN
--         ROLLBACK TO revise_offer;
--      END IF;
   END revise_recommend;

END xxpm_recommend_rev_pkg;
