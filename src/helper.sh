#!/bin/bash
# Define the base directory
BASE_DIR=$(dirname "$0")
if [ -f "$BASE_DIR/src/constants.sh" ]; then
    source "$BASE_DIR/src/constants.sh"
else
    echo "Error: src/constants.sh not found."
    exit 1
fi

# @desc: Log error message
# @param: $1 - message
# @return: void
# @example: logError "Error message"

logError() {
    printf "%bError : %s%b\n" "$RED" "$1" "$NC"
}

# @desc : Check if the current directory is a Flutter project
# @return : void
# @example : is_flutter_project

is_flutter_project() {
    if [ -f "pubspec.yaml" ]; then
        return 0
    else
        logError "This is not a Flutter project."
        exit 1
    fi
}

# @desc : Confirm the command
# @param : $1 - key
# @return : void
# @example : confirm_command "yes"

confirm_command() {
    key="$1"
    if [[ "$key" == "yes" || "$key" == "y" || "$key" == "Y" || "$key" == "YES" ]]; then
        return 0
    else
        echo "Command cancelled..."
        return 1
    fi
}
