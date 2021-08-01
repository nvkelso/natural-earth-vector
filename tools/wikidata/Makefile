.PHONY: all

all: clean fetch write

install:
	pip3 install -U SPARQLWrapper
	pip3 install -U fiona
	pip3 install -U csvtomd
	pip3 install -U hanzidentifier

clean:
	cd ../.. && rm -rf temp_shape/*

fetch:
	cd ../.. && ./tools/wikidata/update.sh fetch && cd ./.

fetch_write:
	cd ../.. && ./tools/wikidata/update.sh fetch_write && cd ./.

write:
	cd ../.. && ./tools/wikidata/update.sh write && cd ./.