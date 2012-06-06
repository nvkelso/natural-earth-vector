all: ne_10m_populated_places_simple.shp \
	ne_50m_populated_places_simple.shp \
	ne_110m_populated_places_simple.shp \ 
	ne_50m_populated_places.shp \
	ne_110m_populated_places.shp \ 
	ne_50m_airports.shp \
	ne_50m_ports.shp


# POPULATED PLACES

#10m simple- populated places
ne_10m_populated_places_simple.shp:
	ogr2ogr -overwrite -sql "SELECT SCALERANK, NATSCALE, LABELRANK, FEATURECLA, NAME, NAMEPAR, NAMEALT, DIFFASCII, NAMEASCII, ADM0CAP, CAPALT, CAPIN, WORLDCITY, MEGACITY, SOV0NAME, SOV_A3, ADM0NAME, ADM0_A3, ADM1NAME, ISO_A2, NOTE, LATITUDE, LONGITUDE, CHANGED, NAMEDIFF, DIFFNOTE, POP_MAX, POP_MIN, POP_OTHER, GEONAMEID, MEGANAME, LS_NAME, LS_MATCH, CHECKME FROM ne_10m_populated_places WHERE natlscale >= 5 ORDER BY natlscale" ne_10m_populated_places_simple.shp ne_10m_populated_places.shp


#50m full - populated places
ne_50m_populated_places.shp:
	# “SCALERANK” <= 4 Or "FEATURECLA" = 'Admin-0 capital' Or "FEATURECLA" = 'Admin-0 capital alt' Or "FEATURECLA" = 'Admin-0 region capital' Or "FEATURECLA" = 'Admin-1 region capital' Or "FEATURECLA" = 'Scientific station'	
	ogr2ogr -overwrite -sql "SELECT * FROM ne_10m_populated_places WHERE natlscale >= 5 ORDER BY natlscale" ne_50m_populated_places.shp ne_10m_populated_places.shp

ne_50m_populated_places_simple.shp:
	#50m simple - populated places
	ogr2ogr -overwrite -sql "SELECT SCALERANK, NATSCALE, LABELRANK, FEATURECLA, NAME, NAMEPAR, NAMEALT, DIFFASCII, NAMEASCII, ADM0CAP, CAPALT, CAPIN, WORLDCITY, MEGACITY, SOV0NAME, SOV_A3, ADM0NAME, ADM0_A3, ADM1NAME, ISO_A2, NOTE, LATITUDE, LONGITUDE, CHANGED, NAMEDIFF, DIFFNOTE, POP_MAX, POP_MIN, POP_OTHER, GEONAMEID, MEGANAME, LS_NAME, LS_MATCH, CHECKME FROM ne_10m_populated_places WHERE natlscale >= 5 ORDER BY natlscale" ne_50m_populated_places_simple.shp ne_10m_populated_places.shp


#110m full - populated places
ne_110m_populated_places.shp:
	# “SCALERANK” <= 1 Or "FEATURECLA" = 'Admin-0 capital' Or "FEATURECLA" = 'Admin-0 capital alt'
	ogr2ogr -overwrite -sql "SELECT * FROM ne_10m_populated_places WHERE natlscale >= 5 ORDER BY natlscale" ne_110m_populated_places.shp ne_10m_populated_places.shp

ne_110m_populated_places.shp:
	#110m simple - populated places
	ogr2ogr -overwrite -sql "SELECT SCALERANK, NATSCALE, LABELRANK, FEATURECLA, NAME, NAMEPAR, NAMEALT, DIFFASCII, NAMEASCII, ADM0CAP, CAPALT, CAPIN, WORLDCITY, MEGACITY, SOV0NAME, SOV_A3, ADM0NAME, ADM0_A3, ADM1NAME, ISO_A2, NOTE, LATITUDE, LONGITUDE, CHANGED, NAMEDIFF, DIFFNOTE, POP_MAX, POP_MIN, POP_OTHER, GEONAMEID, MEGANAME, LS_NAME, LS_MATCH, CHECKME FROM ne_10m_populated_places WHERE natlscale >= 5 ORDER BY natlscale" ne_110m_populated_places_simple.shp ne_10m_populated_places.shp



# AIRPORTS

#50m airports
ne_50m_airports.shp:
	ogr2ogr -overwrite -sql "SELECT * FROM ne_50m_airports WHERE SCALERANK <= 4 ORDER BY SCALERANK" ne_50m_airports.shp ne_10m_airports.shp


# PORTS

#50m ports
ne_50m_ports.shp:
	ogr2ogr -overwrite -sql "SELECT * FROM ne_50m_ports WHERE SCALERANK <= 4 ORDER BY SCALERANK" ne_50m_ports.shp ne_10m_ports.shp


clean: 
	 rm -f ne_50m_populated_places.*
	 rm -f ne_110m_populated_places.*
	 rm -f ne_10m_populated_places_simple.*
	 rm -f ne_50m_populated_places_simple.*
	 rm -f ne_110m_populated_places_simple.*
	 rm -f ne_50m_airports.{shp, dbf, shx, prj}
	 rm -f ne_50m_ports.shp ne_50m_ports.dbf ne_50m_ports.shx ne_50m_ports.prj