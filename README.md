# docker-snowplow


## What it Gives You

* Snowplow stream iglu
* A docker container with Postgres for Scala Repository Server ([postgres](https://github.com/docker-library/postgres))

## Quick Start

### Build

```
 docker build -t stream-iglu snowplow/iglu
```

### Run

Before running make sure to replace the API_KEY environment variable in the docker compose file e.g. 8a651c6a-3fbb-11e7-a919-92ebcb67fe33

```
 docker-compose up -d
```

### Generate the super API key

The following command creates the super API key wich can be used for generating API keys with read/write privileges for a specific vendor prefix.

```
 docker exec stream-iglu /opt/iglu/scripts/super_api_key_init.sh
```

### Generate API key 

The following POST request generates read and write API keys for a specific vendor prefix returned in JSON format. It is need to be applied on the host machine.

```
curl -X POST \
  http://localhost:8080/api/auth/keygen \
  -H 'apikey: <your super API key>' \
  -H 'content-type: multipart/form-data \
  -F vendor_prefix=<your desired prefix>
```

Example response

```
{
  "read" : "uuid_read",
  "write" : "uuid_write"
}
```

### Upload your own JSON schema to the repository

Need to be executed on host machine. Response message is in JSON format.

```
curl -X POST \
  http://localhost:8080/api/schemas/<your vendor prefix>/<your schema name>/jsonschema/<your schema version> \
  -H 'apikey: <your write API key>' \
  -d '{
  "$schema": "http://iglucentral.com/schemas/com.snowplowanalytics.self-desc/schema/jsonschema/1-0-0#",
  "description": "Schema for an example event",
  "self": {
    "vendor": "<your vendor prefix>",
    "name": "<your schema name>",
    "format": "jsonschema",
    "version": "<your schema version>"
  },

  "type": "object",
  "properties": {
    "<your property name>": {
      "type": "string",
      "maxLength": 255
    }
  },
  "minProperties":1,
  "required": ["<your property name>"],
  "additionalProperties": false
}'
```

Example response

```
{
  "status" : 201,
  "message" : "Schema successfully added",
  "location" : "/api/schemas/<your vendor prefix>/<your schema name>/jsonschema/<your schema version>"
}
```
### Modifying resolver config

The default resolrver.json should be modified to make stream enrich work with the repository server. The following modifications need to be applied:

* Append your own repository server config to the repositories list as following separated with comma

```
{
	"name": "<Your desired name>",
	"priority": <Your priority number (0 or greater)>,
	"vendorPrefixes": [
	  "<your vendor prefix>"
	],
	"connection": {
	  "http": {
	    "uri": "http://stream-iglu:8080/api",
	    "apikey": "<your read API key for the vendor prefix>"
	  }
	}
}
```