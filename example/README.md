# Docker Compose example

This folder contains a Docker Compose example for the Snowplow realtime pipeline.

## Introduction

This Docker Compose example bundles the following components in two distinct containers:

- [Scala Stream Collector][ssc]
- [Stream Enrich][se]

As is, the configuration files make the following assumptions regarding Kinesis streams:

- The `snowplow-raw` stream exists and is used to store the collected events
- The `snowplow-enriched` stream exists and is used to store the enriched events
- The `snowplow-bad` stream exists and is used to store the events which failed validation

All those streams being located in `us-east-1`. To authenticate the components, the
[DefaultAWSCredentialsProviderChain][dacpc] is used.

Feel free to modify those configuration files to suit your needs.

## Usage

Once you have configured the configuration files to your liking, you can launch those two components
with:

```bash
$ docker swarm init
$ docker stack deploy -c docker-compose.yml snowplow-realtime
```

To stop the components:

```bash
$ docker stack rm snowplow-realtime
```

## Copyright and license

The Docker Compose example is copyright 2017-2017 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[ssc]: https://github.com/snowplow/snowplow-docker/tree/master/scala-stream-collector
[se]: https://github.com/snowplow/snowplow-docker/tree/master/stream-enrich

[dacpc]: http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/auth/DefaultAWSCredentialsProviderChain.html

[license]: http://www.apache.org/licenses/LICENSE-2.0