# AutoType

AutoType is a simple macOS utility that allows you to automatically type text into any application after a countdown.

<p align="center">
  <img src="resources/icon.png" width="128" height="128" alt="AutoType Icon">
</p>

## Features

- Paste text and have it automatically typed into any application
- Adjustable typing delay (0.01 to 0.2 seconds between keystrokes)
- 5-second countdown to switch to your target application
- Status indicator showing typing progress
- Menu bar application for easy access

## Requirements

- macOS 10.13 or later
- Xcode 12 or later (for building from source)

## Installation

1. Download `AutoType.dmg` from the [latest release](https://github.com/bunnysayzz/autotype/releases/latest)
2. Open the downloaded DMG file
3. Drag AutoType to your Applications folder
4. Open AutoType from Applications

<p align="center">
  <img src="resources/dmg_screenshot.png" width="600" alt="DMG Installation">
</p>

## First Time Setup

When you first open AutoType, macOS will show security prompts. Here's how to handle them:

### Security Warning
If macOS shows "AutoType can't be opened because it is from an unidentified developer":

1. Open System Settings
2. Go to Privacy & Security
3. Scroll down to the "Security" section
4. Click "Open Anyway" next to AutoType
5. Click "Open" in the popup confirmation

<p align="center">
  <img src="resources/security_warning.png" width="500" alt="Security Warning">
</p>

### Accessibility Permission
AutoType needs accessibility permission to simulate keyboard input:

1. When prompted, click "Open System Settings"
2. In Privacy & Security > Accessibility
3. Find AutoType in the list
4. Toggle the switch to allow AutoType

<p align="center">
  <img src="resources/accessibility_permission.png" width="500" alt="Accessibility Permission">
</p>

## Usage

1. Click the AutoType icon in your menu bar
2. Paste or type your text in the window
3. Adjust typing speed using the slider
4. Click "Start Typing" and switch to your target application within 5 seconds
5. AutoType will type out your text automatically

<p align="center">
  <img src="resources/app_screenshot.png" width="400" alt="AutoType Interface">
</p>

## Features

- Type text with customizable speed
- Simple menu bar interface
- Easy to use
- Works in any text input field

## Support

For issues and feature requests, please [open an issue](https://github.com/bunnysayzz/autotype/issues) on GitHub. 