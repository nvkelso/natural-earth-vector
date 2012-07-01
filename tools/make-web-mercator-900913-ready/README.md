Make Web Mercator 900913 Ready
==============================

Many tools, such as Cascadenik, understand that shapefiles can be found in same-named
zip archives. This tool packages Natural Earth data into a set of zip files and posts
them publicly to a Cascadenik-data S3 bucket, after reprojecting to web Mercator
(900913) and re-encoding all text from Windows-1252 to UTF-8.

This data could also be used with Mapnik in PostGIS, via shp2pgsql.

Data will be downloadable from [Cascadenik Data](http://cascadenik.teczno.com/index.html).
