#!/bin/bash

# Script to create DMG for AutoType

VERSION=$(grep -A1 "CFBundleShortVersionString" Info.plist | grep string | sed -E 's/.*<string>(.*)<\/string>.*/\1/')
DMG_NAME="AutoType-$VERSION.dmg"
VOLUME_NAME="AutoType"
APP_NAME="AutoType.app"
RELEASE_DIR="releases"

# Ensure the app is built
if [ ! -d "$APP_NAME" ]; then
    echo "Building AutoType..."
    ./build.sh
fi

# Ensure the releases directory exists
mkdir -p "$RELEASE_DIR"

# Remove any existing DMG
rm -f "$RELEASE_DIR/$DMG_NAME"

# Create a temporary directory for DMG contents
TMP_DIR=$(mktemp -d)

# Copy the app
cp -r "$APP_NAME" "$TMP_DIR/"

# Create the DMG
echo "Creating DMG..."
create-dmg \
    --volname "$VOLUME_NAME" \
    --window-pos 200 120 \
    --window-size 600 400 \
    --icon-size 128 \
    --icon "$APP_NAME" 160 190 \
    --app-drop-link 440 190 \
    --no-internet-enable \
    --format UDZO \
    "$RELEASE_DIR/$DMG_NAME" \
    "$TMP_DIR"

# Clean up
rm -rf "$TMP_DIR"

echo "DMG created at $RELEASE_DIR/$DMG_NAME" 