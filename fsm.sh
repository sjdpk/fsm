#!/bin/bash

# Source function files
# source 'src/constants.sh'
source 'src/helper.sh'
source 'src/fsm_info.sh'
source 'src/scripts.sh'
source 'src/flutter/clean_arch_script.sh'


# Main function
opt=$1
case $opt in
    -h|help) fsmHelp ;;
    -v|version) fsmInformation ;;
    -d|doctor) checkFlutterVersion ;;
    -ls|list) locallyInstalledFlutterVersionsList ;;
    update) updateFSMVersion ;;
    use) version_to_use=$2
        if [ -n "$version_to_use" ]; then
            flutterSDKVersionSwitch "$version_to_use"
        else
            logError "Please provide a version number after 'use' option."
        fi
        ;;
    install) version_to_install=$2
        if [ -n "$version_to_install" ]; then
            downloadFlutterVersion "$version_to_install"
        else
            logError "Please provide a version number after 'install' option."
        fi
        ;;
    upgradeFlutterSDK) upgradeFlutterSDK ;;
    create) applicationName=$2 
        if [ -n "$applicationName" ]; then
            createFlutterProject "$applicationName"
        else
            logError "Please provide a application name after 'create' option."
        fi
        ;;
    
    feature) featureToCreate=$2
        if [ -n "$featureToCreate" ]; then
            createFeatureFoldersStr "$featureToCreate"
        else
            logError "Please provide a Feature Name after 'feature' option."
        fi
        ;;
    *) fsmHelp
       exit ;;
esac