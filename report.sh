#!/bin/bash

source ~/.bash_profile

version=$(cat ~/massa/massa-node/Cargo.toml | grep "version =" | cut -d \" -f 2)
service=$(sudo systemctl status massad --no-pager | grep "active (running)" | wc -l)
chain="mainnet"
foldersize=$(du -hs ~/massa | awk '{print $1}')
cpu=$(sudo systemctl status massad --no-pager | grep CPU | awk '{print $2}')
mem=$(sudo systemctl status massad --no-pager | grep Memory | awk '{print $2}')
id=massa-$MASSA_ID
bucket=node

if [ $service -ne 1 ]
then 
  status="error";
  message="service not running"
else 
  status="ok";
fi

cat << EOF
{
  "id":"$id",
  "machine":"$MACHINE",
  "chain":"$chain",
  "type":"node",
  "status":"$status",
  "message":"$message",
  "service":$service,
  "updated":"$(date --utc +%FT%TZ)"
}
EOF

# send data to influxdb
if [ ! -z $INFLUX_HOST ]
then
 curl --request POST \
 "$INFLUX_HOST/api/v2/write?org=$INFLUX_ORG&bucket=$bucket&precision=ns" \
  --header "Authorization: Token $INFLUX_TOKEN" \
  --header "Content-Type: text/plain; charset=utf-8" \
  --header "Accept: application/json" \
  --data-binary "
    status,node=$id,machine=$MACHINE status=\"$status\",message=\"$message\",version=\"$version\",url=\"$url\",chain=\"$chain\" $(date +%s%N) 
    "
fi
