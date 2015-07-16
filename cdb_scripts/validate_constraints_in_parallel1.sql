

-- run it as dba_admin
set serveroutput on
spool validate_constraints_in_parallel.out
DECLARE
  l_lst          cef_cnr.ce_str_lst_t;
  l_flag         NUMBER;
  l_pipe_name    VARCHAR2(100) := 'BYU_CONSTRAINT_LIST';
  l_receiver_cnt NUMBER := 8;
  l_msg_timeout  NUMBER := 5;
  l_cnt          NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO l_cnt
    FROM user_tables
   WHERE table_name = 'BYU_CONSTRAINT_LIST_LOG';
  IF l_cnt = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE BYU_CONSTRAINT_LIST_LOG 
AS SELECT OWNER, TABLE_NAME, CONSTRAINT_NAME, SYSDATE ST, SYSDATE ET FROM USER_CONSTRAINTS WHERE 0 = 1';
  ELSE
    EXECUTE IMMEDIATE 'TRUNCATE TABLE BYU_CONSTRAINT_LIST_LOG';
  END IF;

  SELECT DISTINCT v BULK COLLECT
    INTO l_lst
    FROM (SELECT owner || '.' || table_name v --owner || '.' || table_name || '.' || constraint_name v          
            FROM all_constraints
           WHERE owner IN
                 ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                  'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS',
                  'STE_APDS', 'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS',
                  'GFMS_APDS', 'PLATTS', 'SDI', 'SPATIAL',
                  'NDA_CNR') /*
             AND table_name NOT IN
                 ('VESSEL_LOCATION', 'VESSEL_EVENT', 'PIERS_TRANSACTION',
                  'PROCESSING_DETAIL', 'HISTORICAL_CELL_VALUE') */
             AND (validated <> 'VALIDATED' OR status <> 'ENABLED')
             AND constraint_type = 'R'
           ORDER BY owner, table_name);

  l_flag := dbms_pipe.create_pipe(l_pipe_name);
  IF l_receiver_cnt <= 0 THEN
    raise_application_error(-20999,
                            'ERROR in send_message, expect to have non-zero l_receiver_cnt : pipename(' ||
                            l_pipe_name || '), l_receiver_cnt(' ||
                            l_receiver_cnt || ')');
  END IF;
  IF l_flag = 0 THEN
  
    IF l_lst IS NOT NULL THEN
      FOR i IN 1 .. l_lst.COUNT LOOP
        --dbms_lock.sleep(1);
        dbms_pipe.pack_message(l_lst(i));
        l_flag := dbms_pipe.send_message(l_pipe_name);
        --        l_flag := dbms_pipe.send_message(l_pipe_name, l_msg_timeout);
        IF l_flag <> 0 THEN
          raise_application_error(-20999,
                                  'ERROR in send_message : pipename(' ||
                                  l_pipe_name || '), l_receiver_cnt(' ||
                                  l_receiver_cnt || '), i(' || i ||
                                  '), msg(' || l_lst(i) ||
                                  '), return_flag(' || l_flag || ')');
          l_flag := dbms_pipe.remove_pipe(l_pipe_name);
        END IF;
      END LOOP;
    END IF;
    /*
    FOR i IN 1 .. l_receiver_cnt LOOP
      dbms_pipe.pack_message('END');
      l_flag := dbms_pipe.send_message(l_pipe_name, l_msg_timeout);
    END LOOP;
    */
  END IF;
END;
/

spool off

-- run the following codes in multiple sessions to validate constraints, 
-- suggestion: 
--          1) put codes into file (e.g. /tmp/validate_constraints.sql), and run the cmds, in multiple times
--          2) nohup sqlplus dba_admin/dba_admin < /tmp/validate_constraints.sql &

set serveroutput on

DECLARE
  l_msg       VARCHAR2(100);
  l_flag      NUMBER := 0;
  l_cnt       NUMBER := 0;
  l_pipe_name VARCHAR2(100) := 'BYU_CONSTRAINT_LIST';
  l_st        DATE;
BEGIN
  WHILE l_flag = 0 LOOP
    l_cnt  := l_cnt + 1;
    l_flag := dbms_pipe.receive_message(l_pipe_name, 10);
    IF l_flag = 0 THEN
      dbms_pipe.unpack_message(l_msg);
      dbms_output.put_line(l_cnt || ' : ' || l_msg);
    
      FOR tmp IN (SELECT *
                    FROM all_constraints
                   WHERE owner || '.' || table_name = l_msg
                     AND (validated <> 'VALIDATED' OR status <> 'ENABLED')
                   ORDER BY owner, table_name, constraint_name) LOOP
        l_st := SYSDATE;
        INSERT INTO byu_constraint_list_log
        VALUES
          (tmp.owner, tmp.table_name, tmp.constraint_name, l_st, NULL);
        COMMIT;
        EXECUTE IMMEDIATE ' ALTER TABLE ' || tmp.owner || '.' ||
                          tmp.table_name || ' modify CONSTRAINT
                      ' || tmp.constraint_name ||
                          ' enable ';
        UPDATE byu_constraint_list_log
           SET et = SYSDATE
         WHERE owner = tmp.owner
           AND table_name = tmp.table_name
           AND constraint_name = tmp.constraint_name
           AND st = l_st;
        COMMIT;
      END LOOP;
    
    END IF;
  END LOOP;
  dbms_output.put_line('l_flag : ' || l_flag);
  dbms_output.put_line('remove pipeline : ' ||
                       dbms_pipe.remove_pipe(l_pipe_name));
END;
/


