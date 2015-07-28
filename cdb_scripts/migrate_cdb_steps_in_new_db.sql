
/*******************************************************/
-- steps on new db
--create new tablespaces on Prod database:
conn / as sysdba
@create_tablespaces.sql
@create_users.sql
-- set  pwd for user dba_admin
alter user dba_admin identified by dba_admin;

-- import metadata
connect dba_admin/dba_admin
create or replace directory CE_PUMP_DIR as '/n04/oraarch2/ce_pump_dir';

-- impdp cost around 8 mins (<=10mins)
!impdp dba_admin/dba_admin parfile=impCE_metadata.par

-- further steps in new db
connect dba_admin/dba_admin
-- create public synonyms
@drop_old_public_synonyms.sql;
@create_public_synonyms.sql;

connect / as sysdba
-- grant specific privs
@grant_privs_others.sql;

-- recompile all objects
connect / as sysdba
@$ORACLE_HOME/rdbms/admin/utlrp.sql;

connect dba_admin/dba_admin
-- disable all triggers
@disable_triggers.sql;
-- disable all db jobs + scheduler jobs
@stop_jobs.sql;


-- drop unexpected jobs if there are any
BEGIN
  FOR tmp IN ( --
              SELECT *
                FROM dba_scheduler_jobs
               WHERE regexp_substr(job_name, '^CE[0-9]{4}\_[0-9]{14}\_[0-9]$') IS NOT NULL) LOOP
    dbms_scheduler.drop_job(tmp.owner || '.' || tmp.job_name);
  END LOOP;
END;

connect dba_admin/dba_admin
-- disable non-C constraints
-- excluding C types of constraints, because it's difficult to enable them later
@disable_non_c_constraints.sql;


-- drop some specific indexes
-- 'VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION', 'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE'
@drop_big_indexes.sql;


-- import data to new db
-- cost 40 mins for all (cef2 cost 20 mins)
!impdp dba_admin/dba_admin parfile=impCE_data.par_gfms;
!impdp dba_admin/dba_admin parfile=impCE_data.par_ems;
!impdp dba_admin/dba_admin parfile=impCE_data.par_frt;
!impdp dba_admin/dba_admin parfile=impCE_data.par_oil;
!impdp dba_admin/dba_admin parfile=impCE_data.par_otd;
!impdp dba_admin/dba_admin parfile=impCE_data.par_ste;
!impdp dba_admin/dba_admin parfile=impCE_data.par_nda;
!impdp dba_admin/dba_admin parfile=impCE_data.par_platts;
!impdp dba_admin/dba_admin parfile=impCE_data.par_sdi;
!impdp dba_admin/dba_admin parfile=impCE_data.par_spatial;


!impdp dba_admin/dba_admin parfile=impCE_data.par_mpd2;
!impdp dba_admin/dba_admin parfile=impCE_data.par_cef1; 
!impdp dba_admin/dba_admin parfile=impCE_data.par_cef2; 


-- move index tablespaces
-- cost 8 mins
conn dba_admin/dba_admin
set timing on
@move_index_tablespace.sql;


-- create removed indexes 
-- 'VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION', 'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE'
-- cost 40mins
conn dba_admin/dba_admin
@create_big_indexes.sql;


-- create some temporary indexes for enabling R constraints
conn dba_admin/dba_admin
@gen_tmp_indexes_creation_remove.sql;
@create_tmp_indexes.sql;


-- recollect statistics for the related objects
exec DBMS_STATS.UNLOCK_SCHEMA_STATS ('CEF_CNR');
@gen_gather_ind_statistics.sql;
@gather_ind_statistics.sql;

-- enable all constraints (around 20 mins)
-- enable non-R constraints
@gen_enable_non_r_constraints.sql;
@enable_non_r_constraints.sql;
connect dba_admin/dba_admin
@validate_constraints_in_parallel.sql

-- remove the temporary indexes
@remove_tmp_indexes.sql
-- enable all triggers
@enable_triggers.sql;


-- remove users out-of-use
connect / as sysdba
drop user MPD2_PDS CASCADE;
drop user STE_PDS CASCADE;
drop user OIL_PDS CASCADE;
drop user EMS_PDS CASCADE;
drop user OTD_PDS CASCADE;
drop user FRT_PDS CASCADE;


