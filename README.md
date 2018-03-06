# homebrew-versions
Containts Magical Versioned homebrew formulae for bazel (and other tools).

Allows using (and switching between) specific versions of bazel.

# Usage

Tab this repository:
```bash
brew tap improbable-io/homebrew-versions
```


Fetch latest formulae:
```bash
brew update
```

Versioned bazel instances can be installed like so:
```bash
brew install bazel@<desired version number, e.g. 0.7.0>
```
*Note*: Bottles are not available for old versions, so the installation will compile bazel from source.

The installed versions can be activated and deactivated like so:
```bash
brew link --force bazel@<version> # activate
brew unlink bazel@<version> # deactivate
```
If a symlink already exists in `/usr/local/bin/bazel` you will be prompted to delete it. This may occur if you installed bazel separately from homebrew.
The `homebrew-core` version of bazel can be deactivated using `brew unlink bazel` and re-activated using `brew link bazel`.
