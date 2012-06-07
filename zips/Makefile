VERSION=2.0.0

all: zips

zips: ../zips/10m_cultural/10m_cultural.zip \
	 ../zips/10m_physical/10m_physical.zip \
	 ../zips/50m_cultural/50m_cultural.zip \
	 ../zips/50m_physical/50m_physical.zip \
	 ../zips/110m_cultural/110m_cultural.zip \
	 ../zips/110m_physical/110m_physical.zip \
	 ../zips/packages/natural_earth_vector.zip \
	 ../zips/packages/Natural_Earth_quick_start/Natural_Earth_quick_start.zip


# PER THEME, BY SCALESET

# SCALESET ZIPS by zoom and physical, cultural (6 total)

../zips/10m_cultural/10m_cultural.zip: ../zips/10m_cultural/ne_10m_admin_0_boundary_breakaway_disputed_areas.zip \
	../zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip \
	../zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip \
	../zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.zip \
	../zips/10m_cultural/ne_10m_admin_0_breakaway_disputed_areas_scale_ranks.zip \
	../zips/10m_cultural/ne_10m_admin_0_breakaway_disputed_areas.zip \
	../zips/10m_cultural/ne_10m_admin_0_countries.zip \
	../zips/10m_cultural/ne_10m_admin_0_map_subunits.zip \
	../zips/10m_cultural/ne_10m_admin_0_map_units.zip \
	../zips/10m_cultural/ne_10m_admin_0_pacific_groupings.zip \
	../zips/10m_cultural/ne_10m_admin_0_scale_ranks_with_minor_islands.zip \
	../zips/10m_cultural/ne_10m_admin_0_scale_ranks.zip \
	../zips/10m_cultural/ne_10m_admin_0_sovereignty.zip \
	../zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.zip \
	../zips/10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.zip \
	../zips/10m_cultural/ne_10m_admin_1_states_provinces_shp.zip \
	../zips/10m_cultural/ne_10m_populated_places_simple.zip \
	../zips/10m_cultural/ne_10m_populated_places.zip \
	../zips/10m_cultural/ne_10m_railroads.zip \
	../zips/10m_cultural/ne_10m_roads_north_america.zip \
	../zips/10m_cultural/ne_10m_roads.zip \
	../zips/10m_cultural/ne_10m_urban_areas_landscan.zip \
	../zips/10m_cultural/ne_10m_urban_areas.zip \
	../zips/10m_cultural/ne_10m_admin_1_states_provinces_geodb.zip \
	../zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.zip \
	../zips/10m_cultural/ne_10m_parks_and_protected_areas.zip

	zip -j -r ../zips/10m_cultural/10m_cultural.zip ../10m_cultural

../zips/10m_physical/10m_physical.zip: ../zips/10m_physical/ne_10m_antarctic_ice_shelves_lines.zip \
	../zips/10m_physical/ne_10m_antarctic_ice_shelves_polys.zip \
	../zips/10m_physical/ne_10m_coastline.zip \
	../zips/10m_physical/ne_10m_geographic_lines.zip \
	../zips/10m_physical/ne_10m_geography_marine_polys.zip \
	../zips/10m_physical/ne_10m_geography_regions_elevation_points.zip \
	../zips/10m_physical/ne_10m_geography_regions_points.zip \
	../zips/10m_physical/ne_10m_geography_regions_polys.zip \
	../zips/10m_physical/ne_10m_glaciated_areas.zip \
	../zips/10m_physical/ne_10m_lakes_europe.zip \
	../zips/10m_physical/ne_10m_lakes_historic.zip \
	../zips/10m_physical/ne_10m_lakes_north_america.zip \
	../zips/10m_physical/ne_10m_lakes_pluvial.zip \
	../zips/10m_physical/ne_10m_lakes.zip \
	../zips/10m_physical/ne_10m_land.zip \
	../zips/10m_physical/ne_10m_minor_islands_coastline.zip \
	../zips/10m_physical/ne_10m_minor_islands.zip \
	../zips/10m_physical/ne_10m_ocean.zip \
	../zips/10m_physical/ne_10m_playas.zip \
	../zips/10m_physical/ne_10m_reefs.zip \
	../zips/10m_physical/ne_10m_rivers_europe.zip \
	../zips/10m_physical/ne_10m_rivers_lake_centerlines_scale_ranks.zip \
	../zips/10m_physical/ne_10m_rivers_lake_centerlines.zip \
	../zips/10m_physical/ne_10m_rivers_north_america.zip \
	../zips/10m_physical/ne_10m_bathymetry_all.zip \
	../zips/10m_physical/ne_10m_bathymetry_A_10000.zip \
	../zips/10m_physical/ne_10m_bathymetry_B_9000.zip \
	../zips/10m_physical/ne_10m_bathymetry_C_8000.zip \
	../zips/10m_physical/ne_10m_bathymetry_D_7000.zip \
	../zips/10m_physical/ne_10m_bathymetry_E_6000.zip \
	../zips/10m_physical/ne_10m_bathymetry_F_5000.zip \
	../zips/10m_physical/ne_10m_bathymetry_G_4000.zip \
	../zips/10m_physical/ne_10m_bathymetry_H_3000.zip \
	../zips/10m_physical/ne_10m_bathymetry_I_2000.zip \
	../zips/10m_physical/ne_10m_bathymetry_J_1000.zip \
	../zips/10m_physical/ne_10m_bathymetry_K_200.zip \
	../zips/10m_physical/ne_10m_bathymetry_L_0.zip \
	../zips/10m_physical/ne_10m_graticules_all.zip \
	../zips/10m_physical/ne_10m_graticules_1.zip \
	../zips/10m_physical/ne_10m_graticules_5.zip \
	../zips/10m_physical/ne_10m_graticules_10.zip \
	../zips/10m_physical/ne_10m_graticules_15.zip \
	../zips/10m_physical/ne_10m_graticules_20.zip \
	../zips/10m_physical/ne_10m_graticules_30.zip \
	../zips/10m_physical/ne_10m_wgs84_bounding_box.zip

	zip -j -r ../zips/10m_physical/10m_physical.zip ../10m_physical

