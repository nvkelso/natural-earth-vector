#!/usr/bin/env python3

#--  pip3 install -U fiona
#--  pip3 install -U shapely

import argparse
import csv
import fiona
import logging
import sys

from shapely.geometry import mapping, shape
from collections import defaultdict
logging.basicConfig(stream=sys.stderr, level=logging.INFO)

parser = argparse.ArgumentParser(description='Update wikidata labels for Natural-Earth ')
parser.add_argument('-input_shape', default='../../10m_cultural/ne_10m_populated_places.shp',  help='input natural-earth shape file - with wikidataid columns')
parser.add_argument('-input_csv',   default='ne_10m_populated_places.csv',                     help='input csv file with the latest wikidataid name_XX columns')
parser.add_argument('-output_shape',default='ne_10m_populated_places_latest.shp',              help='output  natural-earth shape file - with updated wikidataid name_XX columns')
parser.add_argument('-output_csvlog',default='ne_10m_populated_places_latest.log.csv',         help='audit log about the changes')

args = parser.parse_args()


"""
read csv data
"""
wddic       = defaultdict(dict)
wdredirects = defaultdict(dict)
with open(args.input_csv , newline='') as csvfile:
     reader = csv.DictReader(csvfile)
     for row in reader:
         qid=row['wd_id']
         for d in row:
            if d != 'wd_id':
                #print(d, d[0:5])
                if d[0:5]=='name_': 
                    wddic[qid][d] =row[d].strip()

         #name_zh:  remove last "市""City" character
         if len(wddic[qid]['name_zh'])>0  and  wddic[qid]['name_zh'][-1] == "市":
            wddic[qid]['name_zh']=wddic[qid]['name_zh'][:-1]

        #"First Nation" ; "Municipality" ; "City"

         # check redirects           
         if row['wd_id_new'] != '': 
             wdredirects[qid]= row['wd_id_new']

#print( ':::', wddic['Q1046748']['name_de'])
print(wdredirects)
#sys.exit(1)


def writelog(wd_id,status,variable,value_old,value_new):
    writer.writerow((wd_id
        ,status
        ,variable
        ,value_old
        ,value_new
    ))   




with open(args.output_csvlog, "w", encoding='utf-8') as f:
    writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    writer.writerow(("wd_id"
        ,"status"
        ,"variable"
        ,"value_old"
        ,"value_new"
    ))


    with fiona.open(args.input_shape, 'r', encoding='utf-8', driver="ESRI Shapefile" ) as source:    
        # **source.meta is a shortcut to get the crs, driver, and schema
        # keyword arguments from the source Collection.
        with fiona.open(
                args.output_shape, 'w',encoding='utf-8',
                **source.meta) as sink:
            
            for f in source:
                
                try:
                    #print(f['id'], f['properties']['name_hu'])
                    qid=f['properties']['wikidataid']
                    if qid != '':
                        #print(qid,  f['properties']['name_en'] )
                        if qid in wddic:
                            #print(qid,  wddic[qid]['name_en']  )

                            #Update wikidataid if redirects 
                            if qid in wdredirects:
                                f['properties']['wikidataid'] = wdredirects[qid]
                                print ('diff:',qid, 'REDIRECT', 'wikidataid',  "#"+ f['properties']['wikidataid']+"#", '  !=  ',"#"+ wdredirects[qid]+"#"  ) 
                                writelog(qid,"REDIRECT",'wikidataid',qid,wdredirects[qid])

                            for updatefield in wddic[qid]:
                                if f['properties'][updatefield].strip() != wddic[qid][updatefield].strip():

                                    if f['properties'][updatefield].strip() =='':
                                        status='NEWvalue'
                                    elif  wddic[qid][updatefield].strip() =='':
                                        status='DELvalue'
                                    else:
                                        status='MODvalue'
                                        
                                    writelog(qid,status,updatefield,f['properties'][updatefield],wddic[qid][updatefield])

                                    if status !='NEWvalue':
                                        print ('diff:',qid, status, updatefield,  "#"+f['properties'][updatefield]+"#", '  !=  ',"#"+wddic[qid][updatefield]+"#"  )

                                    f['properties'][updatefield] = wddic[qid][updatefield].strip()
                                #else:
                                    #print ('OK :',qid, updatefield,  "#"+f['properties'][updatefield]+"#", '  ==  ',"#"+wddic[qid][updatefield]+"#"  )
                        else:
                            print("Missing:",qid ) 
                            #sys.exit(1) 
                    else:
                        print("empty:",  f['properties']['ne_id'] ) 
                        #sys.exit(1)                                
                    sink.write(f)
                    #print(f['id'], f['properties'])
                
                except Exception:
                    logging.exception("Error cleaning feature %s:", f['id'])
                    sys.exit(1)






