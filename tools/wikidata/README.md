# TLDR

```bash
#Install/Update python3 modules  ( tested with Python 3.6 / Ubuntu  )
   pip3 install -U SPARQLWrapper
   pip3 install -U fiona
   pip3 install -U csvtomd
   pip3 install -U requests
   pip3 install -U hanzidentifier

#run from the project root ( expected 30-40 minutes )
# be careful this is running  'make all'
  ./run_all.sh

# Check the log file
cat x_tempshape/run_all.log

# Check the summary ..
x_tempshape/update.md

# Check the individula changes - every tables - in the temp_shape/*
# Check the logs & shape files
# if everything is ok, move the shape files to the correct folder

```




# Run individual process ( updating "10m_physical/ne_10m_lakes_north_america.shp" )

```bash
#                          |mode |LetterCase| shape_path  |  shape filename
# == 10m ================= |==== |==========| ============| ================================================
./tools/wikidata/update.sh  all   lowercase   10m_physical  ne_10m_lakes_north_america
```

mode =
* fetch  = fetch Wikidata Labels(names) via SPARQL - and create a csv file
* write  = create a new temp Shape file with the new wikidata names
* fetch_write =   fetch and write
* copy   =  copy the temp Shape + audit files to the original place
* all    =  fetch + write + copy


step by step
```bash
#                          |mode        |LetterCase| shape_path  |  shape filename
# ======================== |=========== |==========| ============| ================================================
# fetch Wikidata Labels(names) via SPARQL - and create a csv file
./tools/wikidata/update.sh  fetch         lowercase   10m_physical  ne_10m_lakes_north_america

# create a new temp Shape file with the new wikidata names
./tools/wikidata/update.sh  write         lowercase   10m_physical  ne_10m_lakes_north_america

# copy the temp Shape + audit files to the original place
./tools/wikidata/update.sh  copy          lowercase   10m_physical  ne_10m_lakes_north_america

```

# ./tools/wikidata/update.sh fetch ...

`./tools/wikidata/update.sh  fetch         lowercase   10m_physical  ne_10m_lakes_north_america`
*  list input shape file variables
*  query all wikida labels
*  write output : `x_tempshape/10m_physical/ne_10m_lakes_north_america.new_names.csv`


Example log:
```log
$ ./tools/wikidata/update.sh  fetch         lowercase   10m_physical  ne_10m_lakes_north_america

########## /tools/wikidata/update.sh parameters:
 1: mode           :  fetch
 2: nei_letter_case:  lowercase
 3: neo_path       :  x_tempshape
 4: ne_shapepath   :  10m_physical
 5: ne_shapefile   :  ne_10m_lakes_north_america


 Fetch wikidata labels
 =================================
INFO: Open of `./10m_physical/ne_10m_lakes_north_america.shp'
      using driver `ESRI Shapefile' successful.

Layer name: ne_10m_lakes_north_america
Geometry: Polygon
Feature Count: 1200
Extent: (-164.284110, 8.988349) - (-18.569997, 82.292487)
Layer SRS WKT:
GEOGCS["GCS_WGS_1984",
    DATUM["WGS_1984",
        SPHEROID["WGS_84",6378137,298.257223563]],
    PRIMEM["Greenwich",0],
    UNIT["Degree",0.017453292519943295],
    AUTHORITY["EPSG","4326"]]
uident: Real (25.9)
featurecla: String (50.0)
name: String (100.0)
name_alt: String (100.0)
note: String (100.0)
scalerank: Integer64 (10.0)
min_zoom: Real (6.1)
min_label: Real (4.1)
label: String (254.0)
wikidataid: String (254.0)
name_ar: String (254.0)
name_bn: String (254.0)
name_de: String (254.0)
name_en: String (254.0)
name_es: String (254.0)
name_fr: String (254.0)
name_el: String (254.0)
name_hi: String (254.0)
name_hu: String (254.0)
name_id: String (254.0)
name_it: String (254.0)
name_ja: String (254.0)
name_ko: String (254.0)
name_nl: String (254.0)
name_pl: String (254.0)
name_pt: String (254.0)
name_ru: String (254.0)
name_sv: String (254.0)
name_tr: String (254.0)
name_vi: String (254.0)
name_zh: String (254.0)
wdid_score: Integer (1.0)
ne_id: Integer64 (10.0)
- Start fetching Natural-Earth wikidata labels via SPARQL query -
fetch:  wd:Q6474657 ...  wd:Q5594723
fetch:  wd:Q5034223 ...  wd:Q4208879
Redirected: Q22702352 Q1799606
fetch:  wd:Q3114698 ...  wd:Q595625
 - JOB end -
 created : x_tempshape/10m_physical/ne_10m_lakes_north_america.new_names.csv


```

