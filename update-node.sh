#!/bin/bash

read -p "Sure ? " sure
if [ $sure -ne "y" -a $sure -ne "Y" ]; then exit 1; fi

echo "Backing up..."
cp ~/massa/massa-node/config/node_privkey.key ~/
cp ~/massa/massa-node/config/config.toml ~/
cp ~/massa/massa-client/wallet.dat ~/

read -p "tag? (https://github.com/massalabs/massa/releases) " tag

echo "Updating..."
cd ~/massa
#git stash
#git remote set-url origin https://github.com/massalabs/massa.git
#git checkout mainnet
#git pull

git fetch
git checkout $tag

echo "Restoring..."
cp ~/node_privkey.key ~/massa/massa-node/config
cp ~/config.toml ~/massa/massa-node/config
cp ~/wallet.dat ~/massa/massa-client

echo "Done..."

 
