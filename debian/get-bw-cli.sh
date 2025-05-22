#!/bin/bash
set -e

# Download Bitwarden CLI
BW_URL="https://bitwarden.com/download/?app=cli&platform=linux"
mkdir -p debian/tmp
BW_ZIP="debian/tmp/bw-linux-latest.zip"
BW_BIN="bw"

wget -O "$BW_ZIP" "$BW_URL"
unzip -o "$BW_ZIP" -d debian/tmp
chmod +x debian/tmp/$BW_BIN

# Create destination directory for debian packaging
mkdir -p usr/bin
mv -f debian/tmp/$BW_BIN usr/bin/bw
