#!/bin/bash

source ~/.bash_profile

#echo "Killing process..."
#pkill massa-client
#sleep 1s
#cd ~/massa/massa-node
#echo "Starting..."
#cargo run --release -- -p $MASSA_PWD >~/logs/massa.log 2>&1 &

sudo systemctl restart massad
sudo journalctl -u massad.service -f --no-hostname -o cat
