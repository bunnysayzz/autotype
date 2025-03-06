# Changelog

All notable changes to AutoType will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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