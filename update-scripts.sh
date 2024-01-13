#!/bin/bash

cd ~/scripts/massa
git stash push --include-untracked
git pull
chmod +x *.sh
