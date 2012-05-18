all: 10m_land.zip 50m_land.zip 110m_land.zip \
	 10m_lakes.zip 50m_lakes.zip 110m_lakes.zip \
	 10m_admin_0_countries.zip 50m_admin_0_countries.zip 110m_admin_0_countries.zip

10m_land.zip: 10m_physical/ne_10m_land.shp
	./zip-it.sh 10m_physical/ne_10m_land.shp $@ 1>/dev/null 2>&1

50m_land.zip: 50m_physical/ne_50m_land.shp
	./zip-it.sh 50m_physical/ne_50m_land.shp $@ 1>/dev/null 2>&1

110m_land.zip: 110m_physical/ne_110m_land.shp
	./zip-it.sh 110m_physical/ne_110m_land.shp $@ 1>/dev/null 2>&1

10m_lakes.zip: 10m_physical/ne_10m_lakes.shp
	./zip-it.sh 10m_physical/ne_10m_lakes.shp $@ 1>/dev/null 2>&1

50m_lakes.zip: 50m_physical/ne_50m_lakes.shp
	./zip-it.sh 50m_physical/ne_50m_lakes.shp $@ 1>/dev/null 2>&1

110m_lakes.zip: 110m_physical/ne_110m_lakes.shp
	./zip-it.sh 110m_physical/ne_110m_lakes.shp $@ 1>/dev/null 2>&1

10m_admin_0_countries.zip: 10m_cultural/ne_10m_admin_0_countries.shp
	./zip-it.sh 10m_cultural/ne_10m_admin_0_countries.shp $@ 1>/dev/null 2>&1

50m_admin_0_countries.zip: 50m_cultural/ne_50m_admin_0_countries.shp
	./zip-it.sh 50m_cultural/ne_50m_admin_0_countries.shp $@ 1>/dev/null 2>&1

110m_admin_0_countries.zip: 110m_cultural/ne_110m_admin_0_countries.shp
	./zip-it.sh 110m_cultural/ne_110m_admin_0_countries.shp $@ 1>/dev/null 2>&1

clean:
	rm -f 10m_land.zip
	rm -f 50m_land.zip
	rm -f 110m_land.zip
	rm -f 10m_lakes.zip
	rm -f 50m_lakes.zip
	rm -f 110m_lakes.zip
	rm -f 10m_admin_0_countries.zip
	rm -f 50m_admin_0_countries.zip
	rm -f 110m_admin_0_countries.zip
