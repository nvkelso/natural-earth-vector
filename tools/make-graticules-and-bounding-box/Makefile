SCALESET=10 50 110
SCALESET_PREFIX_GEOJSON=$(SCALESET:%=geojson/ne_%m_graticules_)
SCALESET_PREFIX_SHP=$(SCALESET:%=shp/ne_%m_graticules_)
SCALESET_PREFIX_ZIP=$(SCALESET:%=zip/ne_%m_graticules_)
GRATICULE=1 5 10 15 20 30

ALL_SCALESET_GRATICULES_GEOJSON=$(foreach SP,$(SCALESET_PREFIX_GEOJSON),$(addprefix $(SP),$(GRATICULE)))
ALL_SCALESET_GRATICULES_SHP=$(foreach SP,$(SCALESET_PREFIX_SHP),$(addprefix $(SP),$(GRATICULE)))
ALL_SCALESET_GRATICULES_ZIP=$(foreach SP,$(SCALESET_PREFIX_ZIP),$(addprefix $(SP),$(GRATICULE)))

test:
	@echo $(ALL_SCALESET_GRATICULES_GEOJSON)
	@echo $(ALL_SCALESET_GRATICULES_SHP)
	@echo $(ALL_SCALESET_GRATICULES_ZIP)
	@echo $(ALL_SCALESET_GRATICULES_SHP:%=%.zip)

all: geojson \
	shp \
	zip

geojson: geojson/ne_10m_graticules_1.geojson \
		 geojson/ne_10m_graticules_5.geojson \
		 geojson/ne_10m_graticules_10.geojson \
		 geojson/ne_10m_graticules_15.geojson \
		 geojson/ne_10m_graticules_20.geojson \
		 geojson/ne_10m_graticules_30.geojson \
		 geojson/ne_50m_graticules_1.geojson \
		 geojson/ne_50m_graticules_5.geojson \
		 geojson/ne_50m_graticules_10.geojson \
		 geojson/ne_50m_graticules_15.geojson \
		 geojson/ne_50m_graticules_20.geojson \
		 geojson/ne_50m_graticules_30.geojson \
		 geojson/ne_110m_graticules_1.geojson \
		 geojson/ne_110m_graticules_5.geojson \
		 geojson/ne_110m_graticules_10.geojson \
		 geojson/ne_110m_graticules_15.geojson \
		 geojson/ne_110m_graticules_20.geojson \
		 geojson/ne_110m_graticules_30.geojson


geojson/ne_10m_graticules_1.geojson:
	python pygraticule.py -g 1  -s 0.5 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":8'
	
geojson/ne_10m_graticules_5.geojson:
	python pygraticule.py -g 5  -s 0.5 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":7' 

geojson/ne_10m_graticules_10.geojson:
	python pygraticule.py -g 10 -s 0.5 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":6'

geojson/ne_10m_graticules_15.geojson:
	python pygraticule.py -g 15 -s 0.5 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":5'

geojson/ne_10m_graticules_20.geojson:
	python pygraticule.py -g 20 -s 0.5 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":4'

geojson/ne_10m_graticules_30.geojson:
	python pygraticule.py -g 30 -s 0.5 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":3'

geojson/ne_50m_graticules_1.geojson:
	python pygraticule.py -g 1  -s 2.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":8'

geojson/ne_50m_graticules_5.geojson:
	python pygraticule.py -g 5  -s 2.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":7'

geojson/ne_50m_graticules_10.geojson:
	python pygraticule.py -g 10 -s 2.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":6'

geojson/ne_50m_graticules_15.geojson:
	python pygraticule.py -g 15 -s 2.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":5'

geojson/ne_50m_graticules_20.geojson:
	python pygraticule.py -g 20 -s 2.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":4'

geojson/ne_50m_graticules_30.geojson:
	python pygraticule.py -g 30 -s 2.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":3'

geojson/ne_110m_graticules_1.geojson:
	python pygraticule.py -g 1  -s 4.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":8'

geojson/ne_110m_graticules_5.geojson:
	python pygraticule.py -g 5  -s 4.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":7'

