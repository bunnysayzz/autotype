#!/bin/bash

# Build script for AutoType

echo "Building AutoType..."

# Create app bundle structure
mkdir -p AutoType.app/Contents/{MacOS,Resources}

# Compile Swift files with required frameworks
swiftc -o AutoType.app/Contents/MacOS/AutoType \
    src/main.swift \
    src/AppDelegate.swift \
    src/ContentViewController.swift \
    -framework Cocoa \
    -framework Carbon \
    -framework ApplicationServices

# Make executable
chmod +x AutoType.app/Contents/MacOS/AutoType

# Copy Info.plist and entitlements
cp Info.plist AutoType.app/Contents/
cp AutoType.entitlements AutoType.app/Contents/

# Create PkgInfo
echo "APPL????" > AutoType.app/Contents/PkgInfo

# Copy resources
cp -r resources/* AutoType.app/Contents/Resources/

# Sign the app with hardened runtime
echo "Signing the application..."
codesign --force --deep --options runtime \
    --entitlements AutoType.entitlements \
    --sign - \
    AutoType.app

# Verify the signing
echo "Verifying signature..."
codesign --verify --verbose=4 AutoType.app

echo "Build completed. App bundle is at AutoType.app" 