#!/usr/bin/env python3

#--  pip3 install -U SPARQLWrapper
#--  pip3 install -U fiona

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
#import requests

from SPARQLWrapper import SPARQLWrapper, JSON, SPARQLExceptions

import fiona

parser = argparse.ArgumentParser(description='Fetch wikidata labels for Natural-Earth ')
parser.add_argument('-input_shape_name',
                    default='../../10m_cultural/ne_10m_populated_places.shp',
                    help='input natural-earth shape file - with wikidataid columns')
parser.add_argument('-input_lettercase',
                    default='lowercase',
                    help='variables in thes hape file - lowercase or uppercase')
parser.add_argument('-output_csv_name',
                    default='ne_10m_populated_places.csv',
                    help='output csv file with wikidata labels')

args = parser.parse_args()


def get_sparql_value(key, sresult, variable_id):
    """
    Get SPARQL value from the sresult
    """
    val = ''
    if variable_id == key:
        val = sresult['value']
    return val

def get_sparql_label(key, sresult, variable_id):
    """
    Get SPARQL label from the sresult
    """
    val = ''
    if variable_id == key:
        val = sresult['value'].split('#')[0].split('(')[0].split(',')[0]
    return val.strip()

def get_sparql_numvalue(key, sresult, variable_id):
    """
    Get SPARQL numeric value from the sresult
    """
    val = -1
    if variable_id == key:
        val = float(sresult['value'])
    return val