geojson/ne_110m_graticules_10.geojson:
	python pygraticule.py -g 10 -s 4.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":6'

geojson/ne_110m_graticules_15.geojson:
	python pygraticule.py -g 15 -s 4.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":5'

geojson/ne_110m_graticules_20.geojson:
	python pygraticule.py -g 20 -s 4.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":4'

geojson/ne_110m_graticules_30.geojson:
	python pygraticule.py -g 30 -s 4.0 -o $@ -f '"FeatureCla":"Graticule","ScaleRank":3'


geojson/%.shp:
	ogr2ogr -f "ESRI Shapefile" -overwrite shp/$*.shp geojson/$*.geojson
	
bounding_box: 10m_wgs84_bounding_box.shp 
	ogr2ogr -segmentize 0.5 shp/ne_10m_wgs84_bounding_box.shp 10m_wgs84_bounding_box.shp 
	ogr2ogr -segmentize 2.0 shp/ne_50m_wgs84_bounding_box.shp 10m_wgs84_bounding_box.shp 
	ogr2ogr -segmentize 4.0 shp/ne_110m_wgs84_bounding_box.shp 10m_wgs84_bounding_box.shp 	
	
shp: $(ALL_SCALESET_GRATICULES_GEOJSON:%=%.shp) \
	bounding_box
	touch shp

zip/ne_10m_graticules_all.zip:
	mkdir -p shp/ne_10m_graticules_all
	cp shp/ne_10m_graticules_*.* shp/ne_10m_graticules_all
	cp shp/ne_10m_wgs84_bounding_box.* shp/ne_10m_graticules_all
	zip -j -r $@ shp/ne_10m_graticules_all

zip/ne_50m_graticules_all.zip:
	mkdir -p shp/ne_50m_graticules_all
	cp shp/ne_50m_graticules_*.* shp/ne_50m_graticules_all
	cp shp/ne_50m_wgs84_bounding_box.* shp/ne_50m_graticules_all
	zip -j -r $@ shp/ne_50m_graticules_all

zip/ne_110m_graticules_all.zip:
	mkdir -p shp/ne_110m_graticules_all
	cp shp/ne_110m_graticules_*.* shp/ne_110m_graticules_all
	cp shp/ne_110m_wgs84_bounding_box.* shp/ne_110m_graticules_all
	zip -j -r $@ shp/ne_110m_graticules_all

zip/%.zip:
	zip -j zip/$*.zip shp/$*.*

zip/ne_10m_wgs84_bounding_box.zip: shp/ne_10m_wgs84_bounding_box.shp
	zip -j zip/ne_10m_wgs84_bounding_box.zip shp/ne_10m_wgs84_bounding_box.*

zip/ne_50m_wgs84_bounding_box.zip: shp/ne_50m_wgs84_bounding_box.shp
	zip -j zip/ne_50m_wgs84_bounding_box.zip shp/ne_50m_wgs84_bounding_box.*

zip/ne_110m_wgs84_bounding_box.zip: shp/ne_110m_wgs84_bounding_box.shp
	zip -j zip/ne_110m_wgs84_bounding_box.zip shp/ne_110m_wgs84_bounding_box.*
	
ne_1d5_graticules_beta2.zip:
	zip -j -r $@ shp/ne_10m_graticules_all shp/ne_50m_graticules_all shp/ne_110m_graticules_all
	

zip: $(ALL_SCALESET_GRATICULES_ZIP:%=%.zip) \
	zip/ne_10m_graticules_all.zip \
	zip/ne_50m_graticules_all.zip \
	zip/ne_110m_graticules_all.zip \
	zip/ne_10m_wgs84_bounding_box.zip \
	zip/ne_50m_wgs84_bounding_box.zip \
	zip/ne_110m_wgs84_bounding_box.zip \
	ne_1d5_graticules_beta2.zip
	touch zip


clean:
	mkdir -p geojson
	mkdir -p shp
	mkdir -p zip
	rm -rf geojson/*
	rm -rf shp/*
	rm -rf zip/*