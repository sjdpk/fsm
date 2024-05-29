#!/bin/bash

# Source function files
if [ -f "$BASE_DIR/src/constants.sh" ]; then
    source "$BASE_DIR/src/constants.sh"
else
    echo "Error: src/constants.sh not found."
    exit 1
fi

# @desc : show flutter version
# @return : flutter version
# @example : checkFlutterVersion

checkFlutterVersion() {
    run_with_spinner "Checking Flutter version..." "Flutter version details:" printf ""
    flutter --version
}

# @desc : list locally installed flutter versions
# @return : list of locally installed flutter versions
# @example : locallyInstalledFlutterVersionsList

locallyInstalledFlutterVersionsList() {
    # Get the Flutter root directory
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)

    # Get branch list
    branch_list=$(git -C "$flutter_root" branch)
    run_with_spinner "Fetching locally installed flutter versions..." "Available versions are: " printf ""
    # Print the branch list
    printf "%s\n" "$branch_list"

}

# @desc : update fsm version
# @return : new fsm version
# @example : updateFSMVersion

updateFSMVersion() {
    command="rm -rf ~/.fsm && git clone https://github.com/sjdpk/fsm.git ~/.fsm >/dev/null 2>&1"
    run_with_spinner "Updating fsm..." "fsm updated successfully" eval "$command"
    printf "%b! %s%b\n" "$YELLOW" "Update shell eg: [ source ~/.zshrc, source ~/.bashrc, ...]" "$NC"
}

# @desc : switch flutter sdk version
# @param : $1 - version_to_use
# @return : set flutter sdk version as default
# @example : flutterSDKVersionSwitch "stable"

flutterSDKVersionSwitch() {
    version_to_use=$1
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)

    command="git -C '$flutter_root' checkout '$version_to_use' >/dev/null 2>&1"
    run_with_spinner "Switching to version $version_to_use..." "Switched to Flutter $version_to_use " eval "$command"
}

# @desc : check if branch is present
# @param : $1 - branch_to_check
# @return : 0 if branch is not present
# @example : isBranchPresent "stable"

isBranchPresent() {
    branch_to_check=$1
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)
    run_with_spinner "Checking Flutter version $branch_to_check" "" printf ""
    check=$(git -C "$flutter_root" branch | grep "$branch_to_check")
    if [ -z "$check" ]; then
        return 0
    else
        logError "Flutter version $branch_to_check is already present in your local system."
        printf "%bHINT: Please switch version%b\n" "$YELLOW" "$NC"
        exit 1
    fi

}

# @desc : download flutter version
# @param : $1 - version_to_install
# @return : download flutter version
# @example : downloadFlutterVersion "stable"
downloadFlutterVersion() {
    version_to_install=$1
    isBranchPresent "$version_to_install"
    current_branch=$(git -C "$flutter_root" branch --show-current)
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)
    command="git -C '$flutter_root' checkout stable >/dev/null 2>&1 && git -C '$flutter_root' checkout -b '$version_to_install' '$version_to_install' >/dev/null 2>&1 && flutter --version >/dev/null 2>&1"
    run_with_spinner "Downloading flutter version $version_to_install" "Flutter $version_to_install installed successfully" eval "$command"
    git -C "$flutter_root" checkout "$current_branch" >/dev/null 2>&1
    printf "%bHINT: Please switch version%b\n" "$YELLOW" "$NC"
}

# @desc : remove flutter version
# @param : $1 - version_to_remove
# @return : remove flutter version
# @example : removeFlutterVersion "stable"
removeFlutterVersion() {
    version_to_remove=$1
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)
    check=$(git -C "$flutter_root" branch | grep "$version_to_remove")
    run_with_spinner "Checking Flutter version $version_to_remove" "" printf ""
    # Check if the version exists
    if [ -z "$check" ]; then
        logError "Flutter version $version_to_remove is not present in your local system."
        exit 1
    else
        # Check if the version to remove is the currently active branch
        current_branch=$(git -C "$flutter_root" branch --show-current)
        if [ "$current_branch" == "$version_to_remove" ]; then
            logError "You are currently using this version. Please switch to another version."
            exit 1
        fi

        # Remove the specified version
        command="git -C $flutter_root checkout stable >/dev/null 2>&1 && git -C '$flutter_root' branch -D '$version_to_remove' >/dev/null 2>&1"
        run_with_spinner "Removing Flutter version $version_to_remove" "Flutter $version_to_remove removed successfully" eval "$command"
    fi
}

# @desc : upgrade flutter sdk
# @return : upgrade flutter sdk
# @example : upgradeFlutterSDK

upgradeFlutterSDK() {
    flutter upgrade --force
}
