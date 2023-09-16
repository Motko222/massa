#!/bin/bash

read -p "Sure ? " sure

case $sure in
 y|Y)
  cd $~
  pkill massa-node
  rm -r ~/massa
  sudo apt install pkg-config curl git build-essential libssl-dev libclang-dev cmake
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source ~/.cargo/env
  rustc --version
  rustup toolchain install 1.72.0
  rustup default 1.72.0
  rustc --version
  git clone --branch testnet https://github.com/massalabs/massa.git

  if [ -f ~/scripts/massa/config/env] 
    then
      echo "Config file found."
    else
      echo "Config file not found, creating one."
      cp ~/scripts/massa/config/env.sample ~/scripts/massa/config/env
  fi
 ;;
*) echo Cancelled... ;;
esac