connect dba_admin/dba_admin
-- recreate some objects (which fail to get successfully via export/import)
-- recreate CEF_APDS.HISTORICAL_CELL_VALUE_M_V
@recreate_cef_apds_historical_cell_value_mv.sql;

-- recreate CEF_CNR.DIMENSION_DATA_MV
--     note that, it's ok if the mv doesn't exist before.
@recreate_cef_cnr_dimension_data_mv.sql;


-- recreate job refresh_coal_flow_mv_group
connect cef_apds/cef_apds
@recreate_job_refresh_coal_flow_mv_group.sql

-- move all refreshing jobs to dba_scheduler_jobs
connect mpd2_apds/mpd2_apds
@replace_MPD2_APDS_10M_RG1.sql;

connect ems_apds/ems_apds
@replace_EMS_APDS_6H_RG1.sql;

connect ste_cnr/ste_cnr
@replace_STE_CNR_30M_RG1.sql;

connect ems_cnr/ems_cnr
@replace_EMS_CNR_dba_jobs.sql;

connect mpd2_cnr/mpd2_cnr
@replace_MPD2_CNR_dba_jobs.sql;


-- !!!!!!!!!!!! remove unwanted objects !!!!!!!!!!!! 
-- China coal mvs
connect dba_admin/dba_admin
execute dbms_scheduler.drop_job('CEF_APDS.REFRESH_CH_COAL_IMPORT_MVS');
drop materialized view CEF_APDS.CHINA_COAL_IMPORT_COUNTRY_M_V;
drop materialized view CEF_APDS.CHINA_COAL_IMPORT_FORECAST_M_V;
drop materialized view CEF_APDS.CHINA_COAL_IMPORT_PREVIOUS_M_V;
drop materialized view CEF_APDS.CHINA_POR_BER_ANC_M_V;

-- Oil in OIL_CNR mvs
connect oil_cnr/oil_cnr
execute DBMS_JOB.REMOVE(24400087);
execute DBMS_JOB.REMOVE(29014831);
commit;
connect dba_admin/dba_admin
DROP MATERIALIZED VIEW OIL_CNR.OIL_AGGREGATED_DATA_MV;
DROP MATERIALIZED VIEW OIL_CNR.OIL_COMMODITY_DATA_MV;
create synonym OIL_CNR.OIL_COMMODITY_DATA_MV for OIL_APDS.OIL_COMMODITY_DATA_MV;
create synonym OIL_CNR.OIL_AGGREGATED_DATA_MV for OIL_APDS.OIL_AGGREGATED_DATA_MV;



-- remove the temporary objects
--    note that, it's ok some objects don't exit 
@remove_old_temporary_objects.sql;


-- recompile all objects
connect / as sysdba
@$ORACLE_HOME/rdbms/admin/utlrp.sql;
-- double check status of all objects
SELECT *
  FROM all_objects
 WHERE owner IN
       ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR', 'OTD_CNR',
        'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS', 'STE_APDS',
        'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS', 'GFMS_APDS',
        'PLATTS', 'SDI', 'SPATIAL', 'NDA_CNR')
   AND status <> 'VALID';
------- ignore two objects below ------
------- SDI.SDI_COMMODITY_FLOW_UTIL_PKG ------


-- refresh all mviews (20 mins)
-- connect dba_admin/dba_admin
-- !!!!!! run the scripts in refresh_mviews_in_parallel.sql separately (8 sessions) !!!!!  
 
-- refresh some special mviews in sequence 
-- cost around 50 mins, coal flows refreshing run the longest
connect dba_admin/dba_admin
@refresh_mviews_in_sequence.sql;

-- collect statistics for CEF_APDS.HISTORICAL_CELL_VALUE_M_V, because this mview is recreated
EXECUTE DBMS_STATS.GATHER_TABLE_STATS(ownname=>'CEF_APDS',tabname=>'HISTORICAL_CELL_VALUE_M_V',estimate_percent=>100,degree=>8,cascade=> true);
 
-- unlock statistics of data schemas
connect dba_admin/dba_admin
@update_stats_locks.sql;

-- 

-- recollect statistics
@collect_db_statistics.sql;
-- !!!! haven't collected the time cost yet!!!! (cef_cnr recollecting takes 70 mins)

-- start all jobs
@start_jobs.sql;

-- grant special privs for DWH
@grant_privs_to_dwh.sql;



