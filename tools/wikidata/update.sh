#!/bin/bash
set -Eeuo pipefail


# check correct start with file existence
if [ ! -f tools/wikidata/fetch_wikidata.py ];
then
   echo "ERROR: Start from the project root ! ./tools/wikidata/update.sh "
   exit 1
fi

mode=$1
nei_letter_case=$2
nei_path=.
neo_path=x_tempshape
ne_shapepath=$3
ne_shapefile=$4

mkdir -p ${neo_path}/${ne_shapepath}
logmd=${neo_path}/update.md

echo " "
echo "########## /tools/wikidata/update.sh parameters:"
echo " 1: mode           :  ${mode}"
echo " 2: nei_letter_case:  ${nei_letter_case}"
#echo " nei_path       :  ${nei_path}"
echo " 3: neo_path       :  ${neo_path}"
echo " 4: ne_shapepath   :  ${ne_shapepath}"
echo " 5: ne_shapefile   :  ${ne_shapefile}"
echo " "




function fetch_names {
    echo " "
    echo " Fetch wikidata labels "
    echo " ================================="
    ogrinfo -al -so  ${nei_path}/${ne_shapepath}/${ne_shapefile}.shp

    python3 tools/wikidata/fetch_wikidata.py -input_shape_name            ${nei_path}/${ne_shapepath}/${ne_shapefile}.shp \
                                             -input_lettercase            ${nei_letter_case} \
                                             -output_csv_name             ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv
    echo " created : ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv "
    echo " "
}


function write_names {
    echo " "
    echo " Write shapefile with wikidata labels "
    echo " ================================="
    echo " shapefile info : ${neo_path}/${ne_shapepath}/${ne_shapefile} "
    if [ ! -f ${nei_path}/${ne_shapepath}/${ne_shapefile}.shp ];
    then
        echo "ERROR: ${nei_path}/${ne_shapepath}/${ne_shapefile}.shp not exist!  STOP "
        exit 1
    fi

    if [ ! -f ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv ];
    then
        echo "ERROR: ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv   not exist!  STOP "
        echo "hint:  You should run the fetch part first! "
        exit 1
    fi

    python3 tools/wikidata/write_wikidata.py  -input_shape       ${nei_path}/${ne_shapepath}/${ne_shapefile}.shp \
                                              -input_lettercase  ${nei_letter_case} \
                                              -input_csv         ${neo_path}/${ne_shapepath}/${ne_shapefile}.new_names.csv \
                                              -output_shape      ${neo_path}/${ne_shapepath}/${ne_shapefile}.shp \
                                              -output_csvlog     ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv \
                                              -output_csvsumlog  ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv

    echo " "                                                               >> $logmd
    echo "###  ${neo_path}/${ne_shapepath}/${ne_shapefile}"                >> $logmd
    echo " "                                                               >> $logmd
    csvtomd    ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv >> $logmd

    csvtomd    ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv >  ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv.md
    csvtomd    ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv >  ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv.md

    echo " "
    echo "show only name_en/NAME_EN changes : ${neo_path}/${ne_shapepath}/${ne_shapefile} "
    echo "---------------------"
    cat ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv.md | grep MODvalue  |  grep name_en || true
    cat ${neo_path}/${ne_shapepath}/${ne_shapefile}.changes_log.csv.md | grep MODvalue  |  grep NAME_EN || true
    echo " "

    cat ${neo_path}/${ne_shapepath}/${ne_shapefile}.summary_log.csv.md
    echo " "

    echo " (write) created shape and audit files:"
    echo " -------------------"
    ls -Gga  ${neo_path}/${ne_shapepath}/${ne_shapefile}*
    echo ""
}


function copy_names {
    echo " "
    echo " Copy shape + audit files  "
    echo " =============================== "
    cp -v ${neo_path}/${ne_shapepath}/${ne_shapefile}*.{shp,dbf,shx,prj,cpg}   ${ne_shapepath}/
}

if   [[ "$mode" == "fetch" ]]
then
    #echo "fetch"
    fetch_names
elif [[ "$mode" == "write" ]]
then
    #echo "write"
    write_names
elif [[ "$mode" == "fetch_write" ]]
then
    #echo "fetch_write "
    fetch_names
    write_names
elif [[ "$mode" == "copy" ]]
then
    #echo "copy files"
    copy_names
elif [[ "$mode" == "all" ]]
then
    #echo "fetch + write + copy"
    fetch_names
    write_names
    copy_names
else
    echo "Unknown mode!   the first parameter should be:[fetch/write/fetch_write/copy/all]"
    exit 1
fi


exit

