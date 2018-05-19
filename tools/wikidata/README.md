# TLDR

```bash
#Install/Update python3 modules  ( tested with Python 3.6 / Ubuntu  )
   pip3 install -U SPARQLWrapper
   pip3 install -U fiona
   pip3 install -U csvtomd
   pip3 install -U requests

#run from the project root ( expected 10-20 minutes )
   time ./tools/wikidata/update.sh fetch   # download new names from wikidata as a csvfile
   time ./tools/wikidata/update.sh write   # update shape files with the csv files
   cat ./temp_shape/update.md

#  See the changes:  temp_shape/*
#  Check the logs & shape files
#  if everything is ok, move the shape files to the correct folder

```




# Fetch all wikidata labels(names):

command:
`./tools/wikidata/update.sh fetch`

output - lot of csv files:
```
$ find ./temp_shape/*/*.csv
./temp_shape/10m_cultural/ne_10m_admin_0_countries_lakes.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_0_countries.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_0_disputed_areas.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_0_map_subunits.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_0_map_units.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_0_sovereignty.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_1_label_points_details.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_1_states_provinces_lakes.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_admin_1_states_provinces.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_airports.shp.new_names.csv
./temp_shape/10m_cultural/ne_10m_populated_places.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_geographic_lines.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_geography_marine_polys.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_geography_regions_elevation_points.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_geography_regions_points.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_geography_regions_polys.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_lakes_europe.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_lakes_historic.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_lakes.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_playas.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_rivers_europe.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_rivers_lake_centerlines.shp.new_names.csv
./temp_shape/10m_physical/ne_10m_rivers_north_america.shp.new_names.csv

```

# Write all wikidata labels(names):


command:
`./tools/wikidata/update.sh write`

Output - updated shape files and audit logs about the changes ...

summary of the changes: ./temp_shape/update.md

example:

```
$ find ./temp_shape/10m_physical/ne_10m_lakes_north_america*
./temp_shape/10m_physical/ne_10m_lakes_north_america.cpg
./temp_shape/10m_physical/ne_10m_lakes_north_america.dbf
./temp_shape/10m_physical/ne_10m_lakes_north_america.prj
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.changes_log.csv            # Column changes  - csv format
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.changes_log.csv.md         # Column changes  - markdown
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.new_names.csv              # input csv
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.summary_log.csv            # Summary of the changes - csv
./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.summary_log.csv.md         # Summary of the changes - markdown
./temp_shape/10m_physical/ne_10m_lakes_north_america.shx
```


### /temp_shape/10m_physical/ne_10m_lakes_north_america.shp.changes_log.csv            # Column changes  - csv format

```
"wd_id","status","variable","value_old","value_new"
"Q1323525","NEWvalue","name_ko","","워싱턴 호"
"Q7356585","MODvalue","name_fr","William","William 'Bill' Dannelly Reservoir"
"Q15118728","NEWvalue","name_en","","Little Salmon Lake"
"Q7236081","NEWvalue","name_de","","Powell Lake"
"Q7236081","NEWvalue","name_es","","Powell Lake"
"Q7236081","NEWvalue","name_it","","Powell Lake"
"Q7236081","NEWvalue","name_nl","","Powell Lake"
"Q22702352","REDIRECT","wikidataid","Q22702352","Q1799606"
"Q22702352","MODvalue","name_de","lac Pusticamica","Lac Pusticamica"
"Q1800890","MODvalue","name_en","Lake Chemong","Chemong Lake"
"Q1800890","NEWvalue","name_sv","","Chemong Lake"
```

### ./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.changes_log.csv.md         # Column changes  - markdown

wd_id      |  status    |  variable    |  value_old        |  value_new
-----------|------------|--------------|-------------------|-----------------------------------
Q1323525   |  NEWvalue  |  name_ko     |                   |  워싱턴 호
Q7356585   |  MODvalue  |  name_fr     |  William          |  William 'Bill' Dannelly Reservoir
Q15118728  |  NEWvalue  |  name_en     |                   |  Little Salmon Lake
Q7236081   |  NEWvalue  |  name_de     |                   |  Powell Lake
Q7236081   |  NEWvalue  |  name_es     |                   |  Powell Lake
Q7236081   |  NEWvalue  |  name_it     |                   |  Powell Lake
Q7236081   |  NEWvalue  |  name_nl     |                   |  Powell Lake
Q22702352  |  REDIRECT  |  wikidataid  |  Q22702352        |  Q1799606
Q22702352  |  MODvalue  |  name_de     |  lac Pusticamica  |  Lac Pusticamica
Q1800890   |  MODvalue  |  name_en     |  Lake Chemong     |  Chemong Lake
Q1800890   |  NEWvalue  |  name_sv     |                   |  Chemong Lake


### ./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.new_names.csv              # input csv

