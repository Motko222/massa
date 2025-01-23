#!/bin/bash

read -p "Sure ? " sure
if [ $sure -ne "y" -a $sure -ne "Y" ]; then exit 1; fi

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
cd $path
source config

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

