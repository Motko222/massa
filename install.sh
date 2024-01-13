#!/bin/bash

read -p "Sure ? " sure

case $sure in
 y|Y)
  cd ~
  pkill massa-node
  rm -r ~/massa
  sudo apt install pkg-config curl git build-essential libssl-dev libclang-dev cmake
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source ~/.cargo/env
  rustc --version
  rustup toolchain install 1.74.1
  rustup default 1.74.1
  rustc --version
  git clone --branch mainnet https://github.com/massalabs/massa.git

  if [ -f ~/scripts/massa/config/env ] 
    then
      echo "Config file found."
    else
     read -p "Password? " massapwd
     read -p "Wallet? " massaadr
     echo "massapwd="$massapwd >> ~/scripts/massa/config/env
     echo "massaadr="$massaadr > ~/scripts/massa/config/env
     echo "Config file created."
  fi

printf "[Unit]
Description=Massa Node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/massa/massa-node
ExecStart=$HOME/massa/massa-node/massa-node -p $massapwd
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/massad.service

sudo systemctl daemon-reload
sudo systemctl enable massad

 ;;
*) echo Cancelled... ;;
esac
