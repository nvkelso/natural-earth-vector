#About

We need to generate a graticule that will project cleanly (with smooth arcs) at world scale. The graticule should have a dense distribution of internal nodes along it's line, especially along the ±180, ±90 WGS84 bounding box.

Uses [pygraticule](https://github.com/nvkelso/pyGraticule) (embedded here) by **Alex Mandel** with modifications by Nathaniel Vaughn KELSO. 

#Usage

The included Makefile should be run as:

    make clean

followed by 

    make all

Behind the scenes, it's running commands like: 

    python pygraticule.py -g 1 -o outfile.geojson

Once the GeoJSON versions are created, the Makefile uses OGR/GDAL (assumes that's installed) to convert to SHP format and then package up into ZIP folders.

## Examples

When we project out of WGS84 to another coordinate system that is not cylindrical, we need to have enough intermediate nodes
on the paths so the GIS application shows a "curve". Most GIS do not auto-densify stright lines during the projection
so we need to add these extra nodes in the raw geodata.

Here we see Robinson using enough nodes:

![Zoom previews](https://github.com/nvkelso/pygraticule/raw/master/images/robinson.png)

Box results when nodes are sparse:

![Zoom previews](https://github.com/nvkelso/pygraticule/raw/master/images/box_no_densification.png)

The two superimposed:

![Zoom previews](https://github.com/nvkelso/pygraticule/raw/master/images/robinson_plus_box.png)

The proj4 string for Robinson is:
`+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs`
