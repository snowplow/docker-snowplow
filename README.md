# Snowplow Docker

[![License][license-image]][license]

## Introduction

This repository contains the Dockerfiles of base images we use at Snowplow:

- base-alpine
- base-debian
- k8s-dataflow

They are published in the [`snowplow-docker-registry.bintray.io`][registry] docker registry.

## Pulling

You can pull the images from the registry directly:

```bash
# base-alpine
docker pull snowplow-docker-registry.bintray.io/snowplow/base-alpine:0.2.1

# base-debian
docker pull snowplow-docker-registry.bintray.io/snowplow/base-debian:0.2.1

# k8s-dataflow
docker pull snowplow-docker-registry.bintray.io/snowplow/k8s-dataflow:0.2.0
```

## Building

Alternatively, you can build them yourself:

```bash
# base-alpine
docker build -t snowplow/base-alpine:0.2.1 base-alpine

# base-debian
docker build -t snowplow/base-debian:0.2.1 base-debian

# k8s-dataflow
docker build -t snowplow/k8s-dataflow:0.2.0 k8s-dataflow
```

## Copyright and license

Copyright 2017-2020 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[registry]: https://bintray.com/snowplow/registry

[license-image]: http://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[license]: http://www.apache.org/licenses/LICENSE-2.0
