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

function run10m {
  ./_run_helper.sh fetch_write 10m
}

function run50m {
  ./_run_helper.sh fetch_write 50m
}

function run110m {
  ./_run_helper.sh fetch_write 110m
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


