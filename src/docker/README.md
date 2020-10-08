# cv4pve-metrics

[![license](https://img.shields.io/github/license/corsinvest/cv4pve-metrics.svg)](https://github.com/Corsinvest/cv4pve-metrics/blob/master/LICENSE.md)

## Copyright and License

Copyright: Corsinvest Srl
For licensing details please visit [LICENSE.md](https://github.com/Corsinvest/cv4pve-metrics/blob/master/LICENSE.md)

## Commercial Support

This software is part of a suite of tools called cv4pve-tools. If you want commercial support, visit the [site](https://www.cv4pve-tools.com)

## Introduction

Docker compose with InfluxDb, Telegraf, Kapacitor, Chronograf, Grafana for metrics Proxmox VE.

## Quick Start

Download docker folder.

Change file ".env" for your configuration.

Change InfluxDB configuration [file](./influxdb/config/influxdb.conf) set database where Proxmox VE store metrics.

```ini
[[udp]]
  database = "db_proxmox"
```

Remember the directory **${DATA_STORE}/grafana** must have the permission user and group 472:472

```sh
# Replace <DATA_STORE> with value
sudo mkdir -p <DATA_STORE>/grafana/data/
sudo chown 472:472 -R <DATA_STORE>/grafana/data/
```

To start the container with persistence you can use the following:

```sh
docker-compose up -d
```

To stop the container launch:

```sh
docker-compose down
```

metrics-util simplify management docker.

```txt
metrics-util commands:
  up       -> spin up the sandbox environment
  down     -> tear down the sandbox environment
  restart  -> restart the sandbox
  influxdb -> attach to the influx cli

  enter (influxdb||kapacitor||chronograf||telegraf||grafana) -> enter the specified container
  logs  (influxdb||kapacitor||chronograf||telegraf||grafana) -> stream logs for the specified container
```

## Mapped Ports

```text
Host  Container   Service
3000  3000        grafana
8888  8888        chronograf
9092  9092        kapacitor
8086  8086        influxdb
8089  8089/udp    influxdb
```

## SSH

```sh
docker exec -it <CONTAINER_ID> bash
```

or

```sh
metrics-util enter (influxdb||kapacitor||chronograf||telegraf||grafana)
```

## Grafana

Open http://localhost:3000

```sh
# first login
Username: admin
Password: admin
```

### Web Interface chronograf

Open http://localhost:8888

### InfluxDB Shell (CLI)

metrics-utils influxdb

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

## Configure Grafana

Create **DataSource** type InfluxDb using database ```db_telegraf_proxmox``` and ```db_proxmox```.

Import dashboard from repository:

* [Proxmox VE Home](https://grafana.com/grafana/dashboards/11416)
* [Proxmox VE Alert](https://grafana.com/grafana/dashboards/11418)
* [Proxmox VE cv4pve-autosnap](https://grafana.com/grafana/dashboards/13099)
* [Proxmox VE Backup VZDump](https://grafana.com/grafana/dashboards/12907)
* [Proxmox VE KVM](https://grafana.com/grafana/dashboards/12908)
* [Proxmox VE Network](https://grafana.com/grafana/dashboards/12909)
* [Proxmox VE Node](https://grafana.com/grafana/dashboards/12910)
* [Proxmox VE Node Detailed](https://grafana.com/grafana/dashboards/12911)
* [Proxmox VE Node IPMI](https://grafana.com/grafana/dashboards/12912)
* [Proxmox VE Sensors](https://grafana.com/grafana/dashboards/12913)
* [Proxmox VE Storage](https://grafana.com/grafana/dashboards/12914)
* [Proxmox VE Syslog](https://grafana.com/grafana/dashboards/12915)

## [Telegraf inside node Proxmox VE](../telegraf-pve-node/README.md)

## [Scripts hook](../scripts-hook/README.md)