#### x_tempshape/10m_physical/ne_10m_lakes_north_america.new_names.csv

```csv
"wd_id","wd_id_new","population","name_ar","name_bn","name_de","name_en","name_es","name_fr","name_el","name_hi","name_hu","name_id","name_it","name_ja","name_ko","name_nl","name_pl","name_pt","name_ru","name_sv","name_tr","name_vi","name_zh"
"Q4397897","","","","","","Ross Barnett Reservoir","","","","","","","","","","","","","Росс Барнетт","","","",""
"Q1426999","","","","","Theodore Roosevelt Lake","Theodore Roosevelt Lake","","","","","","","","","","","","","Рузвельт","","","",""
"Q175554","","","","","Walker Lake","Walker Lake","","Walker Lake","","","Walker-tó","","","ウォーカー湖","","Walker Lake","","","Уокер","","","",""
"Q6908686","","","","","","Mooselookmeguntic Lake","","Mooselookmeguntic Lake","","","","","","","","","","","Муслукмегантик","","","",""
"Q1110527","","","","","Priest Lake","Priest Lake","","Priest Lake","","","","","","","","","","","Прист","","","",""
"Q1627906","","","","","","Caddo Lake","","lac Caddo","","","","","lago Caddo","","","Caddo Lake","","Lago Caddo","Каддо","","","",""
"Q4261031","","","","","","Lake Livingston","","lac Livingston","","","","","","","","","","","Ливингстон","","","",""
"Q4231229","","","","","","Lake Conroe","","Lake Conroe","","","","","","","","","","","Конро","","","",""
"Q2365354","","","","","Summer Lake","Summer Lake","","Summer Lake","","","","","","","","","","","Саммер","","","",""
...
```


# ./tools/wikidata/update.sh write ...

` ./tools/wikidata/update.sh  write         lowercase   10m_physical  ne_10m_lakes_north_america`
* create new temp shapefile
* create some audits logs, statistics

```log
$ ./tools/wikidata/update.sh  write         lowercase   10m_physical  ne_10m_lakes_north_america

########## /tools/wikidata/update.sh parameters:
 1: mode           :  write
 2: nei_letter_case:  lowercase
 3: neo_path       :  x_tempshape
 4: ne_shapepath   :  10m_physical
 5: ne_shapefile   :  ne_10m_lakes_north_america


 Write shapefile with wikidata labels
 =================================
 shapefile info : x_tempshape/10m_physical/ne_10m_lakes_north_america

name_en/NAME_EN changes  x_tempshape/10m_physical/ne_10m_lakes_north_america)
---------------------
Q1800890   |  MODvalue  |  name_en     |  Lake Chemong     |  Chemong Lake

shapefilename                                  |  var                     |  value
-----------------------------------------------|--------------------------|-------
./10m_physical/ne_10m_lakes_north_america.shp  |  New_name                |  12
./10m_physical/ne_10m_lakes_north_america.shp  |  Deleted_name            |  0
./10m_physical/ne_10m_lakes_north_america.shp  |  Modified_name           |  3
./10m_physical/ne_10m_lakes_north_america.shp  |  Empty_name              |  7894
./10m_physical/ne_10m_lakes_north_america.shp  |  Same_name               |  1604
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_redirected   |  1
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_notfound     |  0
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_null         |  747
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_notnull      |  453
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_badformated  |  0

 (write) created :
 -------------------
-rw-r--r-- 1     942 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.changes_log.csv
-rw-r--r-- 1    1393 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.changes_log.csv.md
-rw-r--r-- 1       5 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.cpg
-rw-r--r-- 1 7499890 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.dbf
-rw-r--r-- 1   57604 May 20 19:23 x_tempshape/10m_physical/ne_10m_lakes_north_america.new_names.csv
-rw-r--r-- 1     143 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.prj
-rw-r--r-- 1  573424 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.shp
-rw-r--r-- 1    9700 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.shx
-rw-r--r-- 1     749 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.summary_log.csv
-rw-r--r-- 1     967 May 20 19:27 x_tempshape/10m_physical/ne_10m_lakes_north_america.summary_log.csv.md


```

