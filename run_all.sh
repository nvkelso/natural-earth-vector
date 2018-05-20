#!/bin/bash
set -Eeuo pipefail


STARTDATE=$(date +"%Y-%m-%dT%H:%M%z")

# clean and recreate x_tempshape directory
rm   -rf x_tempshape
mkdir -p x_tempshape
log_file=x_tempshape/run_all.log
#####  backup log from here ...
exec &> >(tee -a "$log_file")

# Don't forget update the VERSION file!
cat VERSION

# Show some debug info
python3 ./tools/wikidata/platform_debug_info.py

# Fetch latest wikidata labels
#   ---  output:    x_tempshape/*/*.new_names.csv  files 
time ./tools/wikidata/update.sh fetch

# Write wikidata labels to the shape files
#   ---  output:    x_tempshape/*/*.shp  files and some audit logs
time ./tools/wikidata/update.sh write

# show summary
cat   x_tempshape/update.md

# list new files
ls -la   x_tempshape/*/*

# Update shape files
cp -r x_tempshape/10m_cultural/*    10m_cultural/
cp -r x_tempshape/10m_physical/*    10m_physical/
cp -r x_tempshape/50m_cultural/*    50m_cultural/
cp -r x_tempshape/50m_physical/*    50m_physical/
cp -r x_tempshape/110m_cultural/*  110m_cultural/
cp -r x_tempshape/110m_physical/*  110m_physical/

# Run the final update process
make clean all

echo " ---- end of run_all.sh ------ "
ls -la $log_file