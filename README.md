# fsm

Flutter SDK Manager : A Command-Line Interface (CLI) tool designed to simplify the management of different versions of the Flutter Software Development Kit (SDK) on your development environment. It provides optimization and convenience for developers who work with Flutter by allowing them to switch between different versions of the Flutter SDK seamlessly.

**Features:**

- Configure and use Flutter SDK version
- Ability to Easy Switch between different Flutter SDK Versions 


> ### **NOTE**
Flutter SDK folder must follow this pattern
`flutter-<version>`
eg:  ```flutter-3.10.4```

### FSM Installation

To install FSM, use the following commands based on your shell environment:

## Installation Instructions

| **Shell**     | **Command**                                                                                                               |
| ------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **Bash**       | `git clone https://github.com/sjdpk/fsm.git ~/.fsm && echo 'alias fsm=~/.fsm/fsm.sh' >> ~/.bashrc && source ~/.bashrc`        |
| **Zsh**        | `git clone https://github.com/sjdpk/fsm.git ~/.fsm && echo 'alias fsm=~/.fsm/fsm.sh' >> ~/.zshrc && source ~/.zshrc`          |
| **Fish**       | ```fish git clone https://github.com/sjdpk/fsm.git ~/.fsm echo 'alias fsm=~/.fsm/fsm.sh' >> ~/.config/fish/config.fish source ~/.config/fish/config.fish``` |
| **PowerShell** | ```powershell git clone https://github.com/sjdpk/fsm.git $HOME/.fsm Add-Content $PROFILE.CurrentUserAllHosts "`nfunction fsm { $HOME/.fsm/fsm.ps1 }"``` |
| **Others**     | 1. Clone the repository: `git clone https://github.com/sjdpk/fsm.git ~/.fsm`<br> 2. Export path in your shell configuration file. Example:<br> - Bash/Zsh: `alias fsm=~/.fsm/fsm.sh`<br> - Fish: `alias fsm=~/.fsm/fsm.sh`<br> - PowerShell: `function fsm { $HOME/.fsm/fsm.ps1 }`<br> 3. Restart your shell or run appropriate commands to apply changes. |

Ensure to restart your shell or run the appropriate commands to apply the changes.


## Usage
Usage : `fsm [OPTIONS]`


| Description                 | Command                  |
| --------------------------- | ------------------------ |
| Help                        | `fsm help`               |
| Display Flutter Version     | `fsm -v`                 |
| Display Flutter Version (alternative) | `flutter --version` |
| Display FSM Info             | `fsm info`               |
| Update FSM Version           | `fsm update`             |
| List all Flutter SDK         | `fsm ls` or `fsm --list` |
| Switch Flutter Version       | `fsm use <version>`      |
| Switch Flutter Version Example | `fsm use "3.10.4"`       |
| Install Flutter Version     | `fsm install <version>` |
| Install Flutter Version Example | `fsm install "3.10.5"` |
| Create Flutter Project | `fsm create <appName>` |
| Create Flutter Project Example | `fsm create awesomeProject` |
| Create Feature Folder | `fsm feature <featureName>` |
| Create Flutter Project Example | `fsm feature authentication` |


Switch to a different version of Flutter, use the `fsm` command followed by the desired version:

```
fsm use <version>
eg: fsm use 3.10.4
```

**FAQ:**

1. **fsm not found**
   
	Add this line at the end of your shell (eg: bashrc/zshrc) file.

	`alias fsm=~/.fsm/fsm.sh`

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
