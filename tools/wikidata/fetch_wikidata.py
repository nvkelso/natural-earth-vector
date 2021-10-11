#!/usr/bin/env python3

#--  pip3 install -U SPARQLWrapper
#--  pip3 install -U fiona
#--  pip3 install -U hanzidentifier

"""
Fetch Wikidata Labels


 Wikidata limitations:
 population: lot of constraint violations.
 https://www.wikidata.org/wiki/Property_talk:P1082#Querying_for_the_latest_value

 elevation : temporary disabled , reason: SPARQL performance problem.
"""



import argparse
import csv
import sys
import time
import hanzidentifier
#import requests

from SPARQLWrapper import SPARQLWrapper, JSON, SPARQLExceptions

import fiona

parser = argparse.ArgumentParser(description='Fetch wikidata labels for Natural-Earth ')
parser.add_argument('-input_shape_name',
                    default='../../10m_cultural/ne_10m_populated_places.shp',
                    help='input natural-earth shape file - with wikidataid columns')
parser.add_argument('-input_lettercase',
                    default='uppercase',
                    help='variables in thes hape file - lowercase or uppercase')
parser.add_argument('-output_csv_name',
                    default='ne_10m_populated_places.csv',
                    help='output csv file with wikidata labels')

args = parser.parse_args()


def get_sparql_value(sresult, variable_id):
    """
    Get SPARQL value from the sresult
    """
    val = ''
    if variable_id in sresult:
        val = sresult[variable_id]['value']
    return val

def get_sparql_label(sresult, variable_id):
    """
    Get SPARQL label from the sresult
    """
    val = ''
    if variable_id in sresult:
        val = sresult[variable_id]['value'].split('#')[0].split('(')[0].split(',')[0]
    return val.strip()

def get_sparql_numvalue(sresult, variable_id):
    """
    Get SPARQL numeric value from the sresult
    """
    val = -1
    if variable_id in sresult:
        val = float(sresult[variable_id]['value'])
    return val

def post_process_wd_zh(properties):
    """ First check whether name_zh (Simplified) and name_zht(Traditional)
    are set already, if not we use the name_zh-default to backfill them.
    During the backfill, if there is no Simplified Chinese, Traditional
    Chinese will be used to further backfill, and vice versa
    It also deletes the intermediate property `zh-default`
    """

    if args.input_lettercase == "lowercase":
        name_en_default = properties['name_en'] if 'name_en' in \
                                                    properties else u''
        zh_Hans_fallback = properties['name_zh_hans'] if 'name_zh_hans' in \
                                                    properties else u''
        zh_Hant_fallback = properties['name_zh_hant'] if 'name_zh_hant' in \
                                                     properties else u''
    else:
        name_en_default = properties['NAME_EN'] if 'NAME_EN' in \
                                                    properties else u''
        zh_Hans_fallback = properties['NAME_ZH_HANS'] if 'NAME_ZH_HANS' in \
                                                    properties else u''
        zh_Hant_fallback = properties['NAME_ZH_HANT'] if 'NAME_ZH_HANT' in \
                                                     properties else u''

    # sometimes the default Chinese name has several values in a list
    if 'name_zh_default' in properties:
        names = properties['name_zh_default'].split('/')
        for name in names:
            if hanzidentifier.is_simplified(name) and \
                    len(zh_Hans_fallback) == 0:
                zh_Hans_fallback = name
                #print('found simplified name')
            if hanzidentifier.is_traditional(name) and \
                    len(zh_Hant_fallback) == 0:
                zh_Hant_fallback = name
                #print('found traditional name')

    # make sure we don't shove English values into Chinese namespace
    if (zh_Hans_fallback == name_en_default) and len(name_en_default) > 0:
        zh_Hans_fallback = u''

    if (zh_Hant_fallback == name_en_default) and len(name_en_default) > 0:
        zh_Hant_fallback = u''

    # now make traditional and simplified Chinese name assignments
    if 'name_zhs' not in properties:
        if len(zh_Hans_fallback) != 0:
            properties['name_zhs'] = zh_Hans_fallback
        elif len(zh_Hant_fallback) != 0:
            properties['name_zhs'] = zh_Hant_fallback
        else:
            properties['name_zhs'] = u''

    if 'name_zht' not in properties:
        if len(zh_Hant_fallback) != 0:
            properties['name_zht'] = zh_Hant_fallback
        elif len(zh_Hans_fallback) != 0:
            properties['name_zht'] = zh_Hans_fallback
        else:
            properties['name_zht'] = u''

    # only select one of the options if the field is separated by "/"
    # for example if the field is "旧金山市县/三藩市市縣/舊金山市郡" only the first
    # one 旧金山市县 will be preserved
    if 'name_zh' in properties:
        if len(properties['name_zh']) > 0:
            properties['name_zh'] = properties['name_zh'].split('/')[0].strip()
    if 'name_zht' in properties:
        if len(properties['name_zht']) > 0:
            properties['name_zht'] = properties['name_zht'].split('/')[0].strip()
    if 'NAME_ZH' in properties:
        if len(properties['NAME_ZH']) > 0:
            properties['NAME_ZH'] = properties['NAME_ZH'].split('/')[0].strip()
    if 'NAME_ZHT' in properties:
        if len(properties['NAME_ZHT']) > 0:
            properties['NAME_ZHT'] = properties['NAME_ZHT'].split('/')[0].strip()

    return properties


