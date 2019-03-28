|develop|master|
|:-----:|:----:|
|[![CircleCI](https://circleci.com/gh/interchainio/docker/tree/develop.svg?style=svg&circle-token=eb616dd897ad66e522e230ddd88142695068c9c3)](https://circleci.com/gh/interchainio/docker/tree/develop)|[![CircleCI](https://circleci.com/gh/interchainio/docker/tree/master.svg?style=svg&circle-token=eb616dd897ad66e522e230ddd88142695068c9c3)](https://circleci.com/gh/interchainio/docker/tree/master)|

[![DepShield Badge](https://depshield.sonatype.org/badges/interchainio/docker/depshield.svg)](https://depshield.github.io)

# Docker and AMI images

Prerequisites:
- Create a repository on DockerHub under the `interchainio` organization
- Add `interchainbot` write permissions to the DockerHub repository (`bots` team `Read + Write` permission under the Permissions tab)
- Create AWS credentials in the CircleCI context for AMI images (dev_imagepacker and prod_imagepacker)

Setup:
- Create a folder with the same name as the DockerHub repository (mandatory)
- Add a Dockerfile in the folder
- Add any additional files needed into the folder
- Push the changes to GitHub master

CircleCI will deploy the built image to the `interchainio/<folder>` repository.

