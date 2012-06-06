# By Alex Mandel Copyright 2012
# Modifications by Nathaniel Vaughn KELSO
#
# Script to generate a graticule that will reproject cleanly(smooth arcs) at world scale
# Output format is geojson, because it's easy to write as a text file python.
# Use ogr2ogr to convert to a SHP format "Esri Shapefile"
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

import sys, math
import os, stat
from optparse import OptionParser

parser = OptionParser(usage="""%prog [options]

Generates a GeoJSON file with graticules spaced at specified interval.""")

parser.add_option('-g', '--grid_interval', dest='grid_interval', default=1.0, type='float',
                  help='Grid interval in decimal degrees, defaults to 1.')

parser.add_option('-s', '--step_interval', dest='step_interval', default=0.5, type='float',
                  help='Step interval in decimal degrees, defaults to 0.5.')

parser.add_option('-o', dest='outfilename', default='',
                  help='Output filename (with or without path), defaults to "graticule_1dd.geojson".')

parser.add_option('-f', dest='field_content', default='',
                  help='Add extra fields with default values to the output.')


def frange(x, y, jump):
    while x < y:
        yield x
        x += jump


(options, args) = parser.parse_args()

#set the stepping of the increment, converting from string to interger
grid_accuracy = options.grid_interval
step_precision = options.step_interval
field_content = options.field_content

# destination file
out_file = options.outfilename
if out_file:
    # remember the directory that file is contained by
    out_dir = os.path.dirname( os.path.abspath(out_file) )
    out_name = os.path.basename( os.path.abspath(out_file) )
else:
    out_dir = 'output/'
    # destination file
    out_extension = 'geojson'
    # for the demo, we put the results in an "output dir for prettier results    
    out_name = ('graticule_%ddd') % (grid_accuracy)
    out_file = out_dir + out_name + '.' + out_extension

# If the output directory doesn't exist, make it so we don't error later on file open()
if not os.path.exists(out_dir):
    print 'making dir...'
    os.makedirs(out_dir)

grid_file = open(out_file,"w")

# Stub out the GeoJSON format wrapper
header = ['{ "type": "FeatureCollection",','"features": [']
footer = [']','}']

grid_file.writelines(header)
    
# Create Geojson lines horizontal, latitude
for x in frange(-90,91,grid_accuracy):
    featstart = '''{ "type": "Feature",
      "geometry": {
        "type": "LineString",
        "coordinates": ['''
    grid_file.write(featstart)
    for y in frange(-180,181,step_precision):
        if y == -180:
            grid_file.write("[")
        else:
            grid_file.write(",[")
        #print y,x
        grid_file.write(",".join([str(y),str(x)]))
        grid_file.write("]")
    # Figure out if it's North or South
    if x >= 0:
        direction = "N"
    else:
        direction = "S"
    label = " ".join([str(abs(x)),direction])
    featend = ''']},
      "properties": {
        "degrees": %d,
        "direction": "%s",
      "display":"%s",
      "dd":%d,
      %s,
        }
      },\n''' % (abs(x),direction,label,x, field_content)
    grid_file.write(featend)

# Create lines vertical, longitude
for y in frange(-180,181,grid_accuracy):
    featstart = '''{ "type": "Feature",
      "geometry": {
        "type": "LineString",
        "coordinates": ['''
    grid_file.write(featstart)
    for x in frange(-90,91,step_precision):
        if x == -90:
            grid_file.write("[")
        else:
            grid_file.write(",[")
        #print y,x
        grid_file.write(",".join([str(y),str(x)]))
        grid_file.write("]")
        
    # Figure out if it's East or West
    if y >= 0:
        direction = "W"
    else:
        direction = "E"
    label = " ".join([str(abs(y)),direction])
    featend = ''']},
      "properties": {
        "degrees": %d,
        "direction": "%s",
      "display":"%s",
      "dd":%d,
      %s,
        }
      },\n''' % (abs(y),direction,label,y, field_content)
    grid_file.write(featend)

grid_file.writelines(footer)
grid_file.close()