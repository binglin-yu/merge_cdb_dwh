drop materialized view cef_apds.historical_cell_value_m_v;

CREATE materialized view cef_apds.historical_cell_value_m_v
	tablespace cef_apds_data01 nologging 
	PARTITION BY RANGE(id) INTERVAL(1000000) 
	SUBPARTITION BY list(dit_minor_period_unit_id)
	(PARTITION p0 VALUES less than(1000000))
	build deferred 
	refresh force ON demand 
AS
  SELECT hcv.ROWID hcv_rowid,
         rls.ROWID rls_rowid,
         hcv.id,
         VALUE,
         rce_id,
         dit_accuracy_level_id,
         dit_minor_period_unit_id,
         rls.id rls_id,
         period_start,
         period_end,
         report_date,
         release_date
    FROM historical_cell_value hcv, report_release rls
   WHERE hcv.end_date IS NULL
     AND hcv.rls_id = rls.id;
