

cd ../../

function update_names {
    ne_path=$1
    ne_shapefile=$2

    mkdir -p tempshape/${ne_path}/

    tools/wikidata/fetch_wikidata_labels.py -input_shape_name         ${ne_path}/${ne_shapefile} \
                                            -output_csv_name  tempshape/${ne_path}/${ne_shapefile}.new_names.csv

    tools/wikidata/write_wikidata.py        -input_shape               ${ne_path}/${ne_shapefile} \
                                            -input_csv       tempshape/${ne_path}/${ne_shapefile}.new_names.csv \
                                            -output_shape    tempshape/${ne_path}/${ne_shapefile} \
                                            -output_csvlog   tempshape/${ne_path}/${ne_shapefile}.update_log.csv
}


update_names 10m_physical ne_10m_lakes_historic.dbf
update_names 10m_physical ne_10m_lakes_europe.dbf
update_names 10m_physical ne_10m_lakes_north_america.dbf
update_names 10m_physical ne_10m_lakes.dbf
update_names 10m_physical ne_10m_playas.dbf
update_names 10m_physical ne_10m_rivers_europe.dbf
update_names 10m_physical ne_10m_rivers_lake_centerlines.dbf
update_names 10m_physical ne_10m_rivers_lake_centerlines.dbf
update_names 10m_physical ne_10m_rivers_north_america.dbf

update_names 10m_cultural ne_10m_airports.dbf
update_names 10m_cultural ne_10m_populated_places.dbf
update_names 10m_physical ne_10m_geographic_lines.dbf
update_names 10m_physical ne_10m_geography_marine_polys.dbf
update_names 10m_physical ne_10m_geography_regions_elevation_points.dbf
update_names 10m_physical ne_10m_geography_regions_points.dbf
update_names 10m_physical ne_10m_geography_regions_polys.dbf

update_names 10m_cultural ne_10m_admin_1_label_points_details.dbf

exit
