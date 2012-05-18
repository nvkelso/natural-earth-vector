EXTENT=-180 -85.05112878 180 85.05112878
P900913=+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs
OPTIONS=OGR_ENABLE_PARTIAL_REPROJECTION=TRUE
OGR2OGR=$(OPTIONS) ogr2ogr -t_srs "$(P900913)" -clipsrc $(EXTENT) -segmentize 1 -skipfailures

all: 10m_land.zip 50m_land.zip 110m_land.zip

10m_land.zip: 10m_physical/ne_10m_land.shp
	$(OGR2OGR) 10m_land.shp 10m_physical/ne_10m_land.shp
	ogrinfo -so 10m_land.shp 10m_land | tail -n +4 > info.txt
	shapeindex 10m_land.shp
	zip -j $@ 10m_land.dbf 10m_land.index 10m_land.prj 10m_land.shp 10m_land.shx info.txt
	rm -f 10m_land.dbf 10m_land.index 10m_land.prj 10m_land.shp 10m_land.shx info.txt

50m_land.zip: 50m_physical/ne_50m_land.shp
	$(OGR2OGR) 50m_land.shp 50m_physical/ne_50m_land.shp
	ogrinfo -so 50m_land.shp 50m_land | tail -n +4 > info.txt
	shapeindex 50m_land.shp
	zip -j $@ 50m_land.dbf 50m_land.index 50m_land.prj 50m_land.shp 50m_land.shx info.txt
	rm -f 50m_land.dbf 50m_land.index 50m_land.prj 50m_land.shp 50m_land.shx info.txt

110m_land.zip: 110m_physical/ne_110m_land.shp
	$(OGR2OGR) 110m_land.shp 110m_physical/ne_110m_land.shp
	ogrinfo -so 110m_land.shp 110m_land | tail -n +4 > info.txt
	shapeindex 110m_land.shp
	zip -j $@ 110m_land.dbf 110m_land.index 110m_land.prj 110m_land.shp 110m_land.shx info.txt
	rm -f 110m_land.dbf 110m_land.index 110m_land.prj 110m_land.shp 110m_land.shx info.txt

clean:
	rm -f 10m_land.zip
	rm -f 50m_land.zip
	rm -f 110m_land.zip
