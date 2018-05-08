.PHONY: all

all: init fetch

init:
	pip3 install -U SPARQLWrapper
	pip3 install -U fiona

fetch:
	python3 ./fetch_wikidata_labels.py  -input_shape_name ../../10m_cultural/ne_10m_populated_places.shp  -output_csv_name ne_10m_populated_places.csv

