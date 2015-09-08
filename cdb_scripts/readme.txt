/*
********************
* all steps are within migrate_cdb_sql.txt, which should be executed in sequence
*   * steps starting with "> " are supposed to run in sqlplus, while others should run as os-user directly
*   * steps in comments ("/**/"), are optional, or substitutes for some long-running steps. So, do read the comments before running the corresponding codes
*   * two steps are splitted into two sub-steps:
*   *    * validate_constraints_in_parallel.sql
*   *    * refresh_mviews_in_parallel.sql
*   *    * !!!! DO NOT run the above two sql files directly, but split them into two sub-steps separately
********************
*/


/*
* if temp tablespace isn't enough, extend it as below
-- collect the current data temp file locaiton
* SELECT f.tablespace_name, file_name
*   FROM sys.v_$temp_space_header f,
*        dba_temp_files           d,
*        sys.v_$temp_extent_pool  p
*  WHERE f.tablespace_name(+) = d.tablespace_name
*    AND f.file_id(+) = d.file_id
*    AND p.file_id(+) = d.file_id
* 
* -- return "TEMP /n02/oradata1/orp723/orp723a_temp01.dbf"
* -- add more tmpfiles, similar as below
* ALTER  TABLESPACE TEMP ADD TEMPFILE '/n02/oradata1/orp723/orp723a_temp01_01.dbf' SIZE 30G AUTOEXTEND ON;
* ALTER  TABLESPACE TEMP ADD TEMPFILE '/n02/oradata1/orp723/orp723a_temp01_02.dbf' SIZE 30G AUTOEXTEND ON;
* ALTER  TABLESPACE TEMP ADD TEMPFILE '/n02/oradata1/orp723/orp723a_temp01_03.dbf' SIZE 30G AUTOEXTEND ON;
* ALTER  TABLESPACE TEMP ADD TEMPFILE '/n02/oradata1/orp723/orp723a_temp01_04.dbf' SIZE 30G AUTOEXTEND ON;
* ALTER  TABLESPACE TEMP ADD TEMPFILE '/n02/oradata1/orp723/orp723a_temp01_05.dbf' SIZE 30G AUTOEXTEND ON;
*/
