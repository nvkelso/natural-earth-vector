FROM python:3.6.5-stretch

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list
RUN sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN    apt-get --yes --force-yes update -qq \
    && apt-get install --yes gdal-bin libgdal-dev jq zip mc \
    && rm -rf /var/lib/apt/lists/*

RUN  pip3 install -U SPARQLWrapper
RUN  pip3 install -U fiona
RUN  pip3 install -U csvtomd
RUN  pip3 install -U requests
RUN  pip3 install -U hanzidentifier

WORKDIR /ne
