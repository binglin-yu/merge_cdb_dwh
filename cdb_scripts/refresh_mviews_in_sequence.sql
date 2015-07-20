-- run them in two groups
-- group 2, will run the longest (more than 30 mins)


-- group 1
set timing on
connect MPD2_CNR/MPD2_CNR
execute MPD2_CNR.REFRESH_GEO_UNIT;

connect STE_CNR/STE_CNR
execute ste_cnr.feed_steo_statistic_result;


connect CEF_APDS/CEF_APDS
execute cef_apds.ws_util_pkg.refresh_physicalasset_mvs_proc;

connect CEF_APDS/CEF_APDS
execute dbms_mview.refresh('CEF_APDS.HISTORICAL_CELL_VALUE_M_V', 'C');
execute dbms_mview.refresh('CEF_APDS.REPORT_TIME_SPAN_M_V','c');

connect OIL_APDS/OIL_APDS
execute dbms_mview.refresh('OIL_APDS.OIL_COMMODITY_DATA_MV','C');
execute dbms_mview.refresh('OIL_APDS.OIL_AGGREGATED_DATA_MV','C');



connect STE_APDS/STE_APDS
execute ste_apds.refresh_ste_cnr;





--group 2
execute CEF_APDS.pkg_coal_flow_refreshing.refresh_data_trunk('BYU_TEST_COAL_FLOW', NULL);
-- note if, the procedure failed, refresh the following mviews manually:
EXECUTE dbms_mview.refresh(LIST=>'CEF_APDS.COAL_FLOW_HISTORY_M_V',ATOMIC_REFRESH=>FALSE);
EXECUTE dbms_mview.refresh(LIST=>'CEF_APDS.COAL_FLOW_FORECAST_EXPORT_M_V',ATOMIC_REFRESH=>FALSE);
EXECUTE dbms_mview.refresh(LIST=>'CEF_APDS.COAL_FLOW_FORECAST_IMPORT_M_V',ATOMIC_REFRESH=>FALSE);
