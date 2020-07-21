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

echo "params: ${PARAMS} threshold: ${THRESHOLD} delay: ${DELAY} GOOGLE_APPLICATION_CREDENTIALS: ${GOOGLE_APPLICATION_CREDENTIALS:-Not Available}"

# enable service account if credentials are available
if [ -z "${GOOGLE_APPLICATION_CREDENTIALS}" ]; then
  echo "GOOGLE_APPLICATION_CREDENTIALS is not defined, gcloud isn't authenticated!"
  exit 1
else
  gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
fi

# wait for GCS bucket to be available
while [ "$ITER" -le "$THRESHOLD" ]; do
  gsutil ls -b "${BUCKET}"
  if [ $? -eq 0 ]; then
    echo "Bucket ${BUCKET} exists! Proceeding."
    break
  else
    echo "Bucket ${BUCKET} does not exist. Retry: ${ITER}/${THRESHOLD}"
    sleep "${DELAY}"
    ITER=$(( ITER+1 ))
  fi
done

# check if retry limit was reached or not
if [ "$ITER" -le "$THRESHOLD" ]; then
  $PARAMS
else
  echo "Bucket ${BUCKET} does not exist. Not retrying anymore."
  exit 1
fi
