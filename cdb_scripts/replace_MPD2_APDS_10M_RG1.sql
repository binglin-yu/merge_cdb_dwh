execute dbms_refresh.destroy('MPD2_APDS.MPD2_APDS_10M_RG1');
commit;
begin
  dbms_scheduler.create_job(job_name        => 'MPD2_APDS.REFRESH_MPD2_APDS_10M_RG1',
                            job_type        => 'plsql_block',
                            job_action      => '
begin
dbms_mview.refresh(''MPD2_APDS.LATEST_NTS_NUC_PLANT_V'');
dbms_mview.refresh(''MPD2_APDS.NTS_NUC_PLANT_M_V'');
dbms_mview.refresh(''MPD2_APDS.NUC_DAY_OUT_AGG'');
dbms_mview.refresh(''MPD2_APDS.PLANT_COMMODITY_TYPE_M_V'');
dbms_mview.refresh(''MPD2_APDS.PLANT_COMMODITY_TYPE_NOTE_M_V'');
end;
',
                            repeat_interval => 'freq=MINUTELY;interval=10',
                            enabled         => FALSE,
                            comments        => 'Job to refresh MPD2_APDS_10M_RG1 by 10 minutes. Note the sequences of mvs does not matter.',
                            START_DATE => TRUNC(SYSDATE));
end;
/

