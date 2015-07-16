spool create_tablespaces.out
set timing on
create tablespace CEF_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_cef_cnr_data01_01.dbf'   size 30G autoextend on extent management local uniform size 10m segment space management auto;
alter tablespace CEF_CNR_DATA01 add datafile '/s01/oradata1/ord723/orp723_cef_cnr_data01_02.dbf'   size 30G autoextend on ;
alter tablespace CEF_CNR_DATA01 add datafile '/s01/oradata1/ord723/orp723_cef_cnr_data01_03.dbf'   size 10G autoextend on ;
create tablespace CEF_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_cef_cnr_index01_01.dbf'  size 30G autoextend on extent management local uniform size 10m segment space management auto;
alter tablespace CEF_CNR_INDEX01   add datafile '/s01/oradata1/ord723/orp723_cef_cnr_index01_02.dbf'   size 30G autoextend on ;
alter tablespace CEF_CNR_INDEX01   add datafile '/s01/oradata1/ord723/orp723_cef_cnr_index01_03.dbf'   size 30G autoextend on ;
alter tablespace CEF_CNR_INDEX01   add datafile '/s01/oradata1/ord723/orp723_cef_cnr_index01_04.dbf'   size 10G autoextend on ;
create tablespace EMS_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_ems_cnr_data01_01.dbf'   size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace EMS_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_ems_cnr_index01_01.dbf'  size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace FRT_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_frt_cnr_data01_01.dbf'   size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace FRT_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_frt_cnr_index01_01.dbf'  size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace MPD2_CNR_DATA01   datafile '/s01/oradata1/ord723/orp723_mpd2_cnr_data01_01.dbf'  size 2G autoextend on extent management local uniform size 1m segment space management auto;
create tablespace MPD2_CNR_INDEX01  datafile '/s01/oradata1/ord723/orp723_mpd2_cnr_index01_01.dbf' size 2G autoextend on extent management local uniform size 1m segment space management auto;
create tablespace OIL_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_oil_cnr_data01_01.dbf'   size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace OIL_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_oil_cnr_index01_01.dbf'  size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace OTD_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_otd_cnr_data01_01.dbf'   size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace OTD_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_otd_cnr_index01_01.dbf'  size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace STE_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_ste_cnr_data01_01.dbf'   size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace STE_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_ste_cnr_index01_01.dbf'  size 512M autoextend on extent management local uniform size 1m segment space management auto;
create tablespace GFMS_CNR_DATA01   datafile '/s01/oradata1/ord723/orp723_gfms_cnr_data01_01.dbf'  size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace GFMS_CNR_INDEX01  datafile '/s01/oradata1/ord723/orp723_gfms_cnr_index01_01.dbf'  size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace EMS_CNR_SNAP_LOG  datafile '/s01/oradata1/ord723/orp723_ems_cnr_snap_log_01.dbf' size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace FRT_REP_SNAP_LOG  datafile '/s01/oradata1/ord723/orp723_frt_rep_snap_log_01.dbf' size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace OIL_CNR_SNAP_LOG  datafile '/s01/oradata1/ord723/orp723_oil_cnr_snap_log_01.dbf' size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace STE_CNR_SNAP_LOG  datafile '/s01/oradata1/ord723/orp723_ste_cnr_snap_log_01.dbf' size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace MPD2_REP_SNAP_LOG datafile '/s01/oradata1/ord723/orp723_mpd2_rep_snap_log_01.dbf'  size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace OTD_CNR_SNAP_LOG  datafile '/s01/oradata1/ord723/orp723_otd_cnr_snap_log_01.dbf'  size 512M   autoextend on extent management local uniform size 1m segment space management auto;
create tablespace NDA_CNR_DATA01    datafile '/s01/oradata1/ord723/orp723_nda_cnr_data01_01.dbf'  size 2G autoextend on extent management local uniform size 10m segment space management auto;
create tablespace NDA_CNR_INDEX01   datafile '/s01/oradata1/ord723/orp723_nda_cnr_index01_01.dbf'  size 1G autoextend on extent management local uniform size 10m segment space management auto;


create tablespace EMS_APDS_DATA01        datafile '/s01/oradata1/ord723/orp723_ems_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace EMS_APDS_INDEX01       datafile '/s01/oradata1/ord723/orp723_ems_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace FRT_APDS_DATA01        datafile '/s01/oradata1/ord723/orp723_frt_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace FRT_APDS_INDEX01       datafile '/s01/oradata1/ord723/orp723_frt_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace MPD2_APDS_DATA01       datafile '/s01/oradata1/ord723/orp723_mpd2_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace MPD2_APDS_INDEX01      datafile '/s01/oradata1/ord723/orp723_mpd2_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace OIL_APDS_DATA01        datafile '/s01/oradata1/ord723/orp723_oil_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace OIL_APDS_INDEX01       datafile '/s01/oradata1/ord723/orp723_oil_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace OTD_APDS_DATA01        datafile '/s01/oradata1/ord723/orp723_otd_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace OTD_APDS_INDEX01       datafile '/s01/oradata1/ord723/orp723_otd_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace STE_APDS_DATA01        datafile '/s01/oradata1/ord723/orp723_ste_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace STE_APDS_INDEX01       datafile '/s01/oradata1/ord723/orp723_ste_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace GFMS_APDS_DATA01       datafile '/s01/oradata1/ord723/orp723_gfms_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace GFMS_APDS_INDEX01      datafile '/s01/oradata1/ord723/orp723_gfms_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace CEF_APDS_DATA01        datafile '/s01/oradata1/ord723/orp723_cef_apds_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace CEF_APDS_INDEX01       datafile '/s01/oradata1/ord723/orp723_cef_apds_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 


create tablespace SDI_DATA01                    datafile '/s01/oradata1/ord723/orp723_sdi_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace PLATTS_DATA01                 datafile '/s01/oradata1/ord723/orp723_platts_data01_01.dbf' size 4G autoextend on extent management local uniform size 10m segment space management auto; 
create tablespace SPATIAL_DATA01                datafile '/s01/oradata1/ord723/orp723_spatial_data01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 

create tablespace SDI_INDEX01           datafile '/s01/oradata1/ord723/orp723_sdi_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace PLATTS_INDEX01        datafile '/s01/oradata1/ord723/orp723_platts_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 
create tablespace SPATIAL_INDEX01       datafile '/s01/oradata1/ord723/orp723_spatial_index01_01.dbf' size 512m autoextend on extent management local uniform size 1m segment space management auto; 


spool off

