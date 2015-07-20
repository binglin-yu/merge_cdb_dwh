-- prompt MPD2_CNR must grant SELECT to CEF_CNR with grant option for these objects:
--------------------------------------------------------------------------
grant select on mpd2_cnr.GEOGRAPHIC_UNIT_CLASSIFICATION to cef_cnr with grant option;
grant select on mpd2_cnr.GEOGRAPHIC_UNIT_RELATIONSHIP to cef_cnr with grant option;


--prompt MPD2_CNR must grant SELECT to FACILITY for theis object:
--------------------------------------------------------
grant select on MPD2_CNR.GEOGRAPHIC_UNIT to facility;
grant select on MPD2_CNR.GEOGRAPHIC_UNIT_CLASS to facility;

--prompt CEF_CNR must grant SELECT to FACILITY for these objects:
--------------------------------------------------------
grant select on cef_cnr.ANCHORAGE to facility;
grant select on cef_cnr.BERTH to facility;
grant select on cef_cnr.COMMODITY_FLOW_ENUMERATION to facility;
grant select on cef_cnr.COMMODITY_FLOW_ORGANISATION to facility;
grant select on cef_cnr.COMMODITY_FLOW_POINT to facility;
grant select on cef_cnr.COMMODITY_FLOW_PRODUCT to facility;
grant select on cef_cnr.COMMODITY_FLOW_V to facility;
grant select on cef_cnr.DIMENSION_ITEM to facility;
grant select on cef_cnr.ORGANISATION_OA to facility;
grant select on cef_cnr.PHYSICAL_ASSET to facility;
grant select on cef_cnr.PHYSICAL_ASSET_NAME to facility;
grant select on cef_cnr.PHYSICAL_ASSET_TYPE to facility;
grant select on cef_cnr.PHYSICAL_ASSET_TYPE_RSHIP to facility;
grant select on cef_cnr.PIERS_TRANSACTION to facility;
grant select on cef_cnr.PORT to facility;
grant select on cef_cnr.PORT_GUN_RSHIP to facility;
grant select on cef_cnr.PORT_GUN_V to facility;
grant select on cef_cnr.UNDERLYING_PRODUCT to facility;
grant select on cef_cnr.UNDERLYING_PRODUCT_RSHIP to facility;
grant select on cef_cnr.VESSEL to facility;
grant select on cef_cnr.VESSEL_EVENT to facility;
grant select on cef_cnr.VESSEL_LOCATION to facility;
grant select on cef_cnr.VESSEL_ZONE to facility;
grant select on cef_cnr.VESSEL_ZONE_CLASSIFICATION to facility;
grant select on cef_cnr.VESSEL_ZONE_RSHIP to facility;
grant select on cef_cnr.VESSEL_ZONE_V to facility;
grant select on cef_cnr.VT_VESSEL_DETAIL to facility;

--prompt CEF_APDS must grant SELECT to FACILITY for these objects:
---------------------------------------------------------
grant select on CEF_APDS.CURRENT_ZONE_M_V to facility;
grant select on CEF_APDS.FIXTURE_M_V to facility;
grant select on CEF_APDS.PHYSICAL_ASSET_VES_M_V to facility;
grant select on CEF_APDS.PHYSICAL_ASSET_VZONE_M_V to facility;

