#!/bin/bash

project=$1
tag=$2

slashed="${project}/"
slashed_len=${#slashed}

cicd=${tag:0:${slashed_len}}
release=${tag:${slashed_len}}

if [ "${cicd}" == "${slashed}" ]; then
    if [ "${release}" == "" ]; then
        echo "Warning! No release specified! Ignoring."
        exit 2
    fi
else
    echo "Warning! This can't be deployed, there's no ${project} tag! Is the travis condition set?"
    exit 1
fi

file="${HOME}/.dockercfg"
docker_repo="snowplow-docker-registry.bintray.io"
curl -X GET \
    -u${BINTRAY_SNOWPLOW_DOCKER_USER}:${BINTRAY_SNOWPLOW_DOCKER_API_KEY} \
    https://${docker_repo}/v2/auth > $file

cd $project
if [ -d "${release}" ]; then
    cd $release
else
    echo "Warning! Release ${project} ${release} doesn't have an associated folder"
    exit 1
fi

for platform in 'google-pubsub' 'kafka' 'kinesis' 'nsq'; do
    if [ -d "${platform}" ]; then
        cd $platform
    # no enrich for pubsub
    elif [ "${platform}" = 'google-pubsub' ] && [ "${project}" = 'stream-enrich' ]; then
        continue
    else
        echo "Warning! Release ${project} ${release} ${platform} doesn't have an associated folder"
        exit 1
    fi

    img_tag="snowplow/${project}-${platform}:${release}"
    final_tag="${docker_repo}/${img_tag}"
    docker build -t $final_tag .
    docker push $final_tag
    cd ..
done
