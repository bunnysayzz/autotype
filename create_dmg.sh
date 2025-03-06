#!/bin/bash

# Script to create DMG for AutoType

# Configuration
APP_NAME="AutoType"
DMG_NAME="$APP_NAME-1.0.0"
DMG_VOLUME_NAME="$APP_NAME Installer"
DMG_SIZE="50m"
DMG_TEMP="temp.dmg"
DMG_FINAL="$DMG_NAME.dmg"

# Clean up any previous builds
rm -rf "$DMG_TEMP" "$DMG_FINAL"

# Build the app
echo "Building $APP_NAME..."
./build.sh

# Create a temporary DMG
echo "Creating temporary DMG..."
hdiutil create -srcfolder "$APP_NAME.app" -volname "$DMG_VOLUME_NAME" -fs HFS+ \
      -fsargs "-c c=64,a=16,e=16" -format UDRW -size "$DMG_SIZE" "$DMG_TEMP"

# Mount the temporary DMG
echo "Mounting temporary DMG..."
MOUNT_DIR="/Volumes/$DMG_VOLUME_NAME"
DEV_NAME=$(hdiutil attach -readwrite -noverify -noautoopen "$DMG_TEMP" | egrep '^/dev/' | sed 1q | awk '{print $1}')

# Wait for the mount
sleep 2

# Create Applications symlink
echo "Creating Applications symlink..."
pushd "$MOUNT_DIR" > /dev/null
ln -s /Applications
popd > /dev/null

# Unmount the temporary DMG
echo "Unmounting temporary DMG..."
hdiutil detach "$DEV_NAME"

# Convert the temporary DMG to the final compressed DMG
echo "Creating final DMG..."
hdiutil convert "$DMG_TEMP" -format UDZO -o "$DMG_FINAL"

# Clean up
rm -f "$DMG_TEMP"

echo "DMG created successfully at $DMG_FINAL" 