#!/bin/bash

read -p "Sure ? " sure
case $sure in
 y|Y)
  echo "Killing process..."
  pkill massa-node
  echo "Backing up..."
  cp ~/massa/massa-node/config/node_privkey.key ~/backup/massa/
  cp ~/massa/massa-node/config/config.toml ~/backup/massa/
  cp ~/massa/massa-client/wallet.dat ~/backup/massa/
  echo "Updating..."
  cd ~/massa
  git stash
  git remote set-url origin https://github.com/massalabs/massa.git
  git checkout testnet
  git pull
  echo "Restoring..."
  cp ~/backup/massa//node_privkey.key ~/massa/massa-node/config
  cp ~/backup/massa//config.toml ~/massa/massa-node/config
  cp ~/backup/massa//wallet.dat  ~/massa/massa-client
  echo "Done..."
 ;;
*) echo "Cancelled..." ;;
esac
