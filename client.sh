#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
source $path/config
source /root/.bash_profile

echo "--- COMMANDS ---"
echo "wallet_info"
echo "buy_rolls "$WALLET" 1 0.01"
echo "node_start_staking "$WALLET
echo "wallet_add_secret_keys <your_secret_key>"
echo "---"
cd ~/massa/massa-client
cargo run --release -- -p $PASSWORD
#cargo run -- --wallet wallet.dat
