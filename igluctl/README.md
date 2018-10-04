# Igluctl

This folder contains

* docker images of [igluctl](igluctl)
  * `0.6.0`
  * `0.5.0`

## Introduction

This image is based on [the base image][base-image] which leverages
[the Java 8 Alpine image][alpine-image].

The igluctl runs under [dumb-init][dumb-init] which handles reaping zombie processes
and forwards signals on to all processes running in the container. 

The container exposes the `/snowplow`. If this folder is bind mounted then you can use `lint` and `static generate`.

The `-XX:+UnlockExperimentalVMOptions` and `-XX:+UseCGroupMemoryLimitForHeap` JVM options will be
automatically provided when launching the server in order to make the JVM adhere to the memory
limits imposed by Docker. For more information, see [this article][jvm-docker-article].

Additional JVM options can be set through the `SP_JAVA_OPTS` environment variable.

### Build

1) Clone repository

    `$ git clone git@github.com:snowplow/snowplow-docker.git`

2) Navigate to `snowplow-docker/igluctl/`

    `$ cd snowplow-docker/igluctl/`

3) Build image    

    ```
    $ VERSION=0.6.0
    $ docker build -t igluctl:${VERSION} $VERSION
    ```

    where `VERSION` is version of igluctl one wants to run. Each version of igluctl has a dedicated folder under `snowplow-docker/igluctl/` which contains a dedicated `Dockerfile`.

### Usage

Running the container without arguments will print out its usage:

```bash
$ docker run igluctl:${VERSION}

igluctl $VERSION
Usage: igluctl [static|lint] [options] <args>...

  --help                   Print this help message
  --version                Print version info
```

Navigate to your project directory.


You'll need to mount a volume to lint your schemas:

```bash
$ docker run \
  --rm \
  -t \
  -v ${PWD}:/snowplow
  igluctl:${VERSION} \
  lint "schemas/"
```

You'll need to mount a volume to generate DLL from your schemas:

```bash
$ docker run \
  --rm \
  -t \
  -v ${PWD}:/snowplow
  igluctl:${VERSION} \
  static generate --with-json-paths "schemas/"
```

If we want to specify additional JVM options, we can add the `SP_JAVA_OPTS` environment variable:

```bash
$ docker run \
  -e 'SP_JAVA_OPTS=-Xms512m -Xmx512m' \
  -t \
  -v ${PWD}:/snowplow
  igluctl:${VERSION} \
```

## Copyright & License

The igluctl image &copy; 2018 Snowplow Analytics Ltd

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[base-image]: https://github.com/snowplow/snowplow-docker/tree/master/base
[iglu-server]: https://github.com/snowplow/iglu/tree/master/2-repositories/iglu-server
[igluctl]: https://github.com/snowplow/iglu/tree/master/2-repositories/igluctl
[docker-compose-example]: https://github.com/snowplow/snowplow-docker/tree/master/igluctl/example
[example-config]: https://github.com/snowplow/snowplow-docker/tree/master/igluctl/example/config/application.conf

[alpine-image]: https://github.com/docker-library/openjdk/blob/master/8/jdk/alpine/Dockerfile
[dumb-init]: https://github.com/Yelp/dumb-init
[su-exec]: https://github.com/ncopa/su-exec
[jvm-docker-article]: https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits

[license]: http://www.apache.org/licenses/LICENSE-2.0
