# Interchain.io CircleCI images - Terragrunt

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## Terragrunt
|Main components|
|-|
|terraform|
|terragrunt|
|stoml|
|stemplate|
|terraform-signalfx *provider*|

The `terragrunt` image is used in CircleCI to deploy projects that have a complex Terraform setup. It contains the `terraform` and `terragrunt` command-line utilities together with SToml for easy INI-file parsing in Bash and STemplate for templated file copy.

|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/terragrunt)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|
|[Terragrunt](https://github.com/gruntwork-io/terragrunt)|
|[Terraform](https://terraform.io)|
|[SToml](https://github.com/freshautomations/stoml)|
|[STemplate](https://github.com/freshautomations/stemplate/)|

