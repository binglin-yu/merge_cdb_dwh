
execute DBMS_JOB.REMOVE(29014833);
execute DBMS_JOB.REMOVE(29014835);
commit;

begin
  dbms_scheduler.create_job(job_name        => 'EMS_CNR.REFRESH_EMS_CNR_12H_RG1',
                            job_type        => 'plsql_block',
                            job_action      => '
begin
dbms_mview.refresh(''EMS_CNR.CITL_DERIVED_STATISTICS_M_V'');
dbms_mview.refresh(''EMS_CNR.CITL_AGGREGATED_STATISTICS_M_V'');
end;
',
                            repeat_interval => 'freq=HOURLY;interval=12',
                            enabled         => FALSE,
                            comments        => 'Job to refresh EMS_CNR_12H_RG1 by 12 hours. Note the sequences of mvs does not matter.',
                            START_DATE => TRUNC(SYSDATE));
end;
/

