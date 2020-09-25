FROM snowplow-docker-registry.bintray.io/snowplow/base-debian:0.1.1
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# The version of EmrEtlRunner to download.
ENV EMR_ETL_RUNNER_VERSION="r113_filitosa"

# The name of the archive to download.
ENV ARCHIVE="snowplow_emr_${EMR_ETL_RUNNER_VERSION}.zip"

# Install EmrEtlRunner.
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build

# Defines an entrypoint script delegating the lauching of EmrEtlRunner to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "--help" ]
