--------------------------------------------------------
--  DDL for Package XXFND_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXFND_PKG" is

--==============================================================================
--                             User Management Package 
--==============================================================================
--
-- file name    : xxfnd_pkh.sql
-- author       : navu k  - 4i apps
-- date         : 01-may-2018 
--
-- description : Package for User Management FND 
--
-- change record:
-- =============
-- version    date             author(s)           remarks
-- ========   ============     ===============     ============
-- ver1.0     01-may-2018      navu k              created
--
--==============================================================================

type apr_rec is record (level_no            number,
                        flow_status         varchar2(60),
                        appr_id             number,
                        appr_role           varchar2(30) ) ;

type apr_tab is table of apr_rec
     index by binary_integer ; 


function needs_approval(p_func_id        in          number,
                        p_ref_id         in          number, -- PK of respective function 
                        p_appr_id        in          number ) 
         return boolean ;
     
procedure get_next_number(p_func_code      in       varchar2,
                          p_next_num       out      varchar2,
                          p_func_id        out      number,
                          p_err_code       out      varchar2,
                          p_err_msg        out      varchar2 ) ;
                             

function get_profile_value(p_profile_name   in       varchar2) return varchar2 ;


function get_lookup_value(p_lookup_type   in       varchar2,
                          p_lookup_value  in       varchar2) return varchar2 ;



procedure insert_appr_hist(p_func_id        in          number,
                           p_ref_id         in          number, -- PK of respective function 
                           p_level_no       in          number,
                           p_appr_id        in          number,
                           p_appr_role      in          varchar2,
                           p_err_code       out         varchar2,
                           p_err_msg        out         varchar2 ) ;
                           
procedure update_appr_hist(p_func_id        in          number,
                          p_ref_id         in          number, -- PK of respective function 
                          p_level_no       in          number,
                          p_appr_id        in          number,
                          p_response       in          varchar2,
                          p_status         in          varchar2,
                          p_err_code       out         varchar2,
                          p_err_msg        out         varchar2 ) ;

procedure submit_for_approval(p_func_id        in          number,
                              p_ref_id         in          number, -- PK of respective function 
                              p_level_no       in out      number,
                              p_flow_status    out         varchar2,
                              p_appr_id        out         number,
                              p_err_code       out         varchar2,
                              p_err_msg        out         varchar2 )  ;
                              
procedure update_response(p_func_id        in          number,
                          p_ref_id         in          number, -- PK of respective function 
                          p_level_no       in out      number,
                          p_appr_id        in out      number,
                          p_response       in          varchar2,
                          p_status         in          varchar2,
                          p_fwd_to         in          number,
                          p_flow_status    out         varchar2,
                          p_err_code       out         varchar2,
                          p_err_msg        out         varchar2 ) ;                                                                                                
       
         
end xxfnd_pkg;



--------------------------------------------------------
--  DDL for Package Body XXFND_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXFND_PKG" is

--==============================================================================
--                            User Management Package 
--==============================================================================
--
-- file name    : xxfnd_pkb.sql
-- author       : navu k  - 4i apps
-- date         : 01-may-2018 
--
-- description : Package for User Management FND 
--
-- change record:
-- =============
-- version    date             author(s)           remarks
-- ========   ============     ===============     ============
-- ver1.0     01-may-2018      navu k              created
--
--==============================================================================




function needs_approval(p_func_id        in          number,
                        p_ref_id         in          number, -- PK of respective function 
                        p_appr_id        in          number ) 
         return boolean is

l_dummy number ;

cursor c1 is
    select 1
    from   xxfnd_func_approval_hist
    where  func_id          = p_func_id
    and    func_ref_id      = p_ref_id
    and    approver_id      = p_appr_id
    and    nvl(status, 'P') = 'P'
    and    action_date      is null ;

begin

    open  c1 ;
    fetch c1 into l_dummy ;
    if c1%found then
       close c1 ;
       return true ;
    else
       close c1 ;
       return false ;
    end if ;

