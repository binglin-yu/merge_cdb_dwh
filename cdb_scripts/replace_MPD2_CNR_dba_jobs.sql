
execute DBMS_JOB.REMOVE(23546717);
commit;

begin
  dbms_scheduler.create_job(job_name        => 'MPD2_CNR.REFRESH_MPD2_CNR_1D_RG1',
                            job_type        => 'stored_procedure',
                            job_action      => 'MPD2_CNR.REFRESH_GEO_UNIT',
                            repeat_interval => 'freq=DAILY;interval=1',
                            enabled         => FALSE,
                            comments        => 'Job to refresh MPD2_CNR_1D_RG1 by 1 day. Note the sequences of mvs does not matter.',
                            START_DATE => TRUNC(SYSDATE));
end;
/

