
BEGIN
  dbms_scheduler.drop_job(job_name => 'REFRESH_COAL_FLOW_MV_GROUP',
                          force    => TRUE);
  dbms_scheduler.create_job(job_name        => 'REFRESH_COAL_FLOW_MV_GROUP',
                            job_type        => 'STORED_PROCEDURE',
                            job_action      => 'pkg_coal_flow_refreshing.refresh_data_trunk',
                            repeat_interval => 'freq=hourly;INTERVAL=2', 
                            number_of_arguments => 2,
                            enabled         => FALSE,
                            comments        => 'REFRESH COAL FLOW RELATED MVIEWS',
                            start_date      => trunc(SYSDATE, 'YYYY'));
                                        
  dbms_scheduler.set_job_argument_value(job_name          => 'REFRESH_COAL_FLOW_MV_GROUP',
                                        argument_position => 1,
                                        argument_value    => 'REFRESH_COAL_FLOW_MV_GROUP');
                                        
  dbms_scheduler.set_job_argument_value(job_name          => 'REFRESH_COAL_FLOW_MV_GROUP',
                                        argument_position => 2,
                                        argument_value    => null);
  dbms_scheduler.enable('REFRESH_COAL_FLOW_MV_GROUP');
END;
/