../zips/50m_cultural/50m_cultural.zip: ../zips/50m_cultural/ne_50m_admin_0_boundary_breakaway_disputed_areas.zip \
	../zips/50m_cultural/ne_50m_admin_0_boundary_lines_land.zip \
	../zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.zip \
	../zips/50m_cultural/ne_50m_admin_0_boundary_map_units.zip \
	../zips/50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.zip \
	../zips/50m_cultural/ne_50m_admin_0_countries.zip \
	../zips/50m_cultural/ne_50m_admin_0_map_subunits.zip \
	../zips/50m_cultural/ne_50m_admin_0_map_units.zip \
	../zips/50m_cultural/ne_50m_admin_0_pacific_groupings.zip \
	../zips/50m_cultural/ne_50m_admin_0_scale_ranks.zip \
	../zips/50m_cultural/ne_50m_admin_0_sovereignty.zip \
	../zips/50m_cultural/ne_50m_admin_0_tiny_countries.zip \
	../zips/50m_cultural/ne_50m_admin_1_states_provinces_lines_shp.zip \
	../zips/50m_cultural/ne_50m_admin_1_states_provinces_shp.zip \
	../zips/50m_cultural/ne_50m_populated_places_simple.zip \
	../zips/50m_cultural/ne_50m_populated_places.zip \
	../zips/50m_cultural/ne_50m_urban_areas.zip

	zip -j -r ../zips/50m_cultural/50m_cultural.zip ../50m_cultural

../zips/50m_physical/50m_physical.zip: ../zips/50m_physical/ne_50m_antarctic_ice_shelves_lines.zip \
	../zips/50m_physical/ne_50m_antarctic_ice_shelves_polys.zip \
	../zips/50m_physical/ne_50m_coastline.zip \
	../zips/50m_physical/ne_50m_geographic_lines.zip \
	../zips/50m_physical/ne_50m_geography_marine_polys.zip \
	../zips/50m_physical/ne_50m_geography_regions_elevation_points.zip \
	../zips/50m_physical/ne_50m_geography_regions_points.zip \
	../zips/50m_physical/ne_50m_geography_regions_polys.zip \
	../zips/50m_physical/ne_50m_glaciated_areas.zip \
	../zips/50m_physical/ne_50m_lakes_historic.zip \
	../zips/50m_physical/ne_50m_lakes.zip \
	../zips/50m_physical/ne_50m_land.zip \
	../zips/50m_physical/ne_50m_ocean.zip \
	../zips/50m_physical/ne_50m_playas.zip \
	../zips/50m_physical/ne_50m_rivers_lake_centerlines_scale_ranks.zip \
	../zips/50m_physical/ne_50m_rivers_lake_centerlines.zip \
	../zips/50m_physical/ne_50m_graticules_all.zip \
	../zips/50m_physical/ne_50m_graticules_1.zip \
	../zips/50m_physical/ne_50m_graticules_5.zip \
	../zips/50m_physical/ne_50m_graticules_10.zip \
	../zips/50m_physical/ne_50m_graticules_15.zip \
	../zips/50m_physical/ne_50m_graticules_20.zip \
	../zips/50m_physical/ne_50m_graticules_30.zip \
	../zips/50m_physical/ne_50m_wgs84_bounding_box.zip

	zip -j -r ../zips/50m_physical/50m_physical.zip ../50m_physical

../zips/110m_cultural/110m_cultural.zip: ../zips/110m_cultural/ne_110m_admin_0_boundary_lines_land.zip \
	../zips/110m_cultural/ne_110m_admin_0_countries.zip \
	../zips/110m_cultural/ne_110m_admin_0_map_units.zip \
	../zips/110m_cultural/ne_110m_admin_0_pacific_groupings.zip \
	../zips/110m_cultural/ne_110m_admin_0_scale_ranks.zip \
	../zips/110m_cultural/ne_110m_admin_0_sovereignty.zip \
	../zips/110m_cultural/ne_110m_admin_0_tiny_countries.zip \
	../zips/110m_cultural/ne_110m_admin_1_states_provinces_lines_shp.zip \
	../zips/110m_cultural/ne_110m_admin_1_states_provinces_shp.zip \
	../zips/110m_cultural/ne_110m_populated_places_simple.zip \
	../zips/110m_cultural/ne_110m_populated_places.zip
	
	zip -j -r ../zips/110m_cultural/110m_cultural.zip ../110m_cultural

110m_physical.zip: ../zips/110m_physical/ne_110m_coastline.zip \
	../zips/110m_physical/ne_110m_geographic_lines.zip \
	../zips/110m_physical/ne_110m_geography_marine_polys.zip \
	../zips/110m_physical/ne_110m_geography_regions_elevation_points.zip \
	../zips/110m_physical/ne_110m_geography_regions_points.zip \
	../zips/110m_physical/ne_110m_geography_regions_polys.zip \
	../zips/110m_physical/ne_110m_glaciated_areas.zip \
	../zips/110m_physical/ne_110m_lakes.zip \
	../zips/110m_physical/ne_110m_land.zip \
	../zips/110m_physical/ne_110m_ocean.zip \
	../zips/110m_physical/ne_110m_physical_geographic_lines.zip \
	../zips/110m_physical/ne_110m_rivers_lake_centerlines.zip \
	../zips/110m_physical/ne_110m_graticules_all.zip \
	../zips/110m_physical/ne_110m_graticules_1.zip \
	../zips/110m_physical/ne_110m_graticules_5.zip \
	../zips/110m_physical/ne_110m_graticules_10.zip \
	../zips/110m_physical/ne_110m_graticules_15.zip \
	../zips/110m_physical/ne_110m_graticules_20.zip \
	../zips/110m_physical/ne_110m_graticules_30.zip \
	../zips/110m_physical/ne_110m_wgs84_bounding_box.zip

	zip -j -r ../zips/110m_physical/110m_physical.zip ../110m_physical



# THEMES

# If either the geometry or the attributes change, time to remake the ZIPs

# grep pattern matching: 
#find:    (\.\./zips/(\w+)/(\w+)\.zip): \r\tzip -j -r \$@ \r
#replace: \1: ../\2/\3.shp ../\2/\3.dbf\r\tzip -j -r $@ ../\2/\3.*\r

# 10m_cultural

../zips/10m_cultural/ne_10m_admin_0_boundary_breakaway_disputed_areas.zip: ../10m_cultural/ne_10m_admin_0_boundary_breakaway_disputed_areas.*
	zip -j -r $@ ../zips/10m_cultural/ne_10m_admin_0_boundary_breakaway_disputed_areas.*
	
../zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip: ../10m_cultural/ne_10m_admin_0_boundary_lines_land.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_boundary_lines_land.*

../zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip: ../10m_cultural/ne_10m_admin_0_boundary_lines_map_units.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_boundary_lines_map_units.*

../zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.zip: ../10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.*

../zips/10m_cultural/ne_10m_admin_0_breakaway_disputed_areas_scale_ranks.zip: ../10m_cultural/ne_10m_admin_0_breakaway_disputed_areas_scale_ranks.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_breakaway_disputed_areas_scale_ranks.*

