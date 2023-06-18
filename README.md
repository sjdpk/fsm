## fsm : Flutter SDK (Version) Management Tool
[![Build sjdpk](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://github.com/sjdpk/fsm)

## Description

`fsm` is a bash script that simplifies switching between different versions of Flutter on your development environment.

## **NOTE**
Flutter SDK folder must follow this pattern
`flutter-<version>`
eg:  ```flutter-3.10.4```

### To Know your shell 
    echo $SHELL
## Installation To `bash` shell

Clone the repository to your local machine and add the sourcing command:
   ```
   git clone https://github.com/sjdpk/fsm.git ~/.fsm && echo 'source ~/.fsm/fsm.sh' >> ~/.bashrc && source ~/.bashrc 
```

## Installation To `zsh` shell

Clone the repository to your local machine and add the sourcing command:
   ```
   git clone https://github.com/sjdpk/fsm.git ~/.fsm && echo 'source ~/.fsm/fsm.sh' >> ~/.zshrc && source ~/.zshrc
  ```

## Usage

For Help

```
fsm --help
```
Current Flutter Version

```
fsm --now
```

Current fsm Version

```
fsm --version
```

List all Flutter SDK versions

```
fsm --list
```

Switch to a different version of Flutter, use the `fsm` command followed by the desired version:

```
fsm -switch <version>
eg: fsm -switch "3.10.4"
```

###FAQ 

1. > fsm not found
Add this line at the end of your shell (eg: bashrc/zshrc) file
			 ...
			...
			source ~/.fsm/fsm.sh

## Contributing

I welcome and appreciate contributions from the community! Whether you want to report a bug, request a new feature, or submit a pull request, please feel free to contribute to this project and help make it even better.
 


### Bug Reports and Feature Requests

If you encounter a bug or have a feature request, please open an issue on the [Issue Tracker](https://github.com/sjdpk/fsm/issues). Be sure to provide detailed information about the problem you encountered or the feature you'd like to see.
