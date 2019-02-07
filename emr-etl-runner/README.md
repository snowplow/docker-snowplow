# EMR ETL Runner

This folder contains the Docker images for [EmrEtlRunner][emr-etl-runner].

## Introduction

This image is based on [the debian base image][debian-base-image] which leverages
[the Java 8 Debian image][debian-image] due to a [JRuby bug][jruby-bug] still unsolved.

EmrEtlRunner uses [gosu][gosu], as a sudo replacement, to run as the non-root `snowplow` user.

The container exposes the `/snowplow/config` volume to store EmrEtlRunner configuration files. If
this folder is bind mounted then ownership will be changed to the `snowplow` user.

## Usage

Running the container without arguments will print out its usage:

```bash
$ VERSION=r109_lambaesis
$ docker run snowplow-docker-registry.bintray.io/snowplow/emr-etl-runner:${VERSION}

Usage snowplow-emr-etl-runner [options] [command [options]]

Available commands are:
run: Run the Snowplow pipeline on EMR
generate emr-config: Generate a Dataflow Runner EMR config which can be used with dataflow-runner up
generate emr-playbook: Generate a Dataflow Runner Playbook config which can be used with dataflow-runner run
generate all: Generate both a Dataflow Runner EMR (as emr-config.json) and Playbook (as emr-playbook.json) configs
lint resolver: Lint an Iglu resolver config to check if it is valid with respect to its schema
lint enrichments: Lint enrichments to check if they are valid with respect to their schemas
lint all: Lint both Iglu resolver config and enrichments to check if they are valid with respect to their schemas

Global options are:
    -v, --version                    Show version
```

Alternatively, we can mount a configuration folder and run EmrEtlRunner:

```bash
$ docker run \
  -d \
  -v ${PWD}/config:/snowplow/config \
  snowplow-docker-registry.bintray.io/snowplow/emr-etl-runner:${VERSION} \
  run \
  --config /snowplow/config/config.yml \
  --resolver /snowplow/config/resolver.json \
  --enrichments /snoplow/config/enrichments/
```

## Copyright and license

The EmrEtlRunner image is copyright 2018-2019 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[emr-etl-runner]: https://github.com/snowplow/snowplow/tree/master/3-enrich/emr-etl-runner
[debian-image]: https://github.com/docker-library/openjdk/blob/master/8/jre/slim/Dockerfile
[debian-base-image]: https://github.com/snowplow/snowplow-docker/tree/develop/base-debian
[jruby-bug]: https://discourse.snowplowanalytics.com/t/systemcallerror-unknown-error-unknown-error-0-home-ubuntu-netrc/452
[gosu]: https://github.com/tianon/gosu
[license]: http://www.apache.org/licenses/LICENSE-2.0
