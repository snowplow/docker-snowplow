FROM jruby:9.1
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV EMR_RELEASE=LASCAUX \
LANG=en_US.UTF-8 \
EMR_DL_ZIP=snowplow_emr_r90_lascaux.zip \
EMR_DL_URL=http://dl.bintray.com/snowplow/snowplow-generic/


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
RUN wget -c --quiet "$EMR_DL_URL$EMR_DL_ZIP" \
  && unzip $EMR_DL_ZIP \
  && rm $EMR_DL_ZIP

USER emr
COPY assets /assets
CMD ["/assets/start.sh"]
