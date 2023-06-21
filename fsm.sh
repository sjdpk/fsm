#!/bin/bash

version='1.0.0'
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
  elif [[ $1 == "--version" ]]; then
    fsmVersion
  elif [[ $1 == "--update" ]]; then
    fsmUpdate
  elif [[ $1 == "--now" ]]; then
    fsmNow
  elif [[ $1 == "--download" ]]; then
    if [ -n "$2" ]; then
      downloadFlutter "$2"
    fi
  elif [[ $1 == "-switch" ]]; then
    if [ -n "$2" ]; then
      versionSwitch "$2"
    fi
  else
    help
  fi
}

# @desc: show current fsm version
# @usage :  fsm --version
fsmVersion() {
  echo -e "$flutterSwitchText"
  echo "fsm @$version"
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
      echo -e "$flutterSwitchText"
      cd "$flutterDir"
      sudo mv "flutter" "$oldName"
      sudo mv "$newName" "flutter"
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

downloadFlutter(){
  newVersion="$1"
  newName="flutter-$newVersion"
  flutterVersion=$(flutter --version | awk '/Flutter/ {print $2}')
  currentDir=$(pwd)
  flutterDir=$(dirname $(dirname $(dirname $(which flutter))))
  oldName="flutter-$flutterVersion"

 if [ "$oldName" = "$newName" ]; then
      echo -e "\e[1m\e[34m You are already using Flutter version $oldName\e[0m"
  else
      availableVersions=($(ls "$flutterDir" | sed -n 's/flutter-\(.*\)/\1/p'))
      versionMatch=0
      for version in "${availableVersions[@]}"; do
      if [ "$version" = "$newVersion" ]; then
          versionMatch=1
          break
      fi
      done
    if [ "$versionMatch" -eq 0 ]; then
      #TODO: Download Logic
      echo -e "\e[1m\e[31m Flutter version $newName is Download Started\e[0m"
      echo -e "$flutterSwitchText"
      cd "$flutterDir"
      os=$(uname -s)
      if [os == "Darwin"]; then
           curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$newVersion-stable.zip
           sudo mv "flutter" "$oldName"
           unzip flutter_macos_$newVersion-stable.zip
      elif [os == "Linux"]; then
           curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$newVersion-stable.zip
           sudo mv "flutter" "$oldName"
           unzip flutter_linux_$newVersion-stable.zip
      fi
      sudo mv "flutter" "$oldName"
      unzip flutter_macos_3.10.1-stable.zip
      echo -ne "\e[1m\e[34m Switching Progress: \e[0m"
      for ((i=1; i<=10; i++)); do
          echo -n "="
          sleep 0.1
      done
      echo -e " 100%"
      echo -e "\e[1m\e[32m Switched Flutter from '$oldName' to '$newName'. \e[0m"
      cd "$currentDir"
 
      else
      echo -e "$flutterSwitchText"
      cd "$flutterDir"
      sudo mv "flutter" "$oldName"
      sudo mv "$newName" "flutter"
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
  echo "--version : current fsm version"
  echo "--update : update fsm"
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

# @desc: update fsm
# @usage :  fsm --update
fsmUpdate() {
  echo -e "$flutterSwitchText"
  rm -rf ~/.fsm
  git clone https://github.com/sjdpk/fsm.git ~/.fsm
  echo "update shell eg: [ source ~/.zshrc, source ~/.bashrc, ...]" 
}