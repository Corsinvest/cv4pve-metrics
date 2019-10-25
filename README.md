# cv4pve-metrics

[![License](https://img.shields.io/github/license/Corsinvest/cv4pve-metrics.svg)](LICENSE.md) [![AppVeyor branch](https://img.shields.io/appveyor/ci/franklupo/cv4pve-metrics/master.svg)](https://ci.appveyor.com/project/franklupo/cv4pve-metrics)

This solutions consists of more parts:

* Docker with Grafana and InfluxDB [![Docker Pulls](https://img.shields.io/docker/pulls/corsinvest/cv4pve-metrics.svg)](https://hub.docker.com/r/corsinvest/cv4pve-metrics)
* Hook Script for send metrics to InfluxDB
* Software collect extra metric

```text
    ______                _                      __
   / ____/___  __________(_)___ _   _____  _____/ /_
  / /   / __ \/ ___/ ___/ / __ \ | / / _ \/ ___/ __/
 / /___/ /_/ / /  (__  ) / / / / |/ /  __(__  ) /_
 \____/\____/_/  /____/_/_/ /_/|___/\___/____/\__/

Metrics for Proxmox VE                         (Made in Italy) 1.0.0

Usage: cv4pve-metrics [options]

Options:
  -?|-h|--help    Show help information
  --host          The host name host[:port]
  --username      User name <username>@<realm>
  --password      The password. Specify 'file:path_file' to store password in file.
  --version       Show version information
  --influxdb-url  InfluxDB url es. http://my-server:8086
  --influxdb-db   InfluxDB db es. proxmox
```

## Copyright and License

Copyright: Corsinvest Srl
For licensing details please visit [LICENSE.md](LICENSE.md)

## Commercial Support

This software is part of a suite of tools called cv4pve-tools. If you want commercial support, visit the [site](https://www.corsinvest.it/cv4pve-tools)

## Introduction

Metrics for Proxmox VE.

this software aims to collect other metrics of Proxmox VE. The metrics are:

* Tasks

## Main features

* Completely written in C#
* Use native api REST Proxmox VE (library C#)
* Independent os (Windows, Linux, Macosx)
* Installation unzip file extract binary
* Not require installation in Proxmox VE
* Execute out side Proxmox VE

## Configuration and use

E.g. install on linux 64

Download last package e.g. Debian cv4pve-metrics-linux-x64.zip, on your os and install:

```sh
root@debian:~# unzip cv4pve-metrics-linux-x64.zip
```

This tool need basically no configuration.

```sh
root@debian:~# cv4pve-metrics --host=192.168.0.100 --username=root@pam --password=fagiano --influxdb-url "http://my-server:8086" --influxdb-db proxmox
```
