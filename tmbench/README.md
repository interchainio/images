# Tendermint Benchmarking Image

Facilitating simple load testing of a Tendermint network, this AMI provides a
machine from which to execute
[`tm-bench`](https://github.com/tendermint/tendermint/tree/master/tools/tm-bench).

## AMIs
Here is a list of the current AMIs available, built from this image:

* Interchain Tendermint tm-bench v0.31.7-1560787065: `ami-0760f51e3146afbf9et`
  (`us-east-1`)

All other information in this README only pertains to the latest version of this
image, unless otherwise specified.

## Usage
When launching an instance based on this AMI, you will need to configure the
following user data (which will be `source`d to convert each parameter to an
environment variable during startup):

```bash
INFLUXDB_URL="http://influxdb-host:8086"
INFLUXDB_DATABASE=tendermint
INFLUXDB_USERNAME=tendermint
INFLUXDB_PASSWORD=somepassword

# Each of these parameters is a semi-colon-separated array of different
# executions of tm-bench that will be executed sequentially. Make sure there is
# no trailing semi-colon, as this will break the script.
TMBENCH_ENDPOINTS="tendermint-host:26657;tendermint-host:26657;tendermint-host:26657"
TMBENCH_TIME=5;5;5
TMBENCH_BROADCAST_TX_METHOD=async;async;async
TMBENCH_CONNECTIONS=1;1;1
TMBENCH_RATE=1000;2000;3000
TMBENCH_SIZE=250;250;250
# The number of seconds to wait between each execution of tm-bench.
TMBENCH_FINISH_WAIT=0
```

See [`tm-bench`](https://github.com/tendermint/tendermint/tree/master/tools/tm-bench)
for details as to what the configuration parameters mean.

## Building
To build this image yourself, you will first need to build a Linux version of
`tm-bench`. First clone the Tendermint source code:

```bash
cd ${GOPATH}/src/github.com/tendermint/tendermint/tools/tm-bench
# Build the Linux version of the executable
GOOS=linux GOARCH=amd64 make build
```

Then, simply clone the repo and build it using Packer (after configuring your
local AWS credentials, of course), making sure to include the path to the built
`tm-bench` executable:

```bash
TMBENCH_BIN=${GOPATH}/src/github.com/tendermint/tendermint/tools/tm-bench/tm-bench \
    packer build packer.json
```

Note that `TMBENCH_BIN` must be an **absolute** path.
