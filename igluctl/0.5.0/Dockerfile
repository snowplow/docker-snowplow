FROM snowplow-docker-registry.bintray.io/snowplow/base-alpine:0.2.1
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# Bin path
ENV BIN_PATH="/usr/local/bin"

# The version of the cli to download
ENV IGLUCTL_VERSION="0.5.0"

# The name of the archive to download
ENV ARCHIVE="igluctl_${IGLUCTL_VERSION}.zip"

WORKDIR $SNOWPLOW_PATH

# Install igluctl
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build

# Defines an entrypoint script delegating the launching of igluctl
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "--help" ]

VOLUME ${SNOWPLOW_PATH}
