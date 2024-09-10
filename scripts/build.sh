#!/bin/bash

GNUPGHOME="$(mktemp -d)"
export GNUPGHOME

echo "$GPG_PRIVATE_KEY" | gpg --import
gpg --list-keys

find docs -name '*.tgz' | while read -r filename; do
    (
        set -x
        helm-sign --key "$GPG_KEY_NAME" "$filename"
    )
done
set -x
helm repo index docs --url https://siakhooi.github.io/helm-charts