#### write - audit log: x_tempshape/10m_physical/ne_10m_lakes_north_america.changes_log.csv.md

```
$ cat  x_tempshape/10m_physical/ne_10m_lakes_north_america.changes_log.csv.md
wd_id      |  status    |  variable    |  value_old        |  value_new
-----------|------------|--------------|-------------------|-----------------------------------
Q1323525   |  NEWvalue  |  name_ko     |                   |  워싱턴 호
Q1323525   |  NEWvalue  |  name_pl     |                   |  Washington
Q1495651   |  NEWvalue  |  name_sv     |                   |  Lake George
Q1627906   |  NEWvalue  |  name_pt     |                   |  Lago Caddo
Q7356585   |  MODvalue  |  name_fr     |  William          |  William 'Bill' Dannelly Reservoir
Q13700     |  NEWvalue  |  name_tr     |                   |  Texcoco Gölü
Q15118728  |  NEWvalue  |  name_en     |                   |  Little Salmon Lake
Q16931868  |  NEWvalue  |  name_sv     |                   |  Athapapuskow Lake
Q7236081   |  NEWvalue  |  name_de     |                   |  Powell Lake
Q7236081   |  NEWvalue  |  name_es     |                   |  Powell Lake
Q7236081   |  NEWvalue  |  name_it     |                   |  Powell Lake
Q7236081   |  NEWvalue  |  name_nl     |                   |  Powell Lake
Q22702352  |  REDIRECT  |  wikidataid  |  Q22702352        |  Q1799606
Q22702352  |  MODvalue  |  name_de     |  lac Pusticamica  |  Lac Pusticamica
Q1800890   |  MODvalue  |  name_en     |  Lake Chemong     |  Chemong Lake
Q1800890   |  NEWvalue  |  name_sv     |                   |  Chemong Lake
```

### write - summary audit log: x_tempshape/10m_physical/ne_10m_lakes_north_america.summary_log.csv.md

```
$ cat x_tempshape/10m_physical/ne_10m_lakes_north_america.summary_log.csv.md
shapefilename                                  |  var                     |  value
-----------------------------------------------|--------------------------|-------
./10m_physical/ne_10m_lakes_north_america.shp  |  New_name                |  12
./10m_physical/ne_10m_lakes_north_america.shp  |  Deleted_name            |  0
./10m_physical/ne_10m_lakes_north_america.shp  |  Modified_name           |  3
./10m_physical/ne_10m_lakes_north_america.shp  |  Empty_name              |  7894
./10m_physical/ne_10m_lakes_north_america.shp  |  Same_name               |  1604
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_redirected   |  1
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_notfound     |  0
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_null         |  747
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_notnull      |  453
./10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_badformated  |  0

```


# ./tools/wikidata/update.sh copy ...

Be careful with copy mode!

`./tools/wikidata/update.sh  copy         lowercase   10m_physical  ne_10m_lakes_north_america`
* copy the new files (shape + audit) to the original place



```
$ ./tools/wikidata/update.sh  copy         lowercase   10m_physical  ne_10m_lakes_north_america

########## /tools/wikidata/update.sh parameters:
 1: mode           :  copy
 2: nei_letter_case:  lowercase
 3: neo_path       :  x_tempshape
 4: ne_shapepath   :  10m_physical
 5: ne_shapefile   :  ne_10m_lakes_north_america


 Copy shape + audit files
 ===============================
'x_tempshape/10m_physical/ne_10m_lakes_north_america.changes_log.csv' -> '10m_physical/ne_10m_lakes_north_america.changes_log.csv'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.changes_log.csv.md' -> '10m_physical/ne_10m_lakes_north_america.changes_log.csv.md'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.cpg' -> '10m_physical/ne_10m_lakes_north_america.cpg'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.dbf' -> '10m_physical/ne_10m_lakes_north_america.dbf'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.new_names.csv' -> '10m_physical/ne_10m_lakes_north_america.new_names.csv'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.prj' -> '10m_physical/ne_10m_lakes_north_america.prj'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.shp' -> '10m_physical/ne_10m_lakes_north_america.shp'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.shx' -> '10m_physical/ne_10m_lakes_north_america.shx'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.summary_log.csv' -> '10m_physical/ne_10m_lakes_north_america.summary_log.csv'
'x_tempshape/10m_physical/ne_10m_lakes_north_america.summary_log.csv.md' -> '10m_physical/ne_10m_lakes_north_america.summary_log.csv.md'

```




