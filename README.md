# Snowplow Docker

[![License][license-image]][license]

## Introduction

This repository contains the Dockerfiles of base images we use at Snowplow:

- [base-alpine][base-alpine]
- [base-debian][base-debian]
- [k8s-dataflow][k8s-dataflow]

**Note that** we migrated the maintenance of Dockerfiles for pipeline components from this repository to projects' own repositories.

## Pulling

You can pull the images from the registry directly:

```bash
# base-alpine
docker pull snowplow/base-alpine

# base-debian
docker pull snowplow/base-debian

# k8s-dataflow
docker pull snowplow/k8s-dataflow
```

## Building

Alternatively, you can build them yourself:

```bash
# base-alpine
docker build -t snowplow/base-alpine:latest base-alpine

# base-debian
docker build -t snowplow/base-debian:latest base-debian

# k8s-dataflow
docker build -t snowplow/k8s-dataflow:latest k8s-dataflow
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

[license-image]: https://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[license]: https://www.apache.org/licenses/LICENSE-2.0

[base-alpine]: https://hub.docker.com/r/snowplow/base-alpine

[base-debian]: https://hub.docker.com/r/snowplow/base-debian

[k8s-dataflow]: https://hub.docker.com/r/snowplow/k8s-dataflow
