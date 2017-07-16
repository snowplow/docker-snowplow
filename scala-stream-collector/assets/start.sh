#!/bin/sh

cd /usr/local/scalacollector
envsubst < /assets/config.template > collector.config
./scala-stream-collector  --config collector.config
