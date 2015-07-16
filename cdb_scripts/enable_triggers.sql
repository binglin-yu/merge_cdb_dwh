BEGIN
  FOR tmp IN (SELECT *
                FROM dba_triggers
               WHERE owner IN
                     ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                      'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS',
                      'MPD2_APDS', 'STE_APDS', 'OIL_APDS', 'EMS_APDS',
                      'OTD_APDS', 'FRT_APDS', 'GFMS_APDS', 'PLATTS',
                      'SDI', 'SPATIAL', 'NDA_CNR')) LOOP
    EXECUTE IMMEDIATE 'alter trigger ' || tmp.owner || '.' ||
                      tmp.trigger_name || ' enable';
  END LOOP;
END;
/

