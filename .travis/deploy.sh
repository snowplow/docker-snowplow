#!/bin/bash
set -e

tag=$1

project=$(echo "$tag" | cut -d'/' -f1)
release=$(echo "$tag" | cut -d'/' -f2)

file="${HOME}/.dockercfg"
docker_repo="snowplow-docker-registry.bintray.io"
curl -X GET \
    -u"${BINTRAY_SNOWPLOW_DOCKER_USER}":"${BINTRAY_SNOWPLOW_DOCKER_API_KEY}" \
    https://${docker_repo}/v2/auth > "$file"

cd "$project"

img_tag="snowplow/${project}:${release}"
final_tag="${docker_repo}/${img_tag}"
docker build -t "$final_tag" .
docker push "$final_tag"
