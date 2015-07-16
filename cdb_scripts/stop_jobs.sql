SET SERVEROUTPUT ON

DECLARE
  v_int INTEGER;
BEGIN
  FOR i IN (SELECT job
              FROM dba_jobs
             WHERE log_user IN
                   ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                    'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS',
                    'STE_APDS', 'OIL_APDS', 'EMS_APDS', 'OTD_APDS',
                    'FRT_APDS', 'GFMS_APDS', 'PLATTS_CNR', 'SDI_CNR',
                    'SPATIAL', 'NDA_CNR')
               AND broken = 'N') LOOP
    sys.dbms_ijob.broken(job => i.job, broken => TRUE);
  END LOOP;
  COMMIT;
  SELECT COUNT(1)
    INTO v_int
    FROM dba_jobs
   WHERE log_user IN
         ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR', 'OTD_CNR',
          'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS', 'STE_APDS',
          'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS', 'GFMS_APDS',
          'PLATTS_CNR', 'SDI_CNR', 'SPATIAL', 'NDA_CNR')
     AND (broken = 'N' OR this_date IS NOT NULL);
  IF v_int > 0 THEN
    dbms_output.put_line('Job is still running. Please wait a while and run this script again.');
  ELSE
    dbms_output.put_line('Jobs are stopped successfully. Please continue next step.');
  END IF;
END;
/

BEGIN
  FOR i IN (SELECT owner, job_name--, job_creator
              FROM dba_scheduler_jobs
             WHERE owner IN
                   ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                    'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS',
                    'STE_APDS', 'OIL_APDS', 'EMS_APDS', 'OTD_APDS',
                    'FRT_APDS', 'GFMS_APDS', 'PLATTS_CNR', 'SDI_CNR',
                    'SPATIAL', 'NDA_CNR')) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'begin dbms_scheduler.disable(''' || i.owner || '.' ||
                        i.job_name || ''',TRUE); end;';
      dbms_output.put_line(' scheduler job ' || i.owner || '.' ||
                           i.job_name || ' set disabled successfully!');
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('errors when setting scheduler job ' ||
                             i.owner || '.' || i.job_name ||
                             '  disabled');
        dbms_output.put_line('error_code:' || SQLCODE);
        dbms_output.put_line('error_megs:' || SQLERRM);
    END;
  END LOOP;
END;
/