```bash
$ cat ./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.new_names.csv | head
"wd_id","wd_id_new","population","name_ar","name_bn","name_de","name_en","name_es","name_fr","name_el","name_hi","name_hu","name_id","name_it","name_ja","name_ko","name_nl","name_pl","name_pt","name_ru","name_sv","name_tr","name_vi","name_zh"
"Q1426999","","","","","Theodore Roosevelt Lake","Theodore Roosevelt Lake","","","","","","","","","","","","","Рузвельт","","","",""
"Q4397897","","","","","","Ross Barnett Reservoir","","","","","","","","","","","","","Росс Барнетт","","","",""
"Q175554","","","","","Walker Lake","Walker Lake","","Walker Lake","","","Walker-tó","","","ウォーカー湖","","Walker Lake","","","Уокер","","","",""
"Q6908686","","","","","","Mooselookmeguntic Lake","","Mooselookmeguntic Lake","","","","","","","","","","","Муслукмегантик","","","",""
"Q1110527","","","","","Priest Lake","Priest Lake","","Priest Lake","","","","","","","","","","","Прист","","","",""
"Q1627906","","","","","","Caddo Lake","","lac Caddo","","","","","lago Caddo","","","Caddo Lake","","","Каддо","","","",""
"Q4261031","","","","","","Lake Livingston","","lac Livingston","","","","","","","","","","","Ливингстон","","","",""
"Q4231229","","","","","","Lake Conroe","","Lake Conroe","","","","","","","","","","","Конро","","","",""
"Q2365354","","","","","Summer Lake","Summer Lake","","Summer Lake","","","","","","","","","","","Саммер","","","",""
...
```

### ./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.summary_log.csv            # Summary of the changes - csv

```csv
"shapefilename","var","value"
"10m_physical/ne_10m_lakes_north_america.shp","New_name","7"
"10m_physical/ne_10m_lakes_north_america.shp","Deleted_name","0"
"10m_physical/ne_10m_lakes_north_america.shp","Modified_name","3"
"10m_physical/ne_10m_lakes_north_america.shp","Empty_name ","7899"
"10m_physical/ne_10m_lakes_north_america.shp","Same_name","1604"
"10m_physical/ne_10m_lakes_north_america.shp","Wikidataid_redirected","1"
"10m_physical/ne_10m_lakes_north_america.shp","Wikidataid_notfound","0"
"10m_physical/ne_10m_lakes_north_america.shp","Wikidataid_null","747"
"10m_physical/ne_10m_lakes_north_america.shp","Wikidataid_notnull","453"
"10m_physical/ne_10m_lakes_north_america.shp","Wikidataid_badformated","0"
```


### ./temp_shape/10m_physical/ne_10m_lakes_north_america.shp.summary_log.csv.md         # Summary of the changes - markdown

shapefilename                                |  var                     |  value
---------------------------------------------|--------------------------|-------
10m_physical/ne_10m_lakes_north_america.shp  |  New_name                |  7
10m_physical/ne_10m_lakes_north_america.shp  |  Deleted_name            |  0
10m_physical/ne_10m_lakes_north_america.shp  |  Modified_name           |  3
10m_physical/ne_10m_lakes_north_america.shp  |  Empty_name              |  7899
10m_physical/ne_10m_lakes_north_america.shp  |  Same_name               |  1604
10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_redirected   |  1
10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_notfound     |  0
10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_null         |  747
10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_notnull      |  453
10m_physical/ne_10m_lakes_north_america.shp  |  Wikidataid_badformated  |  0


# My best practice ...


* First iteration
    `./tools/wikidata/update.sh fetch`
    `./tools/wikidata/update.sh write`

* check the audit csv files ( Open by Libreoffice , filter , check the wikidata history )
* find & fix the 'fake' wikidata changes  :(
* iterate or modify input csv and write shape files
* check shape files and move the shape files to the correct folders


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
* 10m_physical/ne_10m_rivers_lake_centerlines.shp
* 10m_physical/ne_10m_rivers_north_america.shp
* 10m_cultural/ne_10m_admin_1_label_points_details.shp

see the latest information in the `update.sh`

### supported languages ( now: 21)

variable name | language     | language wikipedia link
--------------|--------------|----------------------------------------------------
 NAME_AR 	  | Arabic       | https://en.wikipedia.org/wiki/Arabic_language
 NAME_BN 	  | Bengali      | https://en.wikipedia.org/wiki/Bengali_language
 NAME_DE 	  | German       | https://en.wikipedia.org/wiki/German_language
 NAME_EN 	  | English      | https://en.wikipedia.org/wiki/English_language
 NAME_ES 	  | Spanish      | https://en.wikipedia.org/wiki/Spanish_language
 NAME_FR 	  | French       | https://en.wikipedia.org/wiki/French_language
 NAME_EL 	  | Modern Greek | https://en.wikipedia.org/wiki/Modern_Greek_language
 NAME_HI 	  | Hindi     	 | https://en.wikipedia.org/wiki/Hindi_language
 NAME_HU 	  | Hungarian 	 | https://en.wikipedia.org/wiki/Hungarian_language
 NAME_ID 	  | Indonesian   | https://en.wikipedia.org/wiki/Indonesian_language
 NAME_IT 	  | Italian      | https://en.wikipedia.org/wiki/Italian_language
 NAME_JA 	  | Japanese     | https://en.wikipedia.org/wiki/Japanese_language
 NAME_KO 	  | Korean       | https://en.wikipedia.org/wiki/Korean_language
 NAME_NL 	  | Dutch        | https://en.wikipedia.org/wiki/Dutch_language
 NAME_PL 	  | Polish       | https://en.wikipedia.org/wiki/Polish_language
 NAME_PT 	  | Portuguese   | https://en.wikipedia.org/wiki/Portuguese_language
 NAME_RU 	  | Russian      | https://en.wikipedia.org/wiki/Russian_language
 NAME_SV 	  | Swedish      | https://en.wikipedia.org/wiki/Swedish_language
 NAME_TR 	  | Turkish      | https://en.wikipedia.org/wiki/Turkish_language
 NAME_VI 	  | Vietnamese   | https://en.wikipedia.org/wiki/Vietnamese_language
 NAME_ZH 	  | Chinese      | https://en.wikipedia.org/wiki/Chinese_language


### program files

* fetch_wikidata.py : 
* write_wikidata.py : 
* update.sh         :
