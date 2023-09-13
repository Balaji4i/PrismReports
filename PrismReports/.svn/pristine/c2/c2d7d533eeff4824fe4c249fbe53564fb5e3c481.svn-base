--------------------------------------------------------
--  DDL for Package Body XXPM_NOTIFICATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_NOTIFICATION" 
as

 PROCEDURE submit_mail( 
  p_from 				    IN VARCHAR2, 
	p_to 				      IN VARCHAR2, 
	
	p_err_code 			  OUT VARCHAR2, 
	p_err_msg 			  OUT VARCHAR2
  )
  IS
    l_from              VARCHAR2(240);
    l_body              VARCHAR2(240);
    l_body_html         VARCHAR2(32767);
    l_subject           VARCHAR2(240);
    l_to                VARCHAR2(240);
    l_security_group_id NUMBER;
    p_security_group_id NUMBER;
    l_sales_mgr_email   NUMBER;
    p_sales_mgr_email   VARCHAR2(240);
  BEGIN
    p_err_code  := '0';
    p_err_msg   := 'Success';
    l_from      := p_from;
    l_to        := p_to;
    --||'tvyshnaviswetha@gmail.com,dineshkumar.p@4iapps.com,dineshkmrp0@gmail.com,amitqt@gmail.com' ;
    dbms_output.put_line('l_to   '||l_to);




    l_body      := 'To view the content of this message, please use an HTML enabled mail client.' ;
    l_body_html :=
    'sudha' ; 
    l_subject := 'OMNIYAT_NOTIFICATION';
    SELECT apex_util.find_security_group_id (
      (SELECT apex_util.find_workspace(
        (SELECT apex_application.get_security_group_id FROM dual
        ))
      FROM dual
      ))
    INTO l_security_group_id
    FROM dual;
    /*
    select apex_util.find_security_group_id (p_workspace => 'BATNJKONMPLME') into l_security_group_id  from dual;
    apex_util.set_security_group_id (p_security_group_id => l_security_group_id);
    1516 apex_util.set_security_group_id (98183977190639809);*/
    apex_util.set_security_group_id(p_security_group_id => l_security_group_id );
    apex_mail.send (l_to,l_from,l_body,l_body_html,l_subject);
    apex_mail.push_queue(P_SMTP_HOSTNAME => '4iapps-com.mail.protection.outlook.com', P_SMTP_PORTNO => 25);
    --apex_mail.push_queue(P_SMTP_HOSTNAME => 'SMTP.office365.com', P_SMTP_PORTNO => 587);
    APEX_MAIL.PUSH_QUEUE;
    dbms_output.put_line('STAUS==>  ' || p_err_code ||' ' || p_err_msg ) ;
  EXCEPTION
  WHEN OTHERS THEN
    p_err_code := '1';
    p_err_msg  := 'Failed';

    end submit_mail;
  END xxpm_notification;
