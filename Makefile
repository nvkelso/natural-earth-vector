VERSION:=$(shell cat VERSION)
VERSION_PREFIXED=_$(VERSION)
#PACKAGE=NaturalEarth-vector-$(VERSION)
#TARBALL=$(PACKAGE).tar.gz
#Remember to escape the : in the urls
#http://www.slac.stanford.edu/BFROOT/www/Computing/Offline/DataDist/ssh-idfile.html
#
#DOCROOT_NE=ftp\://naturalearthdata.com:download
DOCROOT_NE=naturalearthdata.org:download
#DOCROOT_FREAC=ftp.freac.fsu.edu:nacis_ftp/web-download
DOCROOT_FREAC=ftp.freac.fsu.edu:nacis_ftp/web-download

all: zip

zip: zips/packages/natural_earth_vector.zip \
	zips/packages/Natural_Earth_quick_start.zip
	#Made zips...
	
	touch $@

zips/packages/natural_earth_vector.zip: \
	zips/10m_cultural/10m_cultural.zip \
	zips/10m_physical/10m_physical.zip \
	zips/50m_cultural/50m_cultural.zip \
	zips/50m_physical/50m_physical.zip \
	zips/110m_cultural/110m_cultural.zip \
	zips/110m_physical/110m_physical.zip \
	zips/packages/natural_earth_vector.sqlite.zip \
	housekeeping/ne_admin_0_details.xls
	
	zip -r $@ 10m_cultural 10m_physical 50m_cultural 50m_physical 110m_cultural 110m_physical housekeeping tools VERSION README.md CHANGELOG
	#Bake off a version'd iteration of that file, too
	cp $@ archive/natural_earth_vector_$(VERSION).zip


