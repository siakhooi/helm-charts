#!/bin/bash

set -e
set -x

sudo apt install -y gpg
sudo apt install -y python3-venv

python3 -m venv "/tmp/venv"

# shellcheck disable=SC1091
source "/tmp/venv/bin/activate"

pip3 install helm-sign
