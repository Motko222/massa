#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')

sudo systemctl restart $folder
sudo journalctl -u $folder.service -f --no-hostname -o cat
