FROM snowplow-docker-registry.bintray.io/snowplow/base-debian:0.1.0
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# The version of the collector to download.
ENV COLLECTOR_VERSION="0.14.0_rc1"

# The targeted platform
ENV PLATFORM="google_pubsub"

# The name of the archive to download.
ENV ARCHIVE="snowplow_scala_stream_collector_${PLATFORM}_${COLLECTOR_VERSION}.zip"

# Install the Scala Stream Collector.
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build

# Port used by the collector.
EXPOSE 80

# Defines an entrypoint script delegating the lauching of the collector to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "--help" ]
