FROM java:8-alpine

ENV SCALA_COLLECTOR=20170708 \
BUILD_PACKAGES='bash curl-dev git curl ca-certificates gettext'

WORKDIR /usr/local/scalacollector

RUN apk update && apk upgrade \
&& apk add --update $BUILD_PACKAGES \
&& rm -rf /var/cache/apk/* \
&& wget -q http://dl.bintray.com/snowplow/snowplow-generic/snowplow_scala_stream_collector_0.9.0.zip \
&& unzip snowplow_scala_stream_collector_0.9.0.zip \
&& rm snowplow_scala_stream_collector_0.9.0.zip \
&& mv snowplow-stream-collector-0.9.0 snowplow-stream-collector

COPY assets /assets

EXPOSE 80

CMD ["/assets/start.sh" ]
