#!/usr/bin/dumb-init /bin/sh
set -e

# If the config directory has been mounted through -v, we chown it.
if [ "$(stat -c %u ${SNOWPLOW_CONFIG_PATH})" != "$(id -u snowplow)" ]; then
  chown snowplow:snowplow ${SNOWPLOW_CONFIG_PATH}
fi

# Needed because of SCE's ./ip_geo file
cd $(eval echo ~snowplow)

# Make sure we run the collector as the snowplow user
exec su-exec snowplow:snowplow /usr/bin/java \
  $SP_JAVA_OPTS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap \
  -Dcom.amazonaws.sdk.disableCbor \
  -jar ${SNOWPLOW_BIN_PATH}/snowplow-stream-enrich-${ENRICH_VERSION}.jar "$@"
