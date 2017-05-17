FROM anapsix/alpine-java:8

MAINTAINER Tamas Szuromi <tromika@gmail.com>


ARG SNOWPLOW_VER
ENV SNOWPLOW_LOC /opt/snowplow

RUN mkdir -p ${SNOWPLOW_LOC}/bin/ && \
    mkdir -p ${SNOWPLOW_LOC}/conf/ && \
    mkdir -p ${SNOWPLOW_LOC}/enrichments/

WORKDIR /tmp
RUN wget http://dl.bintray.com/snowplow/snowplow-generic/snowplow_kinesis_${SNOWPLOW_VER}.zip && \
    unzip snowplow_kinesis_${SNOWPLOW_VER}.zip -d ${SNOWPLOW_LOC}/bin && \
    rm snowplow_kinesis_${SNOWPLOW_VER}.zip && \
    rm ${SNOWPLOW_LOC}/bin/snowplow-elasticsearch-sink-0.8.0-1x && \
    mv ${SNOWPLOW_LOC}/bin/snowplow-stream-collector-* ${SNOWPLOW_LOC}/bin/snowplow-stream-collector.jar && \
    mv ${SNOWPLOW_LOC}/bin/snowplow-stream-enrich-* ${SNOWPLOW_LOC}/bin/snowplow-stream-enrich.jar && \
    mv ${SNOWPLOW_LOC}/bin/snowplow-elasticsearch-sink-*-2x* ${SNOWPLOW_LOC}/bin/snowplow-elasticsearch-sink.jar

WORKDIR ${SNOWPLOW_LOC}/bin
