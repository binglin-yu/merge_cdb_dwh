SET SERVEROUTPUT ON
set feedback off
set linesize 1000
set timing off

SPOOL remove_tmp_indexes.sql;

BEGIN
  FOR tmp IN (SELECT owner,
                     constraint_name,
                     table_name,
                     new_ind_name,
                     column_name,
                     'CREATE INDEX ' || t.new_ind_name || ' on ' || t.owner ||
                     ' ( ' || t.column_name || ') PARALLEL 8;' ind_creation_str
                FROM (SELECT t.owner,
                             t.constraint_name,
                             t.table_name,
                             t.owner || '.' || t.constraint_name || '_BYU_T' new_ind_name,
                             MAX(column_name) column_name,
                             COUNT(1) cnt
                        FROM all_constraints t, all_cons_columns s
                       WHERE t.table_name IN
                             ('VESSEL_LOCATION', 'VESSEL_EVENT',
                              'PIERS_TRANSACTION', 'PROCESSING_DETAIL',
                              'HISTORICAL_CELL_VALUE')
                         AND t.owner = 'CEF_CNR'
                         AND t.owner = s.owner
                         AND t.constraint_name = s.constraint_name
                         AND t.constraint_type = 'R'
                       GROUP BY t.owner, t.table_name, t.constraint_name
                      HAVING COUNT(1) = 1) t
               WHERE NOT EXISTS (SELECT 1
                        FROM all_ind_columns c
                       WHERE t.owner = c.index_owner
                         AND t.column_name = c.column_name
                         AND t.table_name = c.table_name)) LOOP
    dbms_output.put_line('DROP INDEX ' || tmp.new_ind_name || ';');
  END LOOP;
END;
/

SPOOL OFF

SET SERVEROUTPUT ON
set feedback off
SPOOL create_tmp_indexes.sql;

BEGIN
  FOR tmp IN (SELECT owner,
                     constraint_name,
                     table_name,
                     new_ind_name,
                     column_name,
                     'CREATE INDEX ' || t.new_ind_name || ' on ' || t.owner || '.' || t.table_name ||
                     ' ( ' || t.column_name || ') PARALLEL 8 tablespace CEF_CNR_INDEX01;' ind_creation_str
                FROM (SELECT t.owner,
                             t.constraint_name,
                             t.table_name,
                             t.owner || '.' || t.constraint_name || '_BYU_T' new_ind_name,
                             MAX(column_name) column_name,
                             COUNT(1) cnt
                        FROM all_constraints t, all_cons_columns s
                       WHERE t.table_name IN
                             ('VESSEL_LOCATION', 'VESSEL_EVENT',
                              'PIERS_TRANSACTION', 'PROCESSING_DETAIL',
                              'HISTORICAL_CELL_VALUE')
                         AND t.owner = 'CEF_CNR'
                         AND t.owner = s.owner
                         AND t.constraint_name = s.constraint_name
                         AND t.constraint_type = 'R'
                       GROUP BY t.owner, t.table_name, t.constraint_name
                      HAVING COUNT(1) = 1) t
               WHERE NOT EXISTS (SELECT 1
                        FROM all_ind_columns c
                       WHERE t.owner = c.index_owner
                         AND t.column_name = c.column_name
                         AND t.table_name = c.table_name)) LOOP
    dbms_output.put_line(tmp.ind_creation_str);
  END LOOP;
END;
/
SPOOL OFF

set feedback on
set timing on