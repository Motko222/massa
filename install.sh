#!/bin/bash

read -p "Sure ? " sure
if [ $sure -ne "y" -a $sure -ne "Y" ]; then exit 1; fi

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')

cd ~
sudo systemctl stop $folder 

rm -r ~/massa
sudo apt install pkg-config curl git build-essential libssl-dev libclang-dev cmake
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustc --version
rustup toolchain install 1.74.1
rustup default 1.74.1
rustc --version
git clone --branch mainnet https://github.com/massalabs/massa.git

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
WantedBy=multi-user.target" > /etc/systemd/system/massad.service

sudo systemctl daemon-reload
sudo systemctl enable $folder

