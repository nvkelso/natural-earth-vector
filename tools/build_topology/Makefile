all: ne_10m_physical_land_ocean_polygon_ouput.geojson

ne_10m_physical_land_ocean_polygon_ouput.geojson: \
	ne_10m_physical_land_ocean_line_input.geojson \
	ne_10m_physical_land_ocean_label_points.geojson
	python ne_10m_physical_land_ocean_line_input.geojson ne_10m_physical_land_ocean_polygon_ouput.geojson

ne_10m_physical_land_ocean_line_input.geojson: ne_10m_physical_land_ocean_line_input.shp ne_10m_physical_land_ocean_line_input.dbf
	rm -f ne_10m_physical_land_ocean_line_input.geojson
	ogr2ogr -f "GeoJSON" ne_10m_physical_land_ocean_line_input.geojson ne_10m_physical_land_ocean_line_input.shp

ne_10m_physical_land_ocean_line_input.shp: ../../10m_physical/ne_10m_coastline.shp ../../10m_physical/ne_10m_coastline.dbf \
	../../10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.shp ../../10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.dbf \
	../../10m_physical/ne_10m_land_ocean_seams.shp ../../10m_physical/ne_10m_land_ocean_seams.dbf
	rm -f ne_10m_physical_land_ocean_line_input.shp
	ogr2ogr -f "Esri Shapefile" ne_10m_physical_land_ocean_line_input.shp ../../10m_physical/ne_10m_coastline.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_physical_land_ocean_line_input.shp ../../10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_physical_land_ocean_line_input.shp ../../10m_physical/ne_10m_land_ocean_seams.shp
	
ne_10m_physical_land_ocean_label_points.geojson: ../../10m_physical/ne_10m_land_ocean_label_points.shp ../../10m_physical/ne_10m_land_ocean_label_points.dbf
	rm -f ne_10m_physical_land_ocean_label_points.geojson
	ogr2ogr -f "GeoJSON" ne_10m_physical_land_ocean_label_points.geojson ../../10m_physical/ne_10m_land_ocean_label_points.shp