#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
source $path/config
json=/root/logs/report-$folder

cd /root/massa/massa-client
version=$(cat /root/massa/massa-node/Cargo.toml | grep "version =" | cut -d \" -f 2)
service=$(sudo systemctl status $folder --no-pager | grep "active (running)" | wc -l)
final_balance=$(cargo run --release -- -p $PASSWORD --json wallet_info 2>/dev/null | jq -r --arg jq_par $WALLET '.[$jq_par].address_info.final_balance' | cut -d . -f 1)
active_rolls=$(cargo run --release -- -p $PASSWORD --json wallet_info 2>/dev/null | jq -r --arg jq_par $WALLET '.[$jq_par].address_info.active_rolls')
node_error=$(cargo run --release -- -p $PASSWORD --json get_status 2>/dev/null | jq -r .error | sed 's/\"//g'  )

#autostake
if [ $final_balance -gt 100 ]
then
 cargo run --release -- -p $PASSWORD buy_rolls $WALLET $(( $final_balance / 100 )) 0.01 2>/dev/null
fi

status="ok"; message="";
[ -z $node_error ] && status="error" && message=$node_error
[ $service -ne 1 ] && status="error" && message="service not running"

cat >$json << EOF
{ 
  "updated":"$(date --utc +%FT%TZ)",
  "measurement":"report",
  "tags": {
        "id":"$folder-$ID",
        "machine":"$MACHINE",
        "owner":"$OWNER",
        "grp":"node" 
  },
  "fields": {
        "network":"mainnet",
        "chain":"massa",
        "version":"$version",
        "status":"$status",
        "message":"$message",
        "m1":"rol=$active_rolls fin=$final_balance",
        "m2":"$node_error"
  }
}
EOF

cat $json | jq
