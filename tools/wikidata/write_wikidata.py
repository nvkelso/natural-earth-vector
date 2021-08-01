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

riverclean_regex = re.compile(r'\b('+'River|rivière de la |rivière à la|rivière des|Rivière De|Rivière du|Rivière aux|Rivière|rivier|Rio dos|Rio|Río La|Río de los|Río de las|Río dos|Río|sông|-folyó|folyó|canale di|canale|Nehri|Jiang|Sungai'+r')\b',
                              flags=re.IGNORECASE)
# Some of these are proper names (Lake of the Ozark's, Clear Lake Reservoir) and
# shouldn't be stripped, but in the meantime, strip aggressively
lakeclean_regex = re.compile(r'\b('+'Lake of the|Grand Lake o\' the|Lake Reservoir|Grand Lake|Grant Lake|Lake of|Lake|Lago degli|Lago del|Lago de|lago di|Lago la|Lago do|Lago |lago d\'||Lago|Lac de la|lac d\'|lac des|Lac des|lac de|Lac de|Lac au|lac di|lac la|Lac La|Lac à l’|lac à la|Lac|lac|-See|See|Laguna de|Laguna|Lake Reservoir|Reservoir|réservoir de la|réservoir de|Reservatório de|réservoir|Réservoir|Represa de|Represa|baie de|Bahía de|öböl|Gölü|järv|Embalse de|Embalse|Bacino di|bacino di|Bacino|bacino|Sông|Lough|Hồ|Danau'+r')\b',
                              flags=re.IGNORECASE)
#geolabels_regex = re.compile(r'\b('+'(wyspa)'+r')\b',
#                              flags=re.IGNORECASE)
placeclean_regex = re.compile(r'\b('+'Municipality of|Municipality|First Nation|Urban District|urban area|Distretto di|District de|District|Heroica Ciudad de|Município|Contea di|Barra do|City of'+r')\b',
                              flags=re.IGNORECASE)
geo_region_regex = re.compile(r'\b('+'Região Autónoma dos'+r')\b',
                              flags=re.IGNORECASE)
admin2_regex = re.compile(r'\b('+'County|Condado de|comté de|contea di|comté d|megye|Hrabstwo|Condado de|Quận|مقاطعة|City and Borough|census area di|Census Area|Borough|borough di|borough de|ilçesi'+r')\b',
                              flags=re.IGNORECASE)
admin1_regex = re.compile(r'\b('+'canton of |Canton of|Department|District Council|distretto di contea di|contea di|District de|distretto di|Distretto della|Distrik|distretto del|district|Constitutional Province|Province of |Provincia del|provincia delle|provincia della|provincia di|Provincia Constitucional del|Província Constitucional de|provincia de|Província de|Província do|Provincia de|Préfecture de|Provincia|Comunidad De|Autonome Provinz|Provincia Autónoma de|Provinz|Província|Departamento de|Departamento do|Autonomous Province of|Autonomous Province|Province de la|province de|Province du|Province|Provinsi|Municipality of |Municipality|Município de|Special Region of |Región Metropolitana de|Special Region|Autonomous Region|Capital Region of|Region of|-Region|Region|Governorate|Gouvernorat|Gubernatorstwo|Gobernación de|governatorato di|Capital  of|Capital of|City Council|City and Borough of|City of|Città di|City|Región Metropolitana de|Metropolitan Region|Metropolitan Borough of|Metropolitan Borough|Borough Metropolitano de|London Borough of|district londonien|district londonien d\'|borough royal de|Royal Borough of|County Borough|Borough of|Borough Council|Metropoliten Borough|londonien de|district royal de|County|Old Royal Capital|(distrikt)|Distrik|(borough)|Cantão central de|cantone della|(cantão)|(departamento)|(departement)|Región del|Región de|Región|gouvernorat de|Gouvernorat|kormányzóság|regione di|Regione del|Prefectura de|prefettura di|Autonome Oblast|Oblast Autônomo|Autonomous Oblast|Oblast\' dell\'|Obwód Autonomiczny|Kraï de|Kraï|Oblast de|Óblast de|Oblast\' di|Oblast\'|oblast|distrito de|Distrito do|Distrito|métropolitain de|Voivodia da|cantone di|cantone dell\'|Munisipalitas\' di|Munisipalitas|Emirato di|Emirato|cantón del|cantón de|canton du|cantón|Καντόνι του|Καντόνι της|Ζουπανία του|Επαρχία του|Δήμος|Κυβερνείο του|distretto|Région autonome du|région de|Governamento de|Kegubernuran|comté de|parrocchia di|obwód|, London|, Londra|, Nya Zeeland|Daerah Istimewa|Autónoma del|Parish of|Parish|, Barbados|Circondario autonomo dei|Circondario autonomo|circondario autonomo degli|Okręg Autonomiczny|Dystrykt|-Distrikt|Distrikt|distriktet|, प्रांत|, पैराग्वे|, Zambia|, Kenya|, Καμερούν|, Τζαμάικα|, Barbados|, Londra|, Bahama|kommun|Ciudad de|, Gambia|, Botswana|tartomány|körzet|Munizip|division|Conselho do Borough de|Rejon|Raionul|Kotar|megye|Żupania|comune distrettuale di|comune distrettuale|Comune di|comune|Condado de|Condado|Kotamadya|Região Autónoma dos|Região Autónoma|Região|Guvernementet|Gobernación del|Gobernación'+r')\b',
                              flags=re.IGNORECASE)
