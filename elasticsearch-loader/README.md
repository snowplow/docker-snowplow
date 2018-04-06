# Elasticsearch Loader

This folder contains the Docker image for [the Snowplow Elasticsearch Loader][es-loader]

## Introduction

This image is based on [the base image][base-image] which leverages
[the Java 8 Alpine image][alpine-image].

The Elasticsearch Loader runs under [dumb-init][dumb-init] which handles reaping zombie processes
and forwards signals on to all processes running in the container. This image also uses
[su-exec][su-exec], as a sudo replacement, to run the Elasticsearch Loader as the non-root
`snowplow` user.

The container exposes the `/snowplow/config` volume to store the loader configuration. If this
folder is bind mounted then ownership will be changed to the `snowplow` user.

The `-XX:+UnlockExperimentalVMOptions` and `-XX:+UseCGroupMemoryLimitForHeap` JVM options will be
automatically provided when launching the loader in order to make the JVM adhere to the memory
limits imposed by Docker. For more information, see [this article][jvm-docker-article].

Additional JVM options can be set through the `SP_JAVA_OPTS` environment variable.

## Usage

Running the container without arguments will print out its usage:

```bash
$ VERSION=0.10.1
$ docker run snowplow-docker-registry.bintray.io/snowplow/elasticsearch-loader:${VERSION}

snowplow-elasticsearch-loader $VERSION

Usage: snowplow-elasticsearch-loader [options]

  --help
  --version
  --config <filename>
```

Alternatively, we can mount a configuration folder and run the loader:

```bash
$ docker run \
  -d \
  -v ${PWD}/config:/snowplow/config \
  snowplow-docker-registry.bintray.io/snowplow/elasticsearch-loader:${VERSION} \
  --config /snowplow/config/config.hocon
```

If we want to specify additional JVM options, we can add the `SP_JAVA_OPTS` environment variable:

```bash
$ docker run \
  -d \
  -v ${PWD}/config:/snowplow/config \
  -e 'SP_JAVA_OPTS=-Xms512m -Xmx512m' \
  snowplow-docker-registry.bintray.io/snowplow/elasticsearch-loader:${VERSION} \
  --config /snowplow/config/config.hocon
```

For a more complete example, check out [the docker compose example][docker-compose-example].

## Copyright and license

The Elasticsearch Loader image is copyright 2017-2018 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[base-image]: https://github.com/snowplow/snowplow-docker/tree/master/base
[docker-compose-example]: https://github.com/snowplow/snowplow-docker/tree/master/example
[alpine-image]: https://github.com/docker-library/openjdk/blob/master/8-jre/alpine/Dockerfile

[es-loader]: https://github.com/snowplow/snowplow-elasticsearch-loader/
[dumb-init]: https://github.com/Yelp/dumb-init
[su-exec]: https://github.com/ncopa/su-exec

[jvm-docker-article]: https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits

[license]: http://www.apache.org/licenses/LICENSE-2.0
