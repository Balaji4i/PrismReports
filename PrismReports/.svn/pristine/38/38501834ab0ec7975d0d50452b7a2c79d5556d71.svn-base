--------------------------------------------------------
--  DDL for Procedure XXPM_JS_UNIT_MASTER_VALIDATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_JS_UNIT_MASTER_VALIDATION" 
   (p_unit_number      IN       VARCHAR2,
    p_unit_shortcode   IN      VARCHAR2,
    p_unit_id          IN      number,
    p_err_msg          OUT      VARCHAR2)
IS
l_unitNumber_count number;
l_unitShortcode_count number;
l_old_unitNumber varchar2(60);
l_old_unitShortcode varchar2(60);
BEGIN
p_err_msg := '{';
if p_unit_id is null then
    select count(*) into l_unitNumber_count from xxpm_property_units where unit_number=p_unit_number;
    select count(*) into l_unitShortcode_count from xxpm_property_units where unit_shortcode=p_unit_shortcode;
else
    select unit_number into l_old_unitNumber from xxpm_property_units where unit_id=p_unit_id;
    select unit_shortcode into l_old_unitShortcode from xxpm_property_units where unit_id=p_unit_id;
    if(l_old_unitNumber <> p_unit_number) then
         select count(*) into l_unitNumber_count from xxpm_property_units where unit_number=p_unit_number;
    end if;
    if(l_old_unitShortcode <> p_unit_shortcode) then
        select count(*) into l_unitShortcode_count from xxpm_property_units where unit_shortcode=p_unit_shortcode;
    end if;
end if;
 if (l_unitNumber_count>0) then
    p_err_msg := p_err_msg || '"unitNumber":["Unit Number already exist"]';
    end if;
    if (l_unitShortcode_count>0) then 
    if(p_err_msg <> '{') then
    p_err_msg := p_err_msg || ',';
    end if;
    p_err_msg := p_err_msg || '"shortCode":["Unit Shortcode already exist"]';
    end if;
p_err_msg := p_err_msg || '}';
END xxpm_js_unit_master_validation;
