FROM snowplow-docker-registry.bintray.io/snowplow/base:0.1.0
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# The version of the loader to download.
ENV S3_LOADER_VERSION="0.6.0"

# The name of the archive to download.
ENV ARCHIVE="snowplow_s3_loader_${S3_LOADER_VERSION}.zip"

# Install the S3 Loader.
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build && \
    apk add --no-cache lzo

# Defines an entrypoint script delegating the lauching of the loader to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]