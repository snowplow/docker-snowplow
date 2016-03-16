FROM memrise/snowplow:r78

RUN mv snowplow-stream-collector-0.6.0 /opt/snowplow/snowplow-stream-collector.jar

WORKDIR /opt/snowplow/
RUN rm -rf /snowplow_jars/

COPY config/collector.conf /etc/snowplow/collector.conf

EXPOSE 80

ENTRYPOINT ["/usr/bin/java", "-jar", "snowplow-stream-collector.jar", "--config", "/etc/snowplow/collector.conf"]
