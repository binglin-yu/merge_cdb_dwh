set serveroutput on

BEGIN
  FOR i IN (SELECT *
              FROM dba_jobs
             WHERE log_user IN
                   ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                    'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS',
                    'STE_APDS', 'OIL_APDS', 'EMS_APDS', 'OTD_APDS',
                    'FRT_APDS', 'GFMS_APDS', 'PLATTS', 'SDI_CNR',
                    'SPATIAL', 'NDA_CNR')
               AND broken = 'Y') LOOP
    BEGIN
      sys.dbms_ijob.broken(i.job, FALSE);
      COMMIT;
      dbms_output.put_line('job ' || i.job || ' started successfully!');
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('errors when setting job ' || i.job ||
                             '  broken');
        dbms_output.put_line('error_code:' || SQLCODE);
        dbms_output.put_line('error_megs:' || SQLERRM);
    END;
  END LOOP;
END;
/

BEGIN
  FOR i IN (SELECT owner, job_name--, job_creator
              FROM dba_scheduler_jobs
             WHERE owner IN
                   ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                    'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS',
                    'STE_APDS', 'OIL_APDS', 'EMS_APDS', 'OTD_APDS',
                    'FRT_APDS', 'GFMS_APDS', 'PLATTS', 'SDI_CNR',
                    'SPATIAL', 'NDA_CNR')) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'begin dbms_scheduler.enable(''' || i.owner || '.' ||
                        i.job_name || '''); end;';
      dbms_output.put_line(' scheduler job ' || i.owner || '.' ||
                           i.job_name || ' set enabled successfully!');
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('errors when setting scheduler job ' ||
                             i.owner || '.' || i.job_name ||
                             '  enabled');
        dbms_output.put_line('error_code:' || SQLCODE);
        dbms_output.put_line('error_megs:' || SQLERRM);
    END;
  END LOOP;
END;
/

