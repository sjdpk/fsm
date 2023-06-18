#!/bin/bash

flutterSwitchText='\e[1m\e[33m
  ______ _____ __  __ 
 |  ____/ ____|  \/  |
 | |__ | (___ | \  / |
 |  __| \___ \| |\/| |
 | |    ____) | |  | |
 |_|   |_____/|_|  |_|
\e[0m'

# 2. download sdk and unzip 

# @desc : file sdk manager (management tool)
# @date : 2023-june-18
# @developer : sjdpk
fsm() {
  if [[ $1 == "--list" ]]; then
    versionList
  elif [[ $1 == "--help" ]]; then
    help
  elif [[ $1 == "--now" ]]; then
    fsmNow
  elif [[ $1 == "-switch" ]]; then
    if [ -n "$2" ]; then
      versionSwitch "$2"
    fi
  else
    help
  fi
}

# @desc : version switch
# @usage :  fsm -switch <version>
versionSwitch(){
  newVersion="$1"
  newName="flutter-$newVersion"
  flutterVersion=$(flutter --version | awk '/Flutter/ {print $2}')
  currentDir=$(pwd)
  flutterDir=$(dirname $(dirname $(dirname $(which flutter))))
  oldName="flutter-$flutterVersion"

 if [ "$oldName" = "$newName" ]; then
      echo -e "\e[1m\e[34m You are already using Flutter version $oldName\e[0m"
  else
      # availableVersions=($(ls "$flutterDir" | grep -oP "(?<=flutter-).+"))
      availableVersions=($(ls "$flutterDir" | sed -n 's/flutter-\(.*\)/\1/p'))
      versionMatch=0
      for version in "${availableVersions[@]}"; do
      if [ "$version" = "$newVersion" ]; then
          versionMatch=1
          break
      fi
      done

     if [ "$versionMatch" -eq 0 ]; then
      echo -e "\e[1m\e[31m Flutter version $newName is not available\e[0m"
      versionList
      else
      cd "$flutterDir"
      sudo mv "flutter" "$oldName"
      sudo mv "$newName" "flutter"
      echo -e "$flutterSwitchText"
      echo -ne "\e[1m\e[34m Switching Progress: \e[0m"
      for ((i=1; i<=10; i++)); do
          echo -n "="
          sleep 0.1
      done
      echo -e " 100%"
      echo -e "\e[1m\e[32m Switched Flutter from '$oldName' to '$newName'. \e[0m"
      cd "$currentDir"
      fi
  fi
}

# @desc: Function to get available Flutter versions
# @usage :  fsm --list
versionList() {
  echo -e "$flutterSwitchText"
  versions=()
  flutterDir=$(dirname $(dirname $(dirname $(which flutter))))
  for dir in "$flutterDir"/flutter*/; do
      if [[ -x "${dir}bin/flutter" ]]; then
      flutterVersion=$("${dir}bin/flutter" --version | awk '/Flutter/ {print $2}')
      versions+=("'$flutterVersion'")
      fi
  done

 # Join the versions with commas
  joined_versions=$(IFS=,; echo "${versions[*]}")

 # Output the versions with color formatting
  echo -e "\e[1m\e[34m Available versions are:\e[0m \e[32m[$joined_versions]\e[0m"
}

# @desc: help function
# @usage :  fsm --help
help() {
  echo -e "$flutterSwitchText"
  echo "--help : for fsm help"
  echo "--now : current flutter version"
  echo "--list : for list all available versions"
  echo "-switch <version> : switch flutter sdk version"
}

# @desc: show current flutter version
# @usage :  fsm --now
fsmNow() {
  echo -e "$flutterSwitchText"
  flutter --version
}