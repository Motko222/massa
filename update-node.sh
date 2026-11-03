#!/bin/bash
# Update the Massa node to a new release tag.
# Usage: update-node.sh <tag>   (see https://github.com/massalabs/massa/releases)
set -e

if [[ -z "$1" ]]; then
  echo "Usage: $0 <tag>  (see https://github.com/massalabs/massa/releases)"
  exit 1
fi
TAG="$1"

TS=$(date +%Y%m%d%H%M%S)
BK="$HOME/backup/massa/$TS"
mkdir -p "$BK/massa-node/config" "$BK/massa-client"

echo "Stopping massa.service..."
systemctl stop massa.service

echo "Backing up config/wallets to $BK..."
cp -r ~/massa/massa-node/config/staking_wallets  "$BK/massa-node/config/"
cp -r ~/massa/massa-node/config/config.toml       "$BK/massa-node/config/"
cp -r ~/massa/massa-node/config/node_privkey.key  "$BK/massa-node/config/"
cp -r ~/massa/massa-client/wallets                "$BK/massa-client/"
cp -r ~/massa/massa-client/config/config.toml     "$BK/massa-client/"

echo "Updating to $TAG..."
cd ~/massa
git fetch --tags
git checkout "$TAG"

echo "Starting massa.service (cargo will rebuild for $TAG, this takes a while)..."
systemctl start massa.service

echo "Done. Tail logs with: journalctl -u massa.service -f"
