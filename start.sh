#!/bin/bash

source ~/scripts/massa/config/env

echo "Killing process..."
pkill massa-client
sleep 1s
cd ~/massa/massa-node
echo "Starting..."
cargo run --release -- -p $massapwd >~/logs/massa.log 2>&1 &
