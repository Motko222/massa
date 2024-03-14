#!/bin/bash

source ~/.bash_profile

sudo systemctl restart massad
sudo journalctl -u massad.service -f --no-hostname -o cat
