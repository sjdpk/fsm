#!/bin/bash

version='1.0.0'
blueBold="\e[1;34m"
yellowBold='\e[1m\e[33m'
redBold='\e[1m\e[31m'
greenBold='\e[32m\e[1m'
exitColor='\e[0m'
flutterSwitchText='\e[1m\e[33m
  ______ _____ __  __ 
 |  ____/ ____|  \/  |
 | |__ | (___ | \  / |
 |  __| \___ \| |\/| |
 | |    ____) | |  | |
 |_|   |_____/|_|  |_|
\e[0m'

# curret fsm version
fsmInformation() {
    developer="Deepak Sapkota"
    # ANSI escape codes for blue and bold text
    echo -e "$flutterSwitchText"
    echo -e "Current Version : \e[1m$version\e[0m"  # Bold version text
    echo -e "Developer : $blue_bold$developer\e[0m"  # Blue and bold developer text
    echo "Repo : https://github.com/sjdpk/fsm"
    echo ""
}


fsmNotes() {
    developer=" Deepak Sapkota"
    echo -e " Current Version : \e[1m$version\e[0m"  # Bold version text
    echo -e " Developer : $blueBold$developer\e[0m"  # Blue and bold developer text
    echo " Repo : https://github.com/sjdpk/fsm"
    echo 
}

# update fsm
updateFSMVersion() {
  echo -e "$flutterSwitchText"
  rm -rf ~/.fsm
  git clone https://github.com/sjdpk/fsm.git ~/.fsm
  echo "update shell eg: [ source ~/.zshrc, source ~/.bashrc, ...]" 
}

# check version
checkFlutterVersion(){
    flutter --version
}

# list locally installed versions of node
locallyInstalledFlutterVersionsList(){
    blue_bold="\e[1;34m"
    flutterDir=$(dirname $(dirname $(dirname $(which flutter))))
    for dir in "$flutterDir"/flutter*/; do
        if [ -d "$dir" ]; then
            cd "$dir" || exit
            flutter_version=$("${dir}bin/flutter" --version | grep -oE "Flutter [0-9]+\.[0-9]+\.[0-9]+")
            echo -e " 👉  $blue_bold$flutter_version\e[0m"
        fi
    done
}

# version switch
flutterSDKVersionSwitch(){
    newFlutterVersion="$1"
    newFlutterName="flutter-$newFlutterVersion"

    currentDir=$(pwd) # store current directory
    
    inUseFlutterVersion=$(flutter --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" | head -n 1)

    if [ "$newFlutterVersion" = "$inUseFlutterVersion" ]; then
        echo -e "$redBold You are already using Flutter version $inUseFlutterVersion $exitColor"
    else 
        declare -a availableFlutterVersionsList
        flutterDir=$(dirname $(dirname $(dirname $(which flutter))))
        for dir in "$flutterDir"/flutter*/; do
            if [ -d "$dir" ]; then
                cd "$dir" || exit
                flutter_version=$("${dir}bin/flutter" --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" | head -n 1)
                flutterVersions+=("$flutter_version") # Append the version to the array
            fi
        done
        # Check if the array contains a specific version
        if [[ " ${flutterVersions[@]} " =~ " $newFlutterVersion " ]]; then
            cd "$flutterDir"
            sudo mv "flutter" "flutter-$inUseFlutterVersion"
            sudo mv "$newFlutterName" "flutter"
            echo -ne " 🫴 $greenBold Switching Progress: $exitColor"
            for ((i=1; i<=10; i++)); do
                echo -e -n "$greenBold=$exitColor"
                sleep 0.1
            done
            echo -e " $greenBold100%$exitColor"
            echo
            echo -e "🎊 🎊$greenBold Switched Flutter from Flutter $inUseFlutterVersion to Flutter $newFlutterVersion $exitColor🎊 🎊"
            echo
        else
            echo -e "$redBold Flutter version $newFlutterVersion is not available\e[0m"
            yellow_bold="\e[1m\e[33m"
            echo -e "$yellowBold Available versions: $exitColor"
            locallyInstalledFlutterVersionsList # list all available versions
        fi
    fi 
    cd "$currentDir"
}

# help function
displayHelp() {
    echo
    fsmNotes
    echo
    echo -e "$yellowBold Useful FSM commands $exitColor"
    echo -e " Usage: fsm [OPTIONS]"
    echo -e "\n Options:"
    echo -e "   -v, --version    Display the version of the flutter"
    echo -e "   ls, --list       List locally installed Flutter versions"
    echo -e "   info             Display information about the current script version"
    echo -e "   update           Update the FSM version"
    echo -e "   use <version>    Switch to a specific Flutter version"
    echo -e "   help             Display this help information"
    echo -e "\n Examples:"
    echo -e "   fsm -v"
    echo -e "   fsm ls"
    echo -e "   fsm info"
    echo -e "   fsm update"
    echo -e "   fsm use 3.3.3"
}

opt=$1
case $opt
in
    -v|--version) checkFlutterVersion ;;
    ls|--list) locallyInstalledFlutterVersionsList ;;
    info) fsmInformation ;;
    update) updateFSMVersion ;;
    use) version_to_use=$2
        if [ -n "$version_to_use" ]; then
            flutterSDKVersionSwitch "$version_to_use"
        else
            echo -e "$redBold Please provide a version number after 'use' option.$exitColor"
        fi
        ;;
    help|*) displayHelp
       exit ;;
esac