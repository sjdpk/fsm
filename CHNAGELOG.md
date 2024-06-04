# Changelog

## [1.1.0] - june 4, 2024

### Feat
- Add feature create with content [follow clean arch]

## [1.0.1] - may 28, 2024

### Feat
- Refactored folder structure to optimize organization and maintainability.
- Optimized code for better performance and readability.
- Helper function `confirm_command` to standardize user input validation.
- Improved readability and maintainability of the script by centralizing confirmation logic.

### Fixed
- Ensured compatibility with ShellCheck by:
  - Adding `-r` option to `read` commands to properly handle backslashes in input.
  - Using double quotes around variables to handle spaces and special characters correctly.
  - Using `mkdir -p` to avoid errors if the directory already exists.
  - Added `|| exit` to the `cd` command to prevent script continuation if `cd` fails.
  - Corrected the `echo` command to include `-e` for enabling escape sequences.


## [1.0.0] - Jan 16, 2024

### Added
- Initial release of the fsm.
- Features 
    - Display Flutter Version
    - Locally Installed Versions
    - Switch FLutter SDK version
    - so on [more](https://github.com/sjdpk/fsm/releases/tag/v_1.0.0)
