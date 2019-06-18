# Interchain.io CircleCI images - Packer

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## Packer
|Main components|
|-|
|alpine 3.9|
|packer|
|ansible|
|awscli|
|git|
|aws_config *config file*|

The `packer` image is used in CircleCI to create AWS AMI images using HashiCorp Packer. It contains `packer`, the `aws` command-line interface and the Ansible toolset. It also has `python3` installed with `pip3` for additional package management and `git`.

The `aws_config` file is copied as `$HOME/.aws/config` for role-based AWS credentials management. This is an obsolete method and newer images already use the `aws-access` script. This image will be updated with `aws-access` at the next update.

|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/packer)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|
|[Packer](https://packer.io/)|