../zips/10m_cultural/ne_10m_admin_0_breakaway_disputed_areas.zip: ../10m_cultural/ne_10m_admin_0_breakaway_disputed_areas.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_breakaway_disputed_areas.*
	
../zips/10m_cultural/ne_10m_admin_0_countries.zip: ../10m_cultural/ne_10m_admin_0_countries.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_countries.*

../zips/10m_cultural/ne_10m_admin_0_map_subunits.zip: ../10m_cultural/ne_10m_admin_0_map_subunits.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_map_subunits.*

../zips/10m_cultural/ne_10m_admin_0_map_units.zip: ../10m_cultural/ne_10m_admin_0_map_units.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_map_units.*
	
../zips/10m_cultural/ne_10m_admin_0_pacific_groupings.zip: ../10m_cultural/ne_10m_admin_0_pacific_groupings.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_pacific_groupings.*
	
../zips/10m_cultural/ne_10m_admin_0_scale_ranks_with_minor_islands.zip: ../10m_cultural/ne_10m_admin_0_scale_ranks_with_minor_islands.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_scale_ranks_with_minor_islands.*
	
../zips/10m_cultural/ne_10m_admin_0_scale_ranks.zip: ../10m_cultural/ne_10m_admin_0_scale_ranks.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_scale_ranks.*
	
../zips/10m_cultural/ne_10m_admin_0_sovereignty.zip: ../10m_cultural/ne_10m_admin_0_sovereignty.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_0_sovereignty.*
	
../zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.zip: ../10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.*

../zips/10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.zip: ../10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.*

../zips/10m_cultural/ne_10m_admin_1_states_provinces_shp.zip: ../10m_cultural/ne_10m_admin_1_states_provinces_shp.*
	zip -j -r $@ ../10m_cultural/ne_10m_admin_1_states_provinces_shp.*
	
../zips/10m_cultural/ne_10m_populated_places_simple.zip: ../10m_cultural/ne_10m_populated_places_simple.*
	zip -j -r $@ ../10m_cultural/ne_10m_populated_places_simple.*

../zips/10m_cultural/ne_10m_populated_places.zip: ../10m_cultural/ne_10m_populated_places.shp ../10m_cultural/ne_10m_populated_places.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_populated_places.*

../zips/10m_cultural/ne_10m_railroads.zip: ../10m_cultural/ne_10m_railroads.shp ../10m_cultural/ne_10m_railroads.dbf
	zip -j -r $@ 

../zips/10m_cultural/ne_10m_roads_north_america.zip: ../10m_cultural/ne_10m_roads_north_america.shp ../10m_cultural/ne_10m_roads_north_america.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_roads_north_america.*

../zips/10m_cultural/ne_10m_roads.zip: ../10m_cultural/ne_10m_roads.shp ../10m_cultural/ne_10m_roads.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_roads.*

../zips/10m_cultural/ne_10m_urban_areas_landscan.zip: ../10m_cultural/ne_10m_urban_areas_landscan.shp ../10m_cultural/ne_10m_urban_areas_landscan.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_urban_areas_landscan.*

../zips/10m_cultural/ne_10m_urban_areas.zip: ../10m_cultural/ne_10m_urban_areas.shp ../10m_cultural/ne_10m_urban_areas.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_urban_areas.*
			
# folders for theme groups or geodb special items
../zips/10m_cultural/ne_10m_admin_1_states_provinces_geodb.zip: ../10m_cultural/ne_10m_admin_1_states_provinces_geodb.shp ../10m_cultural/ne_10m_admin_1_states_provinces_geodb.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_admin_1_states_provinces_geodb.*

../zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.zip: ../10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.shp ../10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.*

../zips/10m_cultural/ne_10m_parks_and_protected_areas.zip: ../10m_cultural/ne_10m_parks_and_protected_areas.shp ../10m_cultural/ne_10m_parks_and_protected_areas.dbf
	zip -j -r $@ ../10m_cultural/ne_10m_parks_and_protected_areas.*


# 10m physical:

../zips/10m_physical/ne_10m_antarctic_ice_shelves_lines.zip: ../10m_physical/ne_10m_antarctic_ice_shelves_lines.shp ../10m_physical/ne_10m_antarctic_ice_shelves_lines.dbf
	zip -j -r $@ ../10m_physical/ne_10m_antarctic_ice_shelves_lines.*

../zips/10m_physical/ne_10m_antarctic_ice_shelves_polys.zip: ../10m_physical/ne_10m_antarctic_ice_shelves_polys.shp ../10m_physical/ne_10m_antarctic_ice_shelves_polys.dbf
	zip -j -r $@ ../10m_physical/ne_10m_antarctic_ice_shelves_polys.*

../zips/10m_physical/ne_10m_coastline.zip: ../10m_physical/ne_10m_coastline.shp ../10m_physical/ne_10m_coastline.dbf
	zip -j -r $@ ../10m_physical/ne_10m_coastline.*

../zips/10m_physical/ne_10m_geographic_lines.zip: ../10m_physical/ne_10m_geographic_lines.shp ../10m_physical/ne_10m_geographic_lines.dbf
	zip -j -r $@ ../10m_physical/ne_10m_geographic_lines.*

../zips/10m_physical/ne_10m_geography_marine_polys.zip: ../10m_physical/ne_10m_geography_marine_polys.shp ../10m_physical/ne_10m_geography_marine_polys.dbf
	zip -j -r $@ ../10m_physical/ne_10m_geography_marine_polys.*

../zips/10m_physical/ne_10m_geography_regions_elevation_points.zip: ../10m_physical/ne_10m_geography_regions_elevation_points.shp ../10m_physical/ne_10m_geography_regions_elevation_points.dbf
	zip -j -r $@ ../10m_physical/ne_10m_geography_regions_elevation_points.*

../zips/10m_physical/ne_10m_geography_regions_points.zip: ../10m_physical/ne_10m_geography_regions_points.shp ../10m_physical/ne_10m_geography_regions_points.dbf
	zip -j -r $@ ../10m_physical/ne_10m_geography_regions_points.*

../zips/10m_physical/ne_10m_geography_regions_polys.zip: ../10m_physical/ne_10m_geography_regions_polys.shp ../10m_physical/ne_10m_geography_regions_polys.dbf
	zip -j -r $@ ../10m_physical/ne_10m_geography_regions_polys.*

../zips/10m_physical/ne_10m_glaciated_areas.zip: ../10m_physical/ne_10m_glaciated_areas.shp ../10m_physical/ne_10m_glaciated_areas.dbf
	zip -j -r $@ ../10m_physical/ne_10m_glaciated_areas.*

