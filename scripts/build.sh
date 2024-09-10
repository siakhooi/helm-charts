#!/bin/bash

set -e
set -x

# shellcheck disable=SC1091
source "/tmp/venv/bin/activate"

GNUPGHOME="$(mktemp -d)"
export GNUPGHOME

echo "$GPG_PRIVATE_KEY" | gpg --import
gpg --list-keys

find docs -name '*.tgz' | while read -r filename; do
    helm-sign --key "$GPG_KEY_NAME" "$filename"
done
helm repo index docs --url https://siakhooi.github.io/helm-charts
