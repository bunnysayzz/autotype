#!/bin/bash

# Release script for AutoType

VERSION=$(grep -A1 "CFBundleShortVersionString" Info.plist | grep string | sed -E 's/.*<string>(.*)<\/string>.*/\1/')
RELEASE_DIR="releases"
RELEASE_NAME="AutoType-$VERSION"
RELEASE_ZIP="$RELEASE_NAME.zip"

echo "Preparing release for AutoType version $VERSION..."

# Clean any previous build
echo "Cleaning previous build..."
rm -rf AutoType.app

# Build the app
echo "Building application..."
./build.sh

# Create releases directory if it doesn't exist
mkdir -p "$RELEASE_DIR"

# Create a clean zip archive
echo "Creating release archive..."
cd AutoType.app
zip -r "../$RELEASE_DIR/$RELEASE_ZIP" .
cd ..

echo "Release archive created at $RELEASE_DIR/$RELEASE_ZIP"
echo ""
echo "To create a GitHub release:"
echo "1. Go to https://github.com/mdazharuddin/autotype/releases/new"
echo "2. Set the tag to v$VERSION"
echo "3. Set the title to 'AutoType $VERSION'"
echo "4. Add release notes from CHANGELOG.md"
echo "5. Upload the zip file from $RELEASE_DIR/$RELEASE_ZIP"
echo "6. Click 'Publish release'"
echo ""
echo "Done!"

chmod +x release.sh 