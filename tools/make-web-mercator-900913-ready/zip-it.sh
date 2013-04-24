#!/bin/sh

shapefile=$1
zipfile=$2
base=${zipfile%.zip}

# Spherical mercator extent and projection,
# http://proj.maptools.org/faq.html#sphere_as_wgs84
#
EXTENT="-180 -85.05112878 180 85.05112878"
P900913="+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"

# Use http://trac.osgeo.org/gdal/wiki/ConfigOptions#OGR_ENABLE_PARTIAL_REPROJECTION
# and clip source to include only data within spherical mercator world square.
# Encoding conversion will *only work* as of GDAL 1.9.x.
#
ogr2ogr \
    --config OGR_ENABLE_PARTIAL_REPROJECTION TRUE --config SHAPE_ENCODING WINDOWS-1252 \
    -t_srs "$P900913" -lco ENCODING=UTF-8 -clipsrc $EXTENT -segmentize 1 -skipfailures \
    $base.shp $shapefile

# Index the shapefile for Mapnik
# https://github.com/mapnik/mapnik/tree/master/utils/shapeindex
# Install shapeindex:
# sudo apt-get install mapnik-utils
shapeindex $base.shp

ogrinfo -so $base.shp $base | tail -n +4 > info.txt
zip -j $zipfile $base.dbf $base.index $base.prj $base.shp $base.shx info.txt
rm -f $base.dbf $base.index $base.prj $base.shp $base.shx $base.cpg info.txt
