#!/bin/bash

read -p "Sure ? " sure
if [ $sure -ne "y" -a $sure -ne "Y" ]; then exit 1; fi

echo "Backing up..."
cp -r ~/massa/massa-node/config/staking_wallets ~/backup/massa/massa-node/config
cp -r ~/massa/massa-client/wallets ~/backup/massa/massa-client
#cp -r ~/massa/massa-node/config/config.toml ~/backup/massa/massa-node/config
#cp -r ~/massa/massa-client/config/config.toml ~/backup/massa/massa-client/config

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
cp -r ~/backup/massa/massa-node/config/staking_wallets  ~/massa/massa-node/config
cp -r ~/backup/massa/massa-client/wallets ~/massa/massa-client
#cp ~/backup/massa/massa-node/config/config.toml ~/massa/massa-node/config
#cp ~/backup/massa/massa-client/config/config.toml ~/massa/massa-client/config

echo "Done..."

 
