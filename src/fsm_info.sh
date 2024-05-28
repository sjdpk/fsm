#!/bin/bash

# Source function files
if [ -f "$BASE_DIR/src/constants.sh" ]; then
    source "$BASE_DIR/src/constants.sh"
else
    echo "Error: src/constants.sh not found."
    exit 1
fi

# @desc : Display fsm version information
# @return : void
# @example : fsmInformation

fsmInformation() {
    printf "%b%s%b" "$BLUE" "$PACKAGE_INFO" "$NC"
    echo ""
    printf "Version : %s%b\n" "$VERSION" "$NC"
    printf "Developer : %b%s%b\n" "$BLUE" "$DEVELOPER_NAME" "$NC"
    printf "Repo : %s\n" "$GITHUB_REPO"
    echo ""
}

# @desc : Display fsm help information
# @return : void
# @example : fsmHelp

fsmHelp() {
    printf "%b%s :%b %s\n" "$YELLOW" "$PACKAGE_NAME" "$NC" "$DESC"
    echo ""
    echo "Usage: fsm [options]"
    echo "Options:"
    echo "  version, -v         Display fsm version information"
    echo "  doctor, -d          Check Flutter version"
    echo "  list, -ls           List locally installed Flutter versions"
    echo "  update              Update fsm version"
    echo "  flutter-upgrade     Upgrade Flutter to latest SDK"
    echo "  use <version>       Switch to a specific Flutter SDK version"
    echo "  install <version>   Install a specific Flutter SDK version"
    echo "  remove <version>    Remove a specific Flutter SDK version"
    echo "  create <name>       Create a new Flutter project"
    echo "  feature <name>      Create a new feature folder"
    echo "  help                Display this help message"
    echo ""
}
