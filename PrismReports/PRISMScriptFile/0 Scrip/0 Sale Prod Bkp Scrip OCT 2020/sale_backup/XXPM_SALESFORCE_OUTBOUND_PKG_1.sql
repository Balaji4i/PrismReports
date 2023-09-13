--------------------------------------------------------
--  DDL for Package Body XXPM_SALESFORCE_OUTBOUND_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXPM_SALESFORCE_OUTBOUND_PKG" IS

    PROCEDURE get_area_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT AREA_ID, PROPERTY_ID, BUILD_ID, UNIT_ID, AREA, UOM, VALUE, DESCRIPTION, ACTIVE_YN, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXPM_PROPERTY_AREA;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                area_id,
                property_id,
                build_id,
                unit_id,
                area,
                uom,
                value,
                description,
                active_yn,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_property_area
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'AREA_ID', p_value => rec.area_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_ID', p_value => rec.build_id, p_write_null => true);

            apex_json.write(p_name => 'UNIT_ID', p_value => rec.unit_id, p_write_null => true);

            apex_json.write(p_name => 'AREA', p_value => rec.area, p_write_null => true);

            apex_json.write(p_name => 'UOM', p_value => rec.uom, p_write_null => true);

            apex_json.write(p_name => 'VALUE', p_value => rec.value, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_area_details;

    PROCEDURE get_qualifiers_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT QLFY_ID ,QUALIFIERS ,OPERATOR ,QUALIFIER_FROM ,QUALIFIER_TO ,START_DATE ,END_DATE ,DESCRIPTION ,ACTIVE_YN ,REVISION_NO ,REVISION_DATE ,REVISED_BY ,CREATED_BY ,CREATION_DATE ,LAST_UPDATED_BY ,LAST_UPDATE_DATE LAST_UPDATE_LOGIN FROM XXPM_QUALIFIERS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                qlfy_id,
                qualifiers,
                operator,
                qualifier_from,
                qualifier_to,
                start_date,
                end_date,
                description,
                active_yn,
                revision_no,
                revision_date,
                revised_by,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_qualifiers
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'QLFY_ID', p_value => rec.qlfy_id, p_write_null => true);

            apex_json.write(p_name => 'QUALIFIERS', p_value => rec.qualifiers, p_write_null => true);

            apex_json.write(p_name => 'OPERATOR', p_value => rec.operator, p_write_null => true);

            apex_json.write(p_name => 'QUALIFIER_FROM', p_value => rec.qualifier_from, p_write_null => true);

            apex_json.write(p_name => 'QUALIFIER_TO', p_value => rec.qualifier_to, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_qualifiers_details;

    PROCEDURE get_modifiers_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT MOD_ID ,MOD_NAME ,MOD_NAME_TL ,MOD_LEVEL ,MOD_CATEGORY ,CHARGE_TYPE ,MOD_TYPE ,MOD_VALUE ,START_DATE ,END_DATE ,DESCRIPTION ,ACTIVE_YN ,REVISION_NO ,REVISION_DATE ,REVISED_BY ,CREATED_BY ,CREATION_DATE ,LAST_UPDATED_BY ,LAST_UPDATE_DATE LAST_UPDATE_LOGIN FROM XXPM_MODIFIERS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                mod_id,
                mod_name,
                mod_name_tl,
                mod_level,
                mod_category,
                charge_type,
                mod_type,
                mod_value,
                start_date,
                end_date,
                description,
                active_yn,
                revision_no,
                revision_date,
                revised_by,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_modifiers
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'MOD_LEVEL', p_value => rec.mod_level, p_write_null => true);

            apex_json.write(p_name => 'MOD_CATEGORY', p_value => rec.mod_category, p_write_null => true);

            apex_json.write(p_name => 'CHARGE_TYPE', p_value => rec.charge_type, p_write_null => true);

            apex_json.write(p_name => 'MOD_TYPE', p_value => rec.mod_type, p_write_null => true);

            apex_json.write(p_name => 'MOD_VALUE', p_value => rec.mod_value, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_modifiers_details;

    PROCEDURE get_fix_fittings_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT FIX_ID ,PROPERTY_ID ,BUILD_ID ,UNIT_ID ,FIX_CATEGORY ,DESCRIPTION ,FIX_CONDITION ,UOM ,VALUE ,ACTIVE_YN ,ATTRIBUTE_CATEGORY ,ATTRIBUTE1 ,ATTRIBUTE2 ,ATTRIBUTE3 ,ATTRIBUTE4 ,ATTRIBUTE5 ,ATTRIBUTE6 ,ATTRIBUTE7 ,ATTRIBUTE8 ,ATTRIBUTE9 ,ATTRIBUTE10 ,CREATED_BY ,CREATION_DATE ,LAST_UPDATED_BY ,LAST_UPDATE_DATE ,LAST_UPDATE_LOGIN ,QUANTITY ,RATE FROM XXPM_PROPERTY_FIX_FITTINGS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                fix_id,
                property_id,
                build_id,
                unit_id,
                fix_category,
                description,
                fix_condition,
                uom,
                value,
                active_yn,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                quantity,
                rate
            FROM
                xxpm_property_fix_fittings
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'FIX_ID', p_value => rec.fix_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_ID', p_value => rec.build_id, p_write_null => true);

            apex_json.write(p_name => 'UNIT_ID', p_value => rec.unit_id, p_write_null => true);

            apex_json.write(p_name => 'FIX_CATEGORY', p_value => rec.fix_category, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'FIX_CONDITION', p_value => rec.fix_condition, p_write_null => true);

            apex_json.write(p_name => 'UOM', p_value => rec.uom, p_write_null => true);

            apex_json.write(p_name => 'VALUE', p_value => rec.value, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'QUANTITY', p_value => rec.quantity, p_write_null => true);

            apex_json.write(p_name => 'RATE', p_value => rec.rate, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_fix_fittings_details;

    PROCEDURE get_property_buildings AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --   OPEN L_CURSOR FOR SELECT BUILD_ID ,PROPERTY_ID ,BUILD_NAME ,BUILD_NAME_TL ,BUILD_NUMBER ,BUILD_SHORTCODE ,PARENT_UNIT_ID ,BUILD_TYPE ,BUILD_CLASS ,BUILD_CATEGORY ,VEND_ID ,DESCRIPTION ,ACTIVE_YN ,FUNC_ID ,VAT_TYPE ,VAT_PERC ,ATTRIBUTE_CATEGORY ,ATTRIBUTE1 ,ATTRIBUTE2 ,ATTRIBUTE3 ,ATTRIBUTE4 ,ATTRIBUTE5 ,ATTRIBUTE6 ,ATTRIBUTE7 ,ATTRIBUTE8 ,ATTRIBUTE9 ,ATTRIBUTE10 ,CREATED_BY ,CREATION_DATE ,LAST_UPDATED_BY ,LAST_UPDATE_DATE ,LAST_UPDATE_LOGIN ,LOCATION_ID ,SALEABLE_YN ,LEASEABLE_YN ,SALE_AVAILABLE_YN ,LEASE_AVAILABLE_YN ,FREE_HOLD_YN ,LEASE_HOLD_YN ,LIST_FOR_BROKERS ,LIST_FOR_INTERNAL ,NO_OF_FLOORS FROM XXPM_PROPERTY_BUILDINGS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                build_id,
                property_id,
                build_name,
                build_name_tl,
                build_number,
                build_shortcode,
                parent_unit_id,
                build_type,
                build_class,
                build_category,
                vend_id,
                description,
                active_yn,
                func_id,
                vat_type,
                vat_perc,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                location_id,
                saleable_yn,
                leaseable_yn,
                sale_available_yn,
                lease_available_yn,
                free_hold_yn,
                lease_hold_yn,
                list_for_brokers,
                list_for_internal,
                no_of_floors
            FROM
                xxpm_property_buildings
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'BUILD_ID', p_value => rec.build_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_NAME', p_value => rec.build_name, p_write_null => true);

            apex_json.write(p_name => 'BUILD_NAME_TL', p_value => rec.build_name_tl, p_write_null => true);

            apex_json.write(p_name => 'BUILD_NUMBER', p_value => rec.build_number, p_write_null => true);

            apex_json.write(p_name => 'BUILD_SHORTCODE', p_value => rec.build_shortcode, p_write_null => true);

            apex_json.write(p_name => 'PARENT_UNIT_ID', p_value => rec.parent_unit_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_TYPE', p_value => rec.build_type, p_write_null => true);

            apex_json.write(p_name => 'BUILD_CLASS', p_value => rec.build_class, p_write_null => true);

            apex_json.write(p_name => 'BUILD_CATEGORY', p_value => rec.build_category, p_write_null => true);

            apex_json.write(p_name => 'VEND_ID', p_value => rec.vend_id, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'FUNC_ID', p_value => rec.func_id, p_write_null => true);

            apex_json.write(p_name => 'VAT_TYPE', p_value => rec.vat_type, p_write_null => true);

            apex_json.write(p_name => 'VAT_PERC', p_value => rec.vat_perc, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'LOCATION_ID', p_value => rec.location_id, p_write_null => true);

            apex_json.write(p_name => 'SALEABLE_YN', p_value => rec.saleable_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASEABLE_YN', p_value => rec.leaseable_yn, p_write_null => true);

            apex_json.write(p_name => 'SALE_AVAILABLE_YN', p_value => rec.sale_available_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASE_AVAILABLE_YN', p_value => rec.lease_available_yn, p_write_null => true);

            apex_json.write(p_name => 'FREE_HOLD_YN', p_value => rec.free_hold_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASE_HOLD_YN', p_value => rec.lease_hold_yn, p_write_null => true);

            apex_json.write(p_name => 'LIST_FOR_BROKERS', p_value => rec.list_for_brokers, p_write_null => true);

            apex_json.write(p_name => 'LIST_FOR_INTERNAL', p_value => rec.list_for_internal, p_write_null => true);

            apex_json.write(p_name => 'NO_OF_FLOORS', p_value => rec.no_of_floors, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_property_buildings;

    PROCEDURE get_organizations AS
        l_cursor   SYS_REFCURSOR;
        v_array    json_array_t := json_array_t();
        l_array    VARCHAR2(4000);
        l_obj      json_object_t;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT ORG_ID ,ORG_NAME ,ORG_NAME_TL ,SHORT_CODE ,LEGAL_ENTITY_ID ,LEDGER_ID ,LEDGER_NAME ,LEDGER_GL_CODE ,ORG_GL_CODE ,ORIG_SYSTEM_REF ,ACTIVE_YN ,CREATED_BY ,CREATION_DATE ,LAST_UPDATED_BY ,LAST_UPDATE_DATE ,LAST_UPDATE_LOGIN FROM XXSTG_ORGANIZATIONS;
    --    APEX_JSON.WRITE(L_CURSOR);
    --    apex_json.initialize_clob_output;
    --     apex_json.open_array();
        l_array := '[';
        FOR rec IN (
            SELECT
                TO_CHAR(org_id) org_id,
                org_name,
                org_name_tl,
                short_code,
                TO_CHAR(nvl(TO_CHAR(legal_entity_id), '')) legal_entity_id,
                ledger_id,
                ledger_name,
                ledger_gl_code,
                org_gl_code,
                orig_system_ref,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxstg_organizations
        ) LOOP
            l_obj := json_object_t('{ "ORG_ID" : '
                                   || rec.org_id
                                   || ',"SHORT_CODE":"'
                                   || rec.short_code
                                   || '"}');
      --     v_array.append(l_obj);

            l_array := l_array
                       || l_obj.to_string()
                       || ',';
      --      APEX_JSON.open_object;
      --     APEX_JSON.WRITE('{ "ORG_ID" : '|| rec.org_id||',"SHORT_CODE":"'||rec.short_code||'"}');
      --
      --      APEX_JSON.WRITE(p_name =>'ORG_ID',p_value => REC.ORG_ID ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'ORG_NAME',p_value => REC.ORG_NAME ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'ORG_NAME_TL',p_value => REC.ORG_NAME_TL ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'SHORT_CODE',p_value => REC.SHORT_CODE ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'LEGAL_ENTITY_ID',p_value => REC.LEGAL_ENTITY_ID ,p_write_null => true );
      --
      --     -- to_json.to_object(key_in =>'LEGAL_ENTITY_ID',value_in => REC.LEGAL_ENTITY_ID);
      --      APEX_JSON.WRITE(p_name =>'LEDGER_ID',p_value => REC.LEDGER_ID ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'LEDGER_NAME',p_value => REC.LEDGER_NAME ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'LEDGER_GL_CODE',p_value => REC.LEDGER_GL_CODE ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'ORG_GL_CODE',p_value => REC.ORG_GL_CODE ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'ORIG_SYSTEM_REF',p_value => REC.ORIG_SYSTEM_REF ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'ACTIVE_YN',p_value => REC.ACTIVE_YN ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'CREATED_BY',p_value => REC.CREATED_BY ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'CREATION_DATE',p_value => REC.CREATION_DATE ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'LAST_UPDATED_BY',p_value => REC.LAST_UPDATED_BY ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'LAST_UPDATE_DATE',p_value => REC.LAST_UPDATE_DATE ,p_write_null => true );
      --      APEX_JSON.WRITE(p_name =>'LAST_UPDATE_LOGIN',p_value => REC.LAST_UPDATE_LOGIN,p_write_null => true );
      --      APEX_JSON.close_object;
        END LOOP;
    --   apex_json.write(apex_escape.json(v_array.to_String()));

        l_array := substr(l_array, 0, length(l_array) - 1);
        l_array := l_array || ']';
        dbms_output.put_line(l_array);
        apex_json.open_object;
        apex_json.write('test', l_array);
        apex_json.close_object;
    --    apex_json.close_array();
    --     apex_json.write(apex_json.get_clob_output);
    --     apex_json.write(l_var);
    --    apex_json.free_output;
        -- due to db link commit;
    END get_organizations;

    PROCEDURE get_lookup_types AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT LOOKUP_TYPE_ID ,LOOKUP_TYPE_NAME ,LOOKUP_TYPE_NAME_DISP ,LOOKUP_TYPE_NAME_DISP_TL ,ACCESS_LEVEL ,ACTIVE_YN ,CREATED_BY ,CREATION_DATE ,LAST_UPDATED_BY ,LAST_UPDATE_DATE ,LAST_UPDATE_LOGIN ,PARENT_TYPE_ID FROM XXFND_LOOKUP_TYPES;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                lookup_type_id,
                lookup_type_name,
                lookup_type_name_disp,
                lookup_type_name_disp_tl,
                access_level,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                parent_type_id
            FROM
                xxfnd_lookup_types
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'LOOKUP_TYPE_ID', p_value => rec.lookup_type_id, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_TYPE_NAME', p_value => rec.lookup_type_name, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_TYPE_NAME_DISP', p_value => rec.lookup_type_name_disp, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_TYPE_NAME_DISP_TL', p_value => rec.lookup_type_name_disp_tl, p_write_null => true)

            ;

            apex_json.write(p_name => 'ACCESS_LEVEL', p_value => rec.access_level, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'PARENT_TYPE_ID', p_value => rec.parent_type_id, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_lookup_types;

    PROCEDURE get_lookup_values AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT LOOKUP_VALUE_ID, LOOKUP_TYPE_ID, LOOKUP_VALUE_NAME, LOOKUP_VALUE_NAME_DISP, LOOKUP_VALUE_NAME_DISP_TL, ACCESS_LEVEL, LOOKUP_ADDL_VALUE, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, PARENT_VALUE_ID FROM XXFND_LOOKUP_VALUES;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                lookup_value_id,
                lookup_type_id,
                lookup_value_name,
                lookup_value_name_disp,
                lookup_value_name_disp_tl,
                access_level,
                lookup_addl_value,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                parent_value_id
            FROM
                xxfnd_lookup_values
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'LOOKUP_VALUE_ID', p_value => rec.lookup_value_id, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_TYPE_ID', p_value => rec.lookup_type_id, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_VALUE_NAME', p_value => rec.lookup_value_name, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_VALUE_NAME_DISP', p_value => rec.lookup_value_name_disp, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_VALUE_NAME_DISP_TL', p_value => rec.lookup_value_name_disp_tl, p_write_null => true

            );

            apex_json.write(p_name => 'ACCESS_LEVEL', p_value => rec.access_level, p_write_null => true);

            apex_json.write(p_name => 'LOOKUP_ADDL_VALUE', p_value => rec.lookup_addl_value, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'PARENT_VALUE_ID', p_value => rec.parent_value_id, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_lookup_values;

    PROCEDURE get_milestone_dtl AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT MS_DTL_ID, MS_HDR_ID, SEQ_NUMBER, INSTALLMENT_TYPE, INSTALLMENT_PCT, CHARGE_TYPE, PAYMENT_TERM, REMARKS, DUE_DAYS, DUE_DAYS_FROM, PROJ_MS_ID, DUE_DATE, REVISION, REVISION_DATE, REVISED_BY, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, INSTALLMENT_METHOD, INSTALLMENT_EVENT, PERIOD_OCCURENCE, PERIOD_VALUES, PERIOD_DURATION FROM XXPM_MILESTONE_DTL;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                ms_dtl_id,
                ms_hdr_id,
                seq_number,
                installment_type,
                installment_pct,
                charge_type,
                payment_term,
                remarks,
                due_days,
                due_days_from,
                proj_ms_id,
                due_date,
                revision,
                revision_date,
                revised_by,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                installment_method,
                installment_event,
                period_occurence,
                period_values,
                period_duration
            FROM
                xxpm_milestone_dtl
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'MS_DTL_ID', p_value => rec.ms_dtl_id, p_write_null => true);

            apex_json.write(p_name => 'MS_HDR_ID', p_value => rec.ms_hdr_id, p_write_null => true);

            apex_json.write(p_name => 'SEQ_NUMBER', p_value => rec.seq_number, p_write_null => true);

            apex_json.write(p_name => 'INSTALLMENT_TYPE', p_value => rec.installment_type, p_write_null => true);

            apex_json.write(p_name => 'INSTALLMENT_PCT', p_value => rec.installment_pct, p_write_null => true);

            apex_json.write(p_name => 'CHARGE_TYPE', p_value => rec.charge_type, p_write_null => true);

            apex_json.write(p_name => 'PAYMENT_TERM', p_value => rec.payment_term, p_write_null => true);

            apex_json.write(p_name => 'REMARKS', p_value => rec.remarks, p_write_null => true);

            apex_json.write(p_name => 'DUE_DAYS', p_value => rec.due_days, p_write_null => true);

            apex_json.write(p_name => 'DUE_DAYS_FROM', p_value => rec.due_days_from, p_write_null => true);

            apex_json.write(p_name => 'PROJ_MS_ID', p_value => rec.proj_ms_id, p_write_null => true);

            apex_json.write(p_name => 'DUE_DATE', p_value => rec.due_date, p_write_null => true);

            apex_json.write(p_name => 'REVISION', p_value => rec.revision, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'INSTALLMENT_METHOD', p_value => rec.installment_method, p_write_null => true);

            apex_json.write(p_name => 'INSTALLMENT_EVENT', p_value => rec.installment_event, p_write_null => true);

            apex_json.write(p_name => 'PERIOD_OCCURENCE', p_value => rec.period_occurence, p_write_null => true);

            apex_json.write(p_name => 'PERIOD_VALUES', p_value => rec.period_values, p_write_null => true);

            apex_json.write(p_name => 'PERIOD_DURATION', p_value => rec.period_duration, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_milestone_dtl;

    PROCEDURE get_property_master_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT PROPERTY_ID, PROPERTY_NAME, PROPERTY_NAME_TL, PROPERTY_NUMBER, PROPERTY_SHORTCODE, FUNC_ID, ORG_ID, PROJECT_ID, COST_CENTER_CODE, LOCATION_ID, PARCEL_TYPE, PROPERTY_TYPE, NO_OF_UNITS, PARENT_PROPERTY_ID, PROPERTY_CLASS, PROPERTY_CATEGORY, VEND_ID, DESCRIPTION, ACTIVE_YN, SALEABLE_YN, LEASEABLE_YN, SALE_AVAILABLE_YN, LEASE_AVAILABLE_YN, FREE_HOLD_YN, LEASE_HOLD_YN, LIST_FOR_BROKERS, LIST_FOR_INTERNAL, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXPM_PROPERTY_MASTER;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                property_id,
                property_name,
                property_name_tl,
                property_number,
                property_shortcode,
                func_id,
                org_id,
                project_id,
                cost_center_code,
                location_id,
                parcel_type,
                property_type,
                no_of_units,
                parent_property_id,
                property_class,
                property_category,
                vend_id,
                description,
                active_yn,
                saleable_yn,
                leaseable_yn,
                sale_available_yn,
                lease_available_yn,
                free_hold_yn,
                lease_hold_yn,
                list_for_brokers,
                list_for_internal,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_property_master
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_NAME', p_value => rec.property_name, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_NAME_TL', p_value => rec.property_name_tl, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_NUMBER', p_value => rec.property_number, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_SHORTCODE', p_value => rec.property_shortcode, p_write_null => true);

            apex_json.write(p_name => 'FUNC_ID', p_value => rec.func_id, p_write_null => true);

            apex_json.write(p_name => 'ORG_ID', p_value => rec.org_id, p_write_null => true);

            apex_json.write(p_name => 'PROJECT_ID', p_value => rec.project_id, p_write_null => true);

            apex_json.write(p_name => 'COST_CENTER_CODE', p_value => rec.cost_center_code, p_write_null => true);

            apex_json.write(p_name => 'LOCATION_ID', p_value => rec.location_id, p_write_null => true);

            apex_json.write(p_name => 'PARCEL_TYPE', p_value => rec.parcel_type, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_TYPE', p_value => rec.property_type, p_write_null => true);

            apex_json.write(p_name => 'NO_OF_UNITS', p_value => rec.no_of_units, p_write_null => true);

            apex_json.write(p_name => 'PARENT_PROPERTY_ID', p_value => rec.parent_property_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_CLASS', p_value => rec.property_class, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_CATEGORY', p_value => rec.property_category, p_write_null => true);

            apex_json.write(p_name => 'VEND_ID', p_value => rec.vend_id, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'SALEABLE_YN', p_value => rec.saleable_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASEABLE_YN', p_value => rec.leaseable_yn, p_write_null => true);

            apex_json.write(p_name => 'SALE_AVAILABLE_YN', p_value => rec.sale_available_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASE_AVAILABLE_YN', p_value => rec.lease_available_yn, p_write_null => true);

            apex_json.write(p_name => 'FREE_HOLD_YN', p_value => rec.free_hold_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASE_HOLD_YN', p_value => rec.lease_hold_yn, p_write_null => true);

            apex_json.write(p_name => 'LIST_FOR_BROKERS', p_value => rec.list_for_brokers, p_write_null => true);

            apex_json.write(p_name => 'LIST_FOR_INTERNAL', p_value => rec.list_for_internal, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_property_master_details;

    PROCEDURE get_projects_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT PROJ_ID, PROJECT_NAME, PROJECT_NUMBER, ORG_ID, START_DATE, COMPLETION_DATE, CLOSED_DATE, COST_CENTER_CODE, ORIG_SYSTEM_REF, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXSTG_PROJECTS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                proj_id,
                project_name,
                project_number,
                org_id,
                start_date,
                completion_date,
                closed_date,
                cost_center_code,
                orig_system_ref,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxstg_projects
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PROJ_ID', p_value => rec.proj_id, p_write_null => true);

            apex_json.write(p_name => 'PROJECT_NAME', p_value => rec.project_name, p_write_null => true);

            apex_json.write(p_name => 'PROJECT_NUMBER', p_value => rec.project_number, p_write_null => true);

            apex_json.write(p_name => 'ORG_ID', p_value => rec.org_id, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'COMPLETION_DATE', p_value => rec.completion_date, p_write_null => true);

            apex_json.write(p_name => 'CLOSED_DATE', p_value => rec.closed_date, p_write_null => true);

            apex_json.write(p_name => 'COST_CENTER_CODE', p_value => rec.cost_center_code, p_write_null => true);

            apex_json.write(p_name => 'ORIG_SYSTEM_REF', p_value => rec.orig_system_ref, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_projects_details;

    PROCEDURE get_project_milestones_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT PROJ_MS_ID, PROJ_ID, MS_NAME, START_DATE, COMPLETION_DATE, ORIG_SYSTEM_REF, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXSTG_PROJECT_MILESTONES;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                proj_ms_id,
                proj_id,
                ms_name,
                start_date,
                completion_date,
                orig_system_ref,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxstg_project_milestones
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PROJ_MS_ID', p_value => rec.proj_ms_id, p_write_null => true);

            apex_json.write(p_name => 'PROJ_ID', p_value => rec.proj_id, p_write_null => true);

            apex_json.write(p_name => 'MS_NAME', p_value => rec.ms_name, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'COMPLETION_DATE', p_value => rec.completion_date, p_write_null => true);

            apex_json.write(p_name => 'ORIG_SYSTEM_REF', p_value => rec.orig_system_ref, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_project_milestones_details;

    PROCEDURE get_pl_qualifiers_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --   OPEN L_CURSOR FOR SELECT PL_QLFY_ID, PL_MOD_ID, QLFY_ID, START_DATE, END_DATE, REVISION_NO, REVISION_DATE, REVISED_BY, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXPM_PL_QUALIFIERS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                pl_qlfy_id,
                pl_mod_id,
                qlfy_id,
                start_date,
                end_date,
                revision_no,
                revision_date,
                revised_by,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_pl_qualifiers
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PL_QLFY_ID', p_value => rec.pl_qlfy_id, p_write_null => true);

            apex_json.write(p_name => 'PL_MOD_ID', p_value => rec.pl_mod_id, p_write_null => true);

            apex_json.write(p_name => 'QLFY_ID', p_value => rec.qlfy_id, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_pl_qualifiers_details;

    PROCEDURE get_pl_modifiers_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --   OPEN L_CURSOR FOR SELECT PL_MOD_ID, PL_ID, MOD_ID, START_DATE, END_DATE, REVISION_NO, REVISION_DATE, REVISED_BY, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXPM_PL_MODIFIERS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                pl_mod_id,
                pl_id,
                mod_id,
                start_date,
                end_date,
                revision_no,
                revision_date,
                revised_by,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_pl_modifiers
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PL_MOD_ID', p_value => rec.pl_mod_id, p_write_null => true);

            apex_json.write(p_name => 'PL_ID', p_value => rec.pl_id, p_write_null => true);

            apex_json.write(p_name => 'MOD_ID', p_value => rec.mod_id, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_pl_modifiers_details;

    PROCEDURE get_pl_lines_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT PLL_ID, PL_ID, PROPERTY_ID, BUILD_ID, UNIT_ID, UOM, BASE_PRICE, MIN_PRICE, START_DATE, END_DATE, REVISION_NO, REVISION_DATE, REVISED_BY, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXPM_PL_LINES;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                pll_id,
                pl_id,
                property_id,
                build_id,
                unit_id,
                uom,
                base_price,
                min_price,
                start_date,
                end_date,
                revision_no,
                revision_date,
                revised_by,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_pl_lines
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PLL_ID', p_value => rec.pll_id, p_write_null => true);

            apex_json.write(p_name => 'PL_ID', p_value => rec.pl_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_ID', p_value => rec.build_id, p_write_null => true);

            apex_json.write(p_name => 'UNIT_ID', p_value => rec.unit_id, p_write_null => true);

            apex_json.write(p_name => 'UOM', p_value => rec.uom, p_write_null => true);

            apex_json.write(p_name => 'BASE_PRICE', p_value => rec.base_price, p_write_null => true);

            apex_json.write(p_name => 'MIN_PRICE', p_value => rec.min_price, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_pl_lines_details;

    PROCEDURE get_pl_header_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --   OPEN L_CURSOR FOR SELECT PL_ID, PL_NAME, PL_NAME_TL, DESCRIPTION, ORG_ID, FUNC_ID, PL_TYPE, PRIORITY, USAGE, CURRENCY_CODE, START_DATE, END_DATE, REVISION_NO, REVISION_DATE, REVISED_BY, STATUS, FLOW_STATUS, FLOW_WITH, FLOW_LEVEL, USER_GRP_ID, BASE_PRICE_YN, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, PL_NUMBER FROM XXPM_PL_HEADER;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                pl_id,
                pl_name,
                pl_name_tl,
                description,
                org_id,
                func_id,
                pl_type,
                priority,
                usage,
                currency_code,
                start_date,
                end_date,
                revision_no,
                revision_date,
                revised_by,
                status,
                flow_status,
                flow_with,
                flow_level,
                user_grp_id,
                base_price_yn,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                pl_number
            FROM
                xxpm_pl_header
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'PL_ID', p_value => rec.pl_id, p_write_null => true);

            apex_json.write(p_name => 'PL_NAME', p_value => rec.pl_name, p_write_null => true);

            apex_json.write(p_name => 'PL_NAME_TL', p_value => rec.pl_name_tl, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ORG_ID', p_value => rec.org_id, p_write_null => true);

            apex_json.write(p_name => 'FUNC_ID', p_value => rec.func_id, p_write_null => true);

            apex_json.write(p_name => 'PL_TYPE', p_value => rec.pl_type, p_write_null => true);

            apex_json.write(p_name => 'PRIORITY', p_value => rec.priority, p_write_null => true);

            apex_json.write(p_name => 'USAGE', p_value => rec.usage, p_write_null => true);

            apex_json.write(p_name => 'CURRENCY_CODE', p_value => rec.currency_code, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'STATUS', p_value => rec.status, p_write_null => true);

            apex_json.write(p_name => 'FLOW_STATUS', p_value => rec.flow_status, p_write_null => true);

            apex_json.write(p_name => 'FLOW_WITH', p_value => rec.flow_with, p_write_null => true);

            apex_json.write(p_name => 'FLOW_LEVEL', p_value => rec.flow_level, p_write_null => true);

            apex_json.write(p_name => 'USER_GRP_ID', p_value => rec.user_grp_id, p_write_null => true);

            apex_json.write(p_name => 'BASE_PRICE_YN', p_value => rec.base_price_yn, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'PL_NUMBER', p_value => rec.pl_number, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_pl_header_details;

    PROCEDURE get_pay_terms_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT TERM_ID, TERM_NAME, TERM_DAYS, ORIG_SYSTEM_REF, ACTIVE_YN, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXSTG_PAY_TERMS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                term_id,
                term_name,
                term_days,
                orig_system_ref,
                active_yn,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxstg_pay_terms
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'TERM_ID', p_value => rec.term_id, p_write_null => true);

            apex_json.write(p_name => 'TERM_NAME', p_value => rec.term_name, p_write_null => true);

            apex_json.write(p_name => 'TERM_DAYS', p_value => rec.term_days, p_write_null => true);

            apex_json.write(p_name => 'ORIG_SYSTEM_REF', p_value => rec.orig_system_ref, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_pay_terms_details;

    PROCEDURE get_milestone_hdr_details AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT MS_HDR_ID, MILESTONE_NAME, MILESTONE_NAME_TL, MILESTONE_NUMBER, MILESTONE_SHORTCODE, MILESTONE_DATE, FUNC_ID, ORG_ID, PROJECT_ID, MILESTONE_TYPE, USAGE, REVISION_NO, REVISION_DATE, REVISED_BY, DESCRIPTION, START_DATE, END_DATE, ACTIVE_YN, STATUS, FLOW_STATUS, FLOW_LEVEL, FLOW_WITH, USER_GRP_ID, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN FROM XXPM_MILESTONE_HDR;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                ms_hdr_id,
                milestone_name,
                milestone_name_tl,
                milestone_number,
                milestone_shortcode,
                milestone_date,
                func_id,
                org_id,
                project_id,
                milestone_type,
                usage,
                revision_no,
                revision_date,
                revised_by,
                description,
                start_date,
                end_date,
                active_yn,
                status,
                flow_status,
                flow_level,
                flow_with,
                user_grp_id,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login
            FROM
                xxpm_milestone_hdr
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'MS_HDR_ID', p_value => rec.ms_hdr_id, p_write_null => true);

            apex_json.write(p_name => 'MILESTONE_NAME', p_value => rec.milestone_name, p_write_null => true);

            apex_json.write(p_name => 'MILESTONE_NAME_TL', p_value => rec.milestone_name_tl, p_write_null => true);

            apex_json.write(p_name => 'MILESTONE_NUMBER', p_value => rec.milestone_number, p_write_null => true);

            apex_json.write(p_name => 'MILESTONE_SHORTCODE', p_value => rec.milestone_shortcode, p_write_null => true);

            apex_json.write(p_name => 'MILESTONE_DATE', p_value => rec.milestone_date, p_write_null => true);

            apex_json.write(p_name => 'FUNC_ID', p_value => rec.func_id, p_write_null => true);

            apex_json.write(p_name => 'ORG_ID', p_value => rec.org_id, p_write_null => true);

            apex_json.write(p_name => 'PROJECT_ID', p_value => rec.project_id, p_write_null => true);

            apex_json.write(p_name => 'MILESTONE_TYPE', p_value => rec.milestone_type, p_write_null => true);

            apex_json.write(p_name => 'USAGE', p_value => rec.usage, p_write_null => true);

            apex_json.write(p_name => 'REVISION_NO', p_value => rec.revision_no, p_write_null => true);

            apex_json.write(p_name => 'REVISION_DATE', p_value => rec.revision_date, p_write_null => true);

            apex_json.write(p_name => 'REVISED_BY', p_value => rec.revised_by, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'START_DATE', p_value => rec.start_date, p_write_null => true);

            apex_json.write(p_name => 'END_DATE', p_value => rec.end_date, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'STATUS', p_value => rec.status, p_write_null => true);

            apex_json.write(p_name => 'FLOW_STATUS', p_value => rec.flow_status, p_write_null => true);

            apex_json.write(p_name => 'FLOW_LEVEL', p_value => rec.flow_level, p_write_null => true);

            apex_json.write(p_name => 'FLOW_WITH', p_value => rec.flow_with, p_write_null => true);

            apex_json.write(p_name => 'USER_GRP_ID', p_value => rec.user_grp_id, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_milestone_hdr_details;

    PROCEDURE get_property_features AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT FEATURE_ID, PROPERTY_ID, BUILD_ID, UNIT_ID, FEATURE_TYPE, DESCRIPTION, FEATURE_CONDITION, UOM, VALUE, ACTIVE_YN, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, QUANTITY, RATE FROM XXPM_PROPERTY_FEATURES;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                feature_id,
                property_id,
                build_id,
                unit_id,
                feature_type,
                description,
                feature_condition,
                uom,
                value,
                active_yn,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                quantity,
                rate
            FROM
                xxpm_property_features
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'FEATURE_ID', p_value => rec.feature_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_ID', p_value => rec.build_id, p_write_null => true);

            apex_json.write(p_name => 'UNIT_ID', p_value => rec.unit_id, p_write_null => true);

            apex_json.write(p_name => 'FEATURE_TYPE', p_value => rec.feature_type, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'FEATURE_CONDITION', p_value => rec.feature_condition, p_write_null => true);

            apex_json.write(p_name => 'UOM', p_value => rec.uom, p_write_null => true);

            apex_json.write(p_name => 'VALUE', p_value => rec.value, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'QUANTITY', p_value => rec.quantity, p_write_null => true);

            apex_json.write(p_name => 'RATE', p_value => rec.rate, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_property_features;

    PROCEDURE get_property_units AS
        l_cursor SYS_REFCURSOR;
    BEGIN
    --    OPEN L_CURSOR FOR SELECT UNIT_ID, PROPERTY_ID, BUILD_ID, UNIT_NAME, UNIT_NAME_TL, UNIT_NUMBER, UNIT_SHORTCODE, FUNC_ID, ORG_ID, PARENT_UNIT_ID, DOC_REF_NUMBER_1, DOC_REF_NUMBER_2, DOC_REF_NUMBER_3, FLOOR_NUMBER, NO_OF_ROOMS, UNIT_TYPE, AREA_TYPE, VIEW_TYPE, CHARGEABLE_AREA, UOM, CURRENCY_CODE, BASE_RATE, PREMIUM_RATE_1, PREMIUM_RATE_TYPE_1, PREMIUM_RATE_2, PREMIUM_RATE_TYPE_2, PREMIUM_RATE_3, PREMIUM_RATE_TYPE_3, PREMIUM_RATE_4, PREMIUM_RATE_TYPE_4, PREMIUM_RATE_5, PREMIUM_RATE_TYPE_5, TOTAL_RATE, PURCHASE_AMOUNT, STATUS, UNIT_CLASS, UNIT_CATEGORY, VEND_ID, DESCRIPTION, ACTIVE_YN, VAT_TYPE, VAT_PERC, VAT_AMOUNT, ATTRIBUTE_CATEGORY, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, ATTRIBUTE10, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, SALEABLE_YN, LEASEABLE_YN, SALE_AVAILABLE_YN, LEASE_AVAILABLE_YN, FREE_HOLD_YN, LEASE_HOLD_YN, LIST_FOR_BROKERS, LIST_FOR_INTERNAL, ALLOT_TYPE
    -- FROM
    --    XXPM_PROPERTY_UNITS;
    --    APEX_JSON.WRITE(L_CURSOR);
        apex_json.open_array();
        FOR rec IN (
            SELECT
                unit_id,
                property_id,
                build_id,
                unit_name,
                unit_name_tl,
                unit_number,
                unit_shortcode,
                func_id,
                org_id,
                parent_unit_id,
                doc_ref_number_1,
                doc_ref_number_2,
                doc_ref_number_3,
                floor_number,
                no_of_rooms,
                unit_type,
                area_type,
                view_type,
                chargeable_area,
                uom,
                currency_code,
                base_rate,
                premium_rate_1,
                premium_rate_type_1,
                premium_rate_2,
                premium_rate_type_2,
                premium_rate_3,
                premium_rate_type_3,
                premium_rate_4,
                premium_rate_type_4,
                premium_rate_5,
                premium_rate_type_5,
                total_rate,
                purchase_amount,
                status,
                unit_class,
                unit_category,
                vend_id,
                description,
                active_yn,
                vat_type,
                vat_perc,
                vat_amount,
                attribute_category,
                attribute1,
                attribute2,
                attribute3,
                attribute4,
                attribute5,
                attribute6,
                attribute7,
                attribute8,
                attribute9,
                attribute10,
                created_by,
                creation_date,
                last_updated_by,
                last_update_date,
                last_update_login,
                saleable_yn,
                leaseable_yn,
                sale_available_yn,
                lease_available_yn,
                free_hold_yn,
                lease_hold_yn,
                list_for_brokers,
                list_for_internal,
                allot_type
            FROM
                xxpm_property_units
        ) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'UNIT_ID', p_value => rec.unit_id, p_write_null => true);

            apex_json.write(p_name => 'PROPERTY_ID', p_value => rec.property_id, p_write_null => true);

            apex_json.write(p_name => 'BUILD_ID', p_value => rec.build_id, p_write_null => true);

            apex_json.write(p_name => 'UNIT_NAME', p_value => rec.unit_name, p_write_null => true);

            apex_json.write(p_name => 'UNIT_NAME_TL', p_value => rec.unit_name_tl, p_write_null => true);

            apex_json.write(p_name => 'UNIT_NUMBER', p_value => rec.unit_number, p_write_null => true);

            apex_json.write(p_name => 'UNIT_SHORTCODE', p_value => rec.unit_shortcode, p_write_null => true);

            apex_json.write(p_name => 'FUNC_ID', p_value => rec.func_id, p_write_null => true);

            apex_json.write(p_name => 'ORG_ID', p_value => rec.org_id, p_write_null => true);

            apex_json.write(p_name => 'PARENT_UNIT_ID', p_value => rec.parent_unit_id, p_write_null => true);

            apex_json.write(p_name => 'DOC_REF_NUMBER_1', p_value => rec.doc_ref_number_1, p_write_null => true);

            apex_json.write(p_name => 'DOC_REF_NUMBER_2', p_value => rec.doc_ref_number_2, p_write_null => true);

            apex_json.write(p_name => 'DOC_REF_NUMBER_3', p_value => rec.doc_ref_number_3, p_write_null => true);

            apex_json.write(p_name => 'FLOOR_NUMBER', p_value => rec.floor_number, p_write_null => true);

            apex_json.write(p_name => 'NO_OF_ROOMS', p_value => rec.no_of_rooms, p_write_null => true);

            apex_json.write(p_name => 'UNIT_TYPE', p_value => rec.unit_type, p_write_null => true);

            apex_json.write(p_name => 'AREA_TYPE', p_value => rec.area_type, p_write_null => true);

            apex_json.write(p_name => 'VIEW_TYPE', p_value => rec.view_type, p_write_null => true);

            apex_json.write(p_name => 'CHARGEABLE_AREA', p_value => rec.chargeable_area, p_write_null => true);

            apex_json.write(p_name => 'UOM', p_value => rec.uom, p_write_null => true);

            apex_json.write(p_name => 'CURRENCY_CODE', p_value => rec.currency_code, p_write_null => true);

            apex_json.write(p_name => 'BASE_RATE', p_value => rec.base_rate, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_1', p_value => rec.premium_rate_1, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_TYPE_1', p_value => rec.premium_rate_type_1, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_2', p_value => rec.premium_rate_2, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_TYPE_2', p_value => rec.premium_rate_type_2, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_3', p_value => rec.premium_rate_3, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_TYPE_3', p_value => rec.premium_rate_type_3, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_4', p_value => rec.premium_rate_4, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_TYPE_4', p_value => rec.premium_rate_type_4, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_5', p_value => rec.premium_rate_5, p_write_null => true);

            apex_json.write(p_name => 'PREMIUM_RATE_TYPE_5', p_value => rec.premium_rate_type_5, p_write_null => true);

            apex_json.write(p_name => 'TOTAL_RATE', p_value => rec.total_rate, p_write_null => true);

            apex_json.write(p_name => 'PURCHASE_AMOUNT', p_value => rec.purchase_amount, p_write_null => true);

            apex_json.write(p_name => 'STATUS', p_value => rec.status, p_write_null => true);

            apex_json.write(p_name => 'UNIT_CLASS', p_value => rec.unit_class, p_write_null => true);

            apex_json.write(p_name => 'UNIT_CATEGORY', p_value => rec.unit_category, p_write_null => true);

            apex_json.write(p_name => 'VEND_ID', p_value => rec.vend_id, p_write_null => true);

            apex_json.write(p_name => 'DESCRIPTION', p_value => rec.description, p_write_null => true);

            apex_json.write(p_name => 'ACTIVE_YN', p_value => rec.active_yn, p_write_null => true);

            apex_json.write(p_name => 'VAT_TYPE', p_value => rec.vat_type, p_write_null => true);

            apex_json.write(p_name => 'VAT_PERC', p_value => rec.vat_perc, p_write_null => true);

            apex_json.write(p_name => 'VAT_AMOUNT', p_value => rec.vat_amount, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE_CATEGORY', p_value => rec.attribute_category, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE1', p_value => rec.attribute1, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE2', p_value => rec.attribute2, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE3', p_value => rec.attribute3, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE4', p_value => rec.attribute4, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE5', p_value => rec.attribute5, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE6', p_value => rec.attribute6, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE7', p_value => rec.attribute7, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE8', p_value => rec.attribute8, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE9', p_value => rec.attribute9, p_write_null => true);

            apex_json.write(p_name => 'ATTRIBUTE10', p_value => rec.attribute10, p_write_null => true);

            apex_json.write(p_name => 'CREATED_BY', p_value => rec.created_by, p_write_null => true);

            apex_json.write(p_name => 'CREATION_DATE', p_value => rec.creation_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATED_BY', p_value => rec.last_updated_by, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_DATE', p_value => rec.last_update_date, p_write_null => true);

            apex_json.write(p_name => 'LAST_UPDATE_LOGIN', p_value => rec.last_update_login, p_write_null => true);

            apex_json.write(p_name => 'SALEABLE_YN', p_value => rec.saleable_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASEABLE_YN', p_value => rec.leaseable_yn, p_write_null => true);

            apex_json.write(p_name => 'SALE_AVAILABLE_YN', p_value => rec.sale_available_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASE_AVAILABLE_YN', p_value => rec.lease_available_yn, p_write_null => true);

            apex_json.write(p_name => 'FREE_HOLD_YN', p_value => rec.free_hold_yn, p_write_null => true);

            apex_json.write(p_name => 'LEASE_HOLD_YN', p_value => rec.lease_hold_yn, p_write_null => true);

            apex_json.write(p_name => 'LIST_FOR_BROKERS', p_value => rec.list_for_brokers, p_write_null => true);

            apex_json.write(p_name => 'LIST_FOR_INTERNAL', p_value => rec.list_for_internal, p_write_null => true);

            apex_json.write(p_name => 'ALLOT_TYPE', p_value => rec.allot_type, p_write_null => true);

            apex_json.close_object;
        END LOOP;

        apex_json.close_array();
        -- due to db link commit;
    END get_property_units;

    PROCEDURE offer_hdr (
        p_offer_hdr_id             IN                         NUMBER,
        p_org_id                   IN                         VARCHAR2,
        p_func_id                  IN                         VARCHAR2,
        p_offer_number             IN                         VARCHAR2,
        p_offer_date               IN                         VARCHAR2,
        p_offer_from_date          IN                         VARCHAR2,
        p_offer_to_date            IN                         VARCHAR2,
        p_performed_by             IN                         VARCHAR2,
        p_revision_no              IN                         VARCHAR2,
        p_revision_date            IN                         VARCHAR2,
        p_revised_by               IN                         VARCHAR2,
        p_ms_hdr_id                IN                         VARCHAR2,
        p_pl_id                    IN                         VARCHAR2,
        p_offer_type               IN                         VARCHAR2,
        p_lead_id                  IN                         VARCHAR2,
        p_customer_id              IN                         VARCHAR2,
        p_cust_site_id             IN                         VARCHAR2,
        p_customer_name            IN                         VARCHAR2,
        p_customer_phone_no        IN                         VARCHAR2,
        p_customer_country         IN                         VARCHAR2,
        p_salesman_id              IN                         VARCHAR2,
        p_currency_code            IN                         VARCHAR2,
        p_checklist                IN                         VARCHAR2,
        p_terms_desc               IN                         VARCHAR2,
        p_object_version_number    IN                         VARCHAR2,
        p_offer_flag               IN                         VARCHAR2,
        p_tax_code                 IN                         VARCHAR2,
        p_prev_booking_id          IN                         VARCHAR2,
        p_status                   IN                         VARCHAR2,
        p_description              IN                         VARCHAR2,
        p_flow_status              IN                         VARCHAR2,
        p_flow_level               IN                         VARCHAR2,
        p_flow_with                IN                         VARCHAR2,
        p_user_grp_id              IN                         VARCHAR2,
        p_attribute_category       IN                         VARCHAR2,
        p_attribute1               IN                         VARCHAR2,
        p_attribute2               IN                         VARCHAR2,
        p_attribute3               IN                         VARCHAR2,
        p_attribute4               IN                         VARCHAR2,
        p_attribute5               IN                         VARCHAR2,
        p_attribute6               IN                         VARCHAR2,
        p_attribute7               IN                         VARCHAR2,
        p_attribute8               IN                         VARCHAR2,
        p_attribute9               IN                         VARCHAR2,
        p_attribute10              IN                         VARCHAR2,
        p_created_by               IN                         VARCHAR2,
        p_creation_date            IN                         VARCHAR2,
        p_last_updated_by          IN                         VARCHAR2,
        p_last_update_date         IN                         VARCHAR2,
        p_last_update_login        IN                         VARCHAR2,
        p_offer_end_date           IN                         VARCHAR2,
        p_usage                    IN                         VARCHAR2,
        p_lead_source_channel      IN                         VARCHAR2,
        p_lead_source_name         IN                         VARCHAR2,
        p_vend_id                  IN                         VARCHAR2,
        p_vend_site_id             IN                         VARCHAR2,
        p_vend_contract_no         IN                         VARCHAR2,
        p_property_id              IN                         VARCHAR2,
        p_email_id                 IN                         VARCHAR2,
        p_lease_agreement_id       IN                         VARCHAR2,
        p_car_park_lease_agre_id   IN                         VARCHAR2,
        p_cust_accept              IN                         VARCHAR2,
        p_agency_name              IN                         VARCHAR2,
        p_sales_manager_name       IN                         VARCHAR2,
        p_agent_commission         IN                         VARCHAR2,
        p_agent_commission_perc    IN                         VARCHAR2,
        p_agent_name               IN                         VARCHAR2,
        p_NATIONALITY               IN                         VARCHAR2,       
        p_EMIRATES_ID               IN                         VARCHAR2,       
        l_status                   OUT                        VARCHAR2,
        l_errormessage             OUT                        VARCHAR2,
        l_out_offer_hdr            OUT                        NUMBER
    ) AS
        l_cursor                   SYS_REFCURSOR;
--    l_status        VARCHAR2(50);
--    l_ErrorMessage  VARCHAR2(50);
--    l_out_offer_hdr NUMBER;
        xxpm_offer_header_type_t   xxpm_offer_header_type := xxpm_offer_header_type();
        l_num                      NUMBER := 1;
    BEGIN
        xxpm_offer_header_type_t.extend();
        xxpm_offer_header_type_t(l_num) := xxpm_offer_header_typ(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
        , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
        , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

        xxpm_offer_header_type_t(l_num).offer_hdr_id := p_offer_hdr_id;
        xxpm_offer_header_type_t(l_num).org_id := p_org_id;
        xxpm_offer_header_type_t(l_num).func_id := p_func_id;
        xxpm_offer_header_type_t(l_num).offer_number := p_offer_number;
        xxpm_offer_header_type_t(l_num).offer_date := TO_DATE(p_offer_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).offer_from_date := TO_DATE(p_offer_from_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).offer_to_date := TO_DATE(p_offer_to_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).performed_by := p_performed_by;
        xxpm_offer_header_type_t(l_num).revision_no := p_revision_no;
        xxpm_offer_header_type_t(l_num).revision_date := TO_DATE(p_revision_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).revised_by := p_revised_by;
        xxpm_offer_header_type_t(l_num).ms_hdr_id := p_ms_hdr_id;
        xxpm_offer_header_type_t(l_num).pl_id := p_pl_id;
        xxpm_offer_header_type_t(l_num).offer_type := p_offer_type;
        xxpm_offer_header_type_t(l_num).lead_id := p_lead_id;
        xxpm_offer_header_type_t(l_num).customer_id := p_customer_id;
        xxpm_offer_header_type_t(l_num).cust_site_id := p_cust_site_id;
        xxpm_offer_header_type_t(l_num).customer_name := p_customer_name;
        xxpm_offer_header_type_t(l_num).customer_phone_no := p_customer_phone_no;
        xxpm_offer_header_type_t(l_num).customer_country := p_customer_country;
        xxpm_offer_header_type_t(l_num).salesman_id := p_salesman_id;
        xxpm_offer_header_type_t(l_num).currency_code := p_currency_code;
        xxpm_offer_header_type_t(l_num).checklist := p_checklist;
        xxpm_offer_header_type_t(l_num).terms_desc := p_terms_desc;
        xxpm_offer_header_type_t(l_num).object_version_number := p_object_version_number;
        xxpm_offer_header_type_t(l_num).offer_flag := p_offer_flag;
        xxpm_offer_header_type_t(l_num).tax_code := p_tax_code;
        xxpm_offer_header_type_t(l_num).prev_booking_id := p_prev_booking_id;
        xxpm_offer_header_type_t(l_num).status := p_status;
        xxpm_offer_header_type_t(l_num).description := p_description;
        xxpm_offer_header_type_t(l_num).flow_status := p_flow_status;
        xxpm_offer_header_type_t(l_num).flow_level := p_flow_level;
        xxpm_offer_header_type_t(l_num).flow_with := p_flow_with;
        xxpm_offer_header_type_t(l_num).user_grp_id := p_user_grp_id;
        xxpm_offer_header_type_t(l_num).attribute_category := p_attribute_category;
        xxpm_offer_header_type_t(l_num).attribute1 := p_attribute1;
        xxpm_offer_header_type_t(l_num).attribute2 := p_attribute2;
        xxpm_offer_header_type_t(l_num).attribute3 := p_attribute3;
        xxpm_offer_header_type_t(l_num).attribute4 := p_attribute4;
        xxpm_offer_header_type_t(l_num).attribute5 := p_attribute5;
        xxpm_offer_header_type_t(l_num).attribute6 := p_attribute6;
        xxpm_offer_header_type_t(l_num).attribute7 := p_attribute7;
        xxpm_offer_header_type_t(l_num).attribute8 := p_attribute8;
        xxpm_offer_header_type_t(l_num).attribute9 := p_attribute9;
        xxpm_offer_header_type_t(l_num).attribute10 := p_attribute10;
        xxpm_offer_header_type_t(l_num).created_by := p_created_by;
        xxpm_offer_header_type_t(l_num).creation_date := TO_DATE(p_creation_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).last_updated_by := p_last_updated_by;
        xxpm_offer_header_type_t(l_num).last_update_date := TO_DATE(p_last_update_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).last_update_login := p_last_update_login;
        xxpm_offer_header_type_t(l_num).offer_end_date := TO_DATE(p_offer_end_date, 'yyyy-mm-dd');
        xxpm_offer_header_type_t(l_num).usage := p_usage;
        xxpm_offer_header_type_t(l_num).lead_source_channel := p_lead_source_channel;
        xxpm_offer_header_type_t(l_num).lead_source_name := p_lead_source_name;
        xxpm_offer_header_type_t(l_num).vend_id := p_vend_id;
        xxpm_offer_header_type_t(l_num).vend_site_id := p_vend_site_id;
        xxpm_offer_header_type_t(l_num).vend_contract_no := p_vend_contract_no;
        xxpm_offer_header_type_t(l_num).property_id := p_property_id;
        xxpm_offer_header_type_t(l_num).email_id := p_email_id;
        xxpm_offer_header_type_t(l_num).lease_agreement_id := p_lease_agreement_id;
        xxpm_offer_header_type_t(l_num).car_park_lease_agre_id := p_car_park_lease_agre_id;
        xxpm_offer_header_type_t(l_num).cust_accept := p_cust_accept;
        xxpm_offer_header_type_t(l_num).agency_name := p_agency_name;
        xxpm_offer_header_type_t(l_num).sales_manager_name := p_sales_manager_name;
        xxpm_offer_header_type_t(l_num).agent_commission := p_agent_commission;
        xxpm_offer_header_type_t(l_num).agent_commission_perc := p_agent_commission_perc;
        xxpm_offer_header_type_t(l_num).agent_name := p_agent_name;
        xxpm_offer_header_type_t(l_num).NATIONALITY := p_NATIONALITY;
        xxpm_offer_header_type_t(l_num).EMIRATES_ID := p_EMIRATES_ID;
        
        xxpm_offer_header_service(xxpm_offer_header_type_t, l_out_offer_hdr);
        l_status := 'Success';
        l_errormessage := 'null';
        dbms_output.put_line('  l_status 00 ' || l_status);
--    OPEN L_CURSOR FOR SELECT l_status
--  AS
--    status , l_ErrorMessage
--  AS
--    ErrorMessage , l_out_offer_hdr
--  AS
--    out_offer_hdr FROM dual;
--    APEX_JSON.WRITE(L_CURSOR);
        -- due to db link commit;
    EXCEPTION
        WHEN OTHERS THEN
            l_out_offer_hdr := NULL;
            l_status := 'Failed';
            l_errormessage := substr(sqlerrm, 1, 2000);
            dbms_output.put_line('  l_status 11 ' || l_status);
            dbms_output.put_line('  l_ErrorMessage 11 ' || l_errormessage);
            dbms_output.put_line('  Error: ' || dbms_utility.format_error_backtrace);
--    OPEN L_CURSOR FOR SELECT l_status
--  AS
--    status , l_ErrorMessage
--  AS
--    ErrorMessage , l_out_offer_hdr
--  AS
--    out_offer_hdr FROM dual;
--    APEX_JSON.WRITE(L_CURSOR);
            -- due to db link commit;
    END offer_hdr;

    PROCEDURE offer_detail (
        p_offer_dtl_id         IN                     VARCHAR2,
        p_offer_hdr_id         IN                     VARCHAR2,
        p_property_id          IN                     VARCHAR2,
        p_building_id          IN                     VARCHAR2,
        p_unit_id              IN                     VARCHAR2,
        p_uom                  IN                     VARCHAR2,
        p_quantity             IN                     VARCHAR2,
        p_base_rate            IN                     VARCHAR2,
        p_offer_amount         IN                     VARCHAR2,
        p_pl_mod_id            IN                     VARCHAR2,
        p_disc_pct             IN                     VARCHAR2,
        p_disc_amount          IN                     VARCHAR2,
        p_tax_code             IN                     VARCHAR2,
        p_tax_rate             IN                     VARCHAR2,
        p_tax_amount           IN                     VARCHAR2,
        p_attribute_category   IN                     VARCHAR2,
        p_attribute1           IN                     VARCHAR2,
        p_attribute2           IN                     VARCHAR2,
        p_attribute3           IN                     VARCHAR2,
        p_attribute4           IN                     VARCHAR2,
        p_attribute5           IN                     VARCHAR2,
        p_attribute6           IN                     VARCHAR2,
        p_attribute7           IN                     VARCHAR2,
        p_attribute8           IN                     VARCHAR2,
        p_attribute9           IN                     VARCHAR2,
        p_attribute10          IN                     VARCHAR2,
        p_created_by           IN                     VARCHAR2,
        p_creation_date        IN                     VARCHAR2,
        p_last_updated_by      IN                     VARCHAR2,
        p_last_update_date     IN                     VARCHAR2,
        p_last_update_login    IN                     VARCHAR2,
        p_DISC_TYPE            IN                     VARCHAR2,
        p_MIN_PRICE            IN                     VARCHAR2,
        l_status               OUT                    VARCHAR2,
        l_errormessage         OUT                    VARCHAR2,
        l_out_offer_dtl        OUT                    NUMBER
    ) AS
        l_cursor                   SYS_REFCURSOR;
--    l_status        VARCHAR2(50);
--    l_ErrorMessage  VARCHAR2(50);
        l_num                      NUMBER := 1;
--    l_out_offer_dtl NUMBER;
        xxpm_offer_detail_type_t   xxpm_offer_detail_type := xxpm_offer_detail_type();
    BEGIN
        xxpm_offer_detail_type_t.extend();
        xxpm_offer_detail_type_t(1) := xxpm_offer_detail_typ(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
        , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL);

        xxpm_offer_detail_type_t(l_num).offer_dtl_id := p_offer_dtl_id;
        xxpm_offer_detail_type_t(l_num).offer_hdr_id := p_offer_hdr_id;
        xxpm_offer_detail_type_t(l_num).property_id := p_property_id;
        xxpm_offer_detail_type_t(l_num).building_id := p_building_id;
        xxpm_offer_detail_type_t(l_num).unit_id := p_unit_id;
        xxpm_offer_detail_type_t(l_num).uom := p_uom;
        xxpm_offer_detail_type_t(l_num).quantity := p_quantity;
        xxpm_offer_detail_type_t(l_num).base_rate := p_base_rate;
        xxpm_offer_detail_type_t(l_num).offer_amount := p_offer_amount;
        xxpm_offer_detail_type_t(l_num).pl_mod_id := p_pl_mod_id;
        xxpm_offer_detail_type_t(l_num).disc_pct := p_disc_pct;
        xxpm_offer_detail_type_t(l_num).disc_amount := p_disc_amount;
        xxpm_offer_detail_type_t(l_num).tax_code := p_tax_code;
        xxpm_offer_detail_type_t(l_num).tax_rate := p_tax_rate;
        xxpm_offer_detail_type_t(l_num).tax_amount := p_tax_amount;
        xxpm_offer_detail_type_t(l_num).attribute_category := p_attribute_category;
        xxpm_offer_detail_type_t(l_num).attribute1 := p_attribute1;
        xxpm_offer_detail_type_t(l_num).attribute2 := p_attribute2;
        xxpm_offer_detail_type_t(l_num).attribute3 := p_attribute3;
        xxpm_offer_detail_type_t(l_num).attribute4 := p_attribute4;
        xxpm_offer_detail_type_t(l_num).attribute5 := p_attribute5;
        xxpm_offer_detail_type_t(l_num).attribute6 := p_attribute6;
        xxpm_offer_detail_type_t(l_num).attribute7 := p_attribute7;
        xxpm_offer_detail_type_t(l_num).attribute8 := p_attribute8;
        xxpm_offer_detail_type_t(l_num).attribute9 := p_attribute9;
        xxpm_offer_detail_type_t(l_num).attribute10 := p_attribute10;
        xxpm_offer_detail_type_t(l_num).created_by := p_created_by;
        xxpm_offer_detail_type_t(l_num).creation_date := p_creation_date;
        xxpm_offer_detail_type_t(l_num).last_updated_by := p_last_updated_by;
        xxpm_offer_detail_type_t(l_num).last_update_date := p_last_update_date;
        xxpm_offer_detail_type_t(l_num).last_update_login := p_last_update_login;
        xxpm_offer_detail_type_t(l_num).DISC_TYPE := p_DISC_TYPE;
        xxpm_offer_detail_type_t(l_num).MIN_PRICE := p_MIN_PRICE;
        xxpm_offer_detail_service(xxpm_offer_detail_type_t, l_out_offer_dtl);
        l_status := 'Success';
        l_errormessage := NULL;
--      l_out_offer_dtl :=p_OFFER_HDR_ID;
--    OPEN L_CURSOR FOR SELECT l_status
--  AS
--    status ,l_ErrorMessage
--  AS
--    errorMessage , l_out_offer_dtl
--  AS
--    offer_dtl_id FROM dual;
--    APEX_JSON.WRITE(L_CURSOR);
        -- due to db link commit;
    EXCEPTION
        WHEN OTHERS THEN
            l_out_offer_dtl := NULL;
            l_status := 'Failed';
            l_errormessage := substr(sqlerrm, 1, 2000);
--    OPEN L_CURSOR FOR SELECT l_status
--  AS
--    status ,l_ErrorMessage
--  AS
--    errorMessage , l_out_offer_dtl
--  AS
--    offer_dtl_id FROM dual;
--    APEX_JSON.WRITE(L_CURSOR);
            -- due to db link commit;
    END offer_detail;

    PROCEDURE offer_milestone (
        p_offer_ms_dtl_id      IN                     NUMBER,
        p_offer_hdr_id         IN                     NUMBER,
        p_ms_dtl_id            IN                     VARCHAR2,
        p_pl_mod_id            IN                     VARCHAR2,
        p_seq_number           IN                     VARCHAR2,
        p_installment_type     IN                     VARCHAR2,
        p_installment_pct      IN                     VARCHAR2,
        p_installment_amount   IN                     VARCHAR2,
        p_charge_type          IN                     VARCHAR2,
        p_payment_term         IN                     VARCHAR2,
        p_remarks              IN                     VARCHAR2,
        p_due_days             IN                     VARCHAR2,
        p_due_days_from        IN                     VARCHAR2,
        p_due_date             IN                     VARCHAR2,
        p_attribute_category   IN                     VARCHAR2,
        p_attribute1           IN                     VARCHAR2,
        p_attribute2           IN                     VARCHAR2,
        p_attribute3           IN                     VARCHAR2,
        p_attribute4           IN                     VARCHAR2,
        p_attribute5           IN                     VARCHAR2,
        p_attribute6           IN                     VARCHAR2,
        p_attribute7           IN                     VARCHAR2,
        p_attribute8           IN                     VARCHAR2,
        p_attribute9           IN                     VARCHAR2,
        p_attribute10          IN                     VARCHAR2,
        p_created_by           IN                     VARCHAR2,
        p_creation_date        IN                     VARCHAR2,
        p_last_updated_by      IN                     VARCHAR2,
        p_last_update_date     IN                     VARCHAR2,
        p_last_update_login    IN                     VARCHAR2,
        p_milestone_type       IN                     VARCHAR2,
        p_uom                  IN                     VARCHAR2,
        p_quantity             IN                     VARCHAR2,
        p_rate                 IN                     VARCHAR2,
        p_wave_off             IN                     VARCHAR2,
        p_installment_method   IN                     VARCHAR2,
        p_installment_event    IN                     VARCHAR2,
        p_period_occurence     IN                     VARCHAR2,
        p_period_values        IN                     VARCHAR2,
        p_period_duration      IN                     VARCHAR2,
        p_included_in_rate     IN                     VARCHAR2,
        p_tax_rate             IN                     NUMBER,
        p_tax_code             IN                     VARCHAR2,
        p_tax_amount           IN                     NUMBER,
        p_CARPARKING           IN                     VARCHAR2,
        p_OTHER_CHARGE_TYPE    IN                      VARCHAR2,
        l_status               OUT                    VARCHAR2,
        l_errormessage         OUT                    VARCHAR2,
        l_out_offer_ms         OUT                    NUMBER
    ) AS
        l_cursor                             SYS_REFCURSOR;
--    l_status       VARCHAR2(50);
--    l_ErrorMessage VARCHAR2(50);
--    l_out_offer_ms NUMBER;
        l_num                                NUMBER := 1;
        xxpm_offer_milestone_detail_type_t   xxpm_offer_milestone_detail_type := xxpm_offer_milestone_detail_type();
    BEGIN
        xxpm_offer_milestone_detail_type_t.extend;
        xxpm_offer_milestone_detail_type_t(1) := xxpm_offer_milestone_detail_typ(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
        , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

        xxpm_offer_milestone_detail_type_t(1).offer_ms_dtl_id := p_offer_ms_dtl_id;
        xxpm_offer_milestone_detail_type_t(1).offer_hdr_id := p_offer_hdr_id;
        xxpm_offer_milestone_detail_type_t(1).ms_dtl_id := p_ms_dtl_id;
        xxpm_offer_milestone_detail_type_t(1).pl_mod_id := p_pl_mod_id;
        xxpm_offer_milestone_detail_type_t(1).seq_number := p_seq_number;
        xxpm_offer_milestone_detail_type_t(1).installment_type := p_installment_type;
        xxpm_offer_milestone_detail_type_t(1).installment_pct := p_installment_pct;
        xxpm_offer_milestone_detail_type_t(1).installment_amount := p_installment_amount;
        xxpm_offer_milestone_detail_type_t(1).charge_type := p_charge_type;
        xxpm_offer_milestone_detail_type_t(1).payment_term := p_payment_term;
        xxpm_offer_milestone_detail_type_t(1).remarks := p_remarks;
        xxpm_offer_milestone_detail_type_t(1).due_days := p_due_days;
        xxpm_offer_milestone_detail_type_t(1).due_days_from := p_due_days_from;
        xxpm_offer_milestone_detail_type_t(1).due_date := TO_DATE(p_due_date, 'yyyy-mm-dd');
        xxpm_offer_milestone_detail_type_t(1).attribute_category := p_attribute_category;
        xxpm_offer_milestone_detail_type_t(1).attribute1 := p_attribute1;
        xxpm_offer_milestone_detail_type_t(1).attribute2 := p_attribute2;
        xxpm_offer_milestone_detail_type_t(1).attribute3 := p_attribute3;
        xxpm_offer_milestone_detail_type_t(1).attribute4 := p_attribute4;
        xxpm_offer_milestone_detail_type_t(1).attribute5 := p_attribute5;
        xxpm_offer_milestone_detail_type_t(1).attribute6 := p_attribute6;
        xxpm_offer_milestone_detail_type_t(1).attribute7 := p_attribute7;
        xxpm_offer_milestone_detail_type_t(1).attribute8 := p_attribute8;
        xxpm_offer_milestone_detail_type_t(1).attribute9 := p_attribute9;
        xxpm_offer_milestone_detail_type_t(1).attribute10 := p_attribute10;
        xxpm_offer_milestone_detail_type_t(1).created_by := p_created_by;
        xxpm_offer_milestone_detail_type_t(1).creation_date := TO_DATE(p_creation_date, 'yyyy-mm-dd');
        xxpm_offer_milestone_detail_type_t(1).last_updated_by := p_last_updated_by;
        xxpm_offer_milestone_detail_type_t(1).last_update_date := TO_DATE(p_last_update_date, 'yyyy-mm-dd');
        xxpm_offer_milestone_detail_type_t(1).last_update_login := p_last_update_login;
        xxpm_offer_milestone_detail_type_t(1).milestone_type := p_milestone_type;
        xxpm_offer_milestone_detail_type_t(1).uom := p_uom;
        xxpm_offer_milestone_detail_type_t(1).quantity := p_quantity;
        xxpm_offer_milestone_detail_type_t(1).rate := p_rate;
        xxpm_offer_milestone_detail_type_t(1).wave_off := p_wave_off;
        xxpm_offer_milestone_detail_type_t(1).installment_method := p_installment_method;
        xxpm_offer_milestone_detail_type_t(1).installment_event := p_installment_event;
        xxpm_offer_milestone_detail_type_t(1).period_occurence := p_period_occurence;
        xxpm_offer_milestone_detail_type_t(1).period_values := p_period_values;
        xxpm_offer_milestone_detail_type_t(1).period_duration := p_period_duration;
        xxpm_offer_milestone_detail_type_t(1).included_in_rate := p_included_in_rate;
        xxpm_offer_milestone_detail_type_t(1).tax_rate := p_tax_rate;
        xxpm_offer_milestone_detail_type_t(1).tax_code := p_tax_code;
        xxpm_offer_milestone_detail_type_t(1).tax_amount := p_tax_amount;
        xxpm_offer_milestone_detail_type_t(1).CARPARKING := p_CARPARKING;
        xxpm_offer_milestone_detail_type_t(1).OTHER_CHARGE_TYPE := p_OTHER_CHARGE_TYPE;
        
        IF p_offer_hdr_id IS NOT NULL AND p_ms_dtl_id IS NOT NULL THEN
            xxpm_offer_milestone_detail_service(xxpm_offer_milestone_detail_type_t, l_out_offer_ms);
            l_status := 'Success';
            l_errormessage := NULL;
        ELSE
            l_status := 'Error';
            l_errormessage := 'Table ID missing';
        END IF;
    --    l_out_offer_ms :=p_OFFER_MS_DTL_ID;
    --    OPEN L_CURSOR FOR SELECT l_status
    --  AS
    --    status , l_ErrorMessage
    --  AS
    --    errorMessage , l_out_offer_ms
    --  AS
    --    offer_ms_id FROM dual;
    --    APEX_JSON.WRITE(L_CURSOR);

        -- due to db link commit;
    EXCEPTION
        WHEN OTHERS THEN
            l_out_offer_ms := NULL;
            l_status := 'Failed';
            l_errormessage := substr(sqlerrm, 1, 2000);
    --    OPEN L_CURSOR FOR SELECT l_status
    --  AS
    --    status , l_ErrorMessage
    --  AS
    --    errorMessage , l_out_offer_ms
    --  AS
    --    offer_ms_id FROM dual;
    --    APEX_JSON.WRITE(L_CURSOR);
--    -- due to db link commit;
    END offer_milestone;

END xxpm_salesforce_outbound_pkg;
