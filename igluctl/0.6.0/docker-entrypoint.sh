#!/usr/bin/dumb-init /bin/sh
set -e

exec su-exec snowplow:snowplow ${BIN_PATH}/igluctl "$@"
