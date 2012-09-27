from sys import stdin, stdout
from json import load, JSONEncoder
from optparse import OptionParser
from re import compile

float_pat = compile(r'^-?\d+\.\d+(e-?\d+)?$')
charfloat_pat = compile(r'^[\[,\,]-?\d+\.\d+(e-?\d+)?$')

parser = OptionParser(usage="""%prog [options]

Make JSON smaller by reducing precision of floating point values
and removing white space. Works great for GeoJSON!

Examples:
  cat input.json | python %prog --precision 2 > output.json
  python %prog --precision 2 input.json > output.json
  python %prog -p 2 input.json output.json""")

defaults = dict(precision=3)

parser.set_defaults(**defaults)

parser.add_option('-p', '--precision', dest='precision',
                  type='int', help='Digits of precision, default %(precision)d.' % defaults)

if __name__ == '__main__':
    options, args = parser.parse_args()
    
    #
    # Read!
    #
    input = len(args) and open(args[0]) or stdin
    data = load(input)
    
    #
    # Write!
    #
    encoder = JSONEncoder(separators=(',', ':'))
    encoded = encoder.iterencode(data)
    
    format = '%.' + str(options.precision) + 'f'
    output = len(args) == 2 and open(args[1], 'w') or stdout
    
    for token in encoded:
        if charfloat_pat.match(token):
            # in python 2.7, we see a character followed by a float literal
            output.write(token[0] + format % float(token[1:]))

        elif float_pat.match(token):
            # in python 2.6, we see a simple float literal
            output.write(format % float(token))

        else:
            output.write(token)