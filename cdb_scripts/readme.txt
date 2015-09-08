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

