#!/usr/bin/env python3
# -*- coding: utf-8 -*-



#--  pip3 install -U fiona
#--- pip3 install -U csvtomd

"""
  Write new wikidata labels ...
"""


import argparse
import csv
import logging
import sys
import re
from collections import defaultdict

import fiona

logging.basicConfig(stream=sys.stderr, level=logging.INFO)

parser = argparse.ArgumentParser(description='Update wikidata labels for Natural-Earth ')
parser.add_argument('-input_shape',
                    default='../../10m_cultural/ne_10m_populated_places.shp',
                    help='input natural-earth shape file - with wikidataid columns')
parser.add_argument('-input_lettercase',
                    default='lowercase',
                    help='variables in the shape file - lowercase or uppercase')
parser.add_argument('-input_csv',
                    default='ne_10m_populated_places.csv',
                    help='input csv file with the latest wikidataid name_XX columns')
parser.add_argument('-output_shape',
                    default='ne_10m_populated_places_latest.shp',
                    help='output  natural-earth shape file - with updated wikidataid name_XX columns')
parser.add_argument('-output_csvlog',
                    default='ne_10m_populated_places_latest.log.csv',
                    help='audit log about the changes')
parser.add_argument('-output_csvsumlog',
                    default='ne_10m_populated_places_latest.sumlog.csv',
                    help='audit sum log about the changes')

args = parser.parse_args()

#lakeclean_regex  = re.compile(r'\b('+'Lake'+r')\b', flags=re.IGNORECASE)
riverclean_regex = re.compile(r'\b('+'River'+r')\b',
                              flags=re.IGNORECASE)
placeclean_regex = re.compile(r'\b('+'Municipality of|Municipality|City|First Nation'+r')\b',
                              flags=re.IGNORECASE)


def isNotEmpty(s):
    """
      Check String is not empty
    """
    return bool(s and s.strip())



