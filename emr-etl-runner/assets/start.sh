#!/bin/bash

main() {

  if [ ! -z ${DEBUG+x} ]
    then
      # show us all environmant variables
      echo '<-------DEBUG---------->'
      printenv
      echo '<-----END-DEBUG-------->'
      export DEBUG_CMD_LINE=--debug
  fi


  # config
  resolverconf
  commonconf
  mkdir -p /emr/enrichments

  # Enrichments
  if [ "$ANON_IP" = "true" ]
    then
      ANON_IP
  fi

  ANON_IP() {
    echo 'ANON_IP'
    envsubst \
    < /assets/enrichments/anon_ip.json.template \
    >/emr/enrichments/anon_ip.json
  }

    if [ "$API_REQUEST_ENRICHMENT" = "true" ]
      then
        API_REQUEST_ENRICHMENT
    fi

  API_REQUEST_ENRICHMENT() {
    echo 'API_REQUEST_ENRICHMENT'
    envsubst \
    < /assets/enrichments/api_request_enrichment.json.template \
    >/emr/enrichments/api_request_enrichment.json
  }

    if [ "$CAMPAIGN_ATTRIBUTION" = "true" ]
      then
        CAMPAIGN_ATTRIBUTION
    fi

  CAMPAIGN_ATTRIBUTION() {
    echo 'CAMPAIGN_ATTRIBUTION'
    envsubst \
    < /assets/enrichments/campaign_attribution.json.template \
    >/emr/enrichments/campaign_attribution.json
  }

    if [ "$COOKIE_EXTRACTOR" = "true" ]
      then
        COOKIE_EXTRACTOR
    fi

  COOKIE_EXTRACTOR() {
    echo 'COOKIE_EXTRACTOR'
    envsubst \
    < /assets/enrichments/cookie_extractor.json.template \
    >/emr/enrichments/cookie_extractor.json
  }

    if [ "$CURRENCY_CONVERSION" = "true" ]
      then
        CURRENCY_CONVERSION
    fi

  CURRENCY_CONVERSION() {
    echo 'CURRENCY_CONVERSION'
    envsubst \
    < /assets/enrichments/currency_conversion.json.template \
    >/emr/enrichments/currency_conversion.json
  }

    if [ "$EVENT_FINGERPRINT_ENRICHMENT" = "true" ]
      then
        EVENT_FINGERPRINT_ENRICHMENT
    fi

  EVENT_FINGERPRINT_ENRICHMENT() {
    echo 'EVENT_FINGERPRINT_ENRICHMENT'
    envsubst \
    < /assets/enrichments/event_fingerprint_enrichment.json.template \
    >/emr/enrichments/event_fingerprint_enrichment.json
  }

    if [ "$HTTP_HEADER_EXTRACTOR" = "true" ]
      then
        HTTP_HEADER_EXTRACTOR
    fi

  HTTP_HEADER_EXTRACTOR() {
    echo 'HTTP_HEADER_EXTRACTOR'
    envsubst \
    < /assets/enrichments/http_header_extractor.json.template \
    >/emr/enrichments/http_header_extractor.json
  }

    if [ "$IP_LOOKUPS" = "true" ]
      then
        IP_LOOKUPS
    fi

  IP_LOOKUPS() {
    echo 'IP_LOOKUPS'
    envsubst \
    < /assets/enrichments/ip_lookups.json.template \
    >/emr/enrichments/ip_lookups.json
  }

    if [ "$JAVASCRIPT_SCRIPT_ENRICHMENT" = "true" ]
      then
        JAVASCRIPT_SCRIPT_ENRICHMENT
    fi

  JAVASCRIPT_SCRIPT_ENRICHMENT() {
    echo 'JAVASCRIPT_SCRIPT_ENRICHMENT'
    envsubst \
    < /assets/enrichments/javascript_script_enrichment.json.template \
    >/emr/enrichments/javascript_script_enrichment.json
  }

    if [ "$REFERER_PARSER" = "true" ]
      then
        REFERER_PARSER
    fi

  REFERER_PARSER() {
    echo 'REFERER_PARSER'
    envsubst \
    < /assets/enrichments/referer_parser.json.template \
    >/emr/enrichments/referer_parser.json
  }

    if [ "$SQL_QUERY_ENRICHMENT" = "true" ]
      then
        SQL_QUERY_ENRICHMENT
    fi

  SQL_QUERY_ENRICHMENT() {
    echo 'SQL_QUERY_ENRICHMENT'
    envsubst \
    < /assets/enrichments/sql_query_enrichment.json.template \
    >/emr/enrichments/sql_query_enrichment.json
  }

    if [ "$UA_PARSER" = "true" ]
      then
        UA_PARSER
    fi

  UA_PARSER() {
    echo 'UA_PARSER'
    envsubst \
    < /assets/enrichments/ua_parser.json.template \
    >/emr/enrichments/ua_parser.json
  }

    if [ "$USER_AGENT_UTILS" = "true" ]
      then
        USER_AGENT_UTILS
    fi

  USER_AGENT_UTILS() {
    echo 'USER_AGENT_UTILS'
    envsubst \
    < /assets/enrichments/user_agent_utils.json.template \
    >/emr/enrichments/user_agent_utils.json
  }

    if [ "$WEATHER_ENRICHMENT" = "true" ]
      then
        WEATHER_ENRICHMENT
    fi

  WEATHER_ENRICHMENT() {
    echo 'WEATHER_ENRICHMENT'
    envsubst \
    < /assets/enrichments/weather_enrichment.json.template \
    >/emr/enrichments/weather_enrichment.json
  }

  # startup
  # EMR
  if [ "$EMR_ENABLE" = "true" ]
    then
      emrstartup
  fi
  # Storage
  if [ "$STORAGE_ENABLE" = "true" ]
    then
      run_storage
  fi
}

resolverconf() {
  echo 'RESOLVER CONF'
  envsubst \
  < /assets/resolver.json.template \
  > /emr/resolver.json
}

commonconf() {
  echo 'COMMON CONF'
  envsubst \
  < /assets/config.yml.template \
  > /emr/config.yml
}

emrstartup() {
  echo 'EMRETL RUNNER'
  /emr/snowplow-emr-etl-runner \
  $DEBUG_CMD_LINE \
  -c /emr/config.yml \
  -r /emr/resolver.json \
  -n /emt/enrichments \
  $EMR_ARGS
}

main "$@"
