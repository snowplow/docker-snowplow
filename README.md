# docker-snowplow

This image can be used to quickly get up and running a local Snowplow with Kafka.

## What it Gives You

* Snowplow stream collector
* Snowplow stream enrich
* A docker container with both Kafka and Zookeeper [spotify/kafka](https://github.com/spotify/docker-kafka)

## Quick Start

### Build

```
 docker build --build-arg SNOWPLOW_VER=<your desired version> -t snowplow/snowplow snowplow/
```

### Run

The following command starts the Snowplow collector and enrich containers and a local Kafka instance.

```
 docker-compose up -d
```


### Modifying Services

By default, the containers mount the config files from the config directory. If you want to change the default configuration just make changes in the config files and restart the containers.
