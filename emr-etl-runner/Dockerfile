FROM jruby:9.1
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV PLAIN_OF_JARS=20170705 \
LANG=en_US.UTF-8

RUN apt-get update \
  && apt-get install -yqq gettext-base \
  && apt-get autoremove -qqy \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd emr \
  && mkdir -p /emr \
  && chown -R emr. /emr

USER emr
WORKDIR /emr
RUN wget -c --quiet 'http://dl.bintray.com/snowplow/snowplow-generic/snowplow_emr_r89_plain_of_jars.zip' \
  && unzip snowplow_emr_r89_plain_of_jars.zip \
  && rm snowplow_emr_r89_plain_of_jars.zip

USER emr
COPY assets /assets
CMD ["/assets/start.sh"]
