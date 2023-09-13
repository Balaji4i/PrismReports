SELECT * FROM xxfnd_schedule_t;


REM INSERTING into XXPRISM.XXFND_SCHEDULE_T
SET DEFINE OFF;
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10001,'BankAccountDetails',30,null,'Custom/Property Lease/Reports','Bank Account Details','XXSTG_BANK_ACCOUNTS','BANK_ACNT_ID','xxstg_integration_pkg.bank_accounts',null,to_timestamp('22-JUN-20 07.23.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('24-MAY-17 03.08.48.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.706000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.706','N','Y',to_timestamp('22-JUN-20 06.53.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('22-JUN-20 06.53.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10002,'CustomerContact',2,null,'Custom/Property Lease/Reports','Customer Contact','xxstg_cust_contacts','CUST_CONTACT_ID,CUST_ID,CUST_SITE_ID','xxstg_integration_pkg.customer_contact',null,to_timestamp('13-JUL-20 03.25.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.11.05.672000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.709000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.709','Y','Y',to_timestamp('13-JUL-20 07.28.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('13-JUL-20 07.28.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10003,'CustomerSites',2,null,'Custom/Property Lease/Reports','Customer Sites','xxstg_cust_sites','CUST_SITE_ID,CUST_ID,ORG_ID','xxstg_integration_pkg.customer_site',null,to_timestamp('13-JUL-20 03.26.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.12.14.452000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.711000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.711','Y','Y',to_timestamp('13-JUL-20 07.29.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('13-JUL-20 07.29.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10009,'Location',60,null,'Custom/Property Lease/Reports','Location','xxstg_locations','LOC_ID','xxstg_integration_pkg.locations',null,to_timestamp('22-APR-20 07.19.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('24-MAY-17 03.08.48.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.713000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.713','N','Y',to_timestamp('01-APR-20 07.18.46.931000000 AM','DD-MON-RR HH.MI.SSXFF AM'),null);
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10006,'Vendor',60,null,'Custom/Property Lease/Reports','Supplier','xxstg_vendor','VEND_ID','xxstg_integration_pkg.vendor',null,to_timestamp('22-APR-20 07.18.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.16.39.326000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.714000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.714','N','Y',to_timestamp('01-APR-20 07.18.46.931000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-APR-20 08.26.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10010,'VendorContact',60,null,'Custom/Property Lease/Reports','Supplier Contact','xxstg_vend_contacts','VEND_CONTACT_ID,VEND_ID,VEND_SITE_ID','xxstg_integration_pkg.vendor_contact',null,to_timestamp('22-APR-20 07.19.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.16.39.326000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.716000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.716','N','Y',to_timestamp('01-APR-20 07.18.46.931000000 AM','DD-MON-RR HH.MI.SSXFF AM'),null);
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10004,'Customer',2,null,'Custom/Property Lease/Reports','Customer','xxstg_customer','CUST_ID','xxstg_integration_pkg.customers',null,to_timestamp('13-JUL-20 03.25.51.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.13.08.964000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.718000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.725','Y','Y',to_timestamp('13-JUL-20 07.28.51.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('13-JUL-20 07.28.51.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10005,'Employee',30,null,'Custom/Property Lease/Reports','Employee','xxstg_employee','EMP_ID','xxstg_integration_pkg.employee',null,to_timestamp('09-JUN-20 08.37.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.13.54.255000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.731000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.731','N','Y',to_timestamp('09-JUN-20 08.07.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-JUN-20 08.07.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10011,'VendorSite',60,null,'Custom/Property Lease/Reports','Supplier Site','xxstg_vend_sites','VEND_SITE_ID,VEND_ID,ORG_ID','xxstg_integration_pkg.vendor_site',null,to_timestamp('22-APR-20 07.19.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.16.39.326000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.733000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.733','N','Y',to_timestamp('01-APR-20 07.18.46.931000000 AM','DD-MON-RR HH.MI.SSXFF AM'),null);
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10007,'OrganizationUnits',30,null,'Custom/Property Lease/Reports','Organization based Projects','xxstg_organizations','ORG_ID','xxstg_integration_pkg.organizations_new',null,to_timestamp('09-JUN-20 08.37.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.15.52.981000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.735000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.735','N','Y',to_timestamp('09-JUN-20 08.07.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-JUN-20 08.07.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10008,'PaymentTerm',30,null,'Custom/Property Lease/Reports','Payment Term','xxstg_pay_terms','TERM_ID','xxstg_integration_pkg.payment_terms',null,to_timestamp('09-JUN-20 08.37.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.16.39.326000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.737000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.737','N','Y',to_timestamp('09-JUN-20 08.07.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-JUN-20 08.07.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10012,'Projects',30,null,'Custom/Property Lease/Reports','Project','xxstg_projects','PROJ_ID','xxstg_integration_pkg.projects',null,to_timestamp('09-JUN-20 08.37.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.15.52.981000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.743000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.743','N','Y',to_timestamp('09-JUN-20 08.07.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-JUN-20 08.07.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into XXPRISM.XXFND_SCHEDULE_T (SCHEDULE_ID,SCHEDULE_NAME,FREQUENCY_MIN,PROGRAM_NAME,BI_REPORT_PATH,BI_REPORT_NAME,DB_TABLE_NAME,DB_COLUMN_NAMES,DB_REFRESH_PKG,APPLICATION_NAME,NEXT_SCHEDULE_TIME,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE,LAST_UPDATE_LOGIN,RUN_STATUS,STATUS,RECORDS_FROM_DATE,LAST_SCHEDULE_TIME) values (10014,'ReceiptMethod',15,null,'Custom/Property Lease/Reports','Receipt Method','xxstg_receipt_method','RECEIPT_METHOD_ID,ORG_ID,REMIT_BANK_ACCT_USE_ID','xxstg_integration_pkg.receipt_method',null,to_timestamp('09-JUN-20 08.37.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('14-SEP-17 03.13.54.255000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'anonymous',to_timestamp('11-APR-20 06.27.26.745000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'2020-04-11 06:27:26.745','N','Y',to_timestamp('09-JUN-20 08.22.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-JUN-20 08.22.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));