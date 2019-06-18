# Interchain.io CircleCI images - AWS

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## AWS
|Main components|
|-|
|alpine 3.9|
|ansible|
|awscli|
|aws-access *script*|

The `aws` image is used in CircleCI to deploy projects that have a complex Amazon AWS setup. It contains the `aws` command-line interface and the Ansible toolset. It also has `python3` installed with `pip3` for additional packages.

The `aws-access` script allows deployments to get access to additional temporary AWS credentials using AWS STS. The documentation for the script is pending but the source code is fairly easy to read.

|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/aws)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|

