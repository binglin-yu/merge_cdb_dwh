-- disable all R constraints
BEGIN
  FOR tmp IN (SELECT *
                FROM dba_constraints
               WHERE owner IN
                     ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                      'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS',
                      'MPD2_APDS', 'STE_APDS', 'OIL_APDS', 'EMS_APDS',
                      'OTD_APDS', 'FRT_APDS', 'GFMS_APDS', 'PLATTS_CNR',
                      'SDI_CNR', 'SPATIAL_CNR', 'NDA_CNR')
                 AND constraint_type IN ('R')) LOOP
    EXECUTE IMMEDIATE 'alter table ' || tmp.owner || '.' || tmp.table_name ||
                      ' disable constraint ' || tmp.constraint_name;
  END LOOP;
END;
/

-- disable some specific constraints
BEGIN
  FOR tmp IN (SELECT *
                FROM all_constraints
               WHERE table_name IN
                     ('VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION',
                      'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE')
                 AND constraint_type IN ('P', 'U')) LOOP
    EXECUTE IMMEDIATE 'alter table ' || tmp.owner || '.' || tmp.table_name ||
                      ' disable constraint ' || tmp.constraint_name;
  END LOOP;
END;
/

