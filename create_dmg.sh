#!/bin/bash

# Script to create DMG for AutoType

VERSION=$(grep -A1 "CFBundleShortVersionString" Info.plist | grep string | sed -E 's/.*<string>(.*)<\/string>.*/\1/')
DMG_NAME="AutoType-$VERSION.dmg"
VOLUME_NAME="AutoType $VERSION"
APP_NAME="AutoType.app"
RELEASE_DIR="releases"
DMG_BACKGROUND_IMG="resources/dmg_background.png"

# Create DMG background image with instructions
convert -size 540x400 xc:white \
    -font Arial -pointsize 16 -fill black \
    -draw "text 30,50 'Install AutoType'" \
    -font Arial -pointsize 12 -fill black \
    -draw "text 30,80 '1. Drag AutoType to the Applications folder'" \
    -draw "text 30,100 '2. Open AutoType from Applications'" \
    -draw "text 30,120 '3. If you see a security warning:'" \
    -draw "text 45,140 '   • Open System Settings → Privacy & Security'" \
    -draw "text 45,160 '   • Scroll down and click Open Anyway'" \
    -draw "text 45,180 '   • Click Open in the popup'" \
    -draw "text 30,210 '4. Grant Accessibility permissions when prompted'" \
    -draw "text 30,240 'Enjoy using AutoType!'" \
    "$DMG_BACKGROUND_IMG"

# Ensure the app is built
if [ ! -d "$APP_NAME" ]; then
    echo "Building AutoType..."
    ./build.sh
fi

# Ensure the releases directory exists
mkdir -p "$RELEASE_DIR"

# Create a temporary directory for DMG contents
TMP_DIR=$(mktemp -d)

# Copy the app
cp -r "$APP_NAME" "$TMP_DIR/"

# Create a symbolic link to Applications folder
ln -s /Applications "$TMP_DIR/Applications"

# Create the DMG
echo "Creating DMG..."
create-dmg \
    --volname "$VOLUME_NAME" \
    --volicon "resources/icon.icns" \
    --background "$DMG_BACKGROUND_IMG" \
    --window-pos 200 120 \
    --window-size 540 400 \
    --icon-size 100 \
    --icon "$APP_NAME" 140 180 \
    --icon "Applications" 400 180 \
    --hide-extension "$APP_NAME" \
    --app-drop-link 400 180 \
    "$RELEASE_DIR/$DMG_NAME" \
    "$TMP_DIR"

# Clean up
rm -rf "$TMP_DIR"
rm "$DMG_BACKGROUND_IMG"

echo "DMG created at $RELEASE_DIR/$DMG_NAME" 