--------------------------------------------------------
--  DDL for Package XXFND_EMAIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "XXFND_EMAIL_PKG" is

--==============================================================================
--                             Email Package 
--==============================================================================
--
-- file name    : xxfnd_email_pkh.sql
-- author       : navu k  - 4i apps
-- date         : 01-may-2018 
--
-- description : Email Package   
--
-- change record:
-- =============
-- version    date             author(s)           remarks
-- ========   ============     ===============     ============
-- ver1.0     01-may-2018      navu k              created
--
--==============================================================================

procedure send (p_from        in     varchar2,
                p_to          in     varchar2,
                p_cc          in     varchar2 default null,
                p_bcc         in     varchar2 default null,
                p_replyto     in     varchar2 default null,
                p_body        in     varchar2,
                p_body_html   in     varchar2 default null,
                p_subject     in     varchar2 default null,
                p_id          in out number) ;

procedure attach ( p_id              in    number,
                   p_attachment      in    blob,
                   p_filename        in    varchar2,
                   p_mime_type       in    varchar2) ;

procedure push ;

procedure send (p_from        in     varchar2,
                p_to          in     varchar2,
                p_cc          in     varchar2 default null,
                p_bcc         in     varchar2 default null,
                p_replyto     in     varchar2 default null,
                p_body        in     varchar2,
                p_body_html   in     varchar2 default null,
                p_subject     in     varchar2 default null,
                p_attachment  in     blob,
                p_filename    in     varchar2,
                p_mime_type   in     varchar2,
                p_id          in out number ) ;
                                                                                                                                                      
end xxfnd_email_pkg;



--------------------------------------------------------
--  DDL for Package Body XXFND_EMAIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXFND_EMAIL_PKG" is

--==============================================================================
--                             Email Package 
--==============================================================================
--
-- file name    : xxfnd_email_pkb.sql
-- author       : navu k  - 4i apps
-- date         : 01-may-2018 
--
-- description : Email Package   
--
-- change record:
-- =============
-- version    date             author(s)           remarks
-- ========   ============     ===============     ============
-- ver1.0     01-may-2018      navu k              created
--
--==============================================================================


procedure initialize is
                                            
l_apex_ws_name       varchar2(240) ;
l_security_group_id  number ;

begin

   l_apex_ws_name := xxfnd_pkg.get_profile_value ( 'APEX_WS_NAME' ) ; 

   select apex_util.find_security_group_id (p_workspace => l_apex_ws_name)
   into   l_security_group_id
   from   dual;

   apex_util.set_security_group_id (p_security_group_id => l_security_group_id);
   
end initialize ;



procedure send (p_from        in     varchar2,
                p_to          in     varchar2,
                p_cc          in     varchar2 default null,
                p_bcc         in     varchar2 default null,
                p_replyto     in     varchar2 default null,
                p_body        in     varchar2,
                p_body_html   in     varchar2 default null,
                p_subject     in     varchar2 default null,
                p_id          in out number) is

l_id                 number ;

begin

   initialize ;
   
   l_id := apex_mail.send (p_from          => p_from,
                           p_to            => p_to,
                           p_cc            => p_cc,
                           p_bcc           => p_bcc,
                           p_replyto       => p_replyto,
                           p_body          => p_body,
                           p_body_html     => p_body_html,
                           p_subj          => p_subject );

    p_id := l_id ;

end send ;

procedure attach ( p_id              in    number,
                   p_attachment      in    blob,
                   p_filename        in    varchar2,
                   p_mime_type       in    varchar2) is

begin

   apex_mail.add_attachment (p_mail_id      => p_id,
                             p_attachment   => p_attachment, 
                             p_filename     => p_filename,
                             p_mime_type    => p_mime_type);
end ;

procedure push is

begin

   apex_mail.push_queue;

end ;

procedure send (p_from        in     varchar2,
                p_to          in     varchar2,
                p_cc          in     varchar2 default null,
                p_bcc         in     varchar2 default null,
                p_replyto     in     varchar2 default null,
                p_body        in     varchar2,
                p_body_html   in     varchar2 default null,
                p_subject     in     varchar2 default null,
                p_attachment  in     blob,
                p_filename    in     varchar2,
                p_mime_type   in     varchar2,
                p_id          in out number ) is
                                            
l_id                 number ;

begin

    send (p_from, p_to, p_cc, p_bcc, p_replyto, p_body, p_body_html, p_subject, p_id ) ;

    if p_attachment is  not null then
    
       attach ( p_id, p_attachment, p_filename, p_mime_type ) ;
    
    end if ;

    push ;

end send ;

end xxfnd_email_pkg;
