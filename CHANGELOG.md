# Changelog

All notable changes to AutoType will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.6] - 2023-03-10

### Fixed
- Increased minimum typing delay from 0.001 to 0.010 seconds to prevent text overlapping
- Improved typing reliability to ensure all characters are typed correctly

## [1.0.5] - 2023-03-09

### Fixed
- Improved line handling to exactly match Python's approach for better code formatting
- Fixed issue with unnecessary tabs and spaces in typed code
- Enhanced empty line handling for better code structure
- Optimized typing behavior to let code editors handle indentation automatically

## [1.0.4] - 2023-03-08

### Changed
- Improved line handling to press Enter after each line, similar to Python's pyautogui approach
- Enhanced typing behavior to let the target application handle formatting automatically
- Simplified typing logic for better compatibility with code editors and IDEs

## [1.0.3] - 2023-03-07

### Changed
- Removed "Preserve Tab Characters" checkbox for simplified user experience
- Improved tab handling to always remove tabs for better compatibility with code editors
- Streamlined UI by removing unnecessary options

## [1.0.2] - 2023-03-06

### Fixed
- Fixed critical issue with the letter 'a' not being typed correctly
- Added special handling for problematic characters
- Improved key event handling with additional delays
- Enhanced debugging output for troubleshooting

## [1.0.1] - 2023-03-06

### Changed
- Improved typing reliability for code and complex text
- Added small delay between key down and key up events to ensure characters are typed correctly
- Changed default "Preserve Tab Characters" setting to unchecked for better code typing
- Reduced default typing delay to 0.01 seconds for faster typing
- Updated typing mechanism to better handle code indentation
- Improved documentation for typing code

### Fixed
- Fixed issue with missing characters during typing
- Fixed issue with extra tabs in code
- Fixed issue with incorrect indentation

## [1.0.0] - 2023-03-05

### Added
- Initial release of AutoType
- Menu bar application with popover interface
- Text input area with scrolling support
- Adjustable typing delay (0.01 to 0.2 seconds)
- Option to preserve tab characters
- 5-second countdown before typing begins
- Progress indicator showing typing status
- Accessibility permissions checking and prompting
- Comprehensive key mapping for standard characters
- Support for special characters and modifiers
- Detailed troubleshooting guide
- Build, run, and install scripts
- Documentation and README 