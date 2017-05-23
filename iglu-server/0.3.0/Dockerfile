FROM snowplow-docker-registry.bintray.io/snowplow/base:0.1.0
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# The version of the server to download
ENV IGLU_SERVER_VERSION="0.3.0"

# The name of the archive to download
ENV ARCHIVE="iglu_server_${IGLU_SERVER_VERSION}.zip"

# Install Iglu Server, postgresql client
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build && \
    chown -R snowplow:snowplow ${SNOWPLOW_BIN_PATH} && \
    apk update && \
    apk add postgresql-client

EXPOSE 8080

# Defines an entrypoint script delegating the launching of the server to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "--help" ]
