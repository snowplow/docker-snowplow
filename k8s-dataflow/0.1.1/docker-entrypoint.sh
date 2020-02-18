#!/bin/sh

DELAY=3
THRESHOLD=5
BUCKET=""

ITER=0
PARAMS=""

# extract params
for opt in "$@"; do
  case "$opt" in
      --tempLocation=*)
          BUCKET="${opt#*=}"
          PARAMS="$PARAMS $opt"
          shift
          ;;
      --gcpTempLocation=*)
          BUCKET="${opt#*=}"
          PARAMS="$PARAMS $opt"
          shift
          ;;
      --gcsThreshold=*)
          THRESHOLD="${opt#*=}"
          shift
          ;;
      --gcsDelay=*)
          DELAY="${opt#*=}"
          shift
          ;;
      *) # preserve positional arguments
          PARAMS="$PARAMS $opt"
          shift
          ;;
  esac
done

if [ -z "$BUCKET" ]; then
    echo "Missing --tempLocation flag. Exiting."
    exit 1
fi

echo "params: ${PARAMS} threshold: ${THRESHOLD} delay: ${DELAY}"

# enable service account
gcloud auth activate-service-account --key-file=/snowplow/config/credentials.json

# wait for GCS bucket to be available
while [ ! -z $(gsutil ls -b "${BUCKET}" | grep BucketNotFoundException) ]; do
    if [ "$ITER" -le "$THRESHOLD" ]; then
        echo "Bucket ${BUCKET} does not exist, retrying: ${ITER}"
        sleep "${DELAY}"

        ITER=$(( ITER+1 ))
    else
        echo "Bucket ${BUCKET} does not exist. Not retrying anymore."
        exit 1
    fi
done

echo "Bucket ${BUCKET} exists. Proceeding."
$PARAMS
