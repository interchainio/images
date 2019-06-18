# Interchain.io CircleCI images - twitterbot

Interchain.io Docker images are created and maintained by the [Interchain Foundation](https://interchain.io). The images are used in CircleCI to create a more streamlined build-and-deploy experience for the Foundation projects.
The images are not versioned but automatically created from each push to `master` in the [GitHub source code](https://github.com/interchainio/images).
Build logs can be checked at [CircleCI](https://circleci.com/gh/interchainio/images/tree/master).

## Twitter Bot
|Main components|
|-|
|alpine 3.9|
|stemplate|
|twurl|
|stake_dist|

The `twitterbot` image is used in CircleCI to execute scheduled jobs that run the `stake_dist` application and tweet about the stake distribution for the Cosmos Hub.

|Links|
|-|
|[Source code](https://github.com/interchainio/images/tree/master/twitterbot)|
|[Build status](https://circleci.com/gh/interchainio/images/tree/master)|
|[Stake_Dist](https://github.com/interchainio/delegation)|
|[STemplate](https://github.com/freshautomations/stemplate/)|
|[Twurl](https://github.com/twitter/twurl)|

