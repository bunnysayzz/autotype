#!/bin/bash

# Install script for AutoType

# Check if build exists
if [ ! -d "AutoType.app" ]; then
    echo "AutoType app not found. Running build script first..."
    ./build.sh
fi

# Copy to Applications folder
cp -r AutoType.app /Applications/

echo "AutoType has been installed to /Applications/AutoType.app"
echo "Note: You may need to grant accessibility permissions in System Preferences > Security & Privacy > Privacy > Accessibility" 