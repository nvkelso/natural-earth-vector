all: ne_10m_physical_land_ocean_polygon_output.geojson \
	ne_10m_minor_islands_polygon_output.geojson \
	ne_10m_cultural_admin_0_polygon_output.geojson \
	ne_10m_cultural_admin_1_polygon_output.geojson
	touch all

ne_10m_physical_land_ocean_polygon_output.geojson: \
	ne_10m_physical_land_ocean_line_input.geojson \
	ne_10m_physical_land_ocean_label_points.geojson
	python polygonize.py ne_10m_physical_land_ocean_line_input.geojson ne_10m_physical_land_ocean_polygon_output.geojson

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
	


ne_10m_cultural_admin_0_polygon_output.geojson: \
	ne_10m_cultural_admin_0_line_input.geojson \
	ne_10m_cultural_admin_0_label_points.geojson
	rm -f ne_10m_cultural_admin_0_polygon_output.geojson
	python polygonize.py ne_10m_cultural_admin_0_line_input.geojson ne_10m_cultural_admin_0_polygon_output.geojson

ne_10m_cultural_admin_0_line_input.geojson: ne_10m_cultural_admin_0_line_input.shp ne_10m_cultural_admin_0_line_input.dbf
	rm -f ne_10m_cultural_admin_0_line_input.geojson
	ogr2ogr -f "GeoJSON" ne_10m_cultural_admin_0_line_input.geojson ne_10m_cultural_admin_0_line_input.shp

ne_10m_cultural_admin_0_line_input.shp: ../../10m_physical/ne_10m_coastline.shp ../../10m_physical/ne_10m_coastline.dbf \
	../../10m_physical/ne_10m_minor_islands_coastline.shp ../../10m_physical/ne_10m_minor_islands_coastline.dbf \
	../../10m_cultural/ne_10m_admin_0_seams.shp ../../10m_cultural/ne_10m_admin_0_seams.dbf \
	../../10m_cultural/ne_10m_admin_0_boundary_lines_land.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_land.dbf \
	../../10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_map_units.dbf \
	../../10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.dbf
	rm -f ne_10m_cultural_admin_0_line_input.shp
	ogr2ogr -f "Esri Shapefile" ne_10m_cultural_admin_0_line_input.shp ../../10m_physical/ne_10m_coastline.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_0_line_input.shp ../../10m_physical/ne_10m_minor_islands_coastline.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_0_line_input.shp ../../10m_cultural/ne_10m_admin_0_seams.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_0_line_input.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_land.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_0_line_input.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_0_line_input.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp
	
ne_10m_cultural_admin_0_label_points.geojson: ../../10m_cultural/ne_10m_admin_0_label_points.shp ../../10m_cultural/ne_10m_admin_0_label_points.dbf
	rm -f ne_10m_cultural_admin_0_label_points.geojson
	ogr2ogr -f "GeoJSON" ne_10m_cultural_admin_0_label_points.geojson ../../10m_cultural/ne_10m_admin_0_label_points.shp
	
	
	
	
ne_10m_cultural_admin_1_polygon_output.geojson: \
	ne_10m_cultural_admin_1_line_input.geojson #\
	#ne_10m_cultural_admin_1_label_points.geojson
	rm -f ne_10m_cultural_admin_1_polygon_output.geojson
	python polygonize.py ne_10m_cultural_admin_1_line_input.geojson ne_10m_cultural_admin_1_polygon_output.geojson

ne_10m_cultural_admin_1_line_input.geojson: ne_10m_cultural_admin_1_line_input.shp ne_10m_cultural_admin_1_line_input.dbf
	rm -f ne_10m_cultural_admin_1_line_input.geojson
	ogr2ogr -f "GeoJSON" ne_10m_cultural_admin_1_line_input.geojson ne_10m_cultural_admin_1_line_input.shp

ne_10m_cultural_admin_1_line_input.shp: ../../10m_physical/ne_10m_coastline.shp ../../10m_physical/ne_10m_coastline.dbf \
	../../10m_physical/ne_10m_minor_islands_coastline.shp ../../10m_physical/ne_10m_minor_islands_coastline.dbf \
	../../10m_cultural/ne_10m_admin_1_seams.shp ../../10m_cultural/ne_10m_admin_1_seams.dbf \
	../../10m_cultural/ne_10m_admin_0_boundary_lines_land.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_land.dbf \
	../../10m_cultural/ne_10m_admin_1_states_provinces_lines.shp ../../10m_cultural/ne_10m_admin_1_states_provinces_lines.dbf
	rm -f ne_10m_cultural_admin_1_line_input.shp
	ogr2ogr -f "Esri Shapefile" ne_10m_cultural_admin_1_line_input.shp ../../10m_physical/ne_10m_coastline.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_1_line_input.shp ../../10m_physical/ne_10m_minor_islands_coastline.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_1_line_input.shp ../../10m_cultural/ne_10m_admin_1_seams.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_1_line_input.shp ../../10m_cultural/ne_10m_admin_0_boundary_lines_land.shp
	ogr2ogr -f "Esri Shapefile" -append -update ne_10m_cultural_admin_1_line_input.shp ../../10m_cultural/ne_10m_admin_1_states_provinces_lines.shp
	
ne_10m_cultural_admin_1_label_points.geojson: ../../10m_cultural/ne_10m_admin_1_label_points.shp ../../10m_cultural/ne_10m_admin_1_label_points.dbf
	rm -f ne_10m_cultural_admin_1_label_points.geojson
	ogr2ogr -f "GeoJSON" ne_10m_cultural_admin_1_label_points.geojson ../../10m_cultural/ne_10m_admin_1_label_points.shp




ne_10m_minor_islands_lines_input.geojson: ../../10m_physical/ne_10m_minor_islands_coastline.shp ../../10m_physical/ne_10m_minor_islands_coastline.dbf
	rm -f ne_10m_minor_islands_lines_input.geojson
	ogr2ogr -f "GeoJSON" ne_10m_minor_islands_lines_input.geojson ../../10m_physical/ne_10m_minor_islands_coastline.shp

ne_10m_minor_islands_polygon_output.geojson: ne_10m_minor_islands_lines_input.geojson
	rm -f ne_10m_minor_islands_polygon_output.geojson
	python polygonize.py ne_10m_minor_islands_lines_input.geojson ne_10m_minor_islands_polygon_output.geojson

ne_10m_minor_islands_label_points.geojson: ../../10m_physical/ne_10m_minor_islands_label_points.shp ../../10m_physical/ne_10m_minor_islands_label_points.dbf
	rm -f ne_10m_minor_islands_label_points.geojson
	ogr2ogr -f "GeoJSON" ne_10m_minor_islands_label_points.geojson ../../10m_physical/ne_10m_minor_islands_label_points.shp
	

clean:
	rm -rf *.shp *.dbf *.shx *.prj *.geojson