#!/bin/bash

read -p "Sure ? " sure
case $sure in
 y|Y)
  echo "Killing process..."
  pkill massa-node
  echo "Backing up..."
  cp ~/massa/massa-node/config/node_privkey.key ~/scripts/massa/config
  cp ~/massa/massa-node/config/config.toml ~/scripts/massa/config
  cp ~/massa/massa-client/wallet.dat ~/scripts/massa/config
  echo "Updating..."
  cd ~/massa
  git stash
  git remote set-url origin https://github.com/massalabs/massa.git
  git checkout testnet
  git pull
  echo "Restoring..."
  cp ~/scripts/massa/config/node_privkey.key ~/massa/massa-node/config
  cp ~/scripts/massa/config/config.toml ~/massa/massa-node/config
  cp ~/scripts/massa/config/wallet.dat  ~/massa/massa-client
  echo "Done..."
 ;;
*) echo "Cancelled..." ;;
esac
