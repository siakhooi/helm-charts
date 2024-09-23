#!/bin/bash

readonly GPG_KEY_NAME=siakhooi-helm
readonly GPG_KEY_BATCH=./scripts/gpg.batch
readonly GPG_KEY_DIRECTORY=./keys

working_directory=$(mktemp -d)
export GNUPGHOME="$working_directory"
readonly GNUPGHOME

GPG_PUBLIC_KEY_ASC=${GPG_KEY_DIRECTORY}/${GPG_KEY_NAME}.gpg.public.asc
GPG_PUBLIC_KEY_BIN=${GPG_KEY_DIRECTORY}/${GPG_KEY_NAME}.gpg.public.key
GPG_PRIVATE_KEY_ASC=${GPG_KEY_DIRECTORY}/${GPG_KEY_NAME}.gpg.private.asc
GPG_PRIVATE_KEY_BIN=${GPG_KEY_DIRECTORY}/${GPG_KEY_NAME}.gpg.private.key

mkdir -p -v $GPG_KEY_DIRECTORY
(
    set -x
    gpg --no-tty --batch --gen-key "$GPG_KEY_BATCH"
    gpg --armor --export "${GPG_KEY_NAME}" >"$GPG_PUBLIC_KEY_ASC"
    gpg --export "${GPG_KEY_NAME}" >"$GPG_PUBLIC_KEY_BIN"
    gpg --armor --export-secret-keys "${GPG_KEY_NAME}" >"$GPG_PRIVATE_KEY_ASC"
    gpg --export-secret-keys "${GPG_KEY_NAME}" >"$GPG_PRIVATE_KEY_BIN"
)

gh secret set GPG_KEY_NAME --body "$GPG_KEY_NAME"
gh secret set GPG_PRIVATE_KEY < "$GPG_PRIVATE_KEY_ASC"
cp -v -f "$GPG_PUBLIC_KEY_BIN" docs/${GPG_KEY_NAME}.gpg
