# Iglu Server on docker compose

## Usage

1) Navigate to the `example/docker-compose` directory, assuming you are in `snowplow-docker/iglu-server/`,

    `$ cd example/docker-compose`

2) Run Iglu Server with Postgres in detached mode

    `$ docker-compose up -d`

### Insert the super API key

The following command inserts an example super API key which can be used for generating API keys
with read/write privileges for a specific vendor prefix.

If you have super API key `1d9c7e70-012b-11e8-ba89-0ed5f89f718b` with database credentials of
[the docker compose example][docker-compose-example], run the below command to insert your super API
key.

```
 $ docker exec -it iglu-server \
   psql -h "postgres" -p 5432  -d igludb -U sp_user \
   -c "insert into apikeys(uid, vendor_prefix, permission, createdat) values ('1d9c7e70-012b-11e8-ba89-0ed5f89f718b', '*', 'super', current_timestamp);"
```

Now you are ready to use Iglu Server. Below are some sample usages for some endpoints.

### Generate read/write API keys for a vendor

The following POST request generates read and write API keys for a specific vendor prefix returned
in JSON format.

```
curl -X POST \
  http://localhost:8080/api/auth/keygen?vendor_prefix=<a_vendor_prefix> \
  -H 'apikey: <your_super_API_key>'
```

Example response:

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

Example response:

```
{
  "status" : 201,
  "message" : "Schema successfully added",
  "location" : "/api/schemas/<vendor_prefix>/<schema_name>/jsonschema/<schema_version>"
}
```