admin0_regex = re.compile(r'\b('+'(district)|(địa hạt)'+r')\b',
                              flags=re.IGNORECASE)


def isNotEmpty(s):
    """
      Check String is not empty
    """
    return bool(s and s.strip())



# read csv data
wddic = defaultdict(dict)
wdredirects = defaultdict(dict)

name_field_prefix = 'name_'
languages = ['ar','bn','de','el','en','es','fa','fr','he','hi','hu','id','it','ja','ko','nl','pl','pt','ru','sv','tr','uk','ur','vi','zh','zht']
new_properties = []

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

                    # where input_shape evaluates the name of the shapefile
                    # as proxy for featureclass

                    # Rivers ...
                    if args.input_shape.lower().find('rivers_lake') > 0:
                        wddic[qid][d] = riverclean_regex.sub('', wddic[qid][d])

                        # Comma ...
                        if wddic[qid][d].find(',') > 0:
                            # RTL languages
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find(',')]

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                    # Lakes ...
                    if args.input_shape.lower().find('lake') > 0 and args.input_shape.lower().find('10m_physical') > 0:
                        #if d == 'name_en' and wddic[qid]['name_en'] != 'Lake of the Woods':
                        wddic[qid][d]=lakeclean_regex.sub('', wddic[qid][d] )

                        # Comma ...
                        if wddic[qid][d].find(',') > 0:
                            # RTL languages
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find(',')]

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                    # Physical Geography label polys and points ...
                    if args.input_shape.lower().find('_geography_') > 0:
                        wddic[qid][d]=geo_region_regex.sub('', wddic[qid][d] )

                        # Comma ...
                        if wddic[qid][d].find(',') > 0:
                            # RTL languages
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find(',')]

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                    # Places ...
                    if args.input_shape.lower().find('place') > 0:
                        wddic[qid][d] = placeclean_regex.sub('', wddic[qid][d])
                        #name_zh:  remove last "市""City" character
                        if d == 'name_zh' and wddic[qid]['name_zh'] and wddic[qid]['name_zh'][-1] == "市":
                            wddic[qid]['name_zh'] = wddic[qid]['name_zh'][:-1]

                        # Comma ...
                        if wddic[qid][d].find(',') > 0:
                            # RTL languages
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find(',')]

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                    # Admin 2 counties ...
                    if args.input_shape.lower().find('admin_2') > 0:
                        wddic[qid][d] = admin2_regex.sub('', wddic[qid][d])

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                        #name_ko:  remove last "주""State" character
                        if d == 'name_ko' and wddic[qid]['name_ko'] and wddic[qid]['name_ko'][-1] == "군":
                            wddic[qid]['name_ko'] = wddic[qid]['name_ko'][:-1]

                    # Admin 1 states, provinces ...
                    if args.input_shape.lower().find('admin_1') > 0:
                        wddic[qid][d] = admin1_regex.sub('', wddic[qid][d])

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                        #name_ko:  remove last "주""State" character
                        if d == 'name_ko' and wddic[qid]['name_ko'] and wddic[qid]['name_ko'][-1] == "주":
                            wddic[qid]['name_ko'] = wddic[qid]['name_ko'][:-1]

                        # That's the city name, we're only interested in the region name
                        if wddic[qid][d] == 'Washington, D.C.':
                            wddic[qid][d] = 'D.C.'

                    # Admin 0 countries, map units, etc
                    if args.input_shape.lower().find('admin_0') > 0:
                        wddic[qid][d] = admin0_regex.sub('', wddic[qid][d])

                        # Parenthetical ...
                        if wddic[qid][d].find('(') > 0:
                            # RTL languages and LTR figure each other out in python 3
                            wddic[qid][d] = wddic[qid][d][0:wddic[qid][d].find('(')]

                    # sometimes the RegEx strips words mid string and leaves double spaces
                    # we also want to strip leading or trailing whitespace
                    wddic[qid][d] = wddic[qid][d].replace('  ', ' ').strip()

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

        out_schema = source.schema

        for locale in languages:
            name_locale = name_field_prefix + locale
            if args.input_lettercase != "lowercase":
                name_locale = name_locale.upper()

            if name_locale not in out_schema['properties']:
                print("...NOTE.. adding locale to schema", name_locale)
                out_schema['properties'][name_locale] = 'str'
                new_properties.append(name_locale)

        #print(out_schema)

        # **source.meta is a shortcut to get the crs, driver, and schema
        #with fiona.open(args.output_shape, 'w', encoding='utf-8', **source.meta) as sink:
        # But since we're overwriting the schema, we take the long way
        # keyword arguments from the source Collection.
        with fiona.open(
            args.output_shape, 'w',
            driver=source.driver,
            crs=source.crs,
            encoding='utf-8',
            schema=out_schema,
            ) as sink:

            #print(sink.schema)

            warn_no_dbf_field_for_new_property = 1

            stat_equal = 0
            stat_empty = 0
            stat_new = 0
            stat_new_value_new_lang = 0
            stat_del = 0
            stat_mod = 0

            stat_wikidataid_redirect = 0
            stat_wikidataid_notfound = 0
            stat_wikidataid_null = 0
            stat_wikidataid_badformated = 0
            stat_wikidataid_notnull = 0

            for f in source:

                try:
                    # get in format at least
                    for new_prop in new_properties:
                        f['properties'][new_prop] = ''

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

                                try:
                                    if not f['properties'][updatefield]:
                                        f['properties'][updatefield] = ''
                                    else:
                                        f['properties'][updatefield] = f['properties'][updatefield].strip()
                                except:
                                    # visual logging is handled in the next section
                                    # see warn_no_dbf_field_for_new_property
                                    pass


                                if not wddic[qid][updatefield]:
                                    wddic[qid][updatefield] = ''
                                else:
                                    wddic[qid][updatefield] = wddic[qid][updatefield].strip()

                                if updatefield in f['properties']:

                                    if f['properties'][updatefield] != wddic[qid][updatefield]:

                                        if f['properties'][updatefield] == '':
                                            if updatefield in new_properties:
                                                status = 'NEWvalue_NEW_LANG'
                                                stat_new_value_new_lang += 1
                                            else:
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
                                    if warn_no_dbf_field_for_new_property:
                                        print("...ERROR.. updatefield is missing", updatefield)
                                        warn_no_dbf_field_for_new_property = 0
                                        #sys.exit(1)

                                    status = 'NEWvalue_NEW_LANG'
                                    stat_new_value_new_lang += 1

                                    writer.writerow((qid, status, updatefield, '', wddic[qid][updatefield]))
                                    f['properties'][updatefield] = wddic[qid][updatefield]
                                    #f['properties'].update(updatefield=wddic[qid][updatefield])

                                    #print(f['properties'])

                        else:
                            print("WARNING: Not found wikidataid - please check :", qid)
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
                sumWriter.writerow((args.input_shape, 'New_name_new_language', stat_new_value_new_lang))
                sumWriter.writerow((args.input_shape, 'Deleted_name', stat_del))
                sumWriter.writerow((args.input_shape, 'Modified_name', stat_mod))
                sumWriter.writerow((args.input_shape, 'Empty_name', stat_empty))
                sumWriter.writerow((args.input_shape, 'Same_name', stat_equal))
                sumWriter.writerow((args.input_shape, 'Wikidataid_redirected', stat_wikidataid_redirect))
                sumWriter.writerow((args.input_shape, 'Wikidataid_notfound', stat_wikidataid_notfound))
                sumWriter.writerow((args.input_shape, 'Wikidataid_null', stat_wikidataid_null))
                sumWriter.writerow((args.input_shape, 'Wikidataid_notnull', stat_wikidataid_notnull))
                sumWriter.writerow((args.input_shape, 'Wikidataid_badformated', stat_wikidataid_badformated))
