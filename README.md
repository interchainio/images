|master|
|:----:|
|[![CircleCI](https://circleci.com/gh/interchainio/images/tree/master.svg?style=svg&circle-token=eb616dd897ad66e522e230ddd88142695068c9c3)](https://circleci.com/gh/interchainio/images/tree/master)|

# Docker and AMI images

This repository holds the Docker and AMI images used by the [Interchain Foundation](https://interchain.io). Most of the Docker images are used for CircleCI build and deploy projects but you might find something that is useful for you.


### Prerequisites for adding new Docker image:
- Create a repository on DockerHub under the `interchainio` organization
- Add `interchainbot` write permissions to the DockerHub repository (`bots` team `Read + Write` permission under the Permissions tab)
- Create AWS credentials in the CircleCI context for AMI images (dev_imagepacker and prod_imagepacker)

### Setup in GitHub:
- Create a folder with the same name as the DockerHub repository (mandatory)
- Add a Dockerfile in the folder
- Add any additional files needed into the folder
- Push the changes to GitHub master

CircleCI will deploy the built image to the `interchainio/<folder>` repository.

