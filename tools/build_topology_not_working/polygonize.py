import os, sys
from optparse import OptionParser
from sys import argv

from shapely.ops import polygonize
from shapely.geometry import asShape, LineString

import json

optparser = OptionParser(usage="""%prog [options]

POLYGONIZE

Have GeoJSON lines? Let's make polygons!""")

optparser.add_option('-l', '--in_file', '--line_file', dest='infilename',
                      help='Give me your huddled masses of geodata!')

optparser.add_option('-p', '--out_files', '--polygon_file', dest='outfile',
                      help='Style name for resulting MSS, MML, and HTML files.')

if __name__ == "__main__":

    (options, args) = optparser.parse_args()
    
    #print 'len(args): ', len(args), ' - ', args
    
    if len(args) is 2:
        in_file  = str(args[0])
        out_file = str(args[1])
    else:
        in_file  = options.infilename
        out_file = options.outfile

    #in_file = argv[1]
    #out_file = argv[2]
    
    input = json.load(open(in_file))
    lines = []
    
    #print input
    
    for feat in input['features']:
        shape = asShape(feat['geometry'])
        geoms = hasattr(shape, 'geoms') and shape.geoms or [shape]
        
        for part in geoms:
            coords = list(part.coords)
            for (start, end) in zip(coords[:-1], coords[1:]):
                lines.append(LineString([start, end]))
    
    #print lines
    
    areas = polygonize(lines)
    output = dict(type='FeatureCollection', features=[])
    
    for (index, area) in enumerate(areas):
        
        feature = dict(type='Feature', properties=dict(index=index))
        feature['geometry'] = area.__geo_interface__
        output['features'].append(feature)
    
    #print output
    
    json.dump(output, open(out_file, 'w'))