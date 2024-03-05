# Obsync

Your favorite Obsidian git synchronisation tool!

**Which commands works**

| Operating System | Setup | Init | Sync | Auto-Sync | Tool-Update |
|------------------|-------|------|------|-----------|--------|
| Linux            | :x: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| MacOS            | :x: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| Windows          | :x: | :x: | :x: | :x: | :x: |
| Android          | :x: | :x: | :x: | :x: | :x: |
| iOS / ipadOS     | :x: | :question: | :question: | :question: | :x: |

*:x: not implemented | :question: functionality untested | :white_check_mark: implemented and tested*

## Requirements

* Shell
  * Linux / MacOS: your favorite shell (bash/sh/zsh)
  * Windows: Powershell
  * Android: Android Bash Terminal like [Termux](https://play.google.com/store/apps/details?id=com.termux)
  * iOS / ipadOS: [iSH](https://apps.apple.com/de/app/ish-shell/id1436902243)
* Git
  * Linux / MacOS / iOS / ipadOS / Android: Git
  * Windows: Git-for-windows

## Setup

* [Linux](./docs/linux.md#Setup)
* [MacOS](./docs/macos.md#Setup)
* [Windows](./docs/windows.md#Setup)
* [Android](./docs/android.md#Setup)
* [iOS / ipadOS](./docs/ios.md#Setup)

## Usage

* [Linux](./docs/linux.md#Usage)
* [MacOS](./docs/macos.md#Usage)
* [Windows](./docs/windows.md#Usage)
* [Android](./docs/android.md#Usage)
* [iOS / ipadOS](./docs/ios.md#Usage)

```shell
Usage: obsync [OPTIONS] COMMAND [COMMAND OPTIONS]

v1.0.0

COMMANDS
  init                  Initialize an obsidian repository.
    -n | --new            (optional) Init a new repository instead of an existing one.
    --path PATH           (required) Path to Obsidian vault folder.
    --repo URL            (required) Git repository URL.
    --token TOKEN         (required) Git personal access token.
  sync                  Synchronize an obsidian repository.
    --path PATH           (required) Path to Obsidian vault folder.
  version               Display obsync version.

OPTIONS
  -h | --help           Display this help.
  -s | --silent         Activate silent mode.
  -v | --verbose        Activate verbose mode.
```

## Troubleshooting

Here, you find general troubleshooting topics. For platform-specific problems, check out the related doc:
* [Linux](./docs/linux.md#Troubleshooting)
* [MacOS](./docs/macos.md#Troubleshooting)
* [Windows](./docs/windows.md#Troubleshooting)
* [Android](./docs/android.md#Troubleshooting)
* [iOS / ipadOS](./docs/ios.md#Troubleshooting)

