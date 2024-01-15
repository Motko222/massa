#!/bin/bash

#tail -f ~/logs/massa.log

sudo journalctl -u massad.service -f --no-hostname -o cat