def fetchwikidata(a_wid):
    """
    Fetch wikidata with SPARQL
    """

    sparql = SPARQLWrapper("https://query.wikidata.org/sparql", 'natural_earth_name_localizer v1.1.1 (github.com/nvkelso/natural-earth-vector)')
    query_template = """
        SELECT
            ?e ?i ?r ?population
            ?name_ar
            ?name_bn
            ?name_de
            ?name_el
            ?name_en
            ?name_es
            ?name_fa
            ?name_fr
            ?name_he
            ?name_hi
            ?name_hu
            ?name_id
            ?name_it
            ?name_ja
            ?name_ko
            ?name_nl
            ?name_pl
            ?name_pt
            ?name_ru
            ?name_sv
            ?name_tr
            ?name_uk
            ?name_ur
            ?name_vi
            ?name_zh
            ?name_zh_hans
            ?name_zh_hant
        WHERE {
            {
                SELECT DISTINCT  ?e ?i ?r
                WHERE{
                    VALUES ?i { wd:Q2102493 wd:Q1781    }
                    OPTIONAL{ ?i owl:sameAs ?r. }
                    BIND(COALESCE(?r, ?i) AS ?e).
                }
            }
            SERVICE wikibase:label {bd:serviceParam wikibase:language "en".}
            OPTIONAL{?e wdt:P1082 ?population .}
            OPTIONAL{?e rdfs:label ?name_ar FILTER((LANG(?name_ar))="ar").}
            OPTIONAL{?e rdfs:label ?name_bn FILTER((LANG(?name_bn))="bn").}
            OPTIONAL{?e rdfs:label ?name_de FILTER((LANG(?name_de))="de").}
            OPTIONAL{?e rdfs:label ?name_el FILTER((LANG(?name_el))="el").}
            OPTIONAL{?e rdfs:label ?name_en FILTER((LANG(?name_en))="en").}
            OPTIONAL{?e rdfs:label ?name_es FILTER((LANG(?name_es))="es").}
            OPTIONAL{?e rdfs:label ?name_fa FILTER((LANG(?name_fa))="fa").}
            OPTIONAL{?e rdfs:label ?name_fr FILTER((LANG(?name_fr))="fr").}
            OPTIONAL{?e rdfs:label ?name_he FILTER((LANG(?name_he))="he").}
            OPTIONAL{?e rdfs:label ?name_hi FILTER((LANG(?name_hi))="hi").}
            OPTIONAL{?e rdfs:label ?name_hu FILTER((LANG(?name_hu))="hu").}
            OPTIONAL{?e rdfs:label ?name_id FILTER((LANG(?name_id))="id").}
            OPTIONAL{?e rdfs:label ?name_it FILTER((LANG(?name_it))="it").}
            OPTIONAL{?e rdfs:label ?name_ja FILTER((LANG(?name_ja))="ja").}
            OPTIONAL{?e rdfs:label ?name_ko FILTER((LANG(?name_ko))="ko").}
            OPTIONAL{?e rdfs:label ?name_nl FILTER((LANG(?name_nl))="nl").}
            OPTIONAL{?e rdfs:label ?name_pl FILTER((LANG(?name_pl))="pl").}
            OPTIONAL{?e rdfs:label ?name_pt FILTER((LANG(?name_pt))="pt").}
            OPTIONAL{?e rdfs:label ?name_ru FILTER((LANG(?name_ru))="ru").}
            OPTIONAL{?e rdfs:label ?name_sv FILTER((LANG(?name_sv))="sv").}
            OPTIONAL{?e rdfs:label ?name_tr FILTER((LANG(?name_tr))="tr").}
            OPTIONAL{?e rdfs:label ?name_uk FILTER((LANG(?name_uk))="uk").}
            OPTIONAL{?e rdfs:label ?name_ur FILTER((LANG(?name_ur))="ur").}
            OPTIONAL{?e rdfs:label ?name_vi FILTER((LANG(?name_vi))="vi").}
            OPTIONAL{?e rdfs:label ?name_zh FILTER((LANG(?name_zh))="zh").}
            OPTIONAL{?e rdfs:label ?name_zh_hans FILTER((LANG(?name_zh_hans))="zh-hans").}
            OPTIONAL{?e rdfs:label ?name_zh_hant FILTER((LANG(?name_zh_hant))="zh-hant").}
        }

    """

    wikidata_sparql_ids = ""
    for wid in a_wid:
        wikidata_sparql_ids += " wd:"+wid

    print("fetch: ", wikidata_sparql_ids.split()[1], "... ", wikidata_sparql_ids.split()[-1])
    ne_query = query_template.replace('wd:Q2102493 wd:Q1781', wikidata_sparql_ids)

    # compress the Query -  removing the extra spaces
    while '  ' in ne_query:
        ne_query = ne_query.replace('  ', ' ')

    results = None
    retries = 0
    while results is None and retries < 8:
        try:
            results = None
            sparql.setQuery(ne_query)
            sparql.setTimeout(1000)
            sparql.setReturnFormat(JSON)
            results = sparql.query().convert()

        except SPARQLExceptions.EndPointNotFound:
            print('ERRwikidata-SPARQLExceptions-EndPointNotFound:  Retrying in 30 seconds.')
            time.sleep(30)
            retries += 1
            continue

        except SPARQLExceptions.EndPointInternalError as e:
            print("ERRwikidata-SPARQLExceptions-EndPointInternalError: Retrying in 30 seconds.",e)
            time.sleep(30)
            retries += 1
            continue

        except SPARQLExceptions.QueryBadFormed as e:
            print("ERRwikidata-SPARQLExceptions-QueryBadFormed : Check!  ",e)
            return "error"

        except TimeoutError as e:
            print("ERRwikidata-SPARQLExceptions  TimeOut : Retrying in 1 seconds.",e)
            time.sleep(1)
            retries += 1
            continue

        except KeyboardInterrupt:
            # quit
            sys.exit()

        except:
            wait = retries*5
            print("ERRwikidata: other error. Retrying in "+str(wait)+" seconds.")
            print('error: %s ' % sys.exc_info()[0])
            time.sleep(3)
            retries += 1
            continue

    if results is None and retries >= 8:
        print("Wikidata request failed ; system stopped! ")
        sys.exit(1)


    return results

