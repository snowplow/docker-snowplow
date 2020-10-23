FROM snowplow/base-debian:0.2.2-rc1
LABEL MAINTAINER="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  apt-get update &&\
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&\
  apt-get install -y --no-install-recommends apt-transport-https=1.8.2.1 ca-certificates=20200601~deb10u1 gnupg=2.2.12-1+deb10u1 curl=7.64.0-4+deb10u1 &&\
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - &&\
  apt-get update &&\
  apt-get install -y --no-install-recommends google-cloud-sdk=316.0.0-0 &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  apt-get purge -y --auto-remove gnupg

USER snowplow

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]
