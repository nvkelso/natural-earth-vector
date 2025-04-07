#!/bin/bash
set -Eeuo pipefail

STARTDATE=$(date +"%Y-%m-%dT%H:%M%z")

# clean and recreate x_tempshape directory
rm   -rf x_tempshape
mkdir -p x_tempshape
log_file=x_tempshape/run.log
#####  backup log from here ...
exec &> >(tee -a "$log_file")

# Don't forget update the VERSION file!
echo "-----------------------------------"
echo "File / RunMode: ${1-all} / ${2-all}"
echo "Version $(cat VERSION)"
echo "Start: $STARTDATE "

# Show some debug info
python3 ./tools/wikidata/platform_debug_info.py

# Summary Log file
logmd=x_tempshape/update.md
rm -f $logmd

echo "----------run plan-----------------------"
./_run_helper.sh plan ${1-all} ${2-all}
echo "-----------------------------------------"
echo ""

./_run_helper.sh ${1-all} ${2-all}

echo " "
echo " ---------------------"
STOPDATE=$(date +"%Y-%m-%dT%H:%M%z")
echo "Stop: $STOPDATE "

echo " see log file: "
ls -Gga $log_file
echo " "
echo " ---- end of run.sh ------ "