# read csv data
wddic = defaultdict(dict)
wdredirects = defaultdict(dict)
with open(args.input_csv, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        qid = row['wd_id']
        for d in row:
            if d != 'wd_id':
                #print(d, d[0:5])
                if d[0:5] == 'name_':
                    wddic[qid][d] = row[d].strip()

                    # Clean names ...

                    # Rivers ...
                    if args.input_shape.lower().find('river') > 0:
                        wddic[qid][d] = riverclean_regex.sub('', wddic[qid][d])

                    # Lakes ...
                    # if args.input_shape.lower().find('lake') > 0:
                    #    wddic[qid][d]=lakeclean_regex.sub('', wddic[qid][d] )

                    # Places ...
                    if args.input_shape.lower().find('place') > 0:
                        wddic[qid][d] = placeclean_regex.sub('', wddic[qid][d])
                        #name_zh:  remove last "市""City" character
                        if d == 'name_zh' and wddic[qid]['name_zh'] and wddic[qid]['name_zh'][-1] == "市":
                            wddic[qid]['name_zh'] = wddic[qid]['name_zh'][:-1]

                    wddic[qid][d] = wddic[qid][d].strip()

                    if wddic[qid][d] != row[d].strip():
                        print(qid, d, ' name cleaning : ', row[d].strip(), ' -->  ', wddic[qid][d])

                    # Add an uppercase version
                    if args.input_lettercase != "lowercase":
                        wddic[qid][d.upper()] = wddic[qid][d]   # - add uppercase version
                        del wddic[qid][d]                       # - remove default lowcase

        if row['wd_id_new'] != '':
            wdredirects[qid] = row['wd_id_new']


with open(args.output_csvlog, "w", encoding='utf-8') as f:
    writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    writer.writerow(("wd_id", "status", "variable", "value_old", "value_new"))

    with fiona.open(args.input_shape, 'r', encoding='utf-8', driver="ESRI Shapefile") as source:
        # **source.meta is a shortcut to get the crs, driver, and schema
        # keyword arguments from the source Collection.
        with fiona.open(args.output_shape, 'w', encoding='utf-8', **source.meta) as sink:

            stat_equal = 0
            stat_empty = 0
            stat_new = 0
            stat_del = 0
            stat_mod = 0

            stat_wikidataid_redirect = 0
            stat_wikidataid_notfound = 0
            stat_wikidataid_null = 0
            stat_wikidataid_badformated = 0
            stat_wikidataid_notnull = 0

            for f in source:

                try:

                    if args.input_lettercase == "lowercase":
                        qid = f['properties']['wikidataid']
                    else:
                        qid = f['properties']['WIKIDATAID']

                    if not qid:
                        qid = ''

                    if qid.startswith('Q'):
                        stat_wikidataid_notnull += 1

                        if qid in wddic:
                            #Update wikidataid if redirects
                            if qid in wdredirects:
                                writer.writerow((qid, "REDIRECT", 'wikidataid', qid, wdredirects[qid]))
                                stat_wikidataid_redirect += 1

                                if args.input_lettercase == "lowercase":
                                    f['properties']['wikidataid'] = wdredirects[qid]
                                else:
                                    f['properties']['WIKIDATAID'] = wdredirects[qid]

                            for updatefield in wddic[qid]:

                                if not f['properties'][updatefield]:
                                    f['properties'][updatefield] = ''
                                else:
                                    f['properties'][updatefield] = f['properties'][updatefield].strip()


                                if not wddic[qid][updatefield]:
                                    wddic[qid][updatefield] = ''
                                else:
                                    wddic[qid][updatefield] = wddic[qid][updatefield].strip()


                                if updatefield in f['properties']:

                                    if f['properties'][updatefield] != wddic[qid][updatefield]:

                                        if f['properties'][updatefield] == '':
                                            status = 'NEWvalue'
                                            stat_new += 1
                                        elif  wddic[qid][updatefield] == '':
                                            status = 'DELvalue'
                                            stat_del += 1
                                        else:
                                            status = 'MODvalue'
                                            stat_mod += 1

                                        writer.writerow((qid, status, updatefield, f['properties'][updatefield], wddic[qid][updatefield]))
                                        f['properties'][updatefield] = wddic[qid][updatefield]

                                    else:
                                        if isNotEmpty(f['properties'][updatefield]):
                                            stat_equal += 1
                                        else:
                                            stat_empty += 1
                                else:
                                    print("...ERROR.. updatefield is missing", updatefield)
                                    sys.exit(1)



                        else:
                            print("WARNIMG: Notfound wikidataid - please check :", qid)
                            stat_wikidataid_notfound += 1

                    else:

                        if qid == '':
                            stat_wikidataid_null += 1
                        else:
                            stat_wikidataid_badformated += 1
                            print("WARNING: Bad formatted wikidataid , skip", qid)

                    sink.write(f)

                except Exception as e:
                    logging.exception("Error processing feature %s:", f['id'])
                    print(e)
                    sys.exit(1)


            # Write statistics ...
            with open(args.output_csvsumlog, "w", encoding='utf-8') as s:
                sumWriter = csv.writer(s, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
                sumWriter.writerow(("shapefilename", "var", "value"))

                sumWriter.writerow((args.input_shape, 'New_name', stat_new))
                sumWriter.writerow((args.input_shape, 'Deleted_name', stat_del))
                sumWriter.writerow((args.input_shape, 'Modified_name', stat_mod))
                sumWriter.writerow((args.input_shape, 'Empty_name', stat_empty))
                sumWriter.writerow((args.input_shape, 'Same_name', stat_equal))
                sumWriter.writerow((args.input_shape, 'Wikidataid_redirected', stat_wikidataid_redirect))
                sumWriter.writerow((args.input_shape, 'Wikidataid_notfound', stat_wikidataid_notfound))
                sumWriter.writerow((args.input_shape, 'Wikidataid_null', stat_wikidataid_null))
                sumWriter.writerow((args.input_shape, 'Wikidataid_notnull', stat_wikidataid_notnull))
                sumWriter.writerow((args.input_shape, 'Wikidataid_badformated', stat_wikidataid_badformated))