exception
    when others  then
         return false ;
end needs_approval ;

------        


procedure insert_appr_hist(p_func_id        in          number,
                           p_ref_id         in          number, -- PK of respective function 
                           p_level_no       in          number,
                           p_appr_id        in          number,
                           p_appr_role      in          varchar2,
                           p_err_code       out         varchar2,
                           p_err_msg        out         varchar2 )  is
begin
  p_err_code     := '0';
  p_err_msg      := 'Success';
 
dbms_output.put_line('@insert_appr_hist: ') ;
     insert into xxfnd_func_approval_hist (
            appr_hist_id,  func_id,        func_ref_id,          seq_number,
            appr_role,     approver_id,    submission_date,      action_date,
            description,   status,         attribute_category,
            attribute1,    attribute2,     attribute3,           attribute4,
            attribute5,    attribute6,     attribute7,           attribute8,
            attribute9,    attribute10,
            created_by,    creation_date,  last_updated_by,      last_update_date,  last_update_login )
     values (
            xxfnd_appr_hist_id_s.nextval, p_func_id,   p_ref_id,  p_level_no,
            p_appr_role,                  p_appr_id,   sysdate,   null,
            null,                         'P',         null,
            null,                         null,        null,      null,
            null,                         null,        null,      null,
            null,                         null,        
            -1,                           sysdate,     -1,        sysdate,        -1 ) ;

dbms_output.put_line('@insert_appr_hist: p_func_id | p_ref_id |  p_level_no | p_appr_role | p_appr_id :' ||  
                       p_func_id ||' | '|| p_ref_id ||' | '||  p_level_no ||' | '|| p_appr_role ||' | '|| p_appr_id ) ;    
      
exception
  when others  then
     p_err_code := sqlcode;
     p_err_msg  := substr (sqlerrm, 1, 2000);
     dbms_output.put_line('@insert_appr_hist: exception  ' || p_err_msg) ;
     return;
end insert_appr_hist ;

------              

procedure update_appr_hist(p_func_id        in          number,
                          p_ref_id         in          number, -- PK of respective function 
                          p_level_no       in          number,
                          p_appr_id        in          number,
                          p_response       in          varchar2,
                          p_status         in          varchar2,
                          p_err_code       out         varchar2,
                          p_err_msg        out         varchar2 )  is
  
begin
  p_err_code     := '0';
  p_err_msg      := 'Success';
 

   if p_appr_id is null then

          -- Update all entries for that level...

           update xxfnd_func_approval_hist
           set    action_date         = sysdate,
                  description         = p_response,
                  status              = p_status,
                  last_updated_by     = -1,
                  last_update_date    = sysdate
           where  func_id             = p_func_id
           and    func_ref_id         = p_ref_id
           and    seq_number          = p_level_no ;      

   else

          -- Update only for particular approver 

           update xxfnd_func_approval_hist
           set    action_date         = sysdate,
                  description         = p_response,
                  status              = p_status,
                  last_updated_by     = -1,
                  last_update_date    = sysdate
           where  func_id             = p_func_id
           and    func_ref_id         = p_ref_id
           and    seq_number          = p_level_no
           and    approver_id         = p_appr_id ;  
           
   end if ;

dbms_output.put_line('@update_appr_hist: p_func_id | p_ref_id |  p_level_no | p_appr_id | p_response | p_status :' ||  
                       p_func_id ||' | '|| p_ref_id ||' | '||  p_level_no ||' | '|| p_appr_id ||' | '|| p_response ||' | '|| p_status ) ;    
      
      
exception
  when others  then
     p_err_code := sqlcode;
     p_err_msg  := substr (sqlerrm, 1, 2000);
     return;
end update_appr_hist ;

------              


