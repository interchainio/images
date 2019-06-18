# Interchain.io CircleCI images - Node

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## Node
|Main components|
|-|
|circleci/node|
|awscli|
|jq|
|python3|
|aws_config *config file*|

The `node` image is an extension to the CircleCI node image that contains the AWS CLI.

The `aws_config` file is copied to `$HOME/.aws/config` for a simple role-based AWS credentials management. This is an obsolete method and will be replaced by `aws-access`.

|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/node)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|

