
-- run it as dba_admin
set serveroutput on
spool validate_constraints_in_parallel.out
DECLARE
  l_lst          cef_cnr.ce_str_lst_t;
  l_flag         NUMBER;
  l_pipe_name    VARCHAR2(100) := 'BYU_CONSTRAINT_LIST';
  l_receiver_cnt NUMBER := 8;
  l_msg_timeout  NUMBER := 5;
BEGIN
  SELECT owner || '.' || table_name || '.' || constraint_name v BULK COLLECT
    INTO l_lst
    FROM all_constraints
   WHERE owner IN
         ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR', 'OTD_CNR',
          'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS', 'STE_APDS',
          'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS', 'GFMS_APDS',
          'PLATTS_CNR', 'SDI_CNR', 'SPATIAL_CNR', 'NDA_CNR')
     AND (validated <> 'VALIDATED' OR status <> 'ENABLED')
  --and constraint_type = 'R'
   ORDER BY owner, table_name, constraint_name;

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
BEGIN
  WHILE l_flag = 0 LOOP
    l_cnt  := l_cnt + 1;
    l_flag := dbms_pipe.receive_message(l_pipe_name, 10);
    IF l_flag = 0 THEN
      dbms_pipe.unpack_message(l_msg);
      dbms_output.put_line(l_cnt || ' : ' || l_msg);
    
      FOR tmp IN (SELECT *
                    FROM all_constraints
                   WHERE owner || '.' || table_name || '.' ||
                         constraint_name = l_msg
                   ORDER BY owner, table_name, constraint_name) LOOP
        EXECUTE IMMEDIATE ' ALTER TABLE ' || tmp.owner || '.' ||
                          tmp.table_name || ' modify CONSTRAINT
                      ' || tmp.constraint_name ||
                          ' enable ';
      END LOOP;
    
    END IF;
  END LOOP;
  dbms_output.put_line('l_flag : ' || l_flag);
  dbms_output.put_line('remove pipeline : ' ||
                       dbms_pipe.remove_pipe(l_pipe_name));
END;
/


