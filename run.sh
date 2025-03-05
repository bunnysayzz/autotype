#!/bin/bash

# Run script for AutoType

# Check if build exists
if [ ! -d "AutoType.app" ]; then
    echo "AutoType app not found. Running build script first..."
    ./build.sh
fi

# Remind about accessibility permissions
echo "Note: AutoType requires accessibility permissions to function properly."
echo "If this is your first time running the app, you will be prompted to grant these permissions."
echo "You can also grant them manually in System Preferences > Security & Privacy > Privacy > Accessibility"

# Run the app
echo "Running AutoType..."
open AutoType.app 