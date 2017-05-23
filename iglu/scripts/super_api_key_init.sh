#!/bin/bash
pswd=$(grep password /opt/iglu/conf/iglu.conf | cut -d '=' -f 2 | tr -d '"' | tr -d '\r')
host=$(grep host /opt/iglu/conf/iglu.conf | cut -d '=' -f 2 | tr -d '"' | tr -d '\r' | tail -n1)
port=$(grep port /opt/iglu/conf/iglu.conf | cut -d '=' -f 2 | tr -d '"' | tr -d '\r' | tail -n1)
dbname=$(grep dbname /opt/iglu/conf/iglu.conf | cut -d '=' -f 2 | tr -d '"' | tr -d '\r')
username=$(grep username /opt/iglu/conf/iglu.conf | cut -d '=' -f 2 | tr -d '"' | tr -d '\r')
PGPASSWORD=$(echo $pswd) psql -h $(echo $host) -p $(echo $port) -d $(echo $dbname) -U $(echo $username) -c "insert into apikeys (uid, vendor_prefix, permission, createdat) values ($(echo "'"$API_KEY"'"), '.', 'super', current_timestamp);"
