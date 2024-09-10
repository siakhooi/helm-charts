#!/bin/bash

set -e
set -x

apt install -y gpg
apt install -y python3-venv

tempDir=$(mktemp -d)

python3 -m venv "$tempDir"

# shellcheck disable=SC1091
source "$tempDir/bin/activate"

pip3 install helm-sign