../zips/10m_physical/ne_10m_lakes_europe.zip: ../10m_physical/ne_10m_lakes_europe.shp ../10m_physical/ne_10m_lakes_europe.dbf
	zip -j -r $@ ../10m_physical/ne_10m_lakes_europe.*

../zips/10m_physical/ne_10m_lakes_historic.zip: ../10m_physical/ne_10m_lakes_historic.shp ../10m_physical/ne_10m_lakes_historic.dbf
	zip -j -r $@ ../10m_physical/ne_10m_lakes_historic.*

../zips/10m_physical/ne_10m_lakes_north_america.zip: ../10m_physical/ne_10m_lakes_north_america.shp ../10m_physical/ne_10m_lakes_north_america.dbf
	zip -j -r $@ ../10m_physical/ne_10m_lakes_north_america.*

../zips/10m_physical/ne_10m_lakes_pluvial.zip: ../10m_physical/ne_10m_lakes_pluvial.shp ../10m_physical/ne_10m_lakes_pluvial.dbf
	zip -j -r $@ ../10m_physical/ne_10m_lakes_pluvial.*

../zips/10m_physical/ne_10m_lakes.zip: ../10m_physical/ne_10m_lakes.shp ../10m_physical/ne_10m_lakes.dbf
	zip -j -r $@ ../10m_physical/ne_10m_lakes.*

../zips/10m_physical/ne_10m_land.zip: ../10m_physical/ne_10m_land.shp ../10m_physical/ne_10m_land.dbf
	zip -j -r $@ ../10m_physical/ne_10m_land.*

../zips/10m_physical/ne_10m_minor_islands_coastline.zip: ../10m_physical/ne_10m_minor_islands_coastline.shp ../10m_physical/ne_10m_minor_islands_coastline.dbf
	zip -j -r $@ ../10m_physical/ne_10m_minor_islands_coastline.*

../zips/10m_physical/ne_10m_minor_islands.zip: ../10m_physical/ne_10m_minor_islands.shp ../10m_physical/ne_10m_minor_islands.dbf
	zip -j -r $@ ../10m_physical/ne_10m_minor_islands.*

../zips/10m_physical/ne_10m_ocean.zip: ../10m_physical/ne_10m_ocean.shp ../10m_physical/ne_10m_ocean.dbf
	zip -j -r $@ ../10m_physical/ne_10m_ocean.*

../zips/10m_physical/ne_10m_playas.zip: ../10m_physical/ne_10m_playas.shp ../10m_physical/ne_10m_playas.dbf
	zip -j -r $@ ../10m_physical/ne_10m_playas.*

../zips/10m_physical/ne_10m_reefs.zip: ../10m_physical/ne_10m_reefs.shp ../10m_physical/ne_10m_reefs.dbf
	zip -j -r $@ ../10m_physical/ne_10m_reefs.*

../zips/10m_physical/ne_10m_rivers_europe.zip: ../10m_physical/ne_10m_rivers_europe.shp ../10m_physical/ne_10m_rivers_europe.dbf
	zip -j -r $@ ../10m_physical/ne_10m_rivers_europe.*

../zips/10m_physical/ne_10m_rivers_lake_centerlines_scale_ranks.zip: ../10m_physical/ne_10m_rivers_lake_centerlines_scale_ranks.shp ../10m_physical/ne_10m_rivers_lake_centerlines_scale_ranks.dbf
	zip -j -r $@ ../10m_physical/ne_10m_rivers_lake_centerlines_scale_ranks.*

../zips/10m_physical/ne_10m_rivers_lake_centerlines.zip: ../10m_physical/ne_10m_rivers_lake_centerlines.shp ../10m_physical/ne_10m_rivers_lake_centerlines.dbf
	zip -j -r $@ ../10m_physical/ne_10m_rivers_lake_centerlines.*

../zips/10m_physical/ne_10m_rivers_north_america.zip: ../10m_physical/ne_10m_rivers_north_america.shp ../10m_physical/ne_10m_rivers_north_america.dbf
	zip -j -r $@ ../10m_physical/ne_10m_rivers_north_america.*

../zips/10m_physical/ne_10m_bathymetry_all.zip: ../10m_physical/ne_10m_bathymetry_all.shp ../10m_physical/ne_10m_bathymetry_all.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_all.*

../zips/10m_physical/ne_10m_bathymetry_A_10000.zip: ../10m_physical/ne_10m_bathymetry_A_10000.shp ../10m_physical/ne_10m_bathymetry_A_10000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_A_10000.*

../zips/10m_physical/ne_10m_bathymetry_B_9000.zip: ../10m_physical/ne_10m_bathymetry_B_9000.shp ../10m_physical/ne_10m_bathymetry_B_9000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_B_9000.*

../zips/10m_physical/ne_10m_bathymetry_C_8000.zip: ../10m_physical/ne_10m_bathymetry_C_8000.shp ../10m_physical/ne_10m_bathymetry_C_8000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_C_8000.*

../zips/10m_physical/ne_10m_bathymetry_D_7000.zip: ../10m_physical/ne_10m_bathymetry_D_7000.shp ../10m_physical/ne_10m_bathymetry_D_7000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_D_7000.*

../zips/10m_physical/ne_10m_bathymetry_E_6000.zip: ../10m_physical/ne_10m_bathymetry_E_6000.shp ../10m_physical/ne_10m_bathymetry_E_6000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_E_6000.*

../zips/10m_physical/ne_10m_bathymetry_F_5000.zip: ../10m_physical/ne_10m_bathymetry_F_5000.shp ../10m_physical/ne_10m_bathymetry_F_5000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_F_5000.*

../zips/10m_physical/ne_10m_bathymetry_G_4000.zip: ../10m_physical/ne_10m_bathymetry_G_4000.shp ../10m_physical/ne_10m_bathymetry_G_4000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_G_4000.*

../zips/10m_physical/ne_10m_bathymetry_H_3000.zip: ../10m_physical/ne_10m_bathymetry_H_3000.shp ../10m_physical/ne_10m_bathymetry_H_3000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_H_3000.*

../zips/10m_physical/ne_10m_bathymetry_I_2000.zip: ../10m_physical/ne_10m_bathymetry_I_2000.shp ../10m_physical/ne_10m_bathymetry_I_2000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_I_2000.*

../zips/10m_physical/ne_10m_bathymetry_J_1000.zip: ../10m_physical/ne_10m_bathymetry_J_1000.shp ../10m_physical/ne_10m_bathymetry_J_1000.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_J_1000.*

