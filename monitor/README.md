# Monitoring Server

This server contains a Grafana and InfluxDB instance to receive data from
external Telegraf instances.

* Interchain Tendermint Monitor v0.1.0-1560260297 - `ami-0fae0bb71abfebc19`

```bash
INFLUXDB_DATABASE=tendermint
INFLUXDB_USERNAME=tendermint
INFLUXDB_PASSWORD=somepassword
```