procedure submit_for_approval(p_func_id        in          number,
                              p_ref_id         in          number, -- PK of respective function 
                              p_level_no       in out      number,
                              p_flow_status    out         varchar2,
                              p_appr_id        out         number,
                              p_err_code       out         varchar2,
                              p_err_msg        out         varchar2 )  is

--
-- This procedure has been shifted to XXFND_UTIL_PKG 
--


   
-- submit for approval
-- find  & get approver  
-- if yes, insert records in history 
--         send back level, appr id, flow sts
-- if no, send as approved...

l_level_no            number;
l_flow_status         varchar2(60) ;
l_appr_id             number;
l_appr_role           varchar2(30) ;

l_apr_tab             apr_tab ;

/***
cursor c1 is
  select  l.level_no, l.level_name, a.user_id, a.appr_role
  from    xxfnd_func_appr_levels l, xxfnd_func_approvals a
  where   l.func_id             = p_func_id
  and     nvl(l.active_yn, 'N') = 'Y' 
  and     l.level_no            = nvl(p_level_no, 0) + 1
  and     a.appr_level_id       = l.appr_level_id
  and     nvl(a.active_yn, 'N') = 'Y' 
  order by l.level_no ;
***/

begin
  p_err_code     := '0';
  p_err_msg      := 'Success';
--  p_level_no     := null ;
--  p_flow_status  := 'A' ;
--  p_appr_id      := null ;    


/***
--
-- This procedure has been shifted to XXFND_UTIL_PKG 
--

dbms_output.put_line('@submit_for_approval0: p_func_id | p_ref_id |  p_level_no | p_appr_id | p_flow_status :' ||  
                       p_func_id ||' | '|| p_ref_id ||' | '||  p_level_no ||' | '|| p_appr_id ||' | '|| p_flow_status ) ;

  -- Get Next Approver  
  --open  c1 ;
  --fetch c1 into l_level_no, l_flow_status, l_appr_id, l_appr_role ;
  --close c1 ;
  
  open  c1 ;
  fetch c1 bulk collect into l_apr_tab ;
  close c1 ;  
      
  if l_apr_tab.count > 0 then
  
      for l in l_apr_tab.first .. l_apr_tab.last
      loop

         l_level_no    := l_apr_tab(l).level_no ;
         l_flow_status := l_apr_tab(l).flow_status ;
         l_appr_id     := l_apr_tab(l).appr_id ;
         l_appr_role   := l_apr_tab(l).appr_role ;

dbms_output.put_line('@submit_for_approval1: p_func_id | p_ref_id |  l_level_no | l_appr_id | l_appr_role | l_flow_status :' ||  
                       p_func_id ||' | '|| p_ref_id ||' | '||  l_level_no ||' | '|| l_appr_id ||' | '|| l_appr_role ||' | '|| l_flow_status ) ;    
         
dbms_output.put_line('@submit_for_approval1a : l_level_no is not null ' || l_level_no) ;
         insert_appr_hist(p_func_id, p_ref_id, l_level_no, l_appr_id, l_appr_role, p_err_code, p_err_msg ) ;

         p_level_no       := l_level_no ;
         p_flow_status    := l_flow_status ;
         p_appr_id        := l_appr_id ;
            
      -- insert mailing procedure 
      
      end loop ;   
  else
dbms_output.put_line('@submit_for_approval1b : l_level_no is null ' || l_level_no) ;
     
     p_level_no       := null ;
     p_flow_status    := 'A' ;
     p_appr_id        := null ;    
        
  end if ;

dbms_output.put_line('@submit_for_approval2: p_func_id | p_ref_id |  p_level_no | p_appr_id | l_appr_role | p_flow_status :' ||  
                       p_func_id ||' | '|| p_ref_id ||' | '||  p_level_no ||' | '|| p_appr_id ||' | '|| l_appr_role ||' | '|| p_flow_status ) ;    
      
exception
  when others  then
     p_err_code := sqlcode;
     p_err_msg  := substr (sqlerrm, 1, 2000);
     return;

***/

