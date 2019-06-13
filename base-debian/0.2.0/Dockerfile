FROM openjdk:11.0.3-slim-stretch
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# Snowplow components will be installed in this folder.
ENV SNOWPLOW_PATH="/snowplow"
ENV SNOWPLOW_CONFIG_PATH="${SNOWPLOW_PATH}/config" \
    SNOWPLOW_BIN_PATH="${SNOWPLOW_PATH}/bin"

# Create a snowplow group and user.
RUN addgroup snowplow && \
    adduser --system --ingroup snowplow snowplow

# Install the components common to all apps.
# https://github.com/yelp/dumb-init: lightweight init system
# https://github.com/tianon/gosu/: sudo replacement
RUN apt-get update && \
    apt-get install -y ca-certificates wget gnupg && \
    rm -rf /var/lib/apt/lists && \
    wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
    dpkg -i dumb-init_*.deb && \
    export GOSU_VERSION=1.10 && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" && \
    export GNUPGHOME="$(mktemp -d)" && \
    for server in $(shuf -e ha.pool.sks-keyservers.net \
                            hkp://p80.pool.sks-keyservers.net:80 \
                            keyserver.ubuntu.com \
                            hkp://keyserver.ubuntu.com:80 \
                            pgp.mit.edu) ; do \
        gpg --batch --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || : ; \
    done && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    gpgconf --kill all || : && \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    apt-get purge -y --auto-remove gnupg

# /snowplow/bin is meant to contain the application jar.
# /snowplow/config is meant to contain the necessary configuration.
RUN mkdir -p ${SNOWPLOW_BIN_PATH} && \
    mkdir -p ${SNOWPLOW_CONFIG_PATH} && \
    chown -R snowplow:snowplow ${SNOWPLOW_PATH}

# Expose the configuration directory.
VOLUME ${SNOWPLOW_CONFIG_PATH}
