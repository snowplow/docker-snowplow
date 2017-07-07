#!/bin/sh

main() {
  printenv
  # and startup
  startup
}

startup() {
  envsubst \
  < /assets/resolver.json.template \
  > /emr/resolver.json
  # no files all redirects and aweseme sauce
  envsubst \
  < /assets/config.yml.template \
  | /emr/snowplow-emr-etl-runner --config - \
  --debug \
  --config - \
  --resolver /emr/resolver.json \
  $EMR_ARGS
}

altstartup() {
  # useful for debugging
  envsubst \
  < /assets/resolver.json.template \
  > /emr/resolver.json
  envsubst \
  < /assets/config.yml.template \
  > /emr/config.yml

  cp /emr/config.yml /tmp/

  /emr/snowplow-emr-etl-runner \
  --debug \
  --config /emr/config.yml \
  --resolver /emr/resolver.json \
  $EMR_ARGS
}

main "$@"
