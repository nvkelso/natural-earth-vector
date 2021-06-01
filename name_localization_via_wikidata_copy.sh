#!/bin/bash
set -Eeuo pipefail

# NOTE: The simple 10m, and 50m, 110m populated places are derived from this single file
./tools/wikidata/update.sh  copy   uppercase   10m_cultural  ne_10m_populated_places

# NOTE: These all need to be copied into the COUNTRY DETAILS file in the housekeeping dir
#       as these all get overwritten later during Make process, incluing the countries_lakes file
#       TODO: Does the tiny countries file, too?
#./tools/wikidata/update.sh  copy   uppercase   10m_cultural  ne_10m_admin_0_countries
#./tools/wikidata/update.sh  copy   uppercase   10m_cultural  ne_10m_admin_0_disputed_areas
#./tools/wikidata/update.sh  copy   uppercase   10m_cultural  ne_10m_admin_0_map_subunits
#./tools/wikidata/update.sh  copy   uppercase   10m_cultural  ne_10m_admin_0_map_units
#./tools/wikidata/update.sh  copy   uppercase   10m_cultural  ne_10m_admin_0_sovereignty

# NOTE: The states (and lake version) all derive their names from the details file
./tools/wikidata/update.sh  copy   lowercase   10m_cultural ne_10m_admin_1_label_points_details
./tools/wikidata/update.sh  copy   lowercase   10m_cultural ne_10m_admin_1_states_provinces

# NOTE: The 50m, 110m airports are derived from this single file
# NOTE: airports but not ports, odd
./tools/wikidata/update.sh  copy   lowercase   10m_cultural ne_10m_airports

# NOTE: The 50m, 110m geographic labels files are derived from this single file
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_geography_regions_polys
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_geography_marine_polys
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_geography_regions_points
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_geography_regions_elevation_points
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_geographic_lines

./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_lakes
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_lakes_north_america
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_lakes_europe
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_lakes_historic
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_playas

./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_rivers_lake_centerlines_scale_rank
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_rivers_lake_centerlines
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_rivers_north_america
./tools/wikidata/update.sh  copy   lowercase   10m_physical ne_10m_rivers_europe


# 50m

# NOTE: The lake version derive their names from this

# TODO: Does the admin1 update from the names in ne_10m_admin_1_label_points_details?
#./tools/wikidata/update.sh  copy   lowercase   50m_cultural ne_50m_admin_1_states_provinces
./tools/wikidata/update.sh  copy   lowercase   50m_physical ne_50m_lakes
./tools/wikidata/update.sh  copy   lowercase   50m_physical ne_50m_lakes_historic
./tools/wikidata/update.sh  copy   lowercase   50m_physical ne_50m_playas
./tools/wikidata/update.sh  copy   lowercase   50m_physical ne_50m_rivers_lake_centerlines
./tools/wikidata/update.sh  copy   lowercase   50m_physical ne_50m_rivers_lake_centerlines_scale_rank


# 110m

# NOTE: The lake version derive their names from this
#./tools/wikidata/update.sh  copy   lowercase   110m_cultural ne_110m_admin_1_states_provinces
./tools/wikidata/update.sh  copy   lowercase   110m_physical ne_110m_lakes
./tools/wikidata/update.sh  copy   lowercase   110m_physical ne_110m_rivers_lake_centerlines
