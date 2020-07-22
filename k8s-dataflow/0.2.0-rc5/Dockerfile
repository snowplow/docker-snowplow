FROM snowplow-docker-registry.bintray.io/snowplow/base-debian:0.1.0
LABEL MAINTAINER="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

RUN \
  apt-get update && \
  apt-get install -y python curl

USER snowplow

RUN \
  cd $SNOWPLOW_PATH && \
  curl -OL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-302.0.0-linux-x86_64.tar.gz && \
  tar -xf google-cloud-sdk-302.0.0-linux-x86_64.tar.gz && \
  rm google-cloud-sdk-302.0.0-linux-x86_64.tar.gz && \
  $SNOWPLOW_PATH/google-cloud-sdk/install.sh --usage-reporting=false --command-completion=true --path-update=true --rc-path=/home/snowplow/.profile

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]
