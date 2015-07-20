drop materialized view CEF_CNR.COMMODITY_FLOW_HIS_M_V_1;
drop materialized view CEF_CNR.COMMODITY_FLOW_HIS_M_V_2;
drop materialized view CEF_CNR.VZT_MAPPING_MV;
drop materialized view MPD2_APDS.AGGREGATE_CPT_FORMAT_M_V01;
drop materialized view MPD2_APDS.AGGREGATE_CPT_FORMAT_M_V02;
drop materialized view MPD2_APDS.AGGREGATE_CPT_M_V01;
drop materialized view MPD2_APDS.AGGREGATE_CPT_M_V02;
drop materialized view MPD2_APDS.PRODUCTION_CAPACITY01_M_V;
drop materialized view MPD2_APDS.PRODUCTION_CAPACITY02_M_V;

drop table CEF_APDS.vessel_latest_polygons_bk;
drop table CEF_APDS.vessel_latest_track_bk;
drop table CEF_APDS.vessel_previous_port_bk;
drop table CEF_APDS.vessel_fact_details_latest_bk;
drop table CEF_APDS.fixture_m_v_bk;
drop table CEF_APDS.fixture_region_assoc_m_v_bk;
drop table CEF_APDS.vessel_flow_m_v_bk;
drop table CEF_APDS.vessel_flow_fixture_m_v_bk;
drop table CEF_CNR.vt_vessel_m_v_bk;

drop materialized view cef_cnr.commodity_flow_m_v;

drop table MPD2_APDS.aggregate_cpt;
drop table MPD2_APDS.AGGREGATE_CPT_FORMAT;
drop table MPD2_APDS.production_capacity_yr;
drop table MPD2_APDS.production_capacity_base;