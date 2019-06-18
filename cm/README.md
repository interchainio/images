# Interchain.io CircleCI images - CM (configuration management)

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## CM (Config Management)
|Main components|
|-|
|alpine 3.9|
|ansible|
|awscli|
|aws-access *script*|
|get-known-hosts *script*|

The `cm` image is used in CircleCI to deploy configuration management for EC2 servers in AWS. It contains the `aws` command-line interface and the Ansible toolset. It also has `python3` installed with `pip3` for additional package management.

The `aws-access` script allows executions to get access to additional temporary AWS credentials using AWS STS. The documentation for the script is pending but the source code is fairly easy to read.

The `get-known-hosts` script allows executions to get a pre-populated `known_hosts` file from a DynamoDB database. This is especially useful for Ansible executions. The script populating the DynamoDB database from EC2 is not public yet but it is planned to make it public.


|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/cm)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|

