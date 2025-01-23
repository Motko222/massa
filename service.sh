#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
cd $path
source config

printf "[Unit]
Description=Massa Node
After=network-online.target
[Service]
User=root
WorkingDirectory=/root/massa/massa-node
ExecStart=/root/.cargo/bin/cargo run --release -- -p $PASSWORD
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/$folder.service

sudo systemctl daemon-reload
sudo systemctl enable $folder
