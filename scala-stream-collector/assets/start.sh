#!/bin/sh

cd /usr/local/scalacollector
envsubst < /assets/config.template > collector.config
./snowplow-stream-collector  --config collector.config
