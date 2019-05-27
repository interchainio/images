# Game of Tendermint - Nightking

The Game of Tendermint (GoT) is an infrastructure framework for research projects.
The infrastructure is based on Amazon's AWS EC2 images and instances.

## Nightking
The Nightking image is the master server executing the research experiment.
Only one server has to be spawned and it will automatically create additional
servers and services for the experiment.

To build a nightking server, the experiment name and Grafana password has to be added to the
`user-data` section of the created instance. Paste the below lines and modify them accordingly.

```bash
EXPERIMENT="xp0"
PASSWORD="<grafana_password>"
```

Note: although these lines don't make a valid user-data script, the nightking will be able to understand it.

TBD: How to set up nightking on the AWS console.

## Whitewalker
The Whitewalker image is a load-testing server that the Nightking builds.
It runs the `tm-load-test` tool configured by the Nightking based on the requested experiment.

A group of Whitewalker servers is called the Army of Whitewalkers.

## Stark
The Stark image is a tendermint node server image. At launch it will
choose the configuration for the experiments and launch tendermint, searching for other nodes.

The Whitewalkers run their load tests on the Stark servers.

A group of Stark servers is called the Family of Starks, or simply Winterfell.
