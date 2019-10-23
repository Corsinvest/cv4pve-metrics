# cv4pve-metrics

[![Docker Pulls](https://img.shields.io/docker/pulls/corsinvest/cv4pve-metrics.svg)](https://hub.docker.com/r/corsinvest/cv4pve-metrics) [![license](https://img.shields.io/github/license/corsinvest/cv4pve-metrics.svg)](https://www.github.com/corsinvest/cv4pve-metrics/LICENSE.md)

![Grafana][grafana-version] ![Influx][influx-version] ![Chronograf][chronograf-version]

[grafana-version]: https://img.shields.io/badge/Grafana-6.4.1-brightgreen
[influx-version]: https://img.shields.io/badge/Influx-1.7.7-brightgreen
[chronograf-version]: https://img.shields.io/badge/Chronograf-1.7.12-brightgreen

[Github cv4pve-metrics Project](https://www.github.com/corsinvest/cv4pve-metrics)

## Copyright and License

Copyright: Corsinvest Srl
For licensing details please visit [LICENSE.md](https://www.github.com/corsinvest/cv4pve-metrics/LICENSE.md)

## Commercial Support

This software is part of a suite of tools called cv4pve-tools. If you want commercial support, visit the [site](https://www.corsinvest.it/cv4pve-tools)

## Introduction

Docker image with Grafana and InfluxDB for metrics Proxmox VE.

## Quick Start

To start the container with persistence you can use the following:

```sh
docker run -d \
  --name cv4pve-metrics \
  -p 3003:3003 \
  -p 3004:8888 \
  -p 8086:8086 \
  -p 8089:8089/udp \
  -v /path/for/influxdb:/var/lib/influxdb \
  -v /path/for/grafana:/var/lib/grafana \
  corsinvest/cv4pve-metrics:latest
```

To stop the container launch:

```sh
docker stop cv4pve-metrics
```

To start the container again launch:

```sh
docker start cv4pve-metrics
```

## Mapped Ports

```text
Host  Container   Service
3003  3003        grafana
3004  8888        chronograf
8086  8086        influxdb
8089  8089/udp    influxdb
```

## SSH

```sh
docker exec -it <CONTAINER_ID> bash
```

## Grafana

Open <http://localhost:3003>

```text
Username: root
Password: root
```

## InfluxDB

### Web Interface (Chronograf)

Open <http://localhost:3004>

```text
Username: root
Password: root
Port: 8086
```

### InfluxDB Shell (CLI)

1. Establish a ssh connection with the container
2. Launch `influx` to open InfluxDB Shell (CLI)

## Proxmox VE configuration metrics

For configuration see [External Metric Server](https://pve.proxmox.com/wiki/External_Metric_Server)

Login in Proxmox VE and edit server definitions on your pve node by creating the file “/etc/pve/status.cfg”.

```sh
nano /etc/pve/status.cfg
```

Add the following

```sh
influxdb:
  server your-docker-ip-address
  port 8089
```

Restart service pvestatd

```sh
pvestatd restart
```
