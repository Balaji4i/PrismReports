--------------------------------------------------------
--  DDL for Package Body XXFND_UTIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXFND_UTIL_PKG" 
IS
   FUNCTION get_segment_value (p_segment_column IN VARCHAR2
                              ,p_segment_value IN VARCHAR2)
      RETURN VARCHAR2
   IS
      CURSOR c1
      IS
           SELECT seq_number
                 ,segment_column
                 ,src_table
                 ,src_column
                 ,src_disp_column
                 ,src_lookup_type
             FROM xxfnd_data_security
            WHERE segment_column = p_segment_column
         ORDER BY seq_number;

      c1_rec         c1%ROWTYPE;
      l_sql          VARCHAR2 (2000) := NULL;
      l_output       VARCHAR2 (2000) := NULL;
   BEGIN
      OPEN c1;

      FETCH c1 INTO c1_rec;

      IF c1%NOTFOUND
      THEN
         CLOSE c1;

         RETURN l_output;
      ELSE
         l_sql       :=
               'select '
            || c1_rec.src_disp_column
            || ' from '
            || c1_rec.src_table
            || ' where 1 = 1 '
            || ' and '
            || c1_rec.src_column
            || ' = '
            || ''''
            || p_segment_value
            || '''';

         DBMS_OUTPUT.put_line ('source table : ' || c1_rec.src_table);

         IF c1_rec.src_table = 'XXFND_LOOKUP_VALUES'
         THEN
            l_sql       :=
                  l_sql
               || ' and lookup_type_id = ( select lookup_type_id from xxfnd_lookup_types where lookup_type_name = '
               || ''''
               || c1_rec.src_lookup_type
               || ''''
               || ')';

            DBMS_OUTPUT.put_line ('inside if ');
         END IF;

         CLOSE c1;
      END IF;

      DBMS_OUTPUT.put_line ('SQL : ' || NVL (l_sql, 'Not Defined'));

      IF l_sql IS NOT NULL
      THEN
         EXECUTE IMMEDIATE l_sql            INTO l_output;
      END IF;

      DBMS_OUTPUT.put_line ('Output : ' || l_output);
      RETURN l_output;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_segment_value;

   ------
   FUNCTION get_user_by_emp (p_emp_id IN NUMBER)
      RETURN NUMBER
   IS
      l_user_id      NUMBER;

      CURSOR c2
      IS
         SELECT user_id
           FROM xxfnd_user
          WHERE     emp_id = p_emp_id
                AND NVL (active_yn, 'N') = 'Y';
   BEGIN
      OPEN c2;

      FETCH c2 INTO l_user_id;

      IF c2%NOTFOUND
      THEN
         CLOSE c2;

         RETURN NULL;
      END IF;

      CLOSE c2;

      RETURN l_user_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_user_by_emp;

   ------
   FUNCTION get_user_by_role (p_role_id IN NUMBER)
      RETURN NUMBER
   IS
      l_role_type    VARCHAR2 (30);
      l_role_value   VARCHAR2 (4000);
      l_user_id      NUMBER;

      CURSOR c1
      IS
         SELECT role_type, role_value
           FROM xxfnd_appr_roles
          WHERE     role_id = p_role_id
                AND NVL (active_yn, 'N') = 'Y';
   BEGIN
      OPEN c1;

      FETCH c1
      INTO l_role_type, l_role_value;

      IF c1%NOTFOUND
      THEN
         CLOSE c1;

         RETURN NULL;
      END IF;

      CLOSE c1;

      IF l_role_type = 'E'
      THEN
         l_user_id   := get_user_by_emp (l_role_value);
      ELSIF l_role_type = 'Q'
      THEN
         RETURN NULL;
      -- needs to be changed
      END IF;

      RETURN l_user_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_user_by_role;

   ------
   FUNCTION get_user_by_position (p_position_id IN NUMBER)
      RETURN NUMBER
   IS
      l_user_id      NUMBER;
      l_person_id    NUMBER;

      CURSOR c1
      IS
         SELECT person_id
           FROM xxstg_positions
          WHERE     position_id = p_position_id
                AND NVL (active_yn, 'N') = 'Y';
   BEGIN
      OPEN c1;

      FETCH c1 INTO l_person_id;

      IF c1%NOTFOUND
      THEN
         CLOSE c1;

         RETURN NULL;
      END IF;

      CLOSE c1;

      l_user_id   := get_user_by_emp (l_person_id);
      RETURN l_user_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_user_by_position;

   ------
   FUNCTION get_appr_by_name (p_appr_type IN VARCHAR2, p_appr_by IN NUMBER)
      RETURN VARCHAR2
   IS
      l_desc         VARCHAR2 (500);

      CURSOR c1
      IS
         SELECT user_name_disp
           FROM xxfnd_user
          WHERE user_id = p_appr_by;

      CURSOR c2
      IS
         SELECT role_name
           FROM xxfnd_appr_roles
          WHERE role_id = p_appr_by;

      CURSOR c3
      IS
         SELECT position_name
           FROM xxstg_positions
          WHERE position_id = p_appr_by;
   BEGIN
      l_desc      := NULL;

      IF p_appr_type = 'U'
      THEN
         OPEN c1;

         FETCH c1 INTO l_desc;

         CLOSE c1;
      ELSIF p_appr_type = 'R'
      THEN
         OPEN c2;

         FETCH c2 INTO l_desc;

         CLOSE c2;
      ELSIF p_appr_type = 'P'
      THEN
         OPEN c3;

         FETCH c3 INTO l_desc;

         CLOSE c3;
      END IF;

      RETURN l_desc;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_appr_by_name;

   ------
   FUNCTION get_user_group (p_func_id      IN NUMBER
                           ,p_attribute1   IN VARCHAR2
                           ,p_attribute2   IN VARCHAR2
                           ,p_attribute3   IN VARCHAR2
                           ,p_attribute4   IN VARCHAR2
                           ,p_attribute5   IN VARCHAR2
                           ,p_amount       IN NUMBER)
      RETURN NUMBER
   IS
      l_user_grp_id  NUMBER;

      ---Krishna
      ---This cursor will provide the user group id which is associated with
      ---Func id and attr group id. From amount and to amount will be taken and used to filter out the user group
      CURSOR c1
      IS
         SELECT ac.user_grp_id
           FROM xxfnd_func_approvals fa
               ,xxfnd_appr_attr_group ag
               ,xxfnd_appr_attr_comb ac
          WHERE     fa.func_id = p_func_id
                AND NVL (fa.active_yn, 'N') = 'Y'
                AND ag.attr_grp_id = fa.attr_grp_id
                AND NVL (ag.active_yn, 'N') = 'Y'
                AND ac.attr_grp_id = ag.attr_grp_id
                AND NVL (ac.active_yn, 'N') = 'Y'
                AND NVL (ac.attribute1, ' ') = NVL (p_attribute1, ' ')
                AND NVL (ac.attribute2, ' ') = NVL (p_attribute2, ' ')
                AND NVL (ac.attribute3, ' ') = NVL (p_attribute3, ' ')
                AND NVL (ac.attribute4, ' ') = NVL (p_attribute4, ' ')
                AND NVL (ac.attribute5, ' ') = NVL (p_attribute5, ' ')
                AND p_amount BETWEEN NVL (ac.amount_from, '')
                                 AND NVL (ac.amount_to, '');
   BEGIN
      OPEN c1;

      FETCH c1 INTO l_user_grp_id;

      IF c1%NOTFOUND
      THEN
         CLOSE c1;

         RETURN NULL;
      END IF;

      CLOSE c1;

      RETURN l_user_grp_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_user_group;

   ------
   PROCEDURE insert_appr_hist (p_func_id      IN     NUMBER
                              ,p_ref_id       IN     NUMBER
                              ,                   -- PK of respective function
                               p_level_no     IN     NUMBER
                              ,p_appr_id      IN     NUMBER
                              ,p_appr_role    IN     VARCHAR2
                              ,p_flow_level   IN     NUMBER
                              ,p_usr_grp_id   IN     NUMBER
                              ,p_cycle_no     IN     NUMBER
                              ,p_err_code        OUT VARCHAR2
                              ,p_err_msg         OUT VARCHAR2)
   IS
   BEGIN
      p_err_code  := '0';
      p_err_msg   := 'Success';

      ---Krishna
      /* Insert the appproval list from all the levels which is associated with the particular and maintain in the xxfnd_func_approval_hist
      table with status as Pending-P */

      DBMS_OUTPUT.put_line ('@insert_appr_hist: ');

      INSERT INTO xxfnd_func_approval_hist (appr_hist_id
                                           ,func_id
                                           ,func_ref_id
                                           ,seq_number
                                           ,appr_role
                                           ,approver_id
                                           ,submission_date
                                           ,action_date
                                           ,description
                                           ,status
                                           ,attribute_category
                                           ,attribute1
                                           ,attribute2
                                           ,attribute3
                                           ,attribute4
                                           ,attribute5
                                           ,attribute6
                                           ,attribute7
                                           ,attribute8
                                           ,attribute9
                                           ,attribute10
                                           ,created_by
                                           ,creation_date
                                           ,last_updated_by
                                           ,last_update_date
                                           ,last_update_login
                                           ,flow_level
                                           ,user_grp_id
                                           ,cycle_no
                                           ,cycle_flag)
           VALUES (xxfnd_appr_hist_id_s.NEXTVAL
                  ,p_func_id
                  ,p_ref_id
                  ,p_level_no
                  ,p_appr_role
                  ,p_appr_id
                  ,NULL
                  ,NULL
                  ,NULL
                  ,'P'
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,NULL
                  ,-1
                  ,SYSDATE
                  ,-1
                  ,SYSDATE
                  ,-1
                  ,p_flow_level
                  ,p_usr_grp_id
                  ,p_cycle_no
                  ,'O');

      DBMS_OUTPUT.put_line (
            '@insert_appr_hist: p_func_id | p_ref_id |  p_level_no | p_appr_role | p_appr_id :'
         || p_func_id
         || ' | '
         || p_ref_id
         || ' | '
         || p_level_no
         || ' | '
         || p_appr_role
         || ' | '
         || p_appr_id);
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := SQLCODE;
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         DBMS_OUTPUT.put_line ('@insert_appr_hist: exception  ' || p_err_msg);
         RETURN;
   END insert_appr_hist;

   ------
   PROCEDURE update_appr_hist (p_func_id      IN     NUMBER
                              ,p_ref_id       IN     NUMBER
                              ,                   -- PK of respective function
                               p_level_no     IN     NUMBER
                              ,p_appr_id      IN     NUMBER
                              ,p_response     IN     VARCHAR2
                              ,p_status       IN     VARCHAR2
                              ,p_cycle_no     IN     NUMBER
                              ,p_err_code        OUT VARCHAR2
                              ,p_err_msg         OUT VARCHAR2)
   IS
   BEGIN
      p_err_code  := '0';
      p_err_msg   := 'Success';

      IF p_appr_id IS NULL
      THEN
         /* Update all the entries and IF CONDITION WILL WORK for when approved_by all column is
            mentioned as 'N' in Appr_user table*/
         UPDATE xxfnd_func_approval_hist
            SET action_date  = SYSDATE
               ,description  = p_response
               ,status       = p_status
               ,last_updated_by = -1
               ,last_update_date = SYSDATE
               ,cycle_flag   = 'C'
          WHERE     func_id = p_func_id
                AND func_ref_id = p_ref_id
                AND flow_level = p_level_no
                AND cycle_no = p_cycle_no
                AND action_date IS NULL;

         ----Status is R-rejected close the cycle.
         /* Update all the entries and if condition will work when user reject the transaction and
             Rejection status will be updated based on the approver levels */
         IF p_status = 'R'
         THEN
            UPDATE xxfnd_func_approval_hist
               SET last_updated_by = -1
                  ,last_update_date = SYSDATE
                  ,cycle_flag   = 'C'
             WHERE     func_id = p_func_id
                   AND func_ref_id = p_ref_id
                   AND cycle_no = p_cycle_no
                   AND cycle_flag = 'O';
         END IF;
      ELSE
         /* Update all the entries and if condition will work for when approved_by all column is
            mentioned as 'Y' in Appr_user table*/
         UPDATE xxfnd_func_approval_hist
            SET action_date  = SYSDATE
               ,description  = p_response
               ,status       = p_status
               ,last_updated_by = -1
               ,last_update_date = SYSDATE
               ,cycle_flag   = 'C'
          WHERE     func_id = p_func_id
                AND func_ref_id = p_ref_id
                AND flow_level = p_level_no
                AND cycle_no = p_cycle_no
                AND approver_id = p_appr_id
                AND action_date IS NULL;
      END IF;

      DBMS_OUTPUT.put_line (
            '@update_appr_hist: p_func_id | p_ref_id |  p_level_no | p_appr_id | p_response | p_status :'
         || p_func_id
         || ' | '
         || p_ref_id
         || ' | '
         || p_level_no
         || ' | '
         || p_appr_id
         || ' | '
         || p_response
         || ' | '
         || p_status);
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := SQLCODE;
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         RETURN;
   END update_appr_hist;

   ----------
   PROCEDURE submit_next_level (p_func_id      IN     NUMBER
                               ,p_ref_id       IN     NUMBER
                               ,                  -- PK of respective function
                                p_level_no     IN     NUMBER
                               ,p_cycle_no     IN     NUMBER
                               ,p_err_code        OUT VARCHAR2
                               ,p_err_msg         OUT VARCHAR2)
   IS
   BEGIN
      p_err_code  := '0';
      p_err_msg   := 'Success';

      /* Get the next approver id from the appproval_hist table and update the submission date alone for the current
      user who is supposed to approve */
      UPDATE xxfnd_func_approval_hist
         SET submission_date = SYSDATE
       WHERE     func_id = p_func_id
             AND func_ref_id = p_ref_id
             AND flow_level = p_level_no
             AND cycle_no = p_cycle_no
             AND cycle_flag = 'O';
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := SQLCODE;
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         RETURN;
   END submit_next_level;

   --------
   PROCEDURE submit_for_approval (p_func_id      IN     NUMBER
                                 ,p_ref_id       IN     NUMBER
                                 ,                -- PK of respective function
                                  p_user_grp_id  IN     NUMBER
                                 ,p_level_no     IN OUT NUMBER
                                 ,p_amount       IN     NUMBER
                                 ,p_flow_status     OUT VARCHAR2
                                 ,p_appr_id         OUT NUMBER
                                 ,p_err_code        OUT VARCHAR2
                                 ,p_err_msg         OUT VARCHAR2)
   IS
      -- submit for approval
      l_level_no     NUMBER;
      l_level_name   VARCHAR2 (60);
      l_flow_status  VARCHAR2 (60);
      l_appr_id      NUMBER;
      l_appr_role    VARCHAR2 (30);
      l_appr_type    VARCHAR2 (30);
      l_appr_by      NUMBER;
      l_cycle_count  NUMBER;
      l_seq_no       NUMBER;
      l_seq_no_hist  NUMBER;
      l_apr_tab      apr_tab;

      -----Krishna
      ----Change in cursor parameter to pull the appproval user id from the user group who is eligible for the  particular transactions.

      CURSOR c1
      IS
           SELECT l.level_no level_no
                 ,l.level_name level_name
                 ,a.appr_role appr_role
                 ,a.appr_type appr_type
                 ,a.user_id user_id_1
             FROM xxfnd_appr_user_group g
                 ,xxfnd_appr_user_levels l
                 ,xxfnd_appr_users a
            WHERE     g.user_grp_id = p_user_grp_id
                  AND NVL (g.active_yn, 'N') = 'Y'
                  AND l.user_grp_id = g.user_grp_id
                  AND NVL (l.active_yn, 'N') = 'Y'
                  AND a.user_level_id = l.user_level_id
                  AND NVL (a.active_yn, 'N') = 'Y'
         ORDER BY l.level_no, a.seq_number;

      TYPE t_level IS TABLE OF c1%ROWTYPE;

      l_user_find    t_level;

      /* This cursor to update the submission date for the current user who is suppose to approve. */
      CURSOR c3
      IS
           SELECT flow_level, approver_id, seq_number
             FROM xxfnd_func_approval_hist
            WHERE     func_id = p_func_id
                  AND func_ref_id = p_ref_id
                  AND flow_level >= p_level_no
                  AND NVL (status, 'P') = 'P'
         ORDER BY seq_number;
   BEGIN
      p_err_code  := '0';
      p_err_msg   := 'Success';

      /*Krishna
        Increment the cycle no if there is any exist for the function id and transaction.*/
      SELECT NVL (MAX (cycle_no), 0)
        INTO l_cycle_count
        FROM xxfnd_func_approval_hist
       WHERE     func_id = p_func_id
             AND func_ref_id = p_ref_id;

      l_cycle_count :=
           l_cycle_count
         + 1;
      l_seq_no    := 0;
      DBMS_OUTPUT.put_line (
            '@submit_for_approval0: p_func_id | p_ref_id |  p_level_no | p_appr_id | p_flow_status :'
         || p_func_id
         || ' | '
         || p_ref_id
         || ' | '
         || p_level_no
         || ' | '
         || p_appr_id
         || ' | '
         || p_flow_status);

      OPEN c1;

      FETCH c1
      BULK COLLECT INTO l_user_find;

      CLOSE c1;

      IF l_user_find.COUNT > 0
      THEN
         FOR l_input IN l_user_find.FIRST .. l_user_find.LAST
         LOOP
            l_level_no  := l_user_find (l_input).level_no;
            l_level_name := l_user_find (l_input).level_name;
            l_appr_role := l_user_find (l_input).appr_role;
            l_appr_type := l_user_find (l_input).appr_type;
            l_appr_id   := l_user_find (l_input).user_id_1;
            l_seq_no    :=
                 l_seq_no
               + 1;
            /* Insert the approvers list into history table */
            insert_appr_hist (p_func_id
                             ,p_ref_id
                             ,l_seq_no
                             ,l_appr_id
                             ,l_appr_role
                             ,l_level_no
                             ,p_user_grp_id
                             ,l_cycle_count
                             ,p_err_code
                             ,p_err_msg);
         END LOOP;

         OPEN c3;

         FETCH c3
         INTO p_level_no, p_appr_id, l_seq_no_hist;

         CLOSE c3;

         /* Update the  submission date for the current approver*/
         submit_next_level (p_func_id
                           ,p_ref_id
                           ,p_level_no
                           ,l_cycle_count
                           ,p_err_code
                           ,p_err_msg);
      ELSE
         /* If there is no user tagged with the user group id then the transaction will automatically get approve.*/
         DBMS_OUTPUT.put_line (
            '@submit_for_approval1b : l_level_no is null ' || l_level_no);
         p_level_no  := NULL;
         p_flow_status := 'A';
         p_appr_id   := NULL;
      END IF;

      DBMS_OUTPUT.put_line (
            '@submit_for_approval2: p_func_id | p_ref_id |  p_level_no | p_appr_id | l_appr_role | p_flow_status :'
         || p_func_id
         || ' | '
         || p_ref_id
         || ' | '
         || p_level_no
         || ' | '
         || p_appr_id
         || ' | '
         || l_appr_role
         || ' | '
         || p_flow_status);
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := SQLCODE;
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         RETURN;
   END submit_for_approval;

   ------
   PROCEDURE update_response (p_func_id      IN     NUMBER
                             ,p_ref_id       IN     NUMBER
                             ,                    -- PK of respective function
                              p_user_grp_id  IN     NUMBER
                             ,p_level_no     IN OUT NUMBER
                             ,p_appr_id      IN OUT NUMBER
                             ,p_response     IN     VARCHAR2
                             ,p_status       IN     VARCHAR2
                             ,p_fwd_to       IN     NUMBER
                             ,p_flow_status     OUT VARCHAR2
                             ,p_amount       IN     NUMBER
                             ,p_err_code        OUT VARCHAR2
                             ,p_err_msg         OUT VARCHAR2)
   IS
      -- get response
      -- if approved, repeat steps till gets approved...
      -- if rejected, stop the process
      --              send back status
      -- if change user, insert records in history
      --              send back level, appr id, flow sts

      l_level_no     NUMBER;
      l_flow_status  VARCHAR2 (60) := NULL;
      l_appr_id      NUMBER;
      l_appr_role    VARCHAR2 (30);
      l_pending_yn   VARCHAR2 (1);
      l_appr_by_all  VARCHAR2 (1);
      l_cycle_count  NUMBER;
      l_seq_hist     NUMBER;

      --To check all approved is required or not for the existing user level.
      CURSOR c1
      IS
         SELECT l.appr_by_all
           FROM xxfnd_appr_user_levels l
          WHERE     l.user_grp_id = p_user_grp_id
                -- and     nvl(l.active_yn, 'N') = 'Y'
                AND l.level_no = NVL (p_level_no, 0);

      CURSOR c2
      IS
         SELECT 'Y'
           FROM xxfnd_func_approval_hist
          WHERE     func_id = p_func_id
                AND func_ref_id = p_ref_id
                AND flow_level = p_level_no
                AND NVL (status, 'P') = 'P';

      /* Get the cycle_no and seq number which is in open status  */
      CURSOR c4
      IS
         SELECT seq_number, cycle_no
           FROM xxfnd_func_approval_hist
          WHERE     func_id = p_func_id
                AND func_ref_id = p_ref_id
                AND flow_level = p_level_no
                AND cycle_flag = 'O'
                AND approver_id = p_appr_id;

      /* To update the submission date for the current user who is suppose to approve. */
      CURSOR c3
      IS
           SELECT flow_level, approver_id
             FROM xxfnd_func_approval_hist
            WHERE     func_id = p_func_id
                  AND func_ref_id = p_ref_id
                  AND flow_level >= p_level_no
                  AND NVL (status, 'P') = 'P'
                  AND cycle_no = l_cycle_count
         ORDER BY seq_number;
   BEGIN
      p_err_code  := '0';
      p_err_msg   := 'Success';

      OPEN c1;

      FETCH c1 INTO l_appr_by_all;

      CLOSE c1;

      OPEN c4;

      FETCH c4
      INTO l_seq_hist, l_cycle_count;

      CLOSE c4;

      --the transaction is rejected by the user
      IF p_status = 'R'
      THEN                                                         -- Rejected
         DBMS_OUTPUT.put_line ('@update_response2: p_status - Rejected');
         -- Update all as Rejected in user level wise and close the current cycle...
         update_appr_hist (p_func_id
                          ,p_ref_id
                          ,p_level_no
                          ,NULL
                          ,p_response
                          ,p_status
                          ,l_cycle_count
                          ,p_err_code
                          ,p_err_msg);
         p_flow_status := p_status;
      --the transaction is forwarded by the user
      ELSIF p_status = 'F'
      THEN                                                     -- Forwarded To
         DBMS_OUTPUT.put_line ('@update_response3: p_status - Forward');
         --Update the current user with flag close and mark the status F
         update_appr_hist (p_func_id
                          ,p_ref_id
                          ,p_level_no
                          ,p_appr_id
                          ,p_response
                          ,p_status
                          ,l_cycle_count
                          ,p_err_code
                          ,p_err_msg);
         --Insert the new user who is suppose the approve.
         insert_appr_hist (p_func_id
                          ,p_ref_id
                          ,l_seq_hist
                          ,p_fwd_to
                          ,l_appr_role
                          ,p_level_no
                          ,p_user_grp_id
                          ,l_cycle_count
                          ,p_err_code
                          ,p_err_msg);
         --Update the submission date for the current user.
         submit_next_level (p_func_id
                           ,p_ref_id
                           ,p_level_no
                           ,l_cycle_count
                           ,p_err_code
                           ,p_err_msg);
         p_flow_status := p_status;
      --the transaction is approved by the user
      ELSE
         DBMS_OUTPUT.put_line ('@update_response4: p_status - Approved');
         DBMS_OUTPUT.put_line (
            '@update_response5: l_appr_by_all ' || l_appr_by_all);

         IF NVL (l_appr_by_all, 'N') = 'N'
         THEN
            -- all approvals not required
            update_appr_hist (p_func_id
                             ,p_ref_id
                             ,p_level_no
                             ,NULL
                             ,p_response
                             ,p_status
                             ,l_cycle_count
                             ,p_err_code
                             ,p_err_msg);
         ELSE
            DBMS_OUTPUT.put_line (
               '@update_response5a: l_appr_by_all ' || l_appr_by_all);
            -- all approvals required
            update_appr_hist (p_func_id
                             ,p_ref_id
                             ,p_level_no
                             ,p_appr_id
                             ,p_response
                             ,p_status
                             ,l_cycle_count
                             ,p_err_code
                             ,p_err_msg);
            DBMS_OUTPUT.put_line (
               '@update_response6: l_pending_yn ' || p_level_no);
         END IF;

         OPEN c3;

         FETCH c3
         INTO l_level_no, p_appr_id;

         --All the users approved then we will mark the transaction with approved status.
         IF c3%NOTFOUND
         THEN
            p_flow_status := 'A';
            p_appr_id   := NULL;
            p_level_no  := NULL;

            CLOSE c3;
         ELSE
            --Update the submission date for the next approver.
            CLOSE c3;

            IF (l_level_no <> p_level_no)
            THEN
               submit_next_level (p_func_id
                                 ,p_ref_id
                                 ,l_level_no
                                 ,l_cycle_count
                                 ,p_err_code
                                 ,p_err_msg);
               p_level_no  := l_level_no;
            END IF;
         END IF;
      END IF;

      DBMS_OUTPUT.put_line (
         '@update_response7: l_flow_status ' || l_flow_status);
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := SQLCODE;
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         RETURN;
   END update_response;

   ------ Screen level Submit
   PROCEDURE submit_for_approval (p_func_id      IN     NUMBER
                                 ,p_ref_id       IN     NUMBER
                                 ,                -- pk of respective function
                                  p_level_no     IN OUT NUMBER
                                 ,p_table_name   IN     VARCHAR2
                                 ,p_status_column IN    VARCHAR2
                                 ,p_pk_column    IN     VARCHAR2
                                 ,p_amount       IN     NUMBER
                                 ,p_attribute1   IN     VARCHAR2
                                 ,p_attribute2   IN     VARCHAR2
                                 ,p_attribute3   IN     VARCHAR2
                                 ,p_attribute4   IN     VARCHAR2
                                 ,p_attribute5   IN     VARCHAR2
                                 ,p_flow_status     OUT VARCHAR2
                                 ,p_flow_with       OUT NUMBER
                                 ,p_approver_name   OUT VARCHAR2
                                 ,p_approver_email   OUT VARCHAR2
                                 ,p_user_grp_id     OUT VARCHAR2
                                 ,p_err_code        OUT VARCHAR2
                                 ,p_err_msg         OUT VARCHAR2)
   IS
      l_flow_status  VARCHAR2 (100) := NULL;
      l_appr_id      NUMBER;
      l_err_code     VARCHAR2 (100);
      l_err_msg      VARCHAR2 (100);
      l_status       VARCHAR2 (100);
      l_flow_with    NUMBER := NULL;
      l_flow_level   NUMBER := NULL;
      l_stmt         VARCHAR2 (5000);
      l_user_grp_id  NUMBER;
      l_user_name    VARCHAR2 (100);
      l_user_emailid VARCHAR2 (100);
      l_flag         VARCHAR2 (10) := NULL;
      l_attribute3   VARCHAR2 (100);
      l_attribute4   VARCHAR2 (100);
      l_attribute5   VARCHAR2 (100);



      CURSOR c_approve_details
      IS
         SELECT user_name, user_email_id
           FROM xxfnd_user
          WHERE user_id = l_appr_id;
   --l_a
   BEGIN
      DBMS_OUTPUT.put_line ('begin ===>');
      p_err_code  := '0';
      p_err_msg   := 'Success';

      IF p_attribute3 = 'null'
      THEN
         DBMS_OUTPUT.put_line ('p_attribute3 =null ===>');

         l_attribute3 := NULL;
      ELSE
         l_attribute3 := p_attribute3;
      END IF;

      IF p_attribute4 = 'null'
      THEN
         DBMS_OUTPUT.put_line ('p_attribute4 =null ===>');


         l_attribute4 := NULL;
      ELSE
         l_attribute4 := p_attribute4;
      END IF;

      IF p_attribute5 = 'null'
      THEN
         DBMS_OUTPUT.put_line ('p_attribute5 =null ===>');

         l_attribute5 := NULL;
      ELSE
         l_attribute5 := p_attribute5;
      END IF;


      -- Ger User Group
      l_user_grp_id :=
         get_user_group (p_func_id
                        ,p_attribute1
                        ,p_attribute2
                        ,l_attribute3
                        ,l_attribute4
                        ,l_attribute5
                        ,p_amount);

      DBMS_OUTPUT.put_line ('l_user_grp_id =null ===> ' || l_user_grp_id);

      IF l_user_grp_id IS NULL
      THEN
         p_err_code  := '-1';
         p_err_msg   :=
            'No Active Approval Attribute Group or User Group defined...';
         RETURN;
      END IF;

      l_stmt      :=
            'update '
         || p_table_name
         || ' set '
         || p_status_column
         || ' = :1,flow_status = :2,flow_with = :3,flow_level = :4, user_grp_id = :5 where '
         || p_pk_column
         || ' = '
         || p_ref_id;
      submit_for_approval (p_func_id
                          ,p_ref_id
                          ,l_user_grp_id
                          ,p_level_no
                          ,p_amount
                          ,l_flow_status
                          ,l_appr_id
                          ,l_err_code
                          ,l_err_msg);
      DBMS_OUTPUT.put_line (
            'flow status ,app id,===>'
         || l_flow_status
         || ' | '
         || l_appr_id
         || ' | '
         || l_err_code
         || ' | '
         || l_err_msg);

      IF l_flow_status = 'A'
      THEN
         l_status    := 'APR';
         l_flag      := 'Y';
         l_flow_status := NULL;
         l_flow_with := NULL;
         l_flow_level := NULL;
         l_user_grp_id := NULL;
         l_flag      := NULL;
      ELSE
         l_status    := 'PEN';
         l_flow_with := l_appr_id;
         l_flow_level := p_level_no;
         l_flag      := NULL;
      END IF;

      EXECUTE IMMEDIATE l_stmt
         USING l_status
              ,l_flow_status
              ,l_flow_with
              ,l_flow_level
              ,l_user_grp_id;

      DBMS_OUTPUT.put_line (
            l_status
         || '----'
         || l_flow_status
         || '------'
         || l_flow_with
         || '------'
         || l_flow_level
         || '------'
         || l_user_grp_id);
   --   COMMIT;
      DBMS_OUTPUT.put_line ('STAUS==>  ' || p_err_code || ' ' || p_err_msg);

      OPEN c_approve_details;

      FETCH c_approve_details
      INTO l_user_name, l_user_emailid;

      CLOSE c_approve_details;

      p_flow_status := l_status;
      p_level_no  := p_level_no;
      p_flow_with := l_appr_id;
      p_approver_name := l_user_name;
      p_approver_email := l_user_emailid;
      p_user_grp_id := l_user_grp_id;

      IF l_flag = 'Y'
      THEN
         xxpm_prism.xxpm_approval_upd_response (p_func_id
                                               ,p_ref_id
                                               ,p_table_name
                                               ,l_err_code
                                               ,l_err_msg);
      END IF;

      -- REST conversion
      DBMS_OUTPUT.put_line (
         'STAUS55==>  ' || p_flow_status || ' ' || p_level_no);
   --APEX_JSON.open_object;
   --APEX_JSON.write('FlowStatus', p_flow_status);
   --APEX_JSON.write('LevelNo', p_level_no);
   --APEX_JSON.write('FlowWith', p_flow_with);
   --APEX_JSON.write('ApproverName', p_approver_name);
   --APEX_JSON.write('ApproverEmail', p_approver_email);
   --APEX_JSON.write('UserGroupId', p_user_grp_id);
   --APEX_JSON.close_object;
   --
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := '1';
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         DBMS_OUTPUT.put_line (
            'STAUS==>  ' || p_err_code || ' ' || p_err_msg);
   END submit_for_approval;

   ------ Screen level Update
   PROCEDURE update_response (p_func_id      IN     NUMBER
                             ,p_ref_id       IN     NUMBER
                             ,                    -- pk of respective function
                              p_user_grp_id  IN OUT NUMBER
                             ,p_level_no     IN OUT NUMBER
                             ,p_appr_id      IN OUT NUMBER
                             ,p_response     IN     VARCHAR2
                             ,p_ar_status    IN     VARCHAR2
                             ,p_fwd_to       IN     NUMBER
                             ,p_table_name   IN     VARCHAR2
                             ,p_status_column IN    VARCHAR2
                             ,p_pk_column    IN     VARCHAR2
                             ,p_amount       IN     NUMBER
                             ,p_flow_status     OUT VARCHAR2
                             ,p_approver_name   OUT VARCHAR2
                             ,p_approver_email   OUT VARCHAR2
                             ,p_err_code        OUT VARCHAR2
                             ,p_err_msg         OUT VARCHAR2)
   IS
      l_flow_status  VARCHAR2 (100) := NULL;
      l_appr_id      NUMBER := p_appr_id;
      l_err_code     VARCHAR2 (100);
      l_err_msg      VARCHAR2 (100);
      l_status       VARCHAR2 (100);
      l_flow_with    NUMBER := NULL;
      l_flow_level   NUMBER := NULL;
      l_stmt         VARCHAR2 (5000);
      l_flow_to      NUMBER := p_fwd_to;
      l_user_grp_id  NUMBER;
      l_user_name    VARCHAR2 (100);
      l_user_emailid VARCHAR2 (100);
      l_p_ar_status  VARCHAR2 (100);
      l_p_fwd_to     NUMBER;
      l_flag         VARCHAR2 (10) := NULL;



      CURSOR c_approve_details
      IS
         SELECT user_name, user_email_id
           FROM xxfnd_user
          WHERE user_id = l_flow_with;
   BEGIN
      -- Dinesh
      IF (p_ar_status = 'APPROVE')
      THEN
         l_p_ar_status := 'A';
      ELSIF (p_ar_status = 'REJECT')
      THEN
         l_p_ar_status := 'R';
      END IF;



      p_err_code  := '0';
      p_err_msg   := 'Success';
      l_stmt      :=
            'update'
         || ' '
         || p_table_name
         || ' '
         || 'set '
         || p_status_column
         || ' = :1,flow_status = :2,flow_with = :3,flow_level = :4, user_grp_id = :5 where '
         || p_pk_column
         || '='
         || p_ref_id;
      update_response (p_func_id
                      ,p_ref_id
                      ,p_user_grp_id
                      ,p_level_no
                      ,l_appr_id
                      ,p_response
                      ,l_p_ar_status
                      ,p_fwd_to
                      ,l_flow_status
                      ,p_amount
                      ,l_err_code
                      ,l_err_msg);

      IF l_flow_status = 'A'
      THEN
         l_status    := 'APR';
         l_flow_status := NULL;
         l_flow_with := NULL;
         l_flow_level := NULL;
         l_user_grp_id := NULL;
         l_flag      := 'Y';
      ELSIF l_flow_status = 'R'
      THEN
         l_status    := 'REJ';
         l_flow_status := NULL;
         l_flow_with := NULL;
         l_flow_level := NULL;
         l_user_grp_id := NULL;
         l_flag      := NULL;
      ELSIF l_flow_status = 'F'
      THEN
         l_stmt      :=
               'update'
            || ' '
            || p_table_name
            || ' '
            || 'set flow_with = :1 where '
            || p_pk_column
            || '='
            || p_ref_id;
         l_flag      := NULL;
      ELSE
         l_status    := 'PEN';
         l_flow_with := l_appr_id;
         l_flow_level := p_level_no;
         l_user_grp_id := p_user_grp_id;
         l_flag      := NULL;
      END IF;

      IF l_flow_status = 'F'
      THEN
         EXECUTE IMMEDIATE l_stmt USING l_flow_to;

         l_flow_with := l_flow_to;
      ELSE
         EXECUTE IMMEDIATE l_stmt
            USING l_status
                 ,l_flow_status
                 ,l_flow_with
                 ,l_flow_level
                 ,l_user_grp_id;
      END IF;

      --COMMIT;

      --updation
      IF l_flag = 'Y'
      THEN
         xxpm_prism.xxpm_approval_upd_response (p_func_id
                                               ,p_ref_id
                                               ,p_table_name
                                               ,l_err_code
                                               ,l_err_msg);
      END IF;


      OPEN c_approve_details;

      FETCH c_approve_details
      INTO l_user_name, l_user_emailid;

      CLOSE c_approve_details;

      p_flow_status := l_status;
      p_level_no  := p_level_no;
      p_appr_id   := l_flow_with;
      p_approver_name := l_user_name;
      p_approver_email := l_user_emailid;
      p_user_grp_id := p_user_grp_id;


      IF (p_flow_status = 'APR')
      THEN
         p_level_no  := 0;
         p_appr_id   := 0;
         p_approver_name := 'A';
         p_approver_email := 'A';
      ELSIF (p_flow_status = 'REJ')
      THEN
         p_level_no  := 0;
         p_appr_id   := 0;
         p_approver_name := 'R';
         p_approver_email := 'R';
      END IF;
   -- -- REST conversion
   --APEX_JSON.open_object;
   --APEX_JSON.write('FlowStatus', p_flow_status);
   --APEX_JSON.write('LevelNo', p_level_no);
   --APEX_JSON.write('FlowWith', p_appr_id);
   --APEX_JSON.write('ApproverName', p_approver_name);
   --APEX_JSON.write('ApproverEmail', p_approver_email);
   --APEX_JSON.write('UserGroupId', p_user_grp_id);
   --APEX_JSON.close_object;

   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code  := '1';
         p_err_msg   := SUBSTR (SQLERRM, 1, 2000);
         DBMS_OUTPUT.put_line (
            'STAUS==>  ' || p_err_code || ' ' || p_err_msg);
   END update_response;
---------


END xxfnd_util_pkg;
