# Docker images

[![CircleCI](https://circleci.com/gh/interchainio/docker/tree/master.svg?style=svg&circle-token=eb616dd897ad66e522e230ddd88142695068c9c3)](https://circleci.com/gh/interchainio/docker/tree/master)

[![DepShield Badge](https://depshield.sonatype.org/badges/interchainio/docker/depshield.svg)](https://depshield.github.io)

Prerequisites:
- Create a repository on DockerHub under the interchainio organization
- Add interchainbot write permissions to the DockerHub repository

Setup:
- Create a folder with the same name as the DockerHub repository (mandatory)
- Add a Dockerfile in the folder
- Add any additional files needed into the folder
- Push the changes to GitHub master

CircleCI will deploy the built image to the interchainio/<folder> repository,

