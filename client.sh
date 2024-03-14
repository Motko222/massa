#!/bin/bash

source ~/.bash_profile

echo "--- COMMANDS ---"
echo "wallet_info"
echo "buy_rolls "$MASSA_WALLET" 1 0"
echo "node_start_staking "$MASSA_WALLET
echo "wallet_add_secret_keys <your_secret_key>"
echo "---"
cd ~/massa/massa-client
cargo run --release -- -p $MASSA_PWD
#cargo run -- --wallet wallet.dat
