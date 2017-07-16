# snowplow-scala-collector
Snowplow Scala Collector

## Create topics

  Create the topics in the running kafka instance

```
bin/kafka-topics.sh --create --zookeeper zk:2181 --replication-factor 1 --partitions 1 --topic collector-payloads
bin/kafka-topics.sh --create --zookeeper zk:2181 --replication-factor 1 --partitions 1 --topic bad-1
```

### Envinonment variables

Check `assets/config.template`

For example the domain variable takes two both a host and domain:

```
    domain = "${SNOWPLOW_HOST}.${SNOWPLOW_DOMAIN}"
```

to see an example of this try the rancher template:

https://github.com/WebHostingCoopTeam/whc-catalog/tree/master/templates/snowplow-scala-collector
