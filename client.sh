#!/bin/bash

source ~/scripts/massa/config/env

echo "--- COMMANDS ---"
echo "wallet_info"
echo "buy_rolls "$massaadr" 1 0"
echo "node_start_staking "$massaadr
echo "wallet_add_secret_keys <your_secret_key>"
#echo "node_testnet_rewards_program_ownership_proof "$massaadr" "$discordid
echo "---"
cd ~/massa/massa-client
cargo run --release -- -p $massapwd
#cargo run -- --wallet wallet.dat
