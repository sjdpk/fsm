# fsm

Flutter SDK Manager : A Command-Line Interface (CLI) tool designed to simplify the management of different versions of the Flutter Software Development Kit (SDK) on your development environment. It provides optimization and convenience for developers who work with Flutter by allowing them to switch between different versions of the Flutter SDK seamlessly.

**Features:**

- Configure and use Flutter SDK version
- Ability to Easy Switch between different Flutter SDK Versions 


> ### **NOTE**
Flutter SDK folder must follow this pattern
`flutter-<version>`
eg:  ```flutter-3.10.4```

### Basic Installation

FSM is installed by running the following commands in your terminal, depending on your shell profile. 
To Know your shell Profile run this command : `echo $SHELL`.
| Shell    | Command                                                                                           |
| :-------- | :------------------------------------------------------------------------------------------------ |
| **bash**  | `git clone https://github.com/sjdpk/fsm.git ~/.fsm && echo 'source ~/.fsm/fsm.sh' >> ~/.bashrc && source ~/.bashrc` |
| **zsh**  | `git clone https://github.com/sjdpk/fsm.git ~/.fsm && echo 'source ~/.fsm/fsm.sh' >> ~/.zshrc && source ~/.zshrc`   |


## Usage
| Description  | Command  |
| ------------ | ------------ |
| Help  | `fsm --help`  |
| Flutter Version  | `fsm --now`  |
| fsm Version  | `fsm --version`  |
|  fsm Version  | `fsm --update`  |
| List all Flutter SDK  | `fsm --list`  |
| Switch Flutter Version  | `fsm -switch <version>` |
| Switch Flutter Version Eg  | ` fsm -switch "3.10.4" `  |



Switch to a different version of Flutter, use the `fsm` command followed by the desired version:

```
fsm -switch <version>
eg: fsm -switch "3.10.4"
```

**FAQ:**

1. **fsm not found**
   
	Add this line at the end of your shell (eg: bashrc/zshrc) file.

	`source ~/.fsm/fsm.sh`

## Contributors ✨

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="25%"><a href="https://github.com/sjdpk"><img src="https://avatars.githubusercontent.com/sjdpk?v=4?s=50" width="50px;" alt="Deepak Sapkota"/><br /><sub><b>Deepak Sapkota</b></sub></a><br /></td>
      <td align="center" valign="top" width="25%"><a href="https://github.com/rajan-poudel"><img src="https://avatars.githubusercontent.com/rajan-poudel?v=4?s=50" width="50px;" alt="Rajan Paudel"/><br /><sub><b>Rajan Paudel</b></sub></a><br /></td>
    </tr>
  </tbody>
</table>

## Contributing

I welcome and appreciate contributions from the community! Whether you want to report a bug, request a new feature, or submit a pull request, please feel free to contribute to this project and help make it even better.
 


### Bug Reports and Feature Requests

If you encounter a bug or have a feature request, please open an issue on the [Issue Tracker](https://github.com/sjdpk/fsm/issues). Be sure to provide detailed information about the problem you encountered or the feature you'd like to see.
