# Igluctl

This folder contains docker images of [igluctl](igluctl).

## Introduction

This image is based on [the base image][base-image] which leverages
[the Java 8 Alpine image][alpine-image].

Igluctl runs under [dumb-init][dumb-init] which handles reaping zombie processes
and forwards signals on to all processes running in the container. This image also uses
[su-exec][su-exec], as a sudo replacement, to run the S3 Loader as the non-root `snowplow` user.

The container exposes the `/snowplow`. If this folder is bind mounted then you can use `lint` and `static generate`.

### Usage

Running the container without arguments will print out its usage:

```bash
$ VERSION=0.6.0
$ docker run snowplow-docker-registry.bintray.io/snowplow/igluctl:${VERSION}

igluctl $VERSION
Usage: igluctl [static|lint] [options] <args>...

  --help                   Print this help message
  --version                Print version info
```

You'll need to mount a volume to lint your schemas:

```bash
$ docker run \
  --rm \
  -t \
  -v ${PWD}:/snowplow
  snowplow-docker-registry.bintray.io/snowplow/igluctl:${VERSION} \
  lint "schemas/"
```

You'll need to mount a volume to generate DLL from your schemas:

```bash
$ docker run \
  --rm \
  -t \
  -v ${PWD}:/snowplow
  snowplow-docker-registry.bintray.io/snowplow/igluctl:${VERSION} \
  static generate --with-json-paths "schemas/"
```

## Copyright & License

The igluctl image &copy; 2018-2018 Snowplow Analytics Ltd

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[base-image]: https://github.com/snowplow/snowplow-docker/tree/master/base
[igluctl]: https://github.com/snowplow/iglu/tree/master/2-repositories/igluctl

[alpine-image]: https://github.com/docker-library/openjdk/blob/master/8/jdk/alpine/Dockerfile
[dumb-init]: https://github.com/Yelp/dumb-init
[su-exec]: https://github.com/ncopa/su-exec

[license]: http://www.apache.org/licenses/LICENSE-2.0
