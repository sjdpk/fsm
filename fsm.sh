#!/bin/bash

# Source function files
# Define the base directory
BASE_DIR=$(dirname "$0")

# Source function files
if [ -f "$BASE_DIR/src/constants.sh" ]; then
    source "$BASE_DIR/src/constants.sh"
else
    echo "Error: src/constants.sh not found."
    exit 1
fi

if [ -f "$BASE_DIR/src/helper.sh" ]; then
    source "$BASE_DIR/src/helper.sh"
else
    echo "Error: src/helper.sh not found."
    exit 1
fi

if [ -f "$BASE_DIR/src/fsm_info.sh" ]; then
    source "$BASE_DIR/src/fsm_info.sh"
else
    echo "Error: src/fsm_info.sh not found."
    exit 1
fi

if [ -f "$BASE_DIR/src/scripts.sh" ]; then
    source "$BASE_DIR/src/scripts.sh"
else
    echo "Error: src/scripts.sh not found."
    exit 1
fi

if [ -f "$BASE_DIR/src/dart/clean_arch_script.sh" ]; then
    source "$BASE_DIR/src/dart/clean_arch_script.sh"
else
    echo "Error: src/dart/clean_arch_script.sh not found."
    exit 1
fi

# Main function
opt=$1
case $opt in
-h | help | h) fsmHelp ;;
-v | version | v) fsmInformation ;;
-d | doctor | d) checkFlutterVersion ;;
-ls | list | ls ) locallyInstalledFlutterVersionsList ;;
update) updateFSMVersion ;;
use)
    version_to_use=$2
    if [ -n "$version_to_use" ]; then
        flutterSDKVersionSwitch "$version_to_use"
    else
        logError "Please provide a version number after 'use' option."
    fi
    ;;
install)
    version_to_install=$2
    if [ -n "$version_to_install" ]; then
        downloadFlutterVersion "$version_to_install"
    else
        logError "Please provide a version number after 'install' option."
    fi
    ;;
-r | remove)
    version_to_remove=$2
    if [ -n "$version_to_remove" ]; then
        removeFlutterVersion "$version_to_remove"
    else
        logError "Please provide a version number after 'remove' option."
    fi
    ;;
flutter-upgrade) upgradeFlutterSDK ;;
create)
    applicationName=$2
    if [ -n "$applicationName" ]; then
        createFlutterProject "$applicationName"
    else
        logError "Please provide a application name after 'create' option."
    fi
    ;;

feature)
    featureToCreate=$2
    if [ -n "$featureToCreate" ]; then
        createFeatureFoldersStr "$featureToCreate"
    else
        logError "Please provide a Feature Name after 'feature' option."
    fi
    ;;
*)
    fsmHelp
    exit
    ;;
esac