zips/packages/natural_earth_vector.sqlite.zip:
	#SQL-Lite
	rm -f packages/natural_earth_vector.sqlite
	for shp in 10m_cultural/*.shp 10m_physical/*.shp 50m_cultural/*.shp 50m_physical/*.shp 110m_cultural/*.shp 110m_physical/*.shp; \
	do \
		ogr2ogr -f SQLite -append packages/natural_earth_vector.sqlite $$shp; \
	done
	zip $@ packages/natural_earth_vector.sqlite VERSION README.md CHANGELOG

	cp $@ archive/natural_earth_vector.sqlite_$(VERSION).zip
	
	
zips/packages/Natural_Earth_quick_start.zip: \
	packages/Natural_Earth_quick_start/10m_cultural/status.txt \
	packages/Natural_Earth_quick_start/10m_physical/status.txt \
	packages/Natural_Earth_quick_start/50m_raster/status.txt \
	packages/Natural_Earth_quick_start/110m_cultural/status.txt \
	packages/Natural_Earth_quick_start/110m_physical/status.txt \
	packages/Natural_Earth_quick_start/Natural_Earth_quick_start_for_ArcMap.mxd \
	packages/Natural_Earth_quick_start/Natural_Earth_quick_start_for_QGIS.qgs

	cp CHANGELOG packages/Natural_Earth_quick_start/CHANGELOG
	cp README.md packages/Natural_Earth_quick_start/README.md
	cp VERSION packages/Natural_Earth_quick_start/VERSION

	rm $@
	zip -r $@ packages/Natural_Earth_quick_start/
	cp $@ archive/Natural_Earth_quick_start_$(VERSION).zip
	
	
zips/housekeeping: \
	zips/housekeeping/ne_admin_0_details.zip \
	zips/housekeeping/ne_admin_0_full_attributes.zip \
	zips/housekeeping/ne_themes_versions.zip \
	
	touch $@


zips/housekeeping/ne_admin_0_details.zip:
	zip -r $@ housekeeping/ne_admin_0_details.xls VERSION README.md CHANGELOG
	
zips/housekeeping/ne_admin_0_full_attributes.zip:
	zip -r $@ housekeeping/ne_admin_0_full_attributes.xls VERSION README.md CHANGELOG
	
zips/housekeeping/ne_themes_versions.zip:
	zip -r $@ housekeeping/ne_themes_versions.xls VERSION README.md CHANGELOG



# PER THEME, BY SCALESET

# SCALESET ZIPS by zoom and physical, cultural (6 total)

zips/10m_cultural/10m_cultural.zip: \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.zip \
	zips/10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.zip \
	zips/10m_cultural/ne_10m_admin_0_disputed_areas.zip \
	zips/10m_cultural/ne_10m_admin_0_countries.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_lakes.zip \
	zips/10m_cultural/ne_10m_admin_0_map_subunits.zip \
	zips/10m_cultural/ne_10m_admin_0_map_units.zip \
	zips/10m_cultural/ne_10m_admin_0_pacific_groupings.zip \
	zips/10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.zip \
	zips/10m_cultural/ne_10m_admin_0_scale_rank.zip \
	zips/10m_cultural/ne_10m_admin_0_sovereignty.zip \
	zips/10m_cultural/ne_10m_admin_0_antarctic_claims.zip \
	zips/10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.zip \
	zips/10m_cultural/ne_10m_admin_0_label_points.zip \
	zips/10m_cultural/ne_10m_admin_0_seams.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_geodb.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_scale_rank_geodb.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_lines.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_lines_geodb.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_shp.zip \
	zips/10m_cultural/ne_10m_admin_1_label_points.zip \
	zips/10m_cultural/ne_10m_admin_1_seams.zip \
	zips/10m_cultural/ne_10m_populated_places_simple.zip \
	zips/10m_cultural/ne_10m_populated_places.zip \
	zips/10m_cultural/ne_10m_railroads.zip \
	zips/10m_cultural/ne_10m_railroads_north_america.zip \
	zips/10m_cultural/ne_10m_roads_north_america.zip \
	zips/10m_cultural/ne_10m_roads.zip \
	zips/10m_cultural/ne_10m_urban_areas_landscan.zip \
	zips/10m_cultural/ne_10m_urban_areas.zip \
	zips/10m_cultural/ne_10m_parks_and_protected_lands.zip \
	zips/10m_cultural/ne_10m_airports.zip \
	zips/10m_cultural/ne_10m_ports.zip \
	zips/10m_cultural/ne_10m_time_zones.zip \
	zips/10m_cultural/ne_10m_cultural_building_blocks_all.zip
	
	zip -r $@ 10m_cultural VERSION README.md CHANGELOG
	cp $@ archive/10m_cultural_$(VERSION).zip	

zips/10m_physical/10m_physical.zip: \
	zips/10m_physical/ne_10m_antarctic_ice_shelves_lines.zip \
	zips/10m_physical/ne_10m_antarctic_ice_shelves_polys.zip \
	zips/10m_physical/ne_10m_coastline.zip \
	zips/10m_physical/ne_10m_geographic_lines.zip \
	zips/10m_physical/ne_10m_geography_marine_polys.zip \
	zips/10m_physical/ne_10m_geography_regions_elevation_points.zip \
	zips/10m_physical/ne_10m_geography_regions_points.zip \
	zips/10m_physical/ne_10m_geography_regions_polys.zip \
	zips/10m_physical/ne_10m_glaciated_areas.zip \
	zips/10m_physical/ne_10m_lakes_europe.zip \
	zips/10m_physical/ne_10m_lakes_historic.zip \
	zips/10m_physical/ne_10m_lakes_north_america.zip \
	zips/10m_physical/ne_10m_lakes_pluvial.zip \
	zips/10m_physical/ne_10m_lakes.zip \
	zips/10m_physical/ne_10m_land.zip \
	zips/10m_physical/ne_10m_land_scale_rank.zip \
	zips/10m_physical/ne_10m_minor_islands_coastline.zip \
	zips/10m_physical/ne_10m_minor_islands.zip \
	zips/10m_physical/ne_10m_ocean.zip \
	zips/10m_physical/ne_10m_ocean_scale_rank.zip \
	zips/10m_physical/ne_10m_playas.zip \
	zips/10m_physical/ne_10m_reefs.zip \
	zips/10m_physical/ne_10m_rivers_europe.zip \
	zips/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.zip \
	zips/10m_physical/ne_10m_rivers_lake_centerlines.zip \
	zips/10m_physical/ne_10m_rivers_north_america.zip \
	zips/10m_physical/ne_10m_bathymetry_all.zip \
	zips/10m_physical/ne_10m_bathymetry_A_10000.zip \
	zips/10m_physical/ne_10m_bathymetry_B_9000.zip \
	zips/10m_physical/ne_10m_bathymetry_C_8000.zip \
	zips/10m_physical/ne_10m_bathymetry_D_7000.zip \
	zips/10m_physical/ne_10m_bathymetry_E_6000.zip \
	zips/10m_physical/ne_10m_bathymetry_F_5000.zip \
	zips/10m_physical/ne_10m_bathymetry_G_4000.zip \
	zips/10m_physical/ne_10m_bathymetry_H_3000.zip \
	zips/10m_physical/ne_10m_bathymetry_I_2000.zip \
	zips/10m_physical/ne_10m_bathymetry_J_1000.zip \
	zips/10m_physical/ne_10m_bathymetry_K_200.zip \
	zips/10m_physical/ne_10m_bathymetry_L_0.zip \
	zips/10m_physical/ne_10m_graticules_all.zip \
	zips/10m_physical/ne_10m_graticules_1.zip \
	zips/10m_physical/ne_10m_graticules_5.zip \
	zips/10m_physical/ne_10m_graticules_10.zip \
	zips/10m_physical/ne_10m_graticules_15.zip \
	zips/10m_physical/ne_10m_graticules_20.zip \
	zips/10m_physical/ne_10m_graticules_30.zip \
	zips/10m_physical/ne_10m_wgs84_bounding_box.zip \
	zips/10m_physical/ne_10m_land_ocean_label_points.zip \
	zips/10m_physical/ne_10m_land_ocean_seams.zip \
	zips/10m_physical/ne_10m_minor_islands_label_points.zip \
	zips/10m_physical/ne_10m_physical_building_blocks_all.zip

	zip -j -r $@ 10m_physical VERSION README.md CHANGELOG
	cp $@ archive/10m_physical_$(VERSION).zip

zips/50m_cultural/50m_cultural.zip: \
	zips/50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.zip \
	zips/50m_cultural/ne_50m_admin_0_boundary_lines_land.zip \
	zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.zip \
	zips/50m_cultural/ne_50m_admin_0_boundary_map_units.zip \
	zips/50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.zip \
	zips/50m_cultural/ne_50m_admin_0_countries.zip \
	zips/50m_cultural/ne_50m_admin_0_countries_lakes.zip \
	zips/50m_cultural/ne_50m_admin_0_map_subunits.zip \
	zips/50m_cultural/ne_50m_admin_0_map_units.zip \
	zips/50m_cultural/ne_50m_admin_0_pacific_groupings.zip \
	zips/50m_cultural/ne_50m_admin_0_scale_rank.zip \
	zips/50m_cultural/ne_50m_admin_0_sovereignty.zip \
	zips/50m_cultural/ne_50m_admin_0_tiny_countries.zip \
	zips/50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.zip \
	zips/50m_cultural/ne_50m_admin_1_states_provinces_lines.zip \
	zips/50m_cultural/ne_50m_admin_1_states_provinces_shp.zip \
	zips/50m_cultural/ne_50m_admin_1_states_provinces_shp_scale_rank.zip \
	zips/50m_cultural/ne_50m_admin_1_states_provinces_lakes_shp.zip \
	zips/50m_cultural/ne_50m_populated_places_simple.zip \
	zips/50m_cultural/ne_50m_populated_places.zip \
	zips/50m_cultural/ne_50m_urban_areas.zip

	zip -j -r $@ 50m_cultural VERSION README.md CHANGELOG
	cp $@ archive/50m_cultural_$(VERSION).zip

zips/50m_physical/50m_physical.zip: \
	zips/50m_physical/ne_50m_antarctic_ice_shelves_lines.zip \
	zips/50m_physical/ne_50m_antarctic_ice_shelves_polys.zip \
	zips/50m_physical/ne_50m_coastline.zip \
	zips/50m_physical/ne_50m_geographic_lines.zip \
	zips/50m_physical/ne_50m_geography_marine_polys.zip \
	zips/50m_physical/ne_50m_geography_regions_elevation_points.zip \
	zips/50m_physical/ne_50m_geography_regions_points.zip \
	zips/50m_physical/ne_50m_geography_regions_polys.zip \
	zips/50m_physical/ne_50m_glaciated_areas.zip \
	zips/50m_physical/ne_50m_lakes_historic.zip \
	zips/50m_physical/ne_50m_lakes.zip \
	zips/50m_physical/ne_50m_land.zip \
	zips/50m_physical/ne_50m_ocean.zip \
	zips/50m_physical/ne_50m_playas.zip \
	zips/50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.zip \
	zips/50m_physical/ne_50m_rivers_lake_centerlines.zip \
	zips/50m_physical/ne_50m_graticules_all.zip \
	zips/50m_physical/ne_50m_graticules_1.zip \
	zips/50m_physical/ne_50m_graticules_5.zip \
	zips/50m_physical/ne_50m_graticules_10.zip \
	zips/50m_physical/ne_50m_graticules_15.zip \
	zips/50m_physical/ne_50m_graticules_20.zip \
	zips/50m_physical/ne_50m_graticules_30.zip \
	zips/50m_physical/ne_50m_wgs84_bounding_box.zip

	zip -j -r $@ 50m_physical VERSION README.md CHANGELOG
	cp $@ archive/50m_physical_$(VERSION).zip

zips/110m_cultural/110m_cultural.zip: \
	zips/110m_cultural/ne_110m_admin_0_boundary_lines_land.zip \
	zips/110m_cultural/ne_110m_admin_0_countries.zip \
	zips/110m_cultural/ne_110m_admin_0_countries_lakes.zip \
	zips/110m_cultural/ne_110m_admin_0_map_units.zip \
	zips/110m_cultural/ne_110m_admin_0_pacific_groupings.zip \
	zips/110m_cultural/ne_110m_admin_0_scale_rank.zip \
	zips/110m_cultural/ne_110m_admin_0_sovereignty.zip \
	zips/110m_cultural/ne_110m_admin_0_tiny_countries.zip \
	zips/110m_cultural/ne_110m_admin_1_states_provinces_lines.zip \
	zips/110m_cultural/ne_110m_admin_1_states_provinces_shp.zip \
	zips/110m_cultural/ne_110m_admin_1_states_provinces_lakes_shp.zip \
	zips/110m_cultural/ne_110m_admin_1_states_provinces_shp_scale_rank.zip \
	zips/110m_cultural/ne_110m_populated_places_simple.zip \
	zips/110m_cultural/ne_110m_populated_places.zip
	
	zip -j -r $@ 110m_cultural VERSION README.md CHANGELOG
	cp $@ archive/110m_cultural_$(VERSION).zip

zips/110m_physical/110m_physical.zip: \
	zips/110m_physical/ne_110m_coastline.zip \
	zips/110m_physical/ne_110m_geographic_lines.zip \
	zips/110m_physical/ne_110m_geography_marine_polys.zip \
	zips/110m_physical/ne_110m_geography_regions_elevation_points.zip \
	zips/110m_physical/ne_110m_geography_regions_points.zip \
	zips/110m_physical/ne_110m_geography_regions_polys.zip \
	zips/110m_physical/ne_110m_glaciated_areas.zip \
	zips/110m_physical/ne_110m_lakes.zip \
	zips/110m_physical/ne_110m_land.zip \
	zips/110m_physical/ne_110m_ocean.zip \
	zips/110m_physical/ne_110m_rivers_lake_centerlines.zip \
	zips/110m_physical/ne_110m_graticules_all.zip \
	zips/110m_physical/ne_110m_graticules_1.zip \
	zips/110m_physical/ne_110m_graticules_5.zip \
	zips/110m_physical/ne_110m_graticules_10.zip \
	zips/110m_physical/ne_110m_graticules_15.zip \
	zips/110m_physical/ne_110m_graticules_20.zip \
	zips/110m_physical/ne_110m_graticules_30.zip \
	zips/110m_physical/ne_110m_wgs84_bounding_box.zip

	zip -j -r $@ 110m_physical VERSION README.md CHANGELOG
	cp $@ archive/110m_physical_$(VERSION).zip



#DERIVED THEMES

# POPULATED PLACES

#10m simple- populated places
10m_cultural/ne_10m_populated_places_simple.shp: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT scalerank, natscale, labelrank, featurecla, name, namepar, namealt, diffascii, nameascii, adm0cap, capalt, capin, worldcity, megacity, sov0name, sov_a3, adm0name, adm0_a3, adm1name, iso_a2, note, latitude, longitude, changed, namediff, diffnote, pop_max, pop_min, pop_other, rank_max, rank_min, geonameid, meganame, ls_name, ls_match, checkme FROM ne_10m_populated_places ORDER BY natscale" $@ 10m_cultural/ne_10m_populated_places.shp
    
#50m full - populated places
50m_cultural/ne_50m_populated_places.shp: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	# “SCALERANK” <= 4 Or "FEATURECLA" = 'Admin-0 capital' Or "FEATURECLA" = 'Admin-0 capital alt' Or "FEATURECLA" = 'Admin-0 region capital' Or "FEATURECLA" = 'Admin-1 region capital' Or "FEATURECLA" = 'Scientific station'	
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_populated_places WHERE scalerank <= 4 OR featurecla = 'Admin-0 capital' OR featurecla = 'Admin-0 capital alt' OR featurecla = 'Admin-0 region capital' OR featurecla = 'Admin-1 region capital' OR featurecla = 'Scientific station' ORDER BY natscale" $@ 10m_cultural/ne_10m_populated_places.shp

50m_cultural/ne_50m_populated_places_simple.shp: 50m_cultural/ne_50m_populated_places.shp 50m_cultural/ne_50m_populated_places.dbf
	#50m simple - populated places
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT scalerank, natscale, labelrank, featurecla, name, namepar, namealt, diffascii, nameascii, adm0cap, capalt, capin, worldcity, megacity, sov0name, sov_a3, adm0name, adm0_a3, adm1name, iso_a2, note, latitude, longitude, changed, namediff, diffnote, pop_max, pop_min, pop_other, rank_max, rank_min, geonameid, meganame, ls_name, ls_match, checkme FROM ne_50m_populated_places ORDER BY natscale" $@ 50m_cultural/ne_50m_populated_places.shp

#110m full - populated places
110m_cultural/ne_110m_populated_places.shp: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	# “SCALERANK” <= 1 Or "FEATURECLA" = 'Admin-0 capital' Or "FEATURECLA" = 'Admin-0 capital alt'
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_populated_places WHERE scalerank <= 1 OR featurecla = 'Admin-0 capital' OR featurecla = 'Admin-0 capital alt' ORDER BY natscale" $@ 10m_cultural/ne_10m_populated_places.shp

110m_cultural/ne_110m_populated_places_simple.shp: 110m_cultural/ne_110m_populated_places.shp 110m_cultural/ne_110m_populated_places.dbf
	#110m simple - populated places
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT scalerank, natscale, labelrank, featurecla, name, namepar, namealt, diffascii, nameascii, adm0cap, capalt, capin, worldcity, megacity, sov0name, sov_a3, adm0name, adm0_a3, adm1name, iso_a2, note, latitude, longitude, changed, namediff, diffnote, pop_max, pop_min, pop_other, rank_max, rank_min, geonameid, meganame, ls_name, ls_match, checkme FROM ne_110m_populated_places ORDER BY natscale" $@ 110m_cultural/ne_110m_populated_places.shp

# TINY COUNTRIES

# 110m

110m_cultural/ne_110m_admin_0_tiny_countries.shp: 50m_cultural/ne_50m_admin_0_tiny_countries.shp 50m_cultural/ne_50m_admin_0_tiny_countries.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_50m_admin_0_tiny_countries WHERE scalerank <= 2 ORDER BY scalerank" $@ 50m_cultural/ne_50m_admin_0_tiny_countries.shp

# AIRPORTS

#50m airports
50m_cultural/ne_50m_airports.shp: 10m_cultural/ne_10m_airports.shp 10m_cultural/ne_10m_airports.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_airports WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_cultural/ne_10m_airports.shp

# PORTS

# 50m ports
50m_cultural/ne_50m_ports.shp: 10m_cultural/ne_10m_ports.shp 10m_cultural/ne_10m_ports.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_ports WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_cultural/ne_10m_ports.shp
	
# Physical labels

# 50m

50m_physical/ne_50m_geographic_lines.shp: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 $@ 10m_physical/ne_10m_geographic_lines.shp

50m_physical/ne_50m_geography_regions_points.shp: 10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_regions_points WHERE scalerank <= 5 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_points.shp

50m_physical/ne_50m_geography_regions_elevation_points.shp: 10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_regions_elevation_points WHERE scalerank <= 5 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_elevation_points.shp

50m_physical/ne_50m_geography_marine_polys.shp: 10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_marine_polys WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_marine_polys.shp

50m_physical/ne_50m_geography_regions_polys.shp: 10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_regions_polys WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_polys.shp


# 110m

110m_physical/ne_110m_geographic_lines.shp: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 $@ 10m_physical/ne_10m_geographic_lines.shp

110m_physical/ne_110m_geography_regions_points.shp: 10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_regions_points WHERE scalerank <= 2 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_points.shp
        
110m_physical/ne_110m_geography_regions_elevation_points.shp: 10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_regions_elevation_points WHERE scalerank <= 2 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_elevation_points.shp
    
110m_physical/ne_110m_geography_marine_polys.shp: 10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252 -sql "SELECT * FROM ne_10m_geography_marine_polys WHERE scalerank <= 1 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_marine_polys.shp

110m_physical/ne_110m_geography_regions_plys.shp: 10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf
	ogr2ogr -overwrite -lco WINDOWS-1252  -sql "SELECT * FROM ne_10m_geography_regions_polys WHERE scalerank <= 1 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_polys.shp        
	

# THEMES

# If either the geometry or the attributes change, time to remake the ZIPs

# grep pattern matching: 
#find:    (\.\./zips/(\w+)/(\w+)\.zip): \r\tzip -j -r \$@ \r
#replace: \1: \2/\3.shp \2/\3.dbf\r\tzip -j -r $@ \2/\3.*\r

# 10m_cultural

zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_land.shp 10m_cultural/ne_10m_admin_0_boundary_lines_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_land$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_map_units$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.shp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_maritime_indicator$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_pacific_groupings.zip: 10m_cultural/ne_10m_admin_0_pacific_groupings.shp 10m_cultural/ne_10m_admin_0_pacific_groupings.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_pacific_groupings$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_disputed_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_disputed_areas.zip: 10m_cultural/ne_10m_admin_0_disputed_areas.shp 10m_cultural/ne_10m_admin_0_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_disputed_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.zip: 10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_countries.zip: 10m_cultural/ne_10m_admin_0_countries.shp 10m_cultural/ne_10m_admin_0_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_countries_lakes.zip: 10m_cultural/ne_10m_admin_0_countries_lakes.shp 10m_cultural/ne_10m_admin_0_countries_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_lakes$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_map_subunits.zip: 10m_cultural/ne_10m_admin_0_map_subunits.shp 10m_cultural/ne_10m_admin_0_map_subunits.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_map_subunits$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_map_units.zip: 10m_cultural/ne_10m_admin_0_map_units.shp 10m_cultural/ne_10m_admin_0_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_map_units$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
		
zips/10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.zip: 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_scale_rank_minor_islands$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_scale_rank.zip: 10m_cultural/ne_10m_admin_0_scale_rank.shp 10m_cultural/ne_10m_admin_0_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_sovereignty.zip: 10m_cultural/ne_10m_admin_0_sovereignty.shp 10m_cultural/ne_10m_admin_0_sovereignty.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_sovereignty$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_label_points.zip: 10m_cultural/ne_10m_admin_0_label_points.shp 10m_cultural/ne_10m_admin_0_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_label_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_seams.zip: 10m_cultural/ne_10m_admin_0_seams.shp 10m_cultural/ne_10m_admin_0_seams.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_seams$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_0_antarctic_claims.zip: 10m_cultural/ne_10m_admin_0_antarctic_claims.shp 10m_cultural/ne_10m_admin_0_antarctic_claims.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_antarctic_claims$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.zip: 10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.shp 10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_antarctic_claim_limit_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.zip: 10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.shp 10m_cultural/ne_10m_admin_1_states_provinces_lakes_shp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_states_provinces_lakes_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_admin_1_states_provinces_lines.zip: 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.shp 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.dbf
	cp VERSION 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.*
	cp $@ archive/ne_10m_admin_1_states_provinces_lines_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@))_shp.shp

zips/10m_cultural/ne_10m_admin_1_states_provinces_shp.zip: 10m_cultural/ne_10m_admin_1_states_provinces_shp.shp 10m_cultural/ne_10m_admin_1_states_provinces_shp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_states_provinces_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_admin_1_seams.zip: 10m_cultural/ne_10m_admin_1_seams.shp 10m_cultural/ne_10m_admin_1_seams.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_seams$(VERSION_PREFIXED).zip	
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_populated_places_simple.zip: 10m_cultural/ne_10m_populated_places_simple.shp 10m_cultural/ne_10m_populated_places_simple.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_populated_places_simple$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_populated_places.zip: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_populated_places$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_railroads.zip: 10m_cultural/ne_10m_railroads.shp 10m_cultural/ne_10m_railroads.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/railroads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_railroads$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_railroads_north_america.zip: 10m_cultural/ne_10m_railroads_north_america.shp 10m_cultural/ne_10m_railroads_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/railroads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_railroads_north_america$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_roads.zip: 10m_cultural/ne_10m_roads.shp 10m_cultural/ne_10m_roads.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/roads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_roads$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_roads_north_america.zip: 10m_cultural/ne_10m_roads_north_america.shp 10m_cultural/ne_10m_roads_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/roads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_roads_north_america$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_urban_areas_landscan.zip: 10m_cultural/ne_10m_urban_areas_landscan.shp 10m_cultural/ne_10m_urban_areas_landscan.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_urban_areas_landscan$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_urban_areas.zip: 10m_cultural/ne_10m_urban_areas.shp 10m_cultural/ne_10m_urban_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-urban-area/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_urban_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_airports.zip: 10m_cultural/ne_10m_airports.shp 10m_cultural/ne_10m_airports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/airports/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_airports$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_ports.zip: 10m_cultural/ne_10m_ports.shp 10m_cultural/ne_10m_ports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/ports/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_ports$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/10m_cultural/ne_10m_time_zones.zip: 10m_cultural/ne_10m_time_zones.shp 10m_cultural/ne_10m_time_zones.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/timezones/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_time_zones$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_cultural/ne_10m_cultural_building_blocks_all.zip: \
	zips/10m_cultural/ne_10m_admin_0_label_points.zip \
	zips/10m_cultural/ne_10m_admin_0_seams.zip \
	zips/10m_cultural/ne_10m_admin_1_label_points.zip \
	zips/10m_cultural/ne_10m_admin_1_seams.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip \
	zips/10m_physical/ne_10m_coastline.zip \
	zips/10m_physical/ne_10m_minor_islands_coastline.zip
	
	zip -j -r $@ 10m_cultural/ne_10m_admin_0_label_points.* 10m_cultural/ne_10m_admin_0_seams.* 10m_cultural/ne_10m_admin_1_label_points.* 10m_cultural/ne_10m_admin_1_seams.* 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.* 10m_cultural/ne_10m_admin_0_boundary_lines_land.* 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.* 10m_physical/ne_10m_coastline.* 10m_physical/ne_10m_minor_islands_coastline.*
	cp $@ archive/ne_10m_cultural_building_blocks_all$(VERSION_PREFIXED).zip



# folders for theme groups or geodb special items
zips/10m_cultural/ne_10m_admin_1_label_points.zip: 10m_cultural/ne_10m_admin_1_label_points.gdb/gdb
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_label_points.gdb $(subst zips/, ,$(basename $@)).VERSION.txt $(subst zips/, ,$(basename $@)).README.html
	cp $@ archive/ne_10m_admin_1_label_points$(VERSION_PREFIXED).zip

zips/10m_cultural/ne_10m_admin_1_states_provinces_geodb.zip: 10m_cultural/ne_10m_admin_1_states_provinces_geodb.gdb/gdb
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_states_provinces_geodb.gdb $(subst zips/, ,$(basename $@)).VERSION.txt $(subst zips/, ,$(basename $@)).README.html
	cp $@ archive/ne_10m_admin_1_states_provinces_geodb$(VERSION_PREFIXED).zip

zips/10m_cultural/ne_10m_admin_1_states_provinces_scale_rank_geodb.zip: 10m_cultural/ne_10m_admin_1_states_provinces_scale_rank_geodb.gdb/gdb
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_states_provinces_scale_rank_geodb.gdb $(subst zips/, ,$(basename $@)).VERSION.txt $(subst zips/, ,$(basename $@)).README.html
	cp $@ archive/ne_10m_admin_1_states_provinces_scale_rank_geodb$(VERSION_PREFIXED).zip

zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.zip: 10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.gdb/gdb
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_states_provinces_lakes_geodb.gdb $(subst zips/, ,$(basename $@)).VERSION.txt $(subst zips/, ,$(basename $@)).README.html
	cp $@ archive/ne_10m_admin_1_states_provinces_lakes_geodb$(VERSION_PREFIXED).zip

zips/10m_cultural/ne_10m_admin_1_states_provinces_lines_geodb.zip: 10m_cultural/ne_10m_admin_1_states_provinces_lines_geodb.gdb/gdb
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_states_provinces_lines_geodb.gdb $(subst zips/, ,$(basename $@)).VERSION.txt $(subst zips/, ,$(basename $@)).README.html
	cp $@ archive/ne_10m_admin_1_states_provinces_lines_geodb$(VERSION_PREFIXED).zip

zips/10m_cultural/ne_10m_parks_and_protected_lands.zip: \
	10m_cultural/ne_10m_parks_and_protected_lands_area.shp 10m_cultural/ne_10m_parks_and_protected_lands_area.dbf \
	10m_cultural/ne_10m_parks_and_protected_lands_scale_rank.shp 10m_cultural/ne_10m_parks_and_protected_lands_scale_rank.dbf \
	10m_cultural/ne_10m_parks_and_protected_lands_line.shp 10m_cultural/ne_10m_parks_and_protected_lands_line.dbf \
	10m_cultural/ne_10m_parks_and_protected_lands_point.shp 10m_cultural/ne_10m_parks_and_protected_lands_point.dbf
	
	cp VERSION 10m_cultural/ne_10m_parks_and_protected_lands_area.VERSION.txt
	cp VERSION 10m_cultural/ne_10m_parks_and_protected_lands_scale_rank.VERSION.txt
	cp VERSION 10m_cultural/ne_10m_parks_and_protected_lands_line.VERSION.txt
	cp VERSION 10m_cultural/ne_10m_parks_and_protected_lands_point.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/parks-and-protected-lands/ > 10m_cultural/ne_10m_parks_and_protected_lands_area.README.html
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/parks-and-protected-lands/ > 10m_cultural/ne_10m_parks_and_protected_lands_scale_rank.README.html
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/parks-and-protected-lands/ > 10m_cultural/ne_10m_parks_and_protected_lands_line.README.html
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/parks-and-protected-lands/ > 10m_cultural/ne_10m_parks_and_protected_lands_point.README.html
	zip -j -r $@ 10m_cultural/ne_10m_parks_and_protected_lands*.*
	cp $@ archive/ne_10m_parks_and_protected_lands$(VERSION_PREFIXED).zip
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/ne_10m_parks_and_protected_lands_area.geojson 10m_cultural/ne_10m_parks_and_protected_lands_area.shp
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/ne_10m_parks_and_protected_lands_scale_rank.geojson 10m_cultural/ne_10m_parks_and_protected_lands_scale_rank.shp
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/ne_10m_parks_and_protected_lands_line.geojson 10m_cultural/ne_10m_parks_and_protected_lands_line.shp
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/ne_10m_parks_and_protected_lands_point.geojson 10m_cultural/ne_10m_parks_and_protected_lands_point.shp



# 10m physical:

zips/10m_physical/ne_10m_antarctic_ice_shelves_lines.zip: 10m_physical/ne_10m_antarctic_ice_shelves_lines.shp 10m_physical/ne_10m_antarctic_ice_shelves_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_antarctic_ice_shelves_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_antarctic_ice_shelves_polys.zip: 10m_physical/ne_10m_antarctic_ice_shelves_polys.shp 10m_physical/ne_10m_antarctic_ice_shelves_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_antarctic_ice_shelves_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_coastline.zip: 10m_physical/ne_10m_coastline.shp 10m_physical/ne_10m_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-coastline/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_coastline$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_geographic_lines.zip: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-geographic-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geographic_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_geography_marine_polys.zip: 10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_marine_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_geography_regions_elevation_points.zip: 10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_regions_elevation_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_geography_regions_points.zip: 10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_regions_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_geography_regions_polys.zip: 10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_regions_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_glaciated_areas.zip: 10m_physical/ne_10m_glaciated_areas.shp 10m_physical/ne_10m_glaciated_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-glaciated-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_glaciated_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_lakes_europe.zip: 10m_physical/ne_10m_lakes_europe.shp 10m_physical/ne_10m_lakes_europe.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_europe$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_lakes_historic.zip: 10m_physical/ne_10m_lakes_historic.shp 10m_physical/ne_10m_lakes_historic.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_historic$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_lakes_north_america.zip: 10m_physical/ne_10m_lakes_north_america.shp 10m_physical/ne_10m_lakes_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_north_america$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_lakes_pluvial.zip: 10m_physical/ne_10m_lakes_pluvial.shp 10m_physical/ne_10m_lakes_pluvial.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_pluvial$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_lakes.zip: 10m_physical/ne_10m_lakes.shp 10m_physical/ne_10m_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_land.zip: 10m_physical/ne_10m_land.shp 10m_physical/ne_10m_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_land_scale_rank.zip: 10m_physical/ne_10m_land_scale_rank.shp 10m_physical/ne_10m_land_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_minor_islands_coastline.zip: 10m_physical/ne_10m_minor_islands_coastline.shp 10m_physical/ne_10m_minor_islands_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-minor-islands/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_minor_islands_coastline$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_minor_islands.zip: 10m_physical/ne_10m_minor_islands.shp 10m_physical/ne_10m_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-minor-islands/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_minor_islands$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_ocean.zip: 10m_physical/ne_10m_ocean.shp 10m_physical/ne_10m_ocean.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_ocean$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_ocean_scale_rank.zip: 10m_physical/ne_10m_ocean_scale_rank.shp 10m_physical/ne_10m_ocean_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_ocean_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_playas.zip: 10m_physical/ne_10m_playas.shp 10m_physical/ne_10m_playas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-playas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_playas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_reefs.zip: 10m_physical/ne_10m_reefs.shp 10m_physical/ne_10m_reefs.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-reefs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_reefs$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_rivers_europe.zip: 10m_physical/ne_10m_rivers_europe.shp 10m_physical/ne_10m_rivers_europe.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_europe$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.zip: 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_lake_centerlines_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_rivers_lake_centerlines.zip: 10m_physical/ne_10m_rivers_lake_centerlines.shp 10m_physical/ne_10m_rivers_lake_centerlines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_lake_centerlines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_rivers_north_america.zip: 10m_physical/ne_10m_rivers_north_america.shp 10m_physical/ne_10m_rivers_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_north_america$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_bathymetry_all.zip: \
	zips/10m_physical/ne_10m_bathymetry_A_10000.zip \
	zips/10m_physical/ne_10m_bathymetry_B_9000.zip \
	zips/10m_physical/ne_10m_bathymetry_C_8000.zip \
	zips/10m_physical/ne_10m_bathymetry_D_7000.zip \
	zips/10m_physical/ne_10m_bathymetry_E_6000.zip \
	zips/10m_physical/ne_10m_bathymetry_F_5000.zip \
	zips/10m_physical/ne_10m_bathymetry_G_4000.zip \
	zips/10m_physical/ne_10m_bathymetry_H_3000.zip \
	zips/10m_physical/ne_10m_bathymetry_I_2000.zip \
	zips/10m_physical/ne_10m_bathymetry_J_1000.zip \
	zips/10m_physical/ne_10m_bathymetry_K_200.zip \
	zips/10m_physical/ne_10m_bathymetry_L_0.zip
	
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/*.*
	cp $@ archive/ne_10m_bathymetry_all$(VERSION_PREFIXED).zip

zips/10m_physical/ne_10m_bathymetry_A_10000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.*
	cp $@ archive/ne_10m_bathymetry_A_10000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.shp

zips/10m_physical/ne_10m_bathymetry_B_9000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.*
	cp $@ archive/ne_10m_bathymetry_B_9000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.shp

zips/10m_physical/ne_10m_bathymetry_C_8000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.*
	cp $@ archive/ne_10m_bathymetry_C_8000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.shp

zips/10m_physical/ne_10m_bathymetry_D_7000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.*
	cp $@ archive/ne_10m_bathymetry_D_7000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.shp

zips/10m_physical/ne_10m_bathymetry_E_6000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.*
	cp $@ archive/ne_10m_bathymetry_E_6000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.shp

zips/10m_physical/ne_10m_bathymetry_F_5000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.*
	cp $@ archive/ne_10m_bathymetry_F_5000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.shp

zips/10m_physical/ne_10m_bathymetry_G_4000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.*
	cp $@ archive/ne_10m_bathymetry_G_4000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.shp

zips/10m_physical/ne_10m_bathymetry_H_3000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.*
	cp $@ archive/ne_10m_bathymetry_H_3000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.shp

zips/10m_physical/ne_10m_bathymetry_I_2000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.*
	cp $@ archive/ne_10m_bathymetry_I_2000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.shp

zips/10m_physical/ne_10m_bathymetry_J_1000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.*
	cp $@ archive/ne_10m_bathymetry_J_1000$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.shp

zips/10m_physical/ne_10m_bathymetry_K_200.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.*
	cp $@ archive/ne_10m_bathymetry_K_200$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.shp

zips/10m_physical/ne_10m_bathymetry_L_0.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.*
	cp $@ archive/ne_10m_bathymetry_L_0$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.shp

zips/10m_physical/ne_10m_graticules_all.zip: \
	zips/10m_physical/ne_10m_graticules_1.zip \
	zips/10m_physical/ne_10m_graticules_5.zip \
	zips/10m_physical/ne_10m_graticules_10.zip \
	zips/10m_physical/ne_10m_graticules_15.zip \
	zips/10m_physical/ne_10m_graticules_20.zip \
	zips/10m_physical/ne_10m_graticules_30.zip \
	zips/10m_physical/ne_10m_wgs84_bounding_box.zip
	
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/*.*
	cp $@ archive/ne_10m_graticules_all$(VERSION_PREFIXED).zip

zips/10m_physical/ne_10m_graticules_1.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_1.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_1.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_1.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_1.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_1.*
	cp $@ archive/ne_10m_graticules_1$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp

zips/10m_physical/ne_10m_graticules_5.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.*
	cp $@ archive/ne_10m_graticules_5$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp

zips/10m_physical/ne_10m_graticules_10.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.*
	cp $@ archive/ne_10m_graticules_10$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp

zips/10m_physical/ne_10m_graticules_15.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.*
	cp $@ archive/ne_10m_graticules_15$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp

zips/10m_physical/ne_10m_graticules_20.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.*
	cp $@ archive/ne_10m_graticules_20$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp

zips/10m_physical/ne_10m_graticules_30.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.*
	cp $@ archive/ne_10m_graticules_30$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp

zips/10m_physical/ne_10m_wgs84_bounding_box.zip: 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.shp 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.*
	cp $@ archive/ne_10m_wgs84_bounding_box$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp
	
zips/10m_physical/ne_10m_land_ocean_label_points.zip: 10m_physical/ne_10m_land_ocean_label_points.shp 10m_physical/ne_10m_land_ocean_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land_ocean_label_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_land_ocean_seams.zip: 10m_physical/ne_10m_land_ocean_seams.shp 10m_physical/ne_10m_land_ocean_seams.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land_ocean_seams$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_minor_islands_label_points.zip: 10m_physical/ne_10m_minor_islands_label_points.shp 10m_physical/ne_10m_minor_islands_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_minor_islands_label_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/10m_physical/ne_10m_physical_building_blocks_all.zip: \
	zips/10m_physical/ne_10m_minor_islands_label_points.zip \
	zips/10m_physical/ne_10m_land_ocean_seams.zip \
	zips/10m_physical/ne_10m_land_ocean_label_points.zip \
	zips/10m_physical/ne_10m_wgs84_bounding_box.zip \
	zips/10m_physical/ne_10m_minor_islands_coastline.zip \
	zips/10m_physical/ne_10m_coastline.zip
		
	zip -j -r $@ 10m_physical/ne_10m_minor_islands_label_points.* 10m_physical/ne_10m_land_ocean_seams.* 10m_physical/ne_10m_land_ocean_label_points.* 10m_physical/ne_10m_wgs84_bounding_box.* 10m_physical/ne_10m_minor_islands_coastline.* 10m_physical/ne_10m_coastline.*
	cp $@ archive/ne_10m_physical_building_blocks_all$(VERSION_PREFIXED).zip


# 50m cultural
	
zips/50m_cultural/ne_50m_admin_0_boundary_lines_land.zip: 50m_cultural/ne_50m_admin_0_boundary_lines_land.shp 50m_cultural/ne_50m_admin_0_boundary_lines_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_lines_land$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_boundary_map_units.zip: 50m_cultural/ne_50m_admin_0_boundary_map_units.shp 50m_cultural/ne_50m_admin_0_boundary_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_map_units$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_pacific_groupings.zip: 50m_cultural/ne_50m_admin_0_pacific_groupings.shp 50m_cultural/ne_50m_admin_0_pacific_groupings.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_pacific_groupings$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.zip: 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.shp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_lines_maritime_indicator$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_countries.zip: 50m_cultural/ne_50m_admin_0_countries.shp 50m_cultural/ne_50m_admin_0_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_countries$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_countries_lakes.zip: 50m_cultural/ne_50m_admin_0_countries_lakes.shp 50m_cultural/ne_50m_admin_0_countries_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_countries_lakes$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_map_subunits.zip: 50m_cultural/ne_50m_admin_0_map_subunits.shp 50m_cultural/ne_50m_admin_0_map_subunits.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_map_subunits$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_map_units.zip: 50m_cultural/ne_50m_admin_0_map_units.shp 50m_cultural/ne_50m_admin_0_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_map_units$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_scale_rank.zip: 50m_cultural/ne_50m_admin_0_scale_rank.shp 50m_cultural/ne_50m_admin_0_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_sovereignty.zip: 50m_cultural/ne_50m_admin_0_sovereignty.shp 50m_cultural/ne_50m_admin_0_sovereignty.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_sovereignty$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_tiny_countries.zip: 50m_cultural/ne_50m_admin_0_tiny_countries.shp 50m_cultural/ne_50m_admin_0_tiny_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_tiny_countries$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.zip: 50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.shp 50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_tiny_countries_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.zip: 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.shp 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_breakaway_disputed_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.zip: 50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.shp 50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_lines_disputed_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_1_states_provinces_shp.zip: 50m_cultural/ne_50m_admin_1_states_provinces_shp.shp 50m_cultural/ne_50m_admin_1_states_provinces_shp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_1_states_provinces_shp_scale_rank.zip: 50m_cultural/ne_50m_admin_1_states_provinces_shp_scale_rank.shp 50m_cultural/ne_50m_admin_1_states_provinces_shp_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_shp_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_1_states_provinces_lakes_shp.zip: 50m_cultural/ne_50m_admin_1_states_provinces_lakes_shp.shp 50m_cultural/ne_50m_admin_1_states_provinces_lakes_shp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_lakes_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_admin_1_states_provinces_lines.zip: 50m_cultural/ne_50m_admin_1_states_provinces_lines.shp 50m_cultural/ne_50m_admin_1_states_provinces_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_populated_places.zip: 50m_cultural/ne_50m_populated_places.shp 50m_cultural/ne_50m_populated_places.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_populated_places$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_populated_places_simple.zip: 50m_cultural/ne_50m_populated_places_simple.shp 50m_cultural/ne_50m_populated_places_simple.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_populated_places_simple$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_airports.zip: 50m_cultural/ne_50m_airports.shp 50m_cultural/ne_50m_airports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/airports-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_airports$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_cultural/ne_50m_ports.zip: 50m_cultural/ne_50m_ports.shp 50m_cultural/ne_50m_ports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/ports-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_ports$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/50m_cultural/ne_50m_urban_areas.zip: 50m_cultural/ne_50m_urban_areas.shp 50m_cultural/ne_50m_urban_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-urban-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_urban_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp


# 50m physical

zips/50m_physical/ne_50m_antarctic_ice_shelves_lines.zip: 50m_physical/ne_50m_antarctic_ice_shelves_lines.shp 50m_physical/ne_50m_antarctic_ice_shelves_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_antarctic_ice_shelves_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_antarctic_ice_shelves_polys.zip: 50m_physical/ne_50m_antarctic_ice_shelves_polys.shp 50m_physical/ne_50m_antarctic_ice_shelves_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_antarctic_ice_shelves_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_coastline.zip: 50m_physical/ne_50m_coastline.shp 50m_physical/ne_50m_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-coastline/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_coastline$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_geographic_lines.zip: 50m_physical/ne_50m_geographic_lines.shp 50m_physical/ne_50m_geographic_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-geographic-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geographic_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_geography_marine_polys.zip: 50m_physical/ne_50m_geography_marine_polys.shp 50m_physical/ne_50m_geography_marine_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_marine_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_geography_regions_elevation_points.zip: 50m_physical/ne_50m_geography_regions_elevation_points.shp 50m_physical/ne_50m_geography_regions_elevation_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_regions_elevation_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_geography_regions_points.zip: 50m_physical/ne_50m_geography_regions_points.shp 50m_physical/ne_50m_geography_regions_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_regions_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_geography_regions_polys.zip: 50m_physical/ne_50m_geography_regions_polys.shp 50m_physical/ne_50m_geography_regions_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_regions_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_glaciated_areas.zip: 50m_physical/ne_50m_glaciated_areas.shp 50m_physical/ne_50m_glaciated_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-glaciated-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_glaciated_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_lakes_historic.zip: 50m_physical/ne_50m_lakes_historic.shp 50m_physical/ne_50m_lakes_historic.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-lakes-reservoirs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_lakes_historic$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_lakes.zip: 50m_physical/ne_50m_lakes.shp 50m_physical/ne_50m_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-lakes-reservoirs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_lakes$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_land.zip: 50m_physical/ne_50m_land.shp 50m_physical/ne_50m_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_land$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_ocean.zip: 50m_physical/ne_50m_ocean.shp 50m_physical/ne_50m_ocean.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_ocean$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_playas.zip: 50m_physical/ne_50m_playas.shp 50m_physical/ne_50m_playas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-playas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_playas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.zip: 50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.shp 50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_rivers_lake_centerlines_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_rivers_lake_centerlines.zip: 50m_physical/ne_50m_rivers_lake_centerlines.shp 50m_physical/ne_50m_rivers_lake_centerlines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_rivers_lake_centerlines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/50m_physical/ne_50m_graticules_all.zip: \
	zips/50m_physical/ne_50m_graticules_1.zip \
	zips/50m_physical/ne_50m_graticules_5.zip \
	zips/50m_physical/ne_50m_graticules_10.zip \
	zips/50m_physical/ne_50m_graticules_15.zip \
	zips/50m_physical/ne_50m_graticules_20.zip \
	zips/50m_physical/ne_50m_graticules_30.zip \
	zips/50m_physical/ne_50m_wgs84_bounding_box.zip
	
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/*.*
	cp $@ archive/ne_50m_graticules_all$(VERSION_PREFIXED).zip

zips/50m_physical/ne_50m_graticules_1.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_1.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_1.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_1.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_1.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_1.*
	cp $@ archive/ne_50m_graticules_1$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp

zips/50m_physical/ne_50m_graticules_5.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.*
	cp $@ archive/ne_50m_graticules_5$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp

zips/50m_physical/ne_50m_graticules_10.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.*
	cp $@ archive/ne_50m_graticules_10$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp

zips/50m_physical/ne_50m_graticules_15.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.*
	cp $@ archive/ne_50m_graticules_15$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp

zips/50m_physical/ne_50m_graticules_20.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.*
	cp $@ archive/ne_50m_graticules_20$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp

zips/50m_physical/ne_50m_graticules_30.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.*
	cp $@ archive/ne_50m_graticules_30$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp

zips/50m_physical/ne_50m_wgs84_bounding_box.zip: 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.shp 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.*
	cp $@ archive/ne_50m_wgs84_bounding_box$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp


# 110m cultural

zips/110m_cultural/ne_110m_admin_0_countries.zip: 110m_cultural/ne_110m_admin_0_countries.shp 110m_cultural/ne_110m_admin_0_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_countries$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_countries_lakes.zip: 110m_cultural/ne_110m_admin_0_countries_lakes.shp 110m_cultural/ne_110m_admin_0_countries_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_countries_lakes$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_boundary_lines_land.zip: 110m_cultural/ne_110m_admin_0_boundary_lines_land.shp 110m_cultural/ne_110m_admin_0_boundary_lines_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_boundary_lines_land$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_pacific_groupings.zip: 110m_cultural/ne_110m_admin_0_pacific_groupings.shp 110m_cultural/ne_110m_admin_0_pacific_groupings.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_pacific_groupings$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_map_units.zip: 110m_cultural/ne_110m_admin_0_map_units.shp 110m_cultural/ne_110m_admin_0_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_map_units$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_scale_rank.zip: 110m_cultural/ne_110m_admin_0_scale_rank.shp 110m_cultural/ne_110m_admin_0_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_sovereignty.zip: 110m_cultural/ne_110m_admin_0_sovereignty.shp 110m_cultural/ne_110m_admin_0_sovereignty.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_sovereignty$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_0_tiny_countries.zip: 110m_cultural/ne_110m_admin_0_tiny_countries.shp 110m_cultural/ne_110m_admin_0_tiny_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_tiny_countries$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_1_states_provinces_shp.zip: 110m_cultural/ne_110m_admin_1_states_provinces_shp.shp 110m_cultural/ne_110m_admin_1_states_provinces_shp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_1_states_provinces_lakes_shp.zip: 110m_cultural/ne_110m_admin_1_states_provinces_lakes_shp.shp 110m_cultural/ne_110m_admin_1_states_provinces_lakes_shp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_lakes_shp$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_1_states_provinces_shp_scale_rank.zip: 110m_cultural/ne_110m_admin_1_states_provinces_shp_scale_rank.shp 110m_cultural/ne_110m_admin_1_states_provinces_shp_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_shp_scale_rank$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_admin_1_states_provinces_lines.zip: 110m_cultural/ne_110m_admin_1_states_provinces_lines.shp 110m_cultural/ne_110m_admin_1_states_provinces_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_populated_places.zip: 110m_cultural/ne_110m_populated_places.shp 110m_cultural/ne_110m_populated_places.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_populated_places$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
zips/110m_cultural/ne_110m_populated_places_simple.zip: 110m_cultural/ne_110m_populated_places_simple.shp 110m_cultural/ne_110m_populated_places_simple.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_populated_places_simple$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp
	
	
# 110m physical

zips/110m_physical/ne_110m_coastline.zip: 110m_physical/ne_110m_coastline.shp 110m_physical/ne_110m_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-coastline/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_coastline$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_geographic_lines.zip: 110m_physical/ne_110m_geographic_lines.shp 110m_physical/ne_110m_geographic_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-geographic-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geographic_lines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_geography_marine_polys.zip: 110m_physical/ne_110m_geography_marine_polys.shp 110m_physical/ne_110m_geography_marine_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_marine_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_geography_regions_elevation_points.zip: 110m_physical/ne_110m_geography_regions_elevation_points.shp 110m_physical/ne_110m_geography_regions_elevation_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_regions_elevation_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_geography_regions_points.zip: 110m_physical/ne_110m_geography_regions_points.shp 110m_physical/ne_110m_geography_regions_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_regions_points$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_geography_regions_polys.zip: 110m_physical/ne_110m_geography_regions_polys.shp 110m_physical/ne_110m_geography_regions_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_regions_polys$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_glaciated_areas.zip: 110m_physical/ne_110m_glaciated_areas.shp 110m_physical/ne_110m_glaciated_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-glaciated-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_glaciated_areas$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_lakes.zip: 110m_physical/ne_110m_lakes.shp 110m_physical/ne_110m_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110mlakes-reservoirs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_lakes$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_land.zip: 110m_physical/ne_110m_land.shp 110m_physical/ne_110m_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_land$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_ocean.zip: 110m_physical/ne_110m_ocean.shp 110m_physical/ne_110m_ocean.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_ocean$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_rivers_lake_centerlines.zip: 110m_physical/ne_110m_rivers_lake_centerlines.shp 110m_physical/ne_110m_rivers_lake_centerlines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_rivers_lake_centerlines$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson $(subst zips/, ,$(basename $@)).shp

zips/110m_physical/ne_110m_graticules_all.zip: \
	zips/110m_physical/ne_110m_graticules_1.zip \
	zips/110m_physical/ne_110m_graticules_5.zip \
	zips/110m_physical/ne_110m_graticules_10.zip \
	zips/110m_physical/ne_110m_graticules_15.zip \
	zips/110m_physical/ne_110m_graticules_20.zip \
	zips/110m_physical/ne_110m_graticules_30.zip \
	zips/110m_physical/ne_110m_wgs84_bounding_box.zip
	
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/*.*
	cp $@ archive/ne_110m_graticules_all$(VERSION_PREFIXED).zip

zips/110m_physical/ne_110m_graticules_1.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_1.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_1.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_1.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_1.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_1.*
	cp $@ archive/ne_110m_graticules_1$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp

zips/110m_physical/ne_110m_graticules_5.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.*
	cp $@ archive/ne_110m_graticules_5$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp

zips/110m_physical/ne_110m_graticules_10.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.*
	cp $@ archive/ne_110m_graticules_10$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp

zips/110m_physical/ne_110m_graticules_15.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.*
	cp $@ archive/ne_110m_graticules_15$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp

zips/110m_physical/ne_110m_graticules_20.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.*
	cp $@ archive/ne_110m_graticules_20$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp

zips/110m_physical/ne_110m_graticules_30.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.*
	cp $@ archive/ne_110m_graticules_30$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp

zips/110m_physical/ne_110m_wgs84_bounding_box.zip: 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.shp 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.*
	cp $@ archive/ne_110m_wgs84_bounding_box$(VERSION_PREFIXED).zip
	rm -f geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson
	ogr2ogr -overwrite -f GeoJSON -lco WINDOWS-1252 geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp


# PACKAGES
	
# copy the master assets into position for 10m_cultural: 
packages/Natural_Earth_quick_start/10m_cultural/status.txt: \
	10m_cultural/ne_10m_admin_1_states_provinces_geodb.gdb/gdb \
	10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.dbf \
	10m_cultural/ne_10m_admin_0_boundary_lines_land.shp 10m_cultural/ne_10m_admin_0_boundary_lines_land.dbf \
	10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.shp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.dbf \
	10m_cultural/ne_10m_admin_0_disputed_areas.shp 10m_cultural/ne_10m_admin_0_disputed_areas.dbf \
	10m_cultural/ne_10m_admin_0_map_subunits.shp 10m_cultural/ne_10m_admin_0_map_subunits.dbf \
	10m_cultural/ne_10m_admin_0_map_units.shp 10m_cultural/ne_10m_admin_0_map_units.dbf \
	10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.dbf \
	10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.shp 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.dbf \
	10m_cultural/ne_10m_admin_1_states_provinces_shp.shp 10m_cultural/ne_10m_admin_1_states_provinces_shp.dbf \
	10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf \
	10m_cultural/ne_10m_urban_areas.shp 10m_cultural/ne_10m_urban_areas.dbf

	mkdir -p packages/Natural_Earth_quick_start/10m_cultural
	mkdir -p packages/Natural_Earth_quick_start/10m_cultural/ne_10m_admin_1_states_provinces_geodb.gdb/
	
	cp -r 10m_cultural/ne_10m_admin_1_states_provinces_geodb.gdb/* packages/Natural_Earth_quick_start/10m_cultural/ne_10m_admin_1_states_provinces_geodb.gdb/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_land.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_disputed_areas.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_map_subunits.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_map_units.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_1_states_provinces_lines_shp.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_1_states_provinces_shp.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_populated_places.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_urban_areas.* packages/Natural_Earth_quick_start/10m_cultural/
	
	touch $@
	
# copy the master assets into position for 10m_physical: 	
packages/Natural_Earth_quick_start/10m_physical/status.txt: \
	10m_physical/ne_10m_coastline.shp 10m_physical/ne_10m_coastline.dbf \
	10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf \
	10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf \
	10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf \
	10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf \
	10m_physical/ne_10m_lakes.shp 10m_physical/ne_10m_lakes.dbf \
	10m_physical/ne_10m_minor_islands.shp 10m_physical/ne_10m_minor_islands.dbf \
	10m_physical/ne_10m_ocean.shp 10m_physical/ne_10m_ocean.dbf \
	10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.dbf \
	10m_physical/ne_10m_rivers_lake_centerlines.shp 10m_physical/ne_10m_rivers_lake_centerlines.dbf
	
	mkdir -p packages/Natural_Earth_quick_start/10m_physical

	cp 10m_physical/ne_10m_coastline.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_marine_polys.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_regions_elevation_points.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_regions_points.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_regions_polys.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_lakes.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_minor_islands.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_ocean.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_lake_centerlines.* packages/Natural_Earth_quick_start/10m_physical/
	
	touch $@
	
# TODO: get the raster from the other repo, which doesn't exist now.
packages/Natural_Earth_quick_start/50m_raster/status.txt:

	mkdir -p packages/Natural_Earth_quick_start/50m_raster
	rm -rf packages/Natural_Earth_quick_start/50m_raster/*
	curl -o packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip -L http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/raster/NE1_50M_SR_W.zip
	unzip packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip -d packages/Natural_Earth_quick_start/50m_raster/
	rm -f packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip
	
	touch $@
	
# copy the master assets into position for 110m_cultural:
packages/Natural_Earth_quick_start/110m_cultural/status.txt: \
	110m_cultural/ne_110m_admin_0_boundary_lines_land.shp 110m_cultural/ne_110m_admin_0_boundary_lines_land.dbf \
	110m_cultural/ne_110m_admin_0_countries.shp 110m_cultural/ne_110m_admin_0_countries.dbf \
	110m_cultural/ne_110m_admin_0_pacific_groupings.shp 110m_cultural/ne_110m_admin_0_pacific_groupings.dbf \
	110m_cultural/ne_110m_admin_0_tiny_countries.shp 110m_cultural/ne_110m_admin_0_tiny_countries.dbf \
	110m_cultural/ne_110m_admin_1_states_provinces_shp.shp 110m_cultural/ne_110m_admin_1_states_provinces_shp.dbf \
	110m_cultural/ne_110m_populated_places.shp 110m_cultural/ne_110m_populated_places.dbf

	mkdir -p packages/Natural_Earth_quick_start/110m_cultural

	cp 110m_cultural/ne_110m_admin_0_boundary_lines_land.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_0_countries.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_0_pacific_groupings.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_0_tiny_countries.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_1_states_provinces_shp.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_populated_places.* packages/Natural_Earth_quick_start/110m_cultural/
	
	touch $@
	
# copy the master assets into position for 110m_physical: 	
packages/Natural_Earth_quick_start/110m_physical/status.txt: \
	110m_physical/ne_110m_coastline.shp 110m_physical/ne_110m_coastline.dbf \
	110m_physical/ne_110m_geography_marine_polys.shp 110m_physical/ne_110m_geography_marine_polys.dbf \
	110m_physical/ne_110m_geography_regions_points.shp 110m_physical/ne_110m_geography_regions_points.dbf \
	110m_physical/ne_110m_geography_regions_polys.shp 110m_physical/ne_110m_geography_regions_polys.dbf \
	110m_physical/ne_110m_lakes.shp 110m_physical/ne_110m_lakes.dbf \
	110m_physical/ne_110m_ocean.shp 110m_physical/ne_110m_ocean.dbf
		
	mkdir -p packages/Natural_Earth_quick_start/110m_physical

	cp 110m_physical/ne_110m_coastline.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_geography_marine_polys.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_geography_regions_points.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_geography_regions_polys.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_lakes.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_ocean.* packages/Natural_Earth_quick_start/110m_physical/
	
	touch $@
	
zips/updates/natural_earth_update_1.1.0.zip:
	zip -r $@ updates/version_1d1/

zips/updates/natural_earth_update_1.1.3.zip:
	zip -r $@ updates/version_1d1d3/

zips/updates/natural_earth_update_1.2.0.zip:
	zip -r $@ updates/version_1d2/

zips/updates/natural_earth_update_1.3.0.zip:
	zip -r $@ updates/version_1d3/
		
zips/updates/natural_earth_update_1.4.0.zip:
	zip -r $@ updates/version_1d4/

zips/updates/natural_earth_update_2.0.0.zip:
	zip -r $@ updates/version_2d0/

zips/live-packages_ne: \
	zips/packages/natural_earth_vector.zip \
	zips/packages/natural_earth_vector.sqlite.zip \
	zips/packages/Natural_Earth_quick_start.zip
	
	rsync -Cru --progress zips/packages/ $(DOCROOT_NE)/packages/
	touch $@
	
zips/live-10m_cultural_ne: zips/10m_cultural/10m_cultural.zip
	rsync -Cru --progress zips/10m_cultural/ $(DOCROOT_NE)/10m/cultural/
	touch $@

zips/live-10m_physical_ne: zips/10m_physical/10m_physical.zip
	rsync -Cru --progress zips/10m_physical/ $(DOCROOT_NE)/10m/physical/
	touch $@

zips/live-50m_cultural_ne: zips/50m_cultural/50m_cultural.zip
	rsync -Cru --progress zips/50m_cultural/ $(DOCROOT_NE)/50m/cultural/
	touch $@

zips/live-50m_physical_ne: zips/50m_physical/50m_physical.zip
	rsync -Cru --progress zips/50m_physical/ $(DOCROOT_NE)/50m/physical/
	touch $@

zips/live-110m_cultural_ne: zips/110m_cultural/110m_cultural.zip
	rsync -Cru --progress zips/110m_cultural/ $(DOCROOT_NE)/110m/cultural/
	touch $@

zips/live-110m_physical_ne: zips/110m_physical/110m_physical.zip
	rsync -Cru --progress zips/110m_physical/ $(DOCROOT_NE)/110m/physical/
	touch $@

zips/updates_ne: zips/updates/natural_earth_update_$(VERSION).zip
	rsync -Cru --progress zips/updates/ $(DOCROOT_NE)/updates/
	touch $@


zips/live-packages_freac: \
	zips/packages/natural_earth_vector.zip \
	zips/packages/natural_earth_vector.sqlite.zip \
	zips/packages/Natural_Earth_quick_start.zip
	
	rsync -Cru --progress zips/packages/ $(DOCROOT_FREAC)/packages/
	touch $@
	
zips/live-10m_cultural_freac: zips/10m_cultural/10m_cultural.zip
	rsync -Cru --progress zips/10m_cultural/ $(DOCROOT_FREAC)/10m/cultural/
	touch $@

zips/live-10m_physical_freac: zips/10m_physical/10m_physical.zip
	rsync -Cru --progress zips/10m_physical/ $(DOCROOT_FREAC)/10m/physical/
	touch $@

zips/live-50m_cultural_freac: zips/50m_cultural/50m_cultural.zip
	rsync -Cru --progress zips/50m_cultural/ $(DOCROOT_FREAC)/50m/cultural/
	touch $@

zips/live-50m_physical_freac: zips/50m_physical/50m_physical.zip
	rsync -Cru --progress zips/50m_physical/ $(DOCROOT_FREAC)/50m/physical/
	touch $@

zips/live-110m_cultural_freac: zips/110m_cultural/110m_cultural.zip
	rsync -Cru --progress zips/110m_cultural/ $(DOCROOT_FREAC)/110m/cultural/
	touch $@

zips/live-110m_physical_freac: zips/110m_physical/110m_physical.zip
	rsync -Cru --progress zips/110m_physical/ $(DOCROOT_FREAC)/110m/physical/
	touch $@

zips/updates_freac: zips/updates/natural_earth_update_$(VERSION).zip
	rsync -Cru --progress zips/updates/ $(DOCROOT_FREAC)/updates/
	touch $@

zips/housekeeping_freac: zips/updates/natural_earth_update_$(VERSION).zip
	rsync -Cru --progress zips/housekeeping/ $(DOCROOT_FREAC)/housekeeping/
	touch $@



downloads:
	# DOWNLOADS copy
	#special items:
	cp updates/natural_earth_update_$(VERSION).zip downloads/
	# packages
	rsync -Cru --progress zips/packages/ downloads/
	# etc for each theme
	rsync -Cru --progress zips/10m_cultural/ downloads/
	rsync -Cru --progress zips/10m_physical/ downloads/
	rsync -Cru --progress zips/50m_cultural/ downloads/
	rsync -Cru --progress zips/50m_physical/ downloads/
	rsync -Cru --progress zips/110m_cultural/ downloads/
	rsync -Cru --progress zips/110m_physical/ downloads/

	touch $@
	

live: \
	zips/packages/natural_earth_vector.zip \
	zips/packages/Natural_Earth_quick_start.zip\
	zips/updates/natural_earth_update_$(VERSION).zip \
	zips/live-packages_ne \
	zips/updates_ne \
	zips/live-10m_cultural_ne \
	zips/live-10m_physical_ne \
	zips/live-50m_cultural_ne \
	zips/live-50m_physical_ne \
	zips/live-110m_cultural_ne \
	zips/live-110m_physical_ne \
	zips/live-packages_freac \
	zips/updates_freac \
	zips/live-10m_cultural_freac \
	zips/live-10m_physical_freac \
	zips/live-50m_cultural_freac \
	zips/live-50m_physical_freac \
	zips/live-110m_cultural_freac \
	zips/live-110m_physical_freac
	
	touch $@

clean-quick-start:
	rm -rf packages/Natural_Earth_quick_start/10m_cultural/*
	rm -rf packages/Natural_Earth_quick_start/10m_physical/*
	rm -rf packages/Natural_Earth_quick_start/50m_raster/*
	rm -rf packages/Natural_Earth_quick_start/110m_cultural/*
	rm -rf packages/Natural_Earth_quick_start/110m_physical/*
	
clean-lite:
	rm -f zips/packages/natural_earth_vector.zip
	rm -f zips/10m_cultural/10m_cultural.zip
	rm -f zips/10m_physical/10m_physical.zip
	rm -f zips/50m_cultural/50m_cultural.zip
	rm -f zips/50m_physical/50m_physical.zip
	rm -f zips/110m_cultural/110m_cultural.zip
	rm -f zips/110m_physical/110m_physical.zip
	rm -f zips/packages/natural_earth_vector.sqlite.zip

clean:
	mkdir -p zips/10m_cultural
	mkdir -p zips/10m_physical
	mkdir -p zips/50m_cultural
	mkdir -p zips/50m_physical
	mkdir -p zips/110m_cultural
	mkdir -p zips/110m_physical
	mkdir -p zips/packages/
	mkdir -p zips/updates/
	mkdir -p archive
	mkdir -p geojson
	rm -rf zips/10m_cultural/*
	rm -rf zips/10m_physical/*
	rm -rf zips/50m_cultural/*
	rm -rf zips/50m_physical/*
	rm -rf zips/110m_cultural/*
	rm -rf zips/110m_physical/*
	#rm -rf zips/packages/*