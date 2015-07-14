
execute dbms_refresh.destroy('STE_CNR.STE_CNR_30M_RG1');
commit;

begin
  dbms_scheduler.create_job(job_name        => 'STE_CNR.REFRESH_STE_CNR_30M_RG1',
                            job_type        => 'plsql_block',
                            job_action      => '
begin
dbms_mview.refresh(''STE_CNR.OPEC_QUOTA_LAST_CHAGE_DATE_M_V'');
end;
',
                            repeat_interval => 'freq=MINUTELY;interval=30',
                            enabled         => FALSE,
                            comments        => 'Job to refresh STE_CNR_30M_RG1 by 30mins. Note the sequences of mvs does not matter.',
                            START_DATE => TRUNC(SYSDATE));
end;
/

