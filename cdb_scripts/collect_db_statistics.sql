
BEGIN
  FOR tmp IN (SELECT *
                FROM all_users
               WHERE username IN
                     ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                      'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS',
                      'MPD2_APDS', 'STE_APDS', 'OIL_APDS', 'EMS_APDS',
                      'OTD_APDS', 'FRT_APDS', 'GFMS_APDS', 'PLATTS',
                      'SDI_CNR', 'SPATIAL', 'NDA_CNR')) LOOP
    dbms_stats.gather_schema_stats(ownname          => tmp.username,
                                   estimate_percent => 100,
                                   degree           => 8);
  END LOOP;
END;
/

