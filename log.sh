#!/bin/bash

sudo journalctl -u massad.service -f --no-hostname -o cat