print('- Start fetching Natural-Earth wikidata labels via SPARQL query - ')

with open(args.output_csv_name, "w", encoding='utf-8') as f:
    writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    writer.writerow((
        "wd_id",
        "wd_id_new",
        "population",
        #"elevation",
        "name_ar",
        "name_bn",
        "name_de",
        "name_el",
        "name_en",
        "name_es",
        "name_fa",
        "name_fr",
        "name_he",
        "name_hi",
        "name_hu",
        "name_id",
        "name_it",
        "name_ja",
        "name_ko",
        "name_nl",
        "name_pl",
        "name_pt",
        "name_ru",
        "name_sv",
        "name_tr",
        "name_uk",
        "name_ur",
        "name_vi",
        "name_zh",
        "name_zht"
    ))




    with fiona.open(args.input_shape_name, 'r') as shape_input:
        i = 0
        REC_IN_SHAPE = len(shape_input)
        wikidata_chunk = list()
        for pt in shape_input:
            i = i+1

            if args.input_lettercase == "lowercase":
                ne_wikidataid = pt['properties']['wikidataid']
            else:
                ne_wikidataid = pt['properties']['WIKIDATAID']

            ne_fid = pt['id']

            if ne_wikidataid:
                if ne_wikidataid[0] == 'Q':
                    wikidata_chunk.append(ne_wikidataid)
                else:
                    print("ERROR: Bad formatted wikidataid , skip", ne_wikidataid)

            if (len(wikidata_chunk) >= 200) or (i >= REC_IN_SHAPE):

                sparql_results = fetchwikidata(wikidata_chunk)
                wikidata_chunk = []

                for result in sparql_results["results"]["bindings"]:
                    #print(result)
                    wd_id_label = get_sparql_value(result, 'e').split('/')[4]
                    wd_id = get_sparql_value(result, 'i').split('/')[4]
                    wd_id_new = get_sparql_value(result, 'r')
                    if wd_id_new:
                        wd_id_new = wd_id_new.split('/')[4]
                        print('Redirected:', wd_id, wd_id_new)
                    population = get_sparql_value(result, 'population')
                    #elevation =get_sparql_value(result, 'elevation')

                    name_ar = get_sparql_label(result, 'name_ar')
                    name_bn = get_sparql_label(result, 'name_bn')
                    name_de = get_sparql_label(result, 'name_de')
                    name_el = get_sparql_label(result, 'name_el')
                    name_en = get_sparql_label(result, 'name_en')
                    name_es = get_sparql_label(result, 'name_es')
                    name_fa = get_sparql_label(result, 'name_fa')
                    name_fr = get_sparql_label(result, 'name_fr')
                    name_he = get_sparql_label(result, 'name_he')
                    name_hi = get_sparql_label(result, 'name_hi')
                    name_hu = get_sparql_label(result, 'name_hu')
                    name_id = get_sparql_label(result, 'name_id')
                    name_it = get_sparql_label(result, 'name_it')
                    name_ja = get_sparql_label(result, 'name_ja')
                    name_ko = get_sparql_label(result, 'name_ko')
                    name_lt = get_sparql_label(result, 'name_lt')
                    name_nl = get_sparql_label(result, 'name_nl')
                    name_pl = get_sparql_label(result, 'name_pl')
                    name_pt = get_sparql_label(result, 'name_pt')
                    name_ru = get_sparql_label(result, 'name_ru')
                    name_sv = get_sparql_label(result, 'name_sv')
                    name_tr = get_sparql_label(result, 'name_tr')
                    name_uk = get_sparql_label(result, 'name_uk')
                    name_ur = get_sparql_label(result, 'name_ur')
                    name_vi = get_sparql_label(result, 'name_vi')

                    # not all Wikidata places have all name (label) translations
                    try:
                        name_en = get_sparql_label(result, 'name_en')
                    except:
                        name_en = u''

                    try:
                        name_zh_default = get_sparql_label(result, 'name_zh')
                    except:
                        name_zh_default = u''

                    try:
                        name_zh_hans = get_sparql_label(result, 'name_zh_hans')
                    except:
                        name_zh_hans = u''

                    try:
                        name_zh_hant = get_sparql_label(result, 'name_zh_hant')
                    except:
                        name_zh_hant = u''

                    chinese_names = { 'name_en'         : name_en,
                                      'name_zh_default' : name_zh_default,
                                      'name_zh_hans'    : name_zh_hans,
                                      'name_zh_hant'    : name_zh_hant
                                    }

                    processed_chinese_names = post_process_wd_zh( chinese_names )

                    try:
                        name_zh  = processed_chinese_names['name_zhs']
                    except:
                        name_zh  = u''
                    try:
                        name_zht = processed_chinese_names['name_zht']
                    except:
                        name_zht  = u''

                    writer.writerow((
                        wd_id,
                        wd_id_new,
                        population,
                        #elevation,
                        name_ar,
                        name_bn,
                        name_de,
                        name_el,
                        name_en,
                        name_es,
                        name_fa,
                        name_fr,
                        name_he,
                        name_hi,
                        name_hu,
                        name_id,
                        name_it,
                        name_ja,
                        name_ko,
                        name_nl,
                        name_pl,
                        name_pt,
                        name_ru,
                        name_sv,
                        name_tr,
                        name_uk,
                        name_ur,
                        name_vi,
                        name_zh,
                        name_zht
                        ))

print(' - JOB end -')