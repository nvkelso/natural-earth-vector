all: 10m_cultural.zip \
	 10m_physical.zip \
	 50m_cultural.zip \
	 50m_physical.zip \
	 110m_cultural.zip \
	 110m_physical.zip \
	 ../zips/packages/natural_earth_vector.zip \
	 ../zips/packages/Natural_Earth_quick_start/Natural_Earth_quick_start.zip


10m_cultural.zip:
	python zip_dir_of_shps.py -i ../packages/Natural_Earth_quick_start/10m_cultural/ -o ../zips/10m_cultural


10m_physical.zip:
	python zip_dir_of_shps.py -i ../packages/Natural_Earth_quick_start/10m_physical/ -o ../zips/10m_physical


50m_cultural.zip:
	python zip_dir_of_shps.py -i ../packages/Natural_Earth_quick_start/50m_cultural -o ../zips/50m_cultural


50m_physical.zip:
	python zip_dir_of_shps.py -i ../packages/Natural_Earth_quick_start/50m_physical -o ../zips/50m_physical


110m_cultural.zip:
	python zip_dir_of_shps.py -i ../packages/Natural_Earth_quick_start/110m_cultural -o ../zips/110m_cultural


110m_physical.zip:
	python zip_dir_of_shps.py -i ../packages/Natural_Earth_quick_start/110m_physical -o ../zips/110m_physical


../zips/packages/natural_earth_vector.zip:
	zip -j -r ../zips/packages/natural_earth_vector.zip ../10m_cultural ../10m_physical ../50m_cultural ../50m_physical ../110m_cultural ../110m_physical
	
	
../zips/packages/Natural_Earth_quick_start/Natural_Earth_quick_start.zip: ../packages/Natural_Earth_quick_start/10m_cultural \
	../packages/Natural_Earth_quick_start/10m_physical \
	../packages/Natural_Earth_quick_start/50m_raster \
	../packages/Natural_Earth_quick_start/110m_cultural \
	../packages/Natural_Earth_quick_start/110m_physical

	zip -j -r ../zips/packages/Natural_Earth_quick_start.zip ../packages/Natural_Earth_quick_start/
	
	
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
	
	
../packages/Natural_Earth_quick_start/50m_raster:
	curl 50m_raster/NE1_50M_SR_W/NE1_50M_SR_W.tif
	
	
../packages/Natural_Earth_quick_start/110m_cultural:
	cp ../110m_cultural/110m_admin_0_boundary_lines_land.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural/110m_admin_0_countries.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_admin_0_pacific_groupings.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_admin_0_tiny_countries.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_admin_1_states_provinces_shp.* ../packages/Natural_Earth_quick_start/110m_cultural/
	cp ../110m_cultural110m_populated_places.* ../packages/Natural_Earth_quick_start/110m_cultural/
	
	
../packages/Natural_Earth_quick_start/110m_physical:
	cp ../110m_physical/110m_coastline.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_geography_marine_polys.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_geography_regions_points.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_geography_regions_polys.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_lakes.* ../packages/Natural_Earth_quick_start/110m_physical/
	cp ../110m_physical/110m_ocean.* ../packages/Natural_Earth_quick_start/110m_physical/
	
	
clean:
	mkdir -p ../zips/10m_cultural
	mkdir -p ../zips/10m_physical
	mkdir -p ../zips/50m_cultural
	mkdir -p ../zips/50m_physical
	mkdir -p ../zips/110m_cultural
	mkdir -p ../zips/110m_physical
	rm -rf ../zips/10m_cultural/*
	rm -rf ../zips/10m_physical/*
	rm -rf ../zips/50m_cultural/*
	rm -rf ../zips/50m_physical/*
	rm -rf ../zips/110m_cultural/*
	rm -rf ../zips/110m_physical/*
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