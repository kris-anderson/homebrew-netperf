# Netperf with the flag `--enable-demo` set for Homebrew users on macOS

## Why this exists

When you install the default homebrew version of `netperf`, the flag `--enable-demo` is not set by default.

If you run a tool like [Flent](https://github.com/tohojo/flent) that requires this flag to be set, it will end up throwing an error if you use the default Homebrew package.

The maintainer of Flent create a [PR for Homebrew](https://github.com/Homebrew/homebrew-core/pull/25503) to address this for macOS users, but the Homebrew dev team felt this should be handled upstream. Hewlett Packard, the maintainer of Netperf, has not yet made a release that contains the needed fix. You can [see the Github issue here](https://github.com/HewlettPackard/netperf/issues/35).

## What this does

This is a slightly modifed formulae that does two things differently than the original.

1. Removes `inline` from two different places in the `src/netlib.c` file.

2. Adds the flag `--enable-demo` during compiling

## How to install this formulae

### Method 1

`brew install kris-anderson/netperf/netperf-enable-demo`

### Method 2

`brew tap kris-anderson/netperf`

then

`brew install netperf-enable-demo`

### Method 3 (will not receive updates)

`brew install https://raw.githubusercontent.com/kris-anderson/homebrew-netperf/master/Formula/netperf-enable-demo.rb`
