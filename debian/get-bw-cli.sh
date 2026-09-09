#!/bin/bash
set -e

# Download Bitwarden CLI.
#
# bitwarden.com/download only ever serves the amd64 build, so fetch
# directly from the upstream GitHub releases instead - those publish a
# per-architecture zip (bw-linux-<version>.zip / bw-linux-arm64-<version>.zip)
# for every "cli-v*" tag.
DEB_ARCH="$(dpkg --print-architecture)"
case "$DEB_ARCH" in
    amd64) ASSET_SUFFIX="" ;;
    arm64) ASSET_SUFFIX="-arm64" ;;
    *)
        echo "get-bw-cli.sh: no upstream Bitwarden CLI build for architecture '$DEB_ARCH'" >&2
        exit 1
        ;;
esac

RELEASES_URL="https://api.github.com/repos/bitwarden/clients/releases"
CLI_TAG="$(curl -fsSL "$RELEASES_URL" | grep -m1 -o '"tag_name": *"cli-v[^"]*"' | sed -E 's/.*"cli-v([^"]+)"/\1/')"
if [ -z "$CLI_TAG" ]; then
    echo "get-bw-cli.sh: could not determine latest Bitwarden CLI release tag" >&2
    exit 1
fi

BW_ASSET="bw-linux${ASSET_SUFFIX}-${CLI_TAG}.zip"
BW_URL="https://github.com/bitwarden/clients/releases/download/cli-v${CLI_TAG}/${BW_ASSET}"
BW_BIN="bw"

mkdir -p debian/tmp
BW_ZIP="debian/tmp/${BW_ASSET}"

wget -O "$BW_ZIP" "$BW_URL"
unzip -o "$BW_ZIP" -d debian/tmp
chmod +x "debian/tmp/$BW_BIN"

# Create destination directory for debian packaging
mkdir -p usr/bin
mv -f "debian/tmp/$BW_BIN" usr/bin/bw
