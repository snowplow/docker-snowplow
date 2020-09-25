FROM snowplow-docker-registry.bintray.io/snowplow/base-alpine:0.2.1
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# The version of the collector to download.
ENV COLLECTOR_VERSION="0.15.0"

# The targeted platform
ENV PLATFORM="kinesis"

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
EXPOSE 8080

# Defines an entrypoint script delegating the lauching of the collector to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "--help" ]