../zips/10m_physical/ne_10m_bathymetry_K_200.zip: ../10m_physical/ne_10m_bathymetry_K_200.shp ../10m_physical/ne_10m_bathymetry_K_200.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_K_200.*

../zips/10m_physical/ne_10m_bathymetry_L_0.zip: ../10m_physical/ne_10m_bathymetry_L_0.shp ../10m_physical/ne_10m_bathymetry_L_0.dbf
	zip -j -r $@ ../10m_physical/ne_10m_bathymetry_L_0.*

../zips/10m_physical/ne_10m_graticules_all.zip: ../10m_physical/ne_10m_graticules_all.shp ../10m_physical/ne_10m_graticules_all.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_all.*

../zips/10m_physical/ne_10m_graticules_1.zip: ../10m_physical/ne_10m_graticules_1.shp ../10m_physical/ne_10m_graticules_1.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_1.*

../zips/10m_physical/ne_10m_graticules_5.zip: ../10m_physical/ne_10m_graticules_5.shp ../10m_physical/ne_10m_graticules_5.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_5.*

../zips/10m_physical/ne_10m_graticules_10.zip: ../10m_physical/ne_10m_graticules_10.shp ../10m_physical/ne_10m_graticules_10.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_10.*

../zips/10m_physical/ne_10m_graticules_15.zip: ../10m_physical/ne_10m_graticules_15.shp ../10m_physical/ne_10m_graticules_15.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_15.*

../zips/10m_physical/ne_10m_graticules_20.zip: ../10m_physical/ne_10m_graticules_20.shp ../10m_physical/ne_10m_graticules_20.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_20.*

../zips/10m_physical/ne_10m_graticules_30.zip: ../10m_physical/ne_10m_graticules_30.shp ../10m_physical/ne_10m_graticules_30.dbf
	zip -j -r $@ ../10m_physical/ne_10m_graticules_30.*

../zips/10m_physical/ne_10m_wgs84_bounding_box.zip: ../10m_physical/ne_10m_wgs84_bounding_box.shp ../10m_physical/ne_10m_wgs84_bounding_box.dbf
	zip -j -r $@ ../10m_physical/ne_10m_wgs84_bounding_box.*


# 50m cultural

../zips/50m_cultural/ne_50m_admin_0_boundary_breakaway_disputed_areas.zip: ../50m_cultural/ne_50m_admin_0_boundary_breakaway_disputed_areas.shp ../50m_cultural/ne_50m_admin_0_boundary_breakaway_disputed_areas.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_boundary_breakaway_disputed_areas.*
	
../zips/50m_cultural/ne_50m_admin_0_boundary_lines_land.zip: ../50m_cultural/ne_50m_admin_0_boundary_lines_land.shp ../50m_cultural/ne_50m_admin_0_boundary_lines_land.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_boundary_lines_land.*

../zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.zip: ../50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.shp ../50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.*

../zips/50m_cultural/ne_50m_admin_0_boundary_map_units.zip: ../50m_cultural/ne_50m_admin_0_boundary_map_units.shp ../50m_cultural/ne_50m_admin_0_boundary_map_units.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_boundary_map_units.*

../zips/50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.zip: ../50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.shp ../50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.*

../zips/50m_cultural/ne_50m_admin_0_countries.zip: ../50m_cultural/ne_50m_admin_0_countries.shp ../50m_cultural/ne_50m_admin_0_countries.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_countries.*

../zips/50m_cultural/ne_50m_admin_0_map_subunits.zip: ../50m_cultural/ne_50m_admin_0_map_subunits.shp ../50m_cultural/ne_50m_admin_0_map_subunits.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_map_subunits.*

../zips/50m_cultural/ne_50m_admin_0_map_units.zip: ../50m_cultural/ne_50m_admin_0_map_units.shp ../50m_cultural/ne_50m_admin_0_map_units.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_map_units.*

../zips/50m_cultural/ne_50m_admin_0_pacific_groupings.zip: ../50m_cultural/ne_50m_admin_0_pacific_groupings.shp ../50m_cultural/ne_50m_admin_0_pacific_groupings.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_pacific_groupings.*

../zips/50m_cultural/ne_50m_admin_0_scale_ranks.zip: ../50m_cultural/ne_50m_admin_0_scale_ranks.shp ../50m_cultural/ne_50m_admin_0_scale_ranks.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_scale_ranks.*

../zips/50m_cultural/ne_50m_admin_0_sovereignty.zip: ../50m_cultural/ne_50m_admin_0_sovereignty.shp ../50m_cultural/ne_50m_admin_0_sovereignty.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_sovereignty.*

../zips/50m_cultural/ne_50m_admin_0_tiny_countries.zip: ../50m_cultural/ne_50m_admin_0_tiny_countries.shp ../50m_cultural/ne_50m_admin_0_tiny_countries.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_0_tiny_countries.*

../zips/50m_cultural/ne_50m_admin_1_states_provinces_lines_shp.zip: ../50m_cultural/ne_50m_admin_1_states_provinces_lines_shp.shp ../50m_cultural/ne_50m_admin_1_states_provinces_lines_shp.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_1_states_provinces_lines_shp.*

../zips/50m_cultural/ne_50m_admin_1_states_provinces_shp.zip: ../50m_cultural/ne_50m_admin_1_states_provinces_shp.shp ../50m_cultural/ne_50m_admin_1_states_provinces_shp.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_admin_1_states_provinces_shp.*

../zips/50m_cultural/ne_50m_populated_places_simple.zip: ../50m_cultural/ne_50m_populated_places_simple.shp ../50m_cultural/ne_50m_populated_places_simple.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_populated_places_simple.*

../zips/50m_cultural/ne_50m_populated_places.zip: ../50m_cultural/ne_50m_populated_places.shp ../50m_cultural/ne_50m_populated_places.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_populated_places.*

../zips/50m_cultural/ne_50m_urban_areas.zip: ../50m_cultural/ne_50m_urban_areas.shp ../50m_cultural/ne_50m_urban_areas.dbf
	zip -j -r $@ ../50m_cultural/ne_50m_urban_areas.*


# 50m physical

../zips/50m_physical/ne_50m_antarctic_ice_shelves_lines.zip: ../50m_physical/ne_50m_antarctic_ice_shelves_lines.shp ../50m_physical/ne_50m_antarctic_ice_shelves_lines.dbf
	zip -j -r $@ ../50m_physical/ne_50m_antarctic_ice_shelves_lines.*

