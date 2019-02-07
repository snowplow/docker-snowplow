# Docker Compose example

This folder contains a Docker Compose example for the Snowplow realtime pipeline.

## Introduction

This Docker Compose example bundles the following Snowplow components in two distinct containers:

- [Scala Stream Collector][ssc]
- [Stream Enrich][se]

Additionally, they make use of [NSQ][nsq] topics to store events, the NSQ components are running
in four different containers:

- nsqd: the daemon in charge of receiving, queueing and delivering messages
- nsqlookupd: the daemon taking care of managing who produces and consumes what
- nsqadmin: a web UI to perform administrative tasks as well as giving an overview of the NSQ
topology, its web interface is available at port 4171
- nsq_pubsub: which lets you consume NSQ topics given a subscription channel you can create through
the nsqadmin UI. For example, to consume your bad rows, given a channel named `bad_channel` you can
hit the `http://127.0.0.1:8081/sub?topic=bad&channel=bad_channel` endpoint

## Usage

Once you have modified the configuration files to your liking, you can launch those two components
with:

```bash
$ docker swarm init # only required the first time
$ docker stack deploy -c docker-compose.yml snowplow-realtime
```

To stop the components:

```bash
$ docker stack rm snowplow-realtime
```

## Copyright and license

The Docker Compose example is copyright 2017-2019 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[ssc]: https://github.com/snowplow/snowplow-docker/tree/master/scala-stream-collector
[se]: https://github.com/snowplow/snowplow-docker/tree/master/stream-enrich

[nsq]: http://nsq.io/

[license]: http://www.apache.org/licenses/LICENSE-2.0
