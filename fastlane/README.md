fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android test

```sh
[bundle exec] fastlane android test
```

Runs all the tests

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Deploy a new version to the Google Play

### android test_teams

```sh
[bundle exec] fastlane android test_teams
```



### android testcase

```sh
[bundle exec] fastlane android testcase
```

Deploy a new version to the App Center

### android publish_appcenter

```sh
[bundle exec] fastlane android publish_appcenter
```

Deploy a new version to the App Center

----


## iOS

### ios publish_appcenter

```sh
[bundle exec] fastlane ios publish_appcenter
```

Deploy a new version to the App Center

### ios release

```sh
[bundle exec] fastlane ios release
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
