# Iglu Server

This folder contains

* docker images of [Iglu Server](iglu-server)
  * `0.3.0`
  * `0.4.0`
* a docker compose example to run [Iglu Server](iglu-server) with [Postgres](https://github.com/docker-library/postgres)

## Introduction

[Iglu Server](iglu-server) images are based on [Snowplow base image][base-image] which leverages [the Java 8 Alpine image][alpine-image].

The Iglu Server runs under [dumb-init][dumb-init] which handles reaping zombie processes
and forwards signals on to all processes running in the container. This image also uses
[su-exec][su-exec], as a sudo replacement, to run the Iglu Server as the non-root `snowplow` user.

The container exposes the `/snowplow/config` volume to store the server configuration. If this
folder is bind mounted then ownership will be changed to the `snowplow` user.

The `-XX:+UnlockExperimentalVMOptions` and `-XX:+UseCGroupMemoryLimitForHeap` JVM options will be
automatically provided when launching the server in order to make the JVM adhere to the memory
limits imposed by Docker. For more information, see [this article][jvm-docker-article].

Additional JVM options can be set through the `SP_JAVA_OPTS` environment variable.

### Build

1) Clone repository

    `$ git clone git@github.com:snowplow/snowplow-docker.git`

2) Navigate to `snowplow-docker/iglu-server/`

    `$ cd snowplow-docker/iglu-server/`

3) Build image    

    ```
    $ VERSION=0.4.0
    $ docker build -t iglu-server:${VERSION} $VERSION
    ```

    where `VERSION` is version of Iglu Server one wants to run. Each version of Iglu Server has a dedicated folder under `snowplow-docker/iglu-server/` which contains a dedicated `Dockerfile`.

### Usage

After building an image for server, there are two options:

  1) Running standalone image with postgres on docker host
  2) Running with postgres in docker-compose

Either way, a super API key needs to be inserted into database. `Iglu Server` makes use of an UUID key, called super API key to generate other API keys.

After that, you can start using Iglu Server.

### Run

#### 1. Running standalone server image with postgres on docker host

###### Important note

Make sure that your config file contains proper db configuration and you've inserted your super API key. An example config can be found [here](example-config).

`Build` step above defines an environment variable `VERSION` being used across this page. If you preferred pulling image instead of building, you can define it as following.

    $ VERSION=0.3.0

Running the container without arguments will print out its usage:

```bash
$ docker run iglu-server:${VERSION}

iglu-server $VERSION
Usage: iglu-server [options]

  --help               Print this help message
  --version            Print version info
  --config <filename>  Path to custom config file. It is required and can not be empty.
```

Alternatively, we can mount a configuration folder and run the server:

```bash
$ docker run \
  -d \
  -v ${PWD}/config:/snowplow/config \
  iglu-server:${VERSION} \
  --config /snowplow/config/application.conf
```

If we want to specify additional JVM options, we can add the `SP_JAVA_OPTS` environment variable:

```bash
$ docker run \
  -d \
  -v ${PWD}/config:/snowplow/config \
  -e 'SP_JAVA_OPTS=-Xms512m -Xmx512m' \
  iglu-server:${VERSION} \
  --config /snowplow/config/application.conf
```

#### 2. Running with postgres in docker-compose

An example docker-compose for iglu server and postgres can be found at [the docker compose example][docker-compose-example].

1) Navigate to `example` directory, assuming you are in `snowplow-docker/iglu-server/`,

    `$ cd example/`

2) Run Iglu Server with Postgres in detached mode

    `$ docker-compose up -d`

#### Insert the super API key

The following command inserts an example super API key which can be used for generating API keys with read/write privileges for a specific vendor prefix.

If you have super API key `1d9c7e70-012b-11e8-ba89-0ed5f89f718b` with database credentials of [the docker compose example][docker-compose-example], run below command to insert your super API key.

```
 $ docker exec -it iglu-server \
   psql -h "postgres" -p 5432  -d igludb -U sp_user \
   -c "insert into apikeys(uid, vendor_prefix, permission, createdat) values ('1d9c7e70-012b-11e8-ba89-0ed5f89f718b', '*', 'super', current_timestamp);"
```

Now you are ready to use Iglu Server. Below are sample usages for some endpoints.

### Generate read/write API keys for a vendor

The following POST request generates read and write API keys for a specific vendor prefix returned in JSON format.

```
curl -X POST \
  http://localhost:8080/api/auth/keygen?vendor_prefix=<a_vendor_prefix> \
  -H 'apikey: <your_super_API_key>'
```

Example response

```
{
  "read" : "uuid_read",
  "write" : "uuid_write"
}
```

### Upload your own JSON schema to the repository

Assuming a pair of read/write key is gathered for vendor of the schema to be uploaded

```
curl -X POST \
  http://localhost:8080/api/schemas/<your vendor prefix>/<your_schema_name>/jsonschema/<your_schema_version> \
  -H 'apikey: <vendor's_write_API_key>' \
  -d '{
  "$schema": "http://iglucentral.com/schemas/com.snowplowanalytics.self-desc/schema/jsonschema/1-0-0#",
  "description": "Schema for an example event",
  "self": {
    "vendor": "<vendor_prefix>",
    "name": "<schema_name>",
    "format": "jsonschema",
    "version": "<schema_version>"
  },

  "type": "object",
  "properties": {
    "<a_property_name>": {
      "type": "string",
      "maxLength": 255
    }
  },
  "minProperties":1,
  "required": ["<a_property_name>"],
  "additionalProperties": false
}'
```

Example response

```
{
  "status" : 201,
  "message" : "Schema successfully added",
  "location" : "/api/schemas/<vendor_prefix>/<schema_name>/jsonschema/<schema_version>"
}
```

## Copyright & License

The Iglu Server image &copy; 2018 Snowplow Analytics Ltd

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[base-image]: https://github.com/snowplow/snowplow-docker/tree/master/base
[iglu-server]: https://github.com/snowplow/iglu/tree/master/2-repositories/iglu-server
[docker-compose-example]: https://github.com/snowplow/snowplow-docker/tree/master/iglu-server/example
[example-config]: https://github.com/snowplow/snowplow-docker/tree/master/iglu-server/example/config/application.conf

[alpine-image]: https://github.com/docker-library/openjdk/blob/master/8-jre/alpine/Dockerfile
[dumb-init]: https://github.com/Yelp/dumb-init
[su-exec]: https://github.com/ncopa/su-exec
[jvm-docker-article]: https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits

[license]: http://www.apache.org/licenses/LICENSE-2.0
