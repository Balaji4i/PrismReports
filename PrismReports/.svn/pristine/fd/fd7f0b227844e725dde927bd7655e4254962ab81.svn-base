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
