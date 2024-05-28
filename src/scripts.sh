#!/bin/bash

# Source function files
source 'src/constants.sh'

# @desc : show flutter version
# @return : flutter version
# @example : checkFlutterVersion

checkFlutterVersion() {
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

    # Print the branch list
    printf "%s\n" "$branch_list"

}

# @desc : update fsm version
# @return : new fsm version
# @example : updateFSMVersion

updateFSMVersion() {
    printf "%b%s%b\n" "$BLUE" "Updating fsm..." "$NC"
    rm -rf ~/.fsm
    git clone https://github.com/sjdpk/fsm.git ~/.fsm
    printf "%b%s%b\n" "$RED" "Update shell eg: [ source ~/.zshrc, source ~/.bashrc, ...]" "$NC"
}

# @desc : switch flutter sdk version
# @param : $1 - version_to_use
# @return : set flutter sdk version as default
# @example : flutterSDKVersionSwitch "stable"

flutterSDKVersionSwitch() {
    version_to_use=$1
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)
    printf "%bSwitching Progress... %b\n" "$GREEN" "$NC"

    # Suppress output from git checkout
    git -C "$flutter_root" checkout "$version_to_use" >/dev/null 2>&1
    printf "%b%s%b\n" "$YELLOW" "Switched to Flutter $version_to_use" "$NC"
}

# @desc : check if branch is present
# @param : $1 - branch_to_check
# @return : 0 if branch is not present
# @example : isBranchPresent "stable"

isBranchPresent() {
    branch_to_check=$1
    flutter_root=$(cd "$(dirname "$(which flutter)")/.." && pwd)
    check=$(git -C "$flutter_root" branch | grep "$branch_to_check")
    if [ -z "$check" ]; then
        return 0
    else
        printf "%bFlutter version %s present in your local system.%b\n" "$BLUE" "$branch_to_check" "$NC"
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
    printf "%bDownloading flutter version %s %b\n" "$GREEN" "$version_to_install" "$NC"
    git -C "$flutter_root" checkout stable >/dev/null 2>&1
    git -C "$flutter_root" checkout -b "$version_to_install" "$version_to_install" >/dev/null 2>&1
    flutter --version
    git -C "$flutter_root" checkout "$current_branch" >/dev/null 2>&1
    printf "%b%s%b\n" "$GREEN" "Flutter $version_to_install installed successfully" "$NC"
    printf "%bHINT: Please switch version%b\n" "$YELLOW" "$NC"
}


# @desc : upgrade flutter sdk
# @return : upgrade flutter sdk
# @example : upgradeFlutterSDK

upgradeFlutterSDK() {
    flutter upgrade --force
}