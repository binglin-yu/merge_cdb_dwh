execute dbms_refresh.destroy('EMS_APDS.EMS_APDS_6H_RG1');
commit;
begin
  dbms_scheduler.create_job(job_name        => 'EMS_APDS.REFRESH_EMS_APDS_6H_RG1',
                            job_type        => 'plsql_block',
                            job_action      => '
begin
dbms_mview.refresh(''EMS_APDS.CDM_AGGREGATED_M_V'');
dbms_mview.refresh(''EMS_APDS.CITL_AGGREGATED_STATISTICS_M_V'');
dbms_mview.refresh(''EMS_APDS.CITL_DERIVED_STATISTICS_M_V'');
end;
',
                            repeat_interval => 'freq=HOURLY;interval=6',
                            enabled         => FALSE,
                            comments        => 'Job to refresh EMS_APDS_6H_RG1 by 6 hours. Note the sequences of mvs does not matter.',
                            START_DATE => TRUNC(SYSDATE));
end;
/

