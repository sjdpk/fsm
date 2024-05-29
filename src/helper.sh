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
    printf "%b! %s%b\n" "$RED" "$1" "$NC"
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

# @desc: Show a spinner while another command is running
# @param: $1 - command to run (with any parameters)
# @return: void
# @example: spinner sleep 10
function shutdown() {
    tput cnorm # reset cursor
}
trap shutdown EXIT

function cursorBack() {
    local num=$1
    echo -en "\033[${num}D"
}

function spinner() {
    # Make sure we use non-unicode character type locale
    local LC_CTYPE=C

    local pid=$1 # Process ID of the previously running command

    local loadingMsg="$2"
    local successMsg="$3"
    # length of the loading message +1
    local msglength=${#loadingMsg}+1

    # Single spinner style
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local charwidth=3

    local i=0
    tput civis # cursor invisible
    while kill -0 "$pid" 2>/dev/null; do
        local i=$(((i + charwidth) % ${#spin}))
        printf "${BLUE}%s $loadingMsg ${NC}" "${spin:i:charwidth}"
        # Move back spinner characters + " Processing"
        cursorBack $(("$charwidth" + "$msglength"))
        sleep .1
    done
    tput cnorm
    # capture exit code
    wait "$pid"
    local exit_code=$?

    # Clear spinner and show completed message
    printf "${BLUE}%s $loadingMsg${NC} " "${spin:i:charwidth}"
    if [ -n "$successMsg" ]; then
        echo -e "\n${GREEN}✔ $successMsg ${NC}"
    else
        echo ""
    fi

    return $exit_code
}

# @desc: Run a command with a spinner
# @param: $@ - command to run with spinner
# @return: void
# @example: run_with_spinner "Processing..." "Completed with exit code 0" sleep 10
run_with_spinner() {
    local loadingMsg="$1"
    local successMsg="$2"
    shift 2
    ("$@") &
    spinner $! "$loadingMsg" "$successMsg"
}
