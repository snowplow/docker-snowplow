#!/bin/bash
set -e

tag=$1

expectedTagFormat="Expected tag format is <project-name>/<release-version>"

[[ $tag != *"/"* ]] && echo "Invalid tag [$tag] due to missing '/'! ""$expectedTagFormat" && exit 1

project=$(echo "$tag" | cut -d'/' -f1)
release=$(echo "$tag" | cut -d'/' -f2)

if [ "${project}" == "base-debian" ] || [ "${project}" == "base-alpine" ] || [ "${project}" == "k8s-dataflow" ]; then
  if [ "${release}" == "" ]; then
    echo "Invalid tag "[$tag]" due to missing release version in tag! ""$expectedTagFormat"
    exit 1
  else
    exit 0
  fi
else
  echo "Invalid tag "[$tag]" due to unexpected project name [$project]. Expected project names are base-debian, base-alpine and k8s-dataflow."
  exit 1
fi
