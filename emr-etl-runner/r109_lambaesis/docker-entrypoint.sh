#!/usr/bin/dumb-init /bin/sh
set -e

# If the config directory has been mounted through -v, we chown it.
if [ "$(stat -c %u ${SNOWPLOW_CONFIG_PATH})" != "$(id -u snowplow)" ]; then
  chown snowplow:snowplow ${SNOWPLOW_CONFIG_PATH}
fi

# Make sure we run the collector as the snowplow user
exec gosu snowplow:snowplow ${SNOWPLOW_BIN_PATH}/snowplow-emr-etl-runner "$@"
