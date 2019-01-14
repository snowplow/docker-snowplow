# Iglu Server on Kubernetes

This folder contains

* kubectl files to deploy workload on a Kubernetes cluster
  * postgres.yaml - deployment of a Postgres database server
  * iglu-server - deployment of the Snowplow Iglu 0.4.0 server
* an example configuration file for Iglu
  * application.conf

## Introduction

The configuration files are very basic examples, which are deploying the Progres server and the Iglu server as NodePort servers on the Kubernetes cluster. For production environments you may want to use load balancer services - the Service configuration in the yaml files need to be changed in this case (type: LoadBalancer).

### Deployement steps

1) Clone repository

    `$ git clone git@github.com:snowplow/snowplow-docker.git`

2) Navigate to `snowplow-docker/iglu-server/0.4.0/Kubernetes`

    `$ cd snowplow-docker/iglu-server/0.4.0/Kubernetes`

3) Deploy the Postgres server

    `$ kubectl create -f postgres.yaml`

4) Retrieve host and port of the Postgres server from the Kuvernetes cluster and modify the application.conf file accordingly (postgres host and port)

    `$ kubectl describe nodes`
    `$ kubectl get services prostgres-srv`

5) Creation of a configmap on the Kubernetes cluster for the Iglu server based on the application.conf file

    `$ kubectl create configmap iglu-config --from-file=application.conf`

6) Deploy the Iglu server

    `$ kubectl create f iglu-server.yaml`

After that, the Iglu Server is running on Kubernetes as a NodePort service.

#### Insert the super API key

The following command inserts an example super API key which can be used for generating API keys with read/write privileges for a specific vendor prefix.

If you have super API key `1d9c7e70-012b-11e8-ba89-0ed5f89f718b` with database credentials of the application.conf example, run below command to insert your super API key (you will have to change the host IP address and port - accoding to the IP and port of the Postgres NodePort server on the Kubernetes cluster).

```
 $ psql -h "46.101.66.208" -p 30753  -d igludb -U test_user \
   -c "insert into apikeys(uid, vendor_prefix, permission, createdat) values ('1d9c7e70-012b-11e8-ba89-0ed5f89f718b', '*', 'super', current_timestamp);"
```

### Generate read/write API keys for a vendor

The following POST request generates read and write API keys for a specific vendor prefix returned in JSON format.

```
curl -X POST \
  http://46.101.66.208:30773/api/auth/keygen?vendor_prefix=<a_vendor_prefix> \
  -H 'apikey: <your_super_API_key>'
```

Example response

```
{
  "read" : "uuid_read",
  "write" : "uuid_write"
}
```
