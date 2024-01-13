#!/bin/bash

source ~/scripts/massa/config/env

#ver=$(cat ~/logs/massa.log | grep -a "Node version :" | tail -1 | awk '{print $8}')
ver=$(cat ~/massa/massa-node/Cargo.toml | grep "version =" | cut -d \" -f 2)
service=$(sudo systemctl status massad --no-pager | grep "active (running)" | wc -l)
pid=$(pgrep /root/massa/target/release/massa-node)
note=""
network="mainnet"
type="node"
now=$(date +'%y-%m-%d %H:%M')
foldersize=$(du -hs ~/massa | awk '{print $1}')
cpu=$(sudo systemctl status massad --no-pager | grep CPU | awk '{print $2}')
mem=$(sudo systemctl status massad --no-pager | grep Memory | awk '{print $2}')
#logsize=$(du -hs ~/logs/massa.log | awk '{print $1}')

if [ $service -ne 1 ]
then 
  status="error";
  note="service not running"
else 
  status="ok";
fi

#legacy launcher
# note="node restarted";
# cd ~/massa/massa-node;
# cargo run --release -- -p $massapwd >~/logs/massa.log 2>&1 &

echo "updated='$now'"
echo "version='$ver'"
echo "service=$service"
echo "status="$status
echo "note='$note'"
echo "network='$network'"
echo "type="$type
echo "folder=$foldersize"
#echo "log=$logsize" 
echo "id=$massapwd" 
echo "wallet=$massaadr"
echo "cpu=$cpu"
echo "memory=$memory"