def fetchwikidata(a_wid):
    """
    Fetch wikidata with SPARQL
    """
    sparql = SPARQLWrapper("https://query.wikidata.org/sparql", agent='natural_earth_name_localizer v1.1.0 (github.com/nvkelso/natural-earth-vector)')

    # Adding additional languages yielded:
    # HTTP Error 431: Request Header Fields Too Large
    # Splitting the query into 2 parts solves that
    query_template_part_a = """
         PREFIX geo: <http://www.opengis.net/ont/geosparql#>
            SELECT
                ?e ?i ?r
                (group_concat(distinct ?name_ar;separator="#") as ?name_ar)
                (group_concat(distinct ?name_bn;separator="#") as ?name_bn)
                (group_concat(distinct ?name_de;separator="#") as ?name_de)
                (group_concat(distinct ?name_en;separator="#") as ?name_en)
                (group_concat(distinct ?name_es;separator="#") as ?name_es)
                (group_concat(distinct ?name_fr;separator="#") as ?name_fr)
                (group_concat(distinct ?name_el;separator="#") as ?name_el)
                (group_concat(distinct ?name_he;separator="#") as ?name_he)
                (group_concat(distinct ?name_hi;separator="#") as ?name_hi)
                (group_concat(distinct ?name_hu;separator="#") as ?name_hu)
                (group_concat(distinct ?name_id;separator="#") as ?name_id)
                (group_concat(distinct ?name_it;separator="#") as ?name_it)
                (group_concat(distinct ?name_ja;separator="#") as ?name_ja)
                (group_concat(distinct ?name_ko;separator="#") as ?name_ko)
                (group_concat(distinct ?name_nl;separator="#") as ?name_nl)
                (group_concat(distinct ?name_pl;separator="#") as ?name_pl)
                (group_concat(distinct ?name_pt;separator="#") as ?name_pt)
                (group_concat(distinct ?name_ru;separator="#") as ?name_ru)
                (group_concat(distinct ?name_sv;separator="#") as ?name_sv)
                (group_concat(distinct ?name_tr;separator="#") as ?name_tr)
                (group_concat(distinct ?disambiguation; separator = "#") as ?disambiguation)
                (SAMPLE(?population) as ?population)
                #(SAMPLE(?elev) as ?elevation)
            WHERE {
                {
                    SELECT DISTINCT  ?e ?i ?r
                    WHERE{
                        VALUES ?i { wd:Q2102493 wd:Q1781 }
                        OPTIONAL{ ?i owl:sameAs ?r. }
                        BIND(COALESCE(?r, ?i) AS ?e).
                    }
                }
                SERVICE wikibase:label {bd:serviceParam wikibase:language "en".}
                #OPTIONAL{?e p:P2044/psn:P2044/wikibase:quantityAmount ?elev}
                OPTIONAL{?e wdt:P1082 ?population .}
                OPTIONAL{?e rdfs:label ?name_ar FILTER((LANG(?name_ar))="ar").}
                OPTIONAL{?e rdfs:label ?name_bn FILTER((LANG(?name_bn))="bn").}
                OPTIONAL{?e rdfs:label ?name_de FILTER((LANG(?name_de))="de").}
                OPTIONAL{?e rdfs:label ?name_en FILTER((LANG(?name_en))="en").}
                OPTIONAL{?e rdfs:label ?name_es FILTER((LANG(?name_es))="es").}
                OPTIONAL{?e rdfs:label ?name_fr FILTER((LANG(?name_fr))="fr").}
                OPTIONAL{?e rdfs:label ?name_el FILTER((LANG(?name_el))="el").}
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
            }
            GROUP BY ?e ?i ?r
    """
    query_template_part_b = """
         PREFIX geo: <http://www.opengis.net/ont/geosparql#>
            SELECT
                ?e ?i ?r
                (group_concat(distinct ?name_uk;separator="#") as ?name_uk)
                (group_concat(distinct ?name_ur;separator="#") as ?name_ur)
                (group_concat(distinct ?name_vi;separator="#") as ?name_vi)
                (group_concat(distinct ?name_zh;separator="#") as ?name_zh)
                (group_concat(distinct ?disambiguation; separator = "#") as ?disambiguation)
                (SAMPLE(?population) as ?population)
                #(SAMPLE(?elev) as ?elevation)
            WHERE {
                {
                    SELECT DISTINCT  ?e ?i ?r
                    WHERE{
                        VALUES ?i { wd:Q2102493 wd:Q1781 }
                        OPTIONAL{ ?i owl:sameAs ?r. }
                        BIND(COALESCE(?r, ?i) AS ?e).
                    }
                }
                SERVICE wikibase:label {bd:serviceParam wikibase:language "en".}
                OPTIONAL{?e rdfs:label ?name_uk FILTER((LANG(?name_uk))="uk").}
                OPTIONAL{?e rdfs:label ?name_ur FILTER((LANG(?name_ur))="ur").}
                OPTIONAL{?e rdfs:label ?name_vi FILTER((LANG(?name_vi))="vi").}
                OPTIONAL{?e rdfs:label ?name_zh FILTER((LANG(?name_zh))="zh").}
            }
            GROUP BY ?e ?i ?r
    """

    wikidata_sparql_ids = ""
    for wid in a_wid:
        wikidata_sparql_ids += " wd:"+wid

    print("fetch: ", wikidata_sparql_ids.split()[1], "... ", wikidata_sparql_ids.split()[-1])
    ne_query_part_a = query_template_part_a.replace('wd:Q2102493 wd:Q1781', wikidata_sparql_ids)
    ne_query_part_b = query_template_part_b.replace('wd:Q2102493 wd:Q1781', wikidata_sparql_ids)

    # compress the Query -  removing the extra spaces
    while '  ' in ne_query_part_a:
        ne_query_part_a = ne_query_part_a.replace('  ', ' ')

    while '  ' in ne_query_part_b:
        ne_query_part_b = ne_query_part_b.replace('  ', ' ')

    results = None
    retries = 0
    while results is None and retries < 8:
        try:
            results = None
            results_part_a = None
            results_part_b = None

            sparql.setQuery(ne_query_part_a)
            sparql.setTimeout(1000)
            sparql.setReturnFormat(JSON)
            results_part_a = sparql.query().convert()

            sparql.setQuery(ne_query_part_b)
            sparql.setTimeout(1000)
            sparql.setReturnFormat(JSON)
            results_part_b = sparql.query().convert()

            results_part_a = results_part_a['results']['bindings']

            # Loop ove the wd_id and merge the name translations into one dict
            for result_a in results_part_a:
                # e has the value of the wikidata_id
                for result_b in results_part_b['results']['bindings']:
                    if result_a['e']['value'] == result_b['e']['value']:
                        for key in result_b:
                            result_a[key] = result_b[key]

            return results_part_a

        except SPARQLExceptions.EndPointNotFound:
            print('ERRwikidata-SPARQLExceptions-EndPointNotFound:  Retrying in 30 seconds.')
            time.sleep(30)
            retries += 1
            continue

        except SPARQLExceptions.EndPointInternalError:
            print("ERRwikidata-SPARQLExceptions-EndPointInternalError: Retrying in 30 seconds.")
            time.sleep(30)
            retries += 1
            continue

        except SPARQLExceptions.QueryBadFormed:
            print("ERRwikidata-SPARQLExceptions-QueryBadFormed : Check!  ")
            return "error"

        except TimeoutError:
            print("ERRwikidata-SPARQLExceptions  TimeOut : Retrying in 1 seconds.")
            time.sleep(1)
            retries += 1
            continue

        except KeyboardInterrupt:
            # quit
            sys.exit()

        except:
            print("ERRwikidata: other error. Retrying in 3 seconds.")
            print('error: %s %s %s %s' % sys.exc_info()[0].code)
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
        "ne_id",
        "wd_id",
        "wd_id_new",
        "population",
        #"elevation",
        "name_ar",
        "name_bn",
        "name_de",
        "name_en",
        "name_es",
        "name_fr",
        "name_el",
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
        "name_zh"
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

            # TODO: wire ne_id thru wikidata_id return
            ne_id = -1

            #if args.input_lettercase == "lowercase":
            #    ne_id = pt['properties']['ne_id']
            #else:
            #    ne_id = pt['PROPERTIES']['NE_ID']

            if ne_wikidataid:
                if ne_wikidataid[0] == 'Q':
                    wikidata_chunk.append(ne_wikidataid)
                else:
                    print("ERROR: Bad formatted wikidataid , skip", ne_wikidataid)

            if (len(wikidata_chunk) >= 200) or (i >= REC_IN_SHAPE):

                sparql_results = fetchwikidata(wikidata_chunk)
                wikidata_chunk = []

                #print(sparql_results)

                for result in sparql_results:
                    wd_id_label = result.get('e', {}).get('value', '')
                    if wd_id_label != '':
                        wd_id_label = wd_id_label.split('/')[4]
                    wd_id = result.get('i', {}).get('value', '')
                    if wd_id != '':
                        wd_id = wd_id.split('/')[4]
                    wd_id_new = result.get('r', {}).get('value', '')
                    if wd_id_new != '':
                        wd_id_new = wd_id_new.split('/')[4]
                        print('Redirected:', wd_id, wd_id_new)

                    population = result.get('population', {}).get('value', -1)
                    #elevation = result.get('elevation', -9999)

                    name_ar = result.get('name_ar', {}).get('value', '')
                    name_bn = result.get('name_bn', {}).get('value', '')
                    name_de = result.get('name_de', {}).get('value', '')
                    name_en = result.get('name_en', {}).get('value', '')
                    name_es = result.get('name_es', {}).get('value', '')
                    name_fr = result.get('name_fr', {}).get('value', '')
                    name_el = result.get('name_el', {}).get('value', '')
                    name_he = result.get('name_he', {}).get('value', '')
                    name_hi = result.get('name_hi', {}).get('value', '')
                    name_hu = result.get('name_hu', {}).get('value', '')
                    name_id = result.get('name_id', {}).get('value', '')
                    name_it = result.get('name_it', {}).get('value', '')
                    name_ja = result.get('name_ja', {}).get('value', '')
                    name_ko = result.get('name_ko', {}).get('value', '')
                    name_nl = result.get('name_nl', {}).get('value', '')
                    name_pl = result.get('name_pl', {}).get('value', '')
                    name_pt = result.get('name_pt', {}).get('value', '')
                    name_ru = result.get('name_ru', {}).get('value', '')
                    name_sv = result.get('name_sv', {}).get('value', '')
                    name_tr = result.get('name_tr', {}).get('value', '')
                    name_uk = result.get('name_uk', {}).get('value', '')
                    name_ur = result.get('name_ur', {}).get('value', '')
                    name_vi = result.get('name_vi', {}).get('value', '')
                    name_zh = result.get('name_zh', {}).get('value', '')

                    writer.writerow((
                        ne_id,
                        wd_id,
                        wd_id_new,
                        population,
                        #elevation,
                        name_ar,
                        name_bn,
                        name_de,
                        name_en,
                        name_es,
                        name_fr,
                        name_el,
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
                        name_zh
                        ))

print(' - JOB end -')
