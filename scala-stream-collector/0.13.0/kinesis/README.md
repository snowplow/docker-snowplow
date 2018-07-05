# Example call for the collector just configured by ENV variables

    docker build 
    docker run \
      -e COLLECTOR_COOKIE_DOMAIN=".liadm.com" \
      -e COLLECTOR_COOKIE_NAME="lidid" \
      -e COLLECTOR_COOKIE_EXPIRATION="730 days" \
      -e COLLECTOR_PORT="8091" \
      -e GOOD_STREAM="li-events-raw-staging" \
      -e BAD_STREAM="li-events-raw-bad-staging" \
      -e AWS_REGION="us-east-1" \
      -e THREADPOOL_SIZE=20 \
      -e BUFFER_RECORD_THRESHOLD=100 \
      -e BUFFER_TIME_THRESHOLD=1000 \
      -e BUFFER_BYTE_THRESHOLD=102400 \
      -e AWS_ACCESS_KEY_ID=YOUR_KEY \
      -e AWS_SECRET_ACCESS_KEY=YOUR_SECRET \
      63f502fcd0c9 \
      --config /snowplow/config/config.hocon

##### Replace the image id with an actual released image url. This is just for local testing purposes