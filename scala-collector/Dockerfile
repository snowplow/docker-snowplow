FROM java:8-alpine

ENV SCALA_COLLECTOR=20170611 \
BUILD_PACKAGES='bash curl-dev git curl ca-certificates gettext' \
SBT_VERSION=0.13.15 \
SBT_HOME=/usr/local/sbt \
PATH=${PATH}:${SBT_HOME}/bin


RUN apk update && apk upgrade && \
apk add --update $BUILD_PACKAGES && \
rm -rf /var/cache/apk/* && \

# Install sbt
echo 'curling' && \
curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -xv -C /usr/local && \
echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built &&\
apk del curl && \

mkdir -p /usr/local && cd /usr/local/ && git clone https://github.com/snowplow/snowplow.git && \
cd snowplow/2-collectors/scala-stream-collector && \
/usr/local/sbt/bin/sbt assembly && \
cd /usr/local/snowplow/2-collectors/scala-stream-collector/target/scala-2.10 && \
mkdir -p /usr/local/scalacollector/ && \
cd /usr/local/scalacollector/ && \
cd /usr/local/snowplow/2-collectors/scala-stream-collector/target/scala-2.10 && ls -lh && \
mv snowplow-stream-collector-0.9.0 /usr/local/scalacollector/snowplow-stream-collector && \
cd /; rm -Rf /usr/local/snowplow && rm -Rf /usr/local/sbt

WORKDIR /usr/local/scalacollector

COPY assets /assets

EXPOSE 80

CMD ["/assets/start.sh" ]
