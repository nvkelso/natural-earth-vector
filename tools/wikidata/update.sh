#!/bin/bash
set -Eeuo pipefail

mode=${1-all}




# check correct start with file existence
if [ ! -f tools/wikidata/fetch_wikidata.py ];
then
   echo "ERROR: Start from the project root ! ./tools/wikidata/update.sh "
   exit 1
fi





function fetch_names {
    nei_letter_case=$1
    nei_path=$2
    neo_path=$3
    ne_shapepath=$4    
    ne_shapefile=$5

    mkdir -p ${neo_path}/${ne_shapepath}

    echo " "
    echo "########## Fetching ... ${nei_path}/${ne_shapepath}/${ne_shapefile} "
    echo " "
    echo "parameters:"
    echo "  nei_letter_case:  ${nei_letter_case}"
    echo "  nei_path       :  ${nei_path}"
    echo "  neo_path       :  ${neo_path}"    
    echo "  ne_shapepath   :  ${ne_shapepath}"
    echo "  ne_shapefile   :  ${ne_shapefile}"    
    echo " "


    ogrinfo -al -so  ${nei_path}/${ne_shapepath}/${ne_shapefile}

    python3 tools/wikidata/fetch_wikidata.py -input_shape_name            ${nei_path}/${ne_shapepath}/${ne_shapefile} \
                                             -input_lettercase            ${nei_letter_case} \
                                             -output_csv_name             ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv
}


function write_names {
    nei_letter_case=$1
    nei_path=$2
    neo_path=$3
    ne_shapepath=$4    
    ne_shapefile=$5

    mkdir -p ${neo_path}/${ne_shapepath}

    echo " "
    echo "########## Writing ... ${neo_path}/${ne_shapepath}/${ne_shapefile} "
    echo " "
    echo "parameters:"
    echo "  nei_letter_case:  ${nei_letter_case}"
    echo "  nei_path       :  ${nei_path}"
    echo "  neo_path       :  ${neo_path}"    
    echo "  ne_shapepath   :  ${ne_shapepath}"
    echo "  ne_shapefile   :  ${ne_shapefile}"    
    echo " "


    if [ ! -f ${nei_path}/${ne_shapepath}/${ne_shapefile} ];
    then
        echo "ERROR: ${nei_path}/${ne_shapepath}/${ne_shapefile} not exist!  STOP "
        exit 1
    fi

    if [ ! -f ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv ];
    then
        echo "ERROR: ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv   not exist!  STOP "
        exit 1
    fi



    python3 tools/wikidata/write_wikidata.py  -input_shape       ${nei_path}/${ne_shapepath}/${ne_shapefile} \
                                              -input_lettercase  ${nei_letter_case} \
                                              -input_csv         ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv \
                                              -output_shape      ${neo_path}/${ne_shapepath}/${ne_shapefile} \
                                              -output_csvlog     ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv \
                                              -output_csvsumlog  ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv


    echo " "                                                >> $logmd
    echo "###  ${neo_path}/${ne_shapepath}/${ne_shapefile}" >> $logmd
    echo " "                                                >> $logmd
    csvtomd    ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv  >>   $logmd

    csvtomd    ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv >  ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv.md
    csvtomd    ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv >  ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv.md

    echo " "
    echo "name_en/NAME_EN changes  ${neo_path}/${ne_shapepath}/${ne_shapefile}) "
    echo "---------------------"
    cat ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv.md | grep MODvalue  |  grep name_en || true
    cat ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv.md | grep MODvalue  |  grep NAME_EN || true
    echo " "

    cat ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv.md
    echo " "
}


function update_names {

    if   [[ "$mode" == "fetch" ]]
    then
        echo "fetch ... $1 $2 $3 $4 $5"
        fetch_names     $1 $2 $3 $4 $5
    elif [[ "$mode" == "write" ]]
    then
        echo "write ... $1 $2 $3 $4 $5"
        write_names     $1 $2 $3 $4 $5
    else
        echo "fetch+write ... $1 $2 $3 $4 $5"
        fetch_names           $1 $2 $3 $4 $5
        write_names           $1 $2 $3 $4 $5
    fi
}







logmd=x_tempshape/update.md
rm -f $logmd

#  lettercase = uppercase variable names [WIKIDATAID, NAME_AR, NAME_BN, NAME_DE, NAME_EN, NAME_ES, ... ]
#  lettercase = lowercase variable names [wikidataid, name_ar, name_bn, name_de, name_en, name_es ]

#            lettercase | input folder | output folder | shape_path   |  shape filename 
# ----------------------| ------------ | ------------- | -------------| ---------------------------------------
update_names uppercase    .              x_tempshape     10m_cultural   ne_10m_admin_0_countries_lakes.shp
update_names uppercase    .              x_tempshape     10m_cultural   ne_10m_admin_0_countries.shp
update_names uppercase    .              x_tempshape     10m_cultural   ne_10m_admin_0_disputed_areas.shp
update_names uppercase    .              x_tempshape     10m_cultural   ne_10m_admin_0_map_subunits.shp
update_names uppercase    .              x_tempshape     10m_cultural   ne_10m_admin_0_map_units.shp
update_names uppercase    .              x_tempshape     10m_cultural   ne_10m_admin_0_sovereignty.shp

update_names lowercase    .              x_tempshape     10m_cultural   ne_10m_admin_1_states_provinces_lakes.shp
update_names lowercase    .              x_tempshape     10m_cultural   ne_10m_admin_1_states_provinces.shp
update_names lowercase    .              x_tempshape     10m_cultural   ne_10m_airports.shp
update_names lowercase    .              x_tempshape     10m_cultural   ne_10m_populated_places.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_geographic_lines.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_geography_marine_polys.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_geography_regions_elevation_points.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_geography_regions_points.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_geography_regions_polys.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_lakes_europe.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_lakes_historic.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_lakes_north_america.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_lakes.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_playas.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_rivers_europe.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_rivers_lake_centerlines_scale_rank.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_rivers_lake_centerlines.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_rivers_lake_centerlines.shp
update_names lowercase    .              x_tempshape     10m_physical   ne_10m_rivers_north_america.shp

update_names lowercase    .              x_tempshape     10m_cultural   ne_10m_admin_1_label_points_details.shp
   


#cp -r x_tempshape/10m_cultural/*    10m_cultural/
#cp -r x_tempshape/10m_physical/*    10m_physical/


#known problems:
# ----------------------------------------------------------------------------------------
# Warningis - in  10m_cultural   ne_10m_admin_1_label_points_details.shp
#
#  WARNING:Fion a:CPLE_AppDefined in b'Value -4.75267000000000017 of field longitude of feature 4645 not successfully written. Possibly due to too larger number with respect to field width'
#  WARNING:Fiona:CPLE_AppDefined in b'Value 10.2509999999999994 of field latitude of feature 4646 not successfully written. Possibly due to too larger number with respect to field width'
#  WARNING:Fiona:CPLE_AppDefined in b'Value -3.34011000000000013 of field longitude of feature 4646 not successfully written. Possibly due to too larger number with respect to field width'
#
