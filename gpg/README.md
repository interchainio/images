# Interchain.io CircleCI images - GPG

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## GPG
|Main components|
|-|
|alpine 3.9|
|make|
|gpg|
|pinentry-tty *modified for automatic signing*|
|stoml|
|gpg-import *script*|
|gpg-cache-passphrase *script*|

The `gpg` image is used in CircleCI to automatically sign files using GPG. It contains the `gpg` command and additional scripts for automated signatures.

The `gpg-import` script imports a GPG key into the key store, automatically. The input parameter has to be the filename containing the GPG key, while the `GPG_PASSPHRASE` environment variable should contain the passphrase to open the GPG key file. The `GPG_PUBLIC_LONGKEY` environment variable has to contain the last 16 digits of the public key.
The key will be ultimately trusted in the key store.
The `GPG_PASSPHRASE` environment is optional. If it is not set, the script will assume that the input parameter is a public key.

The `gpg-cache-passphrase` script forces `gpg-agent` to start and cache the GPG key passphrase. The passphrase has to be in the `GPG_PASSPHRASE` environment variable. Subsequent gpg signing requests will not prompt for the passphrase.

Note: The script forces `gpg-agent` to start by trying to sign the `gpg.conf` file in the default GPG config folder.

|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/gpg)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|
|[SToml](https://github.com/freshautomations/stoml)|
|[Pinentry source](ftp://ftp.gnupg.org/gcrypt/pinentry/)|