# My best practice ...

* checkout the original shape files
* Run step by step  ( line by line , table by table )  from  the `./run_all.sh` in  `fetch_write` mode
* check the audit csv files ( Open by Libreoffice , filter )
* find & fix the 'fake' wikidata changes  :(
* iterate or modify input csv and write shape files
* check shape files
  * if OK -  move the shape files to the correct folders:  `./tools/wikidata/update.sh  copy ...`


# known problems

### updating   10m_cultural/ne_10m_admin_1_label_points_details.shp

I got a lot of warnings:
```
WARNING:Fiona:CPLE_AppDefined in b'Value -4.75267000000000017 of field longitude of feature 4645 not successfully written. Possibly due to too larger number with respect to field width'
WARNING:Fiona:CPLE_AppDefined in b'Value 10.2509999999999994 of field latitude of feature 4646 not successfully written. Possibly due to too larger number with respect to field width'
WARNING:Fiona:CPLE_AppDefined in b'Value -3.34011000000000013 of field longitude of feature 4646 not successfully written. Possibly due to too larger number with respect to field width'
...
```



###  uppercase / lowercase  variable names



lettercase = uppercase variable names [WIKIDATAID, NAME_AR, NAME_BN, NAME_DE, NAME_EN, NAME_ES, ... ]
* 10m_cultural/ne_10m_admin_0_countries_lakes.shp
* 10m_cultural/ne_10m_admin_0_countries.shp
* 10m_cultural/ne_10m_admin_0_disputed_areas.shp
* 10m_cultural/ne_10m_admin_0_map_subunits.shp
* 10m_cultural/ne_10m_admin_0_map_units.shp
* 10m_cultural/ne_10m_admin_0_sovereignty.shp
* 50m_cultural/....
* 110m_cultural/....

lettercase = lowercase variable names [wikidataid, name_ar, name_bn, name_de, name_en, name_es, ... ]
* 10m_cultural/ne_10m_admin_1_states_provinces_lakes.shp
* 10m_cultural/ne_10m_admin_1_states_provinces.shp
* 10m_cultural/ne_10m_airports.shp
* 10m_cultural/ne_10m_populated_places.shp
* 10m_physical/ne_10m_geographic_lines.shp
* 10m_physical/ne_10m_geography_marine_polys.shp
* 10m_physical/ne_10m_geography_regions_elevation_points.shp
* 10m_physical/ne_10m_geography_regions_points.shp
* 10m_physical/ne_10m_geography_regions_polys.shp
* 10m_physical/ne_10m_lakes_europe.shp
* 10m_physical/ne_10m_lakes_historic.shp
* 10m_physical/ne_10m_lakes_north_america.shp
* 10m_physical/ne_10m_lakes.shp
* 10m_physical/ne_10m_playas.shp
* 10m_physical/ne_10m_rivers_europe.shp
* 10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp
* 10m_physical/ne_10m_rivers_lake_centerlines.shp
* 10m_physical/ne_10m_rivers_north_america.shp
* 10m_cultural/ne_10m_admin_1_label_points_details.shp
* 50m_cultural/...
* 50m_physical/...
* 110m_cultural/...
* 110m_physical/...

see the _latest_  information in the `./run_all.sh`


### supported languages ( now: 26)

variable name | language              | language wikipedia link
--------------|-----------------------|----------------------------------------------------
 NAME_AR 	  | Arabic                | https://en.wikipedia.org/wiki/Arabic
 NAME_BN 	  | Bengali               | https://en.wikipedia.org/wiki/Bengali_language
 NAME_DE 	  | German                | https://en.wikipedia.org/wiki/German_language
 NAME_EN 	  | English               | https://en.wikipedia.org/wiki/English_language
 NAME_EL 	  | Greek (modern)        | https://en.wikipedia.org/wiki/Modern_Greek
 NAME_ES 	  | Spanish               | https://en.wikipedia.org/wiki/Spanish_language
 NAME_FA 	  | Farsi                 | https://en.wikipedia.org/wiki/Persian_language
 NAME_FR 	  | French                | https://en.wikipedia.org/wiki/French_language
 NAME_HE 	  | Hebrew     	          | https://en.wikipedia.org/wiki/Hebrew_language
 NAME_HI 	  | Hindi     	          | https://en.wikipedia.org/wiki/Hindi
 NAME_HU 	  | Hungarian 	          | https://en.wikipedia.org/wiki/Hungarian_language
 NAME_ID 	  | Indonesian            | https://en.wikipedia.org/wiki/Indonesian_language
 NAME_IT 	  | Italian               | https://en.wikipedia.org/wiki/Italian_language
 NAME_JA 	  | Japanese              | https://en.wikipedia.org/wiki/Japanese_language
 NAME_KO 	  | Korean                | https://en.wikipedia.org/wiki/Korean_language
 NAME_NL 	  | Dutch                 | https://en.wikipedia.org/wiki/Dutch_language
 NAME_PL 	  | Polish                | https://en.wikipedia.org/wiki/Polish_language
 NAME_PT 	  | Portuguese            | https://en.wikipedia.org/wiki/Portuguese_language
 NAME_RU 	  | Russian               | https://en.wikipedia.org/wiki/Russian_language
 NAME_SV 	  | Swedish               | https://en.wikipedia.org/wiki/Swedish_language
 NAME_TR 	  | Turkish               | https://en.wikipedia.org/wiki/Turkish_language
 NAME_UK 	  | Ukrainian             | https://en.wikipedia.org/wiki/Ukrainian_language
 NAME_UR 	  | Urdu                  | https://en.wikipedia.org/wiki/Urdu
 NAME_VI 	  | Vietnamese            | https://en.wikipedia.org/wiki/Vietnamese_language
 NAME_ZH 	  | Chinese (simplified)  | https://en.wikipedia.org/wiki/Chinese_language
 NAME_ZHT 	  | Chinese (traditional) | https://en.wikipedia.org/wiki/Traditional_Chinese_characters

# Name cleaning

minimal regexp implementation, hard coded in the `write_wikidata.py`

TODO :  need better implementation.


### remove `river`
if  the shape file name contain trigger word  ('river') - run regexp.

```python
riverclean_regex = re.compile(r'\b('+'River'+r')\b',  flags=re.IGNORECASE)
....
    if args.input_shape.lower().find('river') > 0:
        wddic[qid][d] = riverclean_regex.sub('', wddic[qid][d])
....
```

changes written to the log.
```
Q1330818 name_en  name cleaning :  Pite River  -->   Pite
Q16663 name_en  name cleaning :  Alagón River  -->   Alagón
Q14764 name_en  name cleaning :  Esla river  -->   Esla
Q14755 name_en  name cleaning :  Tormes River  -->   Tormes
Q71122 name_en  name cleaning :  Chir River  -->   Chir
Q192157 name_en  name cleaning :  Belaya River  -->   Belaya
Q202796 name_en  name cleaning :  Desna River  -->   Desna

```


### remove `Municipality of|Municipality|First Nation` words


if  the shape file name contain trigger word  ('place') - run regexp.

```python
placeclean_regex = re.compile(r'\b('+'Municipality of|Municipality|First Nation'+r')\b',
                              flags=re.IGNORECASE)

   ...
    # Places ...
    if args.input_shape.lower().find('place') > 0:
        wddic[qid][d] = placeclean_regex.sub('', wddic[qid][d])

        ... remove 市(city)
```

example changes:
```
Q3078079 name_en  name cleaning :  Fort Severn First Nation  -->   Fort Severn
Q3078079 name_nl  name cleaning :  Fort Severn First Nation  -->   Fort Severn
```

###  remove 市(city)

example changes:

```
Q68695 name_zh  name cleaning :  泉州市  -->   泉州
Q74881 name_zh  name cleaning :  大连市  -->   大连
Q74957 name_zh  name cleaning :  鞍山市  -->   鞍山
Q92381 name_zh  name cleaning :  白城市  -->   白城
```
