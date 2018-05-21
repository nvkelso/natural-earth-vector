FROM python:3.6.5-stretch

RUN    apt-get --yes --force-yes update -qq \
    && apt-get install --yes gdal-bin jq zip mc \
    && rm -rf /var/lib/apt/lists/*

RUN  pip3 install -U SPARQLWrapper
RUN  pip3 install -U fiona
RUN  pip3 install -U csvtomd
RUN  pip3 install -U requests

WORKDIR /ne
