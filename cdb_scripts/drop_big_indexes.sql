
BEGIN
  FOR tmp IN (SELECT *
                FROM all_indexes
               WHERE table_name IN
                     ('VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION',
                      'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE')
                 AND owner IN ('CEF_CNR')) LOOP
    EXECUTE IMMEDIATE 'drop index ' || tmp.owner || '.' || tmp.index_name;
  END LOOP;
END;
/