end submit_for_approval ;

------              

procedure update_response(p_func_id        in          number,
                          p_ref_id         in          number, -- PK of respective function 
                          p_level_no       in out      number,
                          p_appr_id        in out      number,
                          p_response       in          varchar2,
                          p_status         in          varchar2,
                          p_fwd_to         in          number,
                          p_flow_status    out         varchar2,
                          p_err_code       out         varchar2,
                          p_err_msg        out         varchar2 )  is

--
-- This procedure has been shifted to XXFND_UTIL_PKG 
--



-- get response 
-- if approved, repeat steps till gets approved...
-- if rejected, stop the process
--              send back status
-- if change user, insert records in history
--              send back level, appr id, flow sts


l_level_no            number;
l_flow_status         varchar2(60) := null ;
l_appr_id             number;
l_appr_role           varchar2(30) ;
l_pending_yn          varchar2(1) ;
l_appr_by_all         varchar2(1) ;

/***
cursor c1 is
   select  l.appr_by_all
   from    xxfnd_func_appr_levels l 
   where   l.func_id             = p_func_id
   -- and     nvl(l.active_yn, 'N') = 'Y' 
   and     l.level_no            = nvl(p_level_no, 0) ;


cursor c2 is
   select  'Y'
   from    xxfnd_func_approval_hist
   where  func_id             = p_func_id
   and    func_ref_id         = p_ref_id
   and    seq_number          = p_level_no
   and    nvl(status,'P')     = 'P' ;
***/

begin
  p_err_code     := '0';
  p_err_msg      := 'Success';
 
/***
--
-- This procedure has been shifted to XXFND_UTIL_PKG 
--


  -- Check whether all approvals required or not 
  -- If not, update all as approved and move to next level
  -- If yes, check whether all approved or not 
  --         if all approved move to next level
  --         if not wait till all get approved

   open  c1 ;
   fetch c1 into l_appr_by_all ;
   close c1 ;

dbms_output.put_line('@update_response1: p_func_id | p_ref_id |  p_level_no | p_appr_id | l_appr_role | p_flow_status | p_response | p_status | p_fwd_to   :' ||  
                       p_func_id ||' | '|| p_ref_id ||' | '||  p_level_no ||' | '|| p_appr_id ||' | '|| l_appr_role ||' | '|| p_flow_status ||' | '|| 
                       p_response  ||' | '||  p_status  ||' | '||  p_fwd_to   ) ;    

   if p_status = 'R' then  -- Rejected 
dbms_output.put_line('@update_response2: p_status - Rejected') ;

        -- Update all as Rejected ...
        update_appr_hist(p_func_id, p_ref_id, p_level_no, null, p_response, p_status, p_err_code, p_err_msg ) ;

        p_flow_status := p_status ;
   
   elsif p_status = 'F' then  -- Forwarded To 
dbms_output.put_line('@update_response3: p_status - Forward') ;

        -- all approvals required
        update_appr_hist(p_func_id, p_ref_id, p_level_no, p_appr_id, p_response, p_status, p_err_code, p_err_msg ) ;

        insert_appr_hist(p_func_id, p_ref_id, p_level_no, p_fwd_to, l_appr_role, p_err_code, p_err_msg ) ;

        p_flow_status := p_status ;

     -- insert mailing procedure 
          
              
   else  -- Approved 
dbms_output.put_line('@update_response4: p_status - Approved') ;

dbms_output.put_line('@update_response5: l_appr_by_all ' || l_appr_by_all ) ;
   
       if nvl(l_appr_by_all, 'N') = 'N' then
           
          -- all approvals not required
          update_appr_hist(p_func_id, p_ref_id, p_level_no, null, p_response, p_status, p_err_code, p_err_msg ) ;

           -- move to next level 
           submit_for_approval(p_func_id, p_ref_id, p_level_no, l_flow_status, p_appr_id, p_err_code, p_err_msg ) ;
           
       else
dbms_output.put_line('@update_response5a: l_appr_by_all ' || l_appr_by_all ) ;
          -- all approvals required
          update_appr_hist(p_func_id, p_ref_id, p_level_no, p_appr_id, p_response, p_status, p_err_code, p_err_msg ) ;
               
           open  c2 ;
           fetch c2 into l_pending_yn ;
           close c2 ;

dbms_output.put_line('@update_response6: l_pending_yn ' || l_pending_yn ) ;
               
           if nvl(l_pending_yn, 'N') != 'Y' then
              -- all approved, move to next level 
              submit_for_approval(p_func_id, p_ref_id, p_level_no, l_flow_status, p_appr_id, p_err_code, p_err_msg ) ;
                  
           end if ;   
                
       end if ;

      p_flow_status := l_flow_status ;

   end if ;


dbms_output.put_line('@update_response7: l_flow_status ' || l_flow_status ) ;

exception
  when others  then
     p_err_code := sqlcode;
     p_err_msg  := substr (sqlerrm, 1, 2000);
     return;

***/ 

