import fiona
from shapely.geometry import shape, mapping

import requests
import logging
import json
import sys

import argparse

parser = argparse.ArgumentParser(description='Add unique ne_id to Natural Earth theme features based on Brooklyn Ints.')
parser.add_argument("--input", "-i", type=str, required=True)
parser.add_argument("--output", "-o", type=str, required=True)
args = parser.parse_args()

def generate_id():

    url = 'https://api.brooklynintegers.com/rest/'
    params = {'method':'brooklyn.integers.create'}

    try :
        rsp = requests.post(url, params=params)
        data = rsp.content
    except Exception, e:
        logging.error(e)
        return 0

    try:
        data = json.loads(data)
    except Exception, e:
        logging.error(e)
        return 0

    return data.get('integer', 0)


with fiona.open( args.input, 'r', encoding='utf-8' ) as source:

    # Copy the source schema and add two new properties.
    sink_schema = source.schema.copy()

    # add ne_id property if not present in the schema add it
    if not hasattr( sink_schema['properties'], 'ne_id'):
        sink_schema['properties']['ne_id'] = 'int'

    # Create a sink for processed features with the same format and
    # coordinate reference system as the source.
    with fiona.open(
            args.output, 'w',
            crs=source.crs,
            driver=source.driver,
            encoding='utf-8',
            schema=sink_schema,
            ) as sink:

        # setup counter to track which feature we're on
        f_counter = 1
        total_features = len(list(source))
                
        for feature in source:
            # report which feature we're processing
            sys.stdout.write("\r  " + str(f_counter) + " of " + str(total_features))
            # but don't spam with new lines
            sys.stdout.flush()

            try:

                # when a feature's ne_id property is null or 0 then request a new Brooklyn Int and store that to the feature's ne_id property
                if not hasattr( sink_schema['properties'], 'ne_id'):
                    # generate a Brooklyn int and assign to feature new ne_id property
                    feature['properties'].update(
                        ne_id = generate_id() )

                    sink.write(feature)

                else:
                    if feature['properties']['ne_id'] is null or feature['properties']['ne_id'] == 0:
                        # generate a Brooklyn int and assign to feature existing ne_id property with empty values
                        feature['properties'].update(
                            ne_id = generate_id() )

                        sink.write(feature)

            except Exception, e:
                logging.exception("Error processing feature %s:", feature['id'])
            
            # increment counter
            f_counter += 1

        # The sink file is written to disk and closed when its block ends.