set serveroutput on
set feedback off
set timing off

spool enable_non_r_constraints.sql;

BEGIN
  FOR tmp IN (SELECT 'alter table ' || owner || '.' || table_name ||
                     ' modify constraint ' || constraint_name || ' enable;' str
                FROM all_constraints
               WHERE owner IN
                     ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                      'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS',
                      'MPD2_APDS', 'STE_APDS', 'OIL_APDS', 'EMS_APDS',
                      'OTD_APDS', 'FRT_APDS', 'GFMS_APDS', 'PLATTS',
                      'SDI', 'SPATIAL', 'NDA_CNR')
                 AND (validated <> 'VALIDATED' OR status <> 'ENABLED')
                 AND constraint_type <> 'R'
               ORDER BY owner, table_name, constraint_name) LOOP
    dbms_output.put_line(tmp.str);
  END LOOP;
END;
/

spool off
set feedback on
set timing on
