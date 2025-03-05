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

# Sign the app if codesign is available
if command -v codesign &> /dev/null; then
    echo "Signing the application..."
    codesign --force --deep --entitlements AutoType.entitlements --sign - AutoType.app
    
    # Verify the signing
    echo "Verifying signature..."
    codesign --verify --verbose AutoType.app
fi

echo "Build completed. App bundle is at AutoType.app"
echo "Note: You may need to grant accessibility permissions in System Preferences > Security & Privacy > Privacy > Accessibility" 