../zips/50m_physical/ne_50m_antarctic_ice_shelves_polys.zip: ../50m_physical/ne_50m_antarctic_ice_shelves_polys.shp ../50m_physical/ne_50m_antarctic_ice_shelves_polys.dbf
	zip -j -r $@ ../50m_physical/ne_50m_antarctic_ice_shelves_polys.*

../zips/50m_physical/ne_50m_coastline.zip: ../50m_physical/ne_50m_coastline.shp ../50m_physical/ne_50m_coastline.dbf
	zip -j -r $@ ../50m_physical/ne_50m_coastline.*

../zips/50m_physical/ne_50m_geographic_lines.zip: ../50m_physical/ne_50m_geographic_lines.shp ../50m_physical/ne_50m_geographic_lines.dbf
	zip -j -r $@ ../50m_physical/ne_50m_geographic_lines.*

../zips/50m_physical/ne_50m_geography_mari../zips/50m_physical/ne_polys.zip: ../50m_physical/ne_polys.shp ../50m_physical/ne_polys.dbf
	zip -j -r $@ ../50m_physical/ne_polys.*

../zips/50m_physical/ne_50m_geography_regions_elevation_points.zip: ../50m_physical/ne_50m_geography_regions_elevation_points.shp ../50m_physical/ne_50m_geography_regions_elevation_points.dbf
	zip -j -r $@ ../50m_physical/ne_50m_geography_regions_elevation_points.*

../zips/50m_physical/ne_50m_geography_regions_points.zip: ../50m_physical/ne_50m_geography_regions_points.shp ../50m_physical/ne_50m_geography_regions_points.dbf
	zip -j -r $@ ../50m_physical/ne_50m_geography_regions_points.*

../zips/50m_physical/ne_50m_geography_regions_polys.zip: ../50m_physical/ne_50m_geography_regions_polys.shp ../50m_physical/ne_50m_geography_regions_polys.dbf
	zip -j -r $@ ../50m_physical/ne_50m_geography_regions_polys.*

../zips/50m_physical/ne_50m_glaciated_areas.zip: ../50m_physical/ne_50m_glaciated_areas.shp ../50m_physical/ne_50m_glaciated_areas.dbf
	zip -j -r $@ ../50m_physical/ne_50m_glaciated_areas.*

../zips/50m_physical/ne_50m_lakes_historic.zip: ../50m_physical/ne_50m_lakes_historic.shp ../50m_physical/ne_50m_lakes_historic.dbf
	zip -j -r $@ ../50m_physical/ne_50m_lakes_historic.*

../zips/50m_physical/ne_50m_lakes.zip: ../50m_physical/ne_50m_lakes.shp ../50m_physical/ne_50m_lakes.dbf
	zip -j -r $@ ../50m_physical/ne_50m_lakes.*

../zips/50m_physical/ne_50m_land.zip: ../50m_physical/ne_50m_land.shp ../50m_physical/ne_50m_land.dbf
	zip -j -r $@ ../50m_physical/ne_50m_land.*

../zips/50m_physical/ne_50m_ocean.zip: ../50m_physical/ne_50m_ocean.shp ../50m_physical/ne_50m_ocean.dbf
	zip -j -r $@ ../50m_physical/ne_50m_ocean.*

../zips/50m_physical/ne_50m_playas.zip: ../50m_physical/ne_50m_playas.shp ../50m_physical/ne_50m_playas.dbf
	zip -j -r $@ ../50m_physical/ne_50m_playas.*

../zips/50m_physical/ne_50m_rivers_lake_centerlines_scale_ranks.zip: ../50m_physical/ne_50m_rivers_lake_centerlines_scale_ranks.shp ../50m_physical/ne_50m_rivers_lake_centerlines_scale_ranks.dbf
	zip -j -r $@ ../50m_physical/ne_50m_rivers_lake_centerlines_scale_ranks.*

../zips/50m_physical/ne_50m_rivers_lake_centerlines.zip: ../50m_physical/ne_50m_rivers_lake_centerlines.shp ../50m_physical/ne_50m_rivers_lake_centerlines.dbf
	zip -j -r $@ ../50m_physical/ne_50m_rivers_lake_centerlines.*

../zips/50m_physical/ne_50m_graticules_all.zip: ../50m_physical/ne_50m_graticules_all.shp ../50m_physical/ne_50m_graticules_all.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_all.*

../zips/50m_physical/ne_50m_graticules_1.zip: ../50m_physical/ne_50m_graticules_1.shp ../50m_physical/ne_50m_graticules_1.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_1.*

../zips/50m_physical/ne_50m_graticules_5.zip: ../50m_physical/ne_50m_graticules_5.shp ../50m_physical/ne_50m_graticules_5.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_5.*

../zips/50m_physical/ne_50m_graticules_10.zip: ../50m_physical/ne_50m_graticules_10.shp ../50m_physical/ne_50m_graticules_10.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_10.*

../zips/50m_physical/ne_50m_graticules_15.zip: ../50m_physical/ne_50m_graticules_15.shp ../50m_physical/ne_50m_graticules_15.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_15.*

../zips/50m_physical/ne_50m_graticules_20.zip: ../50m_physical/ne_50m_graticules_20.shp ../50m_physical/ne_50m_graticules_20.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_20.*

../zips/50m_physical/ne_50m_graticules_30.zip: ../50m_physical/ne_50m_graticules_30.shp ../50m_physical/ne_50m_graticules_30.dbf
	zip -j -r $@ ../50m_physical/ne_50m_graticules_30.*

../zips/50m_physical/ne_50m_wgs84_bounding_box.zip: ../50m_physical/ne_50m_wgs84_bounding_box.shp ../50m_physical/ne_50m_wgs84_bounding_box.dbf
	zip -j -r $@ ../50m_physical/ne_50m_wgs84_bounding_box.*


# 110m cultural

../zips/110m_cultural/ne_110m_admin_0_boundary_lines_land.zip: ../110m_cultural/ne_110m_admin_0_boundary_lines_land.shp ../110m_cultural/ne_110m_admin_0_boundary_lines_land.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_boundary_lines_land.*
	
../zips/110m_cultural/ne_110m_admin_0_countries.zip: ../110m_cultural/ne_110m_admin_0_countries.shp ../110m_cultural/ne_110m_admin_0_countries.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_countries.*
	
../zips/110m_cultural/ne_110m_admin_0_map_units.zip: ../110m_cultural/ne_110m_admin_0_map_units.shp ../110m_cultural/ne_110m_admin_0_map_units.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_map_units.*
	
../zips/110m_cultural/ne_110m_admin_0_pacific_groupings.zip: ../110m_cultural/ne_110m_admin_0_pacific_groupings.shp ../110m_cultural/ne_110m_admin_0_pacific_groupings.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_pacific_groupings.*
	
