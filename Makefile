build:
	GPG_KEY_NAME=siakhooi-helm GPG_PRIVATE_KEY=$$(cat keys/siakhooi-helm.gpg.private.asc) scripts/build.sh

generate-key:
	scripts/gpg-generate-key.sh
