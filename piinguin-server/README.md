# Piinguin Server

This folder contains

* Dockerfile to build [Piinguin server][piinguin-server]
  * `0.1.1`

## Introduction

[Piinguin server][piinguin-server] images are based on [Snowplow base image][base-image] which leverages [the Java 8 Alpine image][alpine-image].

The Piinguin Server runs under [dumb-init][dumb-init] which handles reaping zombie processes
and forwards signals on to all processes running in the container. This image also uses
[su-exec][su-exec] or [gosu][gosu], as a sudo replacement, to run the Piinguin Server as the non-root `snowplow` user.

The `-XX:+UnlockExperimentalVMOptions` and `-XX:+UseCGroupMemoryLimitForHeap` JVM options will be
automatically provided when launching the server in order to make the JVM adhere to the memory
limits imposed by Docker. For more information, see [this article][jvm-docker-article].

Additional JVM options can be set through the `SP_JAVA_OPTS` environment variable.

### Build

1) Clone repository

    `$ git clone git@github.com:snowplow/snowplow-docker.git`

2) Navigate to `snowplow-docker/piinguin-server/`

    `$ cd snowplow-docker/piinguin-server/`

3) Build image

    From the `piinguin-server` directory of this repo:
```bash
$ VERSION=0.1.1
$ docker build -t piinguin-server:${VERSION} $VERSION
```
    where `VERSION` is version of Piinguin Server one wants to run. Each version of Piinguin Server has a dedicated folder under `snowplow-docker/piinguin-server/` which contains a dedicated `Dockerfile`.

### Run

Running the container with `--help` will print out its usage:

```bash
$ docker run piinguin-server:${VERSION} --help

Usage: piinguin-server [options]

  --help                    prints this help message
  --version                 prints the server version
  -h, --host <value>        host to bind server to
  -p, --port <value>        port number to bind server to
  -t, --table-name <value>  the dynamodb table to use
```

Alternatively, we run the server with:

```bash
$ docker run \
  -d \
  piinguin-server:${VERSION}
```

If we want to specify additional JVM options, we can add the `SP_JAVA_OPTS` environment variable:

```bash
$ docker run \
  -d \
  -e 'SP_JAVA_OPTS=-Xms512m -Xmx512m' \
  piinguin-server:${VERSION}
```

If we want to specify alternative server arguments, we can override the environment variables e.g. `PIINGUIN_PORT`:

```bash
$ docker run \
  -d \
  -e 'PIINGUIN_PORT=12345' \
  piinguin-server:${VERSION}
```

## Copyright & License

The Piinguin Server image &copy; 2018-2019 Snowplow Analytics Ltd

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


[base-image]: https://github.com/snowplow/snowplow-docker/tree/master/base
[piinguin-server]: https://github.com/snowplow-incubator/piinguin
[alpine-image]: https://github.com/docker-library/openjdk/blob/master/8/jre/alpine/Dockerfile
[dumb-init]: https://github.com/Yelp/dumb-init
[su-exec]: https://github.com/ncopa/su-exec
[jvm-docker-article]: https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits
[gosu]: https://github.com/tianon/gosu