../zips/110m_cultural/ne_110m_admin_0_scale_ranks.zip: ../110m_cultural/ne_110m_admin_0_scale_ranks.shp ../110m_cultural/ne_110m_admin_0_scale_ranks.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_scale_ranks.*
	
../zips/110m_cultural/ne_110m_admin_0_sovereignty.zip: ../110m_cultural/ne_110m_admin_0_sovereignty.shp ../110m_cultural/ne_110m_admin_0_sovereignty.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_sovereignty.*
	
../zips/110m_cultural/ne_110m_admin_0_tiny_countries.zip: ../110m_cultural/ne_110m_admin_0_tiny_countries.shp ../110m_cultural/ne_110m_admin_0_tiny_countries.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_0_tiny_countries.*
	
../zips/110m_cultural/ne_110m_admin_1_states_provinces_lines_shp.zip: ../110m_cultural/ne_110m_admin_1_states_provinces_lines_shp.shp ../110m_cultural/ne_110m_admin_1_states_provinces_lines_shp.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_1_states_provinces_lines_shp.*
	
../zips/110m_cultural/ne_110m_admin_1_states_provinces_shp.zip: ../110m_cultural/ne_110m_admin_1_states_provinces_shp.shp ../110m_cultural/ne_110m_admin_1_states_provinces_shp.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_admin_1_states_provinces_shp.*
	
../zips/110m_cultural/ne_110m_populated_places_simple.zip: ../110m_cultural/ne_110m_populated_places_simple.shp ../110m_cultural/ne_110m_populated_places_simple.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_populated_places_simple.*
	
../zips/110m_cultural/ne_110m_populated_places.zip: ../110m_cultural/ne_110m_populated_places.shp ../110m_cultural/ne_110m_populated_places.dbf
	zip -j -r $@ ../110m_cultural/ne_110m_populated_places.*
	
	
# 110m physical

../zips/110m_physical/ne_110m_coastline.zip: ../110m_physical/ne_110m_coastline.shp ../110m_physical/ne_110m_coastline.dbf
	zip -j -r $@ ../110m_physical/ne_110m_coastline.*

../zips/110m_physical/ne_110m_geographic_lines.zip: ../110m_physical/ne_110m_geographic_lines.shp ../110m_physical/ne_110m_geographic_lines.dbf
	zip -j -r $@ ../110m_physical/ne_110m_geographic_lines.*

../zips/110m_physical/ne_110m_geography_marine_polys.zip: ../110m_physical/ne_110m_geography_marine_polys.shp ../110m_physical/ne_110m_geography_marine_polys.dbf
	zip -j -r $@ ../110m_physical/ne_110m_geography_marine_polys.*

../zips/110m_physical/ne_110m_geography_regions_elevation_points.zip: ../110m_physical/ne_110m_geography_regions_elevation_points.shp ../110m_physical/ne_110m_geography_regions_elevation_points.dbf
	zip -j -r $@ ../110m_physical/ne_110m_geography_regions_elevation_points.*

../zips/110m_physical/ne_110m_geography_regions_points.zip: ../110m_physical/ne_110m_geography_regions_points.shp ../110m_physical/ne_110m_geography_regions_points.dbf
	zip -j -r $@ ../110m_physical/ne_110m_geography_regions_points.*

../zips/110m_physical/ne_110m_geography_regions_polys.zip: ../110m_physical/ne_110m_geography_regions_polys.shp ../110m_physical/ne_110m_geography_regions_polys.dbf
	zip -j -r $@ ../110m_physical/ne_110m_geography_regions_polys.*

../zips/110m_physical/ne_110m_glaciated_areas.zip: ../110m_physical/ne_110m_glaciated_areas.shp ../110m_physical/ne_110m_glaciated_areas.dbf
	zip -j -r $@ ../110m_physical/ne_110m_glaciated_areas.*

../zips/110m_physical/ne_110m_lakes.zip: ../110m_physical/ne_110m_lakes.shp ../110m_physical/ne_110m_lakes.dbf
	zip -j -r $@ ../110m_physical/ne_110m_lakes.*

../zips/110m_physical/ne_110m_land.zip: ../110m_physical/ne_110m_land.shp ../110m_physical/ne_110m_land.dbf
	zip -j -r $@ ../110m_physical/ne_110m_land.*

../zips/110m_physical/ne_110m_ocean.zip: ../110m_physical/ne_110m_ocean.shp ../110m_physical/ne_110m_ocean.dbf
	zip -j -r $@ ../110m_physical/ne_110m_ocean.*

../zips/110m_physical/ne_110m_physical_geographic_lines.zip: ../110m_physical/ne_110m_physical_geographic_lines.shp ../110m_physical/ne_110m_physical_geographic_lines.dbf
	zip -j -r $@ ../110m_physical/ne_110m_physical_geographic_lines.*

../zips/110m_physical/ne_110m_rivers_lake_centerlines.zip: ../110m_physical/ne_110m_rivers_lake_centerlines.shp ../110m_physical/ne_110m_rivers_lake_centerlines.dbf
	zip -j -r $@ ../110m_physical/ne_110m_rivers_lake_centerlines.*

../zips/110m_physical/ne_110m_graticules_all.zip: ../110m_physical/ne_110m_graticules_all.shp ../110m_physical/ne_110m_graticules_all.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_all.*

../zips/110m_physical/ne_110m_graticules_1.zip: ../110m_physical/ne_110m_graticules_1.shp ../110m_physical/ne_110m_graticules_1.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_1.*

../zips/110m_physical/ne_110m_graticules_5.zip: ../110m_physical/ne_110m_graticules_5.shp ../110m_physical/ne_110m_graticules_5.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_5.*

../zips/110m_physical/ne_110m_graticules_10.zip: ../110m_physical/ne_110m_graticules_10.shp ../110m_physical/ne_110m_graticules_10.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_10.*

../zips/110m_physical/ne_110m_graticules_15.zip: ../110m_physical/ne_110m_graticules_15.shp ../110m_physical/ne_110m_graticules_15.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_15.*

../zips/110m_physical/ne_110m_graticules_20.zip: ../110m_physical/ne_110m_graticules_20.shp ../110m_physical/ne_110m_graticules_20.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_20.*

../zips/110m_physical/ne_110m_graticules_30.zip: ../110m_physical/ne_110m_graticules_30.shp ../110m_physical/ne_110m_graticules_30.dbf
	zip -j -r $@ ../110m_physical/ne_110m_graticules_30.*

