#!/bin/bash
set -Eeuo pipefail

STARTDATE=$(date +"%Y-%m-%dT%H:%M%z")

runmode=${1-all}

# clean and recreate x_tempshape directory
rm   -rf x_tempshape
mkdir -p x_tempshape
log_file=x_tempshape/run_all.log
#####  backup log from here ...
exec &> >(tee -a "$log_file")

# Don't forget update the VERSION file!
echo "-----------------------------------"
echo "Runmode : $runmode"
echo "Version $(cat VERSION)"
echo "Start: $STARTDATE "

# Show some debug info
python3 ./tools/wikidata/platform_debug_info.py

# Summary Log file
logmd=x_tempshape/update.md
rm -f $logmd

# --------------------------------------------------------------------------------------------------------------------
#  mode =  fetch | write | fetch_write | copy | all
#  LetterCase = uppercase  --> variable names [WIKIDATAID, NAME_AR, NAME_BN, NAME_DE, NAME_EN, NAME_ES, ... ]
#  LetterCase = lowercase  --> variable names [wikidataid, name_ar, name_bn, name_de, name_en, name_es, ... ]
# --------------------------------------------------------------------------------------------------------------------
#                          | mode       |LetterCase| shape_path  |  shape filename
# == 10m ================= |=========== |==========| ============| ================================================
function run10m {
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_0_sovereignty                        # this and other admin_0 run, but Mapshaper overwrites them
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_0_countries                          # instead results are copied into housekeeping file's lookup table
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_0_countries_lakes
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_0_map_units
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_0_map_subunits
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_0_disputed_areas
./tools/wikidata/update.sh  fetch_write  lowercase   10m_cultural  ne_10m_admin_1_states_provinces                   # this and other admin_1 run, but Mapshaper overwrites them
./tools/wikidata/update.sh  fetch_write  lowercase   10m_cultural  ne_10m_admin_1_states_provinces_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   10m_cultural  ne_10m_admin_1_label_points_details               # Mapshaper uses this to generate admin_1 polys
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_2_label_points_details               # Mapshaper uses this to generate admin_2 polys
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_2_counties                           # this and other admin_2 run, but Mapshaper overwrites them
./tools/wikidata/update.sh  fetch_write  uppercase   10m_cultural  ne_10m_admin_2_counties_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   10m_cultural  ne_10m_airports
./tools/wikidata/update.sh  fetch_write  lowercase   10m_cultural  ne_10m_populated_places                           # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_geographic_lines                           # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_geography_marine_polys                     # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_geography_regions_elevation_points         # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_geography_regions_points                   # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_geography_regions_polys                    # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_lakes_europe
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_lakes_historic
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_lakes_north_america
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_playas
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_rivers_lake_centerlines
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_rivers_lake_centerlines_scale_rank
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_rivers_europe
./tools/wikidata/update.sh  fetch_write  lowercase   10m_physical  ne_10m_rivers_north_america
}

function run50m {
# == 50m ================= |=========== |==========| ============| ================================================
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_sovereignty
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_countries
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_countries_lakes
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_map_units
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_map_subunits
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_tiny_countries                    # this should be build before derived Makefile themes run
./tools/wikidata/update.sh  fetch_write  uppercase   50m_cultural  ne_50m_admin_0_breakaway_disputed_areas
./tools/wikidata/update.sh  fetch_write  lowercase   50m_cultural  ne_50m_admin_1_states_provinces
./tools/wikidata/update.sh  fetch_write  lowercase   50m_cultural  ne_50m_admin_1_states_provinces_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   50m_physical  ne_50m_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   50m_physical  ne_50m_lakes_historic
./tools/wikidata/update.sh  fetch_write  lowercase   50m_physical  ne_50m_playas
./tools/wikidata/update.sh  fetch_write  lowercase   50m_physical  ne_50m_rivers_lake_centerlines
./tools/wikidata/update.sh  fetch_write  lowercase   50m_physical  ne_50m_rivers_lake_centerlines_scale_rank
}

function run110m {
# ==110m ================= |=========== |==========| ============| ================================================
./tools/wikidata/update.sh  fetch_write  uppercase   110m_cultural ne_110m_admin_0_sovereignty
./tools/wikidata/update.sh  fetch_write  uppercase   110m_cultural ne_110m_admin_0_countries
./tools/wikidata/update.sh  fetch_write  uppercase   110m_cultural ne_110m_admin_0_countries_lakes
./tools/wikidata/update.sh  fetch_write  uppercase   110m_cultural ne_110m_admin_0_map_units
./tools/wikidata/update.sh  fetch_write  lowercase   110m_cultural ne_110m_admin_1_states_provinces
./tools/wikidata/update.sh  fetch_write  lowercase   110m_cultural ne_110m_admin_1_states_provinces_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   110m_physical ne_110m_lakes
./tools/wikidata/update.sh  fetch_write  lowercase   110m_physical ne_110m_rivers_lake_centerlines
}

# ======================== |=========== |==========| ============| ================================================



if   [[ "$runmode" == "all" ]]
then
    # =========================================================
    #                  run all steps !
    # =========================================================
    run10m
    run50m
    run110m

    # show summary
    cat   x_tempshape/update.md

    # list new files
    ls -Gga   x_tempshape/*/*

    # Update shape files  ( if everything is OK!  )
    # Don't copy over the change logs, though (limit file extension expansion listing)
    cp -r x_tempshape/10m_cultural/*.{shp,dbf,shx,prj,cpg}    10m_cultural/
    cp -r x_tempshape/10m_physical/*.{shp,dbf,shx,prj,cpg}    10m_physical/
    cp -r x_tempshape/50m_cultural/*.{shp,dbf,shx,prj,cpg}    50m_cultural/
    cp -r x_tempshape/50m_physical/*.{shp,dbf,shx,prj,cpg}    50m_physical/
    cp -r x_tempshape/110m_cultural/*.{shp,dbf,shx,prj,cpg}  110m_cultural/
    cp -r x_tempshape/110m_physical/*.{shp,dbf,shx,prj,cpg}  110m_physical/

    # test copy mode ( write again .. )
    ./tools/wikidata/update.sh  copy  uppercase   10m_cultural  ne_10m_admin_0_countries

else
    # =========================================================
    #                  fast test  !
    # =========================================================
    # travis osx hack - run a minimal test
    run110m
    # show summary
    cat   x_tempshape/update.md
    # list new files
    ls -Gga   x_tempshape/*/*
    # Update shape files  ( if everything is OK!  )
    # Don't copy over the change logs, though (limit file extension expansion listing)
    cp -r x_tempshape/110m_cultural/*.{shp,dbf,shx,prj,cpg}  110m_cultural/
    cp -r x_tempshape/110m_physical/*.{shp,dbf,shx,prj,cpg}  110m_physical/

    # test copy mode ( write again .. )
    ./tools/wikidata/update.sh  copy  lowercase   110m_physical ne_110m_rivers_lake_centerlines

fi








# Run the final update process
# (2018-05-20 nvkelso) NOTE: This works because the MapShaper build is manual
# if it were during all target we'd have a condition where the localized names would be
# reverted for some themes (mostly admin-0 and admin-1)
make clean all

echo " "
echo " ---------------------"
STOPDATE=$(date +"%Y-%m-%dT%H:%M%z")
echo "Stop: $STARTDATE "

echo " see log file: "
ls -Gga $log_file
echo " "
echo " ---- end of run_all.sh ------ "


