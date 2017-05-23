FROM anapsix/alpine-java:8

MAINTAINER Gergely Lendvai <gergely.lendvai93@gmail.com>

ENV IGLU_VER 0.2.0
ENV IGLU_LOC /opt/iglu

RUN mkdir -p ${IGLU_LOC}/bin/ && \
    mkdir -p ${IGLU_LOC}/conf/

WORKDIR /tmp
RUN wget http://dl.bintray.com/snowplow/snowplow-generic/iglu_server_${IGLU_VER}.zip && \
    unzip iglu_server_${IGLU_VER}.zip -d ${IGLU_LOC}/bin && \
    rm iglu_server_${IGLU_VER}.zip && \
    mv ${IGLU_LOC}/bin/iglu-server-* ${IGLU_LOC}/bin/iglu_server.jar

RUN apk update && \
    apk add postgresql-client

COPY ./scripts/super_api_key_init.sh ${IGLU_LOC}/bin/
RUN chmod +x ${IGLU_LOC}/bin/super_api_key_init.sh && \
	sed -i -e 's/\r$//' ${IGLU_LOC}/bin/super_api_key_init.sh

WORKDIR ${IGLU_LOC}/bin

EXPOSE 8080
