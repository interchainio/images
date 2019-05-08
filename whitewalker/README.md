# Game of Tendermint - Whitewalker

The Game of Tendermint (GoT) is an infrastructure framework for research projects.
The infrastructure is based on Amazon's AWS EC2 images and instances.

(Todo: write a detailed description of how it works.)

## Nightking
The Nightking image is the master server executing the research experiment.
Only one server has to be spawned and it will automatically create additional
servers and services for the experiment.

## Whitewalker
The Whitewalker image is a load-testing server that the Nightking builds.
It runs the `tm-load-test` tool configured by the Nightking based on the requested experiment.

A group of Whitewalker servers is called the Army of Whitewalkers.

## Stark
The Stark image is a tendermint node server image. At launch it will
choose the configuration for the experiments and launch tendermint, searching for other nodes.

The Whitewalkers run their load tests on the Stark servers.

A group of Stark servers is called the Family of Starks, or simply Winterfell.