../zips/110m_physical/ne_110m_wgs84_bounding_box.zip: ../zips/110m_physical/ne_110m_wgs84_bounding_box.shp ../zips/110m_physical/ne_110m_wgs84_bounding_box.dbf
	zip -j -r $@ ../zips/110m_physical/ne_110m_wgs84_bounding_box.*

# PACKAGES

../zips/packages/natural_earth_vector.zip:
	zip -j -r ../zips/packages/natural_earth_vector.zip ../10m_cultural ../10m_physical ../50m_cultural ../50m_physical ../110m_cultural ../110m_physical  ../VERSION ../README.md ../CHANGELOG
	cp ../zips/packages/natural_earth_vector.zip ../zips/packages/natural_earth_vector_$(VERSION).zip
	
../zips/packages/Natural_Earth_quick_start/Natural_Earth_quick_start.zip: ../packages/Natural_Earth_quick_start/10m_cultural \
	../packages/Natural_Earth_quick_start/10m_physical \
	../packages/Natural_Earth_quick_start/50m_raster \
	../packages/Natural_Earth_quick_start/110m_cultural \
	../packages/Natural_Earth_quick_start/110m_physical

	zip -j -r ../zips/packages/Natural_Earth_quick_start.zip ../packages/Natural_Earth_quick_start/ ../VERSION ../README.md ../CHANGELOG
	cp ../zips/packages/Natural_Earth_quick_start.zip ../zips/packages/Natural_Earth_quick_start_$(VERSION).zip
	
# copy the master assets into position for 10m_cultural: 
../packages/Natural_Earth_quick_start/10m_cultural:
	cp ../10m_cultural/10m_admin_0_boundary_breakaway_disputed_areas.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_0_boundary_lines_land.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_0_boundary_lines_maritime_indicator.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_0_breakaway_disputed_areas.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_0_map_subunits.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_0_map_units.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_0_scale_ranks_with_minor_islands.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_1_states_provinces_lines_shp.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_admin_1_states_provinces_shp.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_populated_places.* ../packages/Natural_Earth_quick_start/10m_cultural/
	cp ../10m_cultural/10m_urban_areas.* ../packages/Natural_Earth_quick_start/10m_cultural/
	
# copy the master assets into position for 10m_physical: 	
../packages/Natural_Earth_quick_start/10m_physical:
	cp ../10m_physical/10m_coastline.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_geography_marine_polys.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_geography_regions_elevation_points.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_geography_regions_points.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_geography_regions_polys.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_lakes.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_minor_islands.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_ocean.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_rivers_lake_centerlines_scale_ranks.* ../packages/Natural_Earth_quick_start/10m_physical/
	cp ../10m_physical/10m_rivers_lake_centerlines.* ../packages/Natural_Earth_quick_start/10m_physical/
	
# TODO: get the raster from the other repo, which doesn't exist now.
../packages/Natural_Earth_quick_start/50m_raster:
	mkdir -p ../packages/Natural_Earth_quick_start/50m_raster
	rm -rf ../packages/Natural_Earth_quick_start/50m_raster/*
	curl -o ../packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip -L http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/raster/NE1_50M_SR_W.zip
	unzip ../packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip -d ../packages/Natural_Earth_quick_start/50m_raster/
	rm ../packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip
	
# copy the master assets into position for 110m_cultural:
../packages/Natural_Earth_quick_start/110m_cultural:
	cp ../110m_cultural/110m_admin_0_boundary_lines_land.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural/110m_admin_0_countries.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_admin_0_pacific_groupings.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_admin_0_tiny_countries.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_admin_1_states_provinces_shp.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_populated_places.* ../packages/Natural_Earth_quick_start/110m_cultural/
	
# copy the master assets into position for 110m_physical: 	
../packages/Natural_Earth_quick_start/110m_physical:
	cp ../110m_physical/110m_coastline.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_geography_marine_polys.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_geography_regions_points.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_geography_regions_polys.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_lakes.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_ocean.* ../packages/Natural_Earth_quick_start/110m_physical/
	

live: zips
	# NATURALEARTHDATA.com copy
	#special items:
	scp ../updates/natural_earth_update_$(VERSION).zip naturbb6@naturalearthdata.com:download/updates/natural_earth_update_$(VERSION).zip
	scp ../packages/natural_earth_update_$(VERSION).zip naturbb6@naturalearthdata.com:download/packages/natural_earth_update_$(VERSION).zip
	# etc for each theme
	scp ne_10m_admin_0_countries.zip naturbb6@naturalearthdata.com:download/10m/cultural/10m-admin-0-countries.zip
	# FREAC copy
	#special items:
	scp ../updates/natural_earth_update_$(VERSION).zip nacis@ftp.freac.fsu.edu:nacis_ftp/web-download/updates/natural_earth_update_$(VERSION).zip
	scp ../packages/natural_earth_update_$(VERSION).zip nacis@ftp.freac.fsu.edu:nacis_ftp/web-download/packages/natural_earth_update_$(VERSION).zip
	# etc for each theme
	scp ne_10m_admin_0_countries.zip nacis@ftp.freac.fsu.edu:nacis_ftp/web-download/10m/cultural/10m-admin-0-countries.zip


clean:
	mkdir -p ../zips/10m_cultural
	mkdir -p ../zips/10m_physical
	mkdir -p ../zips/50m_cultural
	mkdir -p ../zips/50m_physical
	mkdir -p ../zips/110m_cultural
	mkdir -p ../zips/110m_physical
	mkdir -p ../zips/packages/
	rm -rf ../zips/10m_cultural/*
	rm -rf ../zips/10m_physical/*
	rm -rf ../zips/50m_cultural/*
	rm -rf ../zips/50m_physical/*
	rm -rf ../zips/110m_cultural/*
	rm -rf ../zips/110m_physical/*
	rm -rf ../zips/packages/*
	mkdir -p ../packages/Natural_Earth_quick_start/10m_cultural
	mkdir -p ../packages/Natural_Earth_quick_start/10m_physical
	mkdir -p ../packages/Natural_Earth_quick_start/50m_raster
	mkdir -p ../packages/Natural_Earth_quick_start/110m_cultural
	mkdir -p ../packages/Natural_Earth_quick_start/110m_physical
	rm -rf ../packages/Natural_Earth_quick_start/10m_cultural/*
	rm -rf ../packages/Natural_Earth_quick_start/10m_physical/*
	rm -rf ../packages/Natural_Earth_quick_start/50m_raster/*
	rm -rf ../packages/Natural_Earth_quick_start/110m_cultural/*
	rm -rf ../packages/Natural_Earth_quick_start/110m_physical/*