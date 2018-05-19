#!/bin/bash
set -Eeuo pipefail

python3 ./tools/wikidata/platform_debug_info.py
time ./tools/wikidata/update.sh fetch
time ./tools/wikidata/update.sh write
cat   x_tempshape/update.md
cp -r x_tempshape/10m_cultural/*    10m_cultural/
cp -r x_tempshape/10m_physical/*    10m_physical/
make clean all
