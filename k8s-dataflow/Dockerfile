FROM snowplow/base-debian:0.2.2-rc1
LABEL MAINTAINER="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  mkdir -p /var/lib/apt/lists/partial &&\
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&\
  apt-get update &&\
  apt-get install -y --no-install-recommends apt-transport-https=1.4.10 ca-certificates=20200601~deb9u1 wget=1.18-5+deb9u3 gnupg=2.1.18-8~deb9u4 &&\
  wget -O - http://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - &&\
  apt-get update &&\
  apt-get install -y --no-install-recommends python=2.7.13-2 google-cloud-sdk=302.0.0-0 &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  apt-get purge -y --auto-remove gnupg

USER snowplow

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]
