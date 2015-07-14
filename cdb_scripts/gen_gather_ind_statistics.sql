SET SERVEROUTPUT ON
set feedback off
set linesize 1000
set timing off
SPOOL gather_ind_statistics.sql;

BEGIN
  FOR tmp IN (SELECT index_name
                FROM all_indexes
               WHERE owner = 'CEF_CNR'
                 AND table_name IN
                     ('VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION',
                      'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE')) LOOP
    dbms_output.put_line('EXECUTE DBMS_STATS.GATHER_INDEX_STATS(ownname=>''CEF_CNR'',indname=>''' ||
                         tmp.index_name ||
                         ''',estimate_percent=>100,degree=>8);');
  END LOOP;
END;
/

set feedback on
SPOOL OFF
set timing on

