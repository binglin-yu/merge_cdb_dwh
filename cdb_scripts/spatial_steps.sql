-----------------------------
-- Vessel Polygon Metadata --
-----------------------------

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('VESSEL_ZONE_GEOMETRY',
   'POLYGON',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('PORT_GEOMETRY',
   'POLYGON',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('BERTH_GEOMETRY',
   'POLYGON',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('ANCHORAGE_GEOMETRY',
   'POLYGON',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

CREATE INDEX vzg_spatial_i ON vessel_zone_geometry(polygon) indextype IS mdsys.spatial_index;

CREATE INDEX por_spatial_i ON port_geometry(polygon) indextype IS mdsys.spatial_index;

CREATE INDEX bge_spatial_i ON berth_geometry(polygon) indextype IS mdsys.spatial_index;

CREATE INDEX anc_spatial_i ON anchorage_geometry(polygon) indextype IS mdsys.spatial_index;

---------------------------
-- Vessel Point Metadata --
---------------------------

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('VESSEL_ZONE_GEOMETRY',
   'POINT',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('PORT_GEOMETRY',
   'POINT',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('BERTH_GEOMETRY',
   'POINT',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

INSERT INTO user_sdo_geom_metadata
  (table_name, column_name, diminfo, srid)
VALUES
  ('ANCHORAGE_GEOMETRY',
   'POINT',
   sdo_dim_array(sdo_dim_element('LONGITUDE', -180, 180, 0.05),
                 sdo_dim_element('LATITUDE', -90, 90, 0.05)),
   4326 -- SRID
   );

COMMIT;

------------------------
-- Vessel Point Index --
------------------------

CREATE INDEX vzg_spatial_point_i ON vessel_zone_geometry(point) indextype IS mdsys.spatial_index;

CREATE INDEX por_spatial_point_i ON port_geometry(point) indextype IS mdsys.spatial_index;

CREATE INDEX bge_spatial_point_i ON berth_geometry(point) indextype IS mdsys.spatial_index;

CREATE INDEX anc_spatial_point_i ON anchorage_geometry(point) indextype IS mdsys.spatial_index;

