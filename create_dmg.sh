#!/bin/bash

# Script to create DMG for AutoType

VERSION=$(grep -A1 "CFBundleShortVersionString" Info.plist | grep string | sed -E 's/.*<string>(.*)<\/string>.*/\1/')
DMG_NAME="AutoType-$VERSION.dmg"
VOLUME_NAME="AutoType $VERSION"
APP_NAME="AutoType.app"
RELEASE_DIR="releases"

# Ensure the app is built
if [ ! -d "$APP_NAME" ]; then
    echo "Building AutoType..."
    ./build.sh
fi

# Create releases directory if it doesn't exist
mkdir -p "$RELEASE_DIR"

# Create a temporary directory for DMG contents
TMP_DIR=$(mktemp -d)
cp -r "$APP_NAME" "$TMP_DIR/"

# Create DMG
echo "Creating DMG..."
hdiutil create -volname "$VOLUME_NAME" -srcfolder "$TMP_DIR" -ov -format UDZO "$RELEASE_DIR/$DMG_NAME"

# Clean up
rm -rf "$TMP_DIR"

echo "DMG created at $RELEASE_DIR/$DMG_NAME" 