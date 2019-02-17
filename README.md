# Tennis

An implementation for [Tennis Kata](https://gist.github.com/MatteoPierro/22e09a2b5d9e41fdd8c226d318fc0984).

- [Environment](#environment)
- [Build](#build)
- [Run](#run) 
- [Tests](#tests)
- [Architecture](#architecture)

## Environment

- iOS 12.1
- Xcode 10.1
- Swift 4.2

## Build

This project has no external dependencies. It can build for any iOS 12 Simulator without additional setup.

## Run

### Simulator

- Open `Tennis.xcodeproj` using Xcode 10.1.
- Select a simulator. Example: `iPhone XS`.
- Run `⌘ R`.

### Device

For running on a device you first need to specify a development team and have proper certificate and provisioning profiles installed.

## Tests

### TennisTests

Unit tests covering the business and presentation logic.

## Architecture

Layered architecture based on [SOLID Principles](https://en.wikipedia.org/wiki/SOLID).

### GameEngine

Component defining and implementing the behavior of a simplified tennis game.

### Scoreboard GUI

Displays on screen the score of a tennis game.
