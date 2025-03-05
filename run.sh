#!/bin/bash

# Run script for AutoType

# Check if build exists
if [ ! -d "AutoType.app" ]; then
    echo "AutoType app not found. Running build script first..."
    ./build.sh
fi

# Run the app
echo "Running AutoType..."
open AutoType.app 