#--  pip3 install -U SPARQLWrapper
#--  pip3 install -U fiona

import argparse
import csv
import requests
import time
import fiona
from SPARQLWrapper import SPARQLWrapper, JSON

parser = argparse.ArgumentParser(description='Fetch wikidata labels for Natural-Earth ')

parser.add_argument('-input_shape_name', default='../../10m_cultural/ne_10m_populated_places.shp',  help='input natural-earth shape file - with wikidataid columns')
parser.add_argument('-output_csv_name', default='ne_10m_populated_places.csv',  help='output csv file with wikidata labels')


args = parser.parse_args()


def get_sparql_value(result,id):
    val=''
    if id in result:
        val = result[id]['value']
    return val

def get_sparql_label(result,id):
    val=''
    if id in result:
        val = result[id]['value'].split('#')[0].split('(')[0].split(',')[0]
    return val

def get_sparql_numvalue(result,id):
    val=-1
    if id in result:
        val = float(result[id]['value'])
    return val


def fetchwikidata( wid ):

    sparql = SPARQLWrapper("https://query.wikidata.org/sparql")
    query_template="""        
            PREFIX geo: <http://www.opengis.net/ont/geosparql#>
            SELECT
                ?entity
                ?entityLabel
                ?entityDescription
            
                (group_concat(distinct  ?pLabel  ; separator = "#")       as ?type_grp)

                (group_concat(distinct ?name_ar ; separator="#") as ?name_ar)
                (group_concat(distinct ?name_bn ; separator="#") as ?name_bn)
                (group_concat(distinct ?name_de ; separator="#") as ?name_de)
                (group_concat(distinct ?name_en ; separator="#") as ?name_en)
                (group_concat(distinct ?name_es ; separator="#") as ?name_es)
                (group_concat(distinct ?name_fr ; separator="#") as ?name_fr)
                (group_concat(distinct ?name_el ; separator="#") as ?name_el)
                (group_concat(distinct ?name_hi ; separator="#") as ?name_hi)
                (group_concat(distinct ?name_hu ; separator="#") as ?name_hu)
                (group_concat(distinct ?name_id ; separator="#") as ?name_id)
                (group_concat(distinct ?name_it ; separator="#") as ?name_it)
                (group_concat(distinct ?name_ja ; separator="#") as ?name_ja)
                (group_concat(distinct ?name_ko ; separator="#") as ?name_ko)
                (group_concat(distinct ?name_nl ; separator="#") as ?name_nl)
                (group_concat(distinct ?name_pl ; separator="#") as ?name_pl)
                (group_concat(distinct ?name_pt ; separator="#") as ?name_pt)
                (group_concat(distinct ?name_ru ; separator="#") as ?name_ru)
                (group_concat(distinct ?name_sv ; separator="#") as ?name_sv)
                (group_concat(distinct ?name_tr ; separator="#") as ?name_tr)
                (group_concat(distinct ?name_vi ; separator="#") as ?name_vi)
                (group_concat(distinct ?name_zh ; separator="#") as ?name_zh)

                (group_concat(distinct  ?disambiguation; separator = "#")       as ?disambiguation)
                
            WHERE {
                VALUES ?entity { wd:Q1781 }
            
                SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
                
                OPTIONAL { ?entity wdt:P31 ?property.  ?property rdfs:label ?pLabel         FILTER (lang(?pLabel) = "en").         }
                OPTIONAL { ?entity wdt:P17 ?country.   ?country  rdfs:label ?countryLabelx  FILTER (lang(?countryLabelx) = "en").  }
            
                OPTIONAL { ?entity wdt:P17       ?country.     }

                OPTIONAL { ?entity  wdt:P31/wdt:P279*  wd:Q4167410 . BIND( "disambiguation" AS ?disambiguation). }

                OPTIONAL { ?entity rdfs:label ?name_ar  FILTER((LANG(?name_ar)) = "ar") . }
                OPTIONAL { ?entity rdfs:label ?name_bn  FILTER((LANG(?name_bn)) = "bn") . }
                OPTIONAL { ?entity rdfs:label ?name_de  FILTER((LANG(?name_de)) = "de") . }
                OPTIONAL { ?entity rdfs:label ?name_en  FILTER((LANG(?name_en)) = "en") . }
                OPTIONAL { ?entity rdfs:label ?name_es  FILTER((LANG(?name_es)) = "es") . }
                OPTIONAL { ?entity rdfs:label ?name_fr  FILTER((LANG(?name_fr)) = "fr") . }
                OPTIONAL { ?entity rdfs:label ?name_el  FILTER((LANG(?name_el)) = "el") . }
                OPTIONAL { ?entity rdfs:label ?name_hi  FILTER((LANG(?name_hi)) = "hi") . }
                OPTIONAL { ?entity rdfs:label ?name_hu  FILTER((LANG(?name_hu)) = "hu") . }
                OPTIONAL { ?entity rdfs:label ?name_id  FILTER((LANG(?name_id)) = "id") . }
                OPTIONAL { ?entity rdfs:label ?name_it  FILTER((LANG(?name_it)) = "it") . }
                OPTIONAL { ?entity rdfs:label ?name_ja  FILTER((LANG(?name_ja)) = "ja") . }
                OPTIONAL { ?entity rdfs:label ?name_ko  FILTER((LANG(?name_ko)) = "ko") . }
                OPTIONAL { ?entity rdfs:label ?name_nl  FILTER((LANG(?name_nl)) = "nl") . }
                OPTIONAL { ?entity rdfs:label ?name_pl  FILTER((LANG(?name_pl)) = "pl") . }
                OPTIONAL { ?entity rdfs:label ?name_pt  FILTER((LANG(?name_pt)) = "pt") . }
                OPTIONAL { ?entity rdfs:label ?name_ru  FILTER((LANG(?name_ru)) = "ru") . }
                OPTIONAL { ?entity rdfs:label ?name_sv  FILTER((LANG(?name_sv)) = "sv") . }
                OPTIONAL { ?entity rdfs:label ?name_tr  FILTER((LANG(?name_tr)) = "tr") . }
                OPTIONAL { ?entity rdfs:label ?name_vi  FILTER((LANG(?name_vi)) = "vi") . }
                OPTIONAL { ?entity rdfs:label ?name_zh  FILTER((LANG(?name_zh)) = "zh") . }

            }
            GROUP BY ?entity ?entityLabel   ?entityDescription
    """

    q=query_template.replace('Q1781',wid)
    sparql.setQuery(q)
    sparql.setTimeout(1000)

    sparql.setReturnFormat(JSON)
    results = sparql.query().convert()
    return results

