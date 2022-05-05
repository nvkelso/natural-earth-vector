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
	zips/packages/Natural_Earth_quick_start.zip \
	zips/packages/natural_earth_vector.sqlite.zip \
	zips/packages/natural_earth_vector.gpkg.zip
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
	zips/housekeeping/ne_admin_0_details.zip

	zip -r $@ 10m_cultural 10m_physical 50m_cultural 50m_physical 110m_cultural 110m_physical housekeeping tools VERSION README.md CHANGELOG
	#Bake off a version'd iteration of that file, too
	cp $@ archive/natural_earth_vector_$(VERSION).zip


zips/packages/natural_earth_vector.sqlite.zip: \
	zips/10m_cultural/10m_cultural.zip \
	zips/10m_physical/10m_physical.zip \
	zips/50m_cultural/50m_cultural.zip \
	zips/50m_physical/50m_physical.zip \
	zips/110m_cultural/110m_cultural.zip \
	zips/110m_physical/110m_physical.zip \
	housekeeping/ne_admin_0_details.ods

	#SQL-Lite
	rm -f packages/natural_earth_vector.sqlite
	for shp in 10m_cultural/*.shp 10m_physical/*.shp 50m_cultural/*.shp 50m_physical/*.shp 110m_cultural/*.shp 110m_physical/*.shp; \
	do \
		ogr2ogr -f SQLite -append packages/natural_earth_vector.sqlite $$shp; \
	done
	zip $@ packages/natural_earth_vector.sqlite VERSION README.md CHANGELOG

	cp $@ archive/natural_earth_vector.sqlite_$(VERSION).zip

zips/packages/natural_earth_vector.gpkg.zip: \
	zips/10m_cultural/10m_cultural.zip \
	zips/10m_physical/10m_physical.zip \
	zips/50m_cultural/50m_cultural.zip \
	zips/50m_physical/50m_physical.zip \
	zips/110m_cultural/110m_cultural.zip \
	zips/110m_physical/110m_physical.zip \
	housekeeping/ne_admin_0_details.ods

	#GeoPackage
	rm -f packages/natural_earth_vector.gpkg
	for shp in 10m_cultural/*.shp 10m_physical/*.shp 50m_cultural/*.shp 50m_physical/*.shp 110m_cultural/*.shp 110m_physical/*.shp; \
	do \
		ogr2ogr -f GPKG -append packages/natural_earth_vector.gpkg $$shp; \
	done
	zip $@ packages/natural_earth_vector.gpkg VERSION README.md CHANGELOG

	cp $@ archive/natural_earth_vector.gpkg_$(VERSION).zip


zips/packages/Natural_Earth_quick_start.zip: \
	packages/Natural_Earth_quick_start/10m_cultural/status.txt \
	packages/Natural_Earth_quick_start/10m_physical/status.txt \
	packages/Natural_Earth_quick_start/50m_raster/status.txt \
	packages/Natural_Earth_quick_start/50m_cultural/status.txt \
	packages/Natural_Earth_quick_start/50m_physical/status.txt \
	packages/Natural_Earth_quick_start/110m_cultural/status.txt \
	packages/Natural_Earth_quick_start/110m_physical/status.txt \
	packages/Natural_Earth_quick_start/Natural_Earth_quick_start_for_ArcMap.mxd \
	packages/Natural_Earth_quick_start/Natural_Earth_quick_start_for_QGIS.qgs \
	CHANGELOG README.md VERSION

	cp CHANGELOG packages/Natural_Earth_quick_start/CHANGELOG
	cp README.md packages/Natural_Earth_quick_start/README.md
	cp VERSION packages/Natural_Earth_quick_start/VERSION

	rm -f $@
	zip -r $@ packages/Natural_Earth_quick_start/
	cp $@ archive/Natural_Earth_quick_start_$(VERSION).zip


zips/housekeeping: \
	zips/housekeeping/ne_admin_0_details.zip \
	zips/housekeeping/ne_admin_0_full_attributes.zip \
	zips/housekeeping/ne_themes_versions.zip \

	touch $@


zips/housekeeping/ne_admin_0_details.zip: housekeeping/ne_admin_0_details.ods \
	housekeeping/ne_admin_0_details_iso_countries.dbf \
	housekeeping/ne_admin_0_details_level_1_sov.dbf \
	housekeeping/ne_admin_0_details_level_2_countries.dbf \
	housekeeping/ne_admin_0_details_level_3_map_units.dbf \
	housekeeping/ne_admin_0_details_level_4_subunits.dbf \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf \
	housekeeping/ne_admin_0_details_top_level_countries.dbf
	zip -r $@ housekeeping/ne_admin_0_details.ods VERSION README.md CHANGELOG housekeeping/ne_admin_0_details_*.dbf

zips/housekeeping/ne_admin_0_full_attributes.zip:
	zip -r $@ housekeeping/ne_admin_0_full_attributes.ods VERSION README.md CHANGELOG

zips/housekeeping/ne_themes_versions.zip:
	zip -r $@ housekeeping/ne_themes_versions.ods VERSION README.md CHANGELOG



# PER THEME, BY SCALESET

# SCALESET ZIPS by zoom and physical, cultural (6 total)

zips/10m_cultural/10m_cultural.zip: \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.zip \
	zips/10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.zip \
	zips/10m_cultural/ne_10m_admin_0_disputed_areas.zip \
	zips/10m_cultural/ne_10m_admin_0_countries.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_arg.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_bdg.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_bra.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_chn.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_deu.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_egy.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_esp.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_fra.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_gbr.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_grc.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_idn.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_ind.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_isr.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_iso.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_ita.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_jpn.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_kor.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_mar.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_nep.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_nld.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_pak.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_pol.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_prt.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_pse.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_rus.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_sau.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_swe.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_tlc.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_tur.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_twn.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_ukr.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_usa.zip \
	zips/10m_cultural/ne_10m_admin_0_countries_vnm.zip \
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
	zips/10m_cultural/ne_10m_admin_1_states_provinces.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes.zip \
	zips/10m_cultural/ne_10m_admin_1_states_provinces_lines.zip \
	zips/10m_cultural/ne_10m_admin_1_label_points.zip \
	zips/10m_cultural/ne_10m_admin_1_seams.zip \
	zips/10m_cultural/ne_10m_admin_2_counties.zip \
	zips/10m_cultural/ne_10m_admin_2_counties_lakes.zip \
	zips/10m_cultural/ne_10m_admin_2_counties_scale_rank.zip \
	zips/10m_cultural/ne_10m_admin_2_counties_scale_rank_minor_islands.zip \
	zips/10m_cultural/ne_10m_admin_2_label_points_details.zip \
	zips/10m_cultural/ne_10m_admin_2_label_points.zip \
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
	zips/10m_physical/ne_10m_lakes_australia.zip \
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
	zips/10m_physical/ne_10m_rivers_australia.zip \
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
	zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.zip \
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
	zips/50m_cultural/ne_50m_admin_1_states_provinces.zip \
	zips/50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.zip \
	zips/50m_cultural/ne_50m_admin_1_states_provinces_lakes.zip \
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
	zips/110m_cultural/ne_110m_admin_1_states_provinces.zip \
	zips/110m_cultural/ne_110m_admin_1_states_provinces_lakes.zip \
	zips/110m_cultural/ne_110m_admin_1_states_provinces_scale_rank.zip \
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

derived_themes: derived_populated_places \
	110m_cultural/ne_110m_admin_0_tiny_countries.shp \
	50m_cultural/ne_50m_airports.shp \
	50m_cultural/ne_50m_ports.shp \
	derived_physical_labels

mapshaper: build_a1_ne_10m_admin_0_scale_rank \
	build_a2_ne_10m_admin_0_disputed \
	build_a3_ne_10m_admin_0_subunits \
	build_a4_ne_10m_admin_0_units \
	build_a5_ne_10m_admin_0_countries \
	build_a5_ne_10m_admin_0_countries_pov \
	build_a6_ne_10m_admin_0_sov \
	build_a7_ne_10m_admin_1_all \
	build_a8_ne_10m_admin_2_all \
	build_a8_ne_10m_physical_land_ocean \
	build_a8_ne_10m_physical_ocean \
	build_a8_ne_10m_physical_land \
	build_b0_ne_50m_admin_0_disputed \
	build_b1_ne_50m_admin_0_subunits \
	build_b2_ne_50m_admin_0_units \
	build_b3_ne_50m_admin_0_countries \
	build_b4_ne_50m_admin_0_sov \
	build_b5_ne_50m_admin_0_tiny_countries \
	build_b6_ne_50m_admin_1_all \
	build_c1_ne_110m_admin_0_units \
	build_c2_ne_110m_admin_0_countries \
	build_c3_ne_110m_admin_0_sov \
	build_c4_ne_110m_admin_1

build_a5_ne_10m_admin_0_countries_pov: \
	build_a5_ne_10m_admin_0_countries_arg \
	build_a5_ne_10m_admin_0_countries_bdg \
	build_a5_ne_10m_admin_0_countries_bra \
	build_a5_ne_10m_admin_0_countries_chn \
	build_a5_ne_10m_admin_0_countries_deu \
	build_a5_ne_10m_admin_0_countries_egy \
	build_a5_ne_10m_admin_0_countries_esp \
	build_a5_ne_10m_admin_0_countries_fra \
	build_a5_ne_10m_admin_0_countries_gbr \
	build_a5_ne_10m_admin_0_countries_grc \
	build_a5_ne_10m_admin_0_countries_idn \
	build_a5_ne_10m_admin_0_countries_ind \
	build_a5_ne_10m_admin_0_countries_isr \
	build_a5_ne_10m_admin_0_countries_iso \
	build_a5_ne_10m_admin_0_countries_ita \
	build_a5_ne_10m_admin_0_countries_jpn \
	build_a5_ne_10m_admin_0_countries_kor \
	build_a5_ne_10m_admin_0_countries_mar \
	build_a5_ne_10m_admin_0_countries_nep \
	build_a5_ne_10m_admin_0_countries_nld \
	build_a5_ne_10m_admin_0_countries_pak \
	build_a5_ne_10m_admin_0_countries_pol \
	build_a5_ne_10m_admin_0_countries_prt \
	build_a5_ne_10m_admin_0_countries_pse \
	build_a5_ne_10m_admin_0_countries_rus \
	build_a5_ne_10m_admin_0_countries_sau \
	build_a5_ne_10m_admin_0_countries_swe \
	build_a5_ne_10m_admin_0_countries_tlc \
	build_a5_ne_10m_admin_0_countries_tur \
	build_a5_ne_10m_admin_0_countries_twn \
	build_a5_ne_10m_admin_0_countries_ukr \
	build_a5_ne_10m_admin_0_countries_usa \
	build_a5_ne_10m_admin_0_countries_vnm
#	build_a5_ne_10m_admin_0_countries_irn \

build_a8_ne_10m_physical_land_ocean: 10m_physical/ne_10m_coastline.shp \
	10m_physical/ne_10m_minor_islands_coastline.shp \
	10m_physical/ne_10m_land_ocean_seams.shp \
	10m_physical/ne_10m_land_ocean_label_points.shp
	mkdir -p intermediate
	mapshaper -i combine-files snap \
		10m_physical/ne_10m_coastline.shp \
		10m_physical/ne_10m_minor_islands_coastline.shp \
		10m_physical/ne_10m_land_ocean_seams.shp \
		-filter-fields \
		-merge-layers \
		-polygons gap-tolerance=1e-6 \
		-join 10m_physical/ne_10m_land_ocean_label_points.shp \
		-o intermediate/ne_10m_physical_building_blocks.shp \

build_a8_ne_10m_physical_ocean: intermediate/ne_10m_physical_building_blocks.shp
	mapshaper -i intermediate/ne_10m_physical_building_blocks.shp \
		-filter 'featurecla !== null' + \
		-filter 'featurecla == "Ocean"' + \
		-o 10m_physical/ne_10m_ocean_scale_rank.shp \
		-dissolve featurecla,min_zoom copy-fields=featurecla,scalerank,min_zoom \
		-o 10m_physical/ne_10m_ocean.shp \

build_a8_ne_10m_physical_land: intermediate/ne_10m_physical_building_blocks.shp
	mapshaper -i intermediate/ne_10m_physical_building_blocks.shp \
		-filter 'featurecla !== null' + \
		-filter '"Land,Null island".indexOf(featurecla) > -1' \
		-o 10m_physical/ne_10m_land_scale_rank.shp \
		-dissolve featurecla,min_zoom copy-fields=featurecla,scalerank,min_zoom \
		-o 10m_physical/ne_10m_land.shp

build_a1_ne_10m_admin_0_scale_rank: 10m_cultural/ne_10m_admin_0_boundary_lines_land.shp \
	10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp \
	10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp \
	10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.shp \
	10m_cultural/ne_10m_admin_0_seams.shp \
	10m_physical/ne_10m_coastline.shp \
	10m_physical/ne_10m_minor_islands_coastline.shp \
	10m_cultural/ne_10m_admin_0_label_points.shp
	mapshaper -i combine-files snap \
		10m_cultural/ne_10m_admin_0_boundary_lines_land.shp \
		10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp \
		10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp \
		10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.shp \
		10m_cultural/ne_10m_admin_0_seams.shp \
		10m_physical/ne_10m_coastline.shp \
		10m_physical/ne_10m_minor_islands_coastline.shp \
		-filter-fields \
		-merge-layers \
		-polygons gap-tolerance=1e-6 \
		-join 10m_cultural/ne_10m_admin_0_label_points.shp \
		-o 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-o 10m_cultural/ne_10m_admin_0_scale_rank.shp \
#calc='join_count = count()'

build_a5_ne_10m_admin_0_countries_usa: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_US \
		-dissolve 'ADM0_A3_US' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_US,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_usa.shp \

build_a5_ne_10m_admin_0_countries_ukr: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_UA \
		-dissolve 'ADM0_A3_UA' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_UA,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_ukr.shp \

build_a5_ne_10m_admin_0_countries_fra: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_FR \
		-dissolve 'ADM0_A3_FR' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_FR,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_fra.shp \

build_a5_ne_10m_admin_0_countries_rus: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_RU \
		-dissolve 'ADM0_A3_RU' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_RU,ADM0_A3 fields=* \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_rus.shp \

build_a5_ne_10m_admin_0_countries_esp: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_ES \
		-dissolve 'ADM0_A3_ES' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_ES,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_esp.shp \

build_a5_ne_10m_admin_0_countries_chn: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_CN \
		-dissolve 'ADM0_A3_CN' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_CN,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_chn.shp \

build_a5_ne_10m_admin_0_countries_twn: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_TW \
		-dissolve 'ADM0_A3_TW' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_TW,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_twn.shp \

build_a5_ne_10m_admin_0_countries_ind: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_IN \
		-dissolve 'ADM0_A3_IN' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_IN,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_ind.shp \

build_a5_ne_10m_admin_0_countries_nep: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_NP \
		-dissolve 'ADM0_A3_NP' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_NP,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_nep.shp \

build_a5_ne_10m_admin_0_countries_pak: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_PK \
		-dissolve 'ADM0_A3_PK' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_PK,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_pak.shp \

build_a5_ne_10m_admin_0_countries_deu: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_DE \
		-dissolve 'ADM0_A3_DE' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_DE,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_deu.shp \

build_a5_ne_10m_admin_0_countries_gbr: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_GB \
		-dissolve 'ADM0_A3_GB' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_GB,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_gbr.shp \

build_a5_ne_10m_admin_0_countries_bra: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_BR \
		-dissolve 'ADM0_A3_BR' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_BR,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_bra.shp \

build_a5_ne_10m_admin_0_countries_isr: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_IL \
		-dissolve 'ADM0_A3_IL' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_IL,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_isr.shp \

build_a5_ne_10m_admin_0_countries_iso: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_iso_countries.dbf \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_ISO \
		-dissolve 'ADM0_ISO' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_iso_countries.dbf encoding=utf8 keys=ADM0_ISO,ADM0_ISO fields=* \
		-filter 'ADM0_ISO !== "-99"' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_iso.shp \

build_a5_ne_10m_admin_0_countries_pse: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_PS \
		-dissolve 'ADM0_A3_PS' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_PS,ADM0_A3 fields=* \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_pse.shp \

build_a5_ne_10m_admin_0_countries_sau: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_SA \
		-dissolve 'ADM0_A3_SA' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_SA,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_sau.shp \

build_a5_ne_10m_admin_0_countries_egy: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_EG \
		-dissolve 'ADM0_A3_EG' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_EG,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_egy.shp \

build_a5_ne_10m_admin_0_countries_mar: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_MA \
		-dissolve 'ADM0_A3_MA' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_MA,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_mar.shp \

build_a5_ne_10m_admin_0_countries_prt: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_PT \
		-dissolve 'ADM0_A3_PT' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_PT,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_prt.shp \

build_a5_ne_10m_admin_0_countries_arg: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_AR \
		-dissolve 'ADM0_A3_AR' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_AR,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_arg.shp \

build_a5_ne_10m_admin_0_countries_jpn: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_JP \
		-dissolve 'ADM0_A3_JP' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_JP,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_jpn.shp \

build_a5_ne_10m_admin_0_countries_kor: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_KO \
		-dissolve 'ADM0_A3_KO' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_KO,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_kor.shp \

build_a5_ne_10m_admin_0_countries_vnm: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_VN \
		-dissolve 'ADM0_A3_VN' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_VN,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_vnm.shp \

build_a5_ne_10m_admin_0_countries_tur: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_TR \
		-dissolve 'ADM0_A3_TR' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_TR,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_tur.shp \

build_a5_ne_10m_admin_0_countries_idn: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_ID \
		-dissolve 'ADM0_A3_ID' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_ID,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_idn.shp \

build_a5_ne_10m_admin_0_countries_pol: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_PL \
		-dissolve 'ADM0_A3_PL' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_PL,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_pol.shp \

build_a5_ne_10m_admin_0_countries_grc: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_GR \
		-dissolve 'ADM0_A3_GR' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_GR,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_grc.shp \

# build_a5_ne_10m_admin_0_countries_irn: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
# 	housekeeping/ne_admin_0_details_level_5_disputed.dbf
# 	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
# 		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_IR \
# 		-dissolve 'ADM0_A3_IR' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
# 		-filter 'scalerank !== null' + \
# 		-filter 'scalerank <= 6' + \
# 		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_IR,ADM0_A3 fields=* \
# 		-filter 'ADM0_A3 !== null' + \
# 		-each 'delete sr_adm0_a3' \
# 		-each 'NAME=BRK_NAME' \
# 		-each 'NAME_LONG=BRK_NAME' \
# 		-o 10m_cultural/ne_10m_admin_0_countries_irn.shp \

build_a5_ne_10m_admin_0_countries_ita: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_IT \
		-dissolve 'ADM0_A3_IT' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_IT,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_ita.shp \

build_a5_ne_10m_admin_0_countries_nld: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_NL \
		-dissolve 'ADM0_A3_NL' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_NL,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_nld.shp \

build_a5_ne_10m_admin_0_countries_swe: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_SE \
		-dissolve 'ADM0_A3_SE' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_SE,ADM0_A3 fields=* \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_swe.shp \

build_a5_ne_10m_admin_0_countries_tlc: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_top_level_countries.dbf \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_TLC \
		-dissolve 'ADM0_TLC' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6 || scalerank == 100' + \
		-join housekeeping/ne_admin_0_details_top_level_countries.dbf encoding=utf8 keys=ADM0_TLC,ADM0_TLC fields=* \
		-filter 'ADM0_TLC !== "-99"' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_tlc.shp \


build_a5_ne_10m_admin_0_countries_bdg: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=ADM0_A3_BD \
		-dissolve 'ADM0_A3_BD' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=ADM0_A3_BD,ADM0_A3 fields=* unjoined \
		-filter 'ADM0_A3 !== null' + \
		-each 'delete sr_adm0_a3' \
		-each 'NAME=BRK_NAME' \
		-each 'NAME_LONG=BRK_NAME' \
		-o 10m_cultural/ne_10m_admin_0_countries_bdg.shp \


build_a2_ne_10m_admin_0_disputed: 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp \
		-filter '"Admin-0 breakaway and disputed,Admin-0 claim area,Admin-0 indeterminant,Admin-0 overlay,Admin-0 lease".indexOf(featurecla) > -1' \
		-filter 'scalerank !== null' + \
		-o 10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.shp \
		-dissolve 'sr_brk_a3' copy-fields=featurecla,scalerank \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=* \
		-each 'delete sr_brk_a3' \
		-o 10m_cultural/ne_10m_admin_0_disputed_areas.shp \

build_a3_ne_10m_admin_0_subunits: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_4_subunits.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-dissolve 'sr_su_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 map subunit"' \
		-join housekeeping/ne_admin_0_details_level_4_subunits.dbf encoding=utf8 keys=sr_su_a3,SU_A3 fields=* \
		-each 'delete sr_su_a3' \
		-o 10m_cultural/ne_10m_admin_0_map_subunits.shp \

build_a4_ne_10m_admin_0_units: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_3_map_units.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-dissolve 'sr_gu_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 map unit"' \
		-join housekeeping/ne_admin_0_details_level_3_map_units.dbf encoding=utf8 keys=sr_gu_a3,GU_A3 fields=* \
		-each 'delete sr_gu_a3' \
		-o 10m_cultural/ne_10m_admin_0_map_units.shp \

intermediate/ne_10m_lakes_big.shp: 10m_physical/ne_10m_lakes.shp
	mkdir -p intermediate
	mapshaper -i 10m_physical/ne_10m_lakes.shp \
		-filter 'scalerank <= 0' + \
		-o intermediate/ne_10m_lakes_big.shp \

build_a5_ne_10m_admin_0_countries: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	intermediate/ne_10m_lakes_big.shp \
	10m_physical/ne_10m_lakes.shp \
	housekeeping/ne_admin_0_details_level_2_countries.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-dissolve 'sr_adm0_a3' calc='featurecla="Admin-0 country", scalerank = min(scalerank)' \
		-filter 'scalerank !== null' + \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=sr_adm0_a3,ADM0_A3 fields=* \
		-each 'delete sr_adm0_a3' \
		-o 10m_cultural/ne_10m_admin_0_countries.shp \
		-erase intermediate/ne_10m_lakes_big.shp \
		-o 10m_cultural/ne_10m_admin_0_countries_lakes.shp \

build_a6_ne_10m_admin_0_sov: 10m_cultural/ne_10m_admin_0_scale_rank.shp \
	intermediate/ne_10m_lakes_big.shp \
	10m_physical/ne_10m_lakes.shp \
	housekeeping/ne_admin_0_details_level_1_sov.dbf
	mapshaper -i 10m_cultural/ne_10m_admin_0_scale_rank.shp \
		-dissolve 'sr_sov_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 sovereignty"' \
		-join housekeeping/ne_admin_0_details_level_1_sov.dbf encoding=utf8 keys=sr_sov_a3,SOV_A3 fields=* \
		-each 'delete sr_sov_a3' \
		-o 10m_cultural/ne_10m_admin_0_sovereignty.shp \

build_a7_ne_10m_admin_1_all: 10m_cultural/ne_10m_admin_0_boundary_lines_land.shp \
	10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp \
	10m_physical/ne_10m_coastline.shp \
	10m_physical/ne_10m_minor_islands_coastline.shp \
	10m_cultural/ne_10m_admin_1_states_provinces_lines.shp \
	10m_cultural/ne_10m_admin_1_seams.shp \
	10m_cultural/ne_10m_admin_1_label_points.shp \
	10m_cultural/ne_10m_admin_1_label_points_details.dbf \
	intermediate/ne_10m_lakes_big.shp \
	10m_physical/ne_10m_lakes.shp
	mapshaper -i combine-files snap \
		10m_cultural/ne_10m_admin_0_boundary_lines_land.shp \
		10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp \
		10m_physical/ne_10m_coastline.shp \
		10m_physical/ne_10m_minor_islands_coastline.shp \
		10m_cultural/ne_10m_admin_1_states_provinces_lines.shp \
		10m_cultural/ne_10m_admin_1_seams.shp \
		-filter-fields \
		-merge-layers \
		-polygons gap-tolerance=1e-4 \
		-join 10m_cultural/ne_10m_admin_1_label_points.shp \
		-filter 'adm0_sr !== null' + \
		-each 'featurecla="Admin-1 states provinces minor islands"' \
		-o 10m_cultural/ne_10m_admin_1_states_provinces_scale_rank_minor_islands.shp \
		-filter 'adm0_sr <= 6' + \
		-each 'featurecla="Admin-1 states provinces scale rank"' \
		-o 10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.shp \
		-dissolve 'adm1_code' copy-fields=featurecla,scalerank \
		-join 10m_cultural/ne_10m_admin_1_label_points_details.dbf encoding=utf8 keys=adm1_code,adm1_code fields=* \
		-each 'featurecla="Admin-1 states provinces"' \
		-o 10m_cultural/ne_10m_admin_1_states_provinces.shp \
		-erase intermediate/ne_10m_lakes_big.shp \
		-each 'featurecla="Admin-1 states provinces lakes"' \
		-o 10m_cultural/ne_10m_admin_1_states_provinces_lakes.shp \
#  calc='join_count = count()'

build_a8_ne_10m_admin_2_all: 10m_cultural/ne_10m_admin_0_boundary_lines_land.shp \
	10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp \
	10m_physical/ne_10m_coastline.shp \
	10m_physical/ne_10m_minor_islands_coastline.shp \
	10m_cultural/ne_10m_admin_1_states_provinces_lines.shp \
	10m_cultural/ne_10m_admin_2_counties_lines.shp \
	10m_cultural/ne_10m_admin_2_label_points.shp \
	10m_cultural/ne_10m_admin_2_label_points_details.dbf \
	intermediate/ne_10m_lakes_big.shp \
	10m_physical/ne_10m_lakes.shp
	mapshaper -i combine-files snap \
		10m_cultural/ne_10m_admin_0_boundary_lines_land.shp \
		10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp \
		10m_physical/ne_10m_coastline.shp \
		10m_physical/ne_10m_minor_islands_coastline.shp \
		10m_cultural/ne_10m_admin_1_states_provinces_lines.shp \
		10m_cultural/ne_10m_admin_2_counties_lines.shp \
		-filter-fields \
		-merge-layers \
		-polygons gap-tolerance=1e-4 \
		-join 10m_cultural/ne_10m_admin_2_label_points.shp encoding=utf8 \
		-filter 'ADM0_SR !== null' + \
		-o 10m_cultural/ne_10m_admin_2_counties_scale_rank_minor_islands.shp \
		-filter 'ADM0_SR <= 6' + \
		-o 10m_cultural/ne_10m_admin_2_counties_scale_rank.shp \
		-dissolve 'ADM2_CODE' copy-fields=FEATURECLA,SCALERANK \
		-join 10m_cultural/ne_10m_admin_2_label_points_details.dbf encoding=utf8 keys=ADM2_CODE,ADM2_CODE fields=* \
		-o 10m_cultural/ne_10m_admin_2_counties.shp \
		-erase intermediate/ne_10m_lakes_big.shp \
		-o 10m_cultural/ne_10m_admin_2_counties_lakes.shp \
#  calc='join_count = count()'

build_b0_ne_50m_admin_0_disputed: 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_5_disputed.dbf
	mapshaper -i 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas_scale_rank.shp \
		-dissolve 'sr_brk_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-filter 'scalerank <= 6' + \
		-join housekeeping/ne_admin_0_details_level_5_disputed.dbf encoding=utf8 keys=sr_brk_a3,BRK_A3 fields=* \
		-each 'delete sr_brk_a3' \
		-o 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.shp \
#calc='join_count = count()' \

build_b1_ne_50m_admin_0_subunits: 50m_cultural/ne_50m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_4_subunits.dbf
	mapshaper -i 50m_cultural/ne_50m_admin_0_scale_rank.shp \
		-dissolve 'sr_su_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 map subunit"' \
		-join housekeeping/ne_admin_0_details_level_4_subunits.dbf encoding=utf8 keys=sr_su_a3,SU_A3 fields=* \
		-each 'delete sr_su_a3' \
		-o 50m_cultural/ne_50m_admin_0_map_subunits.shp \

build_b2_ne_50m_admin_0_units: 50m_cultural/ne_50m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_3_map_units.dbf
	mapshaper -i 50m_cultural/ne_50m_admin_0_scale_rank.shp \
		-dissolve 'sr_gu_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 map unit"' \
		-join housekeeping/ne_admin_0_details_level_3_map_units.dbf encoding=utf8 keys=sr_gu_a3,GU_A3 fields=* \
		-each 'delete sr_gu_a3' \
		-o 50m_cultural/ne_50m_admin_0_map_units.shp \

intermediate/ne_50m_lakes_big.shp: 50m_physical/ne_50m_lakes.shp
	mkdir -p intermediate
	mapshaper -i 50m_physical/ne_50m_lakes.shp \
		-filter 'admin == "admin-0"' + \
		-o intermediate/ne_50m_lakes_big.shp \

build_b3_ne_50m_admin_0_countries: 50m_cultural/ne_50m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_2_countries.dbf \
	intermediate/ne_50m_lakes_big.shp
	mapshaper -i 50m_cultural/ne_50m_admin_0_scale_rank.shp \
		-dissolve 'sr_adm0_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 country"' \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=sr_adm0_a3,ADM0_A3 fields=* \
		-each 'delete sr_adm0_a3' \
		-o 50m_cultural/ne_50m_admin_0_countries.shp \
		-erase intermediate/ne_50m_lakes_big.shp \
		-o 50m_cultural/ne_50m_admin_0_countries_lakes.shp \

build_b4_ne_50m_admin_0_sov: 50m_cultural/ne_50m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_1_sov.dbf
	mapshaper -i 50m_cultural/ne_50m_admin_0_scale_rank.shp \
		-dissolve 'sr_sov_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 sovereignty"' \
		-join housekeeping/ne_admin_0_details_level_1_sov.dbf encoding=utf8 keys=sr_sov_a3,SOV_A3 fields=* \
		-each 'delete sr_sov_a3' \
		-o 50m_cultural/ne_50m_admin_0_sovereignty.shp \

build_b5_ne_50m_admin_0_tiny_countries: 50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_4_subunits.dbf
	mapshaper -i 50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.shp \
		-filter 'scalerank !== null' + \
		-filter 'scalerank >= 0' + \
		-each 'featurecla="Admin-0 Tiny Countries"' \
		-join housekeeping/ne_admin_0_details_level_4_subunits.dbf encoding=utf8 keys=sr_su_a3,SU_A3 fields=* \
		-drop fields=sr_sov_a3,sr_adm0_a3,sr_gu_a3,sr_su_a3,sr_subunit \
		-o 50m_cultural/ne_50m_admin_0_tiny_countries.shp \

build_b6_ne_50m_admin_1_all: 50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.shp \
	10m_cultural/ne_10m_admin_1_label_points_details.dbf \
	intermediate/ne_50m_lakes_big.shp
	mapshaper -i 50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.shp \
		-filter 'scalerank !== null' + \
		-dissolve 'adm1_code' copy-fields=featurecla,scalerank \
		-join 10m_cultural/ne_10m_admin_1_label_points_details.dbf encoding=utf8 keys=adm1_code,adm1_code fields=* \
		-o 50m_cultural/ne_50m_admin_1_states_provinces.shp \
		-erase intermediate/ne_50m_lakes_big.shp \
		-o 50m_cultural/ne_50m_admin_1_states_provinces_lakes.shp \

# new in v5 but not manual construction for now until proper 50m label points available and gap tolerence smaller
# currently just: AUS,BRA,CAN,CHN,IDN,IND,RUS,USA,ZAF
build_b6_ne_50m_admin_1_all_raw: 50m_cultural/ne_50m_admin_0_boundary_lines_land.shp \
	50m_physical/ne_50m_coastline.shp \
	50m_cultural/ne_50m_admin_1_states_provinces_lines.shp \
	50m_cultural/ne_50m_admin_1_seams.shp
	mapshaper -i combine-files snap \
		50m_cultural/ne_50m_admin_0_boundary_lines_land.shp \
		50m_physical/ne_50m_coastline.shp \
		50m_cultural/ne_50m_admin_1_states_provinces_lines.shp \
		50m_cultural/ne_50m_admin_1_seams.shp \
		-filter-fields \
		-merge-layers \
		-polygons gap-tolerance=1e-2 \
		-join 10m_cultural/ne_10m_admin_1_label_points.shp \
		-filter 'adm0_sr !== null' + \
		-o 50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.shp \
		-dissolve 'adm1_code' copy-fields=featurecla,scalerank \
		-join 10m_cultural/ne_10m_admin_1_label_points_details.dbf encoding=utf8 keys=adm1_code,adm1_code fields=* \
		-o 50m_cultural/ne_50m_admin_1_states_provinces.shp
		-erase intermediate/ne_50m_lakes_big.shp \
		-o 50m_cultural/ne_50m_admin_1_states_provinces_lakes.shp \

build_c1_ne_110m_admin_0_units: 110m_cultural/ne_110m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_3_map_units.dbf
	mapshaper -i 110m_cultural/ne_110m_admin_0_scale_rank.shp \
		-dissolve 'sr_gu_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 map unit"' \
		-join housekeeping/ne_admin_0_details_level_3_map_units.dbf encoding=utf8 keys=sr_gu_a3,GU_A3 fields=* \
		-each 'delete sr_gu_a3' \
		-o 110m_cultural/ne_110m_admin_0_map_units.shp \

intermediate/ne_110m_lakes_big.shp: 110m_physical/ne_110m_lakes.shp
	mkdir -p intermediate
	mapshaper -i 110m_physical/ne_110m_lakes.shp \
		-filter 'admin == "admin-0"' + \
		-o intermediate/ne_110m_lakes_big.shp \

build_c2_ne_110m_admin_0_countries: 110m_cultural/ne_110m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_2_countries.dbf \
	intermediate/ne_110m_lakes_big.shp
	mkdir -p intermediate
	mapshaper -i 110m_cultural/ne_110m_admin_0_scale_rank.shp \
		-dissolve 'sr_adm0_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 country"' \
		-join housekeeping/ne_admin_0_details_level_2_countries.dbf encoding=utf8 keys=sr_adm0_a3,ADM0_A3 fields=* \
		-each 'delete sr_adm0_a3' \
		-o 110m_cultural/ne_110m_admin_0_countries.shp \
		-erase intermediate/ne_110m_lakes_big.shp \
		-o 110m_cultural/ne_110m_admin_0_countries_lakes.shp \

build_c3_ne_110m_admin_0_sov: 110m_cultural/ne_110m_admin_0_scale_rank.shp \
	housekeeping/ne_admin_0_details_level_1_sov.dbf
	mapshaper -i 110m_cultural/ne_110m_admin_0_scale_rank.shp \
		-dissolve 'sr_sov_a3' copy-fields=featurecla,scalerank \
		-filter 'scalerank !== null' + \
		-each 'featurecla="Admin-0 sovereignty"' \
		-join housekeeping/ne_admin_0_details_level_1_sov.dbf encoding=utf8 keys=sr_sov_a3,SOV_A3 fields=* \
		-each 'delete sr_sov_a3' \
		-o 110m_cultural/ne_110m_admin_0_sovereignty.shp \

build_c4_ne_110m_admin_1: 110m_cultural/ne_110m_admin_1_states_provinces_scale_rank.shp \
	10m_cultural/ne_10m_admin_1_label_points_details.dbf \
	intermediate/ne_110m_lakes_big.shp
	mapshaper -i 110m_cultural/ne_110m_admin_1_states_provinces_scale_rank.shp \
		-filter 'scalerank !== null' + \
		-dissolve 'adm1_code' copy-fields=featurecla,scalerank \
		-join 10m_cultural/ne_10m_admin_1_label_points_details.dbf encoding=utf8 keys=adm1_code,adm1_code fields=* \
		-o 110m_cultural/ne_110m_admin_1_states_provinces.shp \
		-erase intermediate/ne_110m_lakes_big.shp \
		-o 110m_cultural/ne_110m_admin_1_states_provinces_lakes.shp \


# River centerlines from scale rank (stroke weight)
intermediate/ne_10m_rivers_lake_centerlines.shp: 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.dbf
	mapshaper -i 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp \
		-dissolve dissolve copy-fields=dissolve,scalerank,featurecla,name,name_alt,rivernum,note,min_zoom,name_en,min_label,ne_id,label,wikidataid,name_ar,name_bn,name_de,name_es,name_fr,name_el,name_hi,name_hu,name_id,name_it,name_ja,name_ko,name_nl,name_pl,name_pt,name_ru,name_sv,name_tr,name_vi,name_zh,name_fa,name_he,name_uk,name_ur,name_zht\
		-o intermediate/ne_10m_rivers_lake_centerlines.shp \

# If the intermediate files look good, then copy them over
# existing files... but beware of edits and names that may have only
# been made to the ne_10m_rivers_lake_centerlines shapefile
10m_physical/ne_10m_rivers_lake_centerlines.shp: intermediate/ne_10m_rivers_lake_centerlines.shp intermediate/ne_10m_rivers_lake_centerlines.dbf
	mapshaper -i intermediate/ne_10m_rivers_lake_centerlines.shp \
		-o force 10m_physical/ne_10m_rivers_lake_centerlines.shp \

# POPULATED PLACES

derived_populated_places: 10m_cultural/ne_10m_populated_places.shp \
	10m_cultural/ne_10m_populated_places_simple.shp \
	50m_cultural/ne_50m_populated_places.shp \
	50m_cultural/ne_50m_populated_places_simple.shp \
	110m_cultural/ne_110m_populated_places.shp \
	110m_cultural/ne_110m_populated_places_simple.shp \

	touch $@

#10m simple- populated places
10m_cultural/ne_10m_populated_places_simple.shp: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT scalerank, natscale, labelrank, featurecla, name, namepar, namealt, nameascii, adm0cap, capalt, capin, worldcity, megacity, sov0name, sov_a3, adm0name, adm0_a3, adm1name, iso_a2, note, latitude, longitude, pop_max, pop_min, pop_other, rank_max, rank_min, meganame, ls_name, min_zoom, ne_id FROM ne_10m_populated_places ORDER BY natscale" $@ 10m_cultural/ne_10m_populated_places.shp

#50m full - populated places
50m_cultural/ne_50m_populated_places.shp: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	# “SCALERANK” <= 4 Or "FEATURECLA" = 'Admin-0 capital' Or "FEATURECLA" = 'Admin-0 capital alt' Or "FEATURECLA" = 'Admin-0 region capital' Or "FEATURECLA" = 'Admin-1 region capital' Or "FEATURECLA" = 'Scientific station'
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_populated_places WHERE scalerank <= 4 OR featurecla = 'Admin-0 capital' OR featurecla = 'Admin-0 capital alt' OR featurecla = 'Admin-0 region capital' OR featurecla = 'Admin-1 region capital' OR featurecla = 'Scientific station' ORDER BY natscale" $@ 10m_cultural/ne_10m_populated_places.shp

50m_cultural/ne_50m_populated_places_simple.shp: 50m_cultural/ne_50m_populated_places.shp 50m_cultural/ne_50m_populated_places.dbf
	#50m simple - populated places
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT scalerank, natscale, labelrank, featurecla, name, namepar, namealt, nameascii, adm0cap, capalt, capin, worldcity, megacity, sov0name, sov_a3, adm0name, adm0_a3, adm1name, iso_a2, note, latitude, longitude, pop_max, pop_min, pop_other, rank_max, rank_min, meganame, ls_name, min_zoom, ne_id FROM ne_50m_populated_places ORDER BY natscale" $@ 50m_cultural/ne_50m_populated_places.shp

#110m full - populated places
110m_cultural/ne_110m_populated_places.shp: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	# “SCALERANK” <= 1 Or "FEATURECLA" = 'Admin-0 capital' Or "FEATURECLA" = 'Admin-0 capital alt'
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_populated_places WHERE scalerank <= 1 OR featurecla = 'Admin-0 capital' OR featurecla = 'Admin-0 capital alt' ORDER BY natscale" $@ 10m_cultural/ne_10m_populated_places.shp

110m_cultural/ne_110m_populated_places_simple.shp: 110m_cultural/ne_110m_populated_places.shp 110m_cultural/ne_110m_populated_places.dbf
	#110m simple - populated places
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT scalerank, natscale, labelrank, featurecla, name, namepar, namealt, nameascii, adm0cap, capalt, capin, worldcity, megacity, sov0name, sov_a3, adm0name, adm0_a3, adm1name, iso_a2, note, latitude, longitude, pop_max, pop_min, pop_other, rank_max, rank_min, meganame, ls_name, min_zoom, ne_id FROM ne_110m_populated_places ORDER BY natscale" $@ 110m_cultural/ne_110m_populated_places.shp

# TINY COUNTRIES

# 110m

110m_cultural/ne_110m_admin_0_tiny_countries.shp: 50m_cultural/ne_50m_admin_0_tiny_countries.shp 50m_cultural/ne_50m_admin_0_tiny_countries.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_50m_admin_0_tiny_countries WHERE scalerank <= 2 ORDER BY scalerank" $@ 50m_cultural/ne_50m_admin_0_tiny_countries.shp

# AIRPORTS

#50m airports
50m_cultural/ne_50m_airports.shp: 10m_cultural/ne_10m_airports.shp 10m_cultural/ne_10m_airports.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_airports WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_cultural/ne_10m_airports.shp

# PORTS

# 50m ports
50m_cultural/ne_50m_ports.shp: 10m_cultural/ne_10m_ports.shp 10m_cultural/ne_10m_ports.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_ports WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_cultural/ne_10m_ports.shp

# Physical labels

derived_physical_labels: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf \
	10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf \
	10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf \
	10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf \
	10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf \
	50m_physical/ne_50m_geographic_lines.shp 50m_physical/ne_50m_geographic_lines.dbf \
	50m_physical/ne_50m_geography_regions_points.shp 50m_physical/ne_50m_geography_regions_points.dbf \
	50m_physical/ne_50m_geography_regions_elevation_points.shp 50m_physical/ne_50m_geography_regions_elevation_points.dbf \
	50m_physical/ne_50m_geography_marine_polys.shp 50m_physical/ne_50m_geography_marine_polys.dbf \
	50m_physical/ne_50m_geography_regions_polys.shp 50m_physical/ne_50m_geography_regions_polys.dbf \
	110m_physical/ne_110m_geographic_lines.shp 110m_physical/ne_110m_geographic_lines.dbf \
	110m_physical/ne_110m_geography_regions_points.shp 110m_physical/ne_110m_geography_regions_points.dbf \
	110m_physical/ne_110m_geography_regions_elevation_points.shp 110m_physical/ne_110m_geography_regions_elevation_points.dbf \
	110m_physical/ne_110m_geography_marine_polys.shp 110m_physical/ne_110m_geography_marine_polys.dbf \
	110m_physical/ne_110m_geography_regions_polys.shp 110m_physical/ne_110m_geography_regions_polys.dbf \

	touch $@

# 50m

50m_physical/ne_50m_geographic_lines.shp: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 $@ 10m_physical/ne_10m_geographic_lines.shp

50m_physical/ne_50m_geography_regions_points.shp: 10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_regions_points WHERE scalerank <= 5 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_points.shp

50m_physical/ne_50m_geography_regions_elevation_points.shp: 10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_regions_elevation_points WHERE scalerank <= 5 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_elevation_points.shp

50m_physical/ne_50m_geography_marine_polys.shp: 10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_marine_polys WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_marine_polys.shp

50m_physical/ne_50m_geography_regions_polys.shp: 10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_regions_polys WHERE scalerank <= 4 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_polys.shp


# 110m

110m_physical/ne_110m_geographic_lines.shp: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 $@ 10m_physical/ne_10m_geographic_lines.shp

110m_physical/ne_110m_geography_regions_points.shp: 10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_regions_points WHERE scalerank <= 2 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_points.shp

110m_physical/ne_110m_geography_regions_elevation_points.shp: 10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_regions_elevation_points WHERE scalerank <= 2 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_elevation_points.shp

110m_physical/ne_110m_geography_marine_polys.shp: 10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8 -sql "SELECT * FROM ne_10m_geography_marine_polys WHERE scalerank <= 1 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_marine_polys.shp

110m_physical/ne_110m_geography_regions_polys.shp: 10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf
	ogr2ogr -overwrite -lco ENCODING=UTF-8  -sql "SELECT * FROM ne_10m_geography_regions_polys WHERE scalerank <= 1 ORDER BY scalerank" $@ 10m_physical/ne_10m_geography_regions_polys.shp


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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_map_units$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.shp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_maritime_indicator$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.shp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_maritime_indicator_chn$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_pacific_groupings.zip: 10m_cultural/ne_10m_admin_0_pacific_groupings.shp 10m_cultural/ne_10m_admin_0_pacific_groupings.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_pacific_groupings$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.zip: 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_boundary_lines_disputed_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_disputed_areas.zip: 10m_cultural/ne_10m_admin_0_disputed_areas.shp 10m_cultural/ne_10m_admin_0_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_disputed_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.zip: 10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_disputed_areas_scale_rank_minor_islands$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries.zip: 10m_cultural/ne_10m_admin_0_countries.shp 10m_cultural/ne_10m_admin_0_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson



zips/10m_cultural/ne_10m_admin_0_countries_arg.zip: 10m_cultural/ne_10m_admin_0_countries_arg.shp 10m_cultural/ne_10m_admin_0_countries_arg.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_arg$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_bdg.zip: 10m_cultural/ne_10m_admin_0_countries_bdg.shp 10m_cultural/ne_10m_admin_0_countries_bdg.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_bdg$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_bra.zip: 10m_cultural/ne_10m_admin_0_countries_bra.shp 10m_cultural/ne_10m_admin_0_countries_bra.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_bra$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_chn.zip: 10m_cultural/ne_10m_admin_0_countries_chn.shp 10m_cultural/ne_10m_admin_0_countries_chn.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_chn$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_deu.zip: 10m_cultural/ne_10m_admin_0_countries_deu.shp 10m_cultural/ne_10m_admin_0_countries_deu.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_deu$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_egy.zip: 10m_cultural/ne_10m_admin_0_countries_egy.shp 10m_cultural/ne_10m_admin_0_countries_egy.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_egy$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_esp.zip: 10m_cultural/ne_10m_admin_0_countries_esp.shp 10m_cultural/ne_10m_admin_0_countries_esp.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_esp$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_fra.zip: 10m_cultural/ne_10m_admin_0_countries_fra.shp 10m_cultural/ne_10m_admin_0_countries_fra.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_fra$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_gbr.zip: 10m_cultural/ne_10m_admin_0_countries_gbr.shp 10m_cultural/ne_10m_admin_0_countries_gbr.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_gbr$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_grc.zip: 10m_cultural/ne_10m_admin_0_countries_grc.shp 10m_cultural/ne_10m_admin_0_countries_grc.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_grc$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_idn.zip: 10m_cultural/ne_10m_admin_0_countries_idn.shp 10m_cultural/ne_10m_admin_0_countries_idn.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_idn$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_ind.zip: 10m_cultural/ne_10m_admin_0_countries_ind.shp 10m_cultural/ne_10m_admin_0_countries_ind.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_ind$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_isr.zip: 10m_cultural/ne_10m_admin_0_countries_isr.shp 10m_cultural/ne_10m_admin_0_countries_isr.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_isr$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_iso.zip: 10m_cultural/ne_10m_admin_0_countries_iso.shp 10m_cultural/ne_10m_admin_0_countries_iso.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_iso$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_ita.zip: 10m_cultural/ne_10m_admin_0_countries_ita.shp 10m_cultural/ne_10m_admin_0_countries_ita.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_ita$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_jpn.zip: 10m_cultural/ne_10m_admin_0_countries_jpn.shp 10m_cultural/ne_10m_admin_0_countries_jpn.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_jpn$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_kor.zip: 10m_cultural/ne_10m_admin_0_countries_kor.shp 10m_cultural/ne_10m_admin_0_countries_kor.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_kor$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_mar.zip: 10m_cultural/ne_10m_admin_0_countries_mar.shp 10m_cultural/ne_10m_admin_0_countries_mar.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_mar$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_nep.zip: 10m_cultural/ne_10m_admin_0_countries_nep.shp 10m_cultural/ne_10m_admin_0_countries_nep.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_nep$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_nld.zip: 10m_cultural/ne_10m_admin_0_countries_nld.shp 10m_cultural/ne_10m_admin_0_countries_nld.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_nld$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_pak.zip: 10m_cultural/ne_10m_admin_0_countries_pak.shp 10m_cultural/ne_10m_admin_0_countries_pak.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_pak$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_pol.zip: 10m_cultural/ne_10m_admin_0_countries_pol.shp 10m_cultural/ne_10m_admin_0_countries_pol.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_pol$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_prt.zip: 10m_cultural/ne_10m_admin_0_countries_prt.shp 10m_cultural/ne_10m_admin_0_countries_prt.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_prt$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_pse.zip: 10m_cultural/ne_10m_admin_0_countries_pse.shp 10m_cultural/ne_10m_admin_0_countries_pse.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_pse$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_rus.zip: 10m_cultural/ne_10m_admin_0_countries_rus.shp 10m_cultural/ne_10m_admin_0_countries_rus.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_rus$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_sau.zip: 10m_cultural/ne_10m_admin_0_countries_sau.shp 10m_cultural/ne_10m_admin_0_countries_sau.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_sau$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_swe.zip: 10m_cultural/ne_10m_admin_0_countries_swe.shp 10m_cultural/ne_10m_admin_0_countries_swe.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_swe$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_tlc.zip: 10m_cultural/ne_10m_admin_0_countries_tlc.shp 10m_cultural/ne_10m_admin_0_countries_tlc.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_tlc$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_tur.zip: 10m_cultural/ne_10m_admin_0_countries_tur.shp 10m_cultural/ne_10m_admin_0_countries_tur.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_tur$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_twn.zip: 10m_cultural/ne_10m_admin_0_countries_twn.shp 10m_cultural/ne_10m_admin_0_countries_twn.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_twn$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_ukr.zip: 10m_cultural/ne_10m_admin_0_countries_ukr.shp 10m_cultural/ne_10m_admin_0_countries_ukr.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_ukr$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_usa.zip: 10m_cultural/ne_10m_admin_0_countries_usa.shp 10m_cultural/ne_10m_admin_0_countries_usa.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_usa$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_countries_vnm.zip: 10m_cultural/ne_10m_admin_0_countries_vnm.shp 10m_cultural/ne_10m_admin_0_countries_vnm.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_vnm$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson



zips/10m_cultural/ne_10m_admin_0_countries_lakes.zip: 10m_cultural/ne_10m_admin_0_countries_lakes.shp 10m_cultural/ne_10m_admin_0_countries_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_countries_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_map_subunits.zip: 10m_cultural/ne_10m_admin_0_map_subunits.shp 10m_cultural/ne_10m_admin_0_map_subunits.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_map_subunits$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_map_units.zip: 10m_cultural/ne_10m_admin_0_map_units.shp 10m_cultural/ne_10m_admin_0_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_map_units$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.zip: 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_scale_rank_minor_islands$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_scale_rank.zip: 10m_cultural/ne_10m_admin_0_scale_rank.shp 10m_cultural/ne_10m_admin_0_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_sovereignty.zip: 10m_cultural/ne_10m_admin_0_sovereignty.shp 10m_cultural/ne_10m_admin_0_sovereignty.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_sovereignty$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_label_points.zip: 10m_cultural/ne_10m_admin_0_label_points.shp 10m_cultural/ne_10m_admin_0_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_label_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_seams.zip: 10m_cultural/ne_10m_admin_0_seams.shp 10m_cultural/ne_10m_admin_0_seams.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_seams$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_antarctic_claims.zip: 10m_cultural/ne_10m_admin_0_antarctic_claims.shp 10m_cultural/ne_10m_admin_0_antarctic_claims.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_antarctic_claims$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.zip: 10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.shp 10m_cultural/ne_10m_admin_0_antarctic_claim_limit_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_0_antarctic_claim_limit_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_1_states_provinces_lakes.zip: 10m_cultural/ne_10m_admin_1_states_provinces_lakes.shp 10m_cultural/ne_10m_admin_1_states_provinces_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_states_provinces_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_1_states_provinces_lines.zip: 10m_cultural/ne_10m_admin_1_states_provinces_lines.shp 10m_cultural/ne_10m_admin_1_states_provinces_lines.dbf
	cp VERSION 10m_cultural/ne_10m_admin_1_states_provinces_lines.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > 10m_cultural/ne_10m_admin_1_states_provinces_lines.README.html
	zip -j -r $@ 10m_cultural/ne_10m_admin_1_states_provinces_lines.*
	cp $@ archive/ne_10m_admin_1_states_provinces_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_1_states_provinces.zip: 10m_cultural/ne_10m_admin_1_states_provinces.shp 10m_cultural/ne_10m_admin_1_states_provinces.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_states_provinces$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.zip: 10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.shp 10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_states_provinces_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_1_seams.zip: 10m_cultural/ne_10m_admin_1_seams.shp 10m_cultural/ne_10m_admin_1_seams.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_seams$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_2_counties.zip: 10m_cultural/ne_10m_admin_2_counties.shp 10m_cultural/ne_10m_admin_2_counties.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-2-counties/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_2_counties$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_2_counties_lakes.zip: 10m_cultural/ne_10m_admin_2_counties_lakes.shp 10m_cultural/ne_10m_admin_2_counties_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-2-counties/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_2_counties_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_2_counties_scale_rank.zip: 10m_cultural/ne_10m_admin_2_counties_scale_rank.shp 10m_cultural/ne_10m_admin_2_counties_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-2-counties/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_2_counties_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_2_counties_scale_rank_minor_islands.zip: 10m_cultural/ne_10m_admin_2_counties_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_2_counties_scale_rank_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-2-counties/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_2_counties_scale_rank_minor_islands$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_2_label_points_details.zip: 10m_cultural/ne_10m_admin_2_label_points_details.shp 10m_cultural/ne_10m_admin_2_label_points_details.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-2-counties/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_2_label_points_details$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_2_label_points.zip: 10m_cultural/ne_10m_admin_2_label_points.shp 10m_cultural/ne_10m_admin_2_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-2-counties/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_2_label_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_populated_places_simple.zip: 10m_cultural/ne_10m_populated_places_simple.shp 10m_cultural/ne_10m_populated_places_simple.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_populated_places_simple$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_populated_places.zip: 10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_populated_places$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_railroads.zip: 10m_cultural/ne_10m_railroads.shp 10m_cultural/ne_10m_railroads.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/railroads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_railroads$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_railroads_north_america.zip: 10m_cultural/ne_10m_railroads_north_america.shp 10m_cultural/ne_10m_railroads_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/railroads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_railroads_north_america$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_roads.zip: 10m_cultural/ne_10m_roads.shp 10m_cultural/ne_10m_roads.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/roads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_roads$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_roads_north_america.zip: 10m_cultural/ne_10m_roads_north_america.shp 10m_cultural/ne_10m_roads_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/roads/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_roads_north_america$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_urban_areas_landscan.zip: 10m_cultural/ne_10m_urban_areas_landscan.shp 10m_cultural/ne_10m_urban_areas_landscan.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_urban_areas_landscan$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_urban_areas.zip: 10m_cultural/ne_10m_urban_areas.shp 10m_cultural/ne_10m_urban_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-urban-area/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_urban_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_airports.zip: 10m_cultural/ne_10m_airports.shp 10m_cultural/ne_10m_airports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/airports/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_airports$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_ports.zip: 10m_cultural/ne_10m_ports.shp 10m_cultural/ne_10m_ports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/ports/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_ports$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_time_zones.zip: 10m_cultural/ne_10m_time_zones.shp 10m_cultural/ne_10m_time_zones.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/timezones/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_time_zones$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_cultural_building_blocks_all.zip: \
	zips/10m_cultural/ne_10m_admin_0_label_points.zip \
	zips/10m_cultural/ne_10m_admin_0_seams.zip \
	zips/10m_cultural/ne_10m_admin_1_label_points.zip \
	zips/10m_cultural/ne_10m_admin_1_label_points_details.zip \
	zips/10m_cultural/ne_10m_admin_1_seams.zip \
	zips/10m_cultural/ne_10m_admin_2_label_points.zip \
	zips/10m_cultural/ne_10m_admin_2_label_points_details.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_land.zip \
	zips/10m_cultural/ne_10m_admin_0_boundary_lines_map_units.zip \
	zips/10m_physical/ne_10m_coastline.zip \
	zips/10m_physical/ne_10m_minor_islands_coastline.zip

	zip -j -r $@ 10m_cultural/ne_10m_admin_0_label_points.* 10m_cultural/ne_10m_admin_0_seams.* 10m_cultural/ne_10m_admin_1_label_points.* 10m_cultural/ne_10m_admin_1_label_points_details.* 10m_cultural/ne_10m_admin_2_label_points.* 10m_cultural/ne_10m_admin_2_label_points_details.* 10m_cultural/ne_10m_admin_1_seams.* 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.* 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.* 10m_cultural/ne_10m_admin_0_boundary_lines_land.* 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.* 10m_physical/ne_10m_coastline.* 10m_physical/ne_10m_minor_islands_coastline.*
	cp $@ archive/ne_10m_cultural_building_blocks_all$(VERSION_PREFIXED).zip


# folders for theme groups or geodb special items
zips/10m_cultural/ne_10m_admin_1_label_points.zip: 10m_cultural/ne_10m_admin_1_label_points.shp 10m_cultural/ne_10m_admin_1_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_label_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

zips/10m_cultural/ne_10m_admin_1_label_points_details.zip: 10m_cultural/ne_10m_admin_1_label_points_details.shp 10m_cultural/ne_10m_admin_1_label_points_details.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-cultural-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_admin_1_label_points_details$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_cultural/,,$(basename $@)).geojson

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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_cultural/ne_10m_parks_and_protected_lands_area.shp \
		| jq -c . > geojson/ne_10m_parks_and_protected_lands_area.geojson
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_cultural/ne_10m_parks_and_protected_lands_scale_rank.shp \
		| jq -c . > geojson/ne_10m_parks_and_protected_lands_scale_rank.geojson
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_cultural/ne_10m_parks_and_protected_lands_line.shp \
		| jq -c . > geojson/ne_10m_parks_and_protected_lands_line.geojson
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_cultural/ne_10m_parks_and_protected_lands_point.shp \
		| jq -c . > geojson/ne_10m_parks_and_protected_lands_point.geojson



# 10m physical:

zips/10m_physical/ne_10m_antarctic_ice_shelves_lines.zip: 10m_physical/ne_10m_antarctic_ice_shelves_lines.shp 10m_physical/ne_10m_antarctic_ice_shelves_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_antarctic_ice_shelves_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_antarctic_ice_shelves_polys.zip: 10m_physical/ne_10m_antarctic_ice_shelves_polys.shp 10m_physical/ne_10m_antarctic_ice_shelves_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_antarctic_ice_shelves_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_coastline.zip: 10m_physical/ne_10m_coastline.shp 10m_physical/ne_10m_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-coastline/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_coastline$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_geographic_lines.zip: 10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-geographic-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geographic_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_geography_marine_polys.zip: 10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_marine_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_geography_regions_elevation_points.zip: 10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_regions_elevation_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_geography_regions_points.zip: 10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_regions_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_geography_regions_polys.zip: 10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_geography_regions_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_glaciated_areas.zip: 10m_physical/ne_10m_glaciated_areas.shp 10m_physical/ne_10m_glaciated_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-glaciated-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_glaciated_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_lakes_australia.zip: 10m_physical/ne_10m_lakes_australia.shp 10m_physical/ne_10m_lakes_australia.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_australia$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_lakes_europe.zip: 10m_physical/ne_10m_lakes_europe.shp 10m_physical/ne_10m_lakes_europe.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_europe$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_lakes_historic.zip: 10m_physical/ne_10m_lakes_historic.shp 10m_physical/ne_10m_lakes_historic.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_historic$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_lakes_north_america.zip: 10m_physical/ne_10m_lakes_north_america.shp 10m_physical/ne_10m_lakes_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_north_america$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_lakes_pluvial.zip: 10m_physical/ne_10m_lakes_pluvial.shp 10m_physical/ne_10m_lakes_pluvial.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes_pluvial$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_lakes.zip: 10m_physical/ne_10m_lakes.shp 10m_physical/ne_10m_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-lakes/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_land.zip: 10m_physical/ne_10m_land.shp 10m_physical/ne_10m_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_land_scale_rank.zip: 10m_physical/ne_10m_land_scale_rank.shp 10m_physical/ne_10m_land_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_minor_islands_coastline.zip: 10m_physical/ne_10m_minor_islands_coastline.shp 10m_physical/ne_10m_minor_islands_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-minor-islands/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_minor_islands_coastline$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_minor_islands.zip: 10m_physical/ne_10m_minor_islands.shp 10m_physical/ne_10m_minor_islands.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-minor-islands/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_minor_islands$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_ocean.zip: 10m_physical/ne_10m_ocean.shp 10m_physical/ne_10m_ocean.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_ocean$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_ocean_scale_rank.zip: 10m_physical/ne_10m_ocean_scale_rank.shp 10m_physical/ne_10m_ocean_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_ocean_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_playas.zip: 10m_physical/ne_10m_playas.shp 10m_physical/ne_10m_playas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-playas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_playas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_reefs.zip: 10m_physical/ne_10m_reefs.shp 10m_physical/ne_10m_reefs.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-reefs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_reefs$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_rivers_australia.zip: 10m_physical/ne_10m_rivers_australia.shp 10m_physical/ne_10m_rivers_australia.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_australia$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_rivers_europe.zip: 10m_physical/ne_10m_rivers_europe.shp 10m_physical/ne_10m_rivers_europe.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_europe$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.zip: 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_lake_centerlines_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_rivers_lake_centerlines.zip: 10m_physical/ne_10m_rivers_lake_centerlines.shp 10m_physical/ne_10m_rivers_lake_centerlines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_lake_centerlines$(VERSION_PREFIXED).zip
	#ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
	#	| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_rivers_north_america.zip: 10m_physical/ne_10m_rivers_north_america.shp 10m_physical/ne_10m_rivers_north_america.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_rivers_north_america$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_A_10000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_B_9000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.*
	cp $@ archive/ne_10m_bathymetry_B_9000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_B_9000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_C_8000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.*
	cp $@ archive/ne_10m_bathymetry_C_8000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_C_8000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_D_7000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.*
	cp $@ archive/ne_10m_bathymetry_D_7000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_D_7000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_E_6000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.*
	cp $@ archive/ne_10m_bathymetry_E_6000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_E_6000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_F_5000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.*
	cp $@ archive/ne_10m_bathymetry_F_5000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_F_5000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_G_4000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.*
	cp $@ archive/ne_10m_bathymetry_G_4000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_G_4000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_H_3000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.*
	cp $@ archive/ne_10m_bathymetry_H_3000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_H_3000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_I_2000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.*
	cp $@ archive/ne_10m_bathymetry_I_2000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_I_2000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_J_1000.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.*
	cp $@ archive/ne_10m_bathymetry_J_1000$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_J_1000.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_K_200.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.*
	cp $@ archive/ne_10m_bathymetry_K_200$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_K_200.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_bathymetry_L_0.zip: 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.shp 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.dbf
	cp VERSION 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-bathymetry/ > 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.README.html
	zip -j -r $@ 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.*
	cp $@ archive/ne_10m_bathymetry_L_0$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_bathymetry_all/ne_10m_bathymetry_L_0.shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_graticules_5.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_5.*
	cp $@ archive/ne_10m_graticules_5$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_graticules_10.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_10.*
	cp $@ archive/ne_10m_graticules_10$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_graticules_15.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_15.*
	cp $@ archive/ne_10m_graticules_15$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_graticules_20.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_20.*
	cp $@ archive/ne_10m_graticules_20$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_graticules_30.zip: 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.shp 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_graticules_30.*
	cp $@ archive/ne_10m_graticules_30$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_wgs84_bounding_box.zip: 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.shp 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.dbf
	cp VERSION 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-graticules/ > 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.README.html
	zip -j -r $@ 10m_physical/ne_10m_graticules_all/ne_10m_wgs84_bounding_box.*
	cp $@ archive/ne_10m_wgs84_bounding_box$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 10m_physical/ne_10m_graticules_all/$(subst zips/10m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_land_ocean_label_points.zip: 10m_physical/ne_10m_land_ocean_label_points.shp 10m_physical/ne_10m_land_ocean_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land_ocean_label_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_land_ocean_seams.zip: 10m_physical/ne_10m_land_ocean_seams.shp 10m_physical/ne_10m_land_ocean_seams.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_land_ocean_seams$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

zips/10m_physical/ne_10m_minor_islands_label_points.zip: 10m_physical/ne_10m_minor_islands_label_points.shp 10m_physical/ne_10m_minor_islands_label_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-physical-building-blocks/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_10m_minor_islands_label_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/10m_physical/,,$(basename $@)).geojson

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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_boundary_map_units.zip: 50m_cultural/ne_50m_admin_0_boundary_map_units.shp 50m_cultural/ne_50m_admin_0_boundary_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_map_units$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_pacific_groupings.zip: 50m_cultural/ne_50m_admin_0_pacific_groupings.shp 50m_cultural/ne_50m_admin_0_pacific_groupings.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_pacific_groupings$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.zip: 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.shp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_lines_maritime_indicator$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.zip: 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.shp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-boundary-lines-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_lines_maritime_indicator_chn$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_countries.zip: 50m_cultural/ne_50m_admin_0_countries.shp 50m_cultural/ne_50m_admin_0_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_countries$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_countries_lakes.zip: 50m_cultural/ne_50m_admin_0_countries_lakes.shp 50m_cultural/ne_50m_admin_0_countries_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_countries_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_map_subunits.zip: 50m_cultural/ne_50m_admin_0_map_subunits.shp 50m_cultural/ne_50m_admin_0_map_subunits.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_map_subunits$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_map_units.zip: 50m_cultural/ne_50m_admin_0_map_units.shp 50m_cultural/ne_50m_admin_0_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_map_units$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_scale_rank.zip: 50m_cultural/ne_50m_admin_0_scale_rank.shp 50m_cultural/ne_50m_admin_0_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_scale_rank$(VERSION_PREFIXED).zip
	#ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
	#	| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_sovereignty.zip: 50m_cultural/ne_50m_admin_0_sovereignty.shp 50m_cultural/ne_50m_admin_0_sovereignty.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_sovereignty$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_tiny_countries.zip: 50m_cultural/ne_50m_admin_0_tiny_countries.shp 50m_cultural/ne_50m_admin_0_tiny_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_tiny_countries$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.zip: 50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.shp 50m_cultural/ne_50m_admin_0_tiny_countries_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_tiny_countries_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.zip: 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.shp 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_breakaway_disputed_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.zip: 50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.shp 50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-breakaway-disputed-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_0_boundary_lines_disputed_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_1_states_provinces.zip: 50m_cultural/ne_50m_admin_1_states_provinces.shp 50m_cultural/ne_50m_admin_1_states_provinces.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.zip: 50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.shp 50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_1_states_provinces_lakes.zip: 50m_cultural/ne_50m_admin_1_states_provinces_lakes.shp 50m_cultural/ne_50m_admin_1_states_provinces_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_admin_1_states_provinces_lines.zip: 50m_cultural/ne_50m_admin_1_states_provinces_lines.shp 50m_cultural/ne_50m_admin_1_states_provinces_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_admin_1_states_provinces_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_populated_places.zip: 50m_cultural/ne_50m_populated_places.shp 50m_cultural/ne_50m_populated_places.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_populated_places$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_populated_places_simple.zip: 50m_cultural/ne_50m_populated_places_simple.shp 50m_cultural/ne_50m_populated_places_simple.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_populated_places_simple$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_airports.zip: 50m_cultural/ne_50m_airports.shp 50m_cultural/ne_50m_airports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/airports-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_airports$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_ports.zip: 50m_cultural/ne_50m_ports.shp 50m_cultural/ne_50m_ports.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/ports-2/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_ports$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson

zips/50m_cultural/ne_50m_urban_areas.zip: 50m_cultural/ne_50m_urban_areas.shp 50m_cultural/ne_50m_urban_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-urban-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_urban_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_cultural/,,$(basename $@)).geojson


# 50m physical

zips/50m_physical/ne_50m_antarctic_ice_shelves_lines.zip: 50m_physical/ne_50m_antarctic_ice_shelves_lines.shp 50m_physical/ne_50m_antarctic_ice_shelves_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_antarctic_ice_shelves_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_antarctic_ice_shelves_polys.zip: 50m_physical/ne_50m_antarctic_ice_shelves_polys.shp 50m_physical/ne_50m_antarctic_ice_shelves_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-antarctic-ice-shelves/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_antarctic_ice_shelves_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_coastline.zip: 50m_physical/ne_50m_coastline.shp 50m_physical/ne_50m_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-coastline/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_coastline$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_geographic_lines.zip: 50m_physical/ne_50m_geographic_lines.shp 50m_physical/ne_50m_geographic_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-geographic-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geographic_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_geography_marine_polys.zip: 50m_physical/ne_50m_geography_marine_polys.shp 50m_physical/ne_50m_geography_marine_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_marine_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_geography_regions_elevation_points.zip: 50m_physical/ne_50m_geography_regions_elevation_points.shp 50m_physical/ne_50m_geography_regions_elevation_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_regions_elevation_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_geography_regions_points.zip: 50m_physical/ne_50m_geography_regions_points.shp 50m_physical/ne_50m_geography_regions_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_regions_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_geography_regions_polys.zip: 50m_physical/ne_50m_geography_regions_polys.shp 50m_physical/ne_50m_geography_regions_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_geography_regions_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_glaciated_areas.zip: 50m_physical/ne_50m_glaciated_areas.shp 50m_physical/ne_50m_glaciated_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-glaciated-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_glaciated_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_lakes_historic.zip: 50m_physical/ne_50m_lakes_historic.shp 50m_physical/ne_50m_lakes_historic.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-lakes-reservoirs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_lakes_historic$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_lakes.zip: 50m_physical/ne_50m_lakes.shp 50m_physical/ne_50m_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-lakes-reservoirs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_land.zip: 50m_physical/ne_50m_land.shp 50m_physical/ne_50m_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_land$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_ocean.zip: 50m_physical/ne_50m_ocean.shp 50m_physical/ne_50m_ocean.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_ocean$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_playas.zip: 50m_physical/ne_50m_playas.shp 50m_physical/ne_50m_playas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-playas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_playas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.zip: 50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.shp 50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_rivers_lake_centerlines_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_rivers_lake_centerlines.zip: 50m_physical/ne_50m_rivers_lake_centerlines.shp 50m_physical/ne_50m_rivers_lake_centerlines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_50m_rivers_lake_centerlines$(VERSION_PREFIXED).zip
	#ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
	#	| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_graticules_5.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_5.*
	cp $@ archive/ne_50m_graticules_5$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_graticules_10.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_10.*
	cp $@ archive/ne_50m_graticules_10$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_graticules_15.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_15.*
	cp $@ archive/ne_50m_graticules_15$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_graticules_20.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_20.*
	cp $@ archive/ne_50m_graticules_20$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_graticules_30.zip: 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.shp 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_graticules_30.*
	cp $@ archive/ne_50m_graticules_30$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson

zips/50m_physical/ne_50m_wgs84_bounding_box.zip: 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.shp 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.dbf
	cp VERSION 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-graticules/ > 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.README.html
	zip -j -r $@ 50m_physical/ne_50m_graticules_all/ne_50m_wgs84_bounding_box.*
	cp $@ archive/ne_50m_wgs84_bounding_box$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 50m_physical/ne_50m_graticules_all/$(subst zips/50m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/50m_physical/,,$(basename $@)).geojson


# 110m cultural

zips/110m_cultural/ne_110m_admin_0_countries.zip: 110m_cultural/ne_110m_admin_0_countries.shp 110m_cultural/ne_110m_admin_0_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_countries$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_countries_lakes.zip: 110m_cultural/ne_110m_admin_0_countries_lakes.shp 110m_cultural/ne_110m_admin_0_countries_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_countries_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_boundary_lines_land.zip: 110m_cultural/ne_110m_admin_0_boundary_lines_land.shp 110m_cultural/ne_110m_admin_0_boundary_lines_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_boundary_lines_land$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_pacific_groupings.zip: 110m_cultural/ne_110m_admin_0_pacific_groupings.shp 110m_cultural/ne_110m_admin_0_pacific_groupings.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-boundary-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_pacific_groupings$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_map_units.zip: 110m_cultural/ne_110m_admin_0_map_units.shp 110m_cultural/ne_110m_admin_0_map_units.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_map_units$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_scale_rank.zip: 110m_cultural/ne_110m_admin_0_scale_rank.shp 110m_cultural/ne_110m_admin_0_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_sovereignty.zip: 110m_cultural/ne_110m_admin_0_sovereignty.shp 110m_cultural/ne_110m_admin_0_sovereignty.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_sovereignty$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_0_tiny_countries.zip: 110m_cultural/ne_110m_admin_0_tiny_countries.shp 110m_cultural/ne_110m_admin_0_tiny_countries.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-details/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_0_tiny_countries$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_1_states_provinces.zip: 110m_cultural/ne_110m_admin_1_states_provinces.shp 110m_cultural/ne_110m_admin_1_states_provinces.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_1_states_provinces_lakes.zip: 110m_cultural/ne_110m_admin_1_states_provinces_lakes.shp 110m_cultural/ne_110m_admin_1_states_provinces_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_1_states_provinces_scale_rank.zip: 110m_cultural/ne_110m_admin_1_states_provinces_scale_rank.shp 110m_cultural/ne_110m_admin_1_states_provinces_scale_rank.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_scale_rank$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_admin_1_states_provinces_lines.zip: 110m_cultural/ne_110m_admin_1_states_provinces_lines.shp 110m_cultural/ne_110m_admin_1_states_provinces_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-1-states-provinces/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_admin_1_states_provinces_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_populated_places.zip: 110m_cultural/ne_110m_populated_places.shp 110m_cultural/ne_110m_populated_places.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_populated_places$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson

zips/110m_cultural/ne_110m_populated_places_simple.zip: 110m_cultural/ne_110m_populated_places_simple.shp 110m_cultural/ne_110m_populated_places_simple.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-populated-places/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_populated_places_simple$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_cultural/,,$(basename $@)).geojson


# 110m physical

zips/110m_physical/ne_110m_coastline.zip: 110m_physical/ne_110m_coastline.shp 110m_physical/ne_110m_coastline.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-coastline/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_coastline$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_geographic_lines.zip: 110m_physical/ne_110m_geographic_lines.shp 110m_physical/ne_110m_geographic_lines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-geographic-lines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geographic_lines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_geography_marine_polys.zip: 110m_physical/ne_110m_geography_marine_polys.shp 110m_physical/ne_110m_geography_marine_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_marine_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_geography_regions_elevation_points.zip: 110m_physical/ne_110m_geography_regions_elevation_points.shp 110m_physical/ne_110m_geography_regions_elevation_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_regions_elevation_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_geography_regions_points.zip: 110m_physical/ne_110m_geography_regions_points.shp 110m_physical/ne_110m_geography_regions_points.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_regions_points$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_geography_regions_polys.zip: 110m_physical/ne_110m_geography_regions_polys.shp 110m_physical/ne_110m_geography_regions_polys.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-physical-labels/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_geography_regions_polys$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_glaciated_areas.zip: 110m_physical/ne_110m_glaciated_areas.shp 110m_physical/ne_110m_glaciated_areas.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-glaciated-areas/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_glaciated_areas$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_lakes.zip: 110m_physical/ne_110m_lakes.shp 110m_physical/ne_110m_lakes.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110mlakes-reservoirs/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_lakes$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_land.zip: 110m_physical/ne_110m_land.shp 110m_physical/ne_110m_land.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-land/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_land$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_ocean.zip: 110m_physical/ne_110m_ocean.shp 110m_physical/ne_110m_ocean.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-ocean/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_ocean$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_rivers_lake_centerlines.zip: 110m_physical/ne_110m_rivers_lake_centerlines.shp 110m_physical/ne_110m_rivers_lake_centerlines.dbf
	cp VERSION $(subst zips/, ,$(basename $@)).VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-rivers-lake-centerlines/ > $(subst zips/, ,$(basename $@)).README.html
	zip -j -r $@ $(subst zips/, ,$(basename $@)).*
	cp $@ archive/ne_110m_rivers_lake_centerlines$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout $(subst zips/, ,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

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
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_graticules_5.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_5.*
	cp $@ archive/ne_110m_graticules_5$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_graticules_10.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_10.*
	cp $@ archive/ne_110m_graticules_10$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_graticules_15.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_15.*
	cp $@ archive/ne_110m_graticules_15$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_graticules_20.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_20.*
	cp $@ archive/ne_110m_graticules_20$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_graticules_30.zip: 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.shp 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_graticules_30.*
	cp $@ archive/ne_110m_graticules_30$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson

zips/110m_physical/ne_110m_wgs84_bounding_box.zip: 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.shp 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.dbf
	cp VERSION 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.VERSION.txt
	curl http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/ > 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.README.html
	zip -j -r $@ 110m_physical/ne_110m_graticules_all/ne_110m_wgs84_bounding_box.*
	cp $@ archive/ne_110m_wgs84_bounding_box$(VERSION_PREFIXED).zip
	ogr2ogr -f GeoJSON -lco COORDINATE_PRECISION=6 -lco WRITE_BBOX=YES /dev/stdout 110m_physical/ne_110m_graticules_all/$(subst zips/110m_physical/,,$(basename $@)).shp \
		| jq -c . > geojson/$(subst zips/110m_physical/,,$(basename $@)).geojson


# PACKAGES

# copy the master assets into position for 10m_cultural:
packages/Natural_Earth_quick_start/10m_cultural/status.txt: \
	10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.dbf \
	10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.shp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.dbf \
	10m_cultural/ne_10m_admin_0_boundary_lines_land.shp 10m_cultural/ne_10m_admin_0_boundary_lines_land.dbf \
	10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.shp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.dbf \
	10m_cultural/ne_10m_admin_0_boundary_lines_map_units.shp 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.dbf \
	10m_cultural/ne_10m_admin_0_countries.shp 10m_cultural/ne_10m_admin_0_countries.dbf \
	10m_cultural/ne_10m_admin_0_disputed_areas.shp 10m_cultural/ne_10m_admin_0_disputed_areas.dbf \
	10m_cultural/ne_10m_admin_0_map_subunits.shp 10m_cultural/ne_10m_admin_0_map_subunits.dbf \
	10m_cultural/ne_10m_admin_0_map_units.shp 10m_cultural/ne_10m_admin_0_map_units.dbf \
	10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.shp 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.dbf \
	10m_cultural/ne_10m_admin_1_states_provinces_lines.shp 10m_cultural/ne_10m_admin_1_states_provinces_lines.dbf \
	10m_cultural/ne_10m_admin_1_states_provinces.shp 10m_cultural/ne_10m_admin_1_states_provinces.dbf \
	10m_cultural/ne_10m_admin_1_states_provinces_lakes.shp 10m_cultural/ne_10m_admin_1_states_provinces_lakes.dbf \
	10m_cultural/ne_10m_admin_2_counties_lines.shp 10m_cultural/ne_10m_admin_2_counties_lines.dbf \
	10m_cultural/ne_10m_admin_2_counties_lakes.shp 10m_cultural/ne_10m_admin_2_counties_lakes.dbf \
	10m_cultural/ne_10m_populated_places.shp 10m_cultural/ne_10m_populated_places.dbf \
	10m_cultural/ne_10m_urban_areas.shp 10m_cultural/ne_10m_urban_areas.dbf \
	10m_cultural/ne_10m_parks_and_protected_lands_area.shp 10m_cultural/ne_10m_parks_and_protected_lands_area.dbf \
	10m_cultural/ne_10m_parks_and_protected_lands_line.shp 10m_cultural/ne_10m_parks_and_protected_lands_line.dbf \
	10m_cultural/ne_10m_parks_and_protected_lands_point.shp 10m_cultural/ne_10m_parks_and_protected_lands_point.dbf \
	10m_cultural/ne_10m_roads.shp 10m_cultural/ne_10m_roads.dbf

	mkdir -p packages/Natural_Earth_quick_start/10m_cultural

	cp 10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_land.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_maritime_indicator_chn.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_boundary_lines_map_units.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_countries.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_disputed_areas.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_map_subunits.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_map_units.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_0_scale_rank_minor_islands.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_1_states_provinces_lines.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_1_states_provinces.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_1_states_provinces_lakes.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_2_counties_lines.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_admin_2_counties_lakes.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_populated_places.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_urban_areas.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_parks_and_protected_lands_area.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_parks_and_protected_lands_line.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_parks_and_protected_lands_point.* packages/Natural_Earth_quick_start/10m_cultural/
	cp 10m_cultural/ne_10m_roads.* packages/Natural_Earth_quick_start/10m_cultural/

	touch $@

# copy the master assets into position for 10m_physical:
packages/Natural_Earth_quick_start/10m_physical/status.txt: \
	10m_physical/ne_10m_coastline.shp 10m_physical/ne_10m_coastline.dbf \
	10m_physical/ne_10m_antarctic_ice_shelves_lines.shp 10m_physical/ne_10m_antarctic_ice_shelves_lines.dbf \
	10m_physical/ne_10m_antarctic_ice_shelves_polys.shp 10m_physical/ne_10m_antarctic_ice_shelves_polys.dbf \
	10m_physical/ne_10m_geography_marine_polys.shp 10m_physical/ne_10m_geography_marine_polys.dbf \
	10m_physical/ne_10m_geography_regions_elevation_points.shp 10m_physical/ne_10m_geography_regions_elevation_points.dbf \
	10m_physical/ne_10m_geography_regions_points.shp 10m_physical/ne_10m_geography_regions_points.dbf \
	10m_physical/ne_10m_geography_regions_polys.shp 10m_physical/ne_10m_geography_regions_polys.dbf \
	10m_physical/ne_10m_geographic_lines.shp 10m_physical/ne_10m_geographic_lines.dbf \
	10m_physical/ne_10m_glaciated_areas.shp 10m_physical/ne_10m_glaciated_areas.dbf \
	10m_physical/ne_10m_lakes.shp 10m_physical/ne_10m_lakes.dbf \
	10m_physical/ne_10m_lakes_europe.shp 10m_physical/ne_10m_lakes_europe.dbf \
	10m_physical/ne_10m_lakes_historic.shp 10m_physical/ne_10m_lakes_historic.dbf \
	10m_physical/ne_10m_lakes_north_america.shp 10m_physical/ne_10m_lakes_north_america.dbf \
	10m_physical/ne_10m_lakes_australia.shp 10m_physical/ne_10m_lakes_australia.dbf \
	10m_physical/ne_10m_ocean.shp 10m_physical/ne_10m_ocean.dbf \
	10m_physical/ne_10m_ocean_scale_rank.shp 10m_physical/ne_10m_ocean_scale_rank.dbf \
	10m_physical/ne_10m_minor_islands.shp 10m_physical/ne_10m_minor_islands.dbf \
	10m_physical/ne_10m_minor_islands_coastline.shp 10m_physical/ne_10m_minor_islands_coastline.dbf \
	10m_physical/ne_10m_land_scale_rank.shp 10m_physical/ne_10m_land_scale_rank.dbf \
	10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.dbf \
	10m_physical/ne_10m_rivers_lake_centerlines.shp 10m_physical/ne_10m_rivers_lake_centerlines.dbf \
	10m_physical/ne_10m_rivers_europe.shp 10m_physical/ne_10m_rivers_europe.dbf \
	10m_physical/ne_10m_rivers_north_america.shp 10m_physical/ne_10m_rivers_north_america.dbf \
	10m_physical/ne_10m_rivers_australia.shp 10m_physical/ne_10m_rivers_australia.dbf \
	10m_physical/ne_10m_playas.shp 10m_physical/ne_10m_playas.dbf \
	10m_physical/ne_10m_reefs.shp 10m_physical/ne_10m_reefs.dbf \

	mkdir -p packages/Natural_Earth_quick_start/10m_physical

	cp 10m_physical/ne_10m_coastline.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_antarctic_ice_shelves_lines.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_antarctic_ice_shelves_polys.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_marine_polys.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_regions_elevation_points.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_regions_points.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geography_regions_polys.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_geographic_lines.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_glaciated_areas.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_lakes.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_lakes_europe.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_lakes_historic.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_lakes_north_america.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_lakes_australia.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_minor_islands.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_minor_islands_coastline.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_ocean.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_ocean_scale_rank.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_land_scale_rank.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_lake_centerlines.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_europe.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_north_america.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_rivers_australia.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_playas.* packages/Natural_Earth_quick_start/10m_physical/
	cp 10m_physical/ne_10m_reefs.* packages/Natural_Earth_quick_start/10m_physical/

	touch $@

# TODO: get the raster from the other repo, which doesn't exist now.
packages/Natural_Earth_quick_start/50m_raster/status.txt:

	mkdir -p packages/Natural_Earth_quick_start/50m_raster
	rm -rf packages/Natural_Earth_quick_start/50m_raster/*
	curl -o packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip -L http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/raster/NE1_50M_SR_W.zip
	unzip packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip -d packages/Natural_Earth_quick_start/50m_raster/
	rm -f packages/Natural_Earth_quick_start/50m_raster/NE1_50M_SR_W.zip

	touch $@

# copy the master assets into position for 50m_cultural:
packages/Natural_Earth_quick_start/50m_cultural/status.txt: \
	50m_cultural/ne_50m_admin_0_boundary_lines_land.shp 50m_cultural/ne_50m_admin_0_boundary_lines_land.dbf \
	50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.shp 50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.dbf \
	50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.shp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.dbf \
	50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.shp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.dbf \
	50m_cultural/ne_50m_admin_0_boundary_map_units.shp 50m_cultural/ne_50m_admin_0_boundary_map_units.dbf \
	50m_cultural/ne_50m_admin_0_countries.shp 50m_cultural/ne_50m_admin_0_countries.dbf \
	50m_cultural/ne_50m_admin_0_map_subunits.shp 50m_cultural/ne_50m_admin_0_map_subunits.dbf \
	50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.shp 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.dbf \
	50m_cultural/ne_50m_admin_1_states_provinces_lakes.shp 50m_cultural/ne_50m_admin_1_states_provinces_lakes.dbf \
	50m_cultural/ne_50m_admin_1_states_provinces_lines.shp 50m_cultural/ne_50m_admin_1_states_provinces_lines.dbf \
	50m_cultural/ne_50m_populated_places.shp 50m_cultural/ne_50m_populated_places.dbf \
	50m_cultural/ne_50m_urban_areas.shp 50m_cultural/ne_50m_urban_areas.dbf

	mkdir -p packages/Natural_Earth_quick_start/50m_cultural

	cp 50m_cultural/ne_50m_admin_0_boundary_lines_land.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_boundary_lines_disputed_areas.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_boundary_lines_maritime_indicator_chn.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_boundary_map_units.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_countries.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_map_subunits.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_0_breakaway_disputed_areas.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_1_states_provinces_lakes.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_admin_1_states_provinces_lines.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_urban_areas.* packages/Natural_Earth_quick_start/50m_cultural/
	cp 50m_cultural/ne_50m_populated_places.* packages/Natural_Earth_quick_start/50m_cultural/

	touch $@

# copy the master assets into position for 50m_physical:
packages/Natural_Earth_quick_start/50m_physical/status.txt: \
	50m_physical/ne_50m_coastline.shp 50m_physical/ne_50m_coastline.dbf \
	50m_physical/ne_50m_glaciated_areas.shp 50m_physical/ne_50m_glaciated_areas.dbf \
	50m_physical/ne_50m_antarctic_ice_shelves_lines.shp 50m_physical/ne_50m_antarctic_ice_shelves_lines.dbf \
	50m_physical/ne_50m_antarctic_ice_shelves_polys.shp 50m_physical/ne_50m_antarctic_ice_shelves_polys.dbf \
	50m_physical/ne_50m_geographic_lines.shp 50m_physical/ne_50m_geographic_lines.dbf \
	50m_physical/ne_50m_geography_marine_polys.shp 50m_physical/ne_50m_geography_marine_polys.dbf \
	50m_physical/ne_50m_geography_regions_elevation_points.shp 50m_physical/ne_50m_geography_regions_elevation_points.dbf \
	50m_physical/ne_50m_geography_regions_polys.shp 50m_physical/ne_50m_geography_regions_polys.dbf \
	50m_physical/ne_50m_lakes.shp 50m_physical/ne_50m_lakes.dbf \
	50m_physical/ne_50m_land.shp 50m_physical/ne_50m_land.dbf \
	50m_physical/ne_50m_ocean.shp 50m_physical/ne_50m_ocean.dbf \
	50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.shp 50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.dbf \

	mkdir -p packages/Natural_Earth_quick_start/50m_physical

	cp 50m_physical/ne_50m_coastline.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_glaciated_areas.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_antarctic_ice_shelves_lines.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_antarctic_ice_shelves_polys.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_geographic_lines.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_geography_marine_polys.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_geography_regions_elevation_points.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_geography_regions_polys.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_lakes.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_land.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_ocean.* packages/Natural_Earth_quick_start/50m_physical/
	cp 50m_physical/ne_50m_rivers_lake_centerlines_scale_rank.* packages/Natural_Earth_quick_start/50m_physical/

	touch $@

# copy the master assets into position for 110m_cultural:
packages/Natural_Earth_quick_start/110m_cultural/status.txt: \
	110m_cultural/ne_110m_admin_0_boundary_lines_land.shp 110m_cultural/ne_110m_admin_0_boundary_lines_land.dbf \
	110m_cultural/ne_110m_admin_0_countries.shp 110m_cultural/ne_110m_admin_0_countries.dbf \
	110m_cultural/ne_110m_admin_0_pacific_groupings.shp 110m_cultural/ne_110m_admin_0_pacific_groupings.dbf \
	110m_cultural/ne_110m_admin_0_tiny_countries.shp 110m_cultural/ne_110m_admin_0_tiny_countries.dbf \
	110m_cultural/ne_110m_admin_1_states_provinces.shp 110m_cultural/ne_110m_admin_1_states_provinces.dbf \
	110m_cultural/ne_110m_admin_1_states_provinces_lines.shp 110m_cultural/ne_110m_admin_1_states_provinces_lines.dbf \
	110m_cultural/ne_110m_populated_places.shp 110m_cultural/ne_110m_populated_places.dbf

	mkdir -p packages/Natural_Earth_quick_start/110m_cultural

	cp 110m_cultural/ne_110m_admin_0_boundary_lines_land.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_0_countries.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_0_pacific_groupings.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_0_tiny_countries.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_1_states_provinces.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_admin_1_states_provinces_lines.* packages/Natural_Earth_quick_start/110m_cultural/
	cp 110m_cultural/ne_110m_populated_places.* packages/Natural_Earth_quick_start/110m_cultural/

	touch $@

# copy the master assets into position for 110m_physical:
packages/Natural_Earth_quick_start/110m_physical/status.txt: \
	110m_physical/ne_110m_coastline.shp 110m_physical/ne_110m_coastline.dbf \
	110m_physical/ne_110m_geography_marine_polys.shp 110m_physical/ne_110m_geography_marine_polys.dbf \
	110m_physical/ne_110m_geography_regions_points.shp 110m_physical/ne_110m_geography_regions_points.dbf \
	110m_physical/ne_110m_geography_regions_polys.shp 110m_physical/ne_110m_geography_regions_polys.dbf \
	110m_physical/ne_110m_lakes.shp 110m_physical/ne_110m_lakes.dbf \
	110m_physical/ne_110m_ocean.shp 110m_physical/ne_110m_ocean.dbf \
	110m_physical/ne_110m_land.shp 110m_physical/ne_110m_land.dbf \
	110m_physical/ne_110m_rivers_lake_centerlines.shp 110m_physical/ne_110m_rivers_lake_centerlines.dbf \
	110m_physical/ne_110m_glaciated_areas.shp 110m_physical/ne_110m_glaciated_areas.dbf

	mkdir -p packages/Natural_Earth_quick_start/110m_physical

	cp 110m_physical/ne_110m_coastline.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_geography_marine_polys.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_geography_regions_points.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_geography_regions_polys.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_lakes.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_ocean.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_land.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_rivers_lake_centerlines.* packages/Natural_Earth_quick_start/110m_physical/
	cp 110m_physical/ne_110m_glaciated_areas.* packages/Natural_Earth_quick_start/110m_physical/

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

live_ne: \
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
	zips/live-110m_physical_ne

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
