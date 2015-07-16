BEGIN
  FOR tmp IN (SELECT t.*,
                     (SELECT status
                        FROM all_objects s
                       WHERE s.owner = t.owner
                         AND s.object_name = t.synonym_name
                         AND s.object_type = 'SYNONYM') status
                FROM dba_synonyms t
               WHERE synonym_name IN
                     ('SWITCH_PDS_TAB', 'STAT_TYPE', 'STAT_PERIOD_TYPE',
                      'STAT_PERIOD_GROUP', 'STATUS_TYPE_VALUE', 'STATUS_TYPE',
                      'RECURSIVE_GUR', 'PLANT_V', 'PLANT_TYPE',
                      'PLANT_SYNC_DETAILS', 'PLANT_STATUS_V', 'PLANT_STATUS',
                      'PLANT_SHARE_TOTALS_V', 'PLANT_SHAREHOLDER_V',
                      'PLANT_SHAREHOLDER', 'PLANT_KEYWORD_V', 'PLANT_KEYWORD',
                      'PLANT_IMAGE', 'PLANT_COMMODITY_TYPE_V',
                      'PLANT_COMMODITY_TYPE_NOTE', 'PLANT_COMMODITY_TYPE',
                      'PLANT_COMMODITY_DATA_V', 'PLANT_COMMODITY_DATA',
                      'PLANT', 'PK_USER_AUTHENTICATION', 'ORGANISATION_V',
                      'ORGANISATION_SHAREHOLDING_V',
                      'ORGANISATION_SHAREHOLDING', 'ORGANISATION',
                      'MEASUREMENT_TYPE', 'MEASUREMENT', 'KEYWORD_TYPE',
                      'KEYWORD_EXEMPT_V', 'KEYWORD_EXEMPT', 'INDUSTRY_NEWS',
                      'IMAGE_TYPE', 'IMAGE', 'GET_ENVIRONMENT',
                      'GEOG_COMMODITY_GROUP_ASSOC',
                      'GEOGRAPHIC_UNIT_RELATIONSHIP',
                      'GEOGRAPHIC_UNIT_CLASSIFICATION',
                      'GEOGRAPHIC_UNIT_CLASS', 'GEOGRAPHIC_UNIT',
                      'GEOGRAPHIC_REGIONS_V', 'FRT_TIME_SPAN',
                      'FRT_FLEET_TYPE', 'FRT_FLEET_SUPER_TYPE',
                      'FRT_FLEET_SIZE', 'FRT_FLEET_DATA', 'FORMAT_TYPE',
                      'EXPORTED_MSTOCK_USER', 'EXPORTED_MSTOCK_TEMP',
                      'EXPORTED_MSTOCK_LAST', 'EXPORTED_MSTOCK',
                      'DATA_VALIDITY_TYPE', 'COUNTRY_ISO_CODE_M_V',
                      'COMMODITY_TYPE', 'COMMODITY_PLANT_TYPE',
                      'COMMODITY_GROUP_FORMAT_TYPE', 'COMMODITY_GROUP',
                      'CITY_COUNTRY_M_V', 'APPLICATION_USERS', 'AGG_TEMP',
                      'AGGREGATED_DATA_02', 'AGGREGATED_DATA_01',
'NTS_COMMODITY_TS', 'IDENTIFIER', 'GEOG_STRUCTURE',
        'GEOG', 'CLASSIFIER_MAP', 'CLASSIFIER')
                 AND owner = 'PUBLIC'
                 AND synonym_name NOT IN ('GET_ENVIRONMENT')
                 AND table_owner IN
                     ('CEF_CNR', 'MPD2_CNR', 'STE_CNR', 'OIL_CNR', 'EMS_CNR',
                      'OTD_CNR', 'FRT_CNR', 'GFMS_CNR', 'CEF_APDS',
                      'MPD2_APDS', 'STE_APDS', 'OIL_APDS', 'EMS_APDS',
                      'OTD_APDS', 'FRT_APDS', 'GFMS_APDS', 'PLATTS',
                      'SDI', 'SPATIAL', 'NDA_CNR')) LOOP
    EXECUTE IMMEDIATE 'drop public synonym ' || tmp.synonym_name;
  END LOOP;
END;
/

