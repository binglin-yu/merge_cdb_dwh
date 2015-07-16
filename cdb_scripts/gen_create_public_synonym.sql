set echo off heading off verify off feedback off linesize 100 pagesize 500 trimspool on

spool create_public_synonyms.sql

prompt spool create_public_synonyms.out

SELECT 'create public synonym ' || synonym_name || ' for ' ||
       decode(table_owner,
              'PLATTS',
              'PLATTS',
              'SDI',
              'SDI_CNR',
              'SPATIAL',
              'SPATIAL',
              table_owner) || '.' || table_name || ';'
  FROM dba_synonyms
 WHERE owner = 'PUBLIC'
   AND table_owner IN
       ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR', 'OTD_CNR',
        'FRT_CNR', 'GFMS_CNR', 'CEF_APDS', 'MPD2_APDS', 'STE_APDS',
        'OIL_APDS', 'EMS_APDS', 'OTD_APDS', 'FRT_APDS', 'GFMS_APDS',
        'PLATTS', 'SDI', 'SPATIAL', 'NDA_CNR')
   AND synonym_name NOT IN ('GET_ENVIRONMENT');
--

prompt spool off
spool off
