spool create_users.out
set timing on

create user CEF_CNR identified by CEF_CNR     default tablespace CEF_CNR_DATA01  temporary tablespace temp01 quota unlimited on CEF_CNR_DATA01 quota unlimited on CEF_CNR_INDEX01;
create user MPD2_CNR identified by MPD2_CNR   default tablespace MPD2_CNR_DATA01 temporary tablespace temp01 quota unlimited on MPD2_CNR_DATA01 quota unlimited on MPD2_CNR_INDEX01;
create user STE_CNR identified by STE_CNR     default tablespace STE_CNR_DATA01  temporary tablespace temp01 quota unlimited on STE_CNR_DATA01 quota unlimited on STE_CNR_INDEX01;
create user OIL_CNR identified by OIL_CNR     default tablespace OIL_CNR_DATA01  temporary tablespace temp01 quota unlimited on OIL_CNR_DATA01 quota unlimited on OIL_CNR_INDEX01;
create user EMS_CNR identified by EMS_CNR     default tablespace EMS_CNR_DATA01  temporary tablespace temp01 quota unlimited on EMS_CNR_DATA01 quota unlimited on EMS_CNR_INDEX01;
create user OTD_CNR identified by OTD_CNR     default tablespace OTD_CNR_DATA01  temporary tablespace temp01 quota unlimited on OTD_CNR_DATA01 quota unlimited on OTD_CNR_INDEX01;
create user FRT_CNR identified by FRT_CNR     default tablespace FRT_CNR_DATA01  temporary tablespace temp01 quota unlimited on FRT_CNR_DATA01 quota unlimited on FRT_CNR_INDEX01;
create user GFMS_CNR identified by GFMS_CNR   default tablespace GFMS_CNR_DATA01 temporary tablespace temp01 quota unlimited on GFMS_CNR_DATA01 quota unlimited on GFMS_CNR_INDEX01;

create user MPD2_APDS identified by MPD2_APDS default tablespace MPD2_APDS_DATA01 temporary tablespace temp01 quota unlimited on MPD2_APDS_DATA01 quota unlimited on MPD2_APDS_INDEX01;
create user STE_APDS identified by STE_APDS   default tablespace STE_APDS_DATA01  temporary tablespace temp01 quota unlimited on STE_APDS_DATA01 quota unlimited on STE_APDS_INDEX01;
create user OIL_APDS identified by OIL_APDS   default tablespace OIL_APDS_DATA01  temporary tablespace temp01 quota unlimited on OIL_APDS_DATA01 quota unlimited on OIL_APDS_INDEX01;
create user EMS_APDS identified by EMS_APDS   default tablespace EMS_APDS_DATA01  temporary tablespace temp01 quota unlimited on EMS_APDS_DATA01 quota unlimited on EMS_APDS_INDEX01;
create user OTD_APDS identified by OTD_APDS   default tablespace OTD_APDS_DATA01  temporary tablespace temp01 quota unlimited on OTD_APDS_DATA01 quota unlimited on OTD_APDS_INDEX01;
create user FRT_APDS identified by FRT_APDS   default tablespace FRT_APDS_DATA01  temporary tablespace temp01 quota unlimited on FRT_APDS_DATA01 quota unlimited on FRT_APDS_INDEX01;
create user CEF_APDS identified by CEF_APDS   default tablespace CEF_APDS_DATA01  temporary tablespace temp01 quota unlimited on CEF_APDS_DATA01 quota unlimited on CEF_APDS_INDEX01;
create user GFMS_APDS identified by GFMS_APDS default tablespace GFMS_APDS_DATA01 temporary tablespace temp01 quota unlimited on GFMS_APDS_DATA01 quota unlimited on GFMS_APDS_INDEX01;

create user SDI identified by SDI          default tablespace SDI_DATA01     temporary tablespace temp01 quota unlimited on SDI_DATA01 ;
create user PLATTS identified by PLATTS    default tablespace PLATTS_DATA01  temporary tablespace temp01 quota unlimited on PLATTS_DATA01 ;
create user SPATIAL identified by SPATIAL  default tablespace SPATIAL_DATA01 temporary tablespace temp01 quota unlimited on SPATIAL_DATA01 ;

-- create pds users to avoid granting errors during impdp
create user MPD2_PDS identified by MPD2_PDS default tablespace CEF_CNR_DATA01  temporary tablespace temp01;
create user STE_PDS identified by STE_PDS default tablespace CEF_CNR_DATA01    temporary tablespace temp01;
create user OIL_PDS identified by OIL_PDS default tablespace CEF_CNR_DATA01    temporary tablespace temp01;
create user EMS_PDS identified by EMS_PDS default tablespace CEF_CNR_DATA01    temporary tablespace temp01;
create user OTD_PDS identified by OTD_PDS default tablespace CEF_CNR_DATA01    temporary tablespace temp01;
create user FRT_PDS identified by FRT_PDS default tablespace CEF_CNR_DATA01    temporary tablespace temp01;


create user NDA_CNR identified by NDA_CNR default tablespace NDA_CNR_DATA01 temporary tablespace temp01;
grant connect,resource to NDA_CNR;

/*
create role PLUSTRACE;
grant select on V_$STATNAME to PLUSTRACE;
grant select on V_$SESSTAT to PLUSTRACE;
grant select on V_$MYSTAT to PLUSTRACE;
*/
spool off
