FROM openjdk:8u171-jre-alpine
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# Snowplow components will be installed in this folder.
ENV SNOWPLOW_PATH="/snowplow"
ENV SNOWPLOW_CONFIG_PATH="${SNOWPLOW_PATH}/config" \
    SNOWPLOW_BIN_PATH="${SNOWPLOW_PATH}/bin"

# Create a snowplow group and user.
RUN addgroup snowplow && \
    adduser -S -G snowplow snowplow

# Install the components common to all apps.
# https://github.com/yelp/dumb-init: lightweight init system
# https://github.com/ncopa/su-exec: sudo replacement
RUN apk add --no-cache dumb-init su-exec ca-certificates wget

# /snowplow/bin is meant to contain the application jar.
# /snowplow/config is meant to contain the necessary configuration.
RUN mkdir -p ${SNOWPLOW_BIN_PATH} && \
    mkdir -p ${SNOWPLOW_CONFIG_PATH} && \
    chown -R snowplow:snowplow ${SNOWPLOW_PATH}

# Expose the configuration directory.
VOLUME ${SNOWPLOW_CONFIG_PATH}
