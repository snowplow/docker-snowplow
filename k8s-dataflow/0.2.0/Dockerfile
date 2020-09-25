FROM snowplow-docker-registry.bintray.io/snowplow/base-debian:0.1.1
LABEL MAINTAINER="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

RUN \
  mkdir -p /var/lib/apt/lists/partial &&\
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&\
  apt-get update &&\
  apt-get install -y apt-transport-https ca-certificates wget gnupg &&\
  wget -O - http://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - &&\
  apt-get update &&\
  apt-get install -y python google-cloud-sdk=302.0.0-0 &&\
  apt-get purge -y --auto-remove gnupg

USER snowplow

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]
