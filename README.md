# AutoType

AutoType is a simple macOS utility that allows you to automatically type text into any application after a countdown.

<p align="center">
  <img src="resources/icon.png" width="128" height="128" alt="AutoType Icon">
</p>

## Features

- Paste text and have it automatically typed into any application
- Adjustable typing delay (0.01 to 0.2 seconds between keystrokes)
- Option to preserve tab characters for code indentation
- Special "Code Mode" for precise formatting of programming code
- 5-second countdown to switch to your target application
- Status indicator showing typing progress
- Menu bar application for easy access

## Requirements

- macOS 10.13 or later
- Xcode 12 or later (for building from source)

## Installation

### Option 1: Download the pre-built app

1. Download the latest release from the [Releases](https://github.com/bunnysayzz/autotype/releases) page
2. Move AutoType.app to your Applications folder
3. Grant accessibility permissions when prompted

### Option 2: Build from source

1. Clone this repository:
   ```
   git clone https://github.com/bunnysayzz/autotype.git
   cd autotype
   ```

2. Run the build script:
   ```
   chmod +x build.sh
   ./build.sh
   ```

3. Run the install script to copy to Applications:
   ```
   chmod +x install.sh
   ./install.sh
   ```

## Usage

1. Click the keyboard icon in the menu bar to open AutoType
2. Paste your text into the text area
3. Adjust the typing delay if needed (default is 0.05 seconds)
4. Choose whether to preserve tab characters (checked by default)
5. Enable "Code Mode" when typing programming code for precise formatting
6. Click "Start Typing" and quickly switch to your target application
7. After a 5-second countdown, the text will be typed automatically

## Permissions

AutoType requires accessibility permissions to function properly. You'll be prompted to grant these permissions when you first run the app. If you need to grant them manually:

1. Open System Preferences > Security & Privacy > Privacy > Accessibility
2. Click the lock icon to make changes
3. Add AutoType.app to the list of allowed applications

## Troubleshooting

If you encounter any issues with AutoType, please refer to the [TROUBLESHOOTING.md](TROUBLESHOOTING.md) guide for detailed solutions to common problems.

Common issues include:
- Missing accessibility permissions
- Text not being typed correctly
- Special characters not working
- Application not launching

## Development

The application consists of three main Swift files:
- `main.swift`: The entry point for the application
- `AppDelegate.swift`: Handles the menu bar item and popover
- `ContentViewController.swift`: Contains the UI and typing logic

## Version History

- **1.1.0** (2023-03-06): Code Typing Improvements
  - Added "Code Mode" for precise code formatting
  - Enhanced character mapping for programming symbols
  - Fixed issues with missing characters
  - Improved whitespace and indentation handling

- **1.0.0** (2023-03-05): Initial release
  - Basic typing functionality
  - Adjustable typing delay
  - Tab character preservation
  - Progress indicator
  - Accessibility permissions handling

## License

MIT License

Copyright (c) 2023 Md Azharuddin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 