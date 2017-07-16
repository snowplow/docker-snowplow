FROM java:8-alpine

ENV SCALA_COLLECTOR=20170708 \
BUILD_PACKAGES='ca-certificates gettext' \
COLLECTOR_VERSION="0.9.0" \
ARTIFACT="snowplow_scala_stream_collector_${COLLECTOR_VERSION}" \
ARCHIVE="${ARTIFACT}.zip"

WORKDIR /usr/local/scalacollector

RUN apk update && apk upgrade \
  && apk add --update $BUILD_PACKAGES \
  && rm -rf /var/cache/apk/*
RUN wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} \
  && unzip ${ARCHIVE} \
  && rm ${ARCHIVE} \
  && mv ${ARTIFACT} snowplow-stream-collector

COPY assets /assets

EXPOSE 80

CMD ["/assets/start.sh" ]
