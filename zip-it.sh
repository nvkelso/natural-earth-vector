#!/bin/sh

SOURCE=$1
ZIPFILE=$2
BASE=${ZIPFILE%.zip}

# Spherical mercator extent and projection,
# http://proj.maptools.org/faq.html#sphere_as_wgs84

EXTENT="-180 -85.05112878 180 85.05112878"
P900913="+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"

ogr2ogr --config OGR_ENABLE_PARTIAL_REPROJECTION TRUE -t_srs "$P900913" -clipsrc $EXTENT -segmentize 1 -skipfailures $BASE.shp $SOURCE

ogrinfo -so $BASE.shp $BASE | tail -n +4 > info.txt
shapeindex $BASE.shp
zip -j $ZIPFILE $BASE.dbf $BASE.index $BASE.prj $BASE.shp $BASE.shx info.txt
rm -f $BASE.dbf $BASE.index $BASE.prj $BASE.shp $BASE.shx info.txt