print('- Start Natural-Earth wikidata label query - ')


with open(args.output_csv_name, "w", encoding='utf-8') as f:
    writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    writer.writerow(("ne_fid","wd_id"
        ,"name_ar"
        ,"name_bn"
        ,"name_de"
        ,"name_en"
        ,"name_es"
        ,"name_fr"
        ,"name_el"
        ,"name_hi"
        ,"name_hu"
        ,"name_id"
        ,"name_it"
        ,"name_ja"
        ,"name_ko"
        ,"name_nl"
        ,"name_pl"
        ,"name_pt"
        ,"name_ru"
        ,"name_sv"
        ,"name_tr"
        ,"name_vi"
        ,"name_zh"
    ))


    with fiona.open( args.input_shape_name , 'r') as input:
        i=0
        rec=len(input)
        for pt in input:
            i=i+1

            #if i> 5:   
            #    continue
            #print(pt)

            ne_wikidataid=pt['properties']['wikidataid']
            ne_fid= pt['id']

            if ne_wikidataid=='':
                print(i,"/",rec," : ",ne_fid, ne_wikidataid)
                continue
            else:
                print(i,"/",rec," : ",ne_fid, ne_wikidataid)


            results=fetchwikidata( ne_wikidataid )
            for result in results["results"]["bindings"]:
                wd_id=get_sparql_value(result,'entity').split('/')[4]

                #wd_label=get_sparql_value(result,'entityLabel')

                #wd_description = get_sparql_value(result,'placeDescription')
                #wd_type = "#"+get_sparql_value(result,'type_grp')+"#"

                name_ar=get_sparql_label(result,'name_ar')
                name_bn=get_sparql_label(result,'name_bn')
                name_de=get_sparql_label(result,'name_de')
                name_en=get_sparql_label(result,'name_en')
                name_es=get_sparql_label(result,'name_es')
                name_fr=get_sparql_label(result,'name_fr')
                name_el=get_sparql_label(result,'name_el')
                name_hi=get_sparql_label(result,'name_hi')
                name_hu=get_sparql_label(result,'name_hu')
                name_id=get_sparql_label(result,'name_id')
                name_it=get_sparql_label(result,'name_it')
                name_ja=get_sparql_label(result,'name_ja')
                name_ko=get_sparql_label(result,'name_ko')
                name_nl=get_sparql_label(result,'name_nl')
                name_pl=get_sparql_label(result,'name_pl')
                name_pt=get_sparql_label(result,'name_pt')
                name_ru=get_sparql_label(result,'name_ru')
                name_sv=get_sparql_label(result,'name_sv')
                name_tr=get_sparql_label(result,'name_tr')
                name_vi=get_sparql_label(result,'name_vi')
                name_zh=get_sparql_label(result,'name_zh')

                writer.writerow((ne_fid,wd_id
                    ,name_ar
                    ,name_bn
                    ,name_de
                    ,name_en
                    ,name_es
                    ,name_fr
                    ,name_el
                    ,name_hi
                    ,name_hu
                    ,name_id
                    ,name_it
                    ,name_ja
                    ,name_ko
                    ,name_nl
                    ,name_pl
                    ,name_pt
                    ,name_ru
                    ,name_sv
                    ,name_tr
                    ,name_vi
                    ,name_zh
                    )) 

print(' - JOB end -')
