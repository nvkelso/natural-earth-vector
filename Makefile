zips: land_10m.zip land_50m.zip land_110m.zip \
	  lakes_10m.zip lakes_50m.zip lakes_110m.zip \
	  admin_0_countries_10m.zip admin_0_countries_50m.zip admin_0_countries_110m.zip
	mkdir zips
	ln land_*m.zip zips/
	ln lakes_*m.zip zips/
	ln admin_0_countries_*m.zip zips/

land_10m.zip: 10m_physical/ne_10m_land.shp
	./zip-it.sh 10m_physical/ne_10m_land.shp $@ 1>/dev/null 2>&1

land_50m.zip: 50m_physical/ne_50m_land.shp
	./zip-it.sh 50m_physical/ne_50m_land.shp $@ 1>/dev/null 2>&1

land_110m.zip: 110m_physical/ne_110m_land.shp
	./zip-it.sh 110m_physical/ne_110m_land.shp $@ 1>/dev/null 2>&1

lakes_10m.zip: 10m_physical/ne_10m_lakes.shp
	./zip-it.sh 10m_physical/ne_10m_lakes.shp $@ 1>/dev/null 2>&1

lakes_50m.zip: 50m_physical/ne_50m_lakes.shp
	./zip-it.sh 50m_physical/ne_50m_lakes.shp $@ 1>/dev/null 2>&1

lakes_110m.zip: 110m_physical/ne_110m_lakes.shp
	./zip-it.sh 110m_physical/ne_110m_lakes.shp $@ 1>/dev/null 2>&1

admin_0_countries_10m.zip: 10m_cultural/ne_10m_admin_0_countries.shp
	./zip-it.sh 10m_cultural/ne_10m_admin_0_countries.shp $@ 1>/dev/null 2>&1

admin_0_countries_50m.zip: 50m_cultural/ne_50m_admin_0_countries.shp
	./zip-it.sh 50m_cultural/ne_50m_admin_0_countries.shp $@ 1>/dev/null 2>&1

admin_0_countries_110m.zip: 110m_cultural/ne_110m_admin_0_countries.shp
	./zip-it.sh 110m_cultural/ne_110m_admin_0_countries.shp $@ 1>/dev/null 2>&1

live: zips
	s3cmd -c s3.cfg --acl-public put zips/*.zip s3://cascadenik-data/ne/900913/

clean:
	rm -rf zips
	rm -f land_10m.zip
	rm -f land_50m.zip
	rm -f land_110m.zip
	rm -f lakes_10m.zip
	rm -f lakes_50m.zip
	rm -f lakes_110m.zip
	rm -f admin_0_countries_10m.zip
	rm -f admin_0_countries_50m.zip
	rm -f admin_0_countries_110m.zip
