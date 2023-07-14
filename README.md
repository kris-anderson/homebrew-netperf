# Netperf with the flag `--enable-demo` set for Homebrew users on macOS

## Why this exists

When you install the default homebrew version of `netperf`, the flag `--enable-demo` is not set by default.

If you run a tool like [Flent](https://github.com/tohojo/flent) that requires this flag to be set, it will end up throwing an error if you use the default Homebrew package.

The maintainer of Flent created a [PR for Homebrew](https://github.com/Homebrew/homebrew-core/pull/25503) to address this for macOS users, but the Homebrew dev team felt this should be handled upstream. Hewlett Packard, the maintainer of Netperf, has not yet made a release that contains the needed fix. You can [see the GitHub issue here](https://github.com/HewlettPackard/netperf/issues/35).

## What this does

This is a slightly modifed formula from the original `netperf` homebrew formula.

1. Adds the flag `--enable-demo` during compiling

1. I downloaded [the latest source code](https://github.com/HewlettPackard/netperf) (as of 07/14/2023) since there have been [~40 commits to the master branch](https://github.com/HewlettPackard/netperf/issues/75) of HP's repo compared to the gzip file they created back in 2015, and I uploaded this gzip file to an S3 bucket of mine. If you trust me less then you trust HP, you can install this homebrew formula using HP's git repo as the source by adding the `--HEAD` option to the `brew install kris-anderson/netperf/netperf-enable-demo` command.

1. There's an [open PR on HP's git repo](https://github.com/HewlettPackard/netperf/pull/67) that allows this to build succesfully on macOS that hasn't been merged yet (as of 07/14/2023), and this homebrew formula incorporates that PR.

1. This homebrew formula also runs `./autogen.sh` during the build process, which is required to get this to build on macOS with the latest source code.

## How to install this homebrew formula

### Method 1 - Recommended

`brew install kris-anderson/netperf/netperf-enable-demo`

### Method 2

> **Note:** This uses HP's Netperf git repo instead of my gzip file which I created on 07/14/2023.
>
> If you use this, you'll build from the source and from the master branch.

`brew install kris-anderson/netperf/netperf-enable-demo --HEAD`

### Method 3

`brew tap kris-anderson/netperf`

then

`brew install netperf-enable-demo`

### Method 4

> **Note:** If you use this, you will not receive updates when this formula is updated in the future

`brew install https://raw.githubusercontent.com/kris-anderson/homebrew-netperf/master/Formula/netperf-enable-demo.rb`
