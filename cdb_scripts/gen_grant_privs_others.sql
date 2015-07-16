set echo off heading off verify off feedback off linesize 100 pagesize 500 trimspool on

spool grant_privs_others.sql
prompt spool grant_privs_others.out

SELECT 'grant ' || privilege || ' on ' || owner || '.' || table_name ||
       ' to ' || grantee || ';'
  FROM dba_tab_privs
 WHERE grantee IN
       ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR', 'OTD_CNR',
        'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS', 'STE_APDS',
        'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS', 'GFMS_APDS',
        'PLATTS', 'SDI', 'SPATIAL', 'NDA_CNR')
   AND (grantor IN
       ('APEX_PUBLIC_USER', 'FLOWS_FILES', 'APEX_040200', 'ORDSYS',
        'ORDPLUGINS', 'SI_INFORMTN_SCHEMA', 'MDSYS', 'SYS')
       /*OR
                     owner IN
                     ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR', 'OTD_CNR',
                      'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS', 'STE_APDS',
                      'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS', 'GFMS_APDS',
                      'PLATTS', 'SDI', 'SPATIAL', 'NDA_CNR')*/ --
       );
--

prompt spool off
spool off;