end update_response ;

------              

procedure get_next_number(p_func_code      in       varchar2,
                          p_next_num       out      varchar2,
                          p_func_id        out      number,
                          p_err_code       out      varchar2,
                          p_err_msg        out      varchar2 )  is
   
l_row_id    varchar2(100) ;
l_next_num  number ;
l_func_id  number ;
l_prefix    varchar2(10) ;
   
cursor c1 is
  select  rowid, decode(auto_number_yn, 'Y', next_number, null), decode(prefix, null, null, prefix || '-' ), func_id   
  from    xxfnd_functions
  where   func_short_code = p_func_code ;
   
begin
  p_err_code     := '0';
  p_err_msg      := 'Success';
  l_next_num     := null ;
  l_prefix       := null ;
  l_func_id      := null ;

  -- Get Next Number 
  open  c1 ;
  fetch c1 into l_row_id, l_next_num, l_prefix, l_func_id ;
  close c1 ;      
      
  if l_next_num is not null then
      -- Increment Next Number
      update  xxfnd_functions
      set     next_number = next_number + 1
      where   rowid    = l_row_id ;
          
      p_next_num := l_prefix || l_next_num ;
          
  else
      p_next_num := null ;
  end if ;
      
  p_func_id := l_func_id ;
      
  commit ;    
           
exception
  when others  then
     p_err_code := sqlcode;
     p_err_msg  := substr (sqlerrm, 1, 2000);
     return;
end get_next_number;

------                 

function get_profile_value(p_profile_name   in       varchar2) return varchar2  is

l_profile_value  varchar2(240) ;

cursor c1 is
  select  lookup_addl_value
  from    xxfnd_lookup_types t, xxfnd_lookup_values v
  where   t.lookup_type_name   = 'PROFILE_VALUES'
  and     t.lookup_type_id     = v.lookup_type_id
  and     v.lookup_value_name  = p_profile_name ;
   
begin

  open  c1 ;
  fetch c1 into l_profile_value ;
  close c1 ;      
      
  return l_profile_value ;
           
exception
  when others  then
       return null ;
       
end get_profile_value ;

------                 


function get_lookup_value(p_lookup_type   in       varchar2,
                          p_lookup_value  in       varchar2) return varchar2  is

l_lookup_value  varchar2(240) ;

cursor c1 is
  select  lookup_addl_value
  from    xxfnd_lookup_types t, xxfnd_lookup_values v
  where   t.lookup_type_name   = p_lookup_type
  and     t.lookup_type_id     = v.lookup_type_id
  and     v.lookup_value_name  = p_lookup_value ;
   
begin

  open  c1 ;
  fetch c1 into l_lookup_value ;
  close c1 ;      
      
  return l_lookup_value ;
           
exception
  when others  then
       return null ;
       
end get_lookup_value ;

 

end xxfnd_pkg;
