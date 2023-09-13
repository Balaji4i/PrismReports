--------------------------------------------------------
--  DDL for Procedure XXPM_PROPERTY_MILE_SERVICE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "XXPM_PROPERTY_MILE_SERVICE" (
    xxpm_property_milestone_t xxpm_property_mile_type,
    p_milestone_id out number)
as
  v_temp number;
  cursor c1(p_milestone_id number)
  is
    select 1 from xxpm_property_milestone where milestone_id = p_milestone_id;
begin
  for i in 1..xxpm_property_milestone_t.count
  loop
    select xxpm_property_milestone_t(i).milestone_id
    into p_milestone_id
    from dual;
    open c1(p_milestone_id);
    fetch c1 into v_temp;
    if c1%notfound then
      select xxpm_milestone_id_s.nextval
      into p_milestone_id
      from dual;
    else
      null;
    end if;
    close c1;
    merge into xxpm_property_milestone a using
    (select p_milestone_id milestone_id ,
      xxpm_property_milestone_t(i).ms_hdr_id ms_hdr_id ,
      xxpm_property_milestone_t(i).property_id property_id ,
      xxpm_property_milestone_t(i).remarks remarks ,
      xxpm_property_milestone_t(i).active_yn active_yn ,
      xxpm_property_milestone_t(i).attribute_category attribute_category ,
      xxpm_property_milestone_t(i).attribute1 attribute1 ,
      xxpm_property_milestone_t(i).attribute2 attribute2 ,
      xxpm_property_milestone_t(i).attribute3 attribute3 ,
      xxpm_property_milestone_t(i).attribute4 attribute4 ,
      xxpm_property_milestone_t(i).attribute5 attribute5 ,
      xxpm_property_milestone_t(i).attribute6 attribute6 ,
      xxpm_property_milestone_t(i).attribute7 attribute7 ,
      xxpm_property_milestone_t(i).attribute8 attribute8 ,
      xxpm_property_milestone_t(i).attribute9 attribute9 ,
      xxpm_property_milestone_t(i).attribute10 attribute10 ,
      xxpm_property_milestone_t(i).created_by created_by ,
      xxpm_property_milestone_t(i).creation_date creation_date ,
      xxpm_property_milestone_t(i).last_updated_by last_updated_by ,
      xxpm_property_milestone_t(i).last_update_date last_update_date ,
      xxpm_property_milestone_t(i).last_update_login last_update_login ,
      xxpm_property_milestone_t(i).pl_id pl_id ,
      xxpm_property_milestone_t(i).primary_yn primary_yn
    from dual
    ) b on (a.milestone_id = b.milestone_id)
  when matched then
    update
    set ms_hdr_id        = b.ms_hdr_id ,
      property_id        = b.property_id ,
      remarks            = b.remarks ,
      active_yn          = b.active_yn ,
      attribute_category = b.attribute_category ,
      attribute1         = b.attribute1 ,
      attribute2         = b.attribute2 ,
      attribute3         = b.attribute3 ,
      attribute4         = b.attribute4 ,
      attribute5         = b.attribute5 ,
      attribute6         = b.attribute6 ,
      attribute7         = b.attribute7 ,
      attribute8         = b.attribute8 ,
      attribute9         = b.attribute9 ,
      attribute10        = b.attribute10 ,
      created_by         = b.created_by ,
      creation_date      = b.creation_date ,
      last_updated_by    = b.last_updated_by ,
      last_update_date   = b.last_update_date ,
      last_update_login  = b.last_update_login ,
      pl_id              = b.pl_id ,
      primary_yn         = b.primary_yn when not matched then
    insert
      (
        milestone_id,
        ms_hdr_id,
        property_id,
        remarks,
        active_yn,
        attribute_category ,
        attribute1 ,
        attribute2 ,
        attribute3 ,
        attribute4 ,
        attribute5 ,
        attribute6 ,
        attribute7 ,
        attribute8 ,
        attribute9 ,
        attribute10 ,
        created_by ,
        creation_date ,
        last_updated_by ,
        last_update_date ,
        last_update_login ,
        pl_id,
        primary_yn
      )
      values
      (
        p_milestone_id,--OFFER_HDR_ID_S.NEXTVAL ,
        xxpm_property_milestone_t(i).property_id ,
        xxpm_property_milestone_t(i).ms_hdr_id,
        xxpm_property_milestone_t(i).remarks ,
        xxpm_property_milestone_t(i).active_yn ,
        xxpm_property_milestone_t(i).attribute_category,
        xxpm_property_milestone_t(i).attribute1 ,
        xxpm_property_milestone_t(i).attribute2 ,
        xxpm_property_milestone_t(i).attribute3 ,
        xxpm_property_milestone_t(i).attribute4 ,
        xxpm_property_milestone_t(i).attribute5 ,
        xxpm_property_milestone_t(i).attribute6 ,
        xxpm_property_milestone_t(i).attribute7 ,
        xxpm_property_milestone_t(i).attribute8 ,
        xxpm_property_milestone_t(i).attribute9 ,
        xxpm_property_milestone_t(i).attribute10 ,
        xxpm_property_milestone_t(i).created_by ,
        xxpm_property_milestone_t(i).creation_date ,
        xxpm_property_milestone_t(i).last_updated_by ,
        xxpm_property_milestone_t(i).last_update_date,
        xxpm_property_milestone_t(i).last_update_login,
        xxpm_property_milestone_t(i).pl_id,
        xxpm_property_milestone_t(i).primary_yn
      );
    commit;
  end loop;
exception
when others then
  raise;
end xxpm_property_mile_service;
