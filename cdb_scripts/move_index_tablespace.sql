set serveroutput on

spool move_index_tablespace.out
BEGIN
  FOR tmp IN (--
  SELECT t.*,
         'alter index ' || t.owner || '.' || t.index_name ||
         ' rebuild tablespace ' || t.tablespace_name sql_str
    FROM (SELECT ind.owner,
                 ind.index_name,
                 ind.owner || '_INDEX01' tablespace_name
            FROM dba_indexes ind, all_tables tab
           WHERE ind.owner IN
                 ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                  'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS',
                  'STE_APDS', 'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS',
                  'GFMS_APDS', 'PLATTS_CNR', 'SDI_CNR', 'SPATIAL',
                  'NDA_CNR')
             AND ind.index_type NOT IN ('LOB', 'DOMAIN')
             AND ind.table_owner = tab.owner
             AND ind.table_name = tab.table_name
             AND NVL(tab.temporary,'N') <> 'Y'
             AND tab.table_name NOT IN
                 ('VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION',
                  'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE')) t
              --WHERE rownum <= 1
              ) LOOP
    dbms_output.put_line(tmp.sql_str);
    EXECUTE IMMEDIATE tmp.sql_str;
  
  END LOOP;
END;
/

spool off
