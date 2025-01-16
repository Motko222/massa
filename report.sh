#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
json=~/logs/report-$folder
source ~/.bash_profile

cd ~/massa/massa-client
version=$(cat ~/massa/massa-node/Cargo.toml | grep "version =" | cut -d \" -f 2)
service=$(sudo systemctl status massad --no-pager | grep "active (running)" | wc -l)
foldersize=$(du -hs ~/massa | awk '{print $1}')
cpu=$(sudo systemctl status massad --no-pager | grep CPU | awk '{print $2}')
mem=$(sudo systemctl status massad --no-pager | grep Memory | awk '{print $2}')
final_balance=$(cargo run --release -- -p $MASSA_PWD --json wallet_info 2>/dev/null | jq -r --arg jq_par $MASSA_WALLET '.[$jq_par].address_info.final_balance' | cut -d . -f 1)
active_rolls=$(cargo run --release -- -p $MASSA_PWD --json wallet_info 2>/dev/null | jq -r --arg jq_par $MASSA_WALLET '.[$jq_par].address_info.active_rolls')

#autostake
if [ $final_balance -gt 100 ]
then
 cargo run --release -- -p $MASSA_PWD buy_rolls $MASSA_WALLET $(( $final_balance / 100 )) 0.01 2>/dev/null
fi

if [ $service -ne 1 ]
then 
  status="error";
  message="service not running"
else 
  status="ok";
  message="rol $active_rolls bal $final_balance";
fi

cat >$json << EOF
{ 
  "updated":"$(date --utc +%FT%TZ)",
  "measurement":"report",
  "tags": {
        "id":"$folder",
        "machine":"$MACHINE",
        "owner":"$OWNER",
        "grp":"node" 
  },
  "fields": {
        "network":"mainnet",
        "chain":"mainnet",
        "status":"$status",
        "message":"$message",
        "service":$service,
        "final_balance":$final_balance,
        "active_rolls":$active_rolls
  }
}
EOF

cat $json | jq
