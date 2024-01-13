#!/bin/bash

source ~/scripts/massa/config/env

#ver=$(cat ~/logs/massa.log | grep -a "Node version :" | tail -1 | awk '{print $8}')
pid=$(pgrep /root/massa/target/release/massa-node)
note=""
network="mainnet"
type="-"
now=$(date +'%y-%m-%d %H:%M')
foldersize=$(du -hs ~/massa | awk '{print $1}')
logsize=$(du -hs ~/logs/massa.log | awk '{print $1}')


#if [ -z $pid ];
#then status="error";
# note="node restarted";
# cd ~/massa/massa-node;
# cargo run --release -- -p $massapwd >~/logs/massa.log 2>&1 &
#else status="ok";
#fi

echo "updated='$now'"
echo "version='$ver'"
echo "process='$pid'"
echo "status="$status
echo "note='$note'"
echo "network='$network'"
echo "type="$type
echo "folder=$foldersize"
echo "log=$logsize" 
echo "id=$massapwd" 
echo "wallet=$massaadr"
