#!/usr/bin/dumb-init /bin/sh
set -e

# Make sure we run the server as the snowplow user
exec gosu snowplow:snowplow /usr/bin/java \
  $SP_JAVA_OPTS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap \
  -jar ${SNOWPLOW_BIN_PATH}/piinguin-server-assembly-${PIINGUIN_SERVER_VERSION}.jar \
  -h $PIINGUIN_HOST -p $PIINGUIN_PORT -t $PIINGUIN_DYNAMO_TABLE "$